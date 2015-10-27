<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html lang="<?php echo $lang; ?>" class="no-js"> <!--<![endif]-->
<head>
	<meta charset="UTF-8">
	<title><?php echo $title; ?></title>
	<base href="<?php echo $base; ?>" />
		<?php if ($description) { ?>
		<meta name="description" content="<?php echo $description; ?>" />
		<?php } ?>
		<?php if ($keywords) { ?>
		<meta name="keywords" content="<?php echo $keywords; ?>" />
		<?php } ?>
	<meta name="author" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<?php if ($icon) { ?>
	<link rel="shortcut icon" href="<?php echo $icon; ?>">
		<?php } ?>
		<?php foreach ($links as $link) { ?>
		<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
		<?php } ?>
		<?php foreach ($styles as $style) { ?>
		<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo HTTP_SERVER; ?><?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
		<?php } ?>		
		<link rel="stylesheet" type="text/css" href="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/stylesheet/stylesheet.css?v=2" />
		<link rel="stylesheet" type="text/css" href="catalog/view/theme/Fashionista/stylesheet/ajax_login_register.css" />
		<script type="text/javascript" src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/javascript/jquery/jquery-1.6.1.min.js"></script>
		<script type="text/javascript" src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/javascript/jquery/ui/jquery-ui-1.8.9.custom.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.9.custom.css" />
		<script type="text/javascript" src="<?php echo HTTP_SERVER; ?>catalog/view/javascript/jquery/ui/external/jquery.cookie.js"></script>
		<script type="text/javascript" src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/javascript/common.js"></script>
		<script type="text/javascript" src="catalog/view/javascript/modal/jquery.reveal.js"></script>
		<link rel="stylesheet" type="text/css" href="catalog/view/javascript/modal/jquery.reveal.css" media="screen" />
		<!-- theme settings -->
		<!-- <script type="text/javascript" src="http://www.templatestock.net/themer/settings.js"></script> -->
		<!-- <script type="text/javascript" src="http://www.templatestock.net/themer/colorpicker.js"></script> -->
		<!-- <link rel="stylesheet" type="text/css" href="http://www.templatestock.net/themer/settings.css" media="screen" /> -->
		<!-- end of settingsdsda -->
		<script src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/javascript/modernizr-1.7.min.js"></script>
		<script type="text/javascript" src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/javascript/jquery/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
		<link rel="stylesheet" type="text/css" href="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/javascript/jquery/fancybox/jquery.fancybox-1.3.4.css" media="screen" />
		<script type="text/javascript" src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/javascript/cufon-yui.js"></script>
		<script type="text/javascript" src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/javascript/Oswald_400.font.js_"></script>
		<?php //echo $google_analytics; ?>
		<?php foreach ($scripts as $script) { ?>
		<script type="text/javascript" src="<?php echo HTTP_SERVER; ?><?php echo $script; ?>"></script>
		<script type="text/javascript" src="catalog/view/javascript/ajax_login_register.js"></script>
		<script type="text/javascript" src="catalog/view/javascript/jquery/jquery.bpopup.min.js"></script>
		<?php } ?>
