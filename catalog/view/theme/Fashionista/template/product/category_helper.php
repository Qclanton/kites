<?php
class HelperProductCategory {
	protected $Controller;
	
	public $root_category_id;
	public $category_id;
	
	
	
	
	
	public function __construct($Controller) {
		$this->Controller = $Controller;
		$this->setRootCategoryId();
		$this->setCategoryId();
	}
	
	
	
	
	
	// URL
	public function getUrlParts() {
		return [
			'root' => explode("?", $_SERVER['REQUEST_URI'])[0],
			'sort' => (!empty($this->Controller->request->get['sort']) ? "&sort={$this->Controller->request->get['sort']}" : ""),
			'order' => (!empty($this->Controller->request->get['sort']) ? "&order={$this->Controller->request->get['order']}" : ""),
			'limit' => (!empty($this->Controller->request->get['limit']) ? "&limit={$this->Controller->request->get['limit']}" : ""),
			'filters' => (!empty($this->Controller->request->get['filters']) ? "&" . http_build_query(['filters'=>$this->Controller->request->get['filters']]) : "")
		];
	}
	
	
	
	
	
	// Products
	public function getAllProducts($options="all") {
		$products = $this->Controller->model_catalog_product->getProducts(['filter_category_id'=>$this->category_id]);
		
		if (!empty($options)) {
			$products = $this->attachOptionsToProducts($products, $options);
		}
		
		return $products;	
	}
	
