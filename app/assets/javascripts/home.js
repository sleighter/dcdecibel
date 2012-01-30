var openItem;
var loadingHolder = '<img src="/assets/loading.gif" alt="loading" />';
function lastFmUrl(api_key){
  return "http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&format=json&api_key=" + last_fm_api_key + "&artist=" + api_key;
}
function templateDetails(template,detailsDiv,data){
  var details = $(template.tmpl(data));
  var bandImage = details.find("IMG");
  if(bandImage.length > 0){
  bandImage.load(function() {
    var hidden = $("#hidden-div");
    hidden.html(details[0]);
    var detailsContent = $("#details-content");
    detailsContent.hide();
    detailsDiv.prepend(detailsContent);
    $("#details-row").animate({
      'height': $(detailsDiv).height()
      },
      200,
      function(){
        detailsDiv.find("IMG").fadeOut(200);
        detailsContent.fadeIn(200);
      });
  });  
  }else{
    var hidden = $("#hidden-div");
    hidden.html(details[0]);
    var detailsContent = $("#details-content");
    detailsContent.hide();
    detailsDiv.prepend(detailsContent);
    detailsDiv.find("IMG").fadeOut(200);
    detailsContent.fadeIn(200);
  }
}

function closeDetails(){
    $('#details-div').slideUp(100);
    $('#details-row').slideUp(100);
    if (openItem != null){
      $(openItem).removeClass('selected');
      openItem = null;
    }
    $("#details-row").insertAfter("#holder-row")
}

$(document).ready(function(){
  $('#events-table').dataTable({
    bPaginate: false, 
    bFilter: false, 
    bInfo: false, 
    aaSorting: [[4,'asc']], 
    fnPreDrawCallback: function(oSettings){
      closeDetails();
    },
    "aoColumnDefs": [{ "iDataSort": 4, "aTargets": [ 2 ] }]
  }); 
  $('.band-link').live('click',function(){
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
  
/*  $('.venue-link').live('click',function(){
    var detailsRow = $('#details-row');
    var detailsDiv = $('#details-div');
    if ($(this)[0] == openItem)
    {
      detailsDiv.slideUp('fast');
      $(openItem).removeClass('selected');
      openItem = null;
      return;
    }
    if (openItem != null){
      $(openItem).removeClass('selected');
    }
    openItem = $(this)[0];
    $(openItem).addClass('selected');
    var thisRow = $(this).parent('tr');
    var itemId = $(this).attr('data-venueid');
    detailsDiv.slideUp('fast',function() {
      detailsRow.insertAfter(thisRow);
      detailsDiv.hide();
      detailsRow.insertAfter(thisRow);  
      detailsDiv.html(loadingHolder);
      detailsDiv.slideDown('fast');
      $.get("/venues/" + itemId.toString() + ".json", function(data){
          templateDetails($("#venue-details-row-template"),detailsDiv,data);
      });
    });
  });*/
});
