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
<?php
if ( $description )
{
    ?>
    <div class="main_bg">
        <div class="container">
            <div style="float:left; width:600px; line-height:1.5em;    text-shadow: 1px 1px #fff; color:#5f5d5d">
                <?php echo $description; ?>
            </div>
            <div class="shop_info">
                <h2 class="c1_color">Клиенту на заметку</h2>
                <ul>
                    <li><a href="<?php echo $this->url->link( 'checkout/voucher' ); ?>"><?php echo $this->language->get( 'text_voucher' ); ?></a></li>
                    <li><a href="<?php echo $this->url->link( 'information/information&information_id=6' ); ?>"><?php echo $this->language->get( 'text_delivery' ); ?></a></li>
                    <li><a href="<?php echo $this->url->link( 'information/information&information_id=5' ); ?>"><?php echo $this->language->get( 'text_terms' ); ?></a></li>
                    <li><a href="<?php echo $this->url->link( 'product/special' ); ?>"><?php echo $this->language->get( 'text_special' ); ?></a></li>
                </ul>
            </div>
            <div class="c"></div>
        </div>
    </div>
<?php } ?>
<div class="c"></div>

<div class="white_bg">
    <div class="container">


        <div class="column_right">
            <?php
            if ( $categories )
            {
                ?><div class="column_cont">
                    <div class="column_head c1"><h3><!-- <?php echo $text_refine; ?> --> <?php echo $heading_title; ?> </h3></div>
                    <div class="column_content">
                        <?php
                        if ( count( $categories ) <= 5 )
                        {
                            ?>
                            <ul class="list">
                                <?php
                                foreach ( $categories as $category )
                                {
                                    ?>
                                    <li><a href="<?php echo $category[ 'href' ]; ?>"><?php echo $category[ 'name' ]; ?></a></li>
                                <?php } ?>
                            </ul>
                            <?php
                        }
                        else
                        {
                            ?>
                            <?php
                            for ( $i = 0; $i < count( $categories ); )
                            {
                                ?>
                                <ul class="list">
                                    <?php $j = $i + ceil( count( $categories ) / 4 ); ?>
                                    <?php
                                    for (; $i < $j; $i++ )
                                    {
                                        ?>
                                        <?php
                                        if ( isset( $categories[ $i ] ) )
                                        {
                                            ?>
                                            <li><a href="<?php echo $categories[ $i ][ 'href' ]; ?>"><?php echo $categories[ $i ][ 'name' ]; ?></a></li>
                                        <?php } ?>
                                    <?php } ?>
                                </ul>
                            <?php } ?>
                        <?php } ?>
                    </div></div><?php } ?>
            <?php echo $column_right; ?></div>


        <?php
        if ( $products )
        {
            ?>
            <div id="main_column" <?php if ( empty( $column_right ) && empty( $categories ) ) echo 'class="m_special"'; ?>>
                                <div class="product-filter" style="width:680px;">
                   <div class="display" style="padding-right:50px;padding-top:3px;">
					<a style="text-decoration: none;font-size:15px;color:#000;padding-right:15px;" href="#" class="list">Список</a><a style="text-decoration: none;font-size:15px;color:#000;" href="#" class="grid">Сетка</a>
                        <!--<b><?php echo $text_display; ?></b>
                        <select class="select_display" onchange="display('');">
                            <option value="grid" <? if($_COOKIE['display'] == 'grid'){echo 'selected="selected"';} ?>>Витрина</option>
                            <option value="list" <? if($_COOKIE['display'] == 'list'){echo 'selected="selected"';} ?>>Список</option>
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
                    <div class="limit" style="display:none" ><label><?php echo $text_limit; ?></label>
                        <select onchange="location = this.value;">
                            <?php foreach ( $limits as $limits ) { ?>
                                <?php if ( $limits[ 'value' ] == $limit ) { ?>
                                    <option value="<?php echo $limits[ 'href' ]; ?>" selected="selected"><?php echo $limits[ 'text' ]; ?></option>
                                    <?php } else { ?>
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
                  <div class="product-list">
                    <?php
                    foreach ( $products as $product )
                    {
                        ?>
                        <div class="product_l">
                            <?php
                          
                            $skidka = round( ((floatval( $product[ 'price' ] ) - floatval( $product[ 'special' ] )) / floatval( $product[ 'price' ] )) * 100 , 2 );
                            
                           

                            if ( $product[ 'thumb' ] )
                            {
                                ?>
                                <div class="image"><a class="thumbnail" href="<?php echo $product[ 'href' ]; ?>">
                                        <img src="<?php echo $product[ 'thumb' ]; ?>" title="<?php echo $product[ 'name' ]; ?>" alt="<?php echo $product[ 'name' ]; ?>" />
                                 <? if(!empty($product[ 'special' ])) { ?>      <span>
                                            <table><tr><td>
                                                        <img style="max-width:300px" src="/image/<?php echo $product[ 'img' ]; ?>"  />
                                                    </td><td style=" text-align:center;">
                                                        <div class="c1 product-price" style="padding:6px;width:70px; "><div style="color:#000;" id="opu_special"><?php echo $product[ 'special' ]; ?></div></div>
                                                        <br>
                                                <strike style="color: #000;"><?php echo $product[ 'price' ]; ?></strike><br><br>
                                                <div class="percent_span" style="color: #444444;" title="Скидка в процентах">Скидка <?php echo $skidka; ?>%</div></td></tr></table>
                                        </span>
                                        
                                        <? } else { ?>
                                        
                                        
                                         <span>
                                            <table><tr><td>
                                                        <img style="max-width:300px" src="/image/<?php echo $product[ 'img' ]; ?>"  />
                                                    </td><td style=" text-align:center;">
                                                        <div class="c1 product-price" style="padding:6px;width:70px; "><div style="color:#000;" id="opu_special"><?php echo $product[ 'sprice' ]; ?></div></div>
                                                        <br>
                                             <br><br>
                                              </td></tr></table>
                                        </span>
                                        
                                        <? } ?>
                                        
                                        
                                        </a></div>
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
                <div class="product-grid">
                    <?php
                    foreach ( $products as $product )
                    {
                        ?>
                        <div class="product_l">
                            <?php
                            if ( $product[ 'thumb' ] )
                            {
                                ?>
                                <div class="image"><a href="<?php echo $product[ 'href' ]; ?>"><img src="<?php echo $product[ 'thumb' ]; ?>" title="<?php echo $product[ 'name' ]; ?>" alt="<?php echo $product[ 'name' ]; ?>" /></a></div>
                            <?php } ?>
                            <div class="desc"><?php echo $product[ 'description' ]; ?></div>
                            <a class="product_price_overlay" href="<?php echo $product[ 'href' ]; ?>"><?php
                            
                                if ( $product[ 'price' ] )
                                {
                                    ?>
                                    <div class="price">
                                        <?php
                                        if ( !$product[ 'special' ] )
                                        {
                                            echo $product[ 'price' ];
                                        }
                                        else
                                        {
                                            ?>
                                            <span class="price-new" style="color:red"><?php echo $product[ 'special' ]; ?></span> <span class="price-old"><?php echo $product[ 'price' ]; ?></span>
                                        <?php } ?>

                                    </div>
                                <?php } ?></a>
                            <a class="name" href="<?php echo $product[ 'href' ]; ?>"><?php echo $product[ 'name' ]; ?></a>
                            <a class="prod_overlay" href="<?php echo $product[ 'href' ]; ?>"></a>
                            <a href="#" class="cart" rel="<?php echo $product[ 'product_id' ]; ?>" ><?php echo $button_cart; ?></a>
                            <a class="wishlist" href="#" rel="<?php echo $product[ 'product_id' ]; ?>"><?php echo $button_wishlist; ?></a>
                            <a class="compare" href="#" rel="<?php echo $product[ 'product_id' ]; ?>"><?php echo $button_compare; ?></a>
                        </div>
                    <?php } ?>
                </div>  

                <div class="pagination">
                    <?php
                    $pagination_new_urls = str_replace( '/?page=' , '/page/' , $pagination );
                    $pagination_new_urls = str_replace( '/page/1/' , '/' , $pagination_new_urls );
                    echo $pagination_new_urls;
                    ?></div>
            </div>
            <?php
        }
        else
        {
            ?>
            <div id="main_column">
                <?php echo $text_empty; ?>
            </div>
        <?php } ?>
        <?php echo $content_bottom; ?>
    </div>
    <div class="c"></div>
</div>
<script type="text/javascript"><!--
function displays(view) {
	if (view == 'list') {
		$('.product-grid').attr('class', 'product-list');
        //$('.product-grid .product_l').unbind('mouseenter mouseleave');



        //$('.product_l').removeClass('test2');
        if (view == 'list') {
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
      
      

    }  }


    view = $.cookie('display');

    if (view) {
   //     display(view);
    } else {
     //   display('grid');
    }
//--></script>
<?php echo $footer; ?>