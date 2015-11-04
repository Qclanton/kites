<?php echo $header; ?>

<?php
	// Calculate sale precent
	$number_price = (int)str_replace(" ", "", $price);
	$number_special = (int)str_replace(" ", "", $special);
	$sale_percent = (!empty($number_special)
		? ceil(($number_price-$number_special)/$number_price*100)
		: 0
	);					
?>
					
<script>
$(document).ready(function () {

	$('.select_block_tab2 .reviews').load('<?php echo HTTP_SERVER; ?>index.php?route=product/product/review&product_id=<?php echo $product_id; ?>', function(){
		$('.pagination .links b').addClass('c1');
		$('.pagination .links').find(":contains('|<')").html('<<');
		$('.pagination .links').find(":contains('>|')").html('>>');
	});
});
</script>
<div class="main-wrapper">
<main class="padding_wrapper">

    <div class="breadcrubs">
        <ul>
	<?php foreach ( $breadcrumbs as $breadcrumb ) {  ?>
		<?php if ($breadcrumb[ 'text' ] != 'Главная') { ?>
            <li><a href="<?php echo $breadcrumb[ 'href' ]; ?>"><?php echo $breadcrumb[ 'text' ]; ?></a></li>
            <li><span> > </span></li>
		<?php } ?>
        <?php } ?>
        </ul>
    </div>

	<div class="goods__content-wrapper product-info">
		<div class="sidebar_goods">
			<div class="img_container" style="background-image: url(<?php if ($popup) { echo $popup; } else { echo "'/catalog/view/theme/Fashionista/img/no_picture.jpg'"; } ?>);">
				<?php if (!empty($sale_percent)) { ?> 
					<div class="new">-<?= $sale_percent ?>%</div>
				<?php } ?>

			<?php if (isset($images[0])) { ?>
					<a href="<?php echo $popup; ?>" class="active img_little img1" style="background-image: url(<?php echo $thumb; ?>);"> </a>
			<?php } ?>

			<?php   
				$i = 2;
				if (isset($images[0])) {
				foreach ($images as $image) { 
				if ($i < 6) { ?>
						<a href="<?php echo $image['popup']; ?>" class="img_little img<?php echo $i;$i++; ?>" style="background-image: url(<?php echo $image['thumb']; ?>);"> </a>
				<?php }
				} ?>
			<?php } ?>

			<?php if ($location != '') { ?>
				<a href="" class="img_little videolink img<?php echo $i; ?>">
			<div class="videocontainer"><?php echo html_entity_decode($location); ?></div>
			<img src="img/good_little_03.jpg" alt="">
			</a>
			<?php } ?>

			</div>

			<div class="similar">
	<?php if($products) { ?>
				<h1>Похожие товары</h1>
		<?php if(count($products)  > 15) { ?>
		<a href="#" class="arr_left c1"></a>
		<a href="#" class="arr_right c1"></a>
		<?php } ?>
		  <?php foreach ($products as $product) { ?>
				<div class="good">
				<?php if ($product['thumb']) { ?>
				<a href="<?php echo $product['href']; ?>" class="thumb"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
				<?php } ?>
				<p class="good-title"><a href="<?php echo $product['href']; ?>" class="name"><?php echo $product['name']; ?></a><span class="title-year">2013</span></p>

				<?php if ($product['price']) { ?>
						<p class="good-price">
				  <?php if (!$product['special']) { ?>
				  <span class="red"><?php echo $product['price']; ?></span>
				  <?php } else { ?>
							<span class="red"><?php echo $product['special']; ?></span>
							<span class="old"><?php echo $product['price']; ?></span>
				  <?php } ?>
						</p>
				<?php } ?>

		  </div>
		  <?php } ?>
	  <?php } ?>

			</div>

		</div> <?php //sidebar block ?>

		<div class="content_goods">
			<div class="product-data">
				<input type="hidden" name="product_id" value="<?= $product_id; ?>" />
				
				<form action="" method="POST" class="form_good">
					<div class="universal__line">
						<label>Рейтинг</label>
						<ul class="stars">
							<li class="starhover">
								<img class="blue" alt="" src="img/star_blue.png">
							</li>
							<li class="starhover">
								<img class="blue" alt="" src="img/star_blue.png">
							</li>
							<li class="starhover">
								<img class="blue" alt="" src="img/star_blue.png">
							</li>
							<li class="starhover">
								<img class="blue" alt="" src="img/star_blue.png">
							</li>
							<li class="starhover">
								<img class="blue" alt="" src="img/star_blue.png">
							</li>
						</ul>
					</div>




				<!-- Options -->
				<?php if ($options) { ?>
					<div class="main options">
						<?php foreach ($options as $option) { ?>	


							<!-- Option "size" -->				
							<?php if ($option['name'] == 'Размер') { ?>
								<div class="universal__line">
									<label><?= $option['name']; ?></label>

									<!-- Real option -->
									<input 
										id="option-size"
										type="hidden" 
										name="option[<?= $option['product_option_id']; ?>]" 
										value="<?= $option['option_value'][0]['product_option_value_id']; ?>"
									>

									<!-- Cute selector -->
									<ul class="sizes">
										<?php foreach ($option['option_value'] as $i=>$option_value) { ?>
											<li>
												<a 
													href="#"
													class="<?= $i==0 ? "active" : "" ?>"
													data-price="<?= $option_value['price'] ?>"
													data-size="<?= $option_value['product_option_value_id']; ?>"
													data-input-field="#option-size"
												>
													<?= $option_value['name']; ?>
												</a>
											</li>
										<?php } ?>
									</ul>
								</div>


							<!-- Option "color" -->
							<?php } else if ($option['name'] == 'Цвет') { ?>
								<div class="universal__line">
									<label><?= $option['name']; ?></label>

									<!-- Real option -->
									<input 
										id="option-color"
										type="hidden" 
										name="option[<?= $option['product_option_id']; ?>]" 
										value="<?= $option['option_value'][0]['product_option_value_id']; ?>"
									>

									<!-- Cute selector -->
									<ul class="colors">
										<?php foreach ($option['option_value'] as $i=>$option_value) { ?>
											<li
												style="cursor:pointer; background-image: url(<?= $option_value['image'] ?>)"
												class="<?= $i==0 ? "active" : "" ?>"
												data-price="<?= $option_value['price'] ?>"
												data-color="<?= $option_value['product_option_value_id']; ?>"
												data-input-field="#option-color"
											>
											</li>
										<?php } ?>
									</ul>
								</div>

								
							<!-- Other options -->
							<?php } else { ?>
								<input 
									type="hidden" 
									name="option[<?= $option['product_option_id']; ?>]" 
									value="<?= $option['option_value'][0]['product_option_value_id']; ?>"
								>
							<?php } ?>
						<?php } ?>
					</div>
				<?php } ?>				



				<!-- Price -->
				<div class="line__count">
					<span class="input__numbers-wrapper">
						<div class="increase-quantity quantity--before"></div>
						<input name="quantity" id="product-quantity" value="1" type="number">
						<div class="decrease-quantity quantity--after"></div>
						<span>шт.</span>
					</span>

					<span 
						id="unit-price" 
						data-price="<?= $special ? $special : $price ?>" 
						class="price_red"
					>
						<?= $special ? $special : $price ?>
					</span>

					<?php if ($special) { ?>					
						<span class="old_price"><?= $price ?></span>
					<?php } ?>
				</div>
			</div>


			
			<!-- Accessories -->
			<?php if (!empty($accessories)) { ?>
				<h1>Аксессуары </h1>
				
				<?php foreach ($accessories as $product_id=>$accessory) { ?>
					<?php $options = $accessory_options[$product_id] ?>
					
					<p class="product__checked">
						<input 
							name="accessories[]" 
							value="<?= $product_id ?>" 
							type="checkbox"
							data-price="<?= $accessory['special'] ? $accessory['special'] : $accessory['price'] ?>"
						>
						<input type="hidden" class="accessory-<?= $product_id ?>" name="product_id" value="<?= $product_id ?>" />
						 
						<label>
							<?= $accessory['name'] ?>
							
							<?php if (empty($options)) { ?>
									<input id="accessory-quantity-<?= $product_id ?>" name="quantity" value="1" type="hidden"> 
									
									<span
										id="accessory-price-<?= $product_id ?>"
										data-price="<?= $accessory['special'] ? $accessory['special'] : $accessory['price'] ?>"
										class="price_red"
									>
										<?= $accessory['special'] ? $accessory['special'] : $accessory['price'] ?>
									</span>

								<?php if ($special) { ?>					
									<span class="old_price"><?= $accessory['price'] ?></span>
								<?php } ?>
							<?php } ?>
						</label>
					</p>
				
					<!-- Accessory options -->
					<?php if (!empty($options)) { ?>
						<div class="options options-<?= $product_id ?>">
							<?php foreach ($options as $option) { ?>	


								<!-- Option "size" -->				
								<?php if ($option['name'] == 'Размер') { ?>
									<div class="universal__line">
										<label><?= $option['name']; ?></label>

										<!-- Real option -->
										<input 
											type="hidden" 
											name="option[<?= $option['product_option_id']; ?>]" 
											value="<?= $option['option_value'][0]['product_option_value_id']; ?>"
										>

										<!-- Cute selector -->
										<ul class="sizes">
											<?php foreach ($option['option_value'] as $i=>$option_value) { ?>
												<li>
													<a 
														href="#"
														class="<?= $i==0 ? "active" : "" ?>"
														data-price="<?= $option_value['price'] ?>"
														data-size="<?= $option_value['product_option_value_id']; ?>"
														data-input-field="input[name='option[<?= $option['product_option_id']; ?>]']"
													>
														<?= $option_value['name']; ?>
													</a>
												</li>
											<?php } ?>
										</ul>
									</div>


								<!-- Option "color" -->
								<?php } elseif ($option['name'] == 'Цвет') { ?>
									<div class="universal__line">
										<label><?= $option['name']; ?></label>

										<!-- Real option -->
										<input 
											type="hidden" 
											name="option[<?= $option['product_option_id']; ?>]" 
											value="<?= $option['option_value'][0]['product_option_value_id']; ?>"
										>

										<!-- Cute selector -->
										<ul class="colors">
											<?php foreach ($option['option_value'] as $i=>$option_value) { ?>
												<li
													style="cursor:pointer; background-image: url(<?= $option_value['image'] ?>)"
													class="<?= $i==0 ? "active" : "" ?>"
													data-price="<?= $option_value['price'] ?>"
													data-color="<?= $option_value['product_option_value_id']; ?>"
													data-input-field="input[name='option[<?= $option['product_option_id']; ?>]']"
												>
												</li>
											<?php } ?>
										</ul>
									</div>

									
								<!-- Other options -->
								<?php } else { ?>
									<input 
										type="hidden" 
										name="option[<?= $option['product_option_id']; ?>]" 
										value="<?= $option['option_value'][0]['product_option_value_id']; ?>"
									>
								<?php } ?>
							<?php } ?>
						</div>
						
						<!-- Accessory price -->	
						<div class="line__count">
							<span class="input__numbers-wrapper">
								<div class="increase-quantity quantity--before"></div>
								<input id="accessory-quantity-<?= $product_id ?>" name="quantity" value="1" type="number">
								<div class="decrease-quantity quantity--after"></div>
								<span>шт.</span>
							</span>

							<span 
								id="accessory-price-<?= $product_id ?>"
								data-price="<?= $accessory['special'] ? $accessory['special'] : $accessory['price'] ?>"
								class="price_red"
							>
								<?= $accessory['special'] ? $accessory['special'] : $accessory['price'] ?>
							</span>

						<?php if ($special) { ?>					
							<span class="old_price"><?= $accessory['price'] ?></span>
						<?php } ?>
						</div>
					<?php } ?>
				<?php } ?>
			<?php } ?>



				<div class="line__count">
					<h1>Итого: <span id="total-price" class="price_red"><?= $special ? $special : $price ?></span>
						<input type="button" value="<?php echo $button_cart; ?>" id="button-cart" class="btn_buy" />
						<!-- <input type="submit" value="В корзину" class="btn_buy"> -->
						<a href="order.html">Оформить заказ</a>
					</h1>
				</div>
			</form>

				<!-- TABS -->
				<div class="tabs">
					<div id="tab1" class="active">Описание</div>
					<div id="tab2"><?php echo $tab_review; ?></div>
				</div>

				<!-- select_block -->
				<div class="select_block_tab1 active">
			<?php echo $description; ?>
				</div>
				<!-- end select_block_tab1 -->

				<!-- select_block_tab2 -->
				<div class="select_block_tab2">
					<div class="reviews"></div>
					<div class="new_comment">
						<form action="" method="POST" class="add_comment">
							<label for="new_text">Ваш отзыв</label>
							<textarea name="" id="new_text" cols="30" rows="10"></textarea>
							<label for="capcha" class="text_grey">Введите символы с картинки</label>
							<div class="cap">
								<img src="img/info/capcha.jpg" alt="">
								<div class="button"></div>
								<input type="text">
								<input type="submit" value="Отправить запрос">
							</div>
						</form>
					</div>
				</div>
				<!-- end select_block_tab2 -->

		</div>	
				
		<!-- end content_goods -->
				
	</div>
		
		