<meta property="fb:app_id" content="154212717980335"/>
<meta property="fb:admins" content="4161860478151"/>
</head>
<body>
<div style="display:none" id="ajax_login">
						<form action="/index.php?route=account/login" method="post" enctype="multipart/form-data" id="login">
						<span id="cross_icon_login"><img style="width:20px" src="catalog/view/theme/Fashionista/image/cross_icon.jpg"></span>
						<div id="login_title">Вход</div>
						<div id="login_details">
							*<span class="login_display">Email</span><br>
							<input type="text" value placeholder="Enter Your Email" name="email"><br>
							*<span class="login_display">Пароль</span><br>
							<input type="password" value placeholder="Enter Your Password" name="password"><br>
							<div style="text-align:right;">
							<input type="submit" value="Login" style="margin-right:13px;"  class="ajax_login">
							</div>
							<div style="border-bottom:1px dotted #DDD;padding:5px 0;"></div>
							<div style="padding-top: 5px;">
							<a href="/index.php?route=account/forgotten">Забыл пароль</a><br>
							<span>Не зарегистрированы?</span><span id="signup-link"><a href="/index.php?route=account/simpleregister">Регистрация!</a></span>
							</div>
							</div>
							</form>
						  </div>
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/ru_RU/all.js#xfbml=1&appId=154212717980335";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

	<header class="header">
	<div class="c2"></div>
	<div class="container">
					<ul class="light_menu c1_color">
					<li><a style="cursor:pointer;" id="loginpopup">ВХОД</a></li>
						<!--<li><a href="<?php echo $cart; ?>"><?php echo $text_cart; ?></a></li>-->
						<!--<li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>-->
						<li><a href="/about_us" id="wishlist_total">О нас</a></li>
                        <!--<li><a href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a></li>-->
						<li><a href="<?php echo $wishlist; ?>" id="wishlist_total"><?php echo $text_wishlist; ?></a></li>
                        <li><a href="<?php echo $this->url->link('product/compare'); ?>"><?php echo $this->language->get('text_compare_head'); ?></a></li>
						<li><a href="<?php echo $home; ?>"><?php echo $text_home; ?></a></li>
					</ul>
					<a href="<?php echo $home; ?>" title="<?php echo $name; ?>" class="logo"><img src="<?php echo $logo; ?>" /></a>
					<div id="basket"><?php echo $text_cart; ?>: <span id="cart_total"><?php echo $text_items; ?></span></div>
					<div class="basket_line"></div>
					<div id="basket_icon" class="basket_icon_closed"></div>
					<div id="basket_drop" class="c1">
						<div class="line_drop"></div>
						<div id="basket_content"></div>
					</div>
					<?php if ($categories) { ?>
					<ul class="top_menu">
					<?php
					global $_;
					$category_count = 0;
					
					foreach ($categories as $key=>$category) {
						
						if($category_count >= 6) {
					?>   
						
						<li><a title="<?php echo $this->language->get('text_custom_more'); ?>" class="drop_<?php echo $key; ?>"><?php echo $this->language->get('text_custom_more'); ?></a></li>
						  <li>
							<div class="drop_down c1" id="drop_<?php echo $key; ?>">
							<ul>
								<?php
								
								foreach($categories as $kt=>$ct)
								{
									if($kt > 6)
									{
								?>
								<li><a href="<?php echo $ct['href']; ?>" title="<?php echo $ct['name']; ?>" class="drop_<?php echo $kt; ?>"><?php echo $ct['name']; ?></a></li>
								<?php
									}
								}
								
								?>
							</ul>
							</div>
						  </li>
						
						
					<?php        
					
						break;
						}
						
						$category_count += 1;
						
						
					?>
					<li><a href="<?php echo $category['href']; ?>" class="drop_<?php echo $key; ?>"><?php echo $category['name']; ?></a></li>
					  <li><?php if ($category['children']) { ?>
					  <div class="drop_down c1" id="drop_<?php echo $key; ?>">
						<?php for ($i = 0; $i < count($category['children']);) { ?>
						<ul>
						  <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
						  <?php for (; $i < $j; $i++) { ?>
						  <?php if (isset($category['children'][$i])) { ?>
						  <li><a href="<?php echo $category['children'][$i]['href']; ?>" title="<?php echo $category['children'][$i]['name']; ?>"><?php echo $category['children'][$i]['name']; ?></a></li>
						  <?php } ?>
						  <?php } ?>
						</ul>
						<?php } ?>
					  </div>
					  <?php } ?></li>

					<?php } ?>
					<li><a class="red" href="/index.php?route=product/special">АКЦИИ</a></li>
					</ul>
					<?php } ?>
					
				  <div id="welcome">
					<?php if (!$logged) { ?>
					<?php echo $text_welcome; ?>
					<?php } else { ?>
					<?php echo $text_logged; ?>
					<?php } ?>
				  </div>
					<div id="language_holder">
				  <?php if (count($languages) > 1) { ?>
				  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
					<ul id="language" class="c1">
					  <?php foreach ($languages as $language) { ?>
					  <li><a href="#" class="<?php echo $language['code']; ?>"><img src="<?php echo HTTP_SERVER; ?>image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
					  <?php } ?>
					</ul>
					  <input type="hidden" name="language_code" value="" />
					  <input type="hidden" name="curr_lang" value="<?php echo $this->language->get('code'); ?>" />
					  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
				  </form>
				  <?php } ?> 
				  <?php if (count($currencies) > 1) { ?>
				  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
					<ul id="currency" class="c1">
					  <?php foreach ($currencies as $currency) { ?>
					  <li><a class="<?php echo $currency['code']; ?>" href="#" title="<?php echo $currency['title']; ?>"><?php echo $currency['title']; ?></a></li>
					  <?php } ?>
					</ul>
					<input type="hidden" name="currency_code" value="" />
					<input type="hidden" name="curr_curr" value="<?php echo $this->currency->getCode(); ?>" />
					<input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
				  </form>
				  <?php } ?>
				  <div class="search">
					<a href="#" class="search_btn"></a>
					<div class="search_inp"><input name="filter_name" autocomplete="off" class="Поиск ..." id="search" value="Поиск ..." /></div>
					<div class="search_com"></div>
				  </div>
				  
					</div>
		</div>
		<script>
