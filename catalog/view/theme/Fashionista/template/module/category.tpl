        <div class="goods">
            <ul>
		        <?php foreach ($categories as $category) { ?>
				<?php if($category['category_id'] == $category_id) { ?>
			            <?php foreach ($category['children'] as $child) { ?>
			            <li>
			              <?php if ($child['category_id'] == $child_id) { ?>
			              <a href="<?php echo $child['href']; ?>" class="active"> <?php echo $child['name']; ?></a>
			              <?php } else { ?>
			              <a href="<?php echo $child['href']; ?>"> <?php echo $child['name']; ?></a>
			              <?php } ?>
			            </li>
			            <?php } ?>
		            	<?php } ?>
		        <?php } ?>
            </ul>
        </div>
