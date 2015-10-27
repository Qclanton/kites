<form action="<?php echo $action; ?>" accept-charset="utf-8" method="post" id="payment">
	<input type="hidden" name="LMI_PAYMENT_AMOUNT" value="<?php echo $amount; ?>">
	<input type="hidden" name="LMI_PAYMENT_DESC" value="<?php echo $description; ?>">
	<input type="hidden" name="LMI_PAYMENT_NO" value="<?php echo $order_id; ?>">
	<input type="hidden" name="LMI_PAYEE_PURSE" value="<?php echo $LMI_PAYEE_PURSE; ?>">
</form>
<div class="button c1"><a onclick="$('#payment').submit(); return false" href="#"><span><?php echo $button_confirm; ?></span></a></div>
  <div class="c"></div>