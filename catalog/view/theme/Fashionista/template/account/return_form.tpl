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
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php echo $text_description; ?><br /><br />
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="return">
    <h2 class="c1_color"><?php echo $text_order; ?></h2>

      <div class="left"><span class="required">*</span> <?php echo $entry_firstname; ?><br />
        <input type="text" name="firstname" value="<?php echo $firstname; ?>" class="large-field" />
        
        <?php if ($error_firstname) { ?>
        <label><span class="error"><?php echo $error_firstname; ?></span></label>
        <?php } ?>
        <br /><br />
        <span class="required">*</span> <?php echo $entry_lastname; ?><br />
        <input type="text" name="lastname" value="<?php echo $lastname; ?>" class="large-field" />

        <?php if ($error_lastname) { ?>
        <label><span class="error"><?php echo $error_lastname; ?></span></label>
        <?php } ?>
        <br /><br />
        <span class="required">*</span> <?php echo $entry_email; ?><br />
        <input type="text" name="email" value="<?php echo $email; ?>" class="large-field" />

        <?php if ($error_email) { ?>
        <label><span class="error"><?php echo $error_email; ?></span></label>
        <?php } ?>
        <br /><br />
        <span class="required">*</span> <?php echo $entry_telephone; ?><br />
        <input type="text" name="telephone" value="<?php echo $telephone; ?>" class="large-field" />

        <?php if ($error_telephone) { ?>
        <label><span class="error"><?php echo $error_telephone; ?></span></label>
        <?php } ?>
        <br /><br />
      </div>
      <div class="right"><span class="required">*</span> <?php echo $entry_order_id; ?><br />
        <input type="text" name="order_id" value="<?php echo $order_id; ?>" class="large-field" />
        
        <?php if ($error_order_id) { ?>
        <label><span class="error"><?php echo $error_order_id; ?></span></label>
        <?php } ?>
        <br /><br />
        <?php echo $entry_date_ordered; ?><br />
        <input type="text" name="date_ordered" value="<?php echo $date_ordered; ?>" class="large-field date" />
        <br /><br /><br />
      </div>

    <h2 class="c1_color"><?php echo $text_product; ?></h2>
    <div id="return-product">
    	
    	
    	
    	
      <?php $return_product_row = 0; ?>
      <?php foreach ($return_products as $return_product) { ?>
      	<div class="c"></div>
      <div id="return-product-row<?php echo $return_product_row; ?>">
<br />
		<div class="ct">
          <div class="return-product">
            <div class="return-name"><span class="required">*</span> <b><?php echo $entry_product; ?></b><br />
              <input type="text" name="return_product[<?php echo $return_product_row; ?>][name]" value="<?php echo $return_product['name']; ?>" />

              <?php if (isset($error_name[$return_product_row])) { ?>
              <label><span class="error"><?php echo $error_name[$return_product_row]; ?></span></label>
              <?php } ?>
            </div>
            <div class="return-model"><span class="required">*</span> <b><?php echo $entry_model; ?></b><br />
              <input type="text" name="return_product[<?php echo $return_product_row; ?>][model]" value="<?php echo $return_product['model']; ?>" />

              <?php if (isset($error_model[$return_product_row])) { ?>
              <label><span class="error"><?php echo $error_model[$return_product_row]; ?></span></label>
              <?php } ?>
            </div>
            <div class="return-quantity"><b><?php echo $entry_quantity; ?></b><br />
              <input type="text" name="return_product[<?php echo $return_product_row; ?>][quantity]" value="<?php echo $return_product['quantity']; ?>" />
            </div>
          </div><br />
          <div class="return-detail">
            <div class="return-reason"><span class="required">*</span> <b><?php echo $entry_reason; ?></b>               <?php if (isset($error_reason[$return_product_row])) { ?>
              <label><span class="error"><?php echo $error_reason[$return_product_row]; ?></span></label>
              <?php } ?><br /><br />
              <table>
                <?php foreach ($return_reasons as $return_reason) { ?>
                <?php if (isset($return_product['return_reason_id']) && $return_reason['return_reason_id'] == $return_product['return_reason_id']) { ?>
                <tr>
                  <td><input type="radio" name="return_product[<?php echo $return_product_row; ?>][return_reason_id]" value="<?php echo $return_reason['return_reason_id']; ?>" id="return-reason-id<?php echo $return_product_row; ?><?php echo $return_reason['return_reason_id']; ?>" checked="checked" /> <label for="return-reason-id<?php echo $return_product_row; ?><?php echo $return_reason['return_reason_id']; ?>"><?php echo $return_reason['name']; ?></label></td>
                </tr>
                <?php } else { ?>
                <tr>
                  <td><input type="radio" name="return_product[<?php echo $return_product_row; ?>][return_reason_id]" value="<?php echo $return_reason['return_reason_id']; ?>" id="return-reason-id<?php echo $return_product_row; ?><?php echo $return_reason['return_reason_id']; ?>" /> <label for="return-reason_id<?php echo $return_product_row; ?><?php echo $return_reason['return_reason_id']; ?>"><?php echo $return_reason['name']; ?></label></td>

                </tr>
                <?php  } ?>
                <?php  } ?>
              </table>

            </div><br /><br />
            <div class="return-opened"><b><?php echo $entry_opened; ?></b><br /><br />
              <?php if ($return_product['opened']) { ?>
              <input type="radio" name="return_product[<?php echo $return_product_row; ?>][opened]" value="1" id="opened<?php echo $return_product_row; ?>" checked="checked" />
              <?php } else { ?>
              <input type="radio" name="return_product[<?php echo $return_product_row; ?>][opened]" value="1" id="opened<?php echo $return_product_row; ?>" />
              <?php } ?>
              <label for="opened<?php echo $return_product_row; ?>"><?php echo $text_yes; ?></label>
              <?php if (!$return_product['opened']) { ?>
              <input type="radio" name="return_product[<?php echo $return_product_row; ?>][opened]" value="0" id="unopened<?php echo $return_product_row; ?>" checked="checked" />
              <?php } else { ?>
              <input type="radio" name="return_product[<?php echo $return_product_row; ?>][opened]" value="0" id="unopened<?php echo $return_product_row; ?>" />
              <?php } ?>
              <label for="unopened<?php echo $return_product_row; ?>"><?php echo $text_no; ?></label>
              <br />
              <br />
              <?php echo $entry_fault_detail; ?><br />
              <textarea name="return_product[<?php echo $return_product_row; ?>][comment]" cols="45" rows="6"><?php echo $return_product['comment']; ?></textarea>
            </div>
            <div class="return-remove"><a href="#" onclick="$('#return-product-row<?php echo $return_product_row; ?>').remove(); return false" class="button"><span><?php echo $button_remove; ?></span></a></div>
          </div>

</div>
      
      </div>
      <?php $return_product_row++; ?>
      <?php } ?>
      
