<div class="column_cont">
  <div class="column_head c1"><h3>Manufacturers</h3></div>
  <div class="column_content manuf">
  	<ul id="manuf" class="c1">
      <?php foreach ($banners as $banner) { ?>
      <li><a href="<?php echo $banner['link']; ?>" title="<?php echo $banner['title']; ?>"><?php echo $banner['title']; ?></a></li>
      <?php } ?>
    </ul>
    <div class="c"></div>  	
  </div>
</div>