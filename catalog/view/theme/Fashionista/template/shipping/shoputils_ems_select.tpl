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
<tr style="background:#FFDFE0; color:black;">
    <td colspan="3">
    <p style="text-align:center; padding: 10px; margin: 0;"><?php echo $text_warning?></p>
    <?php if (!$items): ?>
        <p style="text-align:center;"><?php echo $text_request_error;?></p>
    <?php else: ?>
        <div style="text-align: center; padding: 10px;">
        <?php echo $entry_select?>
        <select type="text" id="ems_item" name="item_id" style="width:300px">
            <?php foreach ($items as $key => $value): ?>
                <option value="<?php echo $key?>"><?php echo $value; ?></option>
            <?php endforeach; ?>
        </select>
    </div>
    <?php endif ?>
    </td>
</tr>
<!-- <input type="radio" name="shipping_method" value="shoputils_ems.shoputils_ems" id="shoputils_ems.shoputils_ems"/> -->
<script type="text/javascript"><!--

$('#ems_item').change(function(e){
    $('#shoputils_ems_item_loading').show();
    var values = 'item_id='+encodeURIComponent($('#ems_item option:selected').val());
    values += '&item_name='+encodeURIComponent($('#ems_item option:selected').text())
    $.ajax({url: '<?php echo $action_url?>&'+values,
        dataType: 'json',
        success: function(data) {
            $('#shoputils_ems_content').html(data.output);
        },
        complete: function() {
            $('#shoputils_ems_item_loading').hide();
			 $('input.emss').attr('checked', 'true');
			 $('input.emss').change();
        }
    });
    e.preventDefault();
});

//--></script>
    