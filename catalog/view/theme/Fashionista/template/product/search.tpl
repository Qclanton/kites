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
<div class="c"></div>

<div class="white_bg">
    <div class="container">

        <div id="main_column" class="m_special">

            <h2 class="c3_color"><?php echo $text_critea; ?></h2><br />
            <div class="content">
                <p><?php echo $entry_search; ?><br />
                    <?php
                    if ( $filter_name )
                    {
                        ?>
                        <input type="text" class="input" name="filter_search_name" value="<?php echo $filter_name; ?>" />
                        <?php
                    }
                    else
                    {
                        ?>
                        <input type="text" class="input" name="filter_search_name" value="<?php echo $filter_name; ?>" onclick="this.value = '';" onkeydown="this.style.color = '000000'" style="color: #999;" />
                    <?php } ?>
                    <select name="filter_category_id" class="input">
                        <option value="0"><?php echo $text_category; ?></option>
                        <?php
                        foreach ( $categories as $category_1 )
                        {
                            ?>
                            <?php
                            if ( $category_1[ 'category_id' ] == $filter_category_id )
                            {
                                ?>
                                <option value="<?php echo $category_1[ 'category_id' ]; ?>" selected="selected"><?php echo $category_1[ 'name' ]; ?></option>
                                <?php
                            }
                            else
                            {
                                ?>
                                <option value="<?php echo $category_1[ 'category_id' ]; ?>"><?php echo $category_1[ 'name' ]; ?></option>
                            <?php } ?>
                            <?php
                            foreach ( $category_1[ 'children' ] as $category_2 )
                            {
                                ?>
                                <?php
                                if ( $category_2[ 'category_id' ] == $filter_category_id )
                                {
                                    ?>
                                    <option value="<?php echo $category_2[ 'category_id' ]; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2[ 'name' ]; ?></option>
                                    <?php
                                }
                                else
                                {
                                    ?>
                                    <option value="<?php echo $category_2[ 'category_id' ]; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2[ 'name' ]; ?></option>
                                <?php } ?>
                                <?php
                                foreach ( $category_2[ 'children' ] as $category_3 )
                                {
                                    ?>
                                    <?php
                                    if ( $category_3[ 'category_id' ] == $filter_category_id )
                                    {
                                        ?>
                                        <option value="<?php echo $category_3[ 'category_id' ]; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3[ 'name' ]; ?></option>
                                        <?php
                                    }
                                    else
                                    {
                                        ?>
                                        <option value="<?php echo $category_3[ 'category_id' ]; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3[ 'name' ]; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            <?php } ?>
                        <?php } ?>
                    </select><br /><br />
                    <?php
                    if ( $filter_sub_category )
                    {
                        ?>
                        <input type="checkbox" name="filter_sub_category" value="1" id="sub_category" checked="checked" />
                        <?php
                    }
                    else
                    {
                        ?>
                        <input type="checkbox" name="filter_sub_category" value="1" id="sub_category" />
                    <?php } ?>
                    <label for="sub_category"><?php echo $text_sub_category; ?></label>
                </p>
                <?php
                if ( $filter_description )
                {
                    ?>
                    <input type="checkbox" name="filter_description" value="1" id="description" checked="checked" />
                    <?php
                }
                else
                {
                    ?>
                    <input type="checkbox" name="filter_description" value="1" id="description" />
                <?php } ?>
                <label for="description"><?php echo $entry_description; ?></label>
            </div>
            <br /><br />
            <div class="button c1"><a id="button-search" href="#"><span><?php echo $button_search; ?></span></a></div>
            <div class="c"></div>
            <br /><br /><br /><br />
            <h2 class="c1_color"><?php echo $text_search; ?></h2>
            <br />
            <?php
            if ( $products )
            {
                ?>
                <div class="product-filter">
                    <div class="display">
					<a href="#" class="list"></a> <a href="#" class="grid"></a>
					<!--<b><?php echo $text_display; ?></b>
                        <select class="select_display" onchange="display('');">
                            <option value="grid" <? if($_COOKIE['display'] == 'grid'){echo 'selected="selected"';} ?>>Витрина</option>
                            <option value="list" <? if($_COOKIE['display'] == 'list'){echo 'selected="selected"';} ?>>Список</option>
                        </select>-->
					</div>
					<div class="limit" style="margin-top:2px;">
					<ul>
						<li><?php echo $text_limit; ?></li>
							<?php foreach ($limits as $limites) { ?>
						<li><?php if ($limites['value'] == $limit) { ?><span class="active"><?php echo $limites['text']; ?></a></span><?php } else { ?><a href="<?php echo $limites['href']; ?>"><?php echo $limites['text']; ?></a><?php } ?></li>
							<?php } ?>
					</ul>
					</div>
					<link rel="stylesheet" type="text/css" href="catalog/view/stylesheet/sha-sort.css" />
					<div id="sha-sort"><!-- <b><?php echo $text_sort; ?></b> -->
						<?php foreach ($sorts as $sort_key => $sort_val) { ?>
						<a style="text-align:center" sort-class="<?php echo $sort_val['value']; ?>" class="sha-sortitem<?php if ($sort_val['value'] == $sort . '-' . $order) { ?> selected<?php } ?><?php if ($sorts[$sort_key + 1]['value'] == $sort . '-' . $order) { ?> next-selected<?php } ?>" href="<?php echo $sort_val['href']; ?>"><span></span><?php echo $sort_val['text']; ?></a>
						<?php } ?>
					</div>
                    <!--<div class="limit"><label><?php echo $text_limit; ?></label>
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
                    <div class="sort"><b><?php echo $text_sort; ?></b>
                        <select onchange="location = this.value;">
                            <?php
                            foreach ( $sorts as $sorts )
                            {
                                ?>
                                <?php
                                if ( $sorts[ 'value' ] == $sort . '-' . $order )
                                {
                                    ?>
                                    <option value="<?php echo $sorts[ 'href' ]; ?>" selected="selected"><?php echo $sorts[ 'text' ]; ?></option>
                                    <?php
                                }
                                else
                                {
                                    ?>
                                    <option value="<?php echo $sorts[ 'href' ]; ?>"><?php echo $sorts[ 'text' ]; ?></option>
                                <?php } ?>
                            <?php } ?>
                        </select>
                    </div>-->
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
                            if ( $product[ 'thumb' ] )
                            {
                                ?>
                                <div class="image"><a href="<?php echo $product[ 'href' ]; ?>"><img src="<?php echo $product[ 'thumb' ]; ?>" title="<?php echo $product[ 'name' ]; ?>" alt="<?php echo $product[ 'name' ]; ?>" /></a></div>
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
                                        <span class="price-new c1_color"><?php echo $product[ 'price' ]; ?></span>
                                        <?php
                                    }
                                    else
                                    {
                                        ?>
                                        <span class="price-new c1_color"><?php echo $product[ 'special' ]; ?></span>
                                    <?php } ?>
                                    <?php
                                    if ( $product[ 'tax' ] )
                                    {
                                        ?>
                                        <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product[ 'tax' ]; ?></span>
                                    <?php } ?>
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
                <div class="product-grid" style="width:700px;display: inline-block;">
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


                        <?php /*

                          <div class="product_l">
                          <?php
                          if ( $product[ 'thumb' ] )
                          {
                          ?>
                          <div class="image"><a href="<?php echo $product[ 'href' ]; ?>"><img src="<?php echo $product[ 'thumb' ]; ?>" title="<?php echo $product[ 'name' ]; ?>" alt="<?php echo $product[ 'name' ]; ?>" /></a></div>
                          <?php } ?>
                          <?php
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
                          <?php } ?>
                          <a class="name" href="<?php echo $product[ 'href' ]; ?>"><?php echo $product[ 'name' ]; ?></a>
                          <a class="prod_overlay" href="<?php echo $product[ 'href' ]; ?>"></a>
                          <a href="#" class="cart" rel="<?php echo $product[ 'product_id' ]; ?>" ><?php echo $button_cart; ?></a>
                          </div> */ ?>
                    <?php } ?>
                </div>  

                <div style="width:200px; margin:30px 0 30px 30px; padding:15px; float:right; background: #eee">
                    <?php
                    $this->load->model( 'catalog/manufacturer' );
                    $m = $this->model_catalog_manufacturer->getManufacturers();

                    $manufs_selected = array();
                    if ( $this->request->get[ 'manufilter' ] )
                    {
                        if ( $this->request->get[ 'manufilter' ][ 0 ] == ',' )
                        {
                            $this->request->get[ 'manufilter' ] = substr( $this->request->get[ 'manufilter' ] , 1 );
                        }

                        $manufs_selected = explode( ',' , $this->request->get[ 'manufilter' ] );
                    }


                    foreach ( $m as $k => $v )
                    {
                        ?>

                                                                                <!--<input onclick="manufilter = manufilter + ',<?= $v[ 'manufacturer_id' ] ?>';$('#button-search').trigger('click');" type="checkbox" <?= ( in_array( $v[ 'manufacturer_id' ] , $manufs_selected ) ? 'checked' : '' ) ?> name="manufilter[<?= $v[ 'manufacturer_id' ] ?>]" value="1"> <?= $v[ 'name' ] ?> <br>-->
                        <input class="manufilter" onclick="cb_go(this);" xid="<?= $v[ 'manufacturer_id' ] ?>" type="checkbox" <?= ( in_array( $v[ 'manufacturer_id' ] , $manufs_selected ) ? 'checked' : '' ) ?> name="manufilter[<?= $v[ 'manufacturer_id' ] ?>]" value="1"> <?= $v[ 'name' ] ?> <br>

                        <?php
                    }
                    ?>

                </div>

                <div class="pagination"><?php echo $pagination; ?></div>

                <?php
            }
            else
            {
                ?>

                <div class="content"><?php echo $text_empty; ?></div>
            <?php } ?>

            <?php echo $content_bottom; ?>
        </div>
    </div>
    <div class="c"></div>
</div> 

<script>
    var manufilter = '<?php echo ( $this->request->get[ 'manufilter' ] ? $this->request->get[ 'manufilter' ] : '' ) ?>';

</script>
<script type="text/javascript"><!--
$('input[name=\'filter_search_name\']').keydown(function(e) {
        if (e.keyCode == 13) {
            $('#button-search').trigger('click');
        }
    });

    function cb_go(checkbox)
    {
        var tmp_m = new Array();
        $('.manufilter').each(function(index) {

            if ($(this).attr('checked'))
                tmp_m.push($(this).attr('xid'));
        });

        tmp_m = tmp_m.join();
        manufilter = tmp_m;

        $('#button-search').trigger('click');
    }

    $('#button-search').bind('click', function(event) {
        url = '<?php echo HTTP_SERVER; ?>index.php?route=product/search';
        event.preventDefault();

        var filter_name = $('input[name=\'filter_search_name\']').attr('value');

        if (filter_name) {
            url += '&filter_name=' + encodeURIComponent(filter_name);
        }


        var filter_category_id = $('select[name=\'filter_category_id\']').attr('value');

        if (filter_category_id > 0) {
            url += '&filter_category_id=' + encodeURIComponent(filter_category_id);
        }

        var filter_sub_category = $('input[name=\'filter_sub_category\']:checked').attr('value');

        if (filter_sub_category) {
            url += '&filter_sub_category=true';
        }

        var filter_description = $('input[name=\'filter_description\']:checked').attr('value');

        if (filter_description) {
            url += '&filter_description=true';
        }
        if (manufilter) {
            url += '&manufilter=' + manufilter;
        }
        location = url;
    });


//--></script>  
<?php echo $footer; ?>