<?php echo $header; ?>
<div class="global c3">
	<div class="container">
            <div class="global_title"><h1><?php echo $heading_title; ?></h1>
            	<span><?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php if($breadcrumb['separator']) { ?>><?php } ?> <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?></span></div>
	</div>
</div>

<div class="white_bg">
    <div class="container">


<div id="main_column_st">
	
  <h2 class="c1_color"><?php echo $heading_title; ?></h2>
  <div class="checkout">
    <div id="checkout">
      <div class="checkout-heading"><?php echo $text_checkout_option; ?></div>
      <div class="checkout-content"></div>
    </div>
    <?php if (!$logged) { ?>
    <div id="payment-address">
      <div class="checkout-heading"><span><?php echo $text_checkout_account; ?></span></div>
      <div class="checkout-content"></div>
    </div>
    <?php } else { ?>
    <div id="payment-address">
      <div class="checkout-heading"><span><?php echo $text_checkout_payment_address; ?></span></div>
      <div class="checkout-content"></div>
    </div>
    <?php } ?>
    <?php if ($shipping_required) { ?>
    <div id="shipping-address">
      <div class="checkout-heading"><?php echo $text_checkout_shipping_address; ?></div>
      <div class="checkout-content"></div>
    </div>
    <div id="shipping-method">
      <div class="checkout-heading"><?php echo $text_checkout_shipping_method; ?></div>
      <div class="checkout-content"></div>
    </div>
    <?php } ?>
    <div id="payment-method">
      <div class="checkout-heading"><?php echo $text_checkout_payment_method; ?></div>
      <div class="checkout-content"></div>
    </div>
    <div id="confirm">
      <div class="checkout-heading"><?php echo $text_checkout_confirm; ?></div>
      <div class="checkout-content"></div>
    </div>
  </div>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
$('#checkout .checkout-content input[name=\'account\']').live('change', function() {
	if ($(this).attr('value') == 'register') {
		$('#payment-address .checkout-heading span').html('<?php echo $text_checkout_account; ?>');
	} else {
		$('#payment-address .checkout-heading span').html('<?php echo $text_checkout_payment_address; ?>');
	}
});

$('.checkout-heading a').live('click', function() {
	$('.checkout-content').slideUp('slow');
	
	$(this).parent().parent().find('.checkout-content').slideDown('slow', function (){
        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		

            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });				
	});
});
<?php if (!$logged) { ?> 
$(document).ready(function() {
	
	
	
	$.ajax({
		url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/login',
		dataType: 'json',
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['output']) {		
				$('#checkout .checkout-content').html(json['output']);
				$('.fancybox').fancybox();	
				$('#checkout .checkout-content').slideDown('slow');
				Cufon.replace('.checkout h2, .button');
				        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		

            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });	
			}
		}
	});	
});		
<?php } else { ?>
$(document).ready(function() {
	$.ajax({
		url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/address/payment',
		dataType: 'json',
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['output']) {
				$('#payment-address .checkout-content').html(json['output']);
$('.fancybox').fancybox();	

				$('.fancybox').fancybox();	

				
				$('#payment-address .checkout-content').slideDown('slow');
				Cufon.replace('.checkout h2, .button');
        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		

            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });
			}

		}
	});	
});
<?php } ?>

// Checkout
$('#button-account').live('click', function(event) {
	event.preventDefault();
	var $t = $(this);
	
	$.ajax({
		url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/' + $('input[name=\'account\']:checked').attr('value'),
		dataType: 'json',
		beforeSend: function() {
			$t.attr('disabled', true);
			$('<span class="wait">&nbsp;<img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/loading.gif" alt="" /></span>').insertAfter($t.parent());
		},		
		complete: function() {
			$('#button-account').attr('disabled', false);
			$('.wait').remove();
		},			
		success: function(json) {

			$('.warning').remove();

			if (json['redirect']) {

				location = json['redirect'];
			}
	
			if (json['output']) {	


				$('#payment-address .checkout-content').html(json['output']);
$('.fancybox').fancybox();	
				$('#checkout .checkout-content').slideUp('slow');
				
				$('#payment-address .checkout-content').slideDown('slow');
				
				$('.checkout-heading a').remove();

				$('#checkout .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
				Cufon.replace('.checkout h2, .button');
        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		

            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });				
			}
		}
	});
});

