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
				<div class="line s1">
					<div class="line_text">Рейтинг</div>
					<div class="line_points">
						<ul class="stars">
							<li class="starhover"><img class="<?php if ($rating > 0) { echo 'red'; } else { echo 'blue'; } ?>" src="img/star_<?php if ($rating > 0) { echo 'red'; } else { echo 'blue'; }  ?>.png" alt=""></li>
							<li class="starhover"><img class="<?php if ($rating > 1) { echo 'red'; } else { echo 'blue'; } ?>" src="img/star_<?php if ($rating > 1) { echo 'red'; } else { echo 'blue'; }  ?>.png" alt=""></li>
							<li class="starhover"><img class="<?php if ($rating > 2) { echo 'red'; } else { echo 'blue'; } ?>" src="img/star_<?php if ($rating > 2) { echo 'red'; } else { echo 'blue'; }  ?>.png" alt=""></li>
							<li class="starhover"><img class="<?php if ($rating > 3) { echo 'red'; } else { echo 'blue'; } ?>" src="img/star_<?php if ($rating > 3) { echo 'red'; } else { echo 'blue'; }  ?>.png" alt=""></li>
							<li class="starhover"><img class="<?php if ($rating > 4) { echo 'red'; } else { echo 'blue'; } ?>" src="img/star_<?php if ($rating > 4) { echo 'red'; } else { echo 'blue'; }  ?>.png" alt=""></li>
							<li>
								<span data-title="цена только за купол" class="imgContainer">
									<a href="" class="i"><img src="img/i.png" alt=""></a>
								</span>
							</li>
						</ul>
					</div>
				</div>

		  <?php if ($options) { ?>
		  <div class="main options">
			<?php foreach ($options as $option) { ?>

				<?php if ($option['name'] == 'Размер') { ?>
				<div class="main line s2">
					<div class="line_text"><?php echo $option['name']; ?></div>
					<div class="line_points">
						
					<!-- Real option -->
					<input 
						id="option-size"
						type="hidden" 
						name="option[<?= $option['product_option_id']; ?>]" 
						value="<?= $option['option_value'][0]['name']; ?>"
					>

					<!-- Cute selector -->
					<ul class="sizes">
					<?php
						foreach ($option['option_value'] as $i=>$option_value) { ?>
						<li>
							<a 
								href="#"
								class="<?= $i==0 ? "active" : "" ?>"
								price="<?= intval(substr(str_replace(' ', '', $option_value['price']), 0, strpos(str_replace(' ', '', $option_value['price']), 'р'))); ?>"
								data-size="<?= $option_value['product_option_value_id']; ?>"
							>
								<?= $option_value['name']; ?>
							</a>
						</li>
						<?php } ?>
					</ul>
				</div>
		   </div>
				<?php } else if ($option['name'] == 'Цвет') { ?>
		<div style="display: none;">
					<div class="line_text"><?php echo $option['name']; ?></div>
					<div class="line_points">
							<ul class="colors">
					<?php $i = 1; foreach ($option['option_value'] as $option_value) { ?>
					<li><div class="c<?php echo $i; if ($i == 1) { echo ' active'; } $i++; ?>"><?php echo substr($option_value['name'], 0, strpos($option_value['name'], 'm2')); ?><div class="triangle"></div></div></li>
					<?php } ?>
							</ul>

				  <select class="currentsel" style="display: none;padding:1px;" name="option[<?php echo $option['product_option_id']; ?>]">
					<option value=""><?php echo $text_select; ?></option>
					<?php foreach ($option['option_value'] as $option_value) { ?>
					<option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
					<?php if ($option_value['price']) { ?>
					(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
					<?php } ?>
					</option>
					<?php } ?>
				  </select>

				  <?php foreach ($option['option_value'] as $option_value) { ?>
					<input type="hidden" class="opt_thumb_<?php echo $option_value['product_option_value_id']; ?>" value="<?=$option_value['thumb'];?>">
					<input type="hidden" class="opt_popup_<?php echo $option_value['product_option_value_id']; ?>" value="<?=$option_value['popup'];?>">
				  <?php } ?>

				</div>
		   </div>
				<?php } ?>

			<?php } //foreach?>

			</div>
		  <?php } //if options ?>

				<div class="main how_much">
					<div class="tri_btn up"></div>
					<div class="tri_btn low"></div>
					<input type="text" name="quantity" id="quantity-opt" value="1">
		<?php if (!$special) { ?>
					<span class="main price_red"><?php echo $price; ?></span>
			<div class="mainrealprice"><?php echo intval(substr(str_replace(' ', '', $price), 0, strpos(str_replace(' ', '', $price), 'р'))); ?></div>
					<span data-title="цена только за купол" class="imgContainer">
						<a href="" class="i"><img src="img/i.png" alt=""></a>
					</span>
		<?php } else { ?>
					<span class="main price_red"><?php echo $special; ?></span>
			<div class="mainrealprice"><?php echo intval(substr(str_replace(' ', '', $special), 0, strpos(str_replace(' ', '', $special), 'р'))); ?></div>
					<span data-title="цена только за купол" class="imgContainer">
						<a href="" class="i"><img src="img/i.png" alt=""></a>
					</span>
					<span class="old_price"><?php echo $price; ?></span>
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


				<div class="itogo">
					<h1>Итого: <span class="price_red">90 500 p.</span>
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
		data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
		dataType: 'json',
		success: function(json) {
			console.log(json);
			
			$('.success, .warning, .attention, information, .error').remove();
			
			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
					}
				}
			} 
			
			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
				$('.success').fadeIn('slow');
					
				$('#cart-total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
			}	
		},
		error: function(response) {
			console.log(response);
		}
	});
});
//--></script>


<?php echo $footer; ?>
