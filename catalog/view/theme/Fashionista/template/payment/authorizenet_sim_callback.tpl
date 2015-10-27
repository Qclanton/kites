<h2 class="c"><?php echo $x_response_reason_text; ?></h2>
<?php if($x_response_code == '1') { ?>
<p>Your payment was processed successfully. Here is your receipt:</p>
<pre>
<?php echo $exact_ctr; ?></pre>
<?php if(!empty($exact_issname)) { ?>
<p>Issuer: <?php echo $exact_issname; ?><br/>
  Confirmation Number: <?php echo $exact_issconf; ?> </p>
<?php } ?>

  <table>
    <tr>
      <td align="left"></td>
      <td align="right"><div class="button c1"><a onclick="location = '<?php echo $confirm; ?>'; return false"><span><?php echo $button_confirm; ?></span></a></div></td>
    </tr>
  </table>

<?php } elseif($_REQUEST['x_response_code'] == '2') { ?>
<p>Your payment failed.  Here is your receipt.</p>
<pre>
<?php echo $exact_ctr; ?></pre>

  <table>
    <tr>
      <td align="left"><div class="button c1"><a onclick="location = '<?php echo $back; ?>'; return false" href="#"><span><?php echo $button_back; ?></span></a></div></td>
      <td align="right"></td>
    </tr>
  </table>
<?php } else { ?>
<p>An error occurred while processing your payment. Please try again later.</p>
  <table>
    <tr>
      <td align="left"><div class="button c1"><a onclick="location = '<?php echo $back; ?>'; return false"><span><?php echo $button_back; ?></span></a></div></td>
      <td align="right"></td>
    </tr>
  </table>
<?php } ?>
