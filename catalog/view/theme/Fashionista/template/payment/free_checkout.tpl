
  <div class="button c1" style="display:none"><a id="button-confirm"><span><?php echo $button_confirm; ?></span></a></div>
<div class="c"></div>
<script type="text/javascript"><!--
$('#button-confirm').bind('click', function(event) {
	event.preventDefault();
	$.ajax({ 
		type: 'GET',
		url: '<?php echo HTTP_SERVER; ?>index.php?route=payment/free_checkout/confirm',
		success: function() {
			location = '<?php echo $continue; ?>';
		}		
	});
});
$(document).ready(function(){
$('#simplecheckout_payment_form').hide();

$('.simplecheckout-button:last').find('span').html('<?php echo $button_confirm; ?>');

$('.simplecheckout-button:last').bind('click', function() {
	$.ajax({ 
		type: 'GET',
		url: 'index.php?route=payment/free_checkout/confirm',
		success: function() {
			location = '<?php echo $continue; ?>';
		}		
	});
});

});
//--></script> 