</div>
    
    <div class="c"></div>
<br />
      <div class="button c1"><a href="#" onclick="addReturnProduct(); return false"><span><?php echo $button_add_product; ?></span></a></div>
<div class="c"></div>
<br /><br /><br />
    <h2 class="c1_color"><?php echo $text_additional; ?></h2>
    <div class="ct">
    <div class="return-additional">
      <div class="return-comment">
        <textarea name="comment" cols="50" rows="6"><?php echo $comment; ?></textarea>
      </div><br />
      <div class="return-captcha"><b><?php echo $entry_captcha; ?></b><br />
        <input type="text" name="captcha" value="<?php echo $captcha; ?>" />
                <?php if ($error_captcha) { ?>
        <label><span class="error"><?php echo $error_captcha; ?></span></label>
        <?php } ?>
        <br /><br />
        <img src="<?php echo HTTP_SERVER; ?>index.php?route=account/return/captcha" alt="" />
      </div>
    </div>
    </div>
    <div class="c"></div>
    <div class="buttons">
      <div class="button c1" style="margin-right:10px"><a href="<?php echo $back; ?>"><span><?php echo $button_back; ?></span></a></div>
      <div class="button c1"><a href="#" onclick="$('#return').submit(); return false;"><span><?php echo $button_continue; ?></span></a></div>
    </div>
  </form>
  <div class="c"></div>


</div>
</div></div>
<script type="text/javascript"><!--
var return_product_row = <?php echo $return_product_row; ?>;

function addReturnProduct() {
	html  = '<div id="return-product-row' + return_product_row + '">';
	html += '  <br /><div class="ct"><div class="content">';
	html += '    <div class="return-product">';
	html += '      <div class="return-name"><span class="required">*</span> <?php echo $entry_product; ?><br /><input type="text" name="return_product[' + return_product_row + '][name]" value="" /></div>';
	html += '      <div class="return-model"><span class="required">*</span> <?php echo $entry_model; ?><br /><input type="text" name="return_product[' + return_product_row + '][model]" value="" /></div>';
	html += '      <div class="return-quantity"><?php echo $entry_quantity; ?><br /><input type="text" name="return_product[' + return_product_row + '][quantity]" value="1" /></div>';
	html += '    </div>';
	html += '    <div class="return-detail">';
	html += '      <br /><div class="return-reason"><span class="required">*</span> <?php echo $entry_reason; ?><br /><br />';
	html += '        <table>';
	<?php foreach ($return_reasons as $return_reason) { ?>
	html += '          <tr>';
	html += '            <td><input type="radio" name="return_product[' + return_product_row + '][return_reason_id]" value="<?php echo $return_reason['return_reason_id']; ?>" id="return-reason-id' + return_product_row + '<?php echo $return_reason['return_reason_id']; ?>" /> <label for="return-reason-id' + return_product_row + '<?php echo $return_reason['return_reason_id']; ?>"><?php echo $return_reason['name']; ?></label></td>';
	html += '          </tr>';
	<?php  } ?>
	html += '        </table>';
	html += '    </div><br /><br />';
	html += '    <div class="return-opened"><?php echo $entry_opened; ?><br /><br />';
	html += '      <input type="radio" name="return_product[' + return_product_row + '][opened]" value="1" id="opened' + return_product_row + '" checked="checked" /><?php echo $text_yes; ?><label for="opened' + return_product_row + '"></label> <input type="radio" name="return_product[' + return_product_row + '][opened]" value="0" id="unopened' + return_product_row + '" /><label for="unopened' + return_product_row + '"><?php echo $text_no; ?></label><br /><br />';	
	html += '	   <?php echo $entry_fault_detail; ?><br /><textarea name="return_product[' + return_product_row + '][comment]" cols="45" rows="6"></textarea>';
	html += '    </div>';
    html += '    <div class="return-remove"><a href="#" onclick="$(\'#return-product-row' + return_product_row + '\').remove(); return false" class="button"><span><?php echo $button_remove; ?></span></a></div>';
	html += '  </div>';
	html += '</div></div><div class="c"></div>';
	
	$('#return-product').append(html);
 
	$('#return-product-row' + return_product_row + ' .date').datepicker({dateFormat: 'yy-mm-dd'});
	Cufon.replace('.return-remove');
	return_product_row++;
}
//--></script> 
<?php echo $footer; ?>