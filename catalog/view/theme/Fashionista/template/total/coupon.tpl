<div>
  <div class="cart-heading"><span class="head_arr"><?php echo $heading_title; ?></span></div>
  <div class="cart-content" id="coupon"><br /><label><?php echo $entry_coupon; ?></label>&nbsp;
    <input type="text" name="coupon" value="<?php echo $coupon; ?>" /><br /><br />
    <div class="button c1"><a href="#" id="button-coupon"><span><?php echo $button_coupon; ?></span></a></div></div>
</div>	
	<div class="c"></div>
<script type="text/javascript"><!--
$('#button-coupon').bind('click', function(event) {
	event.preventDefault();
	var $t = $(this);
	$.ajax({
		type: 'POST',
		url: '<?php echo HTTP_SERVER; ?>index.php?route=total/coupon/calculate',
		data: $('#coupon :input'),
		dataType: 'json',		
		beforeSend: function() {
			$('.success, .warning').remove();
			$t.attr('disabled', true);
			$t.parent().after('<span class="wait">&nbsp;<img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$t.attr('disabled', false);
			$('.wait').remove();
		},		
		success: function(json) {
			if (json['error']) {
				$("#notification").remove();
				$('#basket_cart').before('<div id="notification" class="notify c1">' + json['error'] + '<a href="#" class="close"><img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/close.png" alt="" /></a></div>');
				$('#notification').fadeIn();
				
				$('#notification .close').click(function(event){
					event.preventDefault();
					$("#notification").fadeOut().remove();
				})		
			}
			
			if (json['redirect']) {
				location = json['redirect'];
			}
		}
	});
});
//--></script> 