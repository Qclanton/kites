<?php echo $header; ?>

<div class="main-wrapper">
<main class="padding_wrapper">

    <div class="breadcrubs">
        <ul>
	<?php foreach ( $breadcrumbs as $breadcrumb ) {  ?>
		<?php if ($breadcrumb[ 'text' ] != 'Главная') { ?>
            <li><a href="<?php echo $breadcrumb[ 'href' ]; ?>"><?php echo $breadcrumb[ 'text' ]; ?></a></li>
            <li><span> > </span></li>
		<?php } ?>
        <?php } ?>
        </ul>
    </div>

	<?php echo $column_left; ?>

    <div class="content">

        <?php
        if ( $products )
        {
            ?>

<?php $uri_parts = explode('?', $_SERVER['REQUEST_URI'], 2); ?>
        <div class="filters second">
            <ul class="show">
                <li><span>показывать</span></li>
                <li><a href="<?php echo $uri_parts[0]; ?>?limit=24">24</a></li>
                <li><span>|</span></li>
                <li><a href="<?php echo $uri_parts[0]; ?>?limit=48">48</a></li>
                <li><span>|</span></li>
                <li><a href="<?php echo $uri_parts[0]; ?>?limit=200">все&nbsp;<span class="allpages"></span></a></li>
            </ul>
		<ul class="pages limit">
                    <?php
                    $pagination_new_urls = str_replace( '/?page=' , '/page/' , $pagination );
                    $pagination_new_urls = str_replace( '/page/1/' , '/' , $pagination_new_urls );
                    echo $pagination_new_urls;
                    ?>
                </ul>

            <ul class="sort" id="sha-sort">
		<li><span>сортировка:</span></li>
		<?php foreach ($sorts as $sort_key => $sort_val) { ?>
		<li>
		<?php if ($sort_val['value'] == $sort . '-' . $order) { 
				if ($order == 'ASC') { $sort_val['href'] = str_replace('ASC','DESC',$sort_val['href']); } else { $sort_val['href'] = str_replace('DESC','ASC',$sort_val['href']); }
			} ?>
		<a style="text-align:center" sort-class="<?php echo $sort_val['value']; ?>" class="sha-sortitem" href="<?php echo $sort_val['href']; ?>"><?php echo $sort_val['text']; ?></a>
		</li>
                <li><span>|</span></li>
		<?php } ?>
            </ul>
        </div>

		<div class="article-wrapper">
			<div class="universal__wrapper clearfix three_cols--inner">
				<?php foreach ( $products as $product ) { ?>

				<div class="universal__cell product__cell">

					<?php

					//echo('<pre style="font-size: 10px;">');
					//var_dump($product);
					//echo('</pre>');
					$skidka = round( ((floatval( $product[ 'price' ] ) - floatval( $product[ 'special' ] )) / floatval( $product[ 'price' ] )) * 100 , 2 );

					?>

					<div class="img">
						<span class="new">Новинка</span>
						<a class="catproductimg" href="<?php echo $product[ 'href' ]; ?>" style="background-image: url(<?php if (isset($product['thumb'])) { echo $product[ 'thumb' ]; } else { echo '/catalog/view/theme/Fashionista/img/no_picture.jpg'; } ?>);"> </a>
					</div>
					<h2 class="name">
						<a href="<?php echo $product[ 'href' ]; ?>">
							<span class="upper"><?php echo $product[ 'name' ]; ?></span>
							<span class="year"><?php echo $product[ 'model' ]; ?></span>
						</a>
					</h2>
					<p class="price">
						<?php if ( $product[ 'special' ] > 0) { ?>
							<span class="red"><?php echo $product[ 'special' ]; ?></span>
							<span class="old"><?php echo $product[ 'price' ]; ?></span>
						<?php } else { ?>
							<span class="red">
								<?php echo $product[ 'price' ]; ?>
							</span>
						<?php } ?>
						<span class="buy">Купить</span>
					</p>

				</div>

				<?php } ?>
			</div>
		</div>

        <div class="filters third">
            <ul class="show">
                <li><span>показывать</span></li>
                <li><a href="<?php echo $uri_parts[0]; ?>?limit=24">24</a></li>
                <li><span>|</span></li>
                <li><a href="<?php echo $uri_parts[0]; ?>?limit=48">48</a></li>
                <li><span>|</span></li>
                <li><a href="<?php echo $uri_parts[0]; ?>?limit=200">все&nbsp;<span class="allpages"></span></a></li>
            </ul>
			<ul class="pages limit">
				<?php
				$pagination_new_urls = str_replace( '/?page=' , '/page/' , $pagination );
				$pagination_new_urls = str_replace( '/page/1/' , '/' , $pagination_new_urls );
				echo $pagination_new_urls;
				?>
			</ul>
            <ul class="sort">
				<li><span>сортировка:</span></li>
				<?php foreach ($sorts as $sort_key => $sort_val) { ?>
				<li>
				<?php if ($sort_val['value'] == $sort . '-' . $order) { 
						if ($order == 'ASC') { $sort_val['href'] = str_replace('ASC','DESC',$sort_val['href']); } else { $sort_val['href'] = str_replace('DESC','ASC',$sort_val['href']); }
					} ?>
				<a style="text-align:center" sort-class="<?php echo $sort_val['value']; ?>" class="sha-sortitem" href="<?php echo $sort_val['href']; ?>"><?php echo $sort_val['text']; ?></a>
				</li>
				<li><span>|</span></li>
				<?php } ?>
            </ul>
			<div class="sort" style="display:none;"><b>Сортировать по:</b>
						   <select id="filterpro_outer_sort" onchange="doFilter(true);">
							   <option value="p.date_added-DESC" data-st="p.date_added-DESC" selected="selected">По умолчанию</option>
							   <option  value="(p.price/ps.price)-DESC" data-st="(p.price/ps.price)-DESC" >По Скидке</option>
							   <option  value="(p.price/ps.price)-ASC" data-st="(p.price/ps.price)-ASC" >По Скидке</option>
							   <option  value="p.price-ASC" data-st="p.price-ASC" >Цена</option>
							   <option  value="p.price-DESC" data-st="p.price-DESC" >Цена</option>
							</select>                    
			</div>
        </div>

		<div class="pagination" style="display: none;">
		</div>

            <?php
        }
        else
        {
            ?>
            <div id="main_column">
                <?php echo $text_empty; ?>
            </div>
        <?php } ?>

        <?php echo $content_bottom; ?>


	</div>

</main>
</div>

<?php echo $footer; ?>