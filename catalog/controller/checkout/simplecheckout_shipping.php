<?php 
/*
@author	Dmitriy Kubarev
@link	http://www.simpleopencart.com
@link	http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4811
*/  

class ControllerCheckoutSimpleCheckoutShipping extends Controller {
    public function index() {

        if (!$this->cart->hasShipping()) {
            return;
        }
        
        $this->language->load('checkout/simplecheckout');

        $this->data['address_empty'] = false;
        
        $address = $this->simple->shipping_address;
        $address_fields = $this->simple->shipping_address_fields;
        
        if ($address['country_id'] == '' && !empty($address_fields['main_country_id']) && $address_fields['main_country_id']['type'] != 'hidden') {
            $this->data['address_empty'] = true;
        }
        
        if ($address['zone_id'] === '' && !empty($address_fields['main_zone_id']) && $address_fields['main_zone_id']['type'] != 'hidden') {
            $this->data['address_empty'] = true;
        }
        
        if ($address['city'] == '' && !empty($address_fields['main_city']) && $address_fields['main_city']['type'] != 'hidden') {
            $this->data['address_empty'] = true;
        }
        
        if ($address['postcode'] == '' && !empty($address_fields['main_postcode']) && $address_fields['main_postcode']['type'] != 'hidden') {
            $this->data['address_empty'] = true;
        }
        
        $this->data['simple_debug'] = $this->config->get('simple_debug');
        $this->data['address'] = $address;
        
        $this->data['simple_shipping_view_title'] = $this->config->get('simple_shipping_view_title');
        $this->data['simple_shipping_view_address_empty'] = $this->config->get('simple_shipping_view_address_empty');
        $simple_shipping_view_address_full = $this->config->get('simple_shipping_view_address_full');
        $simple_shipping_view_autoselect_first = $this->config->get('simple_shipping_methods_hide') ? true : $this->config->get('simple_shipping_view_autoselect_first');
        
        $this->data['shipping_methods'] = array();
    
        $quote_data = array();
        
        $this->load->model('setting/extension');
        
        $results = $this->model_setting_extension->getExtensions('shipping');
        
        foreach ($results as $result) {
            $show_module = true;
            if (!$this->data['address_empty']) {
                $show_module = true;
            } elseif ($this->data['address_empty'] && !empty($simple_shipping_view_address_full[$result['code']])) {
                $show_module = false;
            } 
            
            if ($this->config->get($result['code'] . '_status') && $show_module) {
                $this->load->model('shipping/' . $result['code']);
                
                $quote = $this->{'model_shipping_' . $result['code']}->getQuote($address); 
    
                if ($quote) {

                    $quote_data[$result['code']] = array( 
                        'title'      => $quote['title'],
                        'quote'      => $quote['quote'], 
                        'sort_order' => $quote['sort_order'],
                        'error'      => $quote['error'],
                        'warning'    => (isset($quote['warning']) ? $quote['warning'] : '')
                    );

                    
                }
            }
        }

        $sort_order = array();
      
        foreach ($quote_data as $key => $value) {
            $sort_order[$key] = $value['sort_order'];
        }

        array_multisort($sort_order, SORT_ASC, $quote_data);
        
        $this->data['shipping_methods'] = $quote_data;
        $this->data['shipping_method'] = null;
        $this->data['error_warning'] = '';
        
        if ($this->request->server['REQUEST_METHOD'] == 'POST' && isset($this->request->post['shipping_method'])) {
            $shipping = explode('.', $this->request->post['shipping_method']);
            
            if (isset($this->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]])) {
                $this->data['shipping_method'] = $this->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]];
               
                if (!isset($this->session->data['shipping_method_selected']) || (isset($this->session->data['shipping_method_selected']) && $this->session->data['shipping_method_selected'] != $this->request->post['shipping_method'])) {
                    $this->session->data['shipping_method_user_select'] = true;
                }
            }
        } else {
            $this->session->data['shipping_method_user_select'] = false;
        }
        
        if ($this->request->server['REQUEST_METHOD'] == 'GET' && isset($this->request->cookie['shipping_method'])) {
            $shipping = explode('.', $this->request->cookie['shipping_method']);
            
            if (isset($this->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]])) {
                $this->data['shipping_method'] = $this->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]];
                $this->session->data['shipping_method_user_select'] = true;
            }
        }
        
        if (!empty($this->data['shipping_methods'])) {
            $first = reset($this->data['shipping_methods']);
            if (!empty($first['quote'])) {
                $first_method = reset($first['quote']);
            }
        }
        
        if ($simple_shipping_view_autoselect_first && !empty($first_method) && empty($this->session->data['shipping_method_user_select'])) {
            $this->session->data['shipping_method_user_select'] = false;
            $this->data['shipping_method'] = $first_method;
        }
        
        if (isset($this->data['shipping_method'])) {
            $this->session->data['shipping_method_selected'] = $this->data['shipping_method']['code'];
            setcookie('shipping_method', $this->data['shipping_method']['code'], time() + 60 * 60 * 24 * 30);
        }
        
        $this->data['code'] = !empty($this->data['shipping_method']) ? $this->data['shipping_method']['code'] : '';                
        
        $this->simple->shipping_methods = $this->data['shipping_methods'];
        $this->simple->shipping_method = $this->data['shipping_method'];
        
        $this->data['simple_create_order'] = !empty($this->request->post['simple_create_order']);
        
        $this->validate();
        
        $this->save_to_session();

             




        
        $this->data['text_checkout_shipping_method'] = $this->language->get('text_checkout_shipping_method');
        $this->data['text_shipping_address'] = $this->language->get('text_shipping_address');
        $this->data['error_no_shipping'] = sprintf($this->language->get('error_no_shipping'), $this->url->link('information/contact'));
                        
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/simplecheckout_shipping.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/checkout/simplecheckout_shipping.tpl';
        } else {
            $this->template = 'default/template/checkout/simplecheckout_shipping.tpl';
        }

        $this->response->setOutput($this->render());        
    }
    
    private function save_to_session() {
        $this->session->data['shipping_methods'] = $this->simple->shipping_methods;
        $this->session->data['shipping_method'] = $this->simple->shipping_method;
        
        if (empty($this->session->data['shipping_methods'])) {
            unset($this->session->data['shipping_method']);
        }
    }
    
    private function validate() {
        $error = false;
        
        if (empty($this->data['shipping_method'])) {
            $this->data['error_warning'] = $this->language->get('error_shipping');
            $error = true;
        } 
        
        if ($error) {
            $this->simple->error = 'shipping';
        }
        
    	return !$error;
    }
}
?>