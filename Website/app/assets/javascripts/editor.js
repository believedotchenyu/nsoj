$(document).ready(function(){
	$(".preview").hide();

  $("#editor-button-preview").click(function(){
  	$(this).addClass("btn-default");
  	$(this).removeClass("btn-link");
  	$("#editor-button-edit").removeClass("btn-default");
  	$("#editor-button-edit").addClass("btn-link");
  	
  	$(".edit").hide();
  	$(".preview").show();
  	
  	$(".preview").html($(".edit").val());
  });
  $("#editor-button-edit").click(function(){
  	$(this).addClass("btn-default");
  	$(this).removeClass("btn-link");
  	$("#editor-button-preview").removeClass("btn-default");
  	$("#editor-button-preview").addClass("btn-link");
  	
  	$(".edit").show();
  	$(".preview").hide();
  });
});
