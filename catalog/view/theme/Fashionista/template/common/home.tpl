<?php echo $header; ?>

<div class="main-wrapper" style="background-color: #fff;">
<main class="index">
	<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	<script type="text/javascript" src="/catalog/view/theme/Fashionista/javascript/jquery/jquery.jscrollpane.js"></script>
	<script type="text/javascript" src="/catalog/view/theme/Fashionista/javascript/jquery/jquery.mousewheel.js"></script>
	<script type="text/javascript" src="/catalog/view/theme/Fashionista/javascript/jquery/jquery.ui-slider.js"></script>
	<script type="text/javascript" src="/catalog/view/theme/Fashionista/javascript/jquery/jqueryrotate.js"></script>
	<script type="text/javascript" src="/catalog/view/theme/Fashionista/javascript/jquery/jssor.js"></script>
	<script type="text/javascript" src="/catalog/view/theme/Fashionista/javascript/jquery/jssor.slider.js"></script>
	<script type="text/javascript" src="/catalog/view/theme/Fashionista/javascript/jquery/script.js"></script>
    <script>

        jQuery(document).ready(function ($) {
            var options = {
                $AutoPlay: true,

                $PauseOnHover: 1,                               //[Optional] Whether to pause when mouse over if a slideshow is auto playing, default value is false

                $ArrowKeyNavigation: true,                          //Allows arrow key to navigate or not
                $SlideWidth: 1080,                                   //[Optional] Width of every slide in pixels, the default is width of 'slides' container
                $SlideHeight: 375,                                  //[Optional] Height of every slide in pixels, the default is width of 'slides' container
                $SlideSpacing: 0,                                   //Space between each slide in pixels
                $DisplayPieces: 2,                                  //Number of pieces to display (the slideshow would be disabled if the value is set to greater than 1), the default value is 1
                $ParkingPosition: 100,                                //The offset position to park slide (this options applys only when slideshow disabled).

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
                    jssor_slider1.$ScaleWidth(Math.min(parentWidth, 1285));
                else
                    window.setTimeout(ScaleSlider, 30);
            }
            ScaleSlider();

            $(window).bind("load", ScaleSlider);
            $(window).bind("resize", ScaleSlider);
            $(window).bind("orientationchange", ScaleSlider);
            //responsive code end
        });
    </script>

    <div id="slider1_container" style='overflow:hidden;'>
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

    <div class="blocks">
        <div class="trinity first">
            <div class="colored">
                <h3>О магазине</h3>
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Tenetur praesentium modi aperiam recusandae suscipit nobis, fugiat eligendi velit laboriosam laudantium sapiente. Fugiat exercitationem commodi nisi minus provident.</p>
            </div>
            <div class="mins">
                <div class="little">
                    <div class="opacity imgs"></div>
                    <a href="" class="loop"><img src="img/index/zoom.jpg" alt=""></a>
                    <img src="img/index/photo_01.jpg" alt="">
                </div>
                <div class="little">
                    <div class="opacity imgs"></div>
                    <a href="" class="loop"><img src="img/index/zoom.jpg" alt=""></a>
                    <img src="img/index/photo_01.jpg" alt="">
                </div>
                <div class="little big_screen">
                    <div class="opacity imgs"></div>
                    <a href="" class="loop"><img src="img/index/zoom.jpg" alt=""></a>
                    <img src="img/index/photo_01.jpg" alt="">
                </div>
            </div>
        </div>
        <div class="trinity second">
            <div class="my_map">
                <img src="img/index/map.jpg" alt="">
            </div>
            <div class="text">
                г.Москва, ул.Ленинский проспект, д.30, вход со двора справа от 1-го подъезда. Мы работаем ежедневно с 10 до 21 часа.
            </div>
        </div>
        <div class="trinity third">
            <div class="mins">
                <div class="little">
                    <div class="opacity"></div>
                    <p>Кайты <span>North</span></p>
                    <p class="percent">-15%</p>
                </div>
                <div class="little">
                    <div class="opacity"></div>
                    <p>Кайтыборд <span>Liquid forse</span></p>
                    <p class="percent">-5%</p>
                </div>
                <div class="little big_screen">
                    <div class="opacity"></div>
                    <p>Кайтыборд <span>Liquid forse</span></p>
                    <p class="percent">-5%</p>
                </div>
            </div>
            <div class="colored">
                <h3>Акции</h3>
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Tenetur praesentium modi aperiam recusandae suscipit nobis, fugiat eligendi velit laboriosam laudantium sapiente. Fugiat exercitationem commodi nisi minus provident.</p>
            </div>
        </div>
    </div>
    <div class="white_back"></div>

    <div class="popular">
        <h1>Популярные товары</h1>
        <div class="goods">
            <div class="goods-wrapper">
                <article>
                    <div class="img">
                        <div class="new">Новинка</div>
                        <a href="goods.html"><img src="img/good_01.jpg" alt=""></a>
                    </div>
                    <p class="name">
                        <a href="goods.html">Кайт <span class="upper">Blade Skinny boy</span>
                        <span class="year">2015</span></a>
                    </p>
                    <p class="price">
                        <span class="red">153 900 p</span>
                    </p>
                </article>
                <article>
                    <div class="img">
                        <div class="new">Новинка</div>
                        <a href="goods.html"><img src="img/good_01.jpg" alt=""></a>
                    </div>
                    <p class="name">
                        <a href="goods.html">Кайт <span class="upper">Blade Skinny boy</span>
                        <span class="year">2015</span></a>
                    </p>
                    <p class="price">
                        <span class="red">153 900 p</span>
                    </p>
                </article>
                <article>
                    <div class="img">
                        <div class="new">Новинка</div>
                        <a href="goods.html"><img src="img/good_01.jpg" alt=""></a>
                    </div>
                    <p class="name">
                        <a href="goods.html">Кайт <span class="upper">Blade Skinny boy</span>
                        <span class="year">2015</span></a>
                    </p>
                    <p class="price">
                        <span class="red">153 900 p</span>
                    </p>
                </article>
                <article>
                    <div class="img">
                        <div class="new">Новинка</div>
                        <a href="goods.html"><img src="img/good_01.jpg" alt=""></a>
                    </div>
                    <p class="name">
                        <a href="goods.html">Кайт <span class="upper">Blade Skinny boy</span>
                        <span class="year">2015</span></a>
                    </p>
                    <p class="price">
                        <span class="red">153 900 p</span>
                    </p>
                </article>
                <article>
                    <div class="img">
                        <div class="new">Новинка</div>
                        <a href="goods.html"><img src="img/good_01.jpg" alt=""></a>
                    </div>
                    <p class="name">
                        <a href="goods.html">Кайт <span class="upper">Blade Skinny boy</span>
                        <span class="year">2015</span></a>
                    </p>
                    <p class="price">
                        <span class="red">153 900 p</span>
                    </p>
                </article>
                <article>
                    <div class="img">
                        <div class="new">Новинка</div>
                        <a href="goods.html"><img src="img/good_01.jpg" alt=""></a>
                    </div>
                    <p class="name">
                        <a href="goods.html">Кайт <span class="upper">Blade Skinny boy</span>
                        <span class="year">2015</span></a>
                    </p>
                    <p class="price">
                        <span class="red">153 900 p</span>
                    </p>
                </article>
                <article>
                    <div class="img">
                        <div class="new">Новинка</div>
                        <a href="goods.html"><img src="img/good_01.jpg" alt=""></a>
                    </div>
                    <p class="name">
                        <a href="goods.html">Кайт <span class="upper">Blade Skinny boy</span>
                        <span class="year">2015</span></a>
                    </p>
                    <p class="price">
                        <span class="red">153 900 p</span>
                    </p>
                </article>
                <article>
                    <div class="img">
                        <div class="new">Новинка</div>
                        <a href="goods.html"><img src="img/good_01.jpg" alt=""></a>
                    </div>
                    <p class="name">
                        <a href="goods.html">Кайт <span class="upper">Blade Skinny boy</span>
                        <span class="year">2015</span></a>
                    </p>
                    <p class="price">
                        <span class="red">153 900 p</span>
                    </p>
                </article>
                <article>
                    <div class="img">
                        <div class="new">Новинка</div>
                        <a href="goods.html"><img src="img/good_01.jpg" alt=""></a>
                    </div>
                    <p class="name">
                        <a href="goods.html">Кайт <span class="upper">Blade Skinny boy</span>
                        <span class="year">2015</span></a>
                    </p>
                    <p class="price">
                        <span class="red">153 900 p</span>
                    </p>
                </article>
            </div>
        </div>
    </div>



    <div class="brends">
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
<div class="white_bg">
	<div class="container home_container">
<?php // echo $column_left; ?>
<?php // echo $column_right; ?>

<?php // echo $content_bottom; ?>

	</div>

</main>
</div>

<?php echo $footer; ?>