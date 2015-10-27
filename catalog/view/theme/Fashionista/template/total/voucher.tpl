<div>
  <div class="cart-heading"><span class="head_arr"><?php echo $heading_title; ?></span></div>
  <div class="cart-content" id="voucher"><br /><label><?php echo $entry_voucher; ?></label>
    <input type="text" name="voucher" value="<?php echo $voucher; ?>" /><br /><br />
    <div class="button c1"><a href="#" id="button-voucher"><span><?php echo $button_voucher; ?></span></a></div>
    </div>
</div>
    <div class="c"></div>
<script type="text/javascript"><!--
$('#button-voucher').bind('click', function(event) {
	event.preventDefault();
	var $t = $(this);
	$.ajax({
		type: 'POST',
		url: '<?php echo HTTP_SERVER; ?>index.php?route=total/voucher/calculate',
		data: $('#voucher :input'),
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
				
				$('#basket_cart').before('<div id="notification" class="c1 notify">' + json['error'] + '<a href="#" class="close"><img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/close.png" alt="" /></a></div>');
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