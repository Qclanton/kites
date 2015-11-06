<?php
// URL
if (!function_exists("getUrlParts")) {
	function getUrlParts($Controller) {
		return [
			'root' => explode("?", $_SERVER['REQUEST_URI'])[0],
			'sort' => (!empty($Controller->request->get['sort']) ? "&sort={$Controller->request->get['sort']}" : ""),
			'order' => (!empty($Controller->request->get['sort']) ? "&order={$Controller->request->get['order']}" : ""),
			'limit' =>  (!empty($Controller->request->get['limit']) ? "&limit={$Controller->request->get['limit']}" : ""),
			'filters' => (!empty($Controller->request->get['filters']) ? "&" . http_build_query(['filters'=>$Controller->request->get['filters']]) : "")
		];
	}
}






// Products
if (!function_exists("getAllProducts")) {
	function getAllProducts($Controller) {
		// Define category id
		$parts = explode("_", (string)$Controller->request->get['path']);
		$category_id = (isset($Controller->request->get['path']) 
			? (int)explode("_", (string)$Controller->request->get['path'])[0] 
			: 0
		);
		
		// Get all products
		return $Controller->model_catalog_product->getProducts(['filter_category_id'=>$category_id]);	
	}
}

if (!function_exists("prepareProducts")) {
	function prepareProducts($Controller, $products) {
		$prepared_products = [];
		
		foreach ($products as $product) {
			$prepared_products[] = [
				'product_id'  => $product['product_id'],
				'thumb'       => ($product['image']
					? $Controller->model_tool_image->resize($product['image'], $Controller->config->get("config_image_product_width"), $Controller->config->get("config_image_product_height"))
					: $Controller->model_tool_image->resize("no_image.jpg", $Controller->config->get("config_image_product_width"), $Controller->config->get("config_image_product_height"))
				),
				'name'        => $product['name'],
				'description' => utf8_substr(strip_tags(html_entity_decode($product['description'], ENT_QUOTES, "UTF-8")), 0, 300) . "..",
				'price'       => $Controller->currency->format($Controller->tax->calculate($product['price'], $product['tax_class_id'], $Controller->config->get("config_tax"))),
				'special'     => (!empty($product['special']) 
					? $Controller->currency->format($Controller->tax->calculate($product['special'], $product['tax_class_id'], $Controller->config->get("config_tax")))
					: false
				),
				'tax'         => ($Controller->config->get("config_tax")
					? $Controller->currency->format((float)$product['special'] ? $product['special'] : $product['price'])
					: false
				),
				'rating'      => $product['rating'],
				'reviews'     => sprintf($Controller->language->get("text_reviews"), (int)$product['reviews']),
				'href'        => $Controller->url->link("product/product", "path={$Controller->request->get['path']}&product_id={$product['product_id']}")
			];
		}
		
		return $prepared_products;
	}
}





// Categories
if (!function_exists("getSiblingCategories")) {
	function getSiblingCategories($Controller) {
		// Define category id
		$parts = explode("_", (string)$Controller->request->get['path']);
		$category_id = (isset($Controller->request->get['path']) 
			? (int)explode("_", (string)$Controller->request->get['path'])[0] 
			: 0
		);
		
		
		$sibling_categories = $Controller->model_catalog_category->getCategories($category_id);
		$prepared_categories = [];
		
		foreach ($sibling_categories as $sibling_category) {
			$prepared_categories[] = [
				'name'  => $sibling_category['name'],
				'href'  => $Controller->url->link("product/category", "path={$category_id}_{$sibling_category['category_id']}")
			];
		}
		
		return $prepared_categories;
	}
}





// Filter
if (!function_exists("applyFiltersToProduct")) {
	function applyFiltersToProduct($product, $filters=null) {
		$result = true;
		
		if (empty($filters)) {
			return $result;
		}
		
		foreach ($filters as $name=>$value) {
			switch ($name) {
				case "min_price":
					$result = (!empty($product['special'])
						? $product['special'] >= $value
						: $product['price'] >= $value
					);
					break; 
					
				case "max_price":
					$result =  (!empty($product['special'])
						? $product['special'] <= $value
						: $product['price'] <= $value
					);
					break;
					
				case "manufacturer":
					$result = (in_array($product['manufacturer_id'], $value));
					break;
					
				case "model":					
					$result = (in_array($product['model'], $value));
					break;
			}
			
			if (!$result) {
				break;
			}
		}
		
		return $result;
	}
}

if (!function_exists("applyFilters")) {
	function applyFilters($Controller, $filters) {
		$products = getAllProducts($Controller);
		
		$filtered = array_filter($products, function($product) use ($filters) { 
			return applyFiltersToProduct($product, $filters);
		});
		
		return $filtered;
	}
}

