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
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="forgotten">
    <p><?php echo $text_email; ?></p><br />
    <h2 class="c1_color"><?php echo $text_your_email; ?></h2>
    <?php echo $entry_email; ?><br />
    <input type="text" name="email" value="" />

<br /><br />
      <div class="button c1" style="margin-right:10px"><a href="<?php echo $back; ?>"><span><?php echo $button_back; ?></span></a></div>
      <div class="button c1"><a onclick="$('#forgotten').submit(); return false" href="#"><span><?php echo $button_continue; ?></span></a></div>

  </form>

  <div class="c"></div>
</div>


  </div>
  </div>
<?php echo $footer; ?>