$(document).ready(function() {
	/* Search */
	$('.search_btn').bind('click', function() {
		url = '<?php echo HTTP_SERVER; ?>index.php?route=product/search';
		 
		var filter_name = $('input[name=\'filter_name\']').attr('value')
		
		if (filter_name) {
			url += '&filter_name=' + encodeURIComponent(filter_name);
		}
		
		location = url;
	});
	
	$('input[name=\'filter_name\']').keydown(function(e) {
		if (e.keyCode == 13) {
			url = '<?php echo HTTP_SERVER; ?>index.php?route=product/search';
			 
			var filter_name = $('input[name=\'filter_name\']').attr('value')
			
			if (filter_name) {
				url += '&filter_name=' + encodeURIComponent(filter_name);
			}
			
			location = url;
		}
	});
	
	/* Ajax Cart */
	$('#basket, #basket_icon').hover(function() {
		
		$.AjaxCart();			

	});
	
		
		/* Ajax Cart function */
		$.AjaxCart = function()
		{
		$.ajax({
			url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/cart/update',
			dataType: 'json',
			success: function(json) {
				if (json['output']) {
					$('#basket_content').html(json['output']);
										
										$("#basket_content > .total").remove();
										$("#basket_content .cart .image").remove();
										
										$('#basket_content .cart .remove img')
										.attr({
											src : '<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/close.png'
										})
										.css({
											cursor : 'pointer'
										});

										$("#basket_content .checkout a").removeClass("button c2");
										$("#basket_content .checkout").addClass("button c2").removeClass("checkout");
										Cufon.replace('#cart_total, .button');
										$.ButtonOverlay();
				}
			}
		});            
		}
		
	/* Mega Menu */
	$('#menu ul > li > a + div').each(function(index, element) {
		// IE6 & IE7 Fixes
		if ($.browser.msie && ($.browser.version == 7 || $.browser.version == 6)) {
			var category = $(element).find('a');
			var columns = $(element).find('ul').length;
			
			$(element).css('width', (columns * 143) + 'px');
			$(element).find('ul').css('float', 'left');
		}		
		
		var menu = $('#menu').offset();
		var dropdown = $(this).parent().offset();
		
		i = (dropdown.left + $(this).outerWidth()) - (menu.left + $('#menu').outerWidth());
		
		if (i > 0) {
			$(this).css('margin-left', '-' + (i + 5) + 'px');
		}
	});

	// IE6 & IE7 Fixes
	if ($.browser.msie) {
		if ($.browser.version <= 6) {
			$('#column-left + #column-right + #content, #column-left + #content').css('margin-left', '195px');
			
			$('#column-right + #content').css('margin-right', '195px');
		
			$('.box-category ul li a.active + ul').css('display', 'block');	
		}
		
		if ($.browser.version <= 7) {
			$('#menu > ul > li').bind('mouseover', function() {
				$(this).addClass('active');
			});
				
			$('#menu > ul > li').bind('mouseout', function() {
				$(this).removeClass('active');
			});	
		}
	}
});