if (!function_exists("getPossibleFilters")) {
	function getPossibleFilters($Controller, $applied_filters=null) {
		// Extract filters info from products
		$products = getAllProducts($Controller);
		$manufacturers = [];
		$models = [];
		
		foreach ($products as $product) {
			$is_filtered = applyFiltersToProduct($product, $applied_filters);
			
			// Manufacturers
			if (!empty($product['manufacturer_id'])) {				
				$manufacturers[$product['manufacturer_id']] = [
					'id' => $product['manufacturer_id'],
					'title' => $product['manufacturer'],
					'is_applied' => (!empty($applied_filters) && in_array("manufacturer", array_keys($applied_filters))
						? (!empty($manufacturers[$product['manufacturer_id']]['is_applied']) 
							? $manufacturers[$product['manufacturer_id']]['is_applied']
							: $is_filtered
						)
						: 0
					),
					'quantity' => (isset($manufacturers[$product['manufacturer_id']]['quantity'])
						? $manufacturers[$product['manufacturer_id']]['quantity']+1
						: 1
					)
				];
			}	
			
			
			// Models
			preg_match("/.*([19|20]{2}[0-9]{2}).*/", $product['model'], $model_info);
			
			if (!empty($model_info[1])) {
				$models[$model_info[1]] = [
					'name' => $model_info[0],
					'year' => $model_info[1],
					'is_applied' => (!empty($applied_filters) && in_array("model", array_keys($applied_filters))
						? (!empty($models[$model_info[1]]['is_applied']) 
							? $models[$model_info[1]]['is_applied']
							: $is_filtered
						)
						: 0
					),
					'quantity' => (isset($models[$model_info[1]]['quantity'])
						? $models[$model_info[1]]['quantity']+1
						: 0
					)
				];
			}
		}



		// Sort Filters 
		uasort($manufacturers, function($some_manufacturer, $other_manufacturer) {
			return (ord($some_manufacturer['title']) >= ord($other_manufacturer['title']) ? 1 : -1);
		});

		sort($models);
		
		
		
		$price_sorted_products = sortBy("p.price", "DESC", $Controller, $products);

		return [
			'min_price' => 0,
			'max_price' => (isset($price_sorted_products[0]) ? ceil($price_sorted_products[0]['price']) : 0),
			'manufacturers' => $manufacturers,
			'models' => $models
		];
	}
}




// Sort
if (!function_exists("sortBy")) {
	function sortBy($field, $order, $Controller, $products=null) {
		// Get products
		$products = (!empty($products) ? $products : getAllProducts($Controller));
		
		
		
		// Define functions for sort
		$sort_functions = [
			'sale' => function($some_product, $other_product) use ($order) { 
				// Calculate sale percent
				$some_product['sale_percent'] = (!empty($some_product['special']) ? ceil(($some_product['price']-$some_product['special'])/$some_product['price']*100) : 0);
				$other_product['sale_percent'] = (!empty($other_product['special']) ? ceil(($other_product['price']-$other_product['special'])/$other_product['price']*100) : 0);
				
				
				if ($order == "ASC") {
					return ($some_product['sale_percent'] >= $other_product['sale_percent'] ? 1 : -1);
				} else {
					return ($some_product['sale_percent'] >= $other_product['sale_percent'] ? -1 : 1);
				}
			},
			
			'p.price' => function($some_product, $other_product) use ($order) {
				// Use special as price if specified
				$some_product['price'] = (!empty($some_product['special']) ? $some_product['special'] : $some_product['price']);
				$other_product['price'] = (!empty($other_product['special']) ? $other_product['special'] : $other_product['price']);
				 
				 
				if ($order == "ASC") {					
					return ($some_product['price'] >= $other_product['price'] ? 1 : -1);
				} else {
					return ($some_product['price'] >= $other_product['price'] ? -1 : 1);
				}
			},
			
			'rating' => function($some_product, $other_product) use ($order) { 
				if ($order == "ASC") {
					return ($some_product['rating'] >= $other_product['rating'] ? 1 : -1);
				} else {
					return ($some_product['rating'] >= $other_product['rating'] ? -1 : 1);
				}
			},
		];
				
		
		
		// Check the field
		$possible_fields = array_keys($sort_functions);
		
		if (!in_array($field, $possible_fields)) {
			return $products;
		}
		
		

		// Sort products
		usort($products, $sort_functions[$field]);
		
	
		
		return $products;
	}
}

if (!function_exists("getPossibleSorts")) {
	function getPossibleSorts($Controller, $sort, $order) {		
		$url = getUrlParts($Controller);

		return [
			[
				'text' => "Цена",
				'href' => "{$url['root']}?sort=p.price&order=" . ("{$sort}-{$order}" == "p.price-ASC" ? "DESC" : "ASC") . $url['limit'] . $url['filters'],
				'value' => "p.price-" . ("{$sort}-{$order}" == "p.price-ASC" ? "DESC" : "ASC")
			],
			
			[
				'text' => "Скидка",
				'href' => "{$url['root']}?sort=sale&order=" . ("{$sort}-{$order}" == "sale-DESC" ? "ASC" : "DESC") . $url['limit'] . $url['filters'],
				'value' => "sale-" . ("{$sort}-{$order}" == "sale-DESC" ? "ASC" : "DESC"),
			],
			
			[
				'text' => "Рейтинг",
				'href' => "{$url['root']}?sort=rating&order=" . ("{$sort}-{$order}" == "rating-DESC" ? "ASC" : "DESC") . $url['limit'] . $url['filters'],
				'value' => "rating-" . ("{$sort}-{$order}" == "rating-DESC" ? "ASC" : "DESC")
			]
		];
	}
}
