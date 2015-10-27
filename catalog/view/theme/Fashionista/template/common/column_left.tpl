<div class="sidebar">

        <div class="filters first">
            фильтры: <a href="" class="clear_filter red_btn">сбросить фильтры</a>
        </div>

<?php if ($modules) { ?>

  <?php foreach ($modules as $module) { ?>
  <?php echo $module; ?>
  <?php } ?>

<?php } ?> 

</div>