function addToCart(product_id) {
	
	$.ajax({
		url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/cart/update',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information, .error').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['error']) {
				if (json['error']['warning']) {
					$('#notification').html('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				}
			}	 
						
			if (json['success']) {
				$('#notification').html('<div class="attention" style="display: none;">' + json['success'] + '<img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				
				$('.attention').fadeIn('slow');
				
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
			}	
		}
	});
}

function removeCart(key) {
	$.ajax({
		url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/cart/update',
		type: 'post',
		data: 'remove=' + key,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information').remove();
			
			if (json['output']) {
				$('#cart_total').html(json['total']);
				
				$('#basket_content').html(json['output']);

										$("#basket_content > .total").remove();
										$("#basket_content .cart .image").remove();
										
										$('#basket_content .cart .remove img')
										.attr({
											src : '<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/close.png'
										})
										.css({
											cursor : 'pointer'
										});
										
										$("#basket_content .checkout a").removeClass("button c2");
										$("#basket_content .checkout").addClass("button c2").removeClass("checkout");
										
										
										
										Cufon.replace('#cart_total, .button');
										$.ButtonOverlay();
								
			}			
		}
	});
}

function removeVoucher(key) {
	$.ajax({
		url: '<?php echo HTTP_SERVER; ?>index.php?route=checkout/cart/update',
		type: 'post',
		data: 'voucher=' + key,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information').remove();
			
			if (json['output']) {
				$('#cart_total').html(json['total']);
				
				$('#cart .content').html(json['output']);
			}			
		}
	});
}

function addToWishList(product_id) {
	$.ajax({
		url: '<?php echo HTTP_SERVER; ?>index.php?route=account/wishlist/update',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information').remove();
						
			if (json['success']) {
				$('#notification').html('<div class="attention" style="display: none;">' + json['success'] + '<img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				
				$('.attention').fadeIn('slow');
				
				$('#wishlist_total').html(json['total']);
				
				$('html, body').animate({scrollTop: 0}, 'slow');
				Cufon.replace('.light_menu > li a');				
			}	
		}
	});
}

function addToCompare(product_id) { 
	$.ajax({
		url: '<?php echo HTTP_SERVER; ?>index.php?route=product/compare/update',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information').remove();
						
			if (json['success']) {
				$('#notification').html(json['success'] + ' <a href="#" class="close"><img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/close.png" alt="" /></a>').fadeIn();
				
				$('#notification .close').click(function(event){
					event.preventDefault();
					$(this).parent().fadeOut('slow',function(){
						$(this).html('')
					});
				});
				
				$('#compare_total').html(json['total']);
				
				$('html, body').animate({scrollTop: 326}, 'slow'); 
				
			}	
		}
	});
}

function addToCompare2(product_id) { 
	$.ajax({
		url: '<?php echo HTTP_SERVER; ?>index.php?route=product/compare/update',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information').remove();
						
			if (json['success']) {
				
				$('body').append(
					$('<div></div>')
					.addClass('body_notify c1')
					.html(json['success'] + ' <a href="#" class="close"><img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/close.png" alt="" /></a>')
				);
				
				$('.body_notify').animate({
					right : 0
				});
				
				$('.body_notify .close').click(function(event){
					event.preventDefault();
					$(this).parent().animate({
						right : '-500px'
					}, function(){
						$(this).remove()
					});
						
				});
				
				
			}	
		}
	});
}			
		</script>
</header>
<div class="c"></div>
<script type="text/javascript" src="/buyme/js/buyme.js"></script>