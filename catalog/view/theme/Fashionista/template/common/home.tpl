<?php echo $header; ?>

<main class="index clearfix">
	<div class="universal__wrapper clearfix" style="background-color: #fff;">
		<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
		<script type="text/javascript" src="/catalog/view/theme/Fashionista/javascript/jquery/jquery.jscrollpane.js"></script>
		<script type="text/javascript" src="/catalog/view/theme/Fashionista/javascript/jquery/jquery.mousewheel.js"></script>
		<script type="text/javascript" src="/catalog/view/theme/Fashionista/javascript/jquery/jquery.ui-slider.js"></script>
		<script type="text/javascript" src="/catalog/view/theme/Fashionista/javascript/jquery/jqueryrotate.js"></script>
		<script type="text/javascript" src="/catalog/view/theme/Fashionista/javascript/jquery/jssor.js"></script>
		<script type="text/javascript" src="/catalog/view/theme/Fashionista/javascript/jquery/jssor.slider.js"></script>
		<script type="text/javascript" src="/catalog/view/theme/Fashionista/javascript/jquery/script.js"></script>
		<script type="text/javascript" src="http://cdn.jsdelivr.net/jquery.mcustomscrollbar/3.0.6/jquery.mCustomScrollbar.concat.min.js"></script>
		<link  type="text/css" rel="stylesheet" href="http://cdn.jsdelivr.net/jquery.mcustomscrollbar/3.0.6/jquery.mCustomScrollbar.min.css">
		
		
		<script>

			jQuery(document).ready(function ($) {
				var options = {
					$AutoPlay: true,

					$PauseOnHover: 1,                               //[Optional] Whether to pause when mouse over if a slideshow is auto playing, default value is false

					$ArrowKeyNavigation: true,                          //Allows arrow key to navigate or not
					$SlideWidth: 1150,                                   //[Optional] Width of every slide in pixels, the default is width of 'slides' container
					$SlideHeight: 375,                                  //[Optional] Height of every slide in pixels, the default is width of 'slides' container
					$SlideSpacing: 0,                                   //Space between each slide in pixels
					$DisplayPieces: 2,                                  //Number of pieces to display (the slideshow would be disabled if the value is set to greater than 1), the default value is 1
					$ParkingPosition: 160,                                //The offset position to park slide (this options applys only when slideshow disabled).

					$ArrowNavigatorOptions: {                       //[Optional] Options to specify and enable arrow navigator or not
						$Class: $JssorArrowNavigator$,              //[Requried] Class to create arrow navigator instance
						$ChanceToShow: 2,                               //[Required] 0 Never, 1 Mouse Over, 2 Always
						$AutoCenter: 0,                                 //[Optional] Auto center arrows in parent container, 0 No, 1 Horizontal, 2 Vertical, 3 Both, default value is 0
						$Steps: 1                                       //[Optional] Steps to go for each navigation request, default value is 1
					}
				};

				var jssor_slider1 = new $JssorSlider$("slider1_container", options);

				//responsive code begin
				//you can remove responsive code if you don't want the slider scales while window resizes
				function ScaleSlider() {
					var parentWidth = jssor_slider1.$Elmt.parentNode.clientWidth;
					if (parentWidth)
						jssor_slider1.$ScaleWidth(Math.min(parentWidth, 1980));
					else
						window.setTimeout(ScaleSlider, 30);
				}
				ScaleSlider();

				$(window).bind("load", ScaleSlider);
				$(window).bind("resize", ScaleSlider);
				$(window).bind("orientationchange", ScaleSlider);
				//responsive code end
				
				
				// Init scrollbar
				$(".goods").mCustomScrollbar({
					axis:"x",
					theme:"dark",
					mouseWheel: {
						enable: false
					},
					scrollButtons: {
						enable: true
					},
					advanced: {
						autoExpandHorizontalScroll: true
					}
				});
			});
		</script>
		

		<div id="slider1_container" style='overflow: hidden;'>
			<!-- Slides Container -->
			<div class="sliders" u="slides">
				<div><img u="image" src="img/banner/banner_1.jpg" /></div>
				<div><img u="image" src="img/banner/banner_2.jpg" /></div>
				<div><img u="image" src="img/banner/banner_3.jpg" /></div>
				<div><img u="image" src="img/banner/banner_4.jpg" /></div>
				<div><img u="image" src="img/banner/banner_5.jpg" /></div>
			</div>
		<!-- Arrow Left -->
			<span u="arrowleft" class="jssora13l">
			</span>
			<!-- Arrow Right -->
			<span u="arrowright" class="jssora13r">
			</span>
			<!--#endregion Arrow Navigator Skin End -->
		</div>

	</div>
	

	 <div class="popular"> 
		<h1>Популярные товары</h1>
		<div class="goods">
			<div class="goods-wrapper">
				<div class="universal__cell product__cell product__cell--main">
					<div class="img">
						<span class="new">Новинка</span>
						<a class="catproductimg" style="background-image: url('http://kites.local/image/cache/data/shop/harness/seat/dakine/DK%20FUSION%202013-193x193.jpg');" href="http://kites.local/Трапеции/Dakine_FUSION_2013"> </a>
					</div>
					<h2 class="name">
						<a href="http://kites.local/Трапеции/Dakine_FUSION_2013">
							<span class="upper">Трапеция Dakine 13 FUSION</span>
							<span class="year"></span>
						</a>
					</h2>
					<p class="price">
						<span class="red"> 7 520 р. </span>
					</p>
				</div>
				<div class="universal__cell product__cell product__cell--main">
					<div class="img">
						<span class="new">Новинка</span>
						<a class="catproductimg" style="background-image: url('http://kites.local/image/cache/data/shop/harness/seat/dakine/DK%20FUSION%202013-193x193.jpg');" href="http://kites.local/Трапеции/Dakine_FUSION_2013"> </a>
					</div>
					<h2 class="name">
						<a href="http://kites.local/Трапеции/Dakine_FUSION_2013">
							<span class="upper">Трапеция Dakine 13 FUSION</span>
							<span class="year"></span>
						</a>
					</h2>
					<p class="price">
						<span class="red"> 7 520 р. </span>
					</p>
				</div>
				<div class="universal__cell product__cell product__cell--main">
					<div class="img">
						<span class="new">Новинка</span>
						<a class="catproductimg" style="background-image: url('http://kites.local/image/cache/data/shop/harness/seat/dakine/DK%20FUSION%202013-193x193.jpg');" href="http://kites.local/Трапеции/Dakine_FUSION_2013"> </a>
					</div>
					<h2 class="name">
						<a href="http://kites.local/Трапеции/Dakine_FUSION_2013">
							<span class="upper">Трапеция Dakine 13 FUSION</span>
							<span class="year"></span>
						</a>
					</h2>
					<p class="price">
						<span class="red"> 7 520 р. </span>
					</p>
				</div>
				<div class="universal__cell product__cell product__cell--main">
					<div class="img">
						<span class="new">Новинка</span>
						<a class="catproductimg" style="background-image: url('http://kites.local/image/cache/data/shop/harness/seat/dakine/DK%20FUSION%202013-193x193.jpg');" href="http://kites.local/Трапеции/Dakine_FUSION_2013"> </a>
					</div>
					<h2 class="name">
						<a href="http://kites.local/Трапеции/Dakine_FUSION_2013">
							<span class="upper">Трапеция Dakine 13 FUSION</span>
							<span class="year"></span>
						</a>
					</h2>
					<p class="price">
						<span class="red"> 7 520 р. </span>
					</p>
				</div>
				<div class="universal__cell product__cell product__cell--main">
					<div class="img">
						<span class="new">Новинка</span>
						<a class="catproductimg" style="background-image: url('http://kites.local/image/cache/data/shop/harness/seat/dakine/DK%20FUSION%202013-193x193.jpg');" href="http://kites.local/Трапеции/Dakine_FUSION_2013"> </a>
					</div>
					<h2 class="name">
						<a href="http://kites.local/Трапеции/Dakine_FUSION_2013">
							<span class="upper">Трапеция Dakine 13 FUSION</span>
							<span class="year"></span>
						</a>
					</h2>
					<p class="price">
						<span class="red"> 7 520 р. </span>
					</p>
				</div>
				<div class="universal__cell product__cell product__cell--main">
					<div class="img">
						<span class="new">Новинка</span>
						<a class="catproductimg" style="background-image: url('http://kites.local/image/cache/data/shop/harness/seat/dakine/DK%20FUSION%202013-193x193.jpg');" href="http://kites.local/Трапеции/Dakine_FUSION_2013"> </a>
					</div>
					<h2 class="name">
						<a href="http://kites.local/Трапеции/Dakine_FUSION_2013">
							<span class="upper">Трапеция Dakine 13 FUSION</span>
							<span class="year"></span>
						</a>
					</h2>
					<p class="price">
						<span class="red"> 7 520 р. </span>
					</p>
				</div>
				<div class="universal__cell product__cell product__cell--main">
					<div class="img">
						<span class="new">Новинка</span>
						<a class="catproductimg" style="background-image: url('http://kites.local/image/cache/data/shop/harness/seat/dakine/DK%20FUSION%202013-193x193.jpg');" href="http://kites.local/Трапеции/Dakine_FUSION_2013"> </a>
					</div>
					<h2 class="name">
						<a href="http://kites.local/Трапеции/Dakine_FUSION_2013">
							<span class="upper">Трапеция Dakine 13 FUSION</span>
							<span class="year"></span>
						</a>
					</h2>
					<p class="price">
						<span class="red"> 7 520 р. </span>
					</p>
				</div>
				<div class="universal__cell product__cell product__cell--main">
					<div class="img">
						<span class="new">Новинка</span>
						<a class="catproductimg" style="background-image: url('http://kites.local/image/cache/data/shop/harness/seat/dakine/DK%20FUSION%202013-193x193.jpg');" href="http://kites.local/Трапеции/Dakine_FUSION_2013"> </a>
					</div>
					<h2 class="name">
						<a href="http://kites.local/Трапеции/Dakine_FUSION_2013">
							<span class="upper">Трапеция Dakine 13 FUSION</span>
							<span class="year"></span>
						</a>
					</h2>
					<p class="price">
						<span class="red"> 7 520 р. </span>
					</p>
				</div>
				<div class="universal__cell product__cell product__cell--main">
					<div class="img">
						<span class="new">Новинка</span>
						<a class="catproductimg" style="background-image: url('http://kites.local/image/cache/data/shop/harness/seat/dakine/DK%20FUSION%202013-193x193.jpg');" href="http://kites.local/Трапеции/Dakine_FUSION_2013"> </a>
					</div>
					<h2 class="name">
						<a href="http://kites.local/Трапеции/Dakine_FUSION_2013">
							<span class="upper">Трапеция Dakine 13 FUSION</span>
							<span class="year"></span>
						</a>
					</h2>
					<p class="price">
						<span class="red"> 7 520 р. </span>
					</p>
				</div>
				<div class="universal__cell product__cell product__cell--main">
					<div class="img">
						<span class="new">Новинка</span>
						<a class="catproductimg" style="background-image: url('http://kites.local/image/cache/data/shop/harness/seat/dakine/DK%20FUSION%202013-193x193.jpg');" href="http://kites.local/Трапеции/Dakine_FUSION_2013"> </a>
					</div>
					<h2 class="name">
						<a href="http://kites.local/Трапеции/Dakine_FUSION_2013">
							<span class="upper">Трапеция Dakine 13 FUSION</span>
							<span class="year"></span>
						</a>
					</h2>
					<p class="price">
						<span class="red"> 7 520 р. </span>
					</p>
				</div>
				<div class="universal__cell product__cell product__cell--main">
					<div class="img">
						<span class="new">Новинка</span>
						<a class="catproductimg" style="background-image: url('http://kites.local/image/cache/data/shop/harness/seat/dakine/DK%20FUSION%202013-193x193.jpg');" href="http://kites.local/Трапеции/Dakine_FUSION_2013"> </a>
					</div>
					<h2 class="name">
						<a href="http://kites.local/Трапеции/Dakine_FUSION_2013">
							<span class="upper">Трапеция Dakine 13 FUSION</span>
							<span class="year"></span>
						</a>
					</h2>
					<p class="price">
						<span class="red"> 7 520 р. </span>
					</p>
				</div>
				<div class="universal__cell product__cell product__cell--main">
					<div class="img">
						<span class="new">Новинка</span>
						<a class="catproductimg" style="background-image: url('http://kites.local/image/cache/data/shop/harness/seat/dakine/DK%20FUSION%202013-193x193.jpg');" href="http://kites.local/Трапеции/Dakine_FUSION_2013"> </a>
					</div>
					<h2 class="name">
						<a href="http://kites.local/Трапеции/Dakine_FUSION_2013">
							<span class="upper">Трапеция Dakine 13 FUSION</span>
							<span class="year"></span>
						</a>
					</h2>
					<p class="price">
						<span class="red"> 7 520 р. </span>
					</p>
				</div>
				<div class="universal__cell product__cell product__cell--main">
					<div class="img">
						<span class="new">Новинка</span>
						<a class="catproductimg" style="background-image: url('http://kites.local/image/cache/data/shop/harness/seat/dakine/DK%20FUSION%202013-193x193.jpg');" href="http://kites.local/Трапеции/Dakine_FUSION_2013"> </a>
					</div>
					<h2 class="name">
						<a href="http://kites.local/Трапеции/Dakine_FUSION_2013">
							<span class="upper">Трапеция Dakine 13 FUSION</span>
							<span class="year"></span>
						</a>
					</h2>
					<p class="price">
						<span class="red"> 7 520 р. </span>
					</p>
				</div>
				<div class="universal__cell product__cell product__cell--main">
					<div class="img">
						<span class="new">Новинка</span>
						<a class="catproductimg" style="background-image: url('http://kites.local/image/cache/data/shop/harness/seat/dakine/DK%20FUSION%202013-193x193.jpg');" href="http://kites.local/Трапеции/Dakine_FUSION_2013"> </a>
					</div>
					<h2 class="name">
						<a href="http://kites.local/Трапеции/Dakine_FUSION_2013">
							<span class="upper">Трапеция Dakine 13 FUSION</span>
							<span class="year"></span>
						</a>
					</h2>
					<p class="price">
						<span class="red"> 7 520 р. </span>
					</p>
				</div>
			
				
			</div>
		</div>
	 </div>


	<div class="universal__wrapper clearfix blocks three_cols">
		<div class="col-universal">
			<div class="cell-colored colored--green">
				<h3>О магазине</h3>
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Tenetur praesentium modi aperiam recusandae suscipit nobis, fugiat eligendi velit laboriosam laudantium sapiente. Fugiat exercitationem commodi nisi minus provident.</p>
			</div>
			<div class="row__universal three__cells">
				<div class="row__universal--inner">
					<div class="cell-universal">
						<div class="opacity imgs"></div>
						<a href="" class="loop">
							<img src="img/index/zoom.jpg" alt="">
						</a>
						<img src="img/index/photo_01.jpg" alt="">
					</div>
					<div class="cell-universal">
						<div class="opacity imgs"></div>
						<a href="" class="loop">
							<img src="img/index/zoom.jpg" alt="">
						</a>
						<img src="img/index/photo_01.jpg" alt="">
					</div>
					<div class="cell-universal">
						<div class="opacity imgs"></div>
						<a href="" class="loop">
							<img src="img/index/zoom.jpg" alt="">
						</a>
						<img src="img/index/photo_01.jpg" alt="">
					</div>
				</div>
			</div>
		</div>

		<div class="col-universal">
			<div class="map__col">
				<img src="img/index/map.jpg" alt="">
				<div class="line-colored">
					<p>г.Москва, ул.Ленинский проспект, д.30, вход со двора справа от 1-го подъезда. Мы работаем ежедневно с 10 до 21 часа.</p>
				</div>
			</div>
		</div>

		<div class="col-universal">
			<div class="row__universal">
				<div class="row__universal--inner">
					<div class="cell-universal">
						<div class="cell-wrapper-inner colored--red cell-colored">
							<div class="opacity"></div>
							<h5>Кайты <span>North</span></h5>
							<p class="percent">-15%</p>
						</div>
					</div>
					<div class="cell-universal">
						<div class="cell-wrapper-inner colored--red cell-colored">
							<div class="opacity"></div>
							<h5>Кайты <span>Liquid forse</span></h5>
							<p class="percent">-15%</p>
						</div>
					</div>
				</div>
			</div>
			<div class="cell-universal colored--red cell-colored">
				<h3>Акции</h3>
				 <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Tenetur praesentium modi aperiam recusandae suscipit nobis, fugiat eligendi velit laboriosam laudantium sapiente. Fugiat exercitationem commodi nisi minus provident.</p>
			</div>
		</div>
	</div>

    <div class="brends universal__wrapper clearfix">
        <img src="img/parad/img_01.gif" alt="">
        <img src="img/parad/img_02.gif" alt="">
        <img src="img/parad/img_03.gif" alt="">
        <img src="img/parad/img_04.gif" alt="">
        <img src="img/parad/img_05.gif" alt="">
        <img src="img/parad/img_06.gif" alt="">
        <img src="img/parad/img_07.gif" alt="">
        <img src="img/parad/img_08.gif" alt="">
        <img src="img/parad/img_09.gif" alt="">
        <img src="img/parad/img_10.gif" alt="">
        <img src="img/parad/img_09.gif" alt="" class="big_screen">
        <img src="img/parad/img_10.gif" alt="" class="big_screen">
        <img src="img/parad/img_09.gif" alt="" class="big_screen">
        <img src="img/parad/img_10.gif" alt="" class="big_screen">
    </div>


<?php // echo $content_top; ?>
	<div class="container home_container universal__wrapper clearfix">
<?php // echo $column_left; ?>
<?php // echo $column_right; ?>

<?php // echo $content_bottom; ?>

	</div>
</main>

<?php echo $footer; ?>
