<h2><?php echo $text_instruction; ?></h2>
<p><b><?php echo $text_payable; ?></b></p>
<p><?php echo $payable; ?></p>
<b><?php echo $text_address; ?></b><br />
<p><?php echo $address; ?></p>
<p><?php echo $text_payment; ?></p>

  <div class="button c1"><a id="button-confirm" href="#"><span><?php echo $button_confirm; ?></span></a></div>

<script type="text/javascript"><!--
$('#button-confirm').bind('click', function(event) {
	event.preventDefault();
	$.ajax({ 
		type: 'GET',
		url: '<?php echo HTTP_SERVER; ?>index.php?route=payment/cheque/confirm',
		success: function() {
			location = '<?php echo $continue; ?>';
		}		
	});
});
//--></script> 