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
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="payment">
    <h2 class="c1_color"><?php echo $text_your_payment; ?></h2>
    
	<?php echo $entry_tax; ?><br />
	<input type="text" name="tax" value="<?php echo $tax; ?>" /><br /><br />
	
	
	<?php echo $entry_payment; ?>&nbsp;<?php if ($payment == 'cheque') { ?>
              <input type="radio" name="payment" value="cheque" id="cheque" checked="checked" />
              <?php } else { ?>
              <input type="radio" name="payment" value="cheque" id="cheque" />
              <?php } ?>
              <label for="cheque"><?php echo $text_cheque; ?></label>
              <?php if ($payment == 'paypal') { ?>
              <input type="radio" name="payment" value="paypal" id="paypal" checked="checked" />
              <?php } else { ?>
              <input type="radio" name="payment" value="paypal" id="paypal" />
              <?php } ?>
              <label for="paypal"><?php echo $text_paypal; ?></label>
              <?php if ($payment == 'bank') { ?>
              <input type="radio" name="payment" value="bank" id="bank" checked="checked" />
              <?php } else { ?>
              <input type="radio" name="payment" value="bank" id="bank" />
              <?php } ?>
              <label for="bank"><?php echo $text_bank; ?></label>
      
        
                <br /><br />
        <div id="payment-cheque" class="payment">
        	<?php echo $entry_cheque; ?><br />
        	<input type="text" name="cheque" value="<?php echo $cheque; ?>" />
        </div>
        
        <div id="payment-paypal" class="payment">
        	<?php echo $entry_paypal; ?><br />
        	<input type="text" name="paypal" value="<?php echo $paypal; ?>" />
        </div>
        
        <div id="payment-bank" class="payment">
        	<?php echo $entry_bank_name; ?><br />
        	<input type="text" name="bank_name" value="<?php echo $bank_name; ?>" /><br /><br />
        	
        	<?php echo $entry_bank_branch_number; ?><br />
        	<input type="text" name="bank_branch_number" value="<?php echo $bank_branch_number; ?>" /><br /><br />
        	
        	<?php echo $entry_bank_swift_code; ?><br />
        	<input type="text" name="bank_swift_code" value="<?php echo $bank_swift_code; ?>" /><br /><br />
        	
        	<?php echo $entry_bank_account_name; ?><br />
        	<input type="text" name="bank_account_name" value="<?php echo $bank_account_name; ?>" /><br /><br />
        	
        	<?php echo $entry_bank_account_number; ?><br />
        	<input type="text" name="bank_account_number" value="<?php echo $bank_account_number; ?>" /><br /><br />
        	
        </div>
        
            

<br />
      <div class="button c1" style="margin-right:10px"><a href="<?php echo $back; ?>"><span><?php echo $button_back; ?></span></a></div>
      <div class="button c1"><a onclick="$('#payment').submit(); return false" href="#"><span><?php echo $button_continue; ?></span></a></div>

  </form>
  <div class="c"></div>
  <script type="text/javascript"><!--
$('input[name=\'payment\']').bind('change', function() {
	$('.payment').hide();
	
	$('#payment-' + this.value).show();
});

$('input[name=\'payment\']:checked').trigger('change');
//--></script> 
</div>


  </div>
  </div>
<?php echo $footer; ?>
