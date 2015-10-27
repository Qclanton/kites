<?php if ($payment_methods) { ?>
<br /><p><?php echo $text_payment_method; ?></p><br />
<table class="form">
  <?php foreach ($payment_methods as $payment_method) { ?>
  <tr>
    <td style="width: 1px;"><?php if ($payment_method['code'] == $code || !$code) { ?>
      <?php $code = $payment_method['code']; ?>
      <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" checked="checked" />
      <?php } else { ?>
      <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" />
      <?php } ?></td>
    <td><label for="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></label></td>
  </tr>
            <?php if (isset($payment_method['description'])):?>
          <tr style="padding:0">
              <td style="padding:0"></td>
              <td style="padding:0 0 0 5px; font-size:11px; color: #555" ><?php echo $payment_method['description']; ?></td>
              <td style="padding:0"></td>
          </tr>
          <?php endif; ?>

  <?php } ?>
</table>
<?php } ?>
<br /><br />
<div><?php echo $text_comments; ?></div>
<textarea name="comment" rows="8" style="width: 98%;"><?php echo $comment; ?></textarea>
<br /><br />
<?php if ($text_agree) { ?>

  <?php echo $text_agree; ?>
    <?php if ($agree) { ?>
    <input type="checkbox" name="agree" value="1" checked="checked" />
    <?php } else { ?>
    <input type="checkbox" name="agree" value="1" />
    <?php } ?>
    
<?php }?>
<?php if ($error_warning) { ?>
<div class="warning c1"><br /><strong><?php echo $error_warning; ?></strong></div>
<?php } ?>
<br /><br />
  <div class="button c1"><a id="button-payment" href="#"><span><?php echo $button_continue; ?></span></a></div>
<div class="c"></div>