// Login
$('#button-login').live('click', function(event) {
	event.preventDefault();
	var $t = $(this);
	
	$.ajax({
		url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/login',
		type: 'post',
		data: $('#checkout #login :input'),
		dataType: 'json',
		beforeSend: function() {
			$t.attr('disabled', true);
			$('<span class="wait">&nbsp;<img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/loading.gif" alt="" /></span>').insertAfter($t.parent());
		},	
		complete: function() {
			$('#button-login').attr('disabled', false);
			$('.wait').remove();
		},				
		success: function(json) {
			$('.warning').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
						
			if (json['error']) {
				$('#checkout .checkout-content .right p:first').append('<div class="warning c1_color" style="display: none; margin-top:20px"><strong>' + json['error']['warning'] + '</strong></div>');
				
				$('.warning').fadeIn('slow');
			} else {								
				$.ajax({
					url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/address/payment',
					dataType: 'json',
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}						
						
						if (json['output']) {
							$('#payment-address .checkout-content').html(json['output']);
							$('.fancybox').fancybox();	
							
							$('#checkout .checkout-content').slideUp('slow');
							
							$('#payment-address .checkout-content').slideDown('slow');
							
							$('#payment-address .checkout-heading span').html('<?php echo $text_checkout_payment_address; ?>');
							
							$('.checkout-heading a').remove();
				Cufon.replace('.checkout h2, .button');
        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		

            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });
						}
					}
				});	
			}
		}
	});	
});

