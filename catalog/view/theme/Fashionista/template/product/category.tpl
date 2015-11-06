<?php
// Init Helper for sorting
require "category_helper.php";

// Info about current url
$url = getUrlParts($this);

// Set info about possible sorts
$possible_sorts = getPossibleSorts($this, $sort, $order);

// Get page
$page = (isset($this->request->get['page']) ? $this->request->get['page'] : 1);

// Apply filters
$applied_filters = (!empty($this->request->get['filters']) ? $this->request->get['filters'] : null);

if (!empty($applied_filters)) {	
	$filtered_products = applyFilters($this, $applied_filters);
	
	// Re-render pagination	
	$pagination = new Pagination();
	$pagination->total = count($filtered_products);
	$pagination->page = $page;
	$pagination->limit = $limit;
	$pagination->text = $this->language->get("text_pagination");
	$pagination->url = $url['root']  . "?" .  http_build_query(['filters'=>$applied_filters]) . $url['sort'] . $url['order'] . $url['limit'] . "&page={page}";
	$pagination = $pagination->render();
}

// Manually sort
$sorted_products = sortBy($sort, $order, $this, (!empty($filtered_products) ? $filtered_products : null));

// Prepare page products
$products = array_slice(prepareProducts($this, $sorted_products), ($page-1)*$limit, $limit);

// Get info about possible filters
$possible_filters = getPossibleFilters($this, $applied_filters);

// Use siblings instead of children in category doesn't has children
$categories = (!empty($categories) ? $categories : getSiblingCategories($this));
?>




<!-- Header -->
<?= $header ?>

<div class="main-wrapper">
	<main class="padding_wrapper">
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
		
		<!-- Left Sidebar -->
		<div class="sidebar">
			<!-- Subcategories menu -->
			<?php if (!empty($categories)) { ?>
				<div class="goods">
					<ul>				
						<?php foreach ($categories as $category) { ?>
							<li>
								<a href="<?= $category['href'] ?>"><?= $category['name'] ?></a>
							</li>
						<?php } ?>
					</ul>
				</div>
			<?php } ?>
			
			<!-- Filter-->
			<form id="filter" method="GET" action="<?= $url['root'] ?>">
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
								<div class="middle"><?= ceil($possible_filters['max_price']/2) ?></div>
								<div class="max"><?= $possible_filters['max_price'] ?></div>
							</div>
						</div>
					</div>
				</div>
				
				
				<div class="producers inputs">
					<h1>
						Производители <div class="tri second"></div>
					</h1>
					<ul class="list1">
						<?php foreach ($possible_filters['manufacturers'] as $manufacturer) { ?>
							<li>
								<input 
									class="manufacturer_value <?= $manufacturer['is_applied'] ? "filtered" : "" ?>"
									type="checkbox" 
									name="filters[manufacturer][]"
									value="<?= $manufacturer['id'] ?>"
									<?= $manufacturer['is_applied'] ? "checked" : "" ?>
								> 
								<label><?= $manufacturer['title'] ?> (<?= $manufacturer['quantity'] ?>)</label>
							</li>
						<?php } ?>
					</ul>
				</div>
				
				
				<div class="year inputs">
					<h1>
						Года <div class="tri third"></div>
					</h1>
					<ul class="list2">
						<?php foreach ($possible_filters['models'] as $model) { ?>
							<li>
								<input 
									class="model_value <?= $model['is_applied'] ? "filtered" : "" ?>"
									type="checkbox" 
									name="filters[model][]"
									value="<?= $model['name'] ?>"
									<?= $model['is_applied'] ? "checked" : "" ?>
								> 
								<label><?= $model['year'] ?> (<?= $model['quantity'] ?>)</label>
							</li>
						<?php } ?>
					</ul>
				</div>
			</form>			
		</div>
		
		<!-- Content -->
		<div class="content">
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

							<div class="universal__cell product__cell">
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
										<span class="upper"><?= $product['name']; ?></span>
									</a>
								</h2>
								
								<div class="universal__line category__size">
									<ul class="category__size-line">
										<p>выберите размер</p>
										<li>1</li>
										<li>2</li>
										<li class="active">2</li>
										<li>1</li>
										<li>33</li>
										<li>1</li>
										<li>1</li>
									</ul>
								</div>
								
								<p class="price">
										<span class="red"><?= !empty($product['special']) ? $product['special'] : $product['price'] ?></span>							
									<?php if (!empty($product['special'])) { ?>
										<span class="old"><?= $product['price']; ?></span>
									<?php } ?>
									
										<span class="buy">Купить</span>
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
	</main>
</div>

<!-- Footer -->
<?= $footer; ?>

<script>
	$(document).ready(function() {	
		// Handle changing of checkboxes
		$('#filter input[type="checkbox"]').bind('change', function() {
			$('.content').load(document.location.origin + document.location.pathname + ' .content', $('#filter').serialize());
		});
		
		
		// Range Slider
		var minPrice = '<?= $possible_filters['min_price'] ?>';
		var maxPrice = '<?= $possible_filters['max_price'] ?>';
		
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
				$('.content').load(document.location.origin + document.location.pathname + ' .content', $('#filter').serialize());
			}		
		});
		
		
		// Range slider buttons
		$('.price_range .min').bind('click', function() { 
			var values = [
				minPrice,
				Math.ceil(maxPrice/2)
			];	
			
			$('#slider').slider('values', values);
			sliderSlide(false, { values: values });
			$('.content').load(document.location.origin + document.location.pathname + ' .content', $('#filter').serialize());
		});
		
		console.log(minPrice);
		$('.price_range .middle').bind('click', function() { 	
			var values = [
				Math.ceil(maxPrice/4),
				Math.ceil(maxPrice/4*3)
			];
			
			$('#slider').slider('values', values);
			sliderSlide(false, { values: values });
			$('.content').load(document.location.origin + document.location.pathname + ' .content', $('#filter').serialize());
		});
		
		$('.price_range .max').bind('click', function() { 
			var values = [
				Math.ceil(maxPrice/2),
				maxPrice
			];
			
			$('#slider').slider('values', values);
			sliderSlide(false, { values: values });
			$('.content').load(document.location.origin + document.location.pathname + ' .content', $('#filter').serialize());
		});
	});
</script>
