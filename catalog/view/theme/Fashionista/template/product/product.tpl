<?php echo $header; ?>

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
				<div class="new">-15%</div>

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
									value="<?= $option['option_value'][0]['name']; ?>"
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
									value="<?= $option['option_value'][0]['name']; ?>"
								>

								<!-- Cute selector -->
								<ul class="colors">
									<?php foreach ($option['option_value'] as $i=>$option_value) { ?>
										<li
											style="cursor:pointer"
											class="<?= $i==0 ? "active" : "" ?>"
											data-price="<?= $option_value['price'] ?>"
											data-color="<?= $option_value['product_option_value_id']; ?>"
										>
											<img alt="<?= $option_value['name'] ?>" src="<?= $option_value['image'] ?>">
										</li>
									<?php } ?>
								</ul>
							</div>
							
							
						<!-- Other options -->
						<?php } else { ?>
							<input 
								type="hidden" 
								name="option[<?= $option['product_option_id']; ?>]" 
								value="<?= $option['option_value'][0]['name']; ?>"
							>
						<?php } ?>
					<?php } ?>
				</div>
			<?php } ?>				



			<!-- Price -->
			<div class="line__count">
				<span class="input__numbers-wrapper">
					<div id="increase-quantity" class="quantity--before"></div>
					<input name="quantity" id="quantity" value="1" type="number">
					<div id="decrease-quantity" class="quantity--after"></div>
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






		<?php if ($accessories) { ?>
				<div class="accessories">
					<h1 style="margin-bottom: 0;">Аксессуары</h1>
					<?php foreach ($accessories as $accessory) { ?>
		<div class="accessoryblock">
			<div class="arequired" style="display: none;"><?php echo $accessory['required']; ?></div>
						<?php if ($price) { ?>
							<?php if (!$accessory['special']) { ?>
						<div class="optrealprice"><?php echo intval(substr(str_replace(' ', '', $accessory['price']), 0, strpos(str_replace(' ', '', $accessory['price']), 'р'))); ?></div>
							<?php } else { ?>
						<div class="optrealprice"><?php echo intval(substr(str_replace(' ', '', $accessory['special']), 0, strpos(str_replace(' ', '', $accessory['special']), 'р'))); ?></div>
							<?php } ?>
					<?php } ?>		            

					<input type="checkbox" <?php if ($accessory['required'] == '1') { echo 'checked ="checked"'; } ?> class="acheck" id="ck">

					<a href="<?php echo $accessory['popup']; ?>" title="<?php echo $accessory['name']; ?>" class="colorbox" rel="colorbox_accessory"><label for="ck"><?php echo $accessory['name']; ?></a>
						<?php if ($price) { ?>
							<?php if (!$accessory['special']) { ?>
							<span class="red" <?php if ($accessory['required'] == '1') { echo 'style="display: none;"'; } ?>><?php echo $accessory['price']; ?></span>
							<?php } else { ?>
						<span class="red" <?php if ($accessory['required'] == '1') { echo 'style="display: none;"'; } ?>><?php echo $accessory['special']; ?></span>
								<span class="old" <?php if ($accessory['required'] == '1') { echo 'style="display: none;"'; } ?>><?php echo $accessory['price']; ?></span> 
							<?php } ?>
					<?php } ?>		            
			</label>
			<!-- options -->
			<?php if (isset($accessory_options[$accessory['product_id']])) { ?>
						<div class="aoptions" <?php if ($accessory['required'] == '0') { echo 'style="display: none;"'; } ?>>
				<?php foreach ($accessory_options[$accessory['product_id']] as $option) { ?>
						<?php if ($option['type'] == 'select') { ?>
							<div class="line s2">
								<div class="line_text"><?php echo $option['name']; ?></div>
								<div class="line_points">
									<ul class="sizes">
							<?php $fst = true; foreach ($option['option_value'] as $option_value) { ?>
											<li><a href=""<?php if ($fst) { $fst = false; echo ' class="active"'; } ?> value="<?php echo $option_value['product_option_value_id']; ?>" price="<?php echo $option_value['price']; ?>"><?php echo $option_value['name']; ?></a></li>
							<?php } ?>
									</ul>
								</div>
							</div>
						<?php } ?>
				<?php } //foreach a options ?>	
						</div>
			<?php } // if is options ?>
				<div class="how_much" <?php if ($accessory['required'] == '0') { echo 'style="display: none;"'; } ?>>
					<div class="tri_btn up"></div>
					<div class="tri_btn low"></div>
					<input type="text" class="ahowmuch" value="1">
					<?php if ($price) { ?>
						<?php if (!$accessory['special']) { ?>
						<span class="price_red"><?php echo $accessory['price']; ?></span>
						<?php } else { ?>
							<span class="price_red"><?php echo $accessory['special']; ?></span>
							<span class="old_price"><?php echo $accessory['price']; ?></span> 
						<?php } ?>
					<?php } ?>		            
				</div>
		</div>
				<?php } //foreach a ?>
		</div>
		<?php } // if isset a ?>


				<div class="line__count">
					<h1>Итого: <span id="total-price" class="price_red"><?= $special ? $special : $price ?></span>
						<input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
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

