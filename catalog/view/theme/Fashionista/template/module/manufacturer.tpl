<div class="column_cont">
  <div class="column_head c1"><h3><?php echo $heading_title; ?></h3></div>
  <div class="column_content manuf">
  	<ul id="manuf" class="c1">
      <?php foreach ($manufacturers as $manufacturer) { ?>
      <li><a href="<?php echo $manufacturer['href']; ?>" title="<?php echo $manufacturer['name']; ?>"><?php echo $manufacturer['name']; ?></a></li>
      <?php } ?>
    </ul>
    <div class="c"></div>  	
  </div>
</div>