</main>
</div>

<script>
	$('#button-cart').bind('click', function() {
		// Add all accessories to cart
		var accessories = $('input[name="accessories[]"]:checked');
		
		if (accessories.length > 0) {
			accessories.each(function() { 
				var productId = $(this).val();
				
				$.ajax({
					url: 'index.php?route=checkout/cart/add',
					type: 'post',
					data: $('#accessory-quantity-' + productId + ', input[type="hidden"].accessory-' + productId + ', .options-' + productId + ' input[type="hidden"]'),
					dataType: 'json',
					success: function(response) {
						console.log(response);						
						/*
						if (response['success']) {
							// Reload cart
							$('#cart').load('index.php #cart');				
							$('html, body').animate({ scrollTop: 0 }, 'slow'); 
						}
						*/
					}
				});
			});
		}
		
		
		// Add product
		$.ajax({
			url: 'index.php?route=checkout/cart/add',
			type: 'post',
			data: $('.product-data input[type=\'text\'], .product-data input[type=\'number\'], .product-data input[type=\'hidden\'], .product-data input[type=\'radio\']:checked, .product-data input[type=\'checkbox\']:checked, .product-data select, .product-data textarea'),
			dataType: 'json',
			success: function(response) {		
				if (response['error']) {
					console.log(response);
				} 
				
				
				if (response['success']) {
					// Reload cart
					$('#cart').load('index.php #cart');				
					$('html, body').animate({ scrollTop: 0 }, 'slow'); 
				}	
			}
		});
		
	});