	protected function attachOptionsToProducts(array $products, $options=[]) {
		// Check
		if (empty($products)) {
			return $products;
		}
		
		
		
		// Prepare products
		foreach ($products as $product) {
			$products_ids[] = $product['product_id'];
		}
		
		$products_ids = "'" . implode("', '", $products_ids) . "'";
		
		
		
		// Prepare options
		$options_query_part = (is_string($options) && $options == "all"
			? ""
			: "AND oc_option_description.`name` IN ('" . implode("', '", $options) .  "')"
		);
		
		
		
		
		// Fetch product options
		$products_options = $this->Controller->db->query("
			SELECT 
				oc_product.`product_id` AS 'product_id',	
				oc_product_option.`product_option_id` AS 'option_id',
				oc_product_option_value.`option_value_id` AS 'option_group_value_id',
				oc_option_description.`name` AS 'option_name',							
				oc_product_option_value.`product_option_value_id` AS 'option_value_id',
				oc_option_value_description.`name` AS 'option_value_name',
				oc_option_value.`image` AS 'option_value_image',	
				oc_product_option_value.`price` AS 'option_value_price'
			FROM 
				`oc_product`
				JOIN `oc_product_option` ON (oc_product_option.`product_id`=oc_product.`product_id`)
				JOIN `oc_option_description` ON (oc_option_description.`option_id`=oc_product_option.`option_id`)
				JOIN `oc_product_option_value` ON (oc_product_option_value.`product_option_id`=oc_product_option.`product_option_id`)
				JOIN `oc_option_value` ON (oc_option_value.`option_value_id`=oc_product_option_value.`option_value_id`)
				JOIN `oc_option_value_description` ON (oc_option_value_description.`option_value_id`=oc_product_option_value.`option_value_id`)
			WHERE 1
				AND oc_product_option_value.`quantity` > 0
				AND oc_product.`product_id` IN ({$products_ids})
				{$options_query_part}
			ORDER BY oc_option_value.`sort_order`
		")->rows;
		
		if (empty($products_options)) {
			return $products;
		}
		
		
		
		// Attach options
		foreach ($products_options as $product_option) {
			$products[$product_option['product_id']]['options'][$product_option['option_name']][$product_option['option_value_id']] = [
				'option_id' => $product_option['option_id'],
				'option_name' => $product_option['option_name'],
				'option_group_value_id' => $product_option['option_group_value_id'],
				'option_value_id' => $product_option['option_value_id'],
				'option_value_name' => $product_option['option_value_name'],
				'option_value_image' => $product_option['option_value_image'],
				'option_value_price' => $product_option['option_value_price']
			];
		}
		
		
		
		return $products;
	}
	
	public function prepareProducts($products) {
		$prepared_products = [];
		
		foreach ($products as $product) {
			$prepared_products[] = [
				'product_id' => $product['product_id'],
				'options' => (isset($product['options']) ? $product['options'] : []),
				'thumb' => ($product['image']
					? $this->Controller->model_tool_image->resize($product['image'], $this->Controller->config->get("config_image_product_width"), $this->Controller->config->get("config_image_product_height"))
					: $this->Controller->model_tool_image->resize("no_image.jpg", $this->Controller->config->get("config_image_product_width"), $this->Controller->config->get("config_image_product_height"))
				),
				'name' => $product['name'],
				'description' => utf8_substr(strip_tags(html_entity_decode($product['description'], ENT_QUOTES, "UTF-8")), 0, 300) . "..",
				'price' => $this->Controller->currency->format($this->Controller->tax->calculate($product['price'], $product['tax_class_id'], $this->Controller->config->get("config_tax"))),
				'special' => (!empty($product['special']) 
					? $this->Controller->currency->format($this->Controller->tax->calculate($product['special'], $product['tax_class_id'], $this->Controller->config->get("config_tax")))
					: false
				),
				'tax' => ($this->Controller->config->get("config_tax")
					? $this->Controller->currency->format((float)$product['special'] ? $product['special'] : $product['price'])
					: false
				),
				'rating' => $product['rating'],
				'reviews' => sprintf($this->Controller->language->get("text_reviews"), (int)$product['reviews']),
				'href' => $this->Controller->url->link("product/product", "path={$this->Controller->request->get['path']}&product_id={$product['product_id']}")
			];
		}
		
		return $prepared_products;
	}
	
	
	
	
	
	// Categories
	private function defineCategoriesIds() {
		$root_category_id = 0;	
		$category_id = 0;		
		
		if (isset($this->Controller->request->get['path'])) {
			$parts = explode("_", (string)$this->Controller->request->get['path']);
			$root_category_id = $parts[0];
			$category_id = array_pop($parts);
		}	
		
		return [
			'root_category_id' => $root_category_id,
			'category_id' => $category_id
		];
	}
	
	protected function defineRootCategoryId() {
		return $this->defineCategoriesIds()['root_category_id'];
	}
	
	protected function defineCategoryId() {
		return $this->defineCategoriesIds()['category_id'];
	}
	
	public function setCategoryId($category_id=null) {
		if (empty($category_id)) {
			$category_id = $this->defineCategoryId();
		}
		
		$this->category_id = $category_id;
	}
	
	public function setRootCategoryId($root_category_id=null) {
		if (empty($root_category_id)) {
			$root_category_id = $this->defineRootCategoryId();
		}
		
		$this->root_category_id = $root_category_id;
	}
	
	public function prepareCategories($categories) {
		$prepared_categories = [];
		
		foreach ($categories as $category) {
			$prepared_categories[] = [
				'category_id' => $category['id'],
				'name'  => $category['name'],
				'href'  => $this->Controller->url->link("product/category", "path={$this->root_category_id}_{$category['id']}"),
				'products_quantity' => $category['products_quantity']
			];
		}
		
		return $prepared_categories;
	}
	
	public function getCategories($parent_id=0, $prepare=true) {
		// Prepare params
		$parent_id = (int)$parent_id;
		$language_id = (int)$this->Controller->config->get('config_language_id');
		$store_id = (int)$this->Controller->config->get('config_store_id');
		

		
		// Get categories 
		$categories = $this->Controller->db->query("
			SELECT 
				oc_category.`category_id` AS 'id',
				oc_category_description.`name` AS 'name',
					(
						SELECT 
							COUNT(oc_product_to_category.`product_id`)
						FROM 
							`oc_product_to_category`
						WHERE 1
							AND oc_product_to_category.`category_id`=oc_category.`category_id`
					) AS 
				'products_quantity'	
			FROM 
				`oc_category`
				JOIN `oc_category_description` ON (oc_category_description.category_id = oc_category.category_id)
				JOIN `oc_category_to_store` ON (oc_category_to_store.`category_id`=oc_category.`category_id`)
			WHERE 1
				AND oc_category.`parent_id`='{$parent_id}'
				AND oc_category_description.`language_id`='{$language_id}'
				AND oc_category_to_store.`store_id`='{$store_id}'
				AND oc_category.`status`='1'
			ORDER BY oc_category.`sort_order`, LCASE(oc_category_description.`name`)
		")->rows;
		
		return ($prepare ? $this->prepareCategories($categories) : $categories);
	}
	
	public function getSiblingCategories() {
		$sibling_categories = $this->getCategories($this->root_category_id);
		
		return $this->prepareCategories($sibling_categories);
	}
	
	
	
	
	
	// Filter
	public function applyFiltersToProduct($product, $filters=null) {
		$result = true;

		if (empty($filters)) {
			return $result;
		}
		
		foreach ($filters as $name=>$value) {
			switch ($name) {
				case "size":
					$result = false;
					
					if (!empty($product['options']['Размер'])) {
						foreach ($product['options']['Размер'] as $size) {
							if ($size['option_group_value_id'] == $value) {
								$result = true;
								break;
							}
						}
					}

					break;
					
				case "min_price":
					$result = (!empty($product['special'])
						? $product['special'] >= $value
						: $product['price'] >= $value
					);
					break; 
					
				case "max_price":
					$result = (!empty($product['special'])
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

	public function applyFilters($filters) {
		$products = $this->getAllProducts();
		
		$filtered = array_filter($products, function($product) use ($filters) { 
			return $this->applyFiltersToProduct($product, $filters);
		});
		
		return $filtered;
	}

	public function getPossibleFilters($applied_filters=null) {
		// Extract filters info from products
		$products = $this->getAllProducts();
		$sizes = [];
		$manufacturers = [];
		$models = [];
		
		foreach ($products as $product) {
			$is_filtered = $this->applyFiltersToProduct($product, $applied_filters);
			
			
			
			// Sizes
			if (!empty($product['options']['Размер'])) {
				$sizes['value'] = null;
				
				foreach ($product['options']['Размер'] as $product_size) {
					$is_applied = (!empty($applied_filters) && in_array("size", array_keys($applied_filters))
						? (!empty($sizes['possible_values'][$product_size['option_group_value_id']]['is_applied']) 
							? $sizes['possible_values'][$product_size['option_group_value_id']]['is_applied']
							: $product_size['option_group_value_id'] == $applied_filters['size']
						)
						: false
					);
					
					if ($is_applied) {
						$sizes['value'] = $product_size['option_group_value_id'];
					}
							
					$sizes['possible_values'][$product_size['option_group_value_id']] = [
						'id' => $product_size['option_group_value_id'],
						'title' => $product_size['option_value_name'],
						'is_applied' => $is_applied,
						'quantity' => (isset($sizes['possible_values'][$product_size['option_group_value_id']]['quantity'])
							? ($is_filtered 
								? $sizes['possible_values'][$product_size['option_group_value_id']]['quantity']+1
								: $sizes['possible_values'][$product_size['option_group_value_id']]['quantity']
							)
							: 1
						)
					];
				}
			}	
			
			
			
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
					'quantity' => ($is_filtered 					
						? (isset($manufacturers[$product['manufacturer_id']]['quantity'])
							? $manufacturers[$product['manufacturer_id']]['quantity']+1
							: 1
						)
						: (isset($manufacturers[$product['manufacturer_id']]['quantity'])
							? $manufacturers[$product['manufacturer_id']]['quantity']
							: 0
						)
					)
				];
			}	
			
			
			
			// Models
			preg_match("/.*([19|20]{2}[0-9]{2}-[19|20]{2}[0-9]{2}|^[19|20]{2}[0-9]{2}).*/", $product['model'], $model_info);
			
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
					'quantity' => ($is_filtered 					
						? (isset($models[$model_info[1]]['quantity'])
							? $models[$model_info[1]]['quantity']+1
							: 1
						)
						: (isset($models[$model_info[1]]['quantity'])
							? $models[$model_info[1]]['quantity']
							: 0
						)
					)
				];
			}
		}


			
		// Set prices
		$sort_filters = $applied_filters;
		unset($sort_filters['min_price']);
		unset($sort_filters['max_price']);		
		$filtered_products = $this->applyFilters($sort_filters);
		$price_sorted_products = $this->sortBy("p.price", "DESC", $filtered_products);
		
		end($price_sorted_products);
		$min_product_price = (!empty(current($price_sorted_products)['special'])
			? current($price_sorted_products)['special']
			: (isset(current($price_sorted_products)['price'])
				? current($price_sorted_products)['price']
				: 0
			)	
		);
		
		reset($price_sorted_products);
		$max_product_price = (!empty(current($price_sorted_products)['special'])
			? current($price_sorted_products)['special']
			: (isset(current($price_sorted_products)['price'])
				? current($price_sorted_products)['price']
				: 0
			)	
		);




		// Sort Filters 
		uasort($manufacturers, function($some_manufacturer, $other_manufacturer) {
			return (ord($some_manufacturer['title']) >= ord($other_manufacturer['title']) ? 1 : -1);
		});

		sort($models);
		
		
		

		// Return
		return [
			'sizes' => $sizes,
			'min_price' => ceil($min_product_price),
			'max_price' => ceil($max_product_price),
			'manufacturers' => $manufacturers,
			'models' => $models
		];
	}
	
	
	
	
	
	// Sort
	public function sortBy($field, $order, $products=null) {
		// Get products
		$products = (!empty($products) ? $products : $this->getAllProducts());
		
		
		
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

	public function getPossibleSorts($sort, $order) {		
		$url = $this->getUrlParts();

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
