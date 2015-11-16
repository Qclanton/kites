<?php echo $header; ?>

<div class="main-wrapper">
	<?php 
		// var_dump($this->data);
		if ($heading_title == "Сервисы") {
			require "services.tpl";
		} else {
			echo $description; 	
		}	
	?>
</div>

<?php echo $footer; ?>