// Register
$('#button-register').live('click', function(event) {
	event.preventDefault();
	var $t = $(this);
	
	$.ajax({
		url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/register',
		type: 'post',
		data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'password\'], #payment-address input[type=\'checkbox\']:checked, #payment-address input[type=\'radio\']:checked, #payment-address select'),
		dataType: 'json',
		beforeSend: function() {
			$t.attr('disabled', true);
			$('<span class="wait">&nbsp;<img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/loading.gif" alt="" /></span>').insertAfter($t.parent());
		},	
		complete: function() {
			$('#button-register').attr('disabled', false); 
			$('.wait').remove();
		},			
		success: function(json) {
			$('.warning').remove();
			$('.error').remove();
					
			if (json['redirect']) {
				
				window.location.href = json['redirect'];
			}
						
			if (json['error']) {
				if (json['error']['warning']) {
					$('#payment-address .checkout-content').prepend('<div class="warning c1_color" style="display: none; margin-top:20px"><strong>' + json['error']['warning'] + '</strong></div>');
					
					$('.warning').fadeIn('slow');
				}
				
				if (json['error']['firstname']) {
					$('#payment-address input[name=\'firstname\'] + br').after('<label>&nbsp;<span class="error">' + json['error']['firstname'] + '</span></label>');
				}
				
				if (json['error']['lastname']) {
					$('#payment-address input[name=\'lastname\'] + br').after('<label>&nbsp;<span class="error">' + json['error']['lastname'] + '</span></label>');
				}	
				
				if (json['error']['email']) {
					$('#payment-address input[name=\'email\'] + br').after('<label>&nbsp;<span class="error">' + json['error']['email'] + '</span></label>');
				}
				
				if (json['error']['telephone']) {
					$('#payment-address input[name=\'telephone\'] + br').after('<label>&nbsp;<span class="error">' + json['error']['telephone'] + '</span></label>');
				}		
										
				if (json['error']['address_1']) {
					$('#payment-address input[name=\'address_1\'] + br').after('<label>&nbsp;<span class="error">' + json['error']['address_1'] + '</span></label>');
				}	
				
				if (json['error']['city']) {
					$('#payment-address input[name=\'city\'] + br').after('<label>&nbsp;<span class="error">' + json['error']['city'] + '</span></label>');
				}	
				
				if (json['error']['postcode']) {
					$('#payment-address input[name=\'postcode\'] + br').after('<label>&nbsp;<span class="error">' + json['error']['postcode'] + '</span></label>');
				}	
				
				if (json['error']['country']) {
					$('#payment-address select[name=\'country_id\'] + br').after('<label>&nbsp;<span class="error">' + json['error']['country'] + '</span></label>');
				}	
				
				if (json['error']['zone']) {
					$('#payment-address select[name=\'zone_id\'] + br').after('<label>&nbsp;<span class="error">' + json['error']['zone'] + '</span></label>');
				}
				
				if (json['error']['password']) {
					$('#payment-address input[name=\'password\'] + br').after('<label>&nbsp;<span class="error">' + json['error']['password'] + '</span></label>');
				}	
				
				if (json['error']['confirm']) {
					$('#payment-address input[name=\'confirm\'] + br').after('<label>&nbsp;<span class="error">' + json['error']['confirm'] + '</span></label>');
				}																																	
			} else {
				<?php if ($shipping_required) { ?>				
				var shipping_address = $('#payment-address input[name=\'shipping_address\']:checked').attr('value');
				
				if (shipping_address) {
					$.ajax({
						url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/shipping',
						dataType: 'json',
						success: function(json) {
							if (json['redirect']) {
								location = json['redirect'];
							}
														
							if (json['output']) {
								$('#shipping-method .checkout-content').html(json['output']);
								$('.fancybox').fancybox();	
								$('#payment-address .checkout-content').slideUp('slow');
								
								$('#shipping-method .checkout-content').slideDown('slow');
								
								$('#checkout .checkout-heading a').remove();
								$('#payment-address .checkout-heading a').remove();
								$('#shipping-address .checkout-heading a').remove();
								$('#shipping-method .checkout-heading a').remove();
								$('#payment-method .checkout-heading a').remove();											
								
								$('#shipping-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');									
								$('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');	
	
								$.ajax({
									url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/address/shipping',
									dataType: 'json',
									success: function(json) {
										if (json['redirect']) {
											location = json['redirect'];
										}										
										
										if (json['output']) {
											$('#shipping-address .checkout-content').html(json['output']);
											$('.fancybox').fancybox();	
															Cufon.replace('.checkout h2, .button');
        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		

            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });
										}
									}
								});	
							}
						}
					});	
				} else {
					$.ajax({
						url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/address/shipping',
						dataType: 'json',
						success: function(json) {
							if (json['redirect']) {
								location = json['redirect'];
							}
										
							if (json['output']) {
								$('#shipping-address .checkout-content').html(json['output']);
								$('.fancybox').fancybox();	
								$('#payment-address .checkout-content').slideUp('slow');
								
								$('#shipping-address .checkout-content').slideDown('slow');
								
								$('#checkout .checkout-heading a').remove();
								$('#payment-address .checkout-heading a').remove();
								$('#shipping-address .checkout-heading a').remove();
								$('#shipping-method .checkout-heading a').remove();
								$('#payment-method .checkout-heading a').remove();							

								$('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');	
												Cufon.replace('.checkout h2, .button');
        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		

            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });
							}
						}
					});			
				}
				<?php } else { ?>
				$.ajax({
					url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/payment',
					dataType: 'json',
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}	
											
						if (json['output']) {
							$('#payment-method .checkout-content').html(json['output']);
							$('.fancybox').fancybox();	
							$('#payment-address .checkout-content').slideUp('slow');
							
							$('#payment-method .checkout-content').slideDown('slow');
							
							$('#checkout .checkout-heading a').remove();
							$('#payment-address .checkout-heading a').remove();
							$('#payment-method .checkout-heading a').remove();								
							
							$('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');	
											Cufon.replace('.checkout h2, .button');
        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		

            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });
						}
					}
				});					
				<?php } ?>
				
				$.ajax({
					url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/address/payment',
					dataType: 'json',
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}
									
						if (json['output']) {
							$('#payment-address .checkout-content').html(json['output']);
							$('.fancybox').fancybox();	
							$('#payment-address .checkout-heading span').html('<?php echo $text_checkout_payment_address; ?>');
											Cufon.replace('.checkout h2, .button');
        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		

            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });
						}
					}
				});
			}	 
		}
	});	
});

