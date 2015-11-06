<?php 
// Info about total products
preg_match("/<div class=\"total\">(\\d*)<\\/div>/m", $pagination, $total_products_info);
$total_products = (!empty($total_products_info[1]) ? $total_products_info[1] : 0);
?>

<div class="filters">
	<ul class="show">
			<li><span>показывать</span></li>
			<li><a href="<?= $url['root'] ?>?limit=24<?= $url['sort'] . $url['order'] . $url['filters'] ?>">24</a></li>
			<li><span>|</span></li>
			<li><a href="<?= $url['root']  ?>?limit=48<?= $url['sort'] . $url['order'] . $url['filters'] ?>">48</a></li>			
			
		<? if ($total_products > 48) { ?>
			<li><span>|</span></li>
			<li>
				<a href="<?= $url['root'] ?>?limit=<?= $total_products . $url['sort'] . $url['order'] . $url['filters'] ?>">
					все <span class="allpages"><?= $total_products ?></span>
				</a>
			</li>
		<? } ?>
	</ul>
	
	<ul class="pages limit">
		<?= $pagination ?>
	</ul>
	
	<ul class="sort" id="sha-sort">
			<li><span>сортировка:</span></li>

		<?php foreach ($possible_sorts as $possible_sort) { ?>				
			<li>
				<a class="sha-sortitem" href="<?= $possible_sort['href']?>"><?= $possible_sort['text']; ?></a>
			</li>
			<li>
				<span>|</span>
			</li>
		<?php } ?>
	</ul>
</div>
				
