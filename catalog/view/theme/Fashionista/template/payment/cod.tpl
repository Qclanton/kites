
  <div class="button c1"><a id="button-confirm" href="#"><span><?php echo $button_confirm; ?></span></a></div>
<div class="c"></div>
<script type="text/javascript"><!--
$('#button-confirm').bind('click', function(event) {
	event.preventDefault();
	$.ajax({ 
		type: 'GET',
		url: '<?php echo HTTP_SERVER; ?>index.php?route=payment/cod/confirm',
		success: function() {
			location = '<?php echo $continue; ?>';
		}		
	});
});
//--></script> 
