<?php
if ( $options || $manufacturers || $attributes )
{
    ?>
    <div class="box">
        <div class="column_head c1"><h3><?php echo $heading_title; ?></h3></div>


        <div class="column_content">


            <div class="box-content">
                <div style="height: 15px"><a class="clear_filter"><?php echo $clear_filter ?></a></div>
                <form id="filterpro">
                    <?php
                    foreach ( $manufacturers as $manufacturer )
                    {
                        ?>
                        <input type="hidden" class="m_name" id="m_<?php echo $manufacturer[ 'manufacturer_id' ] ?>" value="<?php echo $manufacturer[ 'name' ] ?>">
                    <?php } ?>

                    <?php
                    foreach ( $models as $model )
                    {
                        ?>
                        <input type="hidden" class="mm_name" id="mm_<?php echo $model ?>" god="mm_<?php echo $model ?>" value="<?php echo $model ?>">
                    <?php } ?>

                    <?php
                    foreach ( $options as $option )
                    {
                        ?>
                        <?php
                        foreach ( $option[ 'option_values' ] as $option_value )
                        {
                            ?>
                            <input type="hidden" class="o_name" id="o_<?php echo $option_value[ 'option_value_id' ] ?>" value="<?php echo $option_value[ 'name' ] ?>">
                        <?php } ?>
                    <?php } ?>
                    <input type="hidden" name="category_id" value="<?php echo $category_id ?>">
                    <input type="hidden" name="page" id="filterpro_page" value="0">
                    <input type="hidden" name="path" value="<?php echo $path ?>">
                    <input type="hidden" name="sort" id="filterpro_sort" value="">
                    <input type="hidden" name="order" id="filterpro_order" value="">
                    <input type="hidden" name="limit" id="filterpro_limit" value="">

                    <div class="price_slider">
                            <label for="min_price"><!-- <span style="color:#ca3939;"> --> <?php echo $text_price_range ?><!-- </span> --> </label><br/>
                        <table>
                            <tr>
                                <td><input class="price_limit" type="text" name="min_price" value="-1" id="min_price"/></td>
                                <td><input class="price_limit2" type="text" name="max_price" value="-1" id="max_price"/></td>
                            </tr>
                        </table>

                        <div id="slider-range"></div>

                    </div>
                    <?php
                    if ( $manufacturers )
                    {
                        ?>
                        <div class="option_box">
                            <div class="option_name"><?php echo $text_manufacturers; ?></div>
                            <?php
                            if ( $display_manufacturer == 'select' )
                            {
                                ?>
                                <div class="collapsible">
                                    <select name="manufacturer[]" class="filtered">
                                        <option value=""><?php echo $text_all ?></option>
                                        <?php
                                        foreach ( $manufacturers as $manufacturer )
                                        {
                                            ?>
                                            <option id="manufacturer_<?php echo $manufacturer[ 'manufacturer_id' ] ?>" class="manufacturer_value" value="<?php echo $manufacturer[ 'manufacturer_id' ] ?>"><?php echo $manufacturer[ 'name' ] ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                                <?php
                            }
                            elseif ( $display_manufacturer == 'checkbox' )
                            {
                                ?>
                                <table class="collapsible">
                                    <?php
                                    foreach ( $manufacturers as $manufacturer )
                                    {
                                        ?>
                                        <tr>
                                            <td>
                                                <input id="manufacturer_<?php echo $manufacturer[ 'manufacturer_id' ] ?>" class="manufacturer_value filtered"
                                                       type="checkbox" name="manufacturer[]"
                                                       value="<?php echo $manufacturer[ 'manufacturer_id' ] ?>">
                                            </td>
                                            <td>
                                                <label for="manufacturer_<?php echo $manufacturer[ 'manufacturer_id' ] ?>"> &nbsp; <?php echo $manufacturer[ 'name' ] ?></label>
                                            </td>
                                        </tr>
                                    <?php } ?>
                                </table>
                                <?php
                            }
                            elseif ( $display_manufacturer == 'radio' )
                            {
                                ?>
                                <table class="collapsible">
                                    <?php
                                    foreach ( $manufacturers as $manufacturer )
                                    {
                                        ?>
                                        <tr>
                                            <td>
                                                <input id="manufacturer_<?php echo $manufacturer[ 'manufacturer_id' ] ?>" class="manufacturer_value filtered"
                                                       type="radio" name="manufacturer[]"
                                                       value="<?php echo $manufacturer[ 'manufacturer_id' ] ?>">
                                            </td>
                                            <td>
                                                <label for="manufacturer_<?php echo $manufacturer[ 'manufacturer_id' ] ?>"><?php echo $manufacturer[ 'name' ] ?></label>
                                            </td>
                                        </tr>
                                    <?php } ?>
                                </table>
                            <?php } ?>
                        </div>
                    <?php } ?>





                    <!-- filter by model -->


                    <?php
//$models = array('asd','sdf');
                    ?>

                    <?php
                    if ( $models )
                    {
                        ?>

                        <div class="option_box">

                            <div class="attribute_box">
                                <div class="option_name">Модель</div>


                                <table class="collapsible">
                                    <tbody>

                                        <?php
                                            $_other = array();
                                            $_years = array();
                                        foreach ( $models as $key => $model )
                                        {
                                            if ( strpos( $model , 'год' ) !== false )
                                            {
                                                $_years [$key] = $model;
                                            }
                                            else
                                            {
                                                $_other [$key] = $model;
                                            }
                                        }
                                        asort($_years);
                                        
                                       // $models = array_merge($_years,$_other);
                                        $models = $_years + $_other;
                                        /*
                                        die( 
                                                
                                                print_r($_years,true).
                                                print_r($_other,true).
                                                print_r($models,true)
                                                );
                                        */
                                        
                                       // $models = $_other;
                                        
                                        ?>


                                        <?php
                                        foreach ( $models as $key => $model )
                                        {
                                            ?>
                                            <tr>
                                                <td>
                                                    <input id="xmodel_<?= $model ?>" class="model_value filtered" name="model[]" value="<?= $model ?>" type="checkbox">
                                                </td>
                                                <td>
                                                    <label for="xmodel_<?= $model ?>"><?= $model ?></label>
                                                </td>
                                            </tr>

                                            <? } ?>
                                        </tbody>
                                    </table>


                                </div>
                            </div>


                            <? } ?>



                            <!-- end filter by model -->





                            <?php
                            if ( $attributes )
                            {
                                ?>
                                <?php
                                foreach ( $attributes as $attribute_group_id => $attribute )
                                {
                                    ?>
                                    <div class="option_box">
                                        <div class="attribute_group_name"><?php echo $attribute[ 'name' ]; ?></div>
                                        <?php
                                        foreach ( $attribute[ 'attribute_values' ] as $attribute_value_id => $attribute_value )
                                        {
                                            ?>
                                            <div class="attribute_box">
                                                <div class="option_name"><?php echo $attribute_value[ 'name' ]; ?></div>
                                                <?php
                                                if ( $attribute_value[ 'display' ] == 'select' )
                                                {
                                                    ?>
                                                    <div class="collapsible">
                                                        <select class="filtered" name="attribute_value[<?php echo $attribute_value_id ?>][]">
                                                            <option value=""><?php echo $text_all ?></option>
                                                            <?php
                                                            foreach ( $attribute_value[ 'values' ] as $i => $value )
                                                            {
                                                                ?>
                                                                <option class="a_name"
                                                                        at_v_i="<?php echo $attribute_value_id . '_' . $value ?>"
                                                                        at_v_t="<?php echo $attribute_value_id . '_' . $value ?>"
                                                                        data-value = "<?php echo $value ?>"
                                                                        value="<?php echo $value ?>"><?php echo $value ?></option>
                                                                    <?php } ?>
                                                        </select>
                                                    </div>
                                                    <?php
                                                }
                                                elseif ( $attribute_value[ 'display' ] == 'checkbox' )
                                                {
                                                    ?>
                                                    <table class="collapsible">
                                                        <?php
                                                        foreach ( $attribute_value[ 'values' ] as $i => $value )
                                                        {
                                                            ?>
                                                            <tr>
                                                                <td>
                                                                    <input class="filtered a_name"
                                                                           id="attribute_value_<?php echo $attribute_value_id . $i; ?>"
                                                                           type="checkbox" name="attribute_value[<?php echo $attribute_value_id ?>][]"
                                                                           at_v_i="<?php echo $attribute_value_id . '_' . $value ?>"
                                                                           value="<?php echo $value ?>">
                                                                </td>
                                                                <td>
                                                                    <label for="attribute_value_<?php echo $attribute_value_id . $i; ?>"
                                                                           at_v_t="<?php echo $attribute_value_id . '_' . $value ?>"
                                                                           data-value = "<?php echo $value ?>"
                                                                           value="<?php echo $value ?>"><?php echo $value ?></label>
                                                                </td>
                                                            </tr>
                                                        <?php } ?>
                                                    </table>
                                                    <?php
                                                }
                                                elseif ( $attribute_value[ 'display' ] == 'radio' )
                                                {
                                                    ?>
                                                    <table class="collapsible">
                                                        <?php
                                                        foreach ( $attribute_value[ 'values' ] as $i => $value )
                                                        {
                                                            ?>
                                                            <tr>
                                                                <td>
                                                                    <input class="filtered a_name"
                                                                           id="attribute_value_<?php echo $attribute_value_id . $i; ?>"
                                                                           type="radio" name="attribute_value[<?php echo $attribute_value_id ?>][]"
                                                                           at_v_i="<?php echo $attribute_value_id . '_' . $value ?>"
                                                                           value="<?php echo $value ?>">
                                                                </td>
                                                                <td>
                                                                    <label for="attribute_value_<?php echo $attribute_value_id . $i; ?>"
                                                                           at_v_t="<?php echo $attribute_value_id . '_' . $value ?>"
                                                                           data-value = "<?php echo $value ?>"
                                                                           value="<?php echo $value ?>"><?php echo $value ?></label>
                                                                </td>
                                                            </tr>
                                                        <?php } ?>
                                                    </table>
                                                    <?php
                                                }
                                                elseif ( $attribute_value[ 'display' ] == 'slider' )
                                                {
                                                    ?>					
                                                    <table class="collapsible" style="width:100%">
                                                        <tr>
                                                            <td><span id="attribute_label_<?php echo $attribute_value_id; ?>_min"><?php echo min( $attribute_value[ 'values' ] ) . $attribute_value[ 'suffix' ]; ?></span>
                                                                <input type="hidden" id="attribute_value_<?php echo $attribute_value_id; ?>_min" name="attr_slider[<?php echo $attribute_value_id ?>][min]" value="">
                                                            </td>
                                                            <td><span id="attribute_label_<?php echo $attribute_value_id; ?>_max"><?php echo max( $attribute_value[ 'values' ] ) . $attribute_value[ 'suffix' ]; ?></span>
                                                                <input type="hidden" id="attribute_value_<?php echo $attribute_value_id; ?>_max" name="attr_slider[<?php echo $attribute_value_id ?>][max]" value="">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2"><div id="slider-range-<?php echo $attribute_value_id; ?>"></div></td>
                                                        </tr>
                                                    </table>						
                                                    <script>
                                                        var attr_arr_<?php echo $attribute_value_id; ?> = [<?php echo implode( ',' , $attribute_value[ 'values' ] ); ?>];
                                                        $('#slider-range-<?php echo $attribute_value_id; ?>').slider({
                                                            range: true,
                                                            min: 0,
                                                            max:<?php echo count( $attribute_value[ 'values' ] ) - 1; ?>,
                                                            values: [0, <?php echo count( $attribute_value[ 'values' ] ) - 1; ?>],
                                                            slide: function(a, b) {
                                                                var min = attr_arr_<?php echo $attribute_value_id; ?>[b.values[0]];
                                                                var max = attr_arr_<?php echo $attribute_value_id; ?>[b.values[1]];
                                                                $("#attribute_label_<?php echo $attribute_value_id; ?>_min").html(min + '<?php echo $attribute_value[ 'suffix' ]; ?>');
                                                                $("#attribute_label_<?php echo $attribute_value_id; ?>_max").html(max + '<?php echo $attribute_value[ 'suffix' ]; ?>');
                                                            },
                                                            stop: function(a, b) {
                                                                var min = attr_arr_<?php echo $attribute_value_id; ?>[b.values[0]];
                                                                var max = attr_arr_<?php echo $attribute_value_id; ?>[b.values[1]];
                                                                $("#attribute_value_<?php echo $attribute_value_id; ?>_min").val(min);
                                                                $("#attribute_value_<?php echo $attribute_value_id; ?>_max").val(max);
                                                                iF()
                                                            }
                                                        });
                                                    </script>						
                                                    </table>
                                                <?php } ?>
                                            </div>
                                        <?php } ?>
                                    </div>
                                <?php } ?>
                            <?php } ?>

                            <?php
                            if ( $options )
                            {
                                ?>
                                <?php
                                foreach ( $options as $option )
                                {
                                    if (
                                            $category_id != '65'
                                            AND $category_id != '71'
                                            AND $category_id != '66'
                                            AND $category_id != '67'
                                            AND $category_id != '68'
                                            AND $category_id != '69'
                                            AND $category_id != '99'
                                            AND $category_id != '100'
                                            AND $category_id != '101'
                                            AND $category_id != '102'
                                            AND $category_id != '74'
                                            AND $category_id != '75'
                                            AND $category_id != '104'
                                            AND $category_id != '105'
                                            AND $category_id != '120'
                                            AND $category_id != '106'
                                            AND $category_id != '107'
                                            AND $category_id != '109'
                                            AND $category_id != '110'
                                            AND $category_id != '111'
                                            AND $category_id != '112'
                                            AND $category_id != '113'
                                            AND $category_id != '118'
                                            AND $category_id != '76'
                                            AND $category_id != '83'
                                            AND $category_id != '72'
                                            AND $category_id != '94'
                                            AND $category_id != '95'
                                            AND $option[ 'option_id' ] == 23 )
                                    {
                                        continue;
                                    }
                                    ?>
                                    <div class="option_box">
                                        <div class="option_name"><?php echo $option[ 'name' ]; ?></div>
                                        <?php
                                        if ( $option[ 'display' ] == 'select' )
                                        {
                                            ?>
                                            <div class="collapsible">
                                                <select class="filtered" name="option_value[<?php echo $option[ 'option_id' ] ?>][]">
                                                    <option value=""><?php echo $text_all ?></option>
                                                    <?php
                                                    foreach ( $option[ 'option_values' ] as $option_value )
                                                    {
                                                        ?>
                                                        <option class="option_value" id="option_value_<?php echo $option_value[ 'option_value_id' ] ?>" value="<?php echo $option_value[ 'option_value_id' ] ?>"><?php echo $option_value[ 'name' ] ?></option>
                                                    <?php } ?>
                                                </select>
                                            </div>
                                            <?php
                                        }
                                        elseif ( $option[ 'display' ] == 'checkbox' )
                                        {
                                            ?>
                                            <table class="collapsible">
                                                <?php
                                                foreach ( $option[ 'option_values' ] as $option_value )
                                                {
                                                    ?>
                                                    <tr>
                                                        <td>
                                                            <input class="filtered option_value" id="option_value_<?php echo $option_value[ 'option_value_id' ] ?>"
                                                                   type="checkbox" name="option_value[<?php echo $option[ 'option_id' ] ?>][]"
                                                                   value="<?php echo $option_value[ 'option_value_id' ] ?>">
                                                        </td>
                                                        <td>
                                                            <label for="option_value_<?php echo $option_value[ 'option_value_id' ] ?>"><?php echo $option_value[ 'name' ] ?></label>
                                                        </td>
                                                    </tr>
                                                <?php } ?>
                                            </table>
                                            <?php
                                        }
                                        elseif ( $option[ 'display' ] == 'radio' )
                                        {
                                            ?>
                                            <table class="collapsible">
                                                <?php
                                                foreach ( $option[ 'option_values' ] as $option_value )
                                                {
                                                    ?>
                                                    <tr>
                                                        <td>
                                                            <input class="filtered option_value" id="option_value_<?php echo $option_value[ 'option_value_id' ] ?>"
                                                                   type="radio" name="option_value[<?php echo $option[ 'option_id' ] ?>][]"
                                                                   value="<?php echo $option_value[ 'option_value_id' ] ?>">
                                                        </td>
                                                        <td>
                                                            <label for="option_value_<?php echo $option_value[ 'option_value_id' ] ?>"><?php echo $option_value[ 'name' ] ?></label>
                                                        </td>
                                                    </tr>
                                                <?php } ?>
                                            </table>
                                        <?php } ?>
                                    </div>
                                <?php } ?>
                            <?php } ?>
                        </form>
                    </div>



                    <script id="productTemplate" type="text/x-jquery-tmpl">
                       
                     
                        <div class="product_l">
                          <? 
if(!empty($this->request->get['route'])  && $this->request->get['route']=='product/special'   ) {
?>

  <span class="strs" style="display:none">
                                            <table><tr><td>
                                                        <img style="max-width:300px" src="/image/${img}"  />
                                                  </tr></table>
                                        </span>

<? } ?>
                        {{if thumb}}
                        <div class="image"><a class="thumbnail" href="${href}"><img src="${thumb}" title="${name}" alt="${name}"/>
                        
                        {{if $.cookie('display')=='list' }}
                      
                        
                        
                          {{/if}}
                        </a></div>
                        {{/if}}
                        <div class="desc">${description}</div>
                        <a class="product_price_overlay" href="${href}">
                        {{if price}}
                        <div class="price">
                        {{if special }}
                        <span class="price-new">${special}</span> <span class="price-old">${price}</span>
                        {{else}}
                        ${price}
                        {{/if}}

                        </div>
                        {{/if}}
                        </a>
                        {{if price}}
                        <div class="price">
                        {{if special }}
                        
                        
         <? 
if(!empty($this->request->get['route'])  && $this->request->get['route']=='product/special'   ) {
?>
 <span class="price-new c2_color">${special}</span> <span class="price-old">${price}</span>  <span class="percent_span" style="color: #444444;" title="Скидка в процентах" style="padding-left:15px;">- ${skidka}%</span>
 
 <? } else { ?>               
                        
                        <span class="price-new c2_color">${special}</span> <span style="display:none" class="price-old">${price}</span>
                        
                        <? } ?>
                        {{else}}
                        <span class="price-new c1_color">${price}</span>
                        {{/if}}

                        </div>
                        {{/if}}
                        <a class="name" href="${href}">${name}</a>
                        <a class="prod_overlay" href="${href}"></a>
                        <a class="cart" href="#"  rel="${product_id}"><?php echo $button_cart; ?></a>
                        <a class="wishlist" href="#" rel="${product_id}"><?php echo $button_wishlist; ?></a>
                        <a class="compare" href="#" rel="${product_id}"><?php echo $button_compare; ?></a>


                        </div>
                    </script>
                </div>
            </div>
        <?php } ?>
<br />