// Payment Address	
$('#payment-address #button-address').live('click', function(event) {
	
	event.preventDefault();
	var $t = $(this);
	
	$.ajax({
		url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/address/payment',
		type: 'post',
		data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'password\'], #payment-address input[type=\'checkbox\']:checked, #payment-address input[type=\'radio\']:checked, #payment-address select'),
		dataType: 'json',
		beforeSend: function() {
			$t.attr('disabled', true);
			$('<span class="wait">&nbsp;<img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/loading.gif" alt="" /></span>').insertAfter($t.parent());
		},	
		complete: function() {
			$t.attr('disabled', false);
			$('.wait').remove();
		},			
		success: function(json) {
			$('.error').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['error']) {
				if (json['error']['firstname']) {
					$('#payment-address input[name=\'firstname\']').after('<label>&nbsp;<span class="error">' + json['error']['firstname'] + '</span></label>');
				}
				
				if (json['error']['lastname']) {
					$('#payment-address input[name=\'lastname\']').after('<label>&nbsp;<span class="error">' + json['error']['lastname'] + '</span></label>');
				}	
				
				if (json['error']['telephone']) {
					$('#payment-address input[name=\'telephone\']').after('<label>&nbsp;<span class="error">' + json['error']['telephone'] + '</span></label>');
				}		
										
				if (json['error']['address_1']) {
					$('#payment-address input[name=\'address_1\']').after('<label>&nbsp;<span class="error">' + json['error']['address_1'] + '</span></label>');
				}	
				
				if (json['error']['city']) {
					$('#payment-address input[name=\'city\']').after('<label>&nbsp;<span class="error">' + json['error']['city'] + '</span></label>');
				}	
				
				if (json['error']['postcode']) {
					$('#payment-address input[name=\'postcode\']').after('<label>&nbsp;<span class="error">' + json['error']['postcode'] + '</span></label>');
				}	
				
				if (json['error']['country']) {
					$('#payment-address select[name=\'country_id\']').after('<label>&nbsp;<span class="error">' + json['error']['country'] + '</span></label>');
				}	
				
				if (json['error']['zone']) {
					$('#payment-address select[name=\'zone_id\']').after('<label>&nbsp;<span class="error">' + json['error']['zone'] + '</span></label>');
				}
			} else {
				<?php if ($shipping_required) { ?>
				$.ajax({
					url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/address/shipping',
					dataType: 'json',
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}
									
						if (json['output']) {
							$('#shipping-address .checkout-content').html(json['output']);
						$('.fancybox').fancybox();	
							$('#payment-address .checkout-content').slideUp('slow');
							
							$('#shipping-address .checkout-content').slideDown('slow');
							
							$('#payment-address .checkout-heading a').remove();
							$('#shipping-address .checkout-heading a').remove();
							$('#shipping-method .checkout-heading a').remove();
							$('#payment-method .checkout-heading a').remove();
							
							$('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');	
											Cufon.replace('.checkout h2, .button');
        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		

            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });
						}
					}
				});
				<?php } else { ?>
				$.ajax({
					url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/payment',
					dataType: 'json',
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}	
											
						if (json['output']) {
							$('#payment-method .checkout-content').html(json['output']);


							$('.fancybox').fancybox();	

						
							$('#payment-address .checkout-content').slideUp('slow');
							
							$('#payment-method .checkout-content').slideDown('slow');
							
							$('#payment-address .checkout-heading a').remove();
							$('#payment-method .checkout-heading a').remove();
														
							$('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');	
											Cufon.replace('.checkout h2, .button');
        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		

            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });
						}
					}
				});	
				<?php } ?>
				
				$.ajax({
					url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/address/payment',
					dataType: 'json',
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}
									
						if (json['output']) {
							$('#payment-address .checkout-content').html(json['output']);
							$('.fancybox').fancybox();	
											Cufon.replace('.checkout h2, .button');
        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		

            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });
						}
					}
				});					
			}	  
		}
	});	
});

