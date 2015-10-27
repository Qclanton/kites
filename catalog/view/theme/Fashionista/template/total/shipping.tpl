<div>
  <div class="cart-heading"><span class="head_arr"><?php echo $heading_title; ?></span></div>
  <div class="cart-content">
    <p><?php echo $text_shipping; ?></p><br />
    <label><span class="required">*</span> <?php echo $entry_country; ?></label><br />
    <select name="country_id" onchange="$('select[name=\'zone_id\']').load('<?php echo HTTP_SERVER; ?>index.php?route=total/shipping/zone&country_id=' + this.value + '&zone_id=<?php echo $zone_id; ?>');">
            <option value=""><?php echo $text_select; ?></option>
            <?php foreach ($countries as $country) { ?>
            <?php if ($country['country_id'] == $country_id) { ?>
            <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
            <?php } ?>
            <?php } ?>
          </select>
          <br /><br />
          <label><span class="required">*</span> <?php echo $entry_zone; ?></label><br />
          <select name="zone_id">
          </select><br /><br />
          
          <label><span class="required">*</span> <?php echo $entry_postcode; ?></label><br />
          <input type="text" name="postcode" value="<?php echo $postcode; ?>" /><br /><br />
          
    <div class="button c1"><a href="#" id="button-quote"><span><?php echo $button_quote; ?></span></a></div>
    <div id="quote" style="display: none;"></div>
    <input type="hidden" name="shipping_method" value="<?php echo $code; ?>" />
  </div>
</div>
<div class="c"></div>
<script type="text/javascript"><!--
$('#button-quote').bind('click', function(event) {
	event.preventDefault();
	var $t = $(this);
	$.ajax({
		type: 'POST',
		url: '<?php echo HTTP_SERVER; ?>index.php?route=total/shipping/quote',
		data: 'country_id=' + $('select[name=\'country_id\']').val() + '&zone_id=' + $('select[name=\'zone_id\']').val() + '&postcode=' + encodeURIComponent($('input[name=\'postcode\']').val()),
		dataType: 'json',		
		beforeSend: function() {
			$('.success, .warning').remove();
			$t.attr('disabled', true);
			$t.parent().after('<span class="wait">&nbsp;<img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$t.attr('disabled', false);
			$('.wait').remove();
		},		
		success: function(json) {
			$('.error').remove();

			if (json['redirect']) {
				location = json['redirect'];
			}
						
			if (json['error']) {
				if (json['error']['warning']) {
					$('#basket_cart').before('<div id="notification" class="notify c1">' + json['error']['warning'] + '</div>');
					$('#notification').fadeIn();
					
					$('#notification .close').click(function(event){
						event.preventDefault();
						$("#notification").fadeOut().remove();
					})		
				}
				
				if (json['error']['country']) {
					$('#shipping select[name=\'country_id\'] + br').after('<span class="error">' + json['error']['country'] + '</span>');
				}	
				
				if (json['error']['zone']) {
					$('#shipping select[name=\'zone_id\'] + br').after('<span class="error">' + json['error']['zone'] + '</span>');
				}
				
				if (json['error']['postcode']) {
					$('#shipping input[name=\'postcode\']').after('<span class="error">' + json['error']['postcode'] + '</span>');
				}					
			}
			//.length > 0
			if (json['shipping_methods']) {
				html  = '<br /><br /><br />';
				html += '<table width="100%" cellpadding="3">';
				
				for (i in json['shipping_methods']) {
					html += '<tr>';
					html += '  <td colspan="3"><strong>' + json['shipping_methods'][i]['title'] + '</strong><br /><br /></td>';
					html += '</tr>';
				
					if (!json['shipping_methods'][i]['error']) {
						for (j in json['shipping_methods'][i]['quote']) {
							html += '<tr>';
							
							if (json['shipping_methods'][i]['quote'][j]['code'] == $('input[name=\'shipping_method\']').attr('value')) {
								html += '<td width="20"><input type="radio" name="shipping_method" value="' + json['shipping_methods'][i]['quote'][j]['code'] + '" id="' + json['shipping_methods'][i]['quote'][j]['code'] + '" checked="checked" /></td>';
							} else {
								html += '<td width="20"><input type="radio" name="shipping_method" value="' + json['shipping_methods'][i]['quote'][j]['code'] + '" id="' + json['shipping_methods'][i]['quote'][j]['code'] + '" /></td>';
							}
								
							html += '  <td><label for="' + json['shipping_methods'][i]['quote'][j]['code'] + '">' + json['shipping_methods'][i]['quote'][j]['title'] + '</label></td>';
							html += '  <td width="20"><label for="' + json['shipping_methods'][i]['quote'][j]['code'] + '">' + json['shipping_methods'][i]['quote'][j]['text'] + '</label></td>';
							html += '</tr>';
						}		
					} else {
						html += '<tr>';
						html += '  <td colspan="3"><div class="error">' + json['shipping_methods'][i]['error'] + '</div></td>';
						html += '</tr>	';						
					}
				}
				
				html += '</table>';
				html += '<br /><div class="button c1"><a href="#" id="button-shipping"><span><?php echo $button_shipping; ?></span></a></div>';				
		
				
				$('#quote').html(html);	
				Cufon.replace('.button');
				
				$('#quote').slideDown('slow');
				
        $(".button").each(function(){

		if($(this).children("div").length){
			$(this).find("div").remove();
		} 
		
            $(this).append(
                $("<div></div>")
                .css({
                    'border' : '1px solid #fff',
                    width : $(this).width()-4,
                    height: $(this).height()-4,
                    position : 'absolute',
                    top : 1,
                    left : 1
                })
                .fadeTo(0,0.25)
            ); 

        });				
			}
		}
	});
});

$('#button-shipping').live('click', function(event) {
	event.preventDefault();
	$.ajax({
		type: 'POST',
		url: '<?php echo HTTP_SERVER; ?>index.php?route=total/shipping/calculate',
		data: 'shipping_method=' + $('input[name=\'shipping_method\']:checked').attr('value'),
		dataType: 'json',		
		beforeSend: function() {
			$('.warning').remove();
			$('#button-shipping').attr('disabled', true);
			$('.button').after('<span class="wait">&nbsp;<img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('#button-shipping').attr('disabled', false);
			$('.wait').remove();
		},		
		success: function(json) {
			if (json['error']) {
				$('#shipping').before('<div class="warning">' + json['error'] + '<img src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/image/close.png" alt="" class="close" /></div>');
			}
			
			if (json['redirect']) {
				location = json['redirect'];
			}
		}
	});
});
//--></script> 
<script type="text/javascript"><!--
$('select[name=\'zone_id\']').load('<?php echo HTTP_SERVER; ?>index.php?route=total/shipping/zone&country_id=<?php echo $country_id; ?>&zone_id=<?php echo $zone_id; ?>');
//--></script> 