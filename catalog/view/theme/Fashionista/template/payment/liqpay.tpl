<form action="<?php echo $action; ?>" method="post" id="payment">
  <input type="hidden" name="operation_xml" value="<?php echo $xml; ?>">
  <input type="hidden" name="signature" value="<?php echo $signature; ?>">

    <div class="button c1"><a onclick="$('#payment').submit(); return false" href="#"><span><?php echo $button_confirm; ?></span></a></div>
<div class="c"></div>
</form>
