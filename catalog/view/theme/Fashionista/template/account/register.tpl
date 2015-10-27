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

  <h2 class="c1_color"><?php echo $heading_title; ?></h2>
  <p><?php echo $text_account_already; ?></p><br /><br />
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="register">
    <h2 class="c1_color"><?php echo $text_your_details; ?></h2><br />
    <div class="content">

          <span class="required">*</span> <?php echo $entry_firstname; ?><br />
          <input type="text" name="firstname" value="<?php echo $firstname; ?>" />
            <?php if ($error_firstname) { ?>
            <label><span class="error"><?php echo $error_firstname; ?></span></label>
            <?php } ?>
<br /><br />

          <span class="required">*</span> <?php echo $entry_lastname; ?><br />
          <input type="text" name="lastname" value="<?php echo $lastname; ?>" />
            <?php if ($error_lastname) { ?>
            <label><span class="error"><?php echo $error_lastname; ?></span></label>
            <?php } ?>
        <br /><br />
        
          <span class="required">*</span> <?php echo $entry_email; ?><br />
          <input type="text" name="email" value="<?php echo $email; ?>" />
            <?php if ($error_email) { ?>
            <label><span class="error"><?php echo $error_email; ?></span></label>
            <?php } ?>
        <br /><br />
        
          <span class="required">*</span> <?php echo $entry_telephone; ?><br />
          <input type="text" name="telephone" value="<?php echo $telephone; ?>" />
            <?php if ($error_telephone) { ?>
            <label><span class="error"><?php echo $error_telephone; ?></span></label>
            <?php } ?>
        <br /><br />
        
          <?php echo $entry_fax; ?><br />
          <input type="text" name="fax" value="<?php echo $fax; ?>" />
        <br /><br />

    </div>
    <br /><br />
    <h2 class="c1_color"><?php echo $text_your_address; ?> </h2>
    <div class="content">
      
        
          <?php echo $entry_company; ?><br />
          <input type="text" name="company" value="<?php echo $company; ?>" />
        <br /><br />
        
          <span class="required">*</span> <?php echo $entry_address_1; ?><br />
          <input type="text" name="address_1" value="<?php echo $address_1; ?>" />
            <?php if ($error_address_1) { ?>
            <label><span class="error"><?php echo $error_address_1; ?></span></label>
            <?php } ?>
        <br /><br />
        
          <?php echo $entry_address_2; ?><br />
          <input type="text" name="address_2" value="<?php echo $address_2; ?>" />
        <br /><br />
        
          <span class="required">*</span> <?php echo $entry_city; ?><br />
          <input type="text" name="city" value="<?php echo $city; ?>" />
            <?php if ($error_city) { ?>
            <label><span class="error"><?php echo $error_city; ?></span></label>
            <?php } ?>
        <br /><br />
        
          <span class="required">*</span> <?php echo $entry_postcode; ?><br />
          <input type="text" name="postcode" value="<?php echo $postcode; ?>" />
            <?php if ($error_postcode) { ?>
            <label><span class="error"><?php echo $error_postcode; ?></span></label>
            <?php } ?>
        <br /><br />
        
          <span class="required">*</span> <?php echo $entry_country; ?><br />
          <select name="country_id" onchange="$('select[name=\'zone_id\']').load('<?php echo HTTP_SERVER; ?>index.php?route=account/register/zone&country_id=' + this.value + '&zone_id=<?php echo $zone_id; ?>');">
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
            <span class="error"><?php echo $error_country; ?></span>
            <?php } ?>
        <br /><br />
        
          <span class="required">*</span> <?php echo $entry_zone; ?><br />
          <select name="zone_id">
            </select>
            <?php if ($error_zone) { ?>
            <label><span class="error"><?php echo $error_zone; ?></span></label>
            <?php } ?>
        <br /><br />
      
    </div><br /><br />
    <h2 class="c1_color"><?php echo $text_your_password; ?></h2>
    <div class="content">
      
        
          <span class="required">*</span> <?php echo $entry_password; ?><br />
          <input type="password" name="password" value="<?php echo $password; ?>" />
            <?php if ($error_password) { ?>
            <label><span class="error"><?php echo $error_password; ?></span></label>
            <?php } ?>
        <br /><br />
        
          <span class="required">*</span> <?php echo $entry_confirm; ?><br />
          <input type="password" name="confirm" value="<?php echo $confirm; ?>" />
            <?php if ($error_confirm) { ?>
            <label><span class="error"><?php echo $error_confirm; ?></span></label>
            <?php } ?>
        <br /><br />
      
    </div><br /><br />
    <h2 class="c1_color"><?php echo $text_newsletter; ?></h2>
    <div class="content">
      
        
          <?php echo $entry_newsletter; ?>
          <?php if ($newsletter == 1) { ?>
            <input type="radio" name="newsletter" value="1" checked="checked" />
            <?php echo $text_yes; ?>
            <input type="radio" name="newsletter" value="0" />
            <?php echo $text_no; ?>
            <?php } else { ?>
            <input type="radio" name="newsletter" value="1" />
            <?php echo $text_yes; ?>
            <input type="radio" name="newsletter" value="0" checked="checked" />
            <?php echo $text_no; ?>
            <?php } ?>
        
      
    </div>
    <?php if ($text_agree) { ?>
<br />
      <?php echo $text_agree; ?>
        <?php if ($agree) { ?>
        <input type="checkbox" name="agree" value="1" checked="checked" /><br /><br />
        <?php } else { ?>
        <input type="checkbox" name="agree" value="1" /><br /><br />
        <?php } ?>
          <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div><br /><br />
  <?php } ?>
        <div class="button c1"><a href="#" onclick="$('#register').submit(); return false"><span><?php echo $button_continue; ?></span></a></div>

    <?php } else { ?>
    <div class="button c1">
      <a href="#" onclick="$('#register').submit(); return false"><span><?php echo $button_continue; ?></span></a>
    </div>
    <?php } ?>
  </form>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
$('select[name=\'zone_id\']').load('<?php echo HTTP_SERVER; ?>index.php?route=account/register/zone&country_id=<?php echo $country_id; ?>&zone_id=<?php echo $zone_id; ?>');
//--></script> 
<script type="text/javascript"><!--
$('.fancybox').fancybox({
	width: 560,
	height: 560,
	autoDimensions: false
});
//--></script>  


<div class="c"></div>
</div>


  </div>
  </div>
<?php echo $footer; ?>