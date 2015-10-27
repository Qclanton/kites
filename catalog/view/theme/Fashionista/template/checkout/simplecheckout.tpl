<?php if (!$ajax) { ?>
<?php echo $header; ?>
<div class="global c3">
	<div class="container">
            <div class="global_title"><h1><?php echo $heading_title; ?></h1>
            	<span><?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php if($breadcrumb['separator']) { ?>><?php } ?> <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?></span></div>
	</div>
</div>

<div class="white_bg">
    <div class="container">


<div id="main_column_st">
	
  <h2 class="c1_color"><?php echo $heading_title; ?><?php if ($simple_show_weight) { ?>&nbsp;(<span id="weight"><?php echo $weight; ?></span>)<?php } ?></h2>
    
    <link rel="stylesheet" type="text/css" href="<?php echo $simple_aceshop ?>catalog/view/theme/<?php echo $template ?>/stylesheet/simple.css" />
    <script type="text/javascript" src="<?php echo $simple_aceshop ?>catalog/view/javascript/simplecheckout.js"></script>
    <script type="text/javascript" src="<?php echo $simple_aceshop ?>catalog/view/javascript/jquery/jquery.maskedinput-1.3.min.js"></script>
    <script type="text/javascript" src="<?php echo $simple_aceshop ?>catalog/view/javascript/jquery/jquery.placeholder.min.js"></script>
    <script type="text/javascript" src="<?php echo $simple_aceshop ?>/catalog/view/javascript/jquery/ui/i18n/jquery.ui.datepicker-<?php echo $language_code ?>.js"></script>
<?php } ?>

    <div class="simplecheckout" id="simplecheckout_form">
    <!-- simplecheckout form -->
        <?php 
            $replace = array(
	  			'{left_column}' => '<div class="simplecheckout-left-column">',
	  			'{/left_column}' => '</div>',
	  			'{right_column}' => '<div class="simplecheckout-right-column">',
      			'{/right_column}' => '</div>',
      			'{customer}' => '<div class="simplecheckout-block" id="simplecheckout_customer"'.($simple_customer_hide_if_logged ? ' style="display:none;"' : '').'>'. $simplecheckout_customer .'</div>',
     			'{cart}' => '<div class="simplecheckout-block" id="simplecheckout_cart">' . $simplecheckout_cart . '</div>',
      			'{shipping}' => $has_shipping ? '<div class="simplecheckout-block" id="simplecheckout_shipping"'.($simple_shipping_methods_hide ? ' style="display:none;"' : '').'>' . $simplecheckout_shipping . '</div>' : '',
      			'{payment}' => '<div class="simplecheckout-block" id="simplecheckout_payment"'.($simple_payment_methods_hide ? ' style="display:none;"' : '').'>' . $simplecheckout_payment . '</div>',
                '{agreement}' => $simple_common_view_agreement_text ? '<div class="simplecheckout-block" id="simplecheckout_agreement"></div>' : '',
			    '{help}' => $simple_common_view_help_text ? '<div class="simplecheckout-block" id="simplecheckout_help"></div>' : '',
			    '{payment_form}' => '',
			);
            
            if ($simple_common_view_agreement_text && isset($information_title) && isset($information_text)) { 
                $replace['{agreement}'] = '<div class="simplecheckout-block" id="simplecheckout_agreement">';
                $replace['{agreement}'] .= '<div class="simplecheckout-block-heading">' . $information_title . '</div>';
                $replace['{agreement}'] .= '<div class="simplecheckout-block-content simplecheckout-scroll">' . $information_text . '</div>';
                $replace['{agreement}'] .= '</div>';
            }
            
            if ($simple_common_view_help_text && isset($help_title) && isset($help_text)) { 
                $replace['{help}'] = '<div class="simplecheckout-block" id="simplecheckout_help">';
                $replace['{help}'] .= '<div class="simplecheckout-block-heading">' . $help_title . '</div>';
                $replace['{help}'] .= '<div class="simplecheckout-block-content simplecheckout-scroll">' . $help_text . '</div>';
                $replace['{help}'] .= '</div>';
            }
            
            if ($payment_form) {
                $replace['{payment_form}'] = '<div class="simplecheckout-block" id="simplecheckout_payment_form">';
                $replace['{payment_form}'] .= '<div class="simplecheckout-block-heading">' . $text_payment_form_title . '</div>';
                $replace['{payment_form}'] .= '<div class="simplecheckout-block-content">' . $payment_form . '</div>';
                $replace['{payment_form}'] .= '</div>';
            }
            
            $find = array(
	  			'{left_column}',
	  			'{/left_column}',
	  			'{right_column}',
      			'{/right_column}',
      			'{customer}',
     			'{cart}',
      			'{shipping}',
      			'{payment}',
                '{agreement}',
                '{help}',
                '{payment_form}'
			);	
			
            echo trim(str_replace($find, $replace, $simple_common_template));
        ?>
    <input type="hidden" name="simple_create_order" id="simple_create_order" value="">
    <span style="display:none" id="need_save_changes"><?php echo $text_need_save_changes ?></span>
    <span style="display:none" id="saving_changes"><?php echo $text_saving_changes ?></span>
    <span style="display:none" id="save_changes"><?php echo $button_save_changes ?></span>
    
    <div style="width:100%;height:1px;clear:both;"></div>
    
    <div class="simplecheckout-proceed-payment" id="simplecheckout_proceed_payment" style="display:none;"><?php echo $text_proceed_payment ?></div>
    <!-- order button block -->
    <?php if ($error_warning && $simple_create_order) { ?>
        <div class="simplecheckout-warning-block agree-warning"><?php echo $error_warning ?></div>
    <?php } elseif ($agree_warning) { ?>
        <div class="simplecheckout-warning-block agree-warning" style="display:none"><?php echo $agree_warning ?></div>
    <?php } ?> 
    <div class="simplecheckout-button-block" id="buttons" <?php if ($block_order) { ?>style="display:none;"<?php } ?>>
		<table>
		<tr>
		<!--<td width="100">
		<div class="simplecheckout-button-left">
            <div class="button c1"><a class="simplecheckout-button" onclick="javascript:history.back()"><span><?php echo $button_back; ?></span></a></div>
			<div class="c"></div>
        </div>
		</td>-->
		<td width="141" style="padding-left:844px;">
		    <div class="simplecheckout-button-right">
            <?php if ($simple_common_view_agreement_checkbox) { ?><label><input type="checkbox" id="agree" name="agree" value="1" <?php if ($agree == 1) { ?>checked="checked"<?php } ?> /><?php echo $text_agree; ?></label>&nbsp;<?php } ?>
			<div class="button2" style="background-color:#911E42;"><a class="simplecheckout-button" onclick="simplecheckout_submit();" id="simplecheckout_button_confirm">ОФОРМИТЬ ЗАКАЗ</a></div>
			<div class="c"></div>
        </div>
        
		</td>
		</tr>
		</table>
    </div>
    </div>
<?php if (!$ajax) { ?>
    <?php echo $content_bottom; ?>
</div>
	  <div class="c"></div>
</div>


  </div>
<?php echo $footer; ?>
<?php } ?>