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
<div class="table-listings">
  <table >
    <thead>
      <tr>
        <td class="left" colspan="2"><?php echo $text_order_detail; ?></td>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="left"><?php if ($invoice_no) { ?>
          <b><?php echo $text_invoice_no; ?></b> <?php echo $invoice_no; ?><br />
          <?php } ?>
          <b><?php echo $text_order_id; ?></b> #<?php echo $order_id; ?><br />
          <b><?php echo $text_date_added; ?></b> <?php echo $date_added; ?></td>
        <td class="left"><b><?php echo $text_payment_method; ?></b> <?php echo $payment_method; ?><br />
          <?php if ($shipping_method) { ?>
          <b><?php echo $text_shipping_method; ?></b> <?php echo $shipping_method; ?>
          <?php } ?></td>
      </tr>
    </tbody>
  </table>
  <table style="margin-top:20px">
    <thead>
      <tr>
        <td class="left"><?php echo $text_payment_address; ?></td>
        <?php if ($shipping_address) { ?>
        <td class="left"><?php echo $text_shipping_address; ?></td>
        <?php } ?>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="left"><?php echo $payment_address; ?></td>
        <?php if ($shipping_address) { ?>
        <td class="left"><?php echo $shipping_address; ?></td>
        <?php } ?>
      </tr>
    </tbody>
  </table>
  </div>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="reorder">
    <div class="cart-info info-cr">
    <table>
      <thead>
        <tr>
          <td><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
          <td><?php echo $column_name; ?></td>
          <td><?php echo $column_model; ?></td>
          <td><?php echo $column_quantity; ?></td>
          <td><?php echo $column_price; ?></td>
          <td class="total"><?php echo $column_total; ?></td>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($products as $product) { ?>
        <tr>
          <td><?php if ($product['selected']) { ?>
            <input type="checkbox" name="selected[]" value="<?php echo $product['order_product_id']; ?>" checked="checked" />
            <?php } else { ?>
            <input type="checkbox" name="selected[]" value="<?php echo $product['order_product_id']; ?>" />
            <?php } ?></td>
          <td><?php echo $product['name']; ?>
            <?php foreach ($product['option'] as $option) { ?>
            <br />
            &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
            <?php } ?></td>
          <td><?php echo $product['model']; ?></td>
          <td><?php echo $product['quantity']; ?></td>
          <td><?php echo $product['price']; ?></td>
          <td class="total"><?php echo $product['total']; ?></td>
        </tr>
        <?php } ?>
      </tbody>
      </table>
      </div>
      
      <div class="cart-total tot-check">
      <table>
        <?php foreach ($totals as $total) { ?>
        <tr>
          <td colspan="5" class="right"><b><?php echo $total['title']; ?></b></td>
          <td class="right"><?php echo $total['text']; ?></td>
        </tr>
        <?php } ?>
    </table>

    </div>
    <br />
    <?php echo $text_action; ?>
        <select name="action" onchange="$('#reorder').submit();">
          <option value=""><?php echo $text_selected; ?></option>
          <option value="reorder"><?php echo $text_reorder; ?></option>
          <option value="return"><?php echo $text_return; ?></option>
        </select>
  </form>
<div class="c"></div>
  <?php if ($comment) { ?>
  	<h2 class="c1_color"><?php echo $text_comment; ?></h2>
  	<?php echo $comment; ?><br />
  <?php } ?>
  <?php if ($histories) { ?>
  <br /><br /><h2 class="c1_color"><?php echo $text_history; ?></h2>
  <div class="cart-info info-cr">
  <table>
    <thead>
      <tr>
        <td class="left" width="10%"><?php echo $column_date_added; ?></td>
        <td class="left" width="10%"><?php echo $column_status; ?></td>
        <td class="left"><?php echo $column_comment; ?></td>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($histories as $history) { ?>
      <tr>
        <td class="left"><?php echo $history['date_added']; ?></td>
        <td class="left"><?php echo $history['status']; ?></td>
        <td class="left"><?php echo $history['comment']; ?></td>
      </tr>
      <?php } ?>
    </tbody>
  </table>
  </div>
  <?php } ?>
<br /><br />
    <div class="button c1"><a href="<?php echo $continue; ?>"><span><?php echo $button_continue; ?></span></a></div>


	
  <div class="c"></div>
</div>


  </div>
  </div>
<?php echo $footer; ?>