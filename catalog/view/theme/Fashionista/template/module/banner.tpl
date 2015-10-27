
  <div class="banner">
  <?php foreach ($banners as $banner) { ?>
  <?php if ($banner['link']) { ?>
  <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" /></a>
  <?php } else { ?>
  <a href="#"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" /></a>
  <?php } ?>
  <?php } ?>
    <div class="c"></div>  	
  </div>
  <script>
  	$(function ($){
  		
  		var $banner_rotator;
  		
  		$('.banner a').hide();
  		
  		$('.banner a').hover(function (){
  			$(this).fadeTo('fast', 0.7)
  		}, function (){
  			$(this).fadeTo('fast', 1)
  		});
  		
  		$.BannerRotation = function (){
  			
  				$('.banner a').hide();
  				// $new = $('.banner a:first');
  				// $('.banner a:first').remove();
  				
  				$('.banner a:first').before($('.banner a:last'));
  				
  				$banner_rotator = setTimeout(function (){
	  				$.BannerRotation();
	  			},6000);
	  			
	  			$('.banner a:first').fadeIn();
  		}
  		
  		$('.banner a:first').show(function (){
  			$banner_rotator = setTimeout(function (){
  				$.BannerRotation();
  			},6000);
  		});
  	})
  </script>