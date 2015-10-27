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

  <div class="login-content">
    <div class="cl_left ct ct_min">
      <h2><?php echo $text_new_customer; ?></h2>
      <div class="content">
        <p><b><?php echo $text_register; ?></b></p><br />
        <p><?php echo $text_register_account; ?></p><br />
        <div class="button c1"><a href="<?php echo $register; ?>"><span><?php echo $button_continue; ?></span></a></div></div>
    </div>
    <div class="cl_right ct ct_min">
      <h2><?php echo $text_returning_customer; ?></h2>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="login">
        <div class="content">
          <p><?php echo $text_i_am_returning_customer; ?></p><br />
            <?php if ($success) { ?>
  <div class="success c1_color"><strong><?php echo $success; ?></strong></div><br />
  <?php } ?>
  <?php if ($error_warning) { ?>
  <div class="warning c1_color"><strong><?php echo $error_warning; ?></strong></div><br />
  <?php } ?>
          <b><?php echo $entry_email; ?></b><br />
          <input type="text" name="email" value="" />
          <br />
          <br />
          <b><?php echo $entry_password; ?></b><br />
          <input type="password" name="password" value="" />
          <br />
          <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a><br />
          <br />
          <div class="button c1"><a onclick="$('#login').submit(); return false;" href="#"><span><?php echo $button_login; ?></span></a></div>
          <?php if ($redirect) { ?>
          <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
          <?php } ?>
        </div>
      </form>
    </div>
  </div>
<div class="c"></div>
<script type="text/javascript"><!--
$('#login input').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#login').submit();
	}
});
//--></script> 
</div>


  </div>
  </div>
<?php echo $footer; ?>