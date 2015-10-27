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
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div><br /><br />
  <?php } ?>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <h2 class="c1_color"><?php echo $text_address_book; ?></h2>
  <?php foreach ($addresses as $result) { ?>
  <div class="content">
    <table style="width: 100%; margin-bottom:40px">
      <tr>
        <td width="50%"><?php echo $result['address']; ?></td>
        <td style="text-align: right;"><div class="button c1" style="margin-right:10px"><a href="<?php echo $result['update']; ?>"><span><?php echo $button_edit; ?></span></a></div><div class="button c1"><a href="<?php echo $result['delete']; ?>"><span><?php echo $button_delete; ?></span></a></div></td>
      </tr>
    </table>
  </div>
  <?php } ?>
<br /><br />
    <div class="button c1" style="margin-right:10px"><a href="<?php echo $back; ?>"><span><?php echo $button_back; ?></span></a></div>
    <div class="button c1"><a href="<?php echo $insert; ?>"><span><?php echo $button_new_address; ?></span></a></div>
  <div class="c"></div>
</div>


  </div>
  </div>
<?php echo $footer; ?>