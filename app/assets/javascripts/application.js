// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery-ui-1.8.17.custom.min
//= require jquery.tmpl.min
//= require jquery.dataTables.min
//= require jquery.lionbars.0.3.min
//= require jquery.cookie
//= require bands
//= require cities
//= require events
//= require home
//= require neighborhoods
//= require tickets
//= require venues

var last_fm_api_key = '7d032ba61568e866f8f9cd751a51e69d';

$(document).ready(function(){
  $('.search_link').on('click',function(){
    if ($('#search_container').is(':visible')){
      hide_search();
    }else{
      show_search();
    }
  });
  $("#search_box").on('keyup',function(event){
    if(event.keyCode == 13){
        $("#search_submit").click();
    }
  });
  $('#search_submit').on('click',function(){
    perform_search($('#search_box').attr('value'));
  });
  
  $("#email-signup").on('keyup',function(event){
    if(event.keyCode == 13){
      var email = $("#email-signup").val();
      $.ajax({
        type: "POST",
        data: $("#email-signup-form").serialize(),
        url: "/users",
        success: function(){
          $("#email-signup-form").fadeOut('fast',function(){
            $("#signed-up-notice").fadeIn('fast');
          });
        }});
      return false;
    }
  });

});

function show_search(){
  $("#search_container").slideDown();
  $("#search_box").focus();
  if(close_info_panel){
    close_info_panel();
  }
}

function hide_search(){
  $("#search_container").slideUp();
}

function perform_search(query){
  window.location.href = "/?q=" + query;
}

