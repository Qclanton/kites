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
	
  <h2 class="c1_color"><?php echo $heading_title; ?></h2>
<!--   <div class="checkout"> -->

    <link rel="stylesheet" type="text/css" href="catalog/view/theme/<?php echo $template ?>/stylesheet/simple.css" />
    <script type="text/javascript" src="catalog/view/javascript/simplecheckout.js"></script>
    <script type="text/javascript" src="catalog/view/javascript/jquery/jquery.maskedinput-1.3.min.js"></script>

    <!-- simplecheckout form -->
    <div class="simplecheckout">
        <?php 
            $replace = array(
	  			'{left_column}' => '<div class="simplecheckout-left-column">',
	  			'{/left_column}' => '</div>',
	  			'{right_column}' => '<div class="simplecheckout-right-column">',
      			'{/right_column}' => '</div>',
      			'{customer}' => '<div class="simplecheckout-block" id="simplecheckout_customer">'. $simplecheckout_customer .'</div>',
     			'{cart}' => '<div class="simplecheckout-block" id="simplecheckout_cart">' . $simplecheckout_cart . '</div>',
      			'{shipping}' => $has_shipping ? '<div class="simplecheckout-block" id="simplecheckout_shipping">' . $simplecheckout_shipping . '</div>' : '',
      			'{payment}' => '<div class="simplecheckout-block" id="simplecheckout_payment">' . $simplecheckout_payment . '</div>',
                '{agreement}' => '<div class="simplecheckout-block" id="simplecheckout_agreement"></div>'
			);
            
            if ($simple_common_view_agreement_text && isset($information_title) && isset($information_text)) { 
                $replace['{agreement}'] = '<div class="simplecheckout-block" id="simplecheckout_agreement">';
                $replace['{agreement}'] .= '<div class="simplecheckout-block-heading">' . $information_title . '</div>';
                $replace['{agreement}'] .= '<div class="simplecheckout-block-content simplecheckout-scroll">' . $information_text . '</div>';
                $replace['{agreement}'] .= '</div>';
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
                '{agreement}'
			);	
			
            echo trim(str_replace($find, $replace, $simple_common_template));
        ?>
        <!-- order button block -->
        <div class="simplecheckout-button-block" <?php if ($block_order) { ?>style="display:none;"<?php } ?>>
			<table>
			<tr><td width="100">
				<?php if ($simple_common_view_agreement_checkbox) { ?><label><input type="checkbox" name="agree" id="agree" value="1" <?php if ($simple_common_view_agreement_checkbox_init == 1) { ?>checked="checked"<?php } ?> /><?php echo $text_agree; ?></label>&nbsp;<?php } ?>
				</td><td width="100">
				<a class="simplecheckout-button" onclick="javascript:history.back()" style="display:none;"><span><?php echo $button_back; ?></span></a></div>
				</div></td><td width="100">
				<div class="button c1"><a class="simplecheckout-button" id="simplecheckout_button_order"><span><?php echo $button_order; ?></span></a></div>
				<div class="c"></div>
				</td>
				</tr>
			</table>
        </div>
    </div>
    <!-- payment form block -->
    <div id="simplecheckout_payment_form" style="height:1px;overflow:hidden;" class="payment"></div>
    <!-- content bottom -->
    <div class="simplecheckout-proceed-payment" id="simplecheckout_proceed_payment" style="display:none;"><?php echo $text_proceed_payment ?></div>
    <?php echo $content_bottom; ?>
		  <div class="c"></div>
</div>


  </div>
</div>

<?php echo $footer; ?>