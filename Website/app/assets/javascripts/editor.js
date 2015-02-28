$(document).ready(function(){
	$("#preview").hide();

  $("#editor-button-preview").click(function(){
  	$(this).addClass("btn-default");
  	$(this).removeClass("btn-link");
  	$("#editor-button-edit").removeClass("btn-default");
  	$("#editor-button-edit").addClass("btn-link");
  	
  	$("#description").hide();
  	$("#preview").show();
  	
  	$("#preview").html($("#description").val());
  });
  $("#editor-button-edit").click(function(){
  	$(this).addClass("btn-default");
  	$(this).removeClass("btn-link");
  	$("#editor-button-preview").removeClass("btn-default");
  	$("#editor-button-preview").addClass("btn-link");
  	
  	$("#description").show();
  	$("#preview").hide();
  });
});
