<div class="column_cont">
  <div class="column_head c1"><h3><?php echo $heading_title; ?></h3></div>
  <div class="column_content specials">
      <?php foreach ($products as $product) { ?>
      <center>
        <?php if ($product['thumb']) { ?>
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div><br />
        <div class="c"></div>
        <?php if ($product['price']) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <span class="product-price c1"><?php echo $product['price']; ?></span>
          <?php } else { ?>
          <span><strike><?php echo $product['price']; ?></strike></span> <span class="product-price c1" style="padding:6px; color:#fff"><?php echo $product['special']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
        <?php if ($product['rating']) { ?>
        <div class="rating"><img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
        <?php } ?>
      <div class="c"></div>
      <br /><br />
      </center>
      <?php } ?>
  </div></div>