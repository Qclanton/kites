<?php
// Init Helper
require "category_helper.php";
$Helper = new HelperProductCategory($this);

// Info about current url
$url = $Helper->getUrlParts($this);

// Set info about possible sorts
$possible_sorts = $Helper->getPossibleSorts($sort, $order);

// Get page
$page = (isset($this->request->get['page']) ? $this->request->get['page'] : 1);

// Apply filters
$applied_filters = (!empty($this->request->get['filters']) ? $this->request->get['filters'] : null);
$filtered_products = $Helper->applyFilters($applied_filters);

// Re-render pagination	
if (!empty($applied_filters)) {
	$pagination = new Pagination();
	$pagination->total = count($filtered_products);
	$pagination->page = $page;
	$pagination->limit = $limit;
	$pagination->text = $this->language->get("text_pagination");
	$pagination->url = $url['root']  . "?" .  http_build_query(['filters'=>$applied_filters]) . $url['sort'] . $url['order'] . $url['limit'] . "&page={page}";
	$pagination = $pagination->render();
}

// Manually sort
$sorted_products = $Helper->sortBy($sort, $order, $filtered_products);

// Prepare page products
$products = array_slice($Helper->prepareProducts($sorted_products), ($page-1)*$limit, $limit);

// Get info about possible filters
$possible_filters = $Helper->getPossibleFilters($applied_filters);

// Set info about categories
$current_category_id = $Helper->category_id;
$root_category_id = $Helper->root_category_id;

// Get categories
$categories = $Helper->getCategories($root_category_id);
?>



<!-- Header -->
<?= $header ?>

