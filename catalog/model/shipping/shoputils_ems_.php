<?php
/*
 * Shoputils
 *
 * ПРИМЕЧАНИЕ К ЛИЦЕНЗИОННОМУ СОГЛАШЕНИЮ
 *
 * Этот файл связан лицензионным соглашением, которое можно найти в архиве,
 * вместе с этим файлом. Файл лицензии называется: LICENSE.1.5.x.RUS.txt
 * Так же лицензионное соглашение можно найти по адресу:
 * http://opencart.shoputils.ru/LICENSE.1.5.x.RUS.txt
 * 
 * =================================================================
 * OPENCART 1.5.x ПРИМЕЧАНИЕ ПО ИСПОЛЬЗОВАНИЮ
 * =================================================================
 *  Этот файл предназначен для Opencart 1.5.x. Shoputils не
 *  гарантирует правильную работу этого расширения на любой другой 
 *  версии Opencart, кроме Opencart 1.5.x. 
 *  Shoputils не поддерживает программное обеспечение для других 
 *  версий Opencart.
 * =================================================================
*/

class ModelShippingShoputilsEMS extends Model {
    const EMS_CURRENCY_CODE = 'RUB';
    const EMS_WEIGHT_UNIT_1 = 'kg';
    const EMS_WEIGHT_UNIT_2 = 'кг';
    const EMS_MAX_WEIGHT = 31.5;

    public function __construct($registry) {
        parent::__construct($registry);
        $this->load->language('shipping/shoputils_ems');
    }

	function getQuote(&$address) {
        if (!$this->config->get('shoputils_ems_status')) {
            return;
        }

        $geo_zones = $this->config->get('shoputils_ems_geo_zones');

        $found = false;
        foreach ($geo_zones as $geo_zone){
            if ($geo_zone == -1){
                $found = true;
                break;
            }
            $query = $this->db->query("SELECT count(*) as total_records FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int)$geo_zone . "' AND country_id = '" . (int)$address['country_id'] . "' AND (zone_id = '" . (int)$address['zone_id'] . "' OR zone_id = '0')");
            if ($query->row['total_records']){
                $found = true;
                break;
            }
        }
        if (!$found){
            return;
        }

        $langdata = $this->getDescriptions((int)$this->config->get('config_language_id'));
        $title = empty($langdata['name']) ? $this->language->get('text_title') : $langdata['name'];
        $description = empty($langdata['description']) ? $this->language->get('text_description') : $langdata['description'];

        $method_data = array(
          'id'          => 'shoputils_ems',
          'title'       => $title,
          'description' => $description,
          'sort_order'  => $this->config->get('shoputils_ems_sort_order'),
          'error' => '',
          'quote' => array(),
        );

        if (!$this->currency->has(self::EMS_CURRENCY_CODE)){
            $method_data['error'] = sprintf($this->language->get('error_currency'), self::EMS_CURRENCY_CODE);
            return $method_data;
        }

        $weight = number_format($this->getWeight(), 2, '.', '');
        if ($weight > self::EMS_MAX_WEIGHT){
            $method_data['error'] = sprintf($this->language->get('error_max_weight'), self::EMS_MAX_WEIGHT, self::EMS_WEIGHT_UNIT_2);
            return $method_data;
        }

        $no_weight = $this->getNoWeight();
        if ($no_weight){
            $method_data['error'] = sprintf($this->language->get('error_no_weight'), $no_weight);
            return $method_data;
        }

        $method_data['title'] .= $this->getLoadingBlock();
        $method_data['block'] = $this->getMethodBlock();
        return $method_data;
	}


    public function getLoadingBlock(){
        $template = new Template();
        $template->data['text_loading'] = $this->language->get('text_loading');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/shipping/shoputils_ems_loading.tpl')) {
            return $template->fetch($this->config->get('config_template') . '/template/shipping/shoputils_ems_loading.tpl');
        } else {
            return $template->fetch('default/template/shipping/shoputils_ems_loading.tpl');
        }
    }

