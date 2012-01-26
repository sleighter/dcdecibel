var openItem;
var loadingHolder = '<td colspan="4" class="grid_16 centered"><image src="/assets/loading.gif" alt="loading" /></td>';
function lastFmUrl(api_key){
  return "http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&format=json&api_key=" + last_fm_api_key + "&artist=" + api_key;
}
function templateDetails(template,detailsDiv,data){
  detailsDiv.hide();
  detailsDiv.html(template.tmpl(data));
  detailsDiv.slideDown('slow');  
}

$(document).ready(function(){
  //$('th').addClass('grid_4');
  //$('td').addClass('grid_4');
  
  $('.band-link').live('click',function(){
    var detailsRow = $('#details-row');
    var detailsDiv = $('#details-div');
    if ($(this)[0] == openItem)
    {
      detailsDiv.slideUp('fast','swing');
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
    var itemId = $(this).attr('data-bandid');
    detailsDiv.slideUp('fast','swing',function() {
      detailsRow.insertAfter(thisRow);
      $.get("/bands/" + itemId.toString() + ".json", function(data){
        if(data.last_fm_id){
          $.get(lastFmUrl(data.last_fm_id),
          function(data2){
              data.image_url = data2.artist.image[3]['#text'];
              templateDetails($("#band-details-row-template"),detailsDiv,data);
          });
        }else{
          templateDetails($("#band-details-row-template"),detailsDiv,data);
        }
      });
    });
  });
  
  $('.venue-link').live('click',function(){
    var detailsRow = $('#details-row');
    var detailsDiv = $('#details-div');
    if ($(this)[0] == openItem)
    {
      detailsDiv.slideUp('fast','swing');
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
    detailsDiv.slideUp('fast','swing',function() {
      detailsRow.insertAfter(thisRow);
      $.get("/venues/" + itemId.toString() + ".json", function(data){
          templateDetails($("#venue-details-row-template"),detailsDiv,data);
      });
    });
  });
});
