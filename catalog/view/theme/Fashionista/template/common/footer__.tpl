<div class="footer_line"><div></div>
<footer>
	<div class="footer_container">
	<div class="options">
		
		  <div class="container">
			  <ul>
				  <li><span class="c1"><?php echo $this->language->get('text_themename'); ?></span>
					  <div class="about">
						<?php echo $this->language->get('text_themeabout'); ?>
						</div>
				  </li>

				  <li id="foot_cats"><span class="c1"><?php echo $this->language->get('text_cats'); ?></span>
				  </li>
				  <li><span class="c1"><?php echo $this->language->get('text_contact'); ?></span><br /><br />
					  <div class="phone_icon contact_icons"><?php echo $this->language->get('text_phone'); ?></div>
					  <div class="mail_icon contact_icons"><a style="color:#303030; text-decoration: none;" href="mailto:<?php echo $this->language->get('text_email'); ?>?subject=Письмо от посетителя Shop.Kites.Ru" title="Написать нам по электронной почте"><?php echo $this->language->get('text_email'); ?></a></div>
					  <div class="skype_icon contact_icons"><a style="color:#303030; text-decoration: none;" href="skype:shop.kites.ru?chat" title="Написать нам в скайп">shop.kites.ru</a></div>
					  <div class="icq_icon contact_icons"><a style="color:#303030; text-decoration: none;" href="http://www.icq.com/whitepages/cmd.php?uin=89101012&action=message" target="_blank" title="Написать нам в ICQ">ICQ#89101012</a></div>
				   </li>
				  <li>          
				  <div id="facebookw">       
<div class="fb-like-box" data-href="http://www.facebook.com/www.kites.ru" data-width="290" data-height="180" data-border-color="fff" data-show-faces="true" data-stream="false" data-header="false"></div>              
				  </div> 
				  </li>
				  
			  </ul>
		  </div>        
	</div>
	
	  <div class="ending">
		  <div class="container">
			  <ul>
				  <li><span><?php echo $this->language->get('text_information'); ?></span>
					  <ul>
						<?php foreach ($informations as $information) { ?>
						<li><a href="<?php echo $information['href']; ?>" title="<?php echo $information['title']; ?>"><?php echo $information['title']; ?></a></li>
						<?php } ?>
						<li><a href="<?php echo $contact; ?>" title="<?php echo $text_contact; ?>"><?php echo $text_contact; ?></a></li>
					  </ul>
				  </li>
				  <li><span><?php echo $this->language->get('text_offer'); ?></span>
					  <ul>
						<li><a href="<?php echo $manufacturer; ?>" title="<?php echo $text_manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
						<li><a href="<?php echo $voucher; ?>" title="<?php echo $text_voucher; ?>"><?php echo $text_voucher; ?></a></li>
				   <!-- <li><a href="<?php echo $affiliate; ?>" title="<?php echo $text_affiliate; ?>"><?php echo $text_affiliate; ?></a></li>//-->
						<li><a href="<?php echo $special; ?>" title="<?php echo $text_special; ?>"><?php echo $text_special; ?></a></li>

						<li><a href="<?php echo $return; ?>" title="<?php echo $text_return; ?>"><?php echo $text_return; ?></a></li>
						<li><a href="<?php echo $sitemap; ?>" title="<?php echo $text_sitemap; ?>"><?php echo $text_sitemap; ?></a></li>        
					  </ul>
				  </li>
				   <li><noindex> <span class="bird"><?php echo $this->language->get('text_twitter'); ?></noindex> </span>
					  <div class="tweet"></div>
				  </li>
		<li class="copyright">           
  <noindex>         
<table width="180">
<tr width="180">
<td width="90">
<a href="http://feeds.feedburner.com/kitesru"><img src="http://feeds.feedburner.com/~fc/kitesru?bg=0099FF&amp;fg=FFFFFF&amp;anim=1" height="26" width="88" style="border:0" alt="" /></a>
</td>
<td width="90">
<script type="text/javascript" src="http://twittercounter.com/embed/kitesru/ffffff/0099FF"></script><noscript><a href="http://twittercounter.com/kitesru">Kites.Ru on Twitter Counter</a></noscript>
</td>
</tr>

<tr width="180">
<td width="90">
<!-- begin WebMoney Transfer : accept label -->
 <a href="http://www.megastock.ru/" target="_blank"><img src="http://www.megastock.ru/doc/Logo/acc_blue_on_white_ru.png" alt="www.megastock.ru" border="0"></a>
<!-- end WebMoney Transfer : accept label --></td>
<td width="90">
<!-- begin WebMoney Transfer : attestation label#86A8AB26-514E-4B25-BF6F-B3757A3CD836 --> 
<a href="https://passport.webmoney.ru/asp/certview.asp?wmid=374687725071" target=_blank><IMG SRC="http://www.webmoney.ru/img/icons/88x31_wm_v_blue_on_white_ru.png" title="Здесь находится аттестат нашего WM идентификатора 374687725071" border="0"><br></a>
<!-- end WebMoney Transfer : attestation label#86A8AB26-514E-4B25-BF6F-B3757A3CD836 -->
 
 <!-- Yandex.Metrika counter -->
<script type="text/javascript">
(function (d, w, c) {
	(w[c] = w[c] || []).push(function() {
		try {
			w.yaCounter13030102 = new Ya.Metrika({id:13030102, enableAll: true, webvisor:true});
		} catch(e) { }
	});
	
	var n = d.getElementsByTagName("script")[0],
		s = d.createElement("script"),
		f = function () { n.parentNode.insertBefore(s, n); };
	s.type = "text/javascript";
	s.async = true;
	s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js";

	if (w.opera == "[object Opera]") {
		d.addEventListener("DOMContentLoaded", f);
	} else { f(); }
})(document, window, "yandex_metrika_callbacks");
</script>
<noscript><div><img src="//mc.yandex.ru/watch/13030102" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
<!-- /Yandex.Metrika counter -->      
</td>
</tr>

</table>


<br />
				  
				  
				 <?php echo $this->language->get('text_powered'); ?></li>
			  </ul>
		  </div>
	  </div>  
</noindex>
		<script type="text/javascript" src="<?php echo HTTP_SERVER; ?>catalog/view/theme/Fashionista/javascript/jquery.tweet.js"></script>    
		<script>
			$(function($){
				$(".tweet").tweet({
					avatar_size: 32,
					count: 10,
					username: "<?php echo $this->language->get('tw_username'); ?>",
					template: '{text}<br /><br />» <span class="retweet">{retweet_action}</span>'
				});				
			})
		</script>
		</div> 
</footer> 
  <!-- 
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donatation.
Please donate via PayPal to donate@opencart.com
//-->
</body>
</html>