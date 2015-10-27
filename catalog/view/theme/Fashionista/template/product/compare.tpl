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


  <?php if ($products) { ?>
  <table class="compare-info">
    <thead>
      <tr>
        <td colspan="<?php echo count($products) + 1; ?>"></td>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td></td>
        <?php foreach ($products as $product) { ?>
        <td class="name" align="center"><h2 class="c1_color"><a href="<?php echo $products[$product['product_id']]['href']; ?>"><?php echo $products[$product['product_id']]['name']; ?></a></h2></td>
        <?php } ?>
      </tr>
      <tr>
        <td></td>
        <?php foreach ($products as $product) { ?>
        <td align="center"><?php if ($products[$product['product_id']]['thumb']) { ?>
          <a href="<?php echo $products[$product['product_id']]['href']; ?>"><img src="<?php echo $products[$product['product_id']]['thumb']; ?>" border="0" alt="<?php echo $products[$product['product_id']]['name']; ?>" /></a>
          <?php } ?></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_price; ?></td>
        <?php foreach ($products as $product) { ?>
        <td align="center"><?php if (!$products[$product['product_id']]['special']) { ?>
          <h2 class="c1_color"><?php echo $products[$product['product_id']]['price']; ?></h2>
          <?php } else { ?>
          <span class="price-old"><strike><?php echo $products[$product['product_id']]['price']; ?></strike></span> <span class="price-new"><?php echo $products[$product['product_id']]['special']; ?></span>
          <?php } ?></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_model; ?></td>
        <?php foreach ($products as $product) { ?>
        <td align="center"><?php echo $products[$product['product_id']]['model']; ?></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_manufacturer; ?></td>
        <?php foreach ($products as $product) { ?>
        <td align="center"><?php echo $products[$product['product_id']]['manufacturer']; ?></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_availability; ?></td>
        <?php foreach ($products as $product) { ?>
        <td align="center"><?php echo $products[$product['product_id']]['availability']; ?></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_rating; ?></td>
        <?php foreach ($products as $product) { ?>
        <td align="center"><img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/stars-<?php echo $products[$product['product_id']]['rating']; ?>.png" alt="<?php echo $products[$product['product_id']]['reviews']; ?>" /><br />
          <?php echo $products[$product['product_id']]['reviews']; ?></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_summary; ?></td>
        <?php foreach ($products as $product) { ?>
        <td class="description"><?php echo $products[$product['product_id']]['description']; ?></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_weight; ?></td>
        <?php foreach ($products as $product) { ?>
        <td align="center"><?php echo $products[$product['product_id']]['weight']; ?></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_dimension; ?></td>
        <?php foreach ($products as $product) { ?>
        <td align="center"><?php echo $products[$product['product_id']]['length']; ?> x <?php echo $products[$product['product_id']]['width']; ?> x <?php echo $products[$product['product_id']]['height']; ?></td>
        <?php } ?>
      </tr>
    </tbody>
    <?php foreach ($attribute_groups as $attribute_group) { ?>
    <thead>
      <tr>
        <td colspan="<?php echo count($products) + 1; ?>"><?php echo $attribute_group['name']; ?></td>
      </tr>
    </thead>
    <?php foreach ($attribute_group['attribute'] as $key => $attribute) { ?>
    <tbody>
      <tr>
        <td><?php echo $attribute['name']; ?></td>
        <?php foreach ($products as $product) { ?>
        <?php if (isset($products[$product['product_id']]['attribute'][$key])) { ?>
        <td align="center"><?php echo $products[$product['product_id']]['attribute'][$key]; ?></td>
        <?php } else { ?>
        <td></td>
        <?php } ?>
        <?php } ?>
      </tr>
    </tbody>
    <?php } ?>
    <?php } ?>
    <tr>
      <td></td>
      <?php foreach ($products as $product) { ?>
      <td>
      	<div style="margin:auto; width:140px">
      	<span class="button c1" style="margin-right:10px"><a onclick="addToCart('<?php echo $product['product_id']; ?>'); return false" href="#"><span><?php echo $button_cart; ?></span></a></span>
      	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
          <input type="hidden" name="remove" value="<?php echo $product['product_id']; ?>" />
          <span class="button c1"><a onclick="$(this).parent().parent().submit(); return false" href="#"><span><?php echo $text_remove; ?></span></a></span>
        </form>
        </div>
      </td>
      <?php } ?>
    </tr>
    <tr>
      <td></td>
      <?php foreach ($products as $product) { ?>
      <td></td>
      <?php } ?>
    </tr>
  </table>



  <?php } else { ?>
  <div class="content"><?php echo $text_empty; ?></div>
<br />
    <div class="button c1"><a href="<?php echo $continue; ?>"><span><?php echo $button_continue; ?></span></a></div>

  <?php } ?>

</div>


  </div>
  </div>
<?php echo $footer; ?>