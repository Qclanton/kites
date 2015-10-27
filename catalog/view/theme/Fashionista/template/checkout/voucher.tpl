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
  	<div id="notification" class="c1 notify"><?php echo $error_warning; ?></div><br />
  <?php } ?>
  <p><?php echo $text_description; ?></p><br />
  <div class="ct">
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="voucher">
    
    <span class="required">*</span> <?php echo $entry_to_name; ?><br />
    <input type="text" name="to_name" value="<?php echo $to_name; ?>" />
    <label><?php if ($error_to_name) { ?>
          <span class="error c1_color"><?php echo $error_to_name; ?></span>
          <?php } ?></label><br /><br />
          
    <span class="required">*</span> <?php echo $entry_to_email; ?><br />      
    <input type="text" name="to_email" value="<?php echo $to_email; ?>" />      
    <label><?php if ($error_to_email) { ?>
          <span class="error c1_color"><?php echo $error_to_email; ?></span>
          <?php } ?></label><br /><br />   
    
    <span class="required">*</span> <?php echo $entry_from_name; ?><br />
    <input type="text" name="from_name" value="<?php echo $from_name; ?>" />
    <label><?php if ($error_from_name) { ?>
          <span class="error c1_color"><?php echo $error_from_name; ?></span>
          <?php } ?></label><br /><br />
          
    <span class="required">*</span> <?php echo $entry_from_email; ?><br />
    <input type="text" name="from_email" value="<?php echo $from_email; ?>" />
    <label><?php if ($error_from_email) { ?>
          <span class="error c1_color"><?php echo $error_from_email; ?></span>
          <?php } ?></label><br /><br />
          
    
    <?php echo $entry_message; ?><br />
    <textarea name="message" cols="40" rows="5"><?php echo $message; ?></textarea>
    <br /><br />
    
    <span class="required">*</span> <?php echo $entry_amount; ?><br />
    <input type="text" name="amount" value="<?php echo $amount; ?>" size="5" />
    <label><?php if ($error_amount) { ?>
          <span class="error c1_color"><?php echo $error_amount; ?></span>
          <?php } ?></label><br /><br />
          
    <span class="required">*</span> <?php echo $entry_theme; ?> <?php if ($error_theme) { ?>
          <span class="error c1_color"><?php echo $error_theme; ?></span>
          <?php } ?><br />
    <?php foreach ($voucher_themes as $voucher_theme) { ?>
          <?php if ($voucher_theme['voucher_theme_id'] == $voucher_theme_id) { ?>
          &nbsp;&nbsp;<input type="radio" name="voucher_theme_id" value="<?php echo $voucher_theme['voucher_theme_id']; ?>" id="voucher-<?php echo $voucher_theme['voucher_theme_id']; ?>" checked="checked" />
          <label for="voucher-<?php echo $voucher_theme['voucher_theme_id']; ?>"><?php echo $voucher_theme['name']; ?></label>
          <?php } else { ?>
          &nbsp;&nbsp;<input type="radio" name="voucher_theme_id" value="<?php echo $voucher_theme['voucher_theme_id']; ?>" id="voucher-<?php echo $voucher_theme['voucher_theme_id']; ?>" />
          <label for="voucher-<?php echo $voucher_theme['voucher_theme_id']; ?>"><?php echo $voucher_theme['name']; ?></label>
          <?php } ?>
          <br />
          <?php } ?><br /><br />
          
          <label><?php echo $text_agree; ?></label>
        <?php if ($agree) { ?>
        <input type="checkbox" name="agree" value="1" checked="checked" />
        <?php } else { ?>
        <input type="checkbox" name="agree" value="1" />
        <?php } ?>
          

  <div class="buttons">
    <div class="button c1"><a href="#" onclick="$('#voucher').submit(); return false"><span><?php echo $button_continue; ?></span></a></div>
  </div>
  

  </form>
	  

  </div>
</div>

  <div class="c"></div>
  </div>
    <div class="c"></div>
  </div>
<?php echo $footer; ?>