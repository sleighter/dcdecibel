var openRow;
var loadingHolder = '<td colspan="4" class="grid_16 centered"><image src="/assets/loading.gif" alt="loading" /></td>';
$(document).ready(function(){
  $('th').addClass('grid_4');
  $('td').addClass('grid_4');
  
  $('.band-link').live('click',function(){
    if ($(this)[0] == openRow)
    {
      $('#details-row').slideUp('fast','swing');
      openRow = null;
      return;
    }
    openRow = $(this)[0];
    var thisRow = $(this).parent('tr');
    var bandid = $(this).attr('data-bandid');
    $('#details-row').slideUp('fast','swing',function() {
      $('#details-row').html(loadingHolder);
      $.get("/bands/" + bandid.toString() + ".json", function(data){ 
        $('#details-row').html('<td colspan="4" class="grid_16 centered">' + data.name + '  <a href="' + data.homepage_url + '">Homepage</a>' + '</td>'); });
      $('#details-row').insertAfter(thisRow);
      $('#details-row').slideDown('fast','swing');
    });
  });
  
  $('.venue-link').live('click',function(){
    if ($(this)[0] == openRow)
    {
      $("#details-row").slideUp('fast','swing');
      openRow = null;
      return;
    }
    openRow = $(this)[0];
    var thisRow = $(this).parent('tr');
    var venueid = $(this).attr('data-venueid');
    $('#details-row').slideUp('fast','swing',function() {
      $('#details-row').html(loadingHolder);
      $.get("/venues/" + venueid.toString() + ".json",function(data){ 
        $('#details-row').html('<td colspan="4" class="grid_16 centered">' + data.name + '  <a href="' + data.homepage_url + '">Homepage</a>' + '</td>'); });
      $('#details-row').insertAfter(thisRow);
      $('#details-row').slideDown('fast','swing');
    });

  });
});
