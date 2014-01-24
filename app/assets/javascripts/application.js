// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require underscore
//= require_tree .


$(document).ready(function(){
	$(".merged input").on({
	    focus: function() { $(this).prev().addClass("focusedInput") },
	    blur:  function() { $(this).prev().removeClass("focusedInput") }
	});

	$(".follow-btn").click(function(){
			var method = $(this).attr("id");
			var that = this;

			$.ajax({
			  url: '/' + $(this).attr('data-id'),
			  type: method,
			  data: { type: $(this).attr('data-type') },
			  dataType: 'json',

			  success: function(response) {
			  	var new_id;
			  	var new_content;
			  	if(method === "post"){
			  		new_id = "delete";
			  		new_content = "Unfollow";
			  	}else{
			  		new_id = "post";
			  		new_content = "Follow";
			  	}

			    $(that).attr("id", new_id);
			    $(that).toggleClass("unfollow btn-danger follow btn-info");
			    $(that).html(new_content);
			    update_errors(response);
			  },

			  error: function( req, status, err ) {
			    console.log( 'something went wrong', status, err );
			  }
			});
		}
	);

	$(".modal-send").click(function(){
    var modalErrors = $(".errors");
    modalErrors.empty();
    var count = 0;
  
    _.each($("#new-question-form .form-control") , function(input){
    	if(!$.trim(input.value).length) { // zero-length string AFTER a trim
        modalErrors.append('<div class="alert alert-danger">' + 
        	$("label[for='"+$(input).attr('id')+"']").html() + ' cant be empty. </div>')
      } else {
        modalErrors.append('<div class="alert alert-success">' + 
        $("label[for='"+$(input).attr('id')+"']").html() + ' is good!. </div>')
        count++;
      }

      if(count === 2){
     		$("#new-question-form").submit();
      }
    })
  });


  $('.upvotes').click(function(event){
  	event.preventDefault();
		$.ajax({
			  url: '/' + $(this).attr('data-id') + "/upvote",
			  type: 'POST',
			  dataType: 'json',

			  success: function(response) {
					$('#answer-' + response.id).find('.glyphicon').html(response.votes)
			  },

			  error: function( req, status, err ) {
			    console.log( 'something went wrong', status, err );
			  }
			});  	
  });


});

update_errors = function(response){
	if(response["alert"]){			    
    $('#alerts').html(
    	"<div class='alert alert-" + response['alert'] + "'>" + response['content'] + "</div>"
    )
  } else {
  	$('#alerts').html("");
  }
}
