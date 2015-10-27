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

class ControllerShippingShoputilsEMS extends Controller {

    public function block(){
        if (!$this->config->get('shoputils_ems_status')) {
            return;
        }

        $json = array();

        $this->load->model('shipping/shoputils_ems');
        $this->load->language('shipping/shoputils_ems');

        if (isset($this->request->get['item_id']) &&
            isset($this->request->get['item_name'])
        ) {
            $this->session->data['ems_item_id'] = $this->request->get['item_id'];
            $this->session->data['ems_item_name'] = $this->request->get['item_name'];
        } else if (isset($this->request->get['item_change'])) {
            $this->model_shipping_shoputils_ems->resetSession();
        }

        if ($this->customer->isLogged()) {
            $this->load->model('account/address');
            $address = $this->model_account_address->getAddress($this->session->data['shipping_address_id']);
        } elseif (isset($this->session->data['guest'])) {
            $address = $this->session->data['guest']['shipping'];
        }

        if (!isset($this->session->data['ems_item_id'])) {
            if ($address['country_id'] == $this->config->get('shoputils_ems_country')) {
                if (isset($this->session->data['ems_item_name'])) {
                    $region = $this->session->data['ems_item_name'];
                } else {
                    $region = $address['city'];
                }
                $this->load->library('ems');
                
                $ems = new EMS($this->registry);
                $cities = $ems->lookupLocations($region, 'cities,regions');
                if (!$cities){
                    $region = $address['zone'];
                }
                $cities = $ems->lookupLocations($region, 'cities,regions');

                $need_select_region = true;
                if (count($cities) == 1 && !isset($this->request->get['item_change'])) {
                    $keys = array_keys($cities);
                    $values = array_values($cities);
                    $this->session->data['ems_item_name'] = $values[0];
                    $this->session->data['ems_item_id'] = $keys[0];
                    $need_select_region = false;
                } else if (isset($this->session->data['ems_item_id']) && $this->session->data['ems_item_id']) {
                    $need_select_region = false;
                    if (mb_strpos($address['city'], $this->session->data['ems_item_name'], null, 'utf-8') === false) {
                        $address['city'] = $address['city'] . ' - ' . $this->session->data['ems_item_name'];
                    }
                }

                if ($need_select_region) {
                    $template = new Template();
                    $template->data['entry_select'] = $this->language->get('entry_city');
                    $template->data['text_warning'] = $this->language->get('text_warning_city');
                    $template->data['text_request_error'] = $this->language->get('text_request_error');

                    $template->data['action_url'] = $this->url->link('shipping/shoputils_ems/block');

                    $template->data['items'] = $ems->getCities();

                    if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/shipping/shoputils_ems_select.tpl')) {
                        $json['output'] = $template->fetch($this->config->get('config_template') . '/template/shipping/shoputils_ems_select.tpl');
                    } else {
                        $json['output'] = $template->fetch('default/template/shipping/shoputils_ems_select.tpl');
                    }
                }
            } else {
                if (isset($this->session->data['ems_item_name'])) {
                    $country_name = $this->session->data['ems_item_name'];
                } else {
                    $country_name = $address['country'];
                }

                $this->load->library('ems');
                $ems = new EMS($this->registry);
                $countries = $ems->lookupLocations($country_name, 'countries');

                $need_select_country = true;
                if (count($countries) == 1 && !isset($this->request->get['item_change'])) {
                    $keys = array_keys($countries);
                    $values = array_values($countries);
                    $this->session->data['ems_item_name'] = $values[0];
                    $this->session->data['ems_item_id'] = $keys[0];
                    $need_select_country = false;
                } else if (isset($this->session->data['ems_item_id']) && $this->session->data['ems_item_id']) {
                    $need_select_country = false;
                    if (mb_strpos($address['city'], $this->session->data['ems_item_name'], null, 'utf-8') === false) {
                        $address['city'] = $address['city'] . ' - ' . $this->session->data['ems_item_name'];
                    }
                }

                if ($need_select_country) {
                    $template = new Template();
                    $template->data['entry_select'] = $this->language->get('entry_country');
                    $template->data['text_warning'] = $this->language->get('text_warning_country');
                    $template->data['text_request_error'] = $this->language->get('text_request_error');

                    $template->data['action_url'] = $this->url->link('shipping/shoputils_ems/block');

                    $template->data['items'] = $ems->getCountries();

                    if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/shipping/shoputils_ems_select.tpl')) {
                        $json['output'] = $template->fetch($this->config->get('config_template') . '/template/shipping/shoputils_ems_select.tpl');
                    } else {
                        $json['output'] = $template->fetch('default/template/shipping/shoputils_ems_select.tpl');
                    }
                }
            }

        }
        
        if (isset($this->session->data['ems_item_id'])) {
            $template = new Template();
            $template->data['action_url'] = $this->url->link('shipping/shoputils_ems/block');
            $template->data['text_change_city'] = $this->language->get('text_change_city');
            $template->data['quotes'] = $this->model_shipping_shoputils_ems->getQuotes($address);
            if (isset($this->session->data['shipping_method']['code'])) {
                $template->data['code'] = $this->session->data['shipping_method']['code'];
            } else {
                $template->data['code'] = '';
            }

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/shipping/shoputils_ems_quote.tpl')) {
                $json['output'] = $template->fetch($this->config->get('config_template') . '/template/shipping/shoputils_ems_quote.tpl');
            } else {
                $json['output'] = $template->fetch('default/template/shipping/shoputils_ems_quote.tpl');
            }

            $this->session->data['shipping_methods']['shoputils_ems']['quote'] = $template->data['quotes'];
        }

		$this->response->setOutput(json_encode($json));
    }
}