<script type="text/javascript"><!--
$('#button-cart').bind('click', function() {
	console.log('clicked');
	
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('.product-info input[type=\'text\'], .product-info input[type=\'number\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
		dataType: 'json',
		success: function(response) {		
			if (response['error']) {
				console.log(response);
				/*
					for (i in json['error']['option']) {
						$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
					}
				*/
			} 
			
			
			if (response['success']) {
				// Reload cart
				$('#cart').load('index.php #cart');				
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
			}	
		}
	});
});
//--></script>


<!-- Chooser of options -->
<script>
	$(document).ready(function() {
		var additionalPrice = 0;
		var isColorOptionExists = ($('#option-color').length > 0);
		var isSizeOptionExists = ($('#option-size').length > 0);
		
		
		
		function makePriceString(priceNumber) {
			return priceNumber.toString().split(/(?=(?:\d{3})+$)/).join(' ') + ' р.';
		}
		
		function makePriceNumber(priceString) {
			return Number(priceString.replace(' ', '').replace('р.', ''));
		}
		
		
		
		function calcPrice() {
			// Get base data
			var unitPrice = makePriceNumber($('#unit-price').data('price'));
			var quantity = Number($('#quantity').val()); 
			var totalPrice = unitPrice*quantity;
			
			// Get additional data
			var additionalPrice = 0;
			var activeOptions = $('.options .active');
			
			activeOptions.each(function() { 
				console.log(makePriceNumber($(this).data('price')));
				additionalPrice += makePriceNumber($(this).data('price'));
			});
					
			// Calculate
			unitPrice = unitPrice+additionalPrice;
			totalPrice = unitPrice*quantity;

			// Set result
			$('#unit-price').html(makePriceString(unitPrice));		
			$('#total-price').html(makePriceString(totalPrice));
		}
		
		// Calculate immidiately
		calcPrice();
		
		// Add handler for size option
		if (isSizeOptionExists) {
			$('.options .sizes a').bind('click', function(ev) { 
				ev.preventDefault();
				
				// Set active
				$('.options .sizes a').removeClass('active');
				$(this).addClass('active');	
				
				// Set size
				var size = $(this).data('size');			
				$('#option-size').val(size);
				
				// Recalculate prices
				calcPrice();
			})
		}
		
		
		// Add handler of color option
		if (isColorOptionExists) {
			$('.options .colors li').bind('click', function(ev) { 
				ev.preventDefault();
				
				// Set active
				$('.options .colors li').removeClass('active');
				$(this).addClass('active');
				
				// Set color
				var color = $(this).data('color');			
				$('#option-color').val(color);
				
				// Recalculate prices
				calcPrice();
			})
		}
		
		// Add handlers for inсreace and descrease of quantity events
		$('#increase-quantity, #decrease-quantity').bind('click', function() {
			var quantity = Number($('#quantity').val()); 
			var newQuantity = ($(this).attr('id') == 'increase-quantity' ? quantity+1 : quantity-1); 
			
			// Set new quantity
			$('#quantity').val(newQuantity);
			
			// Recalculate price
			calcPrice();
		});
		
		$('#quantity').bind('change', function() { 
			calcPrice();
		});
	});
</script>

<?php echo $footer; ?>
