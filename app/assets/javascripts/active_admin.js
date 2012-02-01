//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require active_admin/base
//= require timepicker
//= require jquery.tokeninput

$(document).ready(function(){
  $(".band_token_select").tokenInput("/bands.json?tokenformat=true",{
    theme: "facebook",
    onAdd: function(item){
      
    },
    onDelete: function(item){
    
    }
  });
});
