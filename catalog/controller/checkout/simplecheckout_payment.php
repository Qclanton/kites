<?php  
/*
@author	Dmitriy Kubarev
@link	http://www.simpleopencart.com
@link	http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4811
*/  

class ControllerCheckoutSimpleCheckoutPayment extends Controller {
    public function index() {
      
        $this->language->load('checkout/simplecheckout');

        $this->data['address_empty'] = false;
        
        $address = $this->simple->payment_address;
        $address_fields = $this->simple->payment_address_fields;
        
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
        
        $this->data['simple_payment_view_address_empty'] = $this->config->get('simple_payment_view_address_empty');
        
        $simple_payment_view_address_full = $this->config->get('simple_payment_view_address_full');
        $simple_payment_view_autoselect_first = $this->config->get('simple_payment_methods_hide') ? true : $this->config->get('simple_payment_view_autoselect_first');
           
        $this->data['payment_methods'] = array();
      
        $total_data = array();                    
        $total = 0;
        $taxes = $this->cart->getTaxes();
        
        $this->load->model('setting/extension');
        
        $sort_order = array(); 
        
        $results = $this->model_setting_extension->getExtensions('total');
        
        foreach ($results as $key => $value) {
            $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
        }
        
        array_multisort($sort_order, SORT_ASC, $results);
        
        foreach ($results as $result) {
            if ($this->config->get($result['code'] . '_status')) {
                $this->load->model('total/' . $result['code']);
                $this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
            }
        }

        $method_data = array();
        
        $this->load->model('setting/extension');
        
        $results = $this->model_setting_extension->getExtensions('payment');
        
        $simple_links = $this->config->get('simple_links');
        
        $shipping_method = $this->simple->shipping_method;
        
        $shipping_method_code = !empty($shipping_method['code']) ? $shipping_method['code'] : false;
        $shipping_method_code = $shipping_method_code ? explode('.',$shipping_method_code) : false;
        $shipping_method_code = count($shipping_method_code) == 2 ? $shipping_method_code : false;
        
        foreach ($results as $result) {
            $show_module = true;
            if (!$this->data['address_empty']) {
                $show_module = true;
            } elseif ($this->data['address_empty'] && !empty($simple_payment_view_address_full[$result['code']])) {
                $show_module = false;
            } 
            
            if ($this->config->get($result['code'] . '_status') && $show_module) {
                
                $for_shipping_methods = array();
                if (!empty($simple_links[$result['code']])) {
                    $for_shipping_methods = explode(",",$simple_links[$result['code']]);
                }
                
                if (empty($for_shipping_methods) || ($shipping_method_code && (in_array($shipping_method_code[0], $for_shipping_methods) || in_array($shipping_method_code[0].'.'.$shipping_method_code[1], $for_shipping_methods)))) {
                    $this->load->model('payment/' . $result['code']);
                    
                    $method = $this->{'model_payment_' . $result['code']}->getMethod($address, $total); 
                    
                    if ($method) {
                        $method_data[$result['code']] = $method;
                    }
                }
            }
        }
                     
        $sort_order = array(); 
      
        foreach ($method_data as $key => $value) {
            $sort_order[$key] = $value['sort_order'];
        }

        array_multisort($sort_order, SORT_ASC, $method_data);            
        
        $this->data['payment_methods'] = $method_data;    
        $this->data['payment_method'] = null;
        $this->data['error_warning'] = '';
        
        if ($this->request->server['REQUEST_METHOD'] == 'POST' && isset($this->request->post['payment_method']) && !empty($this->data['payment_methods'][$this->request->post['payment_method']])) {
            $this->data['payment_method'] = $this->data['payment_methods'][$this->request->post['payment_method']];
            
            if (!isset($this->session->data['payment_method_selected']) || (isset($this->session->data['payment_method_selected']) && $this->session->data['payment_method_selected'] != $this->request->post['payment_method'])) {
                $this->session->data['payment_method_user_select'] = true;
            }
        } else {
            $this->session->data['payment_method_user_select'] = false;
        }
        
        if ($this->request->server['REQUEST_METHOD'] == 'GET' && isset($this->request->cookie['payment_method']) && !empty($this->data['payment_methods'][$this->request->cookie['payment_method']])) {
            $this->data['payment_method'] = $this->data['payment_methods'][$this->request->cookie['payment_method']];
            $this->session->data['payment_method_user_select'] = true;
        }
        
        if (!empty($this->data['payment_methods'])) {
            $first_method = reset($this->data['payment_methods']);
        }
        
        if ($simple_payment_view_autoselect_first && !empty($first_method) && empty($this->session->data['payment_method_user_select'])) {
            $this->session->data['payment_method_user_select'] = false;
            $this->data['payment_method'] = $first_method;
        }
        
        if (isset($this->data['payment_method'])) {
            $this->session->data['payment_method_selected'] = $this->data['payment_method']['code'];
            setcookie('payment_method', $this->data['payment_method']['code'], time() + 60 * 60 * 24 * 30);
        }
        
        $this->data['code'] = !empty($this->data['payment_method']) ? $this->data['payment_method']['code'] : '';                
        
        $this->simple->payment_methods = $this->data['payment_methods'];
        $this->simple->payment_method = $this->data['payment_method'];
        
        $this->data['simple_create_order'] = !empty($this->request->post['simple_create_order']);
        
        $this->validate();
        
        $this->save_to_session();
        
        $this->data['text_payment_address'] = $this->language->get('text_payment_address');
        $this->data['error_no_payment'] = sprintf($this->language->get('error_no_payment'), $this->url->link('information/contact'));
        $this->data['text_checkout_payment_method'] = $this->language->get('text_checkout_payment_method');        
        
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/simplecheckout_payment.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/checkout/simplecheckout_payment.tpl';
        } else {
            $this->template = 'default/template/checkout/simplecheckout_payment.tpl';
        }
                
        $this->response->setOutput($this->render());
    }
    
    private function save_to_session() {
        $this->session->data['payment_methods'] = $this->simple->payment_methods;
        $this->session->data['payment_method'] = $this->simple->payment_method;
        
        if (empty($this->session->data['payment_methods'])) {
            unset($this->session->data['payment_method']);
        }
    }
    
    private function validate() {
        $error = false;
        
        if (empty($this->data['payment_method'])) {
  			$this->data['error_warning'] = $this->language->get('error_payment');
            $error = true;
        }
        
        if ($error) {
            $this->simple->error = 'payment_method';
        }
        
    	return !$error;
    }
}
?>