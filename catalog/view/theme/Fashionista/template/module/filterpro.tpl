<?php
ini_set("display_errors", "1");
error_reporting(E_ALL);

if ( $options || $manufacturers || $attributes )
{
    ?>
           <form id="filterpro">
                    <?php foreach ( $manufacturers as $manufacturer ) { ?>
                        <input type="hidden" class="m_name" id="m_<?php echo $manufacturer[ 'manufacturer_id' ] ?>" value="<?php echo $manufacturer[ 'name' ] ?>">
                    <?php } ?>
                    <input type="hidden" name="category_id" value="<?php echo $category_id ?>">
                    <input type="hidden" name="page" id="filterpro_page" value="0">
                    <input type="hidden" name="path" value="<?php echo $path ?>">
                    <input type="hidden" name="sort" id="filterpro_sort" value="">
                    <input type="hidden" name="order" id="filterpro_order" value="">
                    <input type="hidden" name="limit" id="filterpro_limit" value="">
                    <?php foreach ( $models as $model ) { ?>
                        <input type="hidden" class="mm_name" id="mm_<?php echo $model ?>" god="mm_<?php echo $model ?>" value="<?php echo $model ?>">
                    <?php } ?>

                    <?php foreach ( $options as $option ) { ?>
                        <?php foreach ( $option[ 'option_values' ] as $option_value ) { ?>
                            <input type="hidden" class="o_name" id="o_<?php echo $option_value[ 'option_value_id' ] ?>" value="<?php echo $option_value[ 'name' ] ?>">
                        <?php } ?>
                    <?php } ?>

        <div class="price">
            <h1>Цена <div class="tri first"></div></h1>
            <div class="slider">
                    <div class="sliderCont">
                            <div id="slider">
                                <img src="../../img/1.jpg" alt="">
                                <img src="../../img/1.jpg" alt="" class="img_mid">
                                <img src="../../img/1.jpg" alt="" class="img_end">
                            </div>
                            <div class="price_range">
                                <div class="min">10</div>
                                <div class="middle">100</div>
                                <div class="max">200</div>
                            </div>
                    </div>
            </div>
        </div>

        <div class="producers inputs">
            <h1>Производители <div class="tri second"></div></h1>
            <ul class="list1">
                                    <?php foreach ( $manufacturers as $manufacturer ) { ?>
                                                <li><input id="manufacturer_<?php echo $manufacturer[ 'manufacturer_id' ] ?>" class="manufacturer_value filtered"
                                                       type="checkbox" name="manufacturer[]"
                                                       value="<?php echo $manufacturer[ 'manufacturer_id' ] ?>">
                                                <label for="manufacturer_<?php echo $manufacturer[ 'manufacturer_id' ] ?>"> &nbsp; <?php echo $manufacturer[ 'name' ] ?></label>
						</li>
                                    <?php } ?>
            </ul>
        </div>

                    <?php if ( false ) {
                        ?>

        <div class="year inputs">
            <h1>Год <div class="tri third"></div></h1>
            <ul class="list2">
                                        <?php
                                            $_other = array();
                                            $_years = array();
                                        foreach ( $models as $key => $model )
                                        {
                                            if ( strpos( $model ) !== false )
											// if ( strpos( $model , 'год' ) !== false )
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
                                        ?>

                                        <?php
                                        foreach ( $models as $key => $model )
                                        {
                                            ?>
                                                    <li><input id="xmodel_<?= $model ?>" class="model_value filtered" name="model[]" value="<?= $model ?>" type="checkbox">
                                                    <label for="xmodel_<?= $model ?>"><?= $model ?></label></li>

                                            <? } ?>
            </ul>
        </div>
                            <? } ?>


                           <?php
                            if ( $attributes )
                            {
                                ?>
                                <?php
                                foreach ( $attributes as $attribute_group_id => $attribute )
                                {
                                    ?>

                                        <?php
                                        foreach ( $attribute[ 'attribute_values' ] as $attribute_value_id => $attribute_value )
                                        {
						if ($attribute_value[ 'name' ] == 'Год') {
                                            ?>
                                            <div class="attr inputs">
					            <h1>Год <div class="tri third"></div></h1>
                                                <?php
							if ( $attribute_value[ 'display' ] == 'checkbox' )
                                                {
                                                    ?>
						        <ul class="list2">
                                                        <?php
                                                        foreach ( $attribute_value[ 'values' ] as $i => $value )
                                                        {
                                                            ?>
                                                                    <li><input class="filtered a_name"
                                                                           id="attribute_value_<?php echo $attribute_value_id . $i; ?>"
                                                                           type="checkbox" name="attribute_value[<?php echo $attribute_value_id ?>][]"
                                                                           at_v_i="<?php echo $attribute_value_id . '_' . $value ?>"
                                                                           value="<?php echo $value ?>">
                                                                    <label for="attribute_value_<?php echo $attribute_value_id . $i; ?>"
                                                                           at_v_t="<?php echo $attribute_value_id . '_' . $value ?>"
                                                                           data-value = "<?php echo $value ?>"
                                                                           value="<?php echo $value ?>"><?php echo $value ?></label></li>
                                                        <?php } ?>
                                                    	</ul>
                                                    <?php
                                                } ?>

                                            </div>
                                        <?php   } // if god
						} ?>

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
                                    <div class="inputs">
                                        <h1><?php echo $option[ 'name' ]; ?></h1>
                                        <?php
					if ( $option[ 'display' ] == 'checkbox' )
                                        {
                                            ?>
                                            <ul class="list2">
                                                <?php
                                                foreach ( $option[ 'option_values' ] as $option_value )
                                                {
                                                    ?>
                                                            <li><input class="filtered option_value" id="option_value_<?php echo $option_value[ 'option_value_id' ] ?>"
                                                                   type="checkbox" name="option_value[<?php echo $option[ 'option_id' ] ?>][]"
                                                                   value="<?php echo $option_value[ 'option_value_id' ] ?>">
                                                            <label for="option_value_<?php echo $option_value[ 'option_value_id' ] ?>"><?php echo $option_value[ 'name' ] ?></label></li>
                                                <?php } ?>
                                            </ul>
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

<?php } ?>