<div class="main-wrapper">
	<div class="padding_wrapper">
		<!-- Breadcrumbs -->
		<div class="breadcrubs">
			<ul>
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
					<?php if ($breadcrumb['text'] != 'Главная') { ?>
						<li><a href="<?= $breadcrumb['href'] ?>"><?= $breadcrumb['text'] ?></a></li>
						<li><span> > </span></li>
					<?php } ?>
				<?php } ?>
			</ul>
		</div>
	</div>
	<main class="padding_wrapper category__table">
		<!-- Left Sidebar -->
		<div class="sidebar">
			<form id="filter" method="GET" action="<?= $url['root'] ?>">
				<!-- Subcategories menu -->
				<?php if (!empty($categories)) { ?>
					<div class="goods category__filter">
						<ul>				
							<?php foreach ($categories as $category) { ?>
								<?php $category['category_id'] = (isset($category['category_id']) ? $category['category_id'] : -1) ?>
								
								<li class="<?= $category['category_id'] == $current_category_id ? "current" : "" ?>">
									<a href="<?= $category['href'] ?>"><?= $category['name'] ?></a> <span><?= $category['products_quantity'] ?></span>
								</li>
								
								<?php if (
									$root_category_id != $current_category_id && 
									$category['category_id'] == $current_category_id
									&& !empty($possible_filters['sizes'])
								) { 
								?>
									<div class="universal__line category__size category__size-filters">
										<?php if (isset($applied_filters['size'])) { ?>
											<input type="hidden" name="filters[size]" value="<?= $applied_filters['size'] ?>">
										<?php } ?>	
																	
										<ul class="category__size-line">
												<p>выберите размер</p>											
											<?php foreach ($possible_filters['sizes']['possible_values'] as $size) { ?>
												<?php if ($size['quantity'] > 0) { ?>																	
													<li data-size="<?= $size['id'] ?>" class="size_value <?= $size['is_applied'] ? "active" : "" ?>">
														<a href="<?= $url['root'] ?>?filters[size]= <?= $size['id'] . $url['limit'] . $url['sort'] . $url['order'] ?>">
															<?= $size['title'] ?>
														</a>
													</li>
												<?php } ?>
											<?php } ?>
										</ul>
									</div>
								<?php } ?>
							<?php } ?>
						</ul>
					</div>
				<?php } ?>
			
				<!-- Filter-->
				<div class="filter">			
					<?php if (!empty($limit)) { ?>
						<input type="hidden" name="limit" value="<?= $limit ?>">
					<?php } ?>
					
					<?php if (!empty($sort)) { ?>
						<input type="hidden" name="sort" value="<?= $sort ?>">
					<?php } ?>	
					
					<?php if (!empty($order)) { ?>
						<input type="hidden" name="order" value="<?= $order ?>">
					<?php } ?>	
						
						
						
					
					<div class="price">
						<h1>
							Цена <div class="tri first"></div>
						</h1>
						<div class="slider">
							<div class="sliderCont">
								<input type="hidden" name="filters[min_price]" value="<?= $possible_filters['min_price'] ?>">
								<input type="hidden" name="filters[max_price]" value="<?= $possible_filters['max_price'] ?>">
								
								<div id="slider">
									<img src="../../img/1.jpg" alt="">
									<img src="../../img/1.jpg" alt="" class="img_mid">
									<img src="../../img/1.jpg" alt="" class="img_end">
								</div>
								
								<div class="price_range">
									<div class="min"><?= $possible_filters['min_price'] ?></div>
									<div class="middle"><?= ceil(($possible_filters['max_price']+$possible_filters['min_price'])/2) ?></div>
									<div class="max"><?= $possible_filters['max_price'] ?></div>
								</div>
							</div>
						</div>
					</div>
					
					
					<div class="category__filter category__filter-checkbox category__filter-manufacturers">
						<div class="wrapper-manufacturers--filtered">
							<h1>
								Производители <div class="tri second"></div>
							</h1>
							<ul class="list1">
								<?php foreach ($possible_filters['manufacturers'] as $manufacturer) { ?>
									<li>
										<input 
											class="manufacturer_value <?= $manufacturer['is_applied'] ? "filtered" : "" ?> <?= $manufacturer['quantity'] == 0 ? "empty" : "" ?>"
											type="checkbox" 
											name="filters[manufacturer][]"
											value="<?= $manufacturer['id'] ?>"
											<?= $manufacturer['is_applied'] ? "checked" : "" ?>
											<?= $manufacturer['quantity'] == 0 ? "disabled": "" ?>
										> 
										<label><?= $manufacturer['title'] ?> <span><?= $manufacturer['quantity'] ?></span></label>
									</li>
								<?php } ?>
							</ul>
						</div>
					</div>
					
					
					<div class="category__filter category__filter-checkbox category__filter-years">
						<div class="wrapper-years--filtered">
							<h1>
								Года <div class="tri third"></div>
							</h1>
							<ul>
								<?php foreach ($possible_filters['models'] as $model) { ?>
									<li>
										<input 
											class="model_value <?= $model['is_applied'] ? "filtered" : "" ?> <?= $model['quantity'] == 0 ? "empty": "" ?>"
											type="checkbox" 
											name="filters[model][]"
											value="<?= $model['name'] ?>"
											<?= $model['is_applied'] ? "checked" : "" ?>
											<?= $model['quantity'] == 0 ? "disabled": "" ?>
										> 
										<label><?= $model['year'] ?> <span><?= $model['quantity'] ?><span></label>
									</li>
								<?php } ?>
							</ul>
						</div>
					</div>
				</div>
			</form>			
		</div>
		
		<!-- Content -->
		<div class="content">
			<div class="wrapper-content--filtered">
				<?php if ($products ) { ?>
					<!-- Top pagination -->
					<?php require "category_pagination.tpl" ?>

					<!-- List of products -->
					<div class="article-wrapper">
						<div class="universal__wrapper clearfix three_cols--inner">
							<?php foreach ($products as $product) { ?>
								<?php
									// Calculate sale precent
									$number_price = (int)str_replace(" ", "", $product['price']);
									$number_special = (int)str_replace(" ", "", $product['special']);						
									$sale_percent = (!empty($number_special)
										? ceil(($number_price-$number_special)/$number_price*100)
										: 0
									);
								?>					

								<div class="universal__cell product__cell category__cells">
									<div class="img">
										<?php if (!empty($sale_percent)) { ?> 
											<span class="new">-<?= $sale_percent ?>%</span>
										<?php } ?>
										
										<a 
											class="catproductimg" 
											href="<?=$product['href']; ?>" 
											style="background-image: url(<?= !empty($product['thumb']) ? $product['thumb'] : "/catalog/view/theme/Fashionista/img/no_picture.jpg" ?>)"
										>
										</a>
									</div>
									<h2 class="name">
										<a href="<?= $product['href']; ?>">
											<span class="upper"><?= $product['name'] ?></span>
										</a>
									</h2>
									
									<?php if (!empty($product['options']['Размер'])) { ?>
										<div id="options_product--<?= $product['product_id'] ?>" class="universal__line category__size">
											<ul class="category__size-line">
													<p>выберите размер</p>
												<?php foreach ($product['options']['Размер'] as $size_option_value_id=>$size) { ?>
													<?php 
														$is_active = (!empty($applied_filters['size'])
															? ($size['option_group_value_id'] == $applied_filters['size'])
															: ($size_option_value_id == array_values($product['options']['Размер'])[0]['option_value_id'])
														)								
													?>
																	
													<li	
														data-product-id="<?= $product['product_id'] ?>"
														data-price="<?= $size['option_value_price'] ?>"
														data-size="<?= $size_option_value_id ?>" 
														class="product_size_value <?= $is_active  ? "active" : "" ?>"
													> 														
														<a>
															<?= $size['option_value_name'] ?>
														</a>
													</li>
												<?php } ?>
											</ul>
										</div>
									<?php } ?>									
							
									<p class="price">
											<span 
												data-product-id="<?= $product['product_id'] ?>"
												data-price="<?= !empty($product['special']) ? $product['special'] : $product['price'] ?>" 
												class="red"												
											>
												<?= !empty($product['special']) ? $product['special'] : $product['price'] ?></span>							
										<?php if (!empty($product['special'])) { ?>
											<span class="old"><?= $product['price'] ?></span>
										<?php } ?>
										
											<span 
												class="buy fast_buy"
												data-sale-percent="<?= $sale_percent ?>"
												data-product='<?= rawurlencode(json_encode($product, JSON_UNESCAPED_UNICODE)) ?>'									
											>
												Купить
											</span>
									</p>
								</div>
							<?php } ?>
						</div>
					</div>


					<!-- Bottom pagination -->
					<?php require "category_pagination.tpl" ?>


				<?php } else { ?>
					<div id="main_column">
						<?php echo $text_empty; ?>
					</div>
				<?php } ?>
			</div>	
		</div>
	</main>
