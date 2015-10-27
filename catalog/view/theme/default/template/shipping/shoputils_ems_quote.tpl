<?php
/*
 * Shoputils
 *
 * ПРИМЕЧАНИЕ К ЛИЦЕНЗИОННОМУ СОГЛАШЕНИЮ
 *
 * Этот файл связан лицензионным соглашением, которое можно найти в архиве,
 * вместе с этим файлом. Файл лицензии называется: LICENSE.1.5.x.RUS.txt
 * Так же лицензионное соглашение можно найти по адресу:
 * http://opencart.shoputils.ru/LICENSE.1.5.x.RUS.txt
 * 
 * =================================================================
 * OPENCART 1.5.x ПРИМЕЧАНИЕ ПО ИСПОЛЬЗОВАНИЮ
 * =================================================================
 *  Этот файл предназначен для Opencart 1.5.x. Shoputils не
 *  гарантирует правильную работу этого расширения на любой другой 
 *  версии Opencart, кроме Opencart 1.5.x. 
 *  Shoputils не поддерживает программное обеспечение для других 
 *  версий Opencart.
 * =================================================================
*/
?>
<?php foreach ($quotes as $quote) : ?>
<tr>
<td style="width: 1px;">
  <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>"<?php echo $code == $quote['code'] ? 'checked="checked"' : ''?> />
</td>
<td>
    <label for="<?php echo $quote['code']; ?>"><?php echo $quote['title']; ?> - <a href="#" id="ems_item_change"><?php echo $text_change_city; ?></a></label>
</td>
<td style="text-align: right;">
    <label for="<?php echo $quote['code']; ?>"><?php echo $quote['text']; ?></label>
</td>
</tr>
<tr>
    <td style="width: 1px;"></td>
    <td  style="color:#555; font-size: 11px;"><?php echo $quote['description']; ?></td>
    <td></td>
</tr>
<?php endforeach;?>


<script type="text/javascript"><!--

$('#ems_item_change').click(function(e){
    $('#shoputils_ems_item_loading').show();
    $.ajax({url: '<?php echo $action_url?>&item_change',
        dataType: 'json',
        success: function(data) {
            $('#shoputils_ems_content').html(data.output);
        },
        complete: function() {
            $('#shoputils_ems_item_loading').hide();
        }
    });
    e.preventDefault();
});

//--></script>
    