// Shipping Address			
$('#shipping-address #button-address').live('click', function(event) {
	
	event.preventDefault();
	var $t = $(this);
	
	$.ajax({
		url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/address/shipping',
		type: 'post',
		data: $('#shipping-address input[type=\'text\'], #shipping-address input[type=\'password\'], #shipping-address input[type=\'checkbox\']:checked, #shipping-address input[type=\'radio\']:checked, #shipping-address select'),
		dataType: 'json',
		beforeSend: function() {
			$t.attr('disabled', true);
			$('<span class="wait">&nbsp;<img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/loading.gif" alt="" /></span>').insertAfter($t.parent());
		},	
		complete: function() {
			$t.attr('disabled', false);
			$('.wait').remove();
		},			
		success: function(json) {
			$('.error').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['error']) {
				if (json['error']['firstname']) {
					$('#shipping-address input[name=\'firstname\']').after('<label>&nbsp;<span class="error">' + json['error']['firstname'] + '</span></label>');
				}
				
				if (json['error']['lastname']) {
					$('#shipping-address input[name=\'lastname\']').after('<label>&nbsp;<span class="error">' + json['error']['lastname'] + '</span></label>');
				}	
				
				if (json['error']['email']) {
					$('#shipping-address input[name=\'email\']').after('<label>&nbsp;<span class="error">' + json['error']['email'] + '</span></label>');
				}
				
				if (json['error']['telephone']) {
					$('#shipping-address input[name=\'telephone\']').after('<label>&nbsp;<span class="error">' + json['error']['telephone'] + '</span></label>');
				}		
										
				if (json['error']['address_1']) {
					$('#shipping-address input[name=\'address_1\']').after('<label>&nbsp;<span class="error">' + json['error']['address_1'] + '</span></label>');
				}	
				
				if (json['error']['city']) {
					$('#shipping-address input[name=\'city\']').after('<label>&nbsp;<span class="error">' + json['error']['city'] + '</span></label>');
				}	
				
				if (json['error']['postcode']) {
					$('#shipping-address input[name=\'postcode\']').after('<label>&nbsp;<span class="error">' + json['error']['postcode'] + '</span></label>');
				}	
				
				if (json['error']['country']) {
					$('#shipping-address select[name=\'country_id\']').after('<label>&nbsp;<span class="error">' + json['error']['country'] + '</span></label>');
				}	
				
				if (json['error']['zone']) {
					$('#shipping-address select[name=\'zone_id\']').after('<label>&nbsp;<span class="error">' + json['error']['zone'] + '</span></label>');
				}
			} else {
				$.ajax({
					url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/shipping',
					dataType: 'json',
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}
									
						if (json['output']) {
							$('#shipping-method .checkout-content').html(json['output']);
							$('.fancybox').fancybox();	
							
							$('#shipping-address .checkout-content').slideUp('slow');
							
							$('#shipping-method .checkout-content').slideDown('slow');
							
							$('#shipping-address .checkout-heading a').remove();
							$('#shipping-method .checkout-heading a').remove();
							$('#payment-method .checkout-heading a').remove();
							
							$('#shipping-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
											Cufon.replace('.checkout h2, .button');
        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		

            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });							
						}
					}
				});	
				
				$.ajax({
					url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/address/shipping',
					dataType: 'json',
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}	
											
						if (json['output']) {
							$('#shipping-address .checkout-content').html(json['output']);
							$('.fancybox').fancybox();	
											Cufon.replace('.checkout h2, .button');
        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		

            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });
						}
					}
				});								
			}  
		}
	});	
});

