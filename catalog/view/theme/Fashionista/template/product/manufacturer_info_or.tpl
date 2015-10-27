<!--<div class="product-compare"><a href="<?php echo $compare; ?>" id="compare_total"><?php echo $text_compare; ?></a></div>
-->
<?php echo $header; ?>

<div class="global c3">
	<div class="container">
			<div class="global_title"><h1><?php echo $heading_title; ?></h1>
				<span><?php foreach ($breadcrumbs as $breadcrumb) { ?>
	<?php if($breadcrumb['separator']) { ?>><?php } ?> <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
	<?php } ?></span></div>
	</div>
</div>
<div class="c"></div>

<div class="white_bg">
	<div class="container">

  
<div id="main_column" class="m_special">
	
	<?php echo $content_top; ?>


  <?php if ($products) { ?>
  <div class="product-filter">
	<div class="display">
		<b><?php echo $text_display; ?></b>
		<select class="select_display" onchange="display('');">
			<option value="grid" <? if($_COOKIE['display'] == 'grid'){echo 'selected="selected"';} ?>>Витрина</option>
			<option value="list" <? if($_COOKIE['display'] == 'list'){echo 'selected="selected"';} ?>>Список</option>
		</select>
	</div>
	<div class="limit"><label><?php echo $text_limit; ?></label>
	  <select onchange="location = this.value;">
		<?php foreach ($limits as $limits) { ?>
		<?php if ($limits['value'] == $limit) { ?>
		<option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
		<?php } else { ?>
		<option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
		<?php } ?>
		<?php } ?>
	  </select>
	</div>
	<div class="man_sort"><b><?php echo $text_sort; ?></b>
	  <select onchange="location = this.value;">
		<?php foreach ($sorts as $sorts) { ?>
		<?php if ($sorts['value'] == $sort . '-' . $order) { ?>
		<option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
		<?php } else { ?>
		<option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
		<?php } ?>
		<?php } ?>
	  </select>
	</div>
  </div>

  <div id="notification" class="c1"></div>
  <!-- List type -->
  <div class="product-list">
	<?php foreach ($products as $product) { ?>
	<div class="product_l">
	  <?php if ($product['thumb']) { ?>
	  <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
	  <?php } ?>
	  <a class="product_price_overlay" href="<?php echo $product['href']; ?>"><?php if ($product['price']) { ?>
	  <div class="price">
		<?php if (!$product['special']) { ?>
		<?php echo $product['price']; ?>
		<?php } else { ?>
		<?php echo $product['special']; ?>
		<?php } ?>

	  </div>
	  <?php } ?></a>
	  <a class="name c1_color" href="<?php echo $product['href']; ?>"><h2><?php echo $product['name']; ?></h2></a>
	  <div class="desc"><?php echo $product['description']; ?></div>
	  <?php if ($product['price']) { ?>
	  <div class="price">
		<?php if (!$product['special']) { ?>
		<span class="price-new c1_color"><?php echo $product['price']; ?></span>
		<?php } else { ?>
		<span class="price-new c2_color"><?php echo $product['special']; ?></span>
		<?php } ?>
	   <!-- <?php if ($product['tax']) { ?>
		<span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
		<?php } ?> -->
	  </div>
	  <?php } ?>
	  <a class="prod_overlay" href="<?php echo $product['href']; ?>"></a>
	  <a href="#" class="cart" rel="<?php echo $product['product_id']; ?>" ><?php echo $button_cart; ?></a>
	  <a class="wishlist" href="#" rel="<?php echo $product['product_id']; ?>"><?php echo $button_wishlist; ?></a>
	  <a class="compare" href="#" rel="<?php echo $product['product_id']; ?>"><?php echo $button_compare; ?></a>
		  
	  </div>
	<?php } ?>
  </div>
  <!-- Grid Type -->
  <div class="product-grid" style="display:none;">
	<?php foreach ($products as $product) { ?>
	<div class="product_l">
	  <?php if ($product['thumb']) { ?>
	  <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
	  <?php } ?>
	  <a class="product_price_overlays" href="<?php echo $product['href']; ?>"><?php if ($product['price']) { ?>
	  <div class="price">
		<?php if (!$product['special']) { ?>
		<?php echo $product['price']; ?>
		<?php } else { ?>
		<span class="price-new"><?php echo $product['special']; ?></span>
		<?php } ?>

	  </div>
	  <?php } ?></a>
	  <a class="name" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
	  <a class="prod_overlays" href="<?php echo $product['href']; ?>"></a>
	  <a href="#" class="cart" rel="<?php echo $product['product_id']; ?>" ><?php echo $button_cart; ?></a>
	  </div>
	<?php } ?>
  </div>  
  
  <div class="pagination"><?php echo $pagination; ?></div>
  <?php } ?>
  <?php echo $content_bottom; ?></div>
	</div>
<div class="c"></div>
</div>
<script type="text/javascript"><!--
function display(view) {
		view = $(".select_display option:selected").val();		
		$('.product_l').unbind('mouseenter mouseleave');
		//$('.product-grid .product_l').unbind('mouseenter mouseleave');
		
		

		//$('.product_l').removeClass('test2');
		if (view == 'list') {
			$('.product-grid').attr('class', 'product-list');
			$(".grid option").each(function(){
				if($(this).val() == 'list'){
					$(this).attr("selected",true);
				}
			});		
			$.cookie('display', 'list'); 

		} else {
			$('.product-list').attr('class', 'product-grid');
			$(".grid option").each(function(){
				if($(this).val() == 'grid'){
					$(this).attr("selected",true);
				}
			});
			$.cookie('display', 'grid');
		}
/*
			$('.product-list .product_l').hover(function(){
				$t = $(this);
				$t.find('.prod_overlay').fadeTo(0, 0.6).animate({
					height: 213
				},'fast');
				
				$t.find('.product_price_overlay').animate({
					top : 50,
					opacity : 'toggle'
				});
				$t.find('.cart').fadeIn();
				$t.find('.wishlist').fadeIn();  
				$t.find('.compare').fadeIn();  
				  
				
			}, function(){
				
				$t = $(this);    	
				
				$t.find('.prod_overlay').hide().css('height', '0px');
				$t.find('.product_price_overlay').animate({
					opacity : 'toggle',
					top : -30
				});
				$t.find('.cart').fadeOut();
				$t.find('.wishlist').fadeOut();  
				$t.find('.compare').fadeOut();  
				
			});	

			$('.product-grid .product_l').hover(function(){
				$t = $(this);
				
				$t.find('.prod_overlay').fadeTo(0, 0.6).animate({
					height: 213
				},'fast');
				
				$t.find('.product_price_overlay').animate({
					top : 30,
					opacity : 'toggle'
				});
				$t.find('.cart').fadeIn();  		
				setTimeout(function(){
					$t.find('.name').show();
				},200);
				
			}, function(){
				
				$t = $(this);    	
				
				$t.find('.prod_overlay').hide().css('height', '0px');
				$t.find('.product_price_overlay').animate({
					opacity : 'toggle',
					top : -30
				});
				$t.find('.cart').fadeOut();
				$t.find('.name').hide();
				
			});	
			*/
}


view = $.cookie('display');

if (view) {
	display(view);
} else {
	display('grid');
}
//--></script> 
<?php echo $footer; ?>
