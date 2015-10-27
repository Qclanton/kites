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
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="password">
    <h2 class="c1_color"><?php echo $text_password; ?></h2>
    
    <span class="required">*</span> <?php echo $entry_password; ?><br />
	<input type="password" name="password" value="<?php echo $password; ?>" />
            <?php if ($error_password) { ?>
            <label><span class="error"><?php echo $error_password; ?></span></label>
            <?php } ?><br /><br />
    
    <span class="required">*</span> <?php echo $entry_confirm; ?><br />        
<input type="password" name="confirm" value="<?php echo $confirm; ?>" />
            <?php if ($error_confirm) { ?>
            <label><span class="error"><?php echo $error_confirm; ?></span></label>
            <?php } ?>                
<br /> <br /> 

      <div class="button c1" style="margin-right:10px"><a href="<?php echo $back; ?>"><span><?php echo $button_back; ?></span></a></div>
      <div class="button c1"><a onclick="$('#password').submit(); return false" href="#"><span><?php echo $button_continue; ?></span></a></div>

  </form>	
  <div class="c"></div>
</div>


  </div>
  </div>
<?php echo $footer; ?>