// Guest
$('#button-guest').live('click', function() {
	$.ajax({
		url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/guest',
		type: 'post',
		data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'checkbox\']:checked, #payment-address select'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-guest').attr('disabled', true);
			$('#button-guest').after('<span class="wait">&nbsp;<img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/loading.gif" alt="" /></span>');
		},	
		complete: function() {
			$('#button-guest').attr('disabled', false); 
			$('.wait').remove();
		},			
		success: function(json) {
			$('.error').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['error']) {
				if (json['error']['firstname']) {
					$('#payment-address input[name=\'firstname\'] + br').after('<label>&nbsp;<span class="error">' + json['error']['firstname'] + '</span></label>');
				}
				
				if (json['error']['lastname']) {
					$('#payment-address input[name=\'lastname\'] + br').after('<label>&nbsp;<span class="error">' + json['error']['lastname'] + '</span></label>');
				}	
				
				if (json['error']['email']) {
					$('#payment-address input[name=\'email\'] + br').after('<label>&nbsp;<span class="error">' + json['error']['email'] + '</span></label>');
				}
				
				if (json['error']['telephone']) {
					$('#payment-address input[name=\'telephone\'] + br').after('<label>&nbsp;<span class="error">' + json['error']['telephone'] + '</span></label>');
				}		
										
				if (json['error']['address_1']) {
					$('#payment-address input[name=\'address_1\'] + br').after('<label>&nbsp;<span class="error">' + json['error']['address_1'] + '</span></label>');
				}	
				
				if (json['error']['city']) {
					$('#payment-address input[name=\'city\'] + br').after('<label>&nbsp;<span class="error">' + json['error']['city'] + '</span></label>');
				}	
				
				if (json['error']['postcode']) {
					$('#payment-address input[name=\'postcode\'] + br').after('<label>&nbsp;<span class="error">' + json['error']['postcode'] + '</span>');
				}	
				
				if (json['error']['country']) {
					$('#payment-address select[name=\'country_id\'] + br').after('<label>&nbsp;<span class="error">' + json['error']['country'] + '</span>');
				}	
				
				if (json['error']['zone']) {
					$('#payment-address select[name=\'zone_id\'] + br').after('<label>&nbsp;<span class="error">' + json['error']['zone'] + '</span>');
				}
			} else {
				<?php if ($shipping_required) { ?>	
				var shipping_address = $('#payment-address input[name=\'shipping_address\']:checked').attr('value');
				
				if (shipping_address) {
					$.ajax({
						url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/shipping',
						dataType: 'json',
						success: function(json) {
							if (json['redirect']) {
								location = json['redirect'];
							}
										
							if (json['output']) {
								$('#shipping-method .checkout-content').html(json['output']);
								$('.fancybox').fancybox();	
								
								$('#payment-address .checkout-content').slideUp('slow');
								
								$('#shipping-method .checkout-content').slideDown('slow');
								
								$('#payment-address .checkout-heading a').remove();
								$('#shipping-address .checkout-heading a').remove();
								$('#shipping-method .checkout-heading a').remove();
								$('#payment-method .checkout-heading a').remove();		
																
								$('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');	
								$('#shipping-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');	
												Cufon.replace('.checkout h2, .button');
        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		

            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });								
							}
							
							$.ajax({
								url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/guest/shipping',
								dataType: 'json',
								success: function(json) {
									if (json['redirect']) {
										location = json['redirect'];
									}
												
									if (json['output']) {
										$('#shipping-address .checkout-content').html(json['output']);
										$('.fancybox').fancybox();	
														Cufon.replace('.checkout h2, .button');
        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		

            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });
									}
								}
							});
						}
					});					
				} else {
					$.ajax({
						url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/guest/shipping',
						dataType: 'json',
						success: function(json) {
							if (json['redirect']) {
								location = json['redirect'];
							}	
													
							if (json['output']) {
								$('#shipping-address .checkout-content').html(json['output']);
								$('.fancybox').fancybox();	
								
								$('#payment-address .checkout-content').slideUp('slow');
								
								$('#shipping-address .checkout-content').slideDown('slow');
								
								$('#payment-address .checkout-heading a').remove();
								$('#shipping-address .checkout-heading a').remove();
								$('#shipping-method .checkout-heading a').remove();
								$('#payment-method .checkout-heading a').remove();
								
								$('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');	
												Cufon.replace('.checkout h2, .button');
        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		

            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });
							}
						}
					});
				}
				<?php } else { ?>				
				$.ajax({
					url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/payment',
					dataType: 'json',
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}		
										
						if (json['output']) {
							$('#payment-method .checkout-content').html(json['output']);
							$('.fancybox').fancybox();	
							
							$('#payment-address .checkout-content').slideUp('slow');
								
							$('#payment-method .checkout-content').slideDown('slow');
								
							$('#payment-address .checkout-heading a').remove();
							$('#payment-method .checkout-heading a').remove();
															
							$('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
											Cufon.replace('.checkout h2, .button');
        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		

            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });
						}
					}
				});				
				<?php } ?>
			}	 
		}
	});	
});

