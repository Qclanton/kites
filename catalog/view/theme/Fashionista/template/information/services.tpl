<?php
// It will be moved, moved!

// Fetch info about manufacturers
$manufacturers = $this->db->query("
	SELECT 
		oc_manufacturer.`manufacturer_id` AS 'id',
		oc_manufacturer.`name` AS 'name',
			(
				SELECT 
					oc_category.`category_id` AS 'category_id'
				FROM 
					`oc_category`
					JOIN `oc_product_to_category` ON (oc_product_to_category.`category_id`=oc_category.`category_id`)
					JOIN `oc_product` ON (oc_product.`product_id`=oc_product_to_category.`product_id`)
				WHERE 1
					AND oc_product.`manufacturer_id`=oc_manufacturer.`manufacturer_id`
					AND oc_product_to_category.`main_category`='0'
				GROUP BY oc_category.`category_id`
				ORDER BY COUNT(oc_product_to_category.`product_id`) DESC
				LIMIT 1
			) AS 
		'main_category_id'
	FROM 
		`oc_manufacturer`
	ORDER BY oc_manufacturer.`name`
")->rows;



// Group by first letters
$grouped_manufacturers = [];

foreach ($manufacturers as $manufacturer) {
	$first_letter = substr($manufacturer['name'], 0, 1);
	
	// Cut manufacturers without category
	if (!empty($manufacturer['main_category_id'])) {
		$grouped_manufacturers[$first_letter][] = $manufacturer;
	}
}
?>

<div class="services">
	<div class="services_upper">
		<div class="width-wrapper">
			<img src="/catalog/view/theme/Fashionista/img/services/ass.png" />
			<ul>
				<li>
					<a href="/servisy#manufacturers">Поиск по производителям</a>
				</li>
				<li>
					<a href="/servisy#sertificats">Подарочные сертификаты</a>
				</li>
				<li>
					<a href="/servisy#repair_kaits">Ремонт кайтов</a>
				</li>
				<li>
					<a href="/servisy#repair_boards">Ремонт досок</a>
				</li>
			</ul>
		</div>
		
		<h4 class="page__title-extra">Сервисы</h4>
	</div>
	
	<div class="width-wrapper">
		<div class="four_cols-wrapper">
			<h1 id="manufacturers">	Поиск по производителям</h1>
			
			<?php foreach ($grouped_manufacturers as $first_letter=>$manufacturers) { ?>
				<ul>
						<li>
							<h2><?= $first_letter ?> </h2>
						</li>
					
					<?php foreach ($manufacturers as $manufacturer) { ?>
						<li>
							<?php $link = $this->url->link("product/category", "path={$manufacturer['main_category_id']}") . "?filters[manufacturer][0]={$manufacturer['id']}" ?>
							<a href="<?=$link ?>"><?= $manufacturer['name'] ?></a>
						<li>
					<?php } ?>
				</ul>
			<?php } ?>
		</div>
	</div>
	<section class="wrapper__wild">
		<div class="width-wrapper">
			<h1 id="sertificats">
				Подарочные сертификаты
			</h1>
			<div class="sertificates">
				<div class="text">
					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Totam obcaecati beatae.
				</div>
			</div>
		</div>
		<form action="" method="POST">
			<div class="columns">
				<div class="column">
					<h2 class="title title--underlined title__arrow title__arrow--small"> 
						<div class="width_wrapper-two-cols">
							Получатель
						</div>
					</h2>
					<div class="width_wrapper-two-cols">
						<ul class="reg_inputs">
							<li>
								<label for="mail">E-mail</label> <input id="mail" type="text" /></li>
							<li>
								<label for="fio">Имя</label> <input id="fio" type="text" /></li>
						</ul>
					</div>
				</div>
				<div class="column">
					<h2 class="title title--underlined title__arrow title__arrow--small">
						<div class="width_wrapper-two-cols">
							Даритель
						</div>
					</h2>
					<div class="width_wrapper-two-cols">
						<ul class="reg_inputs">
							<li>
								<label for="mail">E-mail</label> <input id="mail" type="text" />
							</li>
							<li>
								<label for="fio">Имя</label> <input id="fio" type="text" />
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="row_universal width-wrapper">
				<ul>
					<li>
						<label for="">Сумма</label> <input type="text" /> <label for="">от 100 р. до 100,000 р.</label>
					</li>
					<li>
						<input id="I_know" type="checkbox" /> <label for="I_know">Мне известно что подарочный сертификат возврату не подлежит.</label>
					</li>
					<li>
						<input type="submit" value="Оформить" />
					</li>
				</ul>
			</div>
		</form>
	</section>
</div>

<section class="wrapper__wild">
	<h1 id="repair_kaits" class="title title--underlined title__arrow title__arrow--small">
		<div class="width-wrapper">
			Ремонт кайтов
		</div>
	</h1>
	<div class="width-wrapper">
		<div class="repair_kaites">
			<div class="text">
				Lorem ipsum dolor sit amet, consectetur adipisicing elit. Libero mollitia, neque minus eaque. Quos temporibus, minus totam enim, nam vitae corporis dolorem. Vitae porro, saepe suscipit! Accusantium asperiores quam laudantium.
			</div>
			<ul>
				<li>
					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Vitae facere delectus earum odit numquam. Mollitia soluta itaque, aspernatur incidunt! Culpa, doloremque maxime placeat est soluta molestias. Est officia, eligendi quo!
				</li>
				<li>
					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique deleniti tempore nulla ad, natus sequi voluptate, blanditiis veniam, nobis officiis iure eveniet sit dolorem soluta laborum repellat ex laboriosam magni.
				</li>
			</ul>
		</div>
	</div>
</section>
<section class="wrapper__wild">
	<h2 class="title title--underlined title__arrow title__arrow--small">
		<div class="width-wrapper">
			Калькулятор стоимости услуг по ремонту кайтов
		</div>
	</h2>
	<div class="width-wrapper">
		<table class="inner__table">
			<tbody>
				<tr>
					<td>
						<p class="big">
							Кайт забрать и доставить</p>
						<p class="little">
							Только для Москвы.</p>
					</td>
					<td>
						<p class="red">
							900 p</p>
					</td>
					<td>
						<input type="checkbox" /></td>
					<td>
						<p class="red">
							900 p</p>
					</td>
				</tr>
				<tr>
					<td>
						<p class="big">
							Ремонт клапана <span class="imgContainer_IMG" data-title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Neque, eligendi, ea recusandae temporibus."> <a class="i" href=""><img alt="" src="img/i2.png" /></a> </span></p>
						<p class="little">
							Устранение течи клапана переклеивания.</p>
					</td>
					<td>
						<p class="red">
							500 p</p>
					</td>
					<td>
						<input type="text" value="0" /> шт</td>
					<td>
						&nbsp;</td>
				</tr>
				<tr>
					<td>
						<p class="big">
							Замена клапана</p>
						<p class="little">
							Удаление старого клапана не включена</p>
					</td>
					<td>
						<p class="red">
							700 p</p>
					</td>
					<td>
						<input type="text" value="0" /> шт</td>
					<td>
						<p class="red">
							1 400 p</p>
					</td>
				</tr>
				<tr>
					<td>
						<p class="big">
							Тюнинг впускного клапана</p>
						<p class="little">
							Удаление старого и установка нового. Стоимость нового клапана.</p>
					</td>
					<td>
						<p class="red">
							3 000 p</p>
					</td>
					<td>
						<input type="text" value="0" /> шт</td>
					<td>
						&nbsp;</td>
				</tr>
				<tr>
					<td>
						<p class="big">
							Вынуть / установить поперечный балон с системой раздельного накачивания</p>
					</td>
					<td>
						<p class="red">
							250 p</p>
					</td>
					<td>
						<input type="checkbox" /></td>
					<td>
						&nbsp;</td>
				</tr>
				<tr>
					<td>
						<p class="big">
							Вынуть / установить поперечный балон с системой OnePump</p>
					</td>
					<td>
						<p class="red">
							350 p</p>
					</td>
					<td>
						<input type="checkbox" /></td>
					<td>
						&nbsp;</td>
				</tr>
				<tr>
					<td>
						<p class="big">
							Вынуть / установить передний балон с системой раздельного накачивания</p>
					</td>
					<td>
						<p class="red">
							600 p</p>
					</td>
					<td>
						<input type="checkbox" /></td>
					<td>
						&nbsp;</td>
				</tr>
				<tr>
					<td>
						<p class="big">
							Вынуть / установить передний балон с системой OnePump</p>
					</td>
					<td>
						<p class="red">
							1 200 p</p>
					</td>
					<td>
						<input type="checkbox" /></td>
					<td>
						&nbsp;</td>
				</tr>
				<tr>
					<td>
						<p class="big">
							Ремонт ткани Рипстоп</p>
						<p class="little">
							Основное полотно купола.</p>
					</td>
					<td>
						<p class="red">
							30 p</p>
					</td>
					<td>
						<input type="text" value="0" /> см</td>
					<td>
						&nbsp;</td>
				</tr>
				<tr>
					<td>
						<p class="big">
							Ремонт ткани Дакрон</p>
						<p class="little">
							Каркас оболочки надувных баллонов и силовые элементы купола.</p>
					</td>
					<td>
						<p class="red">
							60 p</p>
					</td>
					<td>
						<input type="text" value="0" /> см</td>
					<td>
						&nbsp;</td>
				</tr>
				<tr>
					<td>
						<p class="big">
							Поиск и ремонт невидимых проколов на переднем балоне <span class="imgContainer_IMG" data-title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Neque, eligendi, ea recusandae temporibus."> <a class="i" href=""><img alt="" src="img/i2.png" /></a> </span></p>
					</td>
					<td>
						<p class="red">
							1 200 p</p>
					</td>
					<td>
						<input type="checkbox" /></td>
					<td>
						&nbsp;</td>
				</tr>
				<tr>
					<td>
						<p class="big">
							Поиск и ремонт невидимых проколов на поперечном балоне <span class="imgContainer_IMG" data-title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Neque, eligendi, ea recusandae temporibus."> <a class="i" href=""><img alt="" src="img/i2.png" /></a> </span></p>
					</td>
					<td>
						<p class="red">
							500 p</p>
					</td>
					<td>
						<input type="checkbox" /></td>
					<td>
						&nbsp;</td>
				</tr>
				<tr>
					<td>
						<p class="big">
							Ремонт грыж балонов <span class="imgContainer_IMG" data-title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Neque, eligendi, ea recusandae temporibus."> <a class="i" href=""><img alt="" src="img/i2.png" /></a> </span></p>
						<p class="little">
							От 2 до 10 см диаметром или длиной.</p>
					</td>
					<td>
						<p class="red">
							550 p</p>
					</td>
					<td>
						<input type="checkbox" /></td>
					<td>
						&nbsp;</td>
				</tr>
				<tr>
					<td>
						<p class="big">
							Ремонт разрывов грыж балонов</p>
						<p class="little">
							От 10 см диаметром или длиной.</p>
					</td>
					<td>
						<p class="red">
							60 p</p>
					</td>
					<td>
						<input type="text" value="0" /> см</td>
					<td>
						<p class="red">
							720 p</p>
					</td>
				</tr>
				<tr>
					<td>
						<p class="big">
							Удаление PU балона <span class="imgContainer_IMG" data-title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Neque, eligendi, ea recusandae temporibus."> <a class="i" href=""><img alt="" src="img/i2.png" /></a> </span></p>
						<p class="little">
							Наращивание или вставка до 50 см длиной.</p>
					</td>
					<td>
						<p class="red">
							900 p</p>
					</td>
					<td>
						<input type="checkbox" /></td>
					<td>
						&nbsp;</td>
				</tr>
				<tr>
					<td>
						<p class="big">
							Обшивание строп <span class="imgContainer_IMG" data-title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Neque, eligendi, ea recusandae temporibus."> <a class="i" href=""><img alt="" src="img/i2.png" /></a> </span></p>
						<p class="little">
							Изготовление петель с обоих концов стропы.</p>
					</td>
					<td>
						<p class="red">
							300 p</p>
					</td>
					<td>
						<input type="checkbox" /></td>
					<td>
						&nbsp;</td>
				</tr>
				<tr class="almost_last">
				</tr>
			</tbody>
		</table>
	</div>
	<div class="border_arrow--top">
		<p>
			Итого: <span class="red">3 020 р</span></p>
	</div>
</section>
<section class="wrapper__wild">
	<div class="width-wrapper">
		<h1 id="repair_boards">
			Ремонт досок
		</h1>
		<div class="repair_boards" id="repair_boards">
			<p>
				Lorem ipsum dolor sit amet, consectetur adipisicing elit. Totam obcaecati beatae.
			</p>
		</div>
	</div>
</section>
