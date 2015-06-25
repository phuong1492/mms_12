// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-datepicker/core
//= require_tree .
$(document).ready(function(){
  $('.datepicker').datepicker({format: "dd/mm/yyyy",
    clearBtn: true});
  select_user();
  $("#team_leader_id").click(function(){
    select_user();
	})
});

function select_user(){
  var a = $("input[id*=team_user_ids]");
  for (var index = 0; index < a.length; index++){
    if($("#team_leader_id").val() == a[index].value){
      document.getElementById("team_user_ids_"+ a[index].value)
        .parentNode.style.display = "none";
    }
    else{
      document.getElementById("team_user_ids_"+ a[index].value)
        .parentNode.style.display = "block";
    }
  }
}
