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
    <h2 class="c1_color"><?php echo $text_your_details; ?></h2><br />
    
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
            
    <span class="required">*</span> <?php echo $entry_email; ?><br />
    <input type="text" name="email" value="<?php echo $email; ?>" />
            <?php if ($error_email) { ?>
            <label><span class="error"><?php echo $error_email; ?></span></label>
            <?php } ?><br /><br />
    
    <span class="required">*</span> <?php echo $entry_telephone; ?><br />
    <input type="text" name="telephone" value="<?php echo $telephone; ?>" />
            <?php if ($error_telephone) { ?>
            <label><span class="error"><?php echo $error_telephone; ?></span></label>
            <?php } ?><br /><br />
            
    <?php echo $entry_fax; ?><br />
    <input type="text" name="fax" value="<?php echo $fax; ?>" /><br /><br />   

      <div class="button c1" style="margin-right:10px"><a href="<?php echo $back; ?>"><span><?php echo $button_back; ?></span></a></div>
      <div class="button c1"><a onclick="$('#edit').submit(); return false" href="#"><span><?php echo $button_continue; ?></span></a></div>

  </form>	
  <div class="c"></div>
</div>


  </div>
  </div>
<?php echo $footer; ?>