// Guest Shipping
$('#button-guest-shipping').live('click', function() {
	$.ajax({
		url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/guest/shipping',
		type: 'post',
		data: $('#shipping-address input[type=\'text\'], #shipping-address select'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-guest-shipping').attr('disabled', true);
			$('#button-guest-shipping').after('<span class="wait">&nbsp;<img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/loading.gif" alt="" /></span>');
		},	
		complete: function() {
			$('#button-guest-shipping').attr('disabled', false); 
			$('.wait').remove();
		},			
		success: function(json) {
			$('.error').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['error']) {
				if (json['error']['firstname']) {
					$('#shipping-address input[name=\'firstname\']').after('<span class="error">' + json['error']['firstname'] + '</span>');
				}
				
				if (json['error']['lastname']) {
					$('#shipping-address input[name=\'lastname\']').after('<span class="error">' + json['error']['lastname'] + '</span>');
				}	
										
				if (json['error']['address_1']) {
					$('#shipping-address input[name=\'address_1\']').after('<span class="error">' + json['error']['address_1'] + '</span>');
				}	
				
				if (json['error']['city']) {
					$('#shipping-address input[name=\'city\']').after('<span class="error">' + json['error']['city'] + '</span>');
				}	
				
				if (json['error']['postcode']) {
					$('#shipping-address input[name=\'postcode\']').after('<span class="error">' + json['error']['postcode'] + '</span>');
				}	
				
				if (json['error']['country']) {
					$('#shipping-address select[name=\'country_id\']').after('<span class="error">' + json['error']['country'] + '</span>');
				}	
				
				if (json['error']['zone']) {
					$('#shipping-address select[name=\'zone_id\']').after('<span class="error">' + json['error']['zone'] + '</span>');
				}
			} else {
				$.ajax({
					url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/shipping',
					dataType: 'json',
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}
									
						if (json['output']) {
							$('#shipping-method .checkout-content').html(json['output']);
							$('.fancybox').fancybox();	
							
							$('#shipping-address .checkout-content').slideUp('slow');
							
							$('#shipping-method .checkout-content').slideDown('slow');
							
							$('#shipping-address .checkout-heading a').remove();
							$('#shipping-method .checkout-heading a').remove();
							$('#payment-method .checkout-heading a').remove();
								
							$('#shipping-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
											Cufon.replace('.checkout h2, .button');
        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		

            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });
						}
					}
				});				
			}	 
		}
	});	
});

