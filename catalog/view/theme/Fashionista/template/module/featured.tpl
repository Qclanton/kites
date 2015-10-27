<div class="featured_cont">
<div class="featured">
    <h1 class="c3_color"><!-- <?php echo $heading_title; ?> --> Популярные товары</h1>
    <a href="#" class="arr_left c1"></a>
    <a href="#" class="arr_right c1"></a>
<ul>
      <?php foreach ($products as $product) { ?>
      <li>
            <?php if ($product['thumb']) { ?>
            <a href="<?php echo $product['href']; ?>" class="thumb"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
            <?php } ?>
            <a href="<?php echo $product['href']; ?>" class="name"><?php echo $product['name']; ?></a>
            <?php if ($product['price']) { ?>

              <?php if (!$product['special']) { ?>
              <span class="price-new" style="font-size:16px;"><?php echo $product['price']; ?></span>
              <?php } else { ?>
              <span class="price-old" style="font-size:16px;"><?php echo $product['price']; ?></span> <span class="price-new" style="font-size:16px;color:red;"><?php echo $product['special']; ?></span>
              <?php } ?>

            <?php } ?>

      </li>
      <?php } ?>
	  <!-- <span class="price-new"><?php echo $product['price']; ?></span> -->
</ul>
</div>
</div>
