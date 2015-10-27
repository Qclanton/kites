<?php echo $header; ?>
<div class="global c3">
	<div class="container">
            <div class="global_title"><h1><?php echo $heading_title; ?></h1>
            	<span><?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php if($breadcrumb['separator']) { ?>><?php } ?> <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?></span></div>
	</div>
</div>

<div class="white_bg">
    <div class="container">


<div id="main_column_st">
	      	<?php if(count($images) > 2) { ?>
      <a href="#" class="arr_left"></a>
      <a href="#" class="arr_right"></a>
      <?php } ?>

    <?php if ($thumb || $images) { ?>
    <div class="product-image">
      <?php if ($thumb) { ?>
      <div class="image"><a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="fancybox" ><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" /></a></div>
      <?php } ?>
      <?php if ($images) { ?>
      <div class="image-additional">
      <ul <?php if(count($images) < 3) echo 'style="left:0"'; ?>>
        <?php foreach ($images as $image) { ?>
        <li><a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="fancybox" rel="fancybox"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></li>
        <?php } ?>      
      </ul>

      </div>
      <?php } ?>
    </div>
    <?php } ?>
    <div class="product-desc">
    	        <span class="wishes"><a onclick="addToWishList('<?php echo $product_id; ?>'); return false" href="#"><?php echo $this->language->get('text_wish'); ?></a><p>
          <a onclick="addToCompare2('<?php echo $product_id; ?>'); return false" href="#"><?php echo $this->language->get('text_compare'); ?></a></p><br />
          
          	<!-- AddThis Button BEGIN -->
          <span class="addthis_default_style"><a class="addthis_button_compact"></a> <a class="addthis_button_email"></a><a class="addthis_button_print"></a> <a class="addthis_button_facebook"></a> <a class="addthis_button_twitter"></a></span>
          <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js"></script> 
          <!-- AddThis Button END --> 
          </span>
      <div class="description c1_color">
      	<h2 class="c1_color"><?php echo $heading_title; ?></h2>
        <?php if ($manufacturer) { ?>
        <span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a><br />
        <?php } ?>
        <span><?php echo $text_model; ?></span> <?php echo $model; ?><br />
        <!-- <span><?php echo $text_reward; ?></span> <?php echo $reward; ?><br /> -->
        <span><?php echo $text_stock; ?></span> <?php echo $stock; ?></div>
      <?php if ($price) { ?>
      <div class="price c1_color">
        <?php if (!$special) { ?>
        <span class="c1 product-price" style="padding:6px"><?php echo $price; ?></span>
        <?php } else { ?>
         <span class="c1 product-price" style="padding:6px"><?php echo $special; ?></span> <strike><?php echo $price; ?></strike> |
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
      </div>
      <?php } ?>
      <?php if ($options) { ?>
      <div class="options">
        <h2 class="c1_color"><?php echo $text_option; ?></h2>

        <?php foreach ($options as $option) { ?>
        <?php if ($option['type'] == 'select') { ?>
        <span id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <select name="option[<?php echo $option['product_option_id']; ?>]">
            <option value=""><?php echo $text_select; ?></option>
            <?php foreach ($option['option_value'] as $option_value) { ?>
            <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
            </option>
            <?php } ?>
          </select>
        </span>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'radio') { ?>
        <span id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <?php foreach ($option['option_value'] as $option_value) { ?>
          <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
          <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
          </label>
          <br />
          <?php } ?>
        </span>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'checkbox') { ?>
        <span id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <?php foreach ($option['option_value'] as $option_value) { ?>
          <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
          <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"> <?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
          </label>
          <br />
          <?php } ?>
        </span>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'image') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
            <table class="option-image">
              <?php foreach ($option['option_value'] as $option_value) { ?>
              <tr>
                <td style="width: 1px;"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" /></td>
                <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></td>
                <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                  </label></td>
              </tr>
              <?php } ?>
            </table>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'text') { ?>
        <span id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
        </span>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'textarea') { ?>
        <span id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
        </span>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'file') { ?>
        <span id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <span ><a href="#" id="button-option-<?php echo $option['product_option_id']; ?>"><span><?php echo $button_upload; ?></span></a></span>
          <br />
          <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
        </span>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'date') { ?>
        <span id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
        </span>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'datetime') { ?>
        <span id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
        </span>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'time') { ?>
        <span id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
        </span>
        <br />
        <?php } ?>
        <?php } ?>
      </div>
      <?php } ?>

      <?php if ($review_status) { ?>
      <div class="review" style="background-image:none">
        <img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />&nbsp;&nbsp;<a href="#" class="open-review"><?php echo $reviews; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" class="open-review"><?php echo $text_write; ?></a>
      </div>
      <?php } ?>
    </div>
          <div class="cart-adding">
          	<div style="float:left">
        <?php echo $text_qty; ?>
          <input type="text" name="quantity" size="2" id="quantity-opt" value="<?php echo $minimum; ?>" />
          <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
          &nbsp;</div><div class="button c4" style="margin-right:10px"><a id="button-cart" href="#"><span><?php echo $this->language->get('text_addtocart'); ?></span></a></div>
		
		<div style="float:left; padding-top:6px">
			<script src="http://connect.facebook.net/ru_RU/all.js#xfbml=1"></script>
			<fb:like href="" send="false" width="280" show_faces="true" action="like" font="arial"></fb:like>
		</div>
		<?php if ($minimum > 1) { ?>
        <div style="clear:both; padding-top:20px; margin-left:30px;"><?php echo $text_minimum; ?></div>
        <?php } ?>
		
      </div>
      
  <div class="c"></div>
	<?php echo $accessories_products; ?>

  <br /><br />
  <div>
  	<a href="#" rel="tab-description" class="checkout-heading"><span><?php echo $tab_description; ?></span></a>
  	<div class="checkout-content" id="tab-description"><br /><?php echo $description; ?></div>
    <?php if ($attribute_groups) { ?>
    <a href="#" rel="tab-attr" class="checkout-heading"><?php echo $tab_attribute; ?></a>
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
    <a href="#" rel="tab-review" class="checkout-heading"><?php echo $tab_review; ?></a>
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
    
    
<div class="c"></div>

<?php if($products) { ?>
  <br /><br />
<div class="featured_cont">
<div class="featured">
    <h1 class="c1_color"><?php echo $tab_related; ?></h1>
    <?php if(count($products)  > 5) { ?>
    <a href="#" class="arr_left c1"></a>
    <a href="#" class="arr_right c1"></a>
    <?php } else { ?>
    	<script>
    		$(function($){
    			clearTimeout($featured_carousel);
    			
    			$(window).focus(function (){
    				clearTimeout($featured_carousel);
    			})
    		});
    	</script>
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
<script type="text/javascript"><!--
$('.fancybox').fancybox({cyclic: true});

$(function($){

    /* Featired carousel */
    $.ProductCarousel = function($direction, $elem)
    {
        var $selr = $($elem).find("ul li");
        var $item_len = $selr.width()+20;
        var $curr_pos = parseInt($($elem).find("ul").css('left'));
        var $elem = $elem;

        if($direction == 'positive')
        {
            $($elem).find('ul').animate({ left : $curr_pos - $item_len }, 'slow', null, function(){
                $($elem).find('ul li:last').after($($elem).find('ul li:first'));
                $($elem).find('ul').css({'left' : '-'+$item_len+'px'});
            });                    
        } else {
            $($elem).find("ul").animate({ left : $curr_pos + $item_len }, 'slow', null, function(){
                $($elem).find('ul li:first').before($($elem).find('ul li:last'));
                $($elem).find('ul').css({'left' : '-'+$item_len+'px'});
            });                    
        }
    }
    
    $('.arr_left').click(function(event){
    	event.preventDefault();
    	$.ProductCarousel('negative', '.image-additional');
    });

    $('.arr_right').click(function(event){
    	event.preventDefault();
    	$.ProductCarousel('positive', '.image-additional');
    });    

    
	
	$('.checkout-heading').each(function(){
		
		var $rel = $(this).attr('rel');
		$('#'+$rel).hide();
		
	});
	
	$('#tab-description').show();
	
	
	$('.checkout-heading').click(function(event){

		event.preventDefault();
		
		var $rel = $(this).attr('rel');
		
		$('.checkout-content').not($('#'+$rel)).slideUp();
		$('#'+$rel).slideDown();
		$.ButtonOverlay();

	});
	
	$('.open-review').click(function(event){
		
		event.preventDefault();
		$('.checkout-content').not($('#tab-review')).slideUp();
		$('#tab-review').slideDown();
		// get the y axis from review heading
		var $top = $('div a[rel="tab-review"]').position();
		
		$('html, body').animate({scrollTop: $top.top}, 'slow');
		$.ButtonOverlay();
	})
	
});


//--></script>
<script type="text/javascript"><!--
$('#button-cart').bind('click', function(event) {
	event.preventDefault();
	$.ajax({
		url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/cart/update',
		type: 'post',
		data: $('#main_column_st input[type=\'text\'], #main_column_st input[type=\'hidden\'], #main_column_st input[type=\'radio\']:checked, #main_column_st input[type=\'checkbox\']:checked, .options select, .options textarea'),
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, information, .error').remove();

			if (json['error']) {
				if (json['error']['warning']) {
					$('#notification').html('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/close.png" alt="" class="close" /></div>');
				
					$('.warning').fadeIn('slow');
				}
				
				for (i in json['error']) {
					$('#option-' + i).after('<span class="error">' + json['error'][i] + '</span>');
				}
			}	 
						
			if (json['success']) {
				$('#cart_total').html(json['total']);
				
                                
                                $.AjaxCart();
                                $("#basket_drop").fadeIn('fast');
                                $("#basket_icon").removeClass('basket_icon_closed').addClass('basket_icon_opened');
                                $("#basket").addClass('c1').css('color', '#fff');

                                Cufon.replace('#cart_total, .button, #basket');
				$('html, body').animate({scrollTop: 0}, 'slow', function(){
					setTimeout(function(){
                                $("#basket_drop").fadeOut('fast');
                                $("#basket").removeClass('c1').css('color', '#000');
                                Cufon.replace('#basket');
                                $("#basket_icon").removeClass('basket_icon_opened').addClass('basket_icon_closed');						
					},5000);
				});
				
				$('#main_column_st #quantity-opt').val(1); 	
			}	
		}
	});
});
//--></script>
<?php if ($options) { ?>
<script type="text/javascript" src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/javascript/jquery/ajaxupload.js"></script>
<?php foreach ($options as $option) { ?>
<?php if ($option['type'] == 'file') { ?>
<script type="text/javascript"><!--
new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
	action: '<?php echo HTTP_SERVER; ?>index.php?route=product/product/upload',
	name: 'file',
	autoSubmit: true,
	responseType: 'json',
	onSubmit: function(file, extension) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/loading.gif" id="loading" style="padding-left: 5px;" />');
	},
	onComplete: function(file, json) {
		$('.error').remove();
		
		if (json.success) {
			alert(json.success);
			
			$('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json.file);
		}
		
		if (json.error) {
			$('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json.error + '</span>');
		}
		
		$('#loading').remove();	
	}
});
//--></script>
<?php } ?>
<?php } ?>
<?php } ?>
<script type="text/javascript"><!--
$('#review .pagination a').live('click', function() {
	$('#review').slideUp('slow');
		
	$('#review').load(this.href,  function(){
		Cufon.replace('.pagination .links');
	    $('.pagination .links b').addClass('c1');
	    $('.pagination .links').find(":contains('|<')").html('<<');
	    $('.pagination .links').find(":contains('>|')").html('>>');
	    Cufon.replace($('.pagination .links').find(":contains('>>')"));
	    Cufon.replace($('.pagination .links').find(":contains('<<')"));		
	});

	$('#review').slideDown('slow');
	
	return false;
});			

$('#review').load('<?php echo HTTP_SERVER; ?>index.php?route=product/product/review&product_id=<?php echo $product_id; ?>', function(){
	Cufon.replace('.pagination .links');
    $('.pagination .links b').addClass('c1');
    $('.pagination .links').find(":contains('|<')").html('<<');
    $('.pagination .links').find(":contains('>|')").html('>>');
    Cufon.replace($('.pagination .links').find(":contains('>>')"));
    Cufon.replace($('.pagination .links').find(":contains('<<')"));
});


    $('.pagination .links a').live({
    	mouseenter:
    	function(){
	    	var $color = $(".c1").css('background-color');
	    	
	    	
	    	$(this).css({
	    		'background-color' : $color,
	    		'color' : '#fff'	
	    	});
	    	Cufon.replace($(this));    		
    	},
    	mouseleave:
    	function(){
	    	$(this).css({
	    		'background-color' : '#ebebeb',
	    		'color' : '#636363'
	    	});
	    	Cufon.replace($(this));    		
    	}
    });

$('#button-review').bind('click', function(event) {
	event.preventDefault();
	$.ajax({
		type: 'POST',
		url: '<?php echo HTTP_SERVER; ?>index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		dataType: 'json',
		data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-review').attr('disabled', true);
			$('#review-title').after('<div class="attention"><img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-review').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(data) {
			if (data.error) {
				$('#review-title').after('<div class="warning">' + data.error + '</div>');
			}
			
			if (data.success) {
				$('#review-title').after('<div class="success">' + data.success + '<br /><br /></div>');
								
				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').attr('checked', '');
				$('input[name=\'captcha\']').val('');
				
			}
		}
	});
});
//--></script> 
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script> 
<script type="text/javascript" src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
if ($.browser.msie && $.browser.version == 6) {
	$('.date, .datetime, .time').bgIframe();
}
$('.date').datepicker({dateFormat: 'yy-mm-dd'});
$('.datetime').datetimepicker({
	dateFormat: 'yy-mm-dd',
	timeFormat: 'h:m'
});
$('.time').timepicker({timeFormat: 'h:m'});
//--></script> 
</div>


  </div>
  </div>
<?php echo $footer; ?>