$('#button-shipping').live('click', function(event) {
	
	event.preventDefault();
	var $t = $(this);
	
	$.ajax({
		url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/shipping',
		type: 'post',
		data: $('#shipping-method input[type=\'radio\']:checked, #shipping-method textarea'),
		dataType: 'json',
		beforeSend: function() {
			$t.attr('disabled', true);
			$('<span class="wait">&nbsp;<img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/loading.gif" alt="" /></span>').insertAfter($t.parent());
		},	
		complete: function() {
			$t.attr('disabled', false);
			$('.wait').remove();
		},			
		success: function(json) {
			$('.warning').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['error']) {
				if (json['error']['warning']) {
					$('#shipping-method .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');
					
					$('.warning').fadeIn('slow');
				}			
			} else {
				$.ajax({
					url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/payment',
					dataType: 'json',
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}
												
						if (json['output']) {
							$('#payment-method .checkout-content').html(json['output']);
							$('.fancybox').fancybox();	
							
							$('#shipping-method .checkout-content').slideUp('slow');
							
							$('#payment-method .checkout-content').slideDown('slow');

							$('#shipping-method .checkout-heading a').remove();
							$('#payment-method .checkout-heading a').remove();
							
							$('#shipping-method .checkout-heading').append('<a><?php echo $text_modify; ?></a>');	
											Cufon.replace('.checkout h2, .button');
        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		

            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });
						}
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError);
					}
				});					
			}
		}
	});	
});

$('#button-payment').live('click', function(event) {
	
	event.preventDefault();
	var $t = $(this);
	
	$.ajax({
		url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/payment', 
		type: 'post',
		data: $('#payment-method input[type=\'radio\']:checked, #payment-method input[type=\'checkbox\']:checked, #payment-method textarea'),
		dataType: 'json',
		beforeSend: function() {
			$t.attr('disabled', true);
			$('<span class="wait">&nbsp;<img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/loading.gif" alt="" /></span>').insertAfter($t.parent());
		},	
		complete: function() {
			$t.attr('disabled', false);
			$('.wait').remove();
		},			
		success: function(json) {
		
			$('.warning').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['error']) {
				if (json['error']['warning']) {
					$('<div class="warning c1_color" style="display: none;"><strong>' + json['error']['warning'] + '</strong></div>').insertAfter($('#payment-method .checkout-content input[name=agree]'));
				
					$('.warning').fadeIn('slow');
				}			
			} else {
				$.ajax({
					url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/confirm',
					dataType: 'json',
					success: function(json, xhr, ajaxOptions, thrownError) {
						
						//alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						
						if (json['redirect']) {
							location = json['redirect'];
							alert('success1');
						}	
						//alert(json);
						if (json['output']) {
						
							$('#confirm .checkout-content').html(json['output']);
							$('.fancybox').fancybox();	
							
							$('#payment-method .checkout-content').slideUp('slow');
							
							$('#confirm .checkout-content').slideDown('slow');
							
							$('#payment-method .checkout-heading a').remove();
							
							$('#payment-method .checkout-heading').append('<a><?php echo $text_modify; ?></a>');	
											Cufon.replace('.checkout h2, .button');
							$(".button").each(function(){

							if($(this).children("div").length){
								$(this).find("div").remove();
							} 
							
							
								$(this).append(
									$("<div></div>")
									.css({
										'border' : '1px solid #fff',
										width : $(this).width()-4,
										height: $(this).height()-4,
										position : 'absolute',
										top : 1,
										left : 1
									})
									.fadeTo(0,0.25)
								); 

							});
						}
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						
					}
				});					
			}
		},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError);
					}
	});	
});
//--></script> 	
	
	  <div class="c"></div>
</div>


  </div>
  </div>
<?php echo $footer; ?>