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
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="edit">
  	
  	
    <h2 class="c1_color"><?php echo $text_your_details; ?></h2>
    
    <span class="required">*</span> <?php echo $entry_firstname; ?><br />
    <input type="text" name="firstname" value="<?php echo $firstname; ?>" />
            <?php if ($error_firstname) { ?>
            <span class="error"><?php echo $error_firstname; ?></span>
            <?php } ?><br /><br />
            
    <span class="required">*</span> <?php echo $entry_lastname; ?><br />
    <input type="text" name="lastname" value="<?php echo $lastname; ?>" />
            <?php if ($error_lastname) { ?>
            <span class="error"><?php echo $error_lastname; ?></span>
            <?php } ?><br /><br />
            
    <span class="required">*</span> <?php echo $entry_email; ?><br />
    <input type="text" name="email" value="<?php echo $email; ?>" />
            <?php if ($error_email) { ?>
            <span class="error"><?php echo $error_email; ?></span>
            <?php } ?><br /><br />
            
    <span class="required">*</span> <?php echo $entry_telephone; ?><br />
    <input type="text" name="telephone" value="<?php echo $telephone; ?>" />
            <?php if ($error_telephone) { ?>
            <span class="error"><?php echo $error_telephone; ?></span>
            <?php } ?><br /><br />
            
            
    <?php echo $entry_fax; ?><br />
    <input type="text" name="fax" value="<?php echo $fax; ?>" /><br /><br />
    
 <br />
    <h2 class="c1_color"><?php echo $text_your_address; ?></h2>
    
    <?php echo $entry_company; ?><br />
    <input type="text" name="company" value="<?php echo $company; ?>" /><br /><br />
    
    <?php echo $entry_website; ?><br />
    <input type="text" name="website" value="<?php echo $website; ?>" /><br /><br />
    
    <span class="required">*</span> <?php echo $entry_address_1; ?><br />
    <input type="text" name="address_1" value="<?php echo $address_1; ?>" />
            <?php if ($error_address_1) { ?>
            <span class="error"><?php echo $error_address_1; ?></span>
            <?php } ?><br /><br />
            
    <?php echo $entry_address_2; ?><br />
    <input type="text" name="address_2" value="<?php echo $address_2; ?>" /><br /><br />
    
    <span class="required">*</span> <?php echo $entry_city; ?><br />
    <input type="text" name="city" value="<?php echo $city; ?>" />
            <?php if ($error_city) { ?>
            <span class="error"><?php echo $error_city; ?></span>
            <?php } ?><br /><br />
            
    <span class="required">*</span> <?php echo $entry_postcode; ?><br />
    <input type="text" name="postcode" value="<?php echo $postcode; ?>" />
            <?php if ($error_postcode) { ?>
            <span class="error"><?php echo $error_postcode; ?></span>
            <?php } ?><br /><br />
            
    <span class="required">*</span> <?php echo $entry_country; ?><br />
    <select name="country_id" onchange="$('select[name=\'zone_id\']').load('<?php echo HTTP_SERVER; ?>index.php?route=affiliate/edit/zone&country_id=' + this.value + '&zone_id=<?php echo $zone_id; ?>');">
              <option value="false"><?php echo $text_select; ?></option>
              <?php foreach ($countries as $country) { ?>
              <?php if ($country['country_id'] == $country_id) { ?>
              <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
            <?php if ($error_country) { ?>
            <span class="error"><?php echo $error_country; ?></span>
            <?php } ?><br /><br />
            
    <span class="required">*</span> <?php echo $entry_zone; ?><br />
    <select name="zone_id">
            </select>
            <?php if ($error_zone) { ?>
            <span class="error"><?php echo $error_zone; ?></span>
            <?php } ?><br /><br />
            
           <br />

      <div class="button c1" style="margin-right:10px"><a href="<?php echo $back; ?>"><span><?php echo $button_back; ?></span></a></div>
      <div class="button c1"><a onclick="$('#edit').submit(); return false" href="#"><span><?php echo $button_continue; ?></span></a></div>

  </form>	
  <div class="c"></div>
</div>


  </div>
  </div>
<script type="text/javascript"><!--
$('select[name=\'zone_id\']').load('<?php echo HTTP_SERVER; ?>index.php?route=affiliate/edit/zone&country_id=<?php echo $country_id; ?>&zone_id=<?php echo $zone_id; ?>');
//--></script> 
<?php echo $footer; ?>