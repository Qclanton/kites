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

  <?php if ($categories) { ?>
  <h2><?php echo $text_index; ?></h2>
  <div class="pagination">
  	<div class="links">
    <?php foreach ($categories as $category) { ?>
    <a href="<?php echo HTTP_SERVER; ?>index.php?route=product/manufacturer#<?php echo $category['name']; ?>"><?php echo $category['name']; ?></a>
    <?php } ?>
    </div>
    </div>
<div class="c"></div>
  <?php foreach ($categories as $category) { ?>
  <div class="manufacturer-list">
    <div class="manufacturer-heading"><?php echo $category['name']; ?><a id="<?php echo $category['name']; ?>"></a></div>
    <div class="manufacturer-content">
      <?php if ($category['manufacturer']) { ?>
      <?php for ($i = 0; $i < count($category['manufacturer']);) { ?>
      <ul>
        <?php $j = $i + ceil(count($category['manufacturer']) / 4); ?>
        <?php for (; $i < $j; $i++) { ?>
        <?php if (isset($category['manufacturer'][$i])) { ?>
        <li><a href="<?php echo $category['manufacturer'][$i]['href']; ?>"><?php echo $category['manufacturer'][$i]['name']; ?></a></li>
        <?php } ?>
        <?php } ?>
      </ul>
      <?php } ?>
      <?php } ?>
    </div>
  </div>
  <?php } ?>
  <?php } else { ?>
  <?php echo $text_empty; ?>
  <div class="buttons">
    <div class="right"><div class="button c1"><a href="<?php echo $continue; ?>"><span><?php echo $button_continue; ?></span></a></div></div>
  </div>
  <?php } ?>
  <div class="c"></div>
</div>


  </div>
  </div>
<?php echo $footer; ?>