    public function getMethodBlock(){
        $template = new Template();
        $template->data['text_loading'] = $this->language->get('text_loading');
        $template->data['action_url'] = $this->url->link('shipping/shoputils_ems/block');
        $template->data['quotes'] = array();
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/shipping/shoputils_ems_block.tpl')) {
            return $template->fetch($this->config->get('config_template') . '/template/shipping/shoputils_ems_block.tpl');
        } else {
            return $template->fetch('default/template/shipping/shoputils_ems_block.tpl');
        }
    }

    private function getWeight() {
        $weight_class_query = $this->db->query("
            SELECT
                wc.weight_class_id
            FROM
                " . DB_PREFIX . "weight_class wc
            LEFT JOIN
                " . DB_PREFIX . "weight_class_description wcd
                ON (wc.weight_class_id = wcd.weight_class_id)
            WHERE
                wcd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND
                (LOWER(unit) = '" . self::EMS_WEIGHT_UNIT_1 . "' OR LOWER(unit) = '" . self::EMS_WEIGHT_UNIT_2 . "')
            LIMIT 1"
        );
        
        if ($weight_class_query->rows) {
            $weight_class_id = $weight_class_query->row['weight_class_id'];
        } else {
            $weight_class_id = 0;
        }
        $weight = $this->weight->convert($this->cart->getWeight(), $this->config->get('config_weight_class_id'), $weight_class_id);
        return $weight;
    }

    private function getAdvancedWeight(){
        return (int)$this->config->get('shoputils_ems_advanced_weight') / 1000;
    }

    public function getDescriptions($language_id){
        $descriptions = $this->config->get('shoputils_ems_descriptions');
        if (isset($descriptions[$language_id])){
            $descriptions[$language_id]['description'] = html_entity_decode($descriptions[$language_id]['description'], ENT_QUOTES, 'utf-8');
            return $descriptions[$language_id];
        } else {
            return false;
        }
    }

    private function getRateDescription($rate, $address){
        $result = '';
        if ($address['country_id'] == $this->config->get('shoputils_ems_country')){
            $result .= $this->config->get('shoputils_ems_city_name') . ' - ';
        }
        $result .= $this->session->data['ems_item_name'].'<br>';

        if ($this->config->get('shoputils_ems_show_advanced')) {
            $result .= sprintf($this->language->get('text_weight'), number_format($this->getWeight(), 2, ',', ''));
            if ($this->config->get('shoputils_ems_advanced_weight')) {
                $result .= sprintf($this->language->get('text_weight_ext'), number_format($this->getAdvancedWeight(), 2, ',', ''));
            }
            $result .= '<br>';

            if ($rate['days_from'] == $rate['days_to']) {
                $days = $rate['days_from'];
            } else {
                $days = $rate['days_from'] . '-' . $rate['days_to'];
            }
            if ($this->config->get('shoputils_ems_advanced_days')) {
                $text_advanced_days = sprintf($this->language->get('text_days_ext'), $this->config->get('shoputils_ems_advanced_days'));
            } else {
                $text_advanced_days = '';
            }

            if ($days != 0){
                $result .= sprintf($this->language->get('text_days'), $days).$text_advanced_days.'<br>';
            }
            
            $total = $this->currency->convert($rate['total'], self::EMS_CURRENCY_CODE, $this->currency->getCode());
            $result .= sprintf($this->language->get('text_total'), $this->currency->format($total));

            if ($rate['total_ext']){
                $total_ext = $this->currency->convert($rate['total_ext'], self::EMS_CURRENCY_CODE, $this->currency->getCode());
                $result .= sprintf($this->language->get('text_total_ext'), $this->currency->format($total_ext)).'<br>';
            }
            $result .= '<br>';
        } else {
            $result .= sprintf($this->language->get('text_weight'), number_format($this->getWeight() + $this->getAdvancedWeight(), 2, ',', '')).'<br>';

            if ($rate['days_from']) {
                if ($rate['days_from'] == $rate['days_to']) {
                    $days = $rate['days_from'] + (int)$this->config->get('shoputils_ems_advanced_days');
                } else {
                    $days = ($rate['days_from'] + (int)$this->config->get('shoputils_ems_advanced_days')) . '-' .
                            ($rate['days_to'] + (int)$this->config->get('shoputils_ems_advanced_days'));
                }

                if ($days != 0) {
                    $result .= sprintf($this->language->get('text_days'), $days) . '<br>';
                }
            }
        }

        return $result;
    }

    public function updateOrderData(&$data){
        if (isset($this->session->data['shipping_method']['code']) && strpos($this->session->data['shipping_method']['code'], 'shoputils_ems') !== false){
            if ($data['comment']){
                $data['comment'] .= '<br/><br/>';
            }
            $data['comment'] .= $this->language->get('text_ems_rate_title').':<br>'.$this->session->data['shipping_method']['description'];
        }
    }


    public function getQuotes($address){
        $quotes = array();

        $total = $this->cart->getSubTotal();

        $title = empty($langdata['name']) ? $this->language->get('text_title') : $langdata['name'];

        $free_shipping = (float)$this->config->get('shoputils_ems_free_shipping');
        if (!empty($free_shipping) && ($total > $free_shipping)) {
            $total = $total > $free_shipping ? 0 : $total;
            $text = $this->language->get('text_free_shipping');

            $quotes['shoputils_ems'] = array(
                'code' => 'shoputils_ems.shoputils_ems_free',
                'title' => $title,
                'cost' => $total,
                'tax_class_id' => 0,
                'text' => $text
            );
        } else {
            $rates = array();

            if (isset($this->session->data['ems_item_id'])){

                $amount = number_format($this->currency->format($total, '', $this->currency->getValue(self::EMS_CURRENCY_CODE), FALSE), 0, '', '');
                $weight = number_format($this->getWeight() + $this->getAdvancedWeight(), 2, '.', '');

                $this->load->library('ems');
                $ems = new Ems($this->registry);
                $rates = $ems->getShippingRates(
                    array(
                        'from_city_id' => $this->config->get('shoputils_ems_city_id'),
                        'to_item_id' => $this->session->data['ems_item_id'],

                        'weight' => $weight,
                        'amount' => $amount,

                        'shipping_rate' => (int)$this->config->get('shoputils_ems_shipping_rate'),
                        'international' => $address['country_id'] != $this->config->get('shoputils_ems_country'),
                        'advanced_price' => (float)$this->config->get('shoputils_ems_advanced_price'),
                    )
                );
            }

            foreach ($rates as $rate){
                $cost = $this->currency->convert($rate['total_total'], self::EMS_CURRENCY_CODE, $this->currency->getCode());
                $quotes['shoputils_ems'] = array(
                    'code' => 'shoputils_ems.shoputils_ems',
                    'title' =>  $this->language->get('text_ems_rate_title'),
                    'description' => $this->getRateDescription($rate, $address),
                    'cost' => $cost,
                    'tax_class_id' => 0,
                    'text' => $this->currency->format($cost),
                );
            }
        }

        return $quotes;
    }

    public function resetSession(){
        unset($this->session->data['ems_item_name']);
        unset($this->session->data['ems_item_id']);
    }

    private function getNoWeight() {
        $products = $this->cart->getProducts();
        $result = array();
        foreach ($products as $product){
            if ($product['shipping'] && !$product['weight']){
                $result[] = sprintf('<a href="%s" >%s</a>',
                                    $this->url->link('product/product', '&product_id=' . $product['product_id']),
                                    $product['name']
                                    );
            }
        }

        if ($result){
            return '<ul><li>'. implode('</li><li>', $result).'</li></ul>';
        } else {
            return false;
        }
    }

}
?>