<?php echo $header; ?>

<div class="global c3">
    <div class="container">
        <div class="global_title"><h1><?php echo $heading_title; ?></h1>
            <span><?php
                foreach ( $breadcrumbs as $breadcrumb )
                {
                    ?>
                    <?php
                    if ( $breadcrumb[ 'separator' ] )
                    {
                        ?>><?php } ?> <a href="<?php echo $breadcrumb[ 'href' ]; ?>"><?php echo $breadcrumb[ 'text' ]; ?></a>
                <?php } ?></span></div>
    </div>
</div>
<style> 
	
	.product-grid .strs {
    display: none;
}

.product-grid .product_l .price .percent_span {
      display: none;
}


.product-list .product_l .price .price-old {
    color: grey;
    display: block;
    font-size: 18px;
    left: 570px;
    position: absolute;
    text-decoration: line-through;
    top: 10px;
}

.product-list .product_l .price .percent_span {
    color: grey;
    display: block;
    font-size: 18px;
    left: 602px;
    position: absolute;
  
    top: 10px;
}

.product-list .product_l .price .price-new {
    font-size: 18px;
    left: 470px;
    position: absolute;
    top: 10px;
}

.product-list .product_l .name {
    color: #ca3939;
    display: inline !important;
    font-size: 18px;
    left: 30px;
    position: absolute;
    text-decoration: none;
    top: 10px;
}

.product-list .product_l {
    border: 1px solid #e8e6e6;
    display: block;
    height: 46px;
    margin-right: 15px;
    margin-top: 30px;
    position: relative;
}

.product-list .product_l .strs{ /*CSS for enlarged image*/  
position: absolute;
border: 2px solid #3d3d3d;
padding: 5px;
background: #fff;
#background-color: transparent; 
left: -1000px;
/* border: 1px solid white; */
visibility: hidden;
color: yellow;
text-decoration: none;
border-radius: 4px 4px 4px 4px;
-moz-border-radius: 4px 4px 4px 4px;
-webkit-border-radius: 4px 4px 4px 4px;
}  


.product-list .product_l:hover .strs{ /*CSS for enlarged image on hover*/  
visibility: visible;  
display: block!important;
top: -100px;  
#position: fixed;
left: 100px; /*position where enlarged image should offset horizontally */
#background-color: transparent;  
z-index: 50;  
}  


.product-list .product_l .image  {
   display: none;
}

.product-list .product_l .desc  {
   display: none;
}

	
</style>

 <script> 
	 $(function($){
	
		
	$('.product-filter .display .list').click(function(event){
		
		event.preventDefault();
		
		if($('.product-list').is(':hidden'))
		{
			$('.product-grid').fadeOut('fast',function(){
				$('.product-list').fadeIn();
			});
			
		}
	});

	$('.product-filter .display .grid').click(function(event){
		
		event.preventDefault();
		
		if($('.product-grid').is(':hidden'))
		{
			$('.product-list').fadeOut('fast',function(){
				$('.product-grid').fadeIn();
			});
					}
	});
	
	});
	 
	 
	 
 </script>
