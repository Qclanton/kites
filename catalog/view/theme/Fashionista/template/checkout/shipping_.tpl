<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($shipping_methods) { ?>
<br /><p><?php echo $text_shipping_method; ?></p>
<table class="form">
  <?php foreach ($shipping_methods as $shipping_method) { ?>
  <tr>
    <td colspan="3"><br /><strong><?php echo $shipping_method['title']; ?></strong></td>
  </tr>
		<?php if (isset($shipping_method['description']) && $shipping_method['description']) { ?>
				<tr>
					<td colspan="3" style="padding-left: 4px; font-size:11px; color: #555"><?php echo $shipping_method['description']; ?></td>
				</tr>
			<?php } ?>
			<?php if (isset($shipping_method['block']) && $shipping_method['block']) { ?>
				<tbody id="<?php echo $shipping_method['code']?>_content">
				<?php echo $shipping_method['block']; ?>
				</body>
		<?php } ?>
			
  <?php if (!$shipping_method['error']) { ?>
  <?php foreach ($shipping_method['quote'] as $quote) { ?>
  <tr>
    <td style="width: 14px;"><?php if ($quote['code'] == $code || !$code) { ?>
      <?php $code = $quote['code']; ?>
      <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" checked="checked" />
      <?php } else { ?>
      <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" />
      <?php } ?></td>
    <td><label for="<?php echo $quote['code']; ?>"><?php echo $quote['title']; ?></label></td>
    <td><label for="<?php echo $quote['code']; ?>">&nbsp;- <?php echo $quote['text']; ?></label></td>
  </tr>
  <?php } ?>
  <?php } else { ?>
  <tr>
    <td colspan="3"><div class="error"><?php echo $shipping_method['error']; ?></div></td>
  </tr>
  <?php } ?>
  <?php } ?>
</table>
<?php } ?>
<br /><br />
<div><?php echo $text_comments; ?></div>
<textarea name="comment" rows="8" style="width: 98%;"><?php echo $comment; ?></textarea>
<br />
<br />

  <div class="button c1"><a id="button-shipping" href="#"><span><?php echo $button_continue; ?></span></a></div>
<div class="c"></div>
