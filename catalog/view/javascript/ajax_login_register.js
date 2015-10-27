  $(document).ready(function(){
 	  $("#cross_icon_login").bind("click", function() {
 	 	  
  			 $("#ajax_login").bPopup().close(); 
 	  });
  	 $("#cross_icon_track").bind("click", function() {
	 	  
		 $("#track_order").bPopup().close(); 
  });
  	 $("#cross_icon_signup").bind("click", function() {
	 	 
		$("#ajax_signup").bPopup().close(); 
  });
 	  
	  $("#loginpopup").bind("click", function() {
		  $('#ajax_login').bPopup({
			    easing: 'easeOutBack', //uses jQuery easing plugin
		            speed: 450,
		            transition: 'slideDown'
		        });
	  });
	  
	  $("#signuppopup").bind("click", function() {
		  $('#ajax_signup').bPopup({
			    easing: 'easeOutBack', //uses jQuery easing plugin
		            speed: 450,
		            transition: 'slideDown'
		        });
	  });

	  $('#signup-link').bind("click", function() {
		  $("#ajax_login").bPopup().close();
		  $('#ajax_signup').bPopup({
			    easing: 'easeOutBack', //uses jQuery easing plugin
		            speed: 450,
		            transition: 'slideDown'
		        });
	  })
	  
	  $('#login-link').bind("click", function() {
		  $("#ajax_signup").bPopup().close();
		  $('#ajax_login').bPopup({
			    easing: 'easeOutBack', //uses jQuery easing plugin
		            speed: 450,
		            transition: 'slideDown'
		        });
	  })
	  
	 
  // Login
$('#button-login-pop').live('click', function() {
	$.ajax({
		url: 'index.php?route=account/ajax_login_register/validateAjaxLogin',
		type: 'post',
		data: $('#login_details :input'),
		
		dataType: 'json',
		beforeSend: function() {
			$('#button-login-pop').attr('disabled', true);
			$('#button-login-pop').before('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},	
		complete: function() {
			$('#button-login-pop').attr('disabled', false);
			$('.wait').remove();
		},				
		success: function(json) {
			$('.warning, .error').remove();
			
			if (json['success'] != undefined) {
				location=json['redirect'];
			} else if (json['error'] != undefined) {
				$('input[name=\'ajax_password\']').after('<div class="warning" style="margin-right: 12px;display: none;margin-bottom:-10px;">' + json['error'] + '</div>');
				setTimeout(function(){$('.warning').fadeOut();}, 3000);
				$('.warning').show();
				
			}
			
		}
	});	

	
});
  function autodeleteMessage()
  {
	   $('.warning').hide(); 
  }
$('#button-register-pop').live('click', function() {
	$.ajax({
		url: 'index.php?route=account/ajax_login_register/ajaxregister',
		type: 'post',
		data: $('#signup_details :input'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-register-pop').attr('disabled', true);
			$('#button-register-pop').before('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},	
		complete: function() {
			$('#button-register-pop').attr('disabled', false);
			$('.wait').remove();
		},				
		success: function(json) {
			$('.warning, .error').remove();
			
			if (json['success'] != undefined) {
				location=json['redirect'];
			} else if (json['error']!= undefined) {
				$('input[name=\'re_ajax_register_password\']').after('<div class="warning" style="margin: 0 12px 4px 0;display: none;">' + json['error'] + '</div>');
				setTimeout(function(){$('.warning').fadeOut();}, 3000);				
				$('.warning').show();
			}
		}
	});	
});
});