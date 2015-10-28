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
		<link rel="stylesheet" type="text/css" href="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/stylesheet/responsive.css" />
		<link rel="stylesheet" type="text/css" href="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/stylesheet/jquery.jscrollpane.css" />
		<link rel="stylesheet" type="text/css" href="catalog/view/theme/Fashionista/stylesheet/ajax_login_register.css" />
		<script type="text/javascript" src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/javascript/jquery/jquery-1.6.1.min.js"></script>
		<script type="text/javascript" src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/javascript/jquery/ui/jquery-ui-1.8.9.custom.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.9.custom.css" />
		<script type="text/javascript" src="<?php echo HTTP_SERVER; ?>catalog/view/javascript/jquery/ui/external/jquery.cookie.js"></script>
		<script type="text/javascript" src="catalog/view/javascript/modal/jquery.reveal.js"></script>
		<link rel="stylesheet" type="text/css" href="catalog/view/javascript/modal/jquery.reveal.css" media="screen" />
		<script type="text/javascript" src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/javascript/jquery/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
		<link rel="stylesheet" type="text/css" href="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/javascript/jquery/fancybox/jquery.fancybox-1.3.4.css" media="screen" />
		<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,400italic,600,700&subset=latin,cyrillic' rel='stylesheet' type='text/css'>
		<script type="text/javascript" src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/javascript/common.js"></script>
		<?php foreach ($scripts as $script) { ?>
		<script type="text/javascript" src="<?php echo HTTP_SERVER; ?><?php echo $script; ?>"></script>
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
							<input type="text" value placeholder="Введите ваш E-mail" name="email"><br>
							*<span class="login_display">Пароль</span><br>
							<input type="password" value placeholder="Введите ваш пароль" name="password"><br>
							<div style="text-align:right;">
							<input type="submit" value="Войти" style="margin-right:13px;"  class="ajax_login">
							</div>
							<div style="border-bottom:1px dotted #DDD;padding:5px 0;"></div>
							<div style="padding-top: 5px;">
							<a href="/index.php?route=account/forgotten">Забыл пароль</a><br>
							<span id="signup-link"><a href="/index.php?route=account/simpleregister">Регистрация!</a></span>
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

<header>
	<div class="universal__wrapper header clearfix">
		<div class="col-universal">
			<a href="tel:+74957774545">+7 495 777-45-45</a>
			<span>
				магазин на Ленинском	
				<div class="map">
					<img src="/img/index/map.jpg" alt="">
				</div>
			</span>
		</div>
		<div class="col-universal">
			<a href="/index.php" class="logo">
				<img class="logo" src="/img/logo.png">
			</a>
			<?php if ($categories) { ?>
			<nav>
				<ul class="top_menu">
					<?php
					global $_;
					$category_count = 0;
					foreach ($categories as $key=>$category) { ?>   

					<li>
						<a href="<?php echo $category['href']; ?>" class="drop_<?php echo $key; ?> <?php if ($category['active']) { echo 'active'; }?>"><?php echo $category['name']; ?></a>
					</li>

					<?php } ?>
					<li>
						<a href="/akcii">АКЦИИ</a>
					</li>
				</ul>
			</nav>
			<?php } ?>			
		</div>
		<div class="col-universal">
			<ul>
				<li>
					Вход
					<ul class="sub__menu">
						<li>
							<a href="">
								Зарегистрироваться
							</a>
						</li>
						<li>
							<a href="">
								Войти
							</a>
						</li>
					</ul>
				</li>
				<li>
					<a href="">
						Корзина
					</a>
					<div id="basket_content"></div>
				</li>
			</ul>	
		</div>
	</div>
</header>