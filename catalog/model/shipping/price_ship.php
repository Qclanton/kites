<?php
	class ModelShippingPriceShip extends Model {
		private $cost;
		private $price;
			function getQuote($address) {
				$this->load->language('shipping/price_ship');
				
			$quote_data = array();
				if ($this->config->get('price_ship_status')) {
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int)$this->config->get('price_ship_geo_zone_id') . "' AND country_id = '" . (int)$address['country_id'] . "' AND (zone_id = '" . (int)$address['zone_id'] . "' OR zone_id = '0')");
					if (!$this->config->get('price_ship_geo_zone_id')) {
						$status = TRUE;
						} elseif ($query->num_rows) {
							$status = TRUE;
						} else {
									$status = FALSE;
								}
						} else {
									$status = FALSE;
								}
$method_data = array();
					if ($status) {
						$this->cost = 0;
						$this->price = $this->cart->getSubTotal();
						$rates = explode(',', $this->config->get('price_ship_rate'));
						foreach ($rates as $rate) {
							$data = explode(':', $rate);
								if ($this->price >= $data[0]) {
									$this->cost = $data[1];
								} else {
									break;
										}
												}	
					
      		$quote_data['price_ship'] = array(
        		'id'           => 'price_ship.price_ship',
        		'title'        => $this->language->get('text_courier'),
        		'cost'         => $this->cost,
        		'tax_class_id' => 0,
				'text'         => $this->currency->format($this->tax->calculate($this->cost, 0, $this->config->get('config_tax')))
      		);

      		$method_data = array(
        		'id'         => 'price_ship',
        		'title'      => $this->language->get('text_courier'),
        		'quote'      => $quote_data,
				'sort_order' => $this->config->get('price_ship_order'),
        		'error'      => FALSE
      		);
		}
		return $method_data;
     }
}
?>