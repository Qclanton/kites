<?php
// Additional data is necessarty for calculate sale percent
$this->load->model('catalog/product');

// Total quantity of products
$total_products = 0;

foreach ($products as $i=>$product) {
	// Fetch full product info
	$product_id = explode(":", $product['key'])[0];
	$product_info = $this->model_catalog_product->getProduct($product_id);
	
	// Calculate total quantity
	$total_products += $product['quantity'];
	
	// Set info about sale percent
	$products[$i]['sale_percent'] = (!empty($product_info['special'])
		? ceil(($product_info['price']-$product_info['special'])/$product_info['price']*100)
		: 0
	);
}
?>


<div id="cart">
	<!-- Always shown part -->
	<div id="cart-static">
		<span class="red quantity"><?= $total_products ?></span>
		<span class="cart_name">Корзина</span>
	</div>
	
	<!-- Dynamic part -->
	<div id="cart-dynamic" style="display:none">
		<div class="small__boxes-wrapper small__boxes-cart_wrapper">
			<?php foreach ($products as $product) { ?>			
				<div class="cart-product small__boxes-box-wrapper">					
					<div class="small__boxes-main-image">
						<?php if ($product['thumb']) { ?>
							<img src="<?= $product['thumb'] ?>" />
						<?php } ?>
					</div>
					
					
					<div class="small__boxes-description">
						<h2>
							<a href="<?= $product['href'] ?>">
								<span><?= str_replace((int)$product['model'], "", $product['name']) ?><span> 
								<span class="year"><?= $product['model']; ?></span> 
								<span class="red">(<?= $product['quantity']; ?>)</span>
							</a>
						</h2>
						
						<?php if (!empty($product['sale_percent'])) { ?>
							<h2>
								<span class="red">Скидка <?= $product['sale_percent']; ?>%</span>
							</h2>
						<?php } ?>
						
						<ul>
							<?php foreach ($product['option'] as $option) { ?>
								<?php if (in_array($option['name'], ["Цвет", "Размер"])) { ?>
									<li>
										<span><?= $option['name'] ?></span>
										<div 
											class="small__cart-value-wrapper <?= $option['name'] == "Цвет" ? " small__cart-value-wrapper--color" : " small__cart-value-wrapper--size" ?>"
											style="<?= $option['name'] == "Цвет" ? "background-color: {$option['value']}" : "" ?>"
										>
											<?= $option['name'] == "Цвет" ? "" : $option['value']; ?>
										</div>
									</li>
								<?php } ?>
							<?php } ?>
									<li>
										<span class="red"><?= $product['total']; ?></span>
									</li>
						</ul>
					</div>
					<a 
						href="index.php?route=checkout/cart&remove=<?= $product['key']; ?>" 
						class="close remove-product" 
						data-product-key="<?= $product['key'] ?>"
						data-product-quantity="<?= $product['quantity'] ?>"
					>
						<img alt="" src="img/cansel_2.png" /> 
					</a>
				</div>
			<?php } ?>
		</div>		
	</div>
</div>


<!-- Remove items from cart -->
<script>
	$(document).ready(function() {
		$('body').delegate('#cart .remove-product', 'click', function(ev) { 
			ev.preventDefault();
			
			var product = $(this).parents('.cart-product');
			var productKey = $(this).data('product-key');
			var productQuantity = $(this).data('product-quantity');
			var removeUrl = 'index.php?route=module/cart&remove=' + productKey;
			
			$.get(removeUrl, function(data) {
				if (data.length > 0) {					
					// Remove product
					product
						.hide('slow')
						.remove()
					;
					
					// Decrease quantity					
					var quantity = Number($('#cart .quantity').html());
					$('#cart .quantity').html(quantity-productQuantity);
				}
			});
			
			return false;
		});
	});
</script>


<!-- Display dynamic part  -->
<script>
	$(document).ready(function() {
		var cartOpenedTimeout = 0;
		
		$('#cart').bind('mouseover', function() {
			if (typeof cartOpenedTimeout != 'undefined' && cartOpenedTimeout > 0) { 
				clearTimeout(cartOpenedTimeout);
			} 
			
			$('#cart-dynamic').show();
		});
		
		$('#cart').bind('mouseout', function() { 
			cartOpenedTimeout = setTimeout(function() { 
				$('#cart-dynamic').hide();
			}, 500);
		});
	});
</script>
