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
<main>

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

	                    <ul class="sizes">
				<?php   $fst = true;
					foreach ($option['option_value'] as $option_value) { ?>
				<li><a href=""<?php if ($fst) { $fst = false; echo ' class="active"'; } ?> name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" price="<?php echo intval(substr(str_replace(' ', '', $option_value['price']), 0, strpos(str_replace(' ', '', $option_value['price']), 'р'))); ?>"><?php echo $option_value['name']; ?></a></li>
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
                    <input type="submit" value="В корзину" class="btn_buy">
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

</main>
</div>

<?php echo $footer; ?>


<!-- Модальное окно "Вопрос"-->
<div id="modal_reg" class="modal_reg">
    <h1>Регистрация
        <div class="modal_reg_close" id="modal_reg_close">
            <img src="img/close.png" alt="">
        </div>
    </h1>
    <form action="" method="POST">
        <ul class="social">
            <li><span>зарегистрироваться через:</span></li>
            <li><a href="">Facebook</a></li>
            <li><span>|</span></li>
            <li><a href="">Вконтакте</a></li>
            <li><span>|</span></li>
            <li><a href="">Google</a></li>
        </ul>
        <ul class="reg_inputs">
            <li><label for="mail">E-mail</label><input type="text" id="mail"></li>
            <li><label for="fio">Имя / ФИО</label><input type="text" id="fio"></li>
            <li><label for="tel">Телефон</label><input type="text" id="tel"></li>
            <div></div>
            <li><label for="log">Логин</label><input type="text" id="log"></li>
            <li><label for="pass">Пароль</label><input type="text" id="pass"></li>
        </ul>

        <input type="submit" value="Зарегистрироваться">
    </form>
</div>
<div id="modal_reg_overlay" class="modal_reg_overlay"></div>
<!-- Конец модального окна -->




<div class="white_bg" style="display: none;">
	<div class="container">


<div id="main_column_st">
			<?php if(count($images) > 2) { ?>
	  <a href="#" class="arr_left"></a>
	  <a href="#" class="arr_right"></a>
	  <?php } ?>
		 
	</div>
	
	<div class="product-desc">
				<span class="wishes"><a onclick="addToWishList('<?php echo $product_id; ?>'); return false" href="#"><?php echo $this->language->get('text_wish'); ?></a><p>
		  <a onclick="addToCompare2('<?php echo $product_id; ?>'); return false" href="#"><?php echo $this->language->get('text_compare'); ?></a></p><br />		  
		  </span>
	  <div class="description c1_color">
		<h2 class="c1_color b1c-name"><!--<?php echo $heading_title; ?>--></h2>
		<?php if ($manufacturer) { ?>
		<span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a><br />
		<?php } ?>
		<span><?php echo $text_model; ?></span> <?php echo $model; ?><br />
		<!-- <span><?php echo $text_reward; ?></span> <?php echo $reward; ?><br /> 
		<span><?php echo $text_stock; ?></span> <?php echo $stock; ?> --> </div>
	  <?php if ($price) { ?>
	  <div class="price c1_color">
		<?php if (!$special) { ?>
		<span class="c1 product-price" style="padding:6px"><span style="color:#ffffff;" id="opu_price"><?php echo $price; ?></span></span>
		<?php } else { ?>
		 <span class="c1 product-price" style="padding:6px"><span style="color:#ffffff;" id="opu_special"><?php echo $special; ?></span></span> <strike><?php echo $price; ?></strike> |
		 <? if($percent){?>
			<span class="percent_span" title="Скидка в процентах"><?=$percent;?>%</span>
		 <?}?>
		<?php } ?>

	   <!-- <?php if ($tax) { ?>
		<span class="price-tax"><small><?php echo $text_tax; ?> <?php echo $tax; ?></small></span>
		<?php } ?> -->
	   <!-- <?php if ($points) { ?>
		| <span class="reward"><small><?php echo $text_points; ?> <?php echo $points; ?></small></span> <br />
		<?php } ?> -->
		<?php if ($discounts) { ?>
<br />
		<span class="discount">
			<ul>
		  <?php foreach ($discounts as $discount) { ?>
		  <li><?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?></li>
		  <?php } ?>
		  </ul>
		</span>
		<?php } ?>
		<div class="cart-adding">
			
			<div class="cart-adding_1">
		<?php // echo $text_qty; ?>
		  <input type="text" name="quantity" size="2" id="quantity-opt" value="<?php echo $minimum; ?>" />
		  <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
		  &nbsp;</div>
		 		
			
				
				
		  <div class="button c4" style="margin-right:10px"><a id="button-cart" href="#"><span><?php echo $this->language->get('text_addtocart'); ?></span></a></div>
			<div style="clear:both"></div>
	<div class="button c4 b1c" style="margin-right:10px;width: 115px;float: right;  margin-top: 5px;"><a style="width: 115px;"  href="#">Купить сейчас</a></div>
	
			
			 
			
		<?php if ($minimum > 1) { ?>
		<div style="clear:both; padding-top:20px; margin-left:30px;"><?php echo $text_minimum; ?></div>
		<?php } ?>
		
	  </div>
	  </div>
	  <?php } ?>
	<?php if ($accessories) { ?>
              <div style="border-bottom: 1px solid #E7E7E7;color: #4D4D4D;margin-bottom: 20px;overflow: auto;">
              <strong><?php echo $text_accessories; ?></strong>
		      <table style="width: 100%;">
		        <?php $has_required = false;?>
		      	<?php foreach ($accessories as $accessory) { ?>
		        <?php if ($accessory['required'] == '1') $has_required = true;?>
		        <tr>
		          <td align="left" valign="top" style="padding:2px;border-bottom:1px dotted #DDDDDD;">
		            <a href="<?php echo $accessory['popup']; ?>" title="<?php echo $accessory['name']; ?>" class="colorbox" rel="colorbox_accessory"><img src="<?php echo $accessory['image']; ?>" title="<?php echo $accessory['name']; ?>" alt="<?php echo $accessory['name']; ?>" /></a>
		          </td>
		          <td valign="top" style="padding:2px 0;border-bottom:1px dotted #DDDDDD;"><?php echo ($accessory['required'] == '0') ? "" : '*';?></td>		          
		          <td valign="top" align="left" style="padding:2px;border-bottom:1px dotted #DDDDDD;">
		            <a class="colorbox-popup cboxElement" href="<?php echo $accessory['href_description']; ?>"><?php echo $accessory['name']; ?></a>
				<!-- options -->
				  <?php if (isset($accessory_options[$accessory['product_id']])) { ?>
				  <div class="options accessory" style="background-image:none">
					<?php foreach ($accessory_options[$accessory['product_id']] as $option) { ?>
					<?php if ($option['type'] == 'select') { ?>
					<div id="option-<?php echo $accessory['product_id']; ?>-<?php echo $option['product_option_id']; ?>" class="option"  style="background-image:none">
					  <?php if ($option['required']) { ?>
					  <span class="required">*</span>
					  <?php } ?>
					  <b><?php echo $option['name']; ?>:</b>
					  <select style="padding:1px;" name="accessory_option[<?php echo $accessory['product_id']; ?>][<?php echo $option['product_option_id']; ?>]" onchange="getDiscount(<?php echo $accessory['product_id'];?>);;" >
						<option value=""><?php echo $text_select; ?></option>
						<?php foreach ($option['option_value'] as $option_value) { ?>
						<option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
						<?php if ($option_value['price']) { ?>
						(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
						<?php } ?>
						</option>
						<?php } ?>
					  </select>
					</div>
					<?php } ?>
					<?php if ($option['type'] == 'radio') { ?>
					<div id="option-<?php echo $accessory['product_id']; ?>-<?php echo $option['product_option_id']; ?>" class="option">
					  <?php if ($option['required']) { ?>
					  <span class="required">*</span>
					  <?php } ?>
					  <b><?php echo $option['name']; ?>:</b><br />
					  <?php foreach ($option['option_value'] as $option_value) { ?>
					  <input type="radio" name="accessory_option[<?php echo $accessory['product_id']; ?>][<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $accessory['product_id']; ?>-<?php echo $option_value['product_option_value_id']; ?>" />
					  <label for="option-value-<?php echo $accessory['product_id']; ?>-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
						<?php if ($option_value['price']) { ?>
						(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
						<?php } ?>
					  </label>
					  <br />
					  <?php } ?>
					</div>
					<?php } ?>
					<?php if ($option['type'] == 'checkbox') { ?>
					<div id="option-<?php echo $accessory['product_id']; ?>-<?php echo $option['product_option_id']; ?>" class="option">
					  <?php if ($option['required']) { ?>
					  <span class="required">*</span>
					  <?php } ?>
					  <b><?php echo $option['name']; ?>:</b><br />
					  <?php foreach ($option['option_value'] as $option_value) { ?>
					  <input type="checkbox" name="accessory_option[<?php echo $accessory['product_id']; ?>][<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $accessory['product_id']; ?>-<?php echo $option_value['product_option_value_id']; ?>" />
					  <label for="option-value-<?php echo $accessory['product_id']; ?>-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
						<?php if ($option_value['price']) { ?>
						(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
						<?php } ?>
					  </label>
					  <br />
					  <?php } ?>
					</div>
					<?php } ?>
					<?php if ($option['type'] == 'image') { ?>
					<div id="option-<?php echo $accessory['product_id']; ?>-<?php echo $option['product_option_id']; ?>" class="option">
					  <?php if ($option['required']) { ?>
					  <span class="required">*</span>
					  <?php } ?>
					  <b><?php echo $option['name']; ?>:</b><br />
					  <table class="option-image">
						<?php foreach ($option['option_value'] as $option_value) { ?>
						<tr>
						  <td style="width: 1px;"><input type="radio" name="accessory_option[<?php echo $accessory['product_id']; ?>][<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $accessory['product_id']; ?>-<?php echo $option_value['product_option_value_id']; ?>" /></td>
						  <td><label for="option-value-<?php echo $accessory['product_id']; ?>-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></td>
						  <td><label for="option-value-<?php echo $accessory['product_id']; ?>-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
							  <?php if ($option_value['price']) { ?>
							  (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
							  <?php } ?>
							</label></td>
						</tr>
						<?php } ?>
					  </table>
					</div>
					<?php } ?>
					<?php if ($option['type'] == 'text') { ?>
					<div id="option-<?php echo $accessory['product_id']; ?>-<?php echo $option['product_option_id']; ?>" class="option">
					  <?php if ($option['required']) { ?>
					  <span class="required">*</span>
					  <?php } ?>
					  <b><?php echo $option['name']; ?>:</b><br />
					  <input type="text" name="accessory_option[<?php echo $accessory['product_id']; ?>][<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
					</div>
					<?php } ?>
					<?php if ($option['type'] == 'textarea') { ?>
					<div id="option-<?php echo $accessory['product_id']; ?>-<?php echo $option['product_option_id']; ?>" class="option">
					  <?php if ($option['required']) { ?>
					  <span class="required">*</span>
					  <?php } ?>
					  <b><?php echo $option['name']; ?>:</b><br />
					  <textarea name="accessory_option[<?php echo $accessory['product_id']; ?>][<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
					</div>
					<?php } ?>
					<?php if ($option['type'] == 'file') { ?>
					<div id="option-<?php echo $accessory['product_id']; ?>-<?php echo $option['product_option_id']; ?>" class="option">
					  <?php if ($option['required']) { ?>
					  <span class="required">*</span>
					  <?php } ?>
					  <b><?php echo $option['name']; ?>:</b><br />
					  <input type="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $accessory['product_id']; ?>-<?php echo $option['product_option_id']; ?>" class="button">
					  <input type="hidden" name="accessory_option[<?php echo $accessory['product_id']; ?>][<?php echo $option['product_option_id']; ?>]" value="" />
					</div>
					<?php } ?>
					<?php if ($option['type'] == 'date') { ?>
					<div id="option-<?php echo $accessory['product_id']; ?>-<?php echo $option['product_option_id']; ?>" class="option">
					  <?php if ($option['required']) { ?>
					  <span class="required">*</span>
					  <?php } ?>
					  <b><?php echo $option['name']; ?>:</b><br />
					  <input type="text" name="accessory_option[<?php echo $accessory['product_id']; ?>][<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
					</div>
					<?php } ?>
					<?php if ($option['type'] == 'datetime') { ?>
					<div id="option-<?php echo $accessory['product_id']; ?>-<?php echo $option['product_option_id']; ?>" class="option">
					  <?php if ($option['required']) { ?>
					  <span class="required">*</span>
					  <?php } ?>
					  <b><?php echo $option['name']; ?>:</b><br />
					  <input type="text" name="accessory_option[<?php echo $accessory['product_id']; ?>][<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
					</div>
					<?php } ?>
					<?php if ($option['type'] == 'time') { ?>
					<div id="option-<?php echo $accessory['product_id']; ?>-<?php echo $option['product_option_id']; ?>" class="option">
					  <?php if ($option['required']) { ?>
					  <span class="required">*</span>
					  <?php } ?>
					  <b><?php echo $option['name']; ?>:</b><br />
					  <input type="text" name="accessory_option[<?php echo $accessory['product_id']; ?>][<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
					</div>
					<?php } ?>
					<?php } ?>
				  </div>
				  <?php } ?>					
				<!-- end options -->
		          </td>
		          <td valign="top" align="right" style="padding:2px;border-bottom:1px dotted #DDDDDD;">
		            <?php if ($price) { ?>
					<?php if (!$accessory['special']) { ?>
		            <span id="acce<?php echo $accessory['product_id'];?>" ><?php echo $accessory['price']; ?></span>
		            <?php } else { ?>
		            <span style="text-decoration: line-through;"><?php echo $accessory['price']; ?></span> <span style="color: #F00;"><?php echo $accessory['special']; ?></span>
		            <?php } ?>
			        <?php if ($accessory['discounts'] && !$accessory['special']) { ?>
			        <br />
			        <div style="font-size:11px; color:#999;">
			          <?php foreach ($accessory['discounts'] as $discount) { ?>
			          <?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
			          <?php } ?>
			        </div>
			        <?php } ?>
					<?php } ?>		            
		          </td>
		          <td valign="top" align="right" style="white-space:nowrap;padding:2px;border-bottom:1px dotted #DDDDDD;" >
					<?php echo $text_qty; ?>
		          	<input type="text" name="accessories[<?php echo $accessory['product_id'];?>]" id="accessories[<?php echo $accessory['product_id'];?>]" onclick="this.select();" onkeyup="getDiscount(<?php echo $accessory['product_id'];?>, this.value);;" size="2" style="width:20px;" value="<?php echo ($accessory['required']) ? $accessory['minimum'] : 0; ?>" />
		          	<input type="hidden" name="accessories_values[<?php echo $accessory['product_id'];?>]" id="accessories_values[<?php echo $accessory['product_id'];?>]" 
	class="accessories_values<?php echo $accessory['product_id'];?>" 	          	value="<?php echo ($accessory['special_value']) ? $accessory['special_value'] : $accessory['price_value'];?>" />
			        <?php if ($accessory['minimum'] > 1) { ?>
			        <br /><span style="font-size:11px; color:#999;"><?php echo sprintf($this->language->get('text_minimum_qty_accessory'), $accessory['minimum']); ?></span>
			        <?php } ?>
		          </td>		          
		        </tr>
		        <?php } ?>
				<?php if ($price) { ?>

		        <tr>
		        	<td colspan="4" align="right" style="color: #666; font-weight: bold;"><?php echo $text_total_geral;?></td>
		        	<td align="right"><?php echo $simbol_left; ?><span id="total_geral" style="font-weight: bold;"><?php echo ($special) ? $special_value : $price_value; ?></span><?php if(!empty($accessory_options)){ echo $text_plus_options; }?></td>		        
		        </tr>
				<?php } ?>
		        <tr><td colspan="5" style="font-size: 11px; color:#999;" align="right"><?php echo ($has_required) ? $text_accessory_required : '';?></td></tr>
				<tr><td colspan="5" id="accessory_msg"></td></tr>
		      </table>
		      </div>
		      <?php } ?>
              
			  <input type="hidden" name="price_value" id="price_value" value="<?php echo ($special_value) ? $special_value : $price_value; ?>" />
              <input type="hidden" name="accessories_ids" id="accessories_ids" value="<?php echo implode('.', $accessories_ids); ?>" />
	  <?php if ($review_status) { ?>
	  <div class="review" style="background-image:none">
		<img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />&nbsp;&nbsp;<a href="#" class="open-review"><?php echo $reviews; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" class="open-review"><?php echo $text_write; ?></a>
	  </div>
	  <?php } ?>
	</div>
		  
	  
  <div class="c"></div>
 
  <div class="otz_container" align="center">

<div class="otz-nav-c" style="text-align:middle;">
	<?php if( $vkladkas) { ?>
	<a style="box-shadow:0px 4px 5px 0px rgba(50, 50, 52, 0.53);" href="#" rel="tab-video" class="checkout-heading"><?php echo $vkladka; ?></a>
	<?}?>
  <?php $attribute_groups_copy = $attribute_groups;?> 
	<?php
		foreach($attribute_groups as $key => $value){
			if($value['attribute_group_id'] == 11){
				unset($attribute_groups[$key]);
			}
		}
	?>
	<?php
	
		foreach($attribute_groups_copy as $key => $value){
			if($value['attribute_group_id'] == 11){
				foreach($attribute_groups_copy[$key]['attribute'] as $key_val => $value_val){ ?>
					<? if(trim($value_val['text']) AND $value_val['attribute_id'] == 29){?>
					<a style="box-shadow:0px 4px 5px 0px rgba(50, 50, 52, 0.53);" href="#" rel="attr-<?=$value_val['attribute_id']?>" class="checkout-heading"><?php echo $value_val['name']; ?></a>		
					<?}?>					
				<?}		
			}
		}
	?>
	<? if(trim(strip_tags($description))){?>
	<a style="box-shadow:0px 4px 5px 0px rgba(50, 50, 52, 0.53);" href="#" rel="tab-description" class="checkout-heading"><span><?php echo $tab_description; ?></span></a>
	<?}?>
	
	<?
	
		foreach($attribute_groups_copy as $key => $value){
			if($value['attribute_group_id'] == 11){
				foreach($attribute_groups_copy[$key]['attribute'] as $key_val => $value_val){ ?>
					<? if(trim($value_val['text']) AND $value_val['attribute_id'] != 29){?>
					<a style="box-shadow:0px 4px 5px 0px rgba(50, 50, 52, 0.53);" href="#" rel="attr-<?=$value_val['attribute_id']?>" class="checkout-heading"><?php echo $value_val['name']; ?></a>		
					<?}?>					
				<?}		
			}
		}
	?>
	
	<? if ($attribute_groups) { ?>
		<a style="box-shadow:0px 4px 5px 0px rgba(50, 50, 52, 0.53);" href="#" rel="tab-attr" class="checkout-heading"><?php echo $tab_attribute; ?></a>
	<? } ?>
	
	<?php if ($this->config->get('wp_vkcomment_status')==1) { ?>
	<a style="box-shadow:0px 4px 5px 0px rgba(50, 50, 52, 0.53);" href="#" rel="tab-vkcomment" class="checkout-heading">Комментарии</a> 
	<?php } ?>
	<?php if ($review_status) { ?>
		<a style="box-shadow:         0px 4px 5px 0px rgba(50, 50, 52, 0.53);" href="#" rel="tab-review" class="checkout-heading"><?php echo $tab_review; ?></a>
	<?}?>

	</div>
	<div class="checkout-content" id="tab-description"><br /><?php echo $description; ?></div>
	
	<?
	
		foreach($attribute_groups_copy as $key => $value){
			if($value['attribute_group_id'] == 11){
				foreach($attribute_groups_copy[$key]['attribute'] as $key_val => $value_val){ ?>
					<div class="checkout-content" id="attr-<?=$value_val['attribute_id']?>"><br />
					<? if($value_val['attribute_id'] == 29){ // видео ?>
						<?php $video_array = explode("\n",$value_val['text']); ?>
						<? foreach($video_array as $video_array_val){?>
							<p align="center"><iframe width="560" height="315" src="http://www.youtube.com/embed/<?=$video_array_val;?>" frameborder="0" allowfullscreen></iframe></p>
						<?}?>
					<? }elseif($value_val['attribute_id'] == 36){ // pdf ?>
						<?php $pdf_array = explode("\n",$value_val['text']); ?>
						<? foreach($pdf_array as $pdf_array_val){?>
							<a target="_blank" href="<?=$pdf_array_val;?>"><?=$pdf_array_val;?></a><br/>
						<?}?>
					<? }else{?>
						<?php echo nl2br($value_val['text']) ?>
					<?}?>					
					</div>							
				<?}		
			}
		}
	?>
	
   
   
	
	  <?php if ($this->config->get('wp_vkcomment_status')==1 || $this->config->get('wp_fbcomment_status')==1 && empty($wp_fbcomment_nametab)) { ?>
	<div id="tab-vkcomment" class="checkout-content">
 
<br />
<table width="100%">
<tr>
<td width="50%">

<?php echo $vkcomment_output.'<br /><br />'; 
	if ($this->config->get('wp_fbcomment_status')==1 && empty($wp_fbcomment_nametab)) echo $fbcomment_output; ?>
	
	<?php } ?>
</td>
<td width="50%">


  <?php if ($this->config->get('wp_fbcomment_status')==1 && !empty($wp_fbcomment_nametab)) { ?>
	<?php echo $fbcomment_output; ?>
</td>   
</tr>
</table>

	</div>
  
  
	
	
	
	
  <?php } ?>
	
	<?php if ($attribute_groups) { ?>
	
	<div id="tab-attr" class="checkout-content">
		<br />
		<table class="attribute" width="100%">
		  <?php foreach ($attribute_groups as $attribute_group) { ?>
		  <thead>
			<tr>
			  <td colspan="2"><?php echo $attribute_group['name']; ?></td>
			</tr>
		  </thead>
		  <tbody>
			<?php foreach ($attribute_group['attribute'] as $attribute) { ?>
			<tr>
			  <td width="50%"><?php echo $attribute['name']; ?></td>
			  <td width="50%"><?php echo $attribute['text']; ?></td>
			</tr>
			<?php } ?>
		  </tbody>
		  <?php } ?>
		</table>
	  </div>
	<?php } ?>

	
	<?php if ($review_status) { ?>
	
	  <div id="tab-review" class="checkout-content">
		<br /><div id="review"></div><br />
		<h2 id="review-title" class="c1_color"><?php echo $text_write; ?></h2>
		<b><?php echo $entry_name; ?></b><br />
		<input type="text" name="name" value="" />
		<br />
		<br />
		<div><?php echo $entry_review; ?></div>
		<textarea name="text" cols="40" rows="8" style="width: 98%;"></textarea>
		<span style="font-size: 11px;"><?php echo $text_note; ?></span><br />
		<br />
		<b><?php echo $entry_rating; ?></b> <span><?php echo $entry_bad; ?></span>&nbsp;
		<input type="radio" name="rating" value="1" />
		&nbsp;
		<input type="radio" name="rating" value="2" />
		&nbsp;
		<input type="radio" name="rating" value="3" />
		&nbsp;
		<input type="radio" name="rating" value="4" />
		&nbsp;
		<input type="radio" name="rating" value="5" />
		&nbsp; <span><?php echo $entry_good; ?></span><br />
		<br />
		<b><?php echo $entry_captcha; ?></b><br />
		<input type="text" name="captcha" value="" />
		<br /><br />
		<img src="<?php echo HTTP_SERVER; ?>index.php?route=product/product/captcha" alt="" id="captcha" /><br />
		<br />
	
		  <div class="button c1"><a id="button-review" href="#"><span><?php echo $button_continue; ?></span></a></div>
	<div class="c"></div>
	  </div>
	<?php } ?>
		  <div id="tab-video" class="checkout-content">
		<br />
	<?php echo $vkladkas; ?>
	<div class="c"></div>
	  </div>
	
<div class="c"></div>

<?php if($products) { ?>
<div class="featured_cont">
<div class="featured">
	<h1 class="c1_color"><?php echo $tab_related; ?></h1>
	<?php if(count($products)  > 5) { ?>
	<a href="#" class="arr_left c1"></a>
	<a href="#" class="arr_right c1"></a>
	<?php } else { ?>

	<?php } ?>
<ul <?php if(count($products)  < 6) { echo 'style="left:0"'; } ?>>
	  <?php foreach ($products as $product) { ?>
	  <li>
			<?php if ($product['thumb']) { ?>
			<a href="<?php echo $product['href']; ?>" class="thumb"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
			<?php } ?>
			<a href="<?php echo $product['href']; ?>" class="name"><?php echo $product['name']; ?></a>
			<?php if ($product['price']) { ?>

			  <?php if (!$product['special']) { ?>
			  <span class="price-new"><?php echo $product['price']; ?></span>
			  <?php } else { ?>
			  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
			  <?php } ?>

			<?php } ?>

	  </li>
	  <?php } ?>
</ul>
</div>
</div>
  <?php } ?>
  
  
  </div>


  <?php if ($tags) { ?><br /><br />
	<h2 class="c1_color"><?php echo $text_tags; ?></h2>
  <div class="tags">
	<?php foreach ($tags as $tag) { ?>
	<a href="<?php echo $tag['href']; ?>"><span class="tag_begin"></span>
	<span class="tag_link"><?php echo $tag['tag']; ?></span>
	<span class="tag_end"></span></a>
	<?php } ?>
  </div>
  <?php } ?>

  <div class="c"></div>