</script>


<!-- Chooser of options -->
<script>
	$(document).ready(function() {	
		function makePriceString(priceNumber) {
			return priceNumber.toString().split(/(?=(?:\d{3})+$)/).join(' ') + ' р.';
		}
		
		function makePriceNumber(priceString) {
			return Number(priceString.replace(' ', '').replace('р.', ''));
		}
		
		
		
		
		
		function calcPrice() {
			// Get base data
			var unitPrice = makePriceNumber($('#unit-price').data('price'));
			var quantity = Number($('#product-quantity').val()); 
			var totalPrice = unitPrice*quantity;
			
			
			
			// Get additional data
			var additionalPrice = 0;
			var activeOptions = $('.main.options .active');
			
			activeOptions.each(function() { 
				additionalPrice += makePriceNumber($(this).data('price'));
			});
			
			
			
			// Get data about accessories
			var accessoriesPrice = 0;
			var accessories = $('input[name="accessories[]"]:checked');
			
			accessories.each(function(index, accessory) {
				var accessoryPrice = makePriceNumber($(this).data('price'));
				var accessoryProductId = $(this).val();					
				var accessoryQuantityField = $('#accessory-quantity-' + accessoryProductId);
				var accessoryQuantity = (accessoryQuantityField.length > 0 ? accessoryQuantityField.val() : 1);

				// Additional prices
				var accessoryAdditionalPrice = 0;
				var accessoryActiveOptions = $('.options-' + accessoryProductId + ' .active');
				
				if (accessoryActiveOptions.length > 0) {
					accessoryActiveOptions.each(function() { 
						accessoryAdditionalPrice += makePriceNumber($(this).data('price'));
					});
				}
				
				// Recalculate accessory prce
				accessoryPrice += accessoryAdditionalPrice;
				
				// Show recalculated price				
				$('#accessory-price-' + accessoryProductId).html(makePriceString(accessoryPrice));
				
				// Increase price of the all accessories
				accessoriesPrice += (accessoryQuantity*accessoryPrice);
			});
				
				
					
			// Calculate
			unitPrice = unitPrice+additionalPrice;
			totalPrice = unitPrice*quantity+accessoriesPrice;



			// Set result
			$('#unit-price').html(makePriceString(unitPrice));		
			$('#total-price').html(makePriceString(totalPrice));
		}
		
		
		
		
		
		// Calculate immidiately
		calcPrice();
		
		
		
		
		
		// Add handler for size options
		$('.options .sizes a').bind('click', function(ev) { 
			ev.preventDefault();
			
			// Set active
			$('.options .sizes a').removeClass('active');
			$(this).addClass('active');	
			
			// Set size
			var size = $(this).data('size');
			var inputField = $(this).data('input-field');			
			$(inputField).val(size);
			
			// Recalculate prices
			calcPrice();
		});
	
		
		
		
		
		// Add handler of color options
		$('.options .colors li').bind('click', function(ev) { 
			ev.preventDefault();
			
			// Set active
			$('.options .colors li').removeClass('active');
			$(this).addClass('active');
			
			// Set color
			var color = $(this).data('color');	
			var inputField = $(this).data('input-field');			
			$(inputField).val(color);
			
			// Activate necessary image
			if ($(this).parents('.options').hasClass('main')) {
				var colorIndex = $(this).index();
				var imageLink = $('.img_container .img_little').eq(colorIndex);
				
				if (imageLink.length > 0 && !imageLink.hasClass('active')) {
					imageLink.click();
				}
			}
			
			// Recalculate prices
			calcPrice();
		});
		
		
		
		// Handler for little image clicks
		$('.img_container .img_little').bind('click', function() { 
			var imageIndex = $(this).index();
			var colorOption = $('.options.main .colors li').eq(imageIndex);

			if (colorOption.length > 0 && !colorOption.hasClass('active')) {
				colorOption.click();
			}
		});


		
		
		
		// Add handlers for inсreace and descrease of quantity events
		$('.increase-quantity, .decrease-quantity').bind('click', function() {
			var quantityField = $(this).siblings('input[name="quantity"]');
			var quantity = Number(quantityField.val());
			var newQuantity = ($(this).hasClass('increase-quantity') ? quantity+1 : quantity-1); 
			
			// Set new quantity
			if (newQuantity > 0) {
				quantityField.val(newQuantity);
			}
			
			// Recalculate price
			calcPrice();
		});
		
		$('input[name="quantity"]').bind('change', function() { 
			if ($(this).val() < 1) {
				$(this).val(1);
			}
			
			calcPrice();
		});
		
		
		
		
		
		// Add handlers to accessories
		$('input[name="accessories[]"]').bind('change', function() { 			
			calcPrice();
		});
	});
</script>

<?php echo $footer; ?>
