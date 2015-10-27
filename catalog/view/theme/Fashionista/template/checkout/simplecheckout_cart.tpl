<?php if ($attention) { ?>
    <div class="simplecheckout-warning-block"><?php echo $attention; ?></div>
<?php } ?>    
<?php if ($error_warning) { ?>
    <div class="simplecheckout-warning-block"><?php echo $error_warning; ?></div>
<?php } ?>
    <table class="simplecheckout-cart">
        <colgroup>
            <?php if (!$is_mobile) { ?>
            <col class="image">
            <?php } ?>
            <col class="name">
            <?php if (!$is_mobile) { ?>
            <col class="model">
            <?php } ?>
            <col class="quantity">
            <col class="price">
            <col class="total">
            <col class="remove">
        </colgroup>
        <thead>
            <tr>
                <?php if (!$is_mobile) { ?>
                <th class="image"><?php echo $column_image; ?></th>   
                <?php } ?>   
                <th class="name"><?php echo $column_name; ?></th>
                <?php if (!$is_mobile) { ?>
                <th class="model"><?php echo $column_model; ?></th>
                <?php } ?> 
                <th class="quantity"><?php echo $column_quantity; ?></th>
                <th class="price"><?php echo $column_price; ?></th>
                <th class="total"><?php echo $column_total; ?></th>
                <th class="remove"></th>        
            </tr>
        </thead>
    <tbody>
    <?php foreach ($products as $product) { ?>
        <tr>
            <?php if (!$is_mobile) { ?>
            <td class="image">
                <?php if ($product['thumb']) { ?>
                    <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                <?php } ?>
            </td> 
            <?php } ?>     
            <td class="name">
                <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                <?php if (!$product['stock'] && ($config_stock_warning || !$config_stock_checkout)) { ?>
                    <span class="product-warning">***</span>
                <?php } ?>
                <div>
                <?php foreach ($product['option'] as $option) { ?>
                &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br />
                <?php } ?>
                </div>
                <?php if ($product['reward']) { ?>
                <small><?php echo $product['reward']; ?></small>
                <?php } ?>
            </td>
            <?php if (!$is_mobile) { ?>
            <td class="model"><?php echo $product['model']; ?></td>
            <?php } ?>
            <td class="quantity">
                <?php if (!$is_mobile) { ?>
                <img src='catalog/view/image/minus.png' border='0' onclick="$(this).next().val(~~$(this).next().val()-1);simplecheckout_reload('from_cart');">
                <?php } ?>
                <input type="text" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" onchange="simplecheckout_reload('from_cart')" />
                <?php if (!$is_mobile) { ?>
                <img src='catalog/view/image/plus.png' border='0' onclick="$(this).prev().val(~~$(this).prev().val()+1);simplecheckout_reload('from_cart');">
                <?php } ?>
            </td>
            <td class="price"><nobr><?php echo $product['price']; ?></nobr></td>
            <td class="total"><nobr><?php echo $product['total']; ?></nobr></td>
            <td class="remove">
            <img style="cursor:pointer;" src="catalog/view/image/close.png" onclick="$('#simplecheckout_remove').val('<?php echo $product['key']; ?>');simplecheckout_reload('from_cart');" />
            </td>        
            </tr>
            <?php } ?>
            <?php foreach ($vouchers as $voucher_info) { ?>
            <tr>
            <?php if (!$is_mobile) { ?>
            <td class="image"></td>  
            <?php } ?>    
            <td class="name"><?php echo $voucher_info['description']; ?></td>
            <?php if (!$is_mobile) { ?>
            <td class="model"></td>
            <?php } ?>
            <td class="quantity">1</td>
            <td class="price"><nobr><?php echo $voucher_info['amount']; ?></nobr></td>
            <td class="total"><nobr><?php echo $voucher_info['amount']; ?></nobr></td>
            <td class="remove"></td>
        </tr>
    <?php } ?>
    </tbody>
    <tfoot>
        <?php foreach ($totals as $total) { ?>
            <tr>
                <td colspan="<?php echo !$is_mobile ? 5 : 3 ?>" class="price"><b><?php echo $total['title']; ?>:</b></td>
                <td class="total"><nobr><?php echo $total['text']; ?></nobr></td>
                <td class="remove">
                <?php if ($total['code'] == 'coupon') { ?>
                <img style="cursor:pointer;" src="catalog/view/image/close.png" onclick="$('input[name=coupon]').val('');simplecheckout_reload('from_cart');" />
                <?php } ?>
                <?php if ($total['code'] == 'voucher') { ?>
                <img style="cursor:pointer;" src="catalog/view/image/close.png" onclick="$('input[name=voucher]').val('');simplecheckout_reload('from_cart');" />
                <?php } ?>
                <?php if ($total['code'] == 'reward') { ?>
                <img style="cursor:pointer;" src="catalog/view/image/close.png" onclick="$('input[name=reward]').val('');simplecheckout_reload('from_cart');" />
                <?php } ?>
                </td>
            </tr>
        <?php } ?>
        <?php if (isset($modules['coupon'])) { ?>
            <tr>
                <td class="total" colspan="<?php echo !$is_mobile ? 7 : 5 ?>"><?php echo $entry_coupon; ?>&nbsp;<input type="text" name="coupon" value="<?php echo $coupon; ?>" onchange="simplecheckout_reload('from_cart')"  /></td>
            </tr>
        <?php } ?>
        <?php if (isset($modules['reward']) && $points > 0) { ?>
            <tr>
                <td class="total" colspan="<?php echo !$is_mobile ? 7 : 5 ?>"><?php echo $entry_reward; ?>&nbsp;<input type="text" name="reward" value="<?php echo $reward; ?>" onchange="simplecheckout_reload('from_cart')"  /></td>
            </tr>
        <?php } ?>
        <?php if (isset($modules['voucher'])) { ?>
            <tr>
                <td class="total" colspan="<?php echo !$is_mobile ? 7 : 5 ?>"><?php echo $entry_voucher; ?>&nbsp;<input type="text" name="voucher" value="<?php echo $voucher; ?>" onchange="simplecheckout_reload('from_cart')"  /></td>
            </tr>
        <?php } ?>
        <?php if (isset($modules['coupon']) || isset($modules['reward']) || isset($modules['voucher'])) { ?>
            <tr>
                <td class="total" colspan="<?php echo !$is_mobile ? 7 : 5 ?>">
				<div class="button c1"><a id="simplecheckout_button_cart" onclick="simplecheckout_reload('from_cart');" class="simplecheckout-button"><span><?php echo $button_update; ?></span></a></div>
					<div class="c"></div>
				</td>
            </tr>
        <?php } ?>
    </tfoot>
</table>
<input type="hidden" name="remove" value="" id="simplecheckout_remove">
<div style="display:none;" id="simplecheckout_cart_total"><?php echo $cart_total ?></div>
<script type="text/javascript">
    $('#cart_total').html('<?php echo $cart_total ?>');
    $('#cart-total').html('<?php echo $cart_total ?>');
    $('#cart_menu .s_grand_total').html('<?php echo $cart_total ?>');
    <?php if ($simple_show_weight) { ?>
    $('#weight').text('<?php echo $weight ?>');
    <?php } ?>
</script>