<form action="<?php echo $action ?>" method="post" id="payment">
    <input type="hidden" name="ik_shop_id" value="<?php echo $ik_shop_id; ?>"/>
    <input type="hidden" name="ik_payment_amount" value="<?php echo $ik_payment_amount; ?>"/>
    <input type="hidden" name="ik_payment_id" value="<?php echo $ik_payment_id; ?>"/>
    <input type="hidden" name="ik_payment_desc" value="<?php echo $ik_payment_desc; ?>"/>
    <input type="hidden" name="ik_paysystem_alias" value="<?php echo $ik_paysystem_alias; ?>"/>
    <input type="hidden" name="ik_baggage_fields" value="<?php echo $ik_baggage_fields; ?>"/>
    <input type="hidden" name="ik_sign_hash" value="<?php echo $ik_sign_hash; ?>"/>
    <input type="hidden" name="ik_success_url" value="<?php echo $ik_success_url; ?>"/>
    <input type="hidden" name="ik_success_method" value="<?php echo $ik_success_method; ?>"/>
    <input type="hidden" name="ik_fail_url" value="<?php echo $ik_fail_url; ?>"/>
    <input type="hidden" name="ik_fail_method" value="<?php echo $ik_fail_method; ?>"/>
    <input type="hidden" name="ik_status_url" value="<?php echo $ik_status_url; ?>"/>
    <input type="hidden" name="ik_status_method" value="<?php echo $ik_status_method; ?>"/>
  <div class="buttons">
    <div class="right"><a onclick="$('#payment').submit();" class="button"><span><?php echo $button_confirm; ?></span></a></div>
  </div>
  </form>