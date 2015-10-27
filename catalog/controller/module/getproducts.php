<?php
class ControllerModuleGetproducts extends Controller {
	public function index() {

			$page = 1;
			if(isset($this->request->post['page'])){
				$page = (int) $this->request->post['page'];
			}

			if (isset($this->request->post['sort'])) {
				$sort = $this->request->post['sort'];
			} else {
				$sort = 'p.sort_order';
			}

			if (isset($this->request->post['order'])) {
				$order = $this->request->post['order'];
			} else {
				$order = 'ASC';
			}

			if (isset($this->request->post['limit'])) {
				$limit = $this->request->post['limit'];
			} else {
				$limit = $this->config->get('config_catalog_limit');
			}


			$this->load->model('module/filterpro');
			$this->load->model('catalog/product');
			$this->load->model('tool/image');

            $manufacturer = false;
            if (isset($this->request->post['manufacturer'])){
                $manufacturer = $this->array_clean($this->request->post['manufacturer']);
                if(!count($manufacturer)){
                    $manufacturer = false;
                }
            }

            $option_value = false;
            if (isset($this->request->post['option_value'])){
                $option_value = $this->array_clean($this->request->post['option_value']);
                if(!count($option_value)){
                    $option_value = false;
                }
            }

            $attribute_value = false;
            if (isset($this->request->post['attribute_value'])){
                $attribute_value = $this->array_clean($this->request->post['attribute_value']);
                if(!count($attribute_value)){
                    $attribute_value = false;
                }
            }

			$data = array(
				'option_value' => $option_value,
				'manufacturer' => $manufacturer,
				'attribute_value' => $attribute_value,
				'category_id' => $this->request->post['category_id'],
				'min_price' => $this->request->post['min_price'],
				'max_price' => $this->request->post['max_price'],
				'start' => ($page - 1) * $limit,
				'limit' => $limit,
				'sort' => $sort,
				'order' => $order
			);

			$product_total = $this->model_module_filterpro->getTotalProducts($data);

			$totals_manufacturers = $this->model_module_filterpro->getTotalManufacturers($data);

			$totals_options = $this->model_module_filterpro->getTotalOptions($data);

			$products = $this->model_module_filterpro->getProducts($data);


			$result = array();

			$min_price=false;
			$max_price = false;

			if(isset($this->request->post['getPriceLimits']) && $this->request->post['getPriceLimits']) {
				$priceLimits = $this->model_module_filterpro->getPriceLimits($data);
				$min_price = $priceLimits['min_price'];
				$max_price = $priceLimits['max_price'];
			}

			foreach($products as $product) {
				if($product['image']) {
					$image = $this->model_tool_image->resize($product['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
				} else {
					$image = false;
				}

				if(($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}
				if ((float)$product['special']) {
					$special = $this->currency->format($this->tax->calculate($product['special'], $product['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$special = false;
				}

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$product['special'] ? $product['special'] : $product['price']);
				} else {
					$tax = false;
				}

				if ($this->config->get('config_review_status')) {
					$rating = (int)$product['rating'];
				} else {
					$rating = false;
				}

				$description = function_exists('utf8_substr') ? utf8_substr(strip_tags(html_entity_decode($product['description'], ENT_QUOTES, 'UTF-8')), 0, 400) . '..' :
						substr(strip_tags(html_entity_decode($product['description'], ENT_QUOTES, 'UTF-8')), 0, 400) . '..';
				$result[] = array(
					'product_id' => $product['product_id'],
					'image' => $image,
					'thumb' => $image,
					'special'     => $special,
					'tax'         => $tax,
					'rating'      => $rating,
					'name' => $product['name'],
					'description' => $description,
					'price' => $price,
					'href' => $this->url->link('product/product', 'path=' . $this->request->post['path'] . '&product_id=' . $product['product_id'])
				);
			}

			$pagination = new Pagination();
			$pagination->total = $product_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->text = $this->language->get('text_pagination');
			$pagination->url = 'page={page}';

			$min_price = $this->currency->convert($min_price, $this->config->get('config_currency'), $this->currency->getCode());
			$max_price = $this->currency->convert($max_price, $this->config->get('config_currency'), $this->currency->getCode());
			$json = json_encode(array('result' => $result, 'min_price' => $min_price, 'max_price'=> $max_price, 'pagination' => $pagination->render(),
									 'totals_data'=>array('manufacturers' => $totals_manufacturers, 'options' => $totals_options)));


		$this->response->setOutput($json);
	}

	private function array_clean(array $haystack) {
		foreach($haystack as $key => $value) {
			if(is_array($value)) {
				$haystack[$key] = $this->array_clean($value);
				if(!count($haystack[$key])) {
					unset($haystack[$key]);
				}
			} elseif(is_string($value)) {
				$value = trim($value);
				if(!$value) {
					unset($haystack[$key]);
				}
			}
		}
		return $haystack;
	}

}

?>