</div>


<!-- Fast buy modal -->
<div id="fast-buy__popup" class="popup__overlay">
	<input type="hidden" data-product-entity="option" name="product_id" value="0" />
	<div class="hidden_options"></div>
	
	<div class="popup__wrapper--inner">
		<div class="popup__wrapper-block"> 
			<div class="popup__wrapper popup__wrapper--wide">
				<div class="popup__title popup__title--red"> 
					<h1><strong>$</strong> Быстрая покупка</h1>
					<a data-product-entity="close_button" class="close"><img src="img/close.png" alt=""></a>
				</div>
				<div class="popup__content">
					<h1 class="fast-buy__title">
						<span class="upper">BLADE SKINNY BOY</span>
						<span class="year">2015</span>
					</h1>

					<div class="fast-buy__popup goods__content-wrapper product-info">
						<div class="sidebar_goods">
							<div class="img_container" style="background-image: url(http://kites.local/image/cache/data/shop/kites/flat/north/north_dyno_2012_1590s-500x500.jpg);"></div>
							<a class="product_link" href="#">перейти на страницу товара</a>
						</div>
						<div class="content_goods">
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
							<div data-product-entity="options">
								<input id="option-size" data-product-entity="option" type="hidden" name="option[]" value="" disabled>
								<input id="option-color" data-product-entity="option" type="hidden" name="option[]" value="" disabled>
								
								<div class="universal__line product_sizes"></div>
								<div class="universal__line product_colors"></div>
							</div>
							<div class="line__count">
								<span class="input__numbers-wrapper">
									<div class="increase-quantity quantity--before"></div>
									<input name="quantity" data-product-entity="quantity" type="number" value="1">
									<div class="decrease-quantity quantity--after"></div>
									<span>шт.</span>
								</span>
								<span data-price="0" data-product-entity="unit-price" class="price_red"></span>
								<span class="old_price"></span>
							</div>
						</div>			
					</div>

					<div class="line__count">
						<h1 class="fast-buy__title">Итого: </h1>
						<span data-product-entity="total-price" class="price_red"></span>
						<span class="old_price"></span>
						<input id="button-cart" class="red_button" type="submit" value="В корзину">
						<a href="#">Оформить заказ</a>
					</div>
				</div>
			</div>
		</div>
	</div>	
</div> 



<!-- Modal "Cart added" -->
<div id="cart-added__popup" class="popup__overlay" data-product-entity="cart-added-popup">
	<div class="popup__wrapper--inner">
		<div class="popup__wrapper-block">
			<div class="reveal-modal popup__wrapper popup__error">
				<div class="popup__title"> 
					<h1>Спасибо!</h1>
					<a class="close close-reveal-modal"><img src="img/close.png" alt=""></a>
				</div>
				<div class="popup__content">
					<h2>
						<strong>Ваш товар добавлен в корзину</strong>
					</h2>
					<a class="red-button close close-reveal-modal">Ок</a>
				</div>
			</div>
		</div>
	</div>
</div>
	
	

<!-- Footer -->
<?= $footer ?>

<script>
	$(document).ready(function() {			
		// Range Slider
		var minPrice = Number('<?= $possible_filters['min_price'] ?>');
		var maxPrice = Number('<?= $possible_filters['max_price'] ?>');
		
		function sliderSlide (ev, ui) {
			$('.ui-slider-handle').html('<div class="val_price">' + ui.values[0] + '</div>');
			$('.ui-slider-handle + .ui-slider-handle').html('<div class="val_price">' + ui.values[1] + '</div>');
			
			$('#filter input[name="filters[min_price]"]').val(ui.values[0]);
			$('#filter input[name="filters[max_price]"]').val(ui.values[1]);
		}
		
		$('#slider').slider({
			range: true,
			min: minPrice,
			max: maxPrice,
			values: [minPrice, maxPrice],	

			create: function (ev, ui) {
				$('.ui-slider-handle').html('<div class="val_price">' + minPrice + '</div>');
				$('.ui-slider-handle + .ui-slider-handle').html('<div class="val_price">' + maxPrice + '</div>');
			},
			slide: sliderSlide,
			stop: function(ev, ui) {
				$('.content').load(document.location.origin + document.location.pathname + ' .content .wrapper-content--filtered', $('#filter').serialize());
				
				// Load filters
				$('#filter .category__filter-manufacturers').load(document.location.origin + document.location.pathname + ' #filter .category__filter-manufacturers .wrapper-manufacturers--filtered', $('#filter').serialize());
				$('#filter .category__filter-years').load(document.location.origin + document.location.pathname + ' #filter .category__filter-years .wrapper-years--filtered', $('#filter').serialize());
			}		
		});
		
		
		
		// Range slider buttons
		$('body').delegate('.price_range .min', 'click', function() { 
			var values = [
				minPrice,
				Math.ceil(maxPrice/2)
			];	
			
			$('#slider').slider('values', values);
			sliderSlide(false, { values: values });
			$('.content').load(document.location.origin + document.location.pathname + ' .content .wrapper-content--filtered', $('#filter').serialize());
		});
		
		$('body').delegate('.price_range .middle', 'click', function() {	
			var values = [
				Math.ceil(maxPrice/4),
				Math.ceil(maxPrice/4*3)
			];
			
			$('#slider').slider('values', values);
			sliderSlide(false, { values: values });
			$('.content').load(document.location.origin + document.location.pathname + ' .content .wrapper-content--filtered', $('#filter').serialize());
		});
		
		$('body').delegate('.price_range .max', 'click', function() { 
			var values = [
				Math.ceil(maxPrice/2),
				maxPrice
			];
			
			$('#slider').slider('values', values);
			sliderSlide(false, { values: values });
			$('.content').load(document.location.origin + document.location.pathname + ' .content .wrapper-content--filtered', $('#filter').serialize());
		});
		
		

		// Handle changing of checkboxes
		$('#filter').delegate('input[type="checkbox"]', 'change', function() {
			var filterMinPrice = Number($('#filter').find('input[name="filters[min_price]"]').val());
			var filterMaxPrice = Number($('#filter').find('input[name="filters[max_price]"]').val());
			var filterData = $('#filter').serialize();
			var filter = $(this);
			
			// Load price filter
			$('#filter .price .price_range').load(document.location.origin + document.location.pathname + ' #filter .price .price_range', filterData, function(data) {
				// Fet new extermums
				minPrice = Number($(data).find('#filter .price .price_range .min').html())
				maxPrice = Number($(data).find('#filter .price .price_range .max').html())
				
				
				
				// Set new extermums
				$('#slider').slider('option', 'min', minPrice);
				$('#slider').slider('option', 'max', maxPrice);
				
				
				
				// Set new filter values
				var newFilterMinPrice = (filterMinPrice < minPrice ? minPrice : filterMinPrice);
				var newFilterMaxPrice = (filterMaxPrice > maxPrice ? maxPrice : filterMaxPrice);
				
				$('#slider').slider('values', [newFilterMinPrice, newFilterMaxPrice]);
				sliderSlide(false, { values: [newFilterMinPrice, newFilterMaxPrice] });
				
				
				
				// Fetch renewed data
				renewedFilterData = $('#filter').serialize();
				
				
				
				// Load content
				$('.content').load(document.location.origin + document.location.pathname + ' .content .wrapper-content--filtered', renewedFilterData);
				
				
				
				// Load manufacturers filter
				if (filter.attr('name') == 'filters[model][]') {
					$('#filter .category__filter-manufacturers').load(document.location.origin + document.location.pathname + ' #filter .category__filter-manufacturers .wrapper-manufacturers--filtered', renewedFilterData);
				}
				
				
				
				// Load years filter
				if (filter.attr('name') == 'filters[manufacturer][]') {
					$('#filter .category__filter-years').load(document.location.origin + document.location.pathname + ' #filter .category__filter-years .wrapper-years--filtered', renewedFilterData);
				}
			});
		});
		
		
		
		// Handle changing size 			
		$('body').delegate('.product_size_value', 'click', function() { 
			$(this).siblings().removeClass('active');
			$(this).addClass('active');
			
			
			// Recalculate price			
			var productId = $(this).data('product-id');
			var priceElement = $('span[data-product-id="' + productId + '"]');
			var regularPrice = makePriceNumber(priceElement.data('price'));
			var additionalPrice = makePriceNumber($(this).data('price'));
			var recalculatedPrice = regularPrice+additionalPrice;
			
			priceElement.html(makePriceString(recalculatedPrice));
		});
		
		// Recalculate prices immidiately
		$('.product_size_value.active').click();
		
		
		
		// Handle fast buy
		$('.fast_buy').bind('click', function() { 
			var product = JSON.parse(decodeURIComponent($(this).attr('data-product')));
			var salePercent = Number($(this).data('sale-percent'));
			
			// Set product id
			$('#fast-buy__popup input[name="product_id"]').val(product.product_id);
			
			// Set quantity
			$('#fast-buy__popup input[name="quantity"]').val(1);
			
			// Set main data
			$('#fast-buy__popup .fast-buy__title .upper').html(product.name);
			$('#fast-buy__popup .fast-buy__title .year').html(product.model);
			$('#fast-buy__popup .sidebar_goods .product_link').attr('href', product.href);
			$('#fast-buy__popup .sidebar_goods .img_container').css('background-image', 'url(' + product.thumb + ')');	
					
			
			if (salePercent > 0) {
				$('#fast-buy__popup .sidebar_goods .img_container').html('<div class="new">-' + salePercent + '%</div>');
			} else {
				$('#fast-buy__popup .sidebar_goods .img_container').html();
			}							
						
			if (product.special == 0 || product.special == '') { 
				$('#fast-buy__popup .price_red').attr('data-price', product.price).html(product.price);
				$('#fast-buy__popup .old_price').hide();
			} else {
				$('#fast-buy__popup .price_red').attr('data-price', product.special).html(product.special);
				$('#fast-buy__popup .old_price').html(product.price).show();
			}

			
			
			// Set option "size"
			if (typeof product.options.Размер !== 'undefined') {
				var activeSize = $('#options_product--' + product.product_id + ' .product_size_value.active').data('size');
				
				// Generate html
				var sizesHtml = '';				
				
				sizesHtml += '<label>Размер</label>';
				sizesHtml += '<ul class="sizes">';				
				
				$.each(product.options.Размер, function(index, productOptionSize) { 
					var activeClass = (activeSize == productOptionSize.option_value_id ? 'active' : '');
					
					// Set derfault value
					if (activeSize == productOptionSize.option_value_id) {
						$('#fast-buy__popup #option-size')
							.val(productOptionSize.option_value_id)
							.attr('name', 'option['+ productOptionSize.option_id + ']')
							.attr('disabled', false)
					}
					
					sizesHtml += '	<li data-input-field="#option-size" data-price="' + productOptionSize.option_value_price + '" class="' + activeClass + '" data-size="' + productOptionSize.option_value_id + '">';
					sizesHtml += '		<a>' + productOptionSize.option_value_name + '</a>';
					sizesHtml += '	</li>';
				});
				
				sizesHtml += '</ul>';

				
				// Insert html
				$('#fast-buy__popup .content_goods .product_sizes').html(sizesHtml).addClass('universal__line');
			} else {
				$('#fast-buy__popup .content_goods .product_sizes').html('').removeClass('universal__line');
				$('#fast-buy__popup #option-size').attr('disabled', true);
			}	
			
			
			
			// Set option "color"
			if (typeof product.options.Цвет !== 'undefined') {
				// Generate html
				var colorsHtml = '';
				
				colorsHtml += '<label>Цвет</label>';
				colorsHtml += '	<ul class="colors">';
				
				var iterator = 0;
				 
				$.each(product.options.Цвет, function(index, productOptionColor) { 
					var activeClass = (iterator == 0 ? 'class="active"' : '');
					var image = (productOptionColor.option_value_image != '' 
						? 'image/' + productOptionColor.option_value_image 
						: 'image/cache/no_image-50x50.jpg'
					);
					
					if (iterator == 0) {
						$('#fast-buy__popup #option-color')
							.val(productOptionColor.option_value_id)
							.attr('name', 'option['+ productOptionColor.option_id + ']')
							.attr('disabled', false)
					}
					
					colorsHtml += '	<li data-input-field="#option-color" data-price="' + productOptionColor.option_value_price + '" ' + activeClass + ' data-color="' + productOptionColor.option_value_id + '">';
					colorsHtml += '		<img src="' + image + '" alt="' + productOptionColor.option_value_name + '"/>';
					colorsHtml += '	</li>';
					
					iterator++;
				});
				
				colorsHtml += '	</ul>';
				
				
				
				// Insert html
				$('#fast-buy__popup .content_goods .product_colors').html(colorsHtml).addClass('universal__line');
			} else {
				$('#fast-buy__popup .content_goods .product_colors').html('').removeClass('universal__line');
				$('#fast-buy__popup #option-color').attr('disabled', true);
			}			
			
			
					
			// Set other options
			// console.log(product.options);

			var hiddenOptionsHtml = '';	
					
			$.each(product.options, function(optionName, optionValues) { 					
				if (optionName != 'Цвет' && optionName != 'Размер') {
					// console.log(optionValues);
					
									
					var optionIterator = 0;
					
					$.each(optionValues, function(optionValueId, optionValue) {
						if (optionIterator == 0) {						
							hiddenOptionsHtml += '<input data-product-entity="option" type="hidden" value="' + optionValue.option_value_id + '" name="option['+ optionValue.option_id + ']">';
						}
						
						optionIterator++;
					});
					
				}
				
				$('#fast-buy__popup .hidden_options').html(hiddenOptionsHtml);
			});
			
			
			
			
			
			// Add product possibilities
			$('#fast-buy__popup').Product({
				unitPrice: (product.special == 0 || product.special == '' ? product.price : product.special),
				quantity: 1
			});
			
			
			
			// Show modal
			$('#fast-buy__popup').fadeIn('fast');
			$('body').css('overflow-y', 'hidden');
			
			// Hide modal possibility
			$('#fast-buy__popup .close').bind('click', function() {
				$('#fast-buy__popup').fadeOut('fast');
				$('body').css('overflow-y', 'visible');
			});
		});
	});
</script>
