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
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="wishlist">
    <div class="cart-info">
      <table>
        <thead>
          <tr>
            <td class="remove"><?php echo $column_remove; ?></td>
            <td class="image"><?php echo $column_image; ?></td>
            <td class="name"><?php echo $column_name; ?></td>
            <td class="model"><?php echo $column_model; ?></td>
            <td class="stock"><?php echo $column_stock; ?></td>
            <td class="price"><?php echo $column_price; ?></td>
            <td class="cart"><?php echo $column_cart; ?></td>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($products as $product) { ?>
          <tr>
            <td class="remove"><input type="checkbox" name="remove[]" value="<?php echo $product['product_id']; ?>" /></td>
            <td class="image"><?php if ($product['thumb']) { ?>
              <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
              <?php } ?></td>
            <td class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></td>
            <td class="model"><?php echo $product['model']; ?></td>
            <td class="stock"><?php echo $product['stock']; ?></td>
            <td class="price"><?php if ($product['price']) { ?>
              <div class="price">
                <?php if (!$product['special']) { ?>
                <?php echo $product['price']; ?>
                <?php } else { ?>
                <s><?php echo $product['price']; ?></s> <b><?php echo $product['special']; ?></b>
                <?php } ?>
              </div>
              <?php } ?></td>
            <td class="cart"><a onclick="addToCart('<?php echo $product['product_id']; ?>'); return false" href="#"><span><?php echo $button_cart; ?></span></a></td>
          </tr>
          <?php } ?>
        </tbody>
      </table>
    </div>
  </form>
<br /><br />
    <div class="button c1" style="margin-right:10px"><a href="<?php echo $back; ?>"><span><?php echo $button_back; ?></span></a></div>
    <div class="button c1"><a href="#" onclick="$('#wishlist').submit(); return false"><span><?php echo $button_update; ?></span></a></div>

  <?php } else { ?>
  <div class="content"><?php echo $text_empty; ?></div>
<br /><br />
    <div class="button c1"><a href="<?php echo $continue; ?>"><span><?php echo $button_continue; ?></span></a></div>

  <?php } ?>
  <div class="c"></div>
</div>


  </div>
  </div>
<?php echo $footer; ?>