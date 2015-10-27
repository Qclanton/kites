<?php echo $header; ?>
<div class="global c3">
	<div class="container">
            <div class="global_title"><h1><?php echo $heading_title; ?></h1>
            	<span><?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php if($breadcrumb['separator']) { ?>><?php } ?> <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?></span></div>
	</div>
</div>

<div class="white_bg">
    <div class="container">


<div id="main_column_st">
	
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="address">
    <h2 class="c1_color"><?php echo $text_edit_address; ?></h2>
    
    <span class="required">*</span> <?php echo $entry_firstname; ?><br />
    <input type="text" name="firstname" value="<?php echo $firstname; ?>" />
            <?php if ($error_firstname) { ?>
            <label><span class="error"><?php echo $error_firstname; ?></span></label>
            <?php } ?><br /><br />
    
    <span class="required">*</span> <?php echo $entry_lastname; ?><br />
    <input type="text" name="lastname" value="<?php echo $lastname; ?>" />
            <?php if ($error_lastname) { ?>
            <label><span class="error"><?php echo $error_lastname; ?></span></label>
            <?php } ?><br /><br />
    
    <?php echo $entry_company; ?><br />
    <input type="text" name="company" value="<?php echo $company; ?>" /><br /><br />
    
    <span class="required">*</span> <?php echo $entry_address_1; ?><br />
    <input type="text" name="address_1" value="<?php echo $address_1; ?>" />
            <?php if ($error_address_1) { ?>
            <label><span class="error"><?php echo $error_address_1; ?></span></label>
            <?php } ?><br /><br />
    
    <?php echo $entry_address_2; ?><br />    
    <input type="text" name="address_2" value="<?php echo $address_2; ?>" /><br /><br />    
    
    <span class="required">*</span> <?php echo $entry_city; ?><br />
    <input type="text" name="city" value="<?php echo $city; ?>" />
            <?php if ($error_city) { ?>
            <label><span class="error"><?php echo $error_city; ?></span></label>
            <?php } ?><br /><br />
            
    <span class="required">*</span> <?php echo $entry_postcode; ?><br />
    <input type="text" name="postcode" value="<?php echo $postcode; ?>" />
            <?php if ($error_postcode) { ?>
            <label><span class="error"><?php echo $error_postcode; ?></span></label>
            <?php } ?><br /><br />
            
    <span class="required">*</span> <?php echo $entry_country; ?><br />        
    <select name="country_id" onchange="$('select[name=\'zone_id\']').load('<?php echo HTTP_SERVER; ?>index.php?route=account/address/zone&country_id=' + this.value + '&zone_id=<?php echo $zone_id; ?>');">
              <option value=""><?php echo $text_select; ?></option>
              <?php foreach ($countries as $country) { ?>
              <?php if ($country['country_id'] == $country_id) { ?>
              <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
            <?php if ($error_country) { ?>
            <label><span class="error"><?php echo $error_country; ?></span></label>
            <?php } ?><br /><br />
            
    <span class="required">*</span> <?php echo $entry_zone; ?><br />
    <select name="zone_id">
            </select>
            <?php if ($error_zone) { ?>
            <label><span class="error"><?php echo $error_zone; ?></span></label>
            <?php } ?><br /><br />
            
    <?php echo $entry_default; ?><br />
    <?php if ($default) { ?>
            <input type="radio" name="default" value="1" checked="checked" />
            <?php echo $text_yes; ?>
            <input type="radio" name="default" value="0" />
            <?php echo $text_no; ?>
            <?php } else { ?>
            <input type="radio" name="default" value="1" />
            <?php echo $text_yes; ?>
            <input type="radio" name="default" value="0" checked="checked" />
            <?php echo $text_no; ?>
            <?php } ?><br /><br />
    
    

      <div class="button c1" style="margin-right:10px"><a href="<?php echo $back; ?>"><span><?php echo $button_back; ?></span></a></div>
      <div class="button c1"><a onclick="$('#address').submit(); return false" href="#"><span><?php echo $button_continue; ?></span></a></div>

  </form>	
  <div class="c"></div>
</div>

<script type="text/javascript"><!--
$('select[name=\'zone_id\']').load('<?php echo HTTP_SERVER; ?>index.php?route=account/address/zone&country_id=<?php echo $country_id; ?>&zone_id=<?php echo $zone_id; ?>');
//--></script> 
  </div>
  </div>
<?php echo $footer; ?>
	