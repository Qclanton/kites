<div class="home c3">
	<div class="container">
		<a href="<?php echo $this->language->get('link_fb'); ?>" target="_blank" class="fb social"></a>
		<a href="<?php echo $this->language->get('link_tw'); ?>" target="_blank" class="tw social"></a>
		<div class="title">
			<a href="#"><h1><?php echo $this->language->get('text_welcome_title'); ?></h1></a>
		</div>
		<div class="subtitle"><?php echo $this->language->get('text_welcome_content'); ?></div>
		<div class="slide">
    <a href="#" class="arr_left c1" style="left: 40px; top: 200px;"></a>
    <a href="#" class="arr_right c1" style="top: 200px; left: 370px;"></a>
		</div>
		<div class="wing"></div>
		<div class="slideshow">
			<ul class="slide_list">
		    <?php foreach ($banners as $banner) { ?>
		    <?php if ($banner['link']) { ?>
		    <li><a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" /></a></li>
		    <?php } else { ?>
		    <li><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" /></li>
		    <?php } ?>
		    <?php } ?>
		    </ul>		
		</div>
		<a href="<?php echo $banner['link']; ?>" title="<?php echo $banners[0]['title']; ?>" class="banner_title"><?php echo $banners[0]['title']; ?></a>
		<a href="<?php echo $banner['link']; ?>" title="<?php echo $banners[0]['title']; ?>" class="banner_show"><?php echo $this->language->get('text_custom_offer'); ?></a>
	</div>
</div>
<div class="c"></div>