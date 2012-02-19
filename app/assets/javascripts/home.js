var openItem;
var loadingHolder = '<img class="loading-image" src="/assets/loading.gif" alt="loading" />';
function lastFmUrl(api_key){
  return "http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&format=json&api_key=" + last_fm_api_key + "&artist=" + api_key;
}
function templateDetails(template,detailsDiv,data){
  var details = $(template.tmpl(data));
  var bandImage = details.find(".band-image");
  if(bandImage.length > 0){
  bandImage.load(function() {
    var hidden = $("#hidden-div");
    hidden.html(details[0]);
    var detailsContent = $("#details-content");
    detailsContent.hide();
    detailsDiv.prepend(detailsContent);
    $("#details-row").animate({
      'height': $(detailsContent).height()
      },
      'fast',
      function(){
        detailsDiv.height($(detailsContent).height() + 15);
        detailsDiv.find(".loading-image").hide();
        detailsContent.fadeIn(200);
        $(".band-bio").lionbars();
      });
  });
  }else{
    var hidden = $("#hidden-div");
    hidden.html(details[0]);
    var detailsContent = $("#details-content");
    detailsContent.hide();
    detailsDiv.prepend(detailsContent);
    $("#details-row").animate({'height': $(detailsContent).height()},'fast',function(){
      detailsDiv.height($(detailsContent).height() + 20);
      detailsDiv.find("IMG").fadeOut(200);
      detailsContent.fadeIn(200);
      $(".band-bio").lionbars();
    });
  }
}
function removeDuplicateDates(){
  var currentDate;
  $("TD.event_datetime").each(function(){
    if($(this).html() == currentDate){
      $(this).addClass("hidden");
    }else{
      currentDate = $(this).html();
    }
  });
}
function showAllDates(){
  $("TD.event_datetime").removeClass("hidden");
}
function closeDetails(){
    $('#details-div').slideUp(100,function(){$(this).height(0);});
    $('#details-row').slideUp(100,function(){$(this).height(0);});
    $('.details-content').html('').height(0);
    if (openItem != null){
      $(openItem).removeClass('selected');
      openItem = null;
    }
    $("#details-row").insertAfter("#holder-row");
}
function openInfoPanel(){
  $('#info_panel').slideDown();
}
function closeInfoPanel(){
  $.cookie('close_info_panel','true')
  $('#info_panel').slideUp();
}

var FirstTableDraw = true;
$(document).ready(function(){

  $('#events-table').dataTable({
    bPaginate: false,
    bFilter: false,
    bInfo: false,
    aaSorting: [],
    fnPreDrawCallback: function(oSettings){
      closeDetails();
      if (!FirstTableDraw){
        showAllDates();
      }
      FirstTableDraw = false;
    },
    "aoColumnDefs": [
      { "iDataSort": 4, "aTargets": [ 0 ] },
      { "iDataSort": 5, "aTargets": [ 3 ] }
    ]
  });

  removeDuplicateDates();

  $('.band-link').on('click',function(){
    var detailsRow = $('#details-row');
    var detailsDiv = $('#details-div');
    if ($(this)[0] == openItem)
    {
      closeDetails();
      return;
    }
    else if (openItem != null){
      $(openItem).removeClass('selected');
    }
    openItem = $(this)[0];
    $(openItem).addClass('selected');
    var thisRow = $(this).parent('tr');
    var itemId = $(this).attr('data-bandid');
    detailsDiv.slideUp('fast',function() {
      detailsRow.slideUp('fast');
      detailsDiv.hide();
      detailsRow.insertAfter(thisRow);
      detailsDiv.html(loadingHolder);
      detailsDiv.slideDown('fast');
      detailsRow.slideDown('fast');
      $.get("/bands/" + itemId.toString() + ".json", function(data){
        if(data.last_fm_id){
          $.get(lastFmUrl(data.last_fm_id),
          function(data2){
              if(!data2.artist){
                data2 = JSON.parse(data2);
              }
              if (data2.artist){
                data.image_url = data2.artist.image[3]['#text'];
              }
              templateDetails($("#band-details-row-template"),detailsDiv,data);
          });
        }else{
          templateDetails($("#band-details-row-template"),detailsDiv,data);
        }
      });
    });
  });

  $('.venue-link').on('click',function(){
    var detailsRow = $('#details-row');
    var detailsDiv = $('#details-div');
    if ($(this)[0] == openItem)
    {
      closeDetails();
      return;
    }
    else if (openItem != null){
      $(openItem).removeClass('selected');
    }
    openItem = $(this)[0];
    $(openItem).addClass('selected');
    var thisRow = $(this).parent('tr');
    var itemId = $(this).attr('data-venueid');
    detailsDiv.slideUp('fast',function() {
      detailsRow.slideUp('fast');
      detailsDiv.hide();
      detailsRow.insertAfter(thisRow);
      detailsDiv.html(loadingHolder);
      detailsDiv.slideDown('fast');
      detailsRow.slideDown('fast');
      $.get("/venues/" + itemId.toString() + ".json", function(data){
        templateDetails($("#venue-details-row-template"),detailsDiv,data);
      });
    });
  });

  $('.ticket-link').on('click', function(){
    var detailsRow = $('#details-row');
    var detailsDiv = $('#details-div');
    if ($(this)[0] == openItem){
      closeDetails();
      return;
    }
    if (openItem != null){
      $(openItem).removeClass('selected');
    }
    openItem = $(this)[0];
    $(openItem).addClass('selected');
    var thisRow = $(this).parent('tr');
    var itemId = $(this).attr('data-eventid');
    detailsDiv.slideUp('fast',function(){
      detailsRow.slideUp('fast');
      detailsDiv.hide();
      detailsRow.insertAfter(thisRow);
      detailsDiv.html(loadingHolder);
      detailsDiv.slideDown('fast');
      detailsRow.slideDown('fast');
      $.get("/events/" + itemId.toString() + ".json", function(data){
        templateDetails($("#ticket-details-row-template"),detailsDiv,data);
      });
    });
  });

  $('.close_info_panel').on('click',function(){
    close_info_panel();
  });

  if(!$.cookie('close_info_panel')){
    openInfoPanel();
  }
});

