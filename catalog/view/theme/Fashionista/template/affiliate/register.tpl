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


  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <p><?php echo $text_account_already; ?></p>
  <p><?php echo $text_signup; ?></p><br /><br />
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="register">
    <h2 class="c1_color"><?php echo $text_your_details; ?></h2><br />
    
    <span class="required">*</span> <?php echo $entry_firstname; ?><br />
    <input type="text" name="firstname" value="<?php echo $firstname; ?>" />
            <?php if ($error_firstname) { ?>
            <span class="error"><?php echo $error_firstname; ?></span>
            <?php } ?><br /><br />
    
    <span class="required">*</span> <?php echo $entry_lastname; ?><br />
    <input type="text" name="lastname" value="<?php echo $lastname; ?>" />
            <?php if ($error_lastname) { ?>
            <span class="error"><?php echo $error_lastname; ?></span>
            <?php } ?><br /><br />
            
    <span class="required">*</span> <?php echo $entry_email; ?><br />
    <input type="text" name="email" value="<?php echo $email; ?>" />
            <?php if ($error_email) { ?>
            <span class="error"><?php echo $error_email; ?></span>
            <?php } ?><br /><br />        
            
    <span class="required">*</span> <?php echo $entry_telephone; ?><br />
    <input type="text" name="telephone" value="<?php echo $telephone; ?>" />
            <?php if ($error_telephone) { ?>
            <span class="error"><?php echo $error_telephone; ?></span>
            <?php } ?><br /><br />
            
    <?php echo $entry_fax; ?><br />
           <input type="text" name="fax" value="<?php echo $fax; ?>" /><br /><br />
           
           
       
   <br />
    <h2 class="c1_color"><?php echo $text_your_address; ?></h2><br />
    
    
    <?php echo $entry_company; ?><br />
    <input type="text" name="company" value="<?php echo $company; ?>" /><br /><br />
    
    <?php echo $entry_website; ?><br />
    <input type="text" name="website" value="<?php echo $website; ?>" /><br /><br />
    
    <span class="required">*</span> <?php echo $entry_address_1; ?><br />
    <input type="text" name="address_1" value="<?php echo $address_1; ?>" />
            <?php if ($error_address_1) { ?>
            <span class="error"><?php echo $error_address_1; ?></span>
            <?php } ?><br /><br />
            
    
    <?php echo $entry_address_2; ?><br />
    <input type="text" name="address_2" value="<?php echo $address_2; ?>" /><br /><br />
    
    <span class="required">*</span> <?php echo $entry_city; ?><br />
    <input type="text" name="city" value="<?php echo $city; ?>" />
            <?php if ($error_city) { ?>
            <span class="error"><?php echo $error_city; ?></span>
            <?php } ?><br /><br />
            
    <span class="required">*</span> <?php echo $entry_postcode; ?><br />
    
    <input type="text" name="postcode" value="<?php echo $postcode; ?>" />
            <?php if ($error_postcode) { ?>
            <span class="error"><?php echo $error_postcode; ?></span>
            <?php } ?><br /><br />
            
    
    <span class="required">*</span> <?php echo $entry_country; ?><br />
           <select name="country_id" onchange="$('select[name=\'zone_id\']').load('<?php echo HTTP_SERVER; ?>index.php?route=account/register/zone&country_id=' + this.value + '&zone_id=<?php echo $zone_id; ?>');">
              <option value="false"><?php echo $text_select; ?></option>
              <?php foreach ($countries as $country) { ?>
              <?php if ($country['country_id'] == $country_id) { ?>
              <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
            <?php if ($error_country) { ?>
            <span class="error"><?php echo $error_country; ?></span>
            <?php } ?><br /><br />
            
     <span class="required">*</span> <?php echo $entry_zone; ?><br />
     <select name="zone_id">
            </select>
            <?php if ($error_zone) { ?>
            <span class="error"><?php echo $error_zone; ?></span>
            <?php } ?><br /><br />
    
    <br />
    <h2 class="c1_color"><?php echo $text_payment; ?></h2>
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
                                                

<br /><br />
    
    <h2 class="c1_color"><?php echo $text_your_password; ?></h2>
    
    <span class="required">*</span> <?php echo $entry_password; ?><br />
    <input type="password" name="password" value="<?php echo $password; ?>" />
            <?php if ($error_password) { ?>
            <span class="error"><?php echo $error_password; ?></span>
            <?php } ?><br /><br />
            
    <span class="required">*</span> <?php echo $entry_confirm; ?><br />
    <input type="password" name="confirm" value="<?php echo $confirm; ?>" />
            <?php if ($error_confirm) { ?>
            <span class="error"><?php echo $error_confirm; ?></span>
            <?php } ?><br /><br />
            

    <?php if ($text_agree) { ?>
      <?php echo $text_agree; ?>
      <?php } ?>
      
        <?php if ($agree) { ?>
        <input type="checkbox" name="agree" value="1" checked="checked" />
        <?php } else { ?>
        <input type="checkbox" name="agree" value="1" />
        <?php } ?>
        <br /><br />
        <div class="button c1"><a onclick="$('#register').submit(); return false" href="#"><span><?php echo $button_continue; ?></span></a></div>
    

  </form>
  <div class="c"></div>

<script type="text/javascript"><!--
$('select[name=\'zone_id\']').load('<?php echo HTTP_SERVER; ?>index.php?route=account/register/zone&country_id=<?php echo $country_id; ?>&zone_id=<?php echo $zone_id; ?>');
//--></script> 
<script type="text/javascript"><!--
$('input[name=\'payment\']').bind('change', function() {
	$('.payment').hide();
	
	$('#payment-' + this.value).show();
});

$('input[name=\'payment\']:checked').trigger('change');

$('.fancybox').fancybox();	

//--></script>   
  
</div>


  </div>
  </div>
<?php echo $footer; ?>

