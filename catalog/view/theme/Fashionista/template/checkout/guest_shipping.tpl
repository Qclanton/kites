<br />
<table class="form">
  <tr>
    <td><span class="required">*</span> <?php echo $entry_firstname; ?></td>
    <td><input type="text" name="firstname" value="<?php echo $firstname; ?>" class="large-field" /></td>
  </tr>
  <tr>
    <td><span class="required">*</span> <?php echo $entry_lastname; ?></td>
    <td><input type="text" name="lastname" value="<?php echo $lastname; ?>" class="large-field" /></td>
  </tr>
  <tr>
    <td><?php echo $entry_company; ?></td>
    <td><input type="text" name="company" value="<?php echo $company; ?>" class="large-field" /></td>
  </tr>
  <tr>
    <td><span class="required">*</span> <?php echo $entry_address_1; ?></td>
    <td><input type="text" name="address_1" value="<?php echo $address_1; ?>" class="large-field" /></td>
  </tr>
  <tr>
    <td><?php echo $entry_address_2; ?></td>
    <td><input type="text" name="address_2" value="<?php echo $address_2; ?>" class="large-field" /></td>
  </tr>
  <tr>
    <td><span class="required">*</span> <?php echo $entry_city; ?></td>
    <td><input type="text" name="city" value="<?php echo $city; ?>" class="large-field" /></td>
  </tr>
  <tr>
    <td><span class="required">*</span> <?php echo $entry_postcode; ?></td>
    <td><input type="text" name="postcode" value="<?php echo $postcode; ?>" class="large-field" /></td>
  </tr>
  <tr>
    <td><span class="required">*</span> <?php echo $entry_country; ?></td>
    <td><select name="country_id" class="large-field" onchange="$('#shipping-address select[name=\'zone_id\']').load('<?php echo HTTP_SERVER; ?>index.php?route=checkout/address/zone&country_id=' + this.value);">
        <option value=""><?php echo $text_select; ?></option>
        <?php foreach ($countries as $country) { ?>
        <?php if ($country['country_id'] == $country_id) { ?>
        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
        <?php } ?>
        <?php } ?>
      </select></td>
  </tr>
  <tr>
    <td><span class="required">*</span> <?php echo $entry_zone; ?></td>
    <td><select name="zone_id" class="large-field">
      </select></td>
  </tr>
</table>
<br />
  <div class="button c1"><a id="button-payment" href="#"><span><?php echo $button_continue; ?></span></a></div>
<div class="c"></div>
<script type="text/javascript"><!--
$('#shipping-address select[name=\'zone_id\']').load('<?php echo HTTP_SERVER; ?>index.php?route=checkout/address/zone&country_id=<?php echo $country_id; ?>&zone_id=<?php echo $zone_id; ?>');
//--></script> 