<div class="white_bg">
    <div class="container">
        <?php echo $column_left; ?>
       <div class="column_right">
         <?php echo $column_right; ?>
        </div> 
        <div id="main_column" class="m_special2">
            <!-- start content -->
            <!--
            <center><h1 class="c1_color">ДЕРЖАТЕЛЯМ ДИСКОНТНЫХ КАРТ КОНКУРЕНТОВ</h1></center><br />
            Информация для держателей различных клубных и магазинных дисконтных карт, дающих право на скидки, бонусы и спецпредложения при покупке кайтового оборудования! <b>Абсолютно все</b> ваши льготы действуют и у нас. При том, что мы обладаем самым большим ассортиментом на кайтовом рынке, мы всегда предложим Вам конкурентную цену!</p><br />
            <p style="text-align: center;"><img src="http://kites.ru/kites/proshop/08.jpg" alt="ProShop"></p>
            <br><br /><br />
            <center><h1 class="c1_color">СОВМЕСТНАЯ АКЦИЯ ПРО ЦЕНТРА СОЛОВЕЙКИНА И КАЙТ МАГАЗИНА "PRO SHOP"</h1></center><br />
            <p style="text-align: left;">Вниманию клиентов Кайт магазина "Pro Shop"! При покупке кайтового оборудования Вы получаете возможность бесплатно обучаться в Про Центре Михаила Соловейкина. При покупке <a href="http://shop.kites.ru/%D0%BA%D0%B0%D0%B9%D1%82%D1%8B/%D0%BF%D0%BB%D0%BE%D1%81%D0%BA%D0%B8%D0%B5%20%D0%BA%D0%B0%D0%B9%D1%82%D1%8B">плоского кайта</a> выдаётся именной сертификат на 5 часов обучения, при покупке <a href="http://shop.kites.ru/%D0%B4%D0%BE%D1%81%D0%BA%D0%B8">доски</a> - на 3 часа и при покупке <a href="http://shop.kites.ru/%D0%A2%D1%80%D0%B0%D0%BF%D0%B5%D1%86%D0%B8%D0%B8">трапеции</a> - на 1 час.</p>
            <p style="text-align: center;"><img src="http://www.kites.ru/storage/procenter/da1cef494b079628f3cbe26358a3dfc1.jpg" alt="именной сертификат"></p>
            <p style="text-align: left;">Именные сертификаты действительны в течение одного года с момента выдачи только при оплате полного <a target="_blank"href="http://kites.ru/%D1%88%D0%BA%D0%BE%D0%BB%D0%B0/%D1%86%D0%B5%D0%BD%D1%8B/">10-ти часового курса</a> обучения в Про Центре Соловейкина. Общее количество часов, представленных одним лицом по нескольким сертификатам не может превышать 9 часов за один оплаченный курс.</p>
            <br />
            -->
          
            <!-- end content -->
            <?php echo $content_top; ?>


            <?php
            if ( $products )
            {
                ?>
                <div class="product-filter" style="width:680px;">
                    <div class="display" style="padding-right:50px;padding-top:3px;">
					<a style="text-decoration: none;font-size:15px;color:#000;padding-right:15px;" href="#" class="list">Список</a><a style="text-decoration: none;font-size:15px;color:#000;" href="#" class="grid">Сетка</a>
					<!--<b><?php echo $text_display; ?></b>
                        <select class="select_display" onchange="display('');">
                            <option value="list" <? if($_COOKIE['display'] == 'list'){echo 'selected="selected"';} ?>>Список</option>
							<option value="grid" <? if($_COOKIE['display'] == 'grid'){echo 'selected="selected"';} ?>>Витрина</option>
                     </select>-->
					</div>
					<div class="limit" style="margin-top:2px;">
					<ul>
						<!--<li><?php echo $text_limit; ?></li>-->
							<?php foreach ($limits as $limites) { ?>
						<li><?php if ($limites['value'] == $limit) { ?><span class="active"><?php echo $limites['text']; ?></a></span><?php } else { ?><a href="<?php echo $limites['href']; ?>"><?php echo $limites['text']; ?></a><?php } ?></li>
							<?php } ?>
					</ul>
					</div>
                    <div class="limit" style="display:none;"><label><?php echo $text_limit; ?></label>
                        <select onchange="location = this.value;">
                            <?php
                            foreach ( $limits as $limits )
                            {
                                ?>
                                <?php
                                if ( $limits[ 'value' ] == $limit )
                                {
                                    ?>
                                    <option value="<?php echo $limits[ 'href' ]; ?>" selected="selected"><?php echo $limits[ 'text' ]; ?></option>
                                    <?php
                                }
                                else
                                {
                                    ?>
                                    <option value="<?php echo $limits[ 'href' ]; ?>"><?php echo $limits[ 'text' ]; ?></option>
                                <?php } ?>
                            <?php } ?>
                        </select>
                    </div>
					<link rel="stylesheet" type="text/css" href="catalog/view/stylesheet/sha-sort.css" />
					<div id="sha-sort"><!-- <b><?php echo $text_sort; ?></b> -->
						<?php foreach ($sorts as $sort_key => $sort_val) { ?>
						<a style="text-align:center" sort-class="<?php echo $sort_val['value']; ?>" class="sha-sortitem<?php if (($sort_key>=1)&&($sort_val['value'] == $sort . '-' . $order)) { ?> selected<?php } ?><?php if ($sorts[$sort_key + 1]['value'] == $sort . '-' . $order) { ?> next-selected<?php } ?>" href="<?php echo $sort_val['href']; ?>"><span></span><?php echo $sort_val['text']; ?></a>
						<?php } ?>
					</div>
                    <div class="sort" style="display:none;"><b><?php echo $text_sort; ?></b>
                       <select id="filterpro_outer_sort" onchange="doFilter(true);">
                            <?php foreach ( $sorts as $sort_val ) { ?>
                                <?php
                                if ( $sort_val[ 'value' ] == $sort . '-' . $order )
                                {
                                    ?>
                                    <option value="<?php echo $sort_val[ 'value' ]; ?>" data-st="<?php echo $sort_val[ 'value' ]; ?>" selected="selected"><?php echo $sort_val[ 'text' ]; ?></option>
                                    <?php
                                }
                                else
                                {
                                    ?>
                                    <option  value="<?php echo $sort_val[ 'value' ]; ?>" data-st="<?php echo $sort_val[ 'value' ]; ?>" ><?php echo $sort_val[ 'text' ]; ?></option>
                                <?php } ?>
                            <?php } ?>		
                        </select>                    </div>
                                       
                </div>

                <div id="notification" class="c1"></div>
                <!-- List type -->
                <div class="product-list">
                    <?php
                    foreach ( $products as $product )
                    {
                        ?>
                        <div class="product_l">
                            <?php
                            $product[ 'price' ] = str_replace( ',' , '.' , $product[ 'price' ] );
                            $product[ 'price' ] = str_replace_once( '.' , '' , $product[ 'price' ] );
                            $product[ 'special' ] = str_replace( ',' , '.' , $product[ 'special' ] );
                            $product[ 'special' ] = str_replace_once( '.' , '' , $product[ 'special' ] );
                            $skidka = round( ((floatval( $product[ 'price' ] ) - floatval( $product[ 'special' ] )) / floatval( $product[ 'price' ] )) * 100 , 2 );
                            ;
                            /*  $product['price'] =str_replace_once('.',',',$product['price']);
                              $product['special'] =str_replace_once('.',',',$product['special']); */

                            if ( $product[ 'thumb' ] )
                            {
                                ?>
                                <div class="image"><a class="thumbnail" href="<?php echo $product[ 'href' ]; ?>">
                                        <img src="<?php echo $product[ 'thumb' ]; ?>" title="<?php echo $product[ 'name' ]; ?>" alt="<?php echo $product[ 'name' ]; ?>" />
                                        <span>
                                            <table><tr><td>
                                                        <img style="max-width:300px" src="/image/<?php echo $product[ 'img' ]; ?>"  />
                                                    </td><td style=" text-align:center;">
                                                        <div class="c1 product-price" style="padding:6px;width:70px; "><div style="color:#000;" id="opu_special"><?php echo $product[ 'special' ]; ?></div></div>
                                                        <br>
                                                <strike style="color: #000;"><?php echo $product[ 'price' ]; ?></strike><br><br>
                                                <div class="percent_span" style="color: #444444;" title="Скидка в процентах">Скидка <?php echo $skidka; ?>%</div></td></tr></table>
                                        </span></a></div>
                            <?php } ?>
                            <a class="product_price_overlay" href="<?php echo $product[ 'href' ]; ?>"><?php
                                if ( $product[ 'price' ] )
                                {
                                    ?>
                                    <div class="price">
                                        <?php
                                        if ( !$product[ 'special' ] )
                                        {
                                            ?>
                                            <?php echo $product[ 'price' ]; ?>
                                            <?php
                                        }
                                        else
                                        {
                                            ?>
                                            <?php echo $product[ 'special' ]; ?>
                                        <?php } ?>

                                    </div>
                                <?php } ?></a>
                            <a class="name c1_color" href="<?php echo $product[ 'href' ]; ?>"><h2><?php echo $product[ 'name' ]; ?></h2></a>
                            <div class="desc"><?php echo $product[ 'description' ]; ?></div>
                            <?php
                            if ( $product[ 'price' ] )
                            {
                                ?>
                                <div class="price">
                                    <?php
                                    if ( !$product[ 'special' ] )
                                    {
                                        ?>
                                        <span class="price-new c2_color"><?php echo $product[ 'price' ]; ?></span>
                                        <?php
                                    }
                                    else
                                    {
                                        ?>
                                        <span class="price-new c2_color"><?php echo $product[ 'special' ]; ?></span>
                                    <?php } ?>
                                    <!--  <?php
                                    if ( $product[ 'tax' ] )
                                    {
                                        ?>
                                                                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product[ 'tax' ]; ?></span>
                                    <?php } ?>  -->
                                </div>
                            <?php } ?>
                            <a class="prod_overlay" href="<?php echo $product[ 'href' ]; ?>"></a>
                            <a href="#" class="cart" rel="<?php echo $product[ 'product_id' ]; ?>" ><?php echo $button_cart; ?></a>
                            <a class="wishlist" href="#" rel="<?php echo $product[ 'product_id' ]; ?>"><?php echo $button_wishlist; ?></a>
                            <a class="compare" href="#" rel="<?php echo $product[ 'product_id' ]; ?>"><?php echo $button_compare; ?></a>

                        </div>
                    <?php } ?>
                </div>
                <!-- Grid Type -->
                <div class="product-grid" style="width:684px;">
                    <?php
                    foreach ( $products as $product )
                    {
                        ?>

                        <div class="product_l">
                            <?php
                            if ( $product[ 'thumb' ] )
                            {
                                ?>
                                <div class="image"><a href="<?= $product[ 'href' ] ?>"><img src="<?= $product[ 'thumb' ] ?>" title="<?= $product[ 'title' ] ?>" alt="<?= $product[ 'name' ] ?>"/></a></div>
                            <?php } ?>
                            <div class="desc"><?= $product[ 'description' ] ?></div>
                            <a class="product_price_overlay" href="<?= $product[ 'href' ] ?>">
                                <?php
                                if ( $product[ 'price' ] )
                                {
                                    ?>
                                    <div class="price">
                                        <?php
                                        if ( $product[ 'special' ] )
                                        {
                                            ?>
                                            <span class="price-new"><?= $product[ 'special' ] ?></span> <span class="price-old"><?= $product[ 'price' ] ?></span>
                                            <?php
                                        }
                                        else
                                        {
                                            ?>
                                            <?= $product[ 'price' ] ?>
                                        <?php } ?>

                                    </div>
                                <?php } ?>
                            </a>
                            <?php
                            if ( $product[ 'price' ] )
                            {
                                ?>
                                <div class="price">
                                    <?php
                                    if ( $product[ 'special' ] )
                                    {
                                        ?>
                                        <span class="price-new c2_color"><?= $product[ 'special' ] ?></span> <span class="price-old"><?= $product[ 'price' ] ?></span>
                                        <?php
                                    }
                                    else
                                    {
                                        ?>
                                        <span class="price-new c1_color"><?= $product[ 'price' ] ?></span>
                                    <?php } ?>

                                </div>
                            <?php } ?>
                            <a class="name" href="<?= $product[ 'href' ] ?>"><?= $product[ 'name' ] ?></a>
                            <a class="prod_overlay" href="<?= $product[ 'href' ] ?>"></a>
                            <a class="cart" href="#"  rel="<?= $product[ 'product_id' ] ?>"><?php echo $button_cart; ?></a>
                            <a class="wishlist" href="#" rel="<?= $product[ 'product_id' ] ?>"><?php echo $button_wishlist; ?></a>
                            <a class="compare" href="#" rel="<?= $product[ 'product_id' ] ?>"><?php echo $button_compare; ?></a>


                        </div>
                    <?php } ?>
                </div>  

                <div class="pagination"><?php echo $pagination; ?></div>
            <?php } ?>
            <?php
            if ( !$products )
            {
                ?>
                <div class="content"><?php echo $text_empty; ?></div>
            <?php } ?>
            <?php echo $content_bottom; ?></div>
    </div>
    <div class="c"></div>
</div>
<script type="text/javascript"><!--
function display(view) {
        view = $(".select_display option:selected").val();
        $('.product_l').unbind('mouseenter mouseleave');
        //$('.product-grid .product_l').unbind('mouseenter mouseleave');



        //$('.product_l').removeClass('test2');
        /*if (view == 'list') {
            $('.product-grid').attr('class', 'product-list');
            $(".grid option").each(function() {
                if ($(this).val() == 'list') {
                    $(this).attr("selected", true);
                }
            });
            $.cookie('display', 'list');

        } else {
            $('.product-list').attr('class', 'product-grid');
            $(".grid option").each(function() {
                if ($(this).val() == 'grid') {
                    $(this).attr("selected", true);
                }
            });
            $.cookie('display', 'grid');
        }
        
         $('.product-list .product_l').hover(function(){
         $t = $(this);
         $t.find('.prod_overlay').fadeTo(0, 0.6).animate({
         height: 213
         },'fast');
         
         $t.find('.product_price_overlay').animate({
         top : 50,
         opacity : 'toggle'
         });
         $t.find('.cart').fadeIn();
         $t.find('.wishlist').fadeIn();  
         $t.find('.compare').fadeIn();  
         
         
         }, function(){
         
         $t = $(this);    	
         
         $t.find('.prod_overlay').hide().css('height', '0px');
         $t.find('.product_price_overlay').animate({
         opacity : 'toggle',
         top : -30
         });
         $t.find('.cart').fadeOut();
         $t.find('.wishlist').fadeOut();  
         $t.find('.compare').fadeOut();  
         
         });	
         */
//			$('.product-grid .product_l').hover(function(){
//				$t = $(this);
//				
//				$t.find('.prod_overlay').fadeTo(0, 0.6).animate({
//					height: 213
//				},'fast');
//				
//				$t.find('.product_price_overlay').animate({
//					top : 30,
//					opacity : 'toggle'
//				});
//				$t.find('.cart').fadeIn();  		
//				setTimeout(function(){
//					$t.find('.name').show();
//				},200);
//				
//			}, function(){
//				
//				$t = $(this);    	
//				
//				$t.find('.prod_overlay').hide().css('height', '0px');
//				$t.find('.product_price_overlay').animate({
//					opacity : 'toggle',
//					top : -30
//				});
//				$t.find('.cart').fadeOut();
//				$t.find('.name').hide();
//				
//			});	

    }


    view = $.cookie('display');

    if (view) {
        display(view);
    } else {
        display('grid');
    }
//--></script>
<?php
echo $footer;

function str_replace_once( $search , $replace , $text )
{
    $pos = strpos( $text , $search );
    return $pos !== false ? substr_replace( $text , $replace , $pos , strlen( $search ) ) : $text;
}
?>