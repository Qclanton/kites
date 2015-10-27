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

<div class="column_right">

</div>

<div id="main_column_st">
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="contact">
    <h2 class="c1_color"><?php echo $text_location; ?></h2>
    <div class="contact">
<div class="left"><strong><?php echo $text_address; ?></strong><br />
        <?php echo $store; ?><br />
        <?php echo $address; ?></div>
      <div class="right">
        <?php if ($telephone) { ?>
        <strong><?php echo $text_telephone; ?></strong><br />
        <?php echo $telephone; ?><br />
        <br />
        <?php } ?>
        <?php if ($fax) { ?>
        <b><?php echo $text_fax; ?></b><br />
        <?php echo $fax; ?>
        <?php } ?>
      </div>
      <div class="c"></div>

<center><h1 class="c1_color">КАЙТ МАГАЗИН “PRO SHOP” РАБОТАЕТ ЕЖЕДНЕВНО С 10 ДО 21 ЧАСА</h1></center><br />
<p style="text-align: center;"><img src="http://www.kites.ru/images/news/shema_pro.jpg" alt="ProShop"></p>
<p align="center">Местоположение кайтового магазина "Pro Shop" также можно посмотреть здесь:<br><a href="http://maps.yandex.ru/-/CJH7eW73" target="_blank"><img src="http://kites.ru/images/news/yandex-maps.png" align="absMiddle" border="0" hspace="5" vspace="5">Яндекс.Карты</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://maps.google.ru/maps/ms?msid=212597665920638534065.000482d7b4270c078e314&amp;msa=0&amp;ll=55.708733,37.583928&amp;spn=0.005706,0.016469" target="_blank"><img src="http://www.kites.ru/images/news/google-maps.png" align="absMiddle" border="0" hspace="5" vspace="5">Google Maps</a>&nbsp;&nbsp;<a href="http://maps.rambler.ru/?3fQOKv5" target="_blank"><img src="http://www.kites.ru/images/news/rambler-maps.png" align="absMiddle" border="0" hspace="5" vspace="5">Рамблер Карты</a></p>	  
<br><br>
      
      <h2 class="c1_color"><?php echo $text_contact; ?></h2>
      <div class="ct">
    

    <b><?php echo $entry_name; ?></b><br />
    <input type="text" name="name" value="<?php echo $name; ?>" />
    <label>
    <?php if ($error_name) { ?>
    <span class="error"><?php echo $error_name; ?></span>
    <?php } ?></label><br />
    <br />
    <b><?php echo $entry_email; ?></b><br />
    <input type="text" name="email" value="<?php echo $email; ?>" />
    <label>
    <?php if ($error_email) { ?>
    <span class="error"><?php echo $error_email; ?></span>
    <?php } ?></label><br />
    <br />
    <b><?php echo $entry_enquiry; ?></b><br />
    <textarea name="enquiry" cols="40" rows="10"><?php echo $enquiry; ?></textarea>
    <br />
    <?php if ($error_enquiry) { ?>
    <span class="error"><?php echo $error_enquiry; ?></span><br />
    <?php } ?>
    <br />
    <b><?php echo $entry_captcha; ?></b><br />
    <input type="text" name="captcha" value="<?php echo $captcha; ?>" />
    <label>    <?php if ($error_captcha) { ?>
    <span class="error"><?php echo $error_captcha; ?></span>
    <?php } ?></label>
    <br /><br />
    <img src="<?php echo HTTP_SERVER; ?>index.php?route=information/contact/captcha" alt="" />

  <div class="buttons">
    <div class="button c1"><a href="#" onclick="$('#contact').submit(); return false;"><span><?php echo $button_continue; ?></span></a></div>
  </div>
    </div>
        </div>
  </form>
  <div class="c"></div>
</div>


  </div>
  </div>
<?php echo $footer; ?>
