<?php
/*
@author	Dmitriy Kubarev
@link	http://www.simpleopencart.com
@link	http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4811
*/  

class ControllerCheckoutSimpleCheckout extends Controller { 
    public function index() {

        if (!$this->customer->isLogged() && $this->config->get('simple_disable_guest_checkout')) {
            $this->session->data['redirect'] = $this->url->link('checkout/simplecheckout', '', 'SSL');
            $this->redirect($this->url->link('account/login','','SSL'));
        }
        
        $this->language->load('checkout/simplecheckout');
        
        $this->document->setTitle($this->language->get('heading_title')); 
            
        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home'),
            'separator' => false
        ); 
        
        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('checkout/simplecheckout', '', 'SSL'),
            'separator' => $this->language->get('text_separator')
        );
        
        $this->data['action'] = $this->url->link('checkout/simplecheckout', '', 'SSL');

        $this->data['heading_title'] = $this->language->get('heading_title');
        $this->data['text_proceed_payment'] = $this->language->get('text_proceed_payment');
        $this->data['text_payment_form_title'] = $this->language->get('text_payment_form_title');
        $this->data['text_need_save_changes'] = $this->language->get('text_need_save_changes');
        $this->data['text_saving_changes'] = $this->language->get('text_saving_changes');
        $this->data['button_save_changes'] = $this->language->get('button_save_changes');
         
        if ($this->cart->hasProducts() || !empty($this->session->data['vouchers'])) {
            
            $this->data['button_order'] = $this->language->get('button_order');
            $this->data['button_back'] = $this->language->get('button_back');
              
            $this->data['simple_common_view_agreement_checkbox'] = false;
            $this->data['simple_common_view_agreement_text'] = false;
            $this->data['simple_common_view_agreement_checkbox_init'] = 0;
            $this->data['simple_common_view_help_text'] = false;
            
            $this->data['agree_warning'] = '';
            
            if ($this->config->get('simple_common_view_agreement_id')) {
                $this->load->model('catalog/information');
                
                $this->data['information_info'] = $this->model_catalog_information->getInformation($this->config->get('simple_common_view_agreement_id'));
                
                if ($this->data['information_info']) {
                    $this->data['simple_common_view_agreement_checkbox'] = $this->config->get('simple_common_view_agreement_checkbox');
                    $this->data['simple_common_view_agreement_text'] = $this->config->get('simple_common_view_agreement_text');
                    $this->data['simple_common_view_agreement_checkbox_init'] = $this->config->get('simple_common_view_agreement_checkbox_init');
            
                    $this->data['information_title'] = $this->data['information_info']['title'];
                    $this->data['information_text'] = html_entity_decode($this->data['information_info']['description'], ENT_QUOTES, 'UTF-8');
                    
                    $current_theme = $this->config->get('config_template');
                    
                    $id = ($current_theme == 'shoppica' || $current_theme == 'shoppica2') ? 'text_agree_shoppica' : 'text_agree';
                    $this->data['text_agree'] = sprintf($this->language->get($id), $this->url->link('information/information/info', 'information_id=' . $this->config->get('simple_common_view_agreement_id'), 'SSL'), $this->data['information_info']['title'], $this->data['information_info']['title']);
                    $this->data['agree_warning'] = sprintf($this->language->get('error_agree'), $this->data['information_info']['title']);
                }
            }
            
            if ($this->config->get('simple_common_view_help_id')) {
                $this->load->model('catalog/information');
                
                $this->data['information_info'] = $this->model_catalog_information->getInformation($this->config->get('simple_common_view_help_id'));
                
                if ($this->data['information_info']) {
                    $this->data['simple_common_view_help_text'] = $this->config->get('simple_common_view_help_text');
                    
                    $this->data['help_title'] = $this->data['information_info']['title'];
                    $this->data['help_text'] = html_entity_decode($this->data['information_info']['description'], ENT_QUOTES, 'UTF-8');
                }
            }
            
            if (isset($this->request->post['agree'])) {
                $this->data['agree'] = $this->request->post['agree'];
            } elseif ($this->request->server['REQUEST_METHOD'] == 'POST') {
                $this->data['agree'] = 0;
            } else {
                $this->data['agree'] = $this->config->get('simple_common_view_agreement_checkbox_init');
            }

 if (isset($this->request->post['newpay'])) {
   if(!empty($this->request->post['newpay'])){
      $this->session->data['newpay']=$this->request->post['newpay'];

            }}

            
            $this->data['simple_create_order'] = !empty($this->request->post['simple_create_order']);
        
            $this->simple = new Simple();
                        
            $this->getChild('checkout/simplecheckout_cart/update');
            $this->getChild('checkout/simplecheckout_customer/update');
            
            $redirect = $this->simple->redirect;
            
            if ($redirect) {
                if (!isset($this->request->server['HTTP_X_REQUESTED_WITH']) || $this->request->server['HTTP_X_REQUESTED_WITH'] != 'XMLHttpRequest') {
                    $this->redirect($redirect);                
                } else {
                    $this->response->setOutput('<script type="text/javascript">location="'.$redirect.'";</script>');
                    return;    
                }
            }
            
            $this->data['simplecheckout_shipping'] = $this->getChild('checkout/simplecheckout_shipping');
            $this->data['simplecheckout_payment'] = $this->getChild('checkout/simplecheckout_payment');
            $this->data['simplecheckout_cart'] = $this->getChild('checkout/simplecheckout_cart');
            $this->data['simplecheckout_customer'] = $this->getChild('checkout/simplecheckout_customer');
            
            $this->data['block_order'] = $this->simple->block_order;
            
            $this->data['error_warning'] = '';
            $this->data['payment_form'] = '';
            
            if ($this->validate()) {                
                $order_id = $this->order();
            
                if (file_exists(DIR_APPLICATION . 'model/tool/simpledata.php')) {
                    $this->load->model('tool/simpledata');
                    if (method_exists($this->model_tool_simpledata,'saveCheckoutData')) {
                        $this->model_tool_simpledata->saveCheckoutData($this->simple->customer['customer_id'], $order_id, $this->request->post);
                    }
                }
            
                $payment_method = $this->simple->payment_method;
                
                $this->request->server['REQUEST_METHOD'] = 'GET';
                
                $this->data['payment_form'] = $this->getChild('payment/' . $payment_method['code']);
                
                unset($this->session->data['simple']);
            }
            
            $this->data['has_shipping'] = true;
            
            if (!$this->cart->hasShipping()) {
                $this->data['has_shipping'] = false;
            }
            
            $simple_common_template = $this->config->get('simple_common_template');
            $simple_common_template = $simple_common_template != '' ? $simple_common_template : '{help}{left_column}{cart}{customer}{/left_column}{right_column}{shipping}{payment}{agreement}{/right_column}{payment_form}';
            if (strpos($simple_common_template, '{payment_form}') === false) {
                $simple_common_template .= '{payment_form}';
            }
            $this->data['simple_common_template'] = $simple_common_template;
            $this->data['language_code'] = $this->config->get('config_language');
            $this->data['simple_aceshop'] = $this->config->get('simple_aceshop');
            
            $this->data['simple_shipping_methods_hide'] = $this->config->get('simple_shipping_methods_hide');
            $this->data['simple_payment_methods_hide'] = $this->config->get('simple_payment_methods_hide');
            $this->data['simple_customer_hide_if_logged'] = $this->customer->isLogged() ? $this->config->get('simple_customer_hide_if_logged') : false;
            
            $this->data['simple_show_weight'] = $this->config->get('simple_show_weight');
            $this->data['weight'] = $this->weight->format($this->cart->getWeight(), $this->config->get('config_weight_class_id'), $this->language->get('decimal_point'), $this->language->get('thousand_point'));
			
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/simplecheckout.tpl')) {
                $this->template = $this->config->get('config_template') . '/template/checkout/simplecheckout.tpl';
                $this->data['template'] = $this->config->get('config_template');
            } else {
                $this->template = 'default/template/checkout/simplecheckout.tpl';
                $this->data['template'] = 'default';
            }
            
            $this->data['ajax'] = true;
            
            if (!isset($this->request->server['HTTP_X_REQUESTED_WITH']) || $this->request->server['HTTP_X_REQUESTED_WITH'] != 'XMLHttpRequest') {
                $this->data['ajax'] = false;
                
                $this->children = array(
                    'common/column_left',
                    'common/column_right',
                    'common/content_top',
                    'common/content_bottom',
                    'common/footer',
                    'common/header',
                );
            }
                  
            $this->response->setOutput($this->render());
        } else {
            $this->data['heading_title'] = $this->language->get('heading_title');
            
            $this->data['text_error'] = $this->language->get('text_empty');
            
            $this->data['button_continue'] = $this->language->get('button_continue');
            
            $this->data['continue'] = $this->url->link('common/home');
            
            if (isset($this->request->server['HTTP_X_REQUESTED_WITH']) && $this->request->server['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest') {
                $this->response->setOutput('<script type="text/javascript">location="'.$this->url->link('checkout/simplecheckout', '', 'SSL').'";</script>');
                return;    
            }

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/simplecheckout_cart_empty.tpl')) {
                $this->template = $this->config->get('config_template') . '/template/checkout/simplecheckout_cart_empty.tpl';
                $this->data['template'] = $this->config->get('config_template');
            } else {
                $this->template = 'default/template/checkout/simplecheckout_cart_empty.tpl';
                $this->data['template'] = 'default';
            }
            
            $this->children = array(
                'common/column_left',
                'common/column_right',
                'common/content_top',
                'common/content_bottom',
                'common/footer',
                'common/header'    
            );
                    
            $this->response->setOutput($this->render());            
        }
    }
    
    private function validate() {
        $error = false;
        
        if (!empty($this->data['simple_common_view_agreement_checkbox']) && empty($this->data['agree'])) {
            $this->data['error_warning'] = sprintf($this->language->get('error_agree'), $this->data['information_info']['title']);
            $this->simple->error = 'agree';
        }
        
        $child_error = $this->simple->error;
        
        if (!empty($child_error)) {
            $error = true;
        }
        
        return !$error;
    }
    
    private function delete_order($order_id) {
        $version = $this->simple->version;
        
        $this->db->query("DELETE FROM `" . DB_PREFIX . "order` WHERE order_id = '" . (int)$order_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "order_product WHERE order_id = '" . (int)$order_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "order_download WHERE order_id = '" . (int)$order_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "order_total WHERE order_id = '" . (int)$order_id . "'");
        
        if ($version >= 152) {
            $this->db->query("DELETE FROM " . DB_PREFIX . "order_voucher WHERE order_id = '" . (int)$order_id . "'");
        }
        
        $this->db->query("SET insert_id = " . (int)$order_id);
    }
    
    private function order() {
        if (isset($this->session->data['order_id'])) {
            $this->delete_order($this->session->data['order_id']);
            unset($this->session->data['order_id']);
        }
        
        $customer = $this->simple->customer;
        
        if (empty($customer['email'])) {
            $email = $this->config->get('simple_empty_email');
            $email = !empty($email) ? $email : 'empty@localhost';
            $customer['email'] = $email;
        }
        
        $this->simple->customer = $customer;
        
        $version = $this->simple->version;
        
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
        
        $sort_order = array(); 
      
        foreach ($total_data as $key => $value) {
            $sort_order[$key] = $value['sort_order'];
        }
    
        array_multisort($sort_order, SORT_ASC, $total_data);
    
        $data = array();
        
        $data['invoice_prefix'] = $this->config->get('config_invoice_prefix');
        $data['store_id'] = $this->config->get('config_store_id');
        $data['store_name'] = $this->config->get('config_name');
        
        if ($data['store_id']) {
            $data['store_url'] = $this->config->get('config_url');        
        } else {
            $data['store_url'] = HTTP_SERVER;    
        }
        
        $data['customer_id'] = $this->simple->customer['customer_id'];
        $data['customer_group_id'] = $this->simple->customer['customer_id'];
        $data['firstname'] = $this->simple->customer['firstname'];
        $data['lastname'] = $this->simple->customer['lastname'];
        $data['email'] = $this->simple->customer['email'];
        $data['telephone'] = $this->simple->customer['telephone'];
        $data['fax'] = $this->simple->customer['fax'];
    
        $data['payment_firstname'] = $this->simple->payment_address['firstname'];
        $data['payment_lastname'] = $this->simple->payment_address['lastname'];    
        $data['payment_company'] = $this->simple->payment_address['company'];    
        $data['payment_address_1'] = $this->simple->payment_address['address_1'];
        $data['payment_address_2'] = $this->simple->payment_address['address_2'];
        $data['payment_city'] = $this->simple->payment_address['city'];
        $data['payment_postcode'] = $this->simple->payment_address['postcode'];
        $data['payment_zone'] = $this->simple->payment_address['zone'];
        $data['payment_zone_id'] = $this->simple->payment_address['zone_id'];
        $data['payment_country'] = $this->simple->payment_address['country'];
        $data['payment_country_id'] = $this->simple->payment_address['country_id'];
        $data['payment_address_format'] = $this->simple->payment_address['address_format'];
        $data['payment_company_id'] = $this->simple->payment_address['company_id'];    
        $data['payment_tax_id'] = $this->simple->payment_address['tax_id'];    
            
        $payment_method = $this->simple->payment_method;
        
        if (isset($payment_method['title'])) {
            $data['payment_method'] = $payment_method['title'];
        } else {
            $data['payment_method'] = '';
        }
        
        if (isset($payment_method['code'])) {
            $data['payment_code'] = $payment_method['code'];
        } else {
            $data['payment_code'] = '';
        }
        
        if ($this->cart->hasShipping()) {
            $data['shipping_firstname'] = $this->simple->shipping_address['firstname'];
            $data['shipping_lastname'] = $this->simple->shipping_address['lastname'];    
            $data['shipping_company'] = $this->simple->shipping_address['company'];    
            $data['shipping_address_1'] = $this->simple->shipping_address['address_1'];
            $data['shipping_address_2'] = $this->simple->shipping_address['address_2'];
            $data['shipping_city'] = $this->simple->shipping_address['city'];
            $data['shipping_postcode'] = $this->simple->shipping_address['postcode'];
            $data['shipping_zone'] = $this->simple->shipping_address['zone'];
            $data['shipping_zone_id'] = $this->simple->shipping_address['zone_id'];
            $data['shipping_country'] = $this->simple->shipping_address['country'];
            $data['shipping_country_id'] = $this->simple->shipping_address['country_id'];
            $data['shipping_address_format'] = $this->simple->shipping_address['address_format'];
            
            $shipping_method = $this->simple->shipping_method;
            
            if (isset($shipping_method['title'])) {
                $data['shipping_method'] = $shipping_method['title'];
            } else {
                $data['shipping_method'] = '';
            }
            
            if (isset($shipping_method['code'])) {
                $data['shipping_code'] = $shipping_method['code'];
            } else {
                $data['shipping_code'] = '';
            }
        } else {
            $data['shipping_firstname'] = '';
            $data['shipping_lastname'] = '';    
            $data['shipping_company'] = '';    
            $data['shipping_address_1'] = '';
            $data['shipping_address_2'] = '';
            $data['shipping_city'] = '';
            $data['shipping_postcode'] = '';
            $data['shipping_zone'] = '';
            $data['shipping_zone_id'] = '';
            $data['shipping_country'] = '';
            $data['shipping_country_id'] = '';
            $data['shipping_address_format'] = '';
            $data['shipping_method'] = '';
            $data['shipping_code'] = '';
        }
        
        $product_data = array();
        
        if ($version < 152) {
        
            if (method_exists($this->tax,'setZone')) {
                if ($this->cart->hasShipping()) {
    				$this->tax->setZone($data['shipping_country_id'], $data['shipping_zone_id']);
    			} else {
    				$this->tax->setZone($data['payment_country_id'], $data['payment_zone_id']);
    			}
            }
            
            $this->load->library('encryption');
        
            foreach ($this->cart->getProducts() as $product) {
                $option_data = array();
        
                foreach ($product['option'] as $option) {
                    if ($option['type'] != 'file') {    
                        $option_data[] = array(
                            'product_option_id'       => $option['product_option_id'],
                            'product_option_value_id' => $option['product_option_value_id'],
                            'product_option_id'       => $option['product_option_id'],
                            'product_option_value_id' => $option['product_option_value_id'],
                            'option_id'               => $option['option_id'],
                            'option_value_id'         => $option['option_value_id'],                                   
                            'name'                    => $option['name'],
                            'value'                   => $option['option_value'],
                            'type'                    => $option['type']
                        );                    
                    } else {
                        $encryption = new Encryption($this->config->get('config_encryption'));
                        
                        $option_data[] = array(
                            'product_option_id'       => $option['product_option_id'],
                            'product_option_value_id' => $option['product_option_value_id'],
                            'product_option_id'       => $option['product_option_id'],
                            'product_option_value_id' => $option['product_option_value_id'],
                            'option_id'               => $option['option_id'],
                            'option_value_id'         => $option['option_value_id'],                                   
                            'name'                    => $option['name'],
                            'value'                   => $encryption->decrypt($option['option_value']),
                            'type'                    => $option['type']
                        );                                
                    }
                }
        
                $product_data[] = array(
                    'product_id' => $product['product_id'],
                    'name'       => $product['name'],
                    'model'      => $product['model'],
                    'option'     => $option_data,
                    'download'   => $product['download'],
                    'quantity'   => $product['quantity'],
                    'subtract'   => $product['subtract'],
                    'price'      => $product['price'],
                    'total'      => $product['total'],
                    'tax'        => method_exists($this->tax,'getRate') ? $this->tax->getRate($product['tax_class_id']) : $this->tax->getTax($product['total'], $product['tax_class_id'])
                ); 
            }
            
            // Gift Voucher
            if (isset($this->session->data['vouchers']) && $this->session->data['vouchers']) {
                foreach ($this->session->data['vouchers'] as $voucher) {
                    $product_data[] = array(
                        'product_id' => 0,
                        'name'       => $voucher['description'],
                        'model'      => '',
                        'option'     => array(),
                        'download'   => array(),
                        'quantity'   => 1,
                        'subtract'   => false,
                        'price'      => $voucher['amount'],
                        'total'      => $voucher['amount'],
                        'tax'        => 0
                    );
                }
            } 
                        
            $data['products'] = $product_data;
            $data['totals'] = $total_data;
            $data['comment'] = $this->simple->comment;
            $data['total'] = $total;
            $data['reward'] = $this->cart->getTotalRewardPoints();
        } elseif ($version >= 152) {
            foreach ($this->cart->getProducts() as $product) {
                $option_data = array();
    
                foreach ($product['option'] as $option) {
                    if ($option['type'] != 'file') {
                        $value = $option['option_value'];    
                    } else {
                        $value = $this->encryption->decrypt($option['option_value']);
                    }    
                    
                    $option_data[] = array(
                        'product_option_id'       => $option['product_option_id'],
                        'product_option_value_id' => $option['product_option_value_id'],
                        'option_id'               => $option['option_id'],
                        'option_value_id'         => $option['option_value_id'],                                   
                        'name'                    => $option['name'],
                        'value'                   => $value,
                        'type'                    => $option['type']
                    );                    
                }
     
                $product_data[] = array(
                    'product_id' => $product['product_id'],
                    'name'       => $product['name'],
                    'model'      => $product['model'],
                    'option'     => $option_data,
                    'download'   => $product['download'],
                    'quantity'   => $product['quantity'],
                    'subtract'   => $product['subtract'],
                    'price'      => $product['price'],
                    'total'      => $product['total'],
                    'tax'        => $this->tax->getTax($product['price'], $product['tax_class_id']),
                    'reward'     => $product['reward']
                ); 
            }
            
            // Gift Voucher
            $voucher_data = array();
            
            if (!empty($this->session->data['vouchers'])) {
                foreach ($this->session->data['vouchers'] as $voucher) {
                    $voucher_data[] = array(
                        'description'      => $voucher['description'],
                        'code'             => substr(md5(rand()), 0, 10),
                        'to_name'          => $voucher['to_name'],
                        'to_email'         => $voucher['to_email'],
                        'from_name'        => $voucher['from_name'],
                        'from_email'       => $voucher['from_email'],
                        'voucher_theme_id' => $voucher['voucher_theme_id'],
                        'message'          => $voucher['message'],                        
                        'amount'           => $voucher['amount']
    
                    );
                }
            }  
                        
            $data['products'] = $product_data;
            $data['vouchers'] = $voucher_data;
            $data['totals'] = $total_data;
            $data['comment'] = $this->simple->comment;
            $data['total'] = $total; 
        }
        
        if (isset($this->request->cookie['tracking'])) {
            $this->load->model('affiliate/affiliate');
            
            $affiliate_info = $this->model_affiliate_affiliate->getAffiliateByCode($this->request->cookie['tracking']);
            $subtotal = $this->cart->getSubTotal();

            if ($affiliate_info) {
                $data['affiliate_id'] = $affiliate_info['affiliate_id']; 
                $data['commission'] = ($subtotal / 100) * $affiliate_info['commission']; 
            } else {
                $data['affiliate_id'] = 0;
                $data['commission'] = 0;
            }
        } else {
            $data['affiliate_id'] = 0;
            $data['commission'] = 0;
        }
        
        $data['language_id'] = $this->config->get('config_language_id');
        $data['currency_id'] = $this->currency->getId();
        $data['currency_code'] = $this->currency->getCode();
        $data['currency_value'] = $this->currency->getValue($this->currency->getCode());
        $data['ip'] = $this->request->server['REMOTE_ADDR'];
        
        if (!empty($this->request->server['HTTP_X_FORWARDED_FOR'])) {
            $data['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];    
        } elseif(!empty($this->request->server['HTTP_CLIENT_IP'])) {
            $data['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];    
        } else {
            $data['forwarded_ip'] = '';
        }
        
        if (isset($this->request->server['HTTP_USER_AGENT'])) {
            $data['user_agent'] = $this->request->server['HTTP_USER_AGENT'];    
        } else {
            $data['user_agent'] = '';
        }
        
        if (isset($this->request->server['HTTP_ACCEPT_LANGUAGE'])) {
            $data['accept_language'] = $this->request->server['HTTP_ACCEPT_LANGUAGE'];    
        } else {
            $data['accept_language'] = '';
        }
        
        $this->load->model('checkout/order');
        
        $order_id = 0;
        
        if ($version < 152) {
            $order_id = $this->model_checkout_order->create($data);
            
            // Gift Voucher
            if (isset($this->session->data['vouchers']) && is_array($this->session->data['vouchers'])) {
                $this->load->model('checkout/voucher');
        
                foreach ($this->session->data['vouchers'] as $voucher) {
                    $this->model_checkout_voucher->addVoucher($order_id, $voucher);
                }
            }
        } elseif ($version >= 152) {
            $order_id = $this->model_checkout_order->addOrder($data);
        }
        
        $this->session->data['order_id'] = $order_id;
        
        return $order_id;
    }
}

class Simple {
    protected $array;
    public $version;
 
    public function __construct() {
        $this->array = array();
        
        $version = explode('.', VERSION);
        $four = isset($version[3]) ? 0.1*$version[3] : 0;
        $main = $version[0].$version[1].$version[2];
        $this->version = (int)$main + $four;
    }
    
    public function __set($name, $value) {
        $this->array[$name] = $value;
    }
 
    public function __get($name) {
        return isset($this->array[$name]) ? $this->array[$name] : null;        
    }
    
    public function is_mobile() {
        $user_agent=strtolower(getenv('HTTP_USER_AGENT'));
        $accept=strtolower(getenv('HTTP_ACCEPT'));
        
        if ((strpos($accept,'text/vnd.wap.wml')!==false) || (strpos($accept,'application/vnd.wap.xhtml+xml')!==false)) {
            return 1; 
        }
        
        if (isset($_SERVER['HTTP_X_WAP_PROFILE']) ||
            isset($_SERVER['HTTP_PROFILE'])) {
            return 2; 
        }
        
        if (preg_match('/(mini 9.5|vx1000|lge |m800|e860|u940|ux840|compal|'.
        'wireless| mobi|ahong|lg380|lgku|lgu900|lg210|lg47|lg920|lg840|'.
        'lg370|sam-r|mg50|s55|g83|t66|vx400|mk99|d615|d763|el370|sl900|'.
        'mp500|samu3|samu4|vx10|xda_|samu5|samu6|samu7|samu9|a615|b832|'.
        'm881|s920|n210|s700|c-810|_h797|mob-x|sk16d|848b|mowser|s580|'.
        'r800|471x|v120|rim8|c500foma:|160x|x160|480x|x640|t503|w839|'.
        'i250|sprint|w398samr810|m5252|c7100|mt126|x225|s5330|s820|'.
        'htil-g1|fly v71|s302|-x113|novarra|k610i|-three|8325rc|8352rc|'.
        'sanyo|vx54|c888|nx250|n120|mtk |c5588|s710|t880|c5005|i;458x|'.
        'p404i|s210|c5100|teleca|s940|c500|s590|foma|samsu|vx8|vx9|a1000|'.
        '_mms|myx|a700|gu1100|bc831|e300|ems100|me701|me702m-three|sd588|'.
        's800|8325rc|ac831|mw200|brew |d88|htc\/|htc_touch|355x|m50|km100|'.
        'd736|p-9521|telco|sl74|ktouch|m4u\/|me702|8325rc|kddi|phone|lg |'.
        'sonyericsson|samsung|240x|x320vx10|nokia|sony cmd|motorola|'.
        'up.browser|up.link|mmp|symbian|smartphone|midp|wap|vodafone|o2|'.
        'pocket|kindle|mobile|psp|treo)/', $user_agent)) {
            return 3; 
        }
        
        if (in_array(substr($user_agent,0,4),
        Array("1207", "3gso", "4thp", "501i", "502i", "503i", "504i", "505i", "506i",
              "6310", "6590", "770s", "802s", "a wa", "abac", "acer", "acoo", "acs-",
              "aiko", "airn", "alav", "alca", "alco", "amoi", "anex", "anny", "anyw",
              "aptu", "arch", "argo", "aste", "asus", "attw", "au-m", "audi", "aur ",
              "aus ", "avan", "beck", "bell", "benq", "bilb", "bird", "blac", "blaz",
              "brew", "brvw", "bumb", "bw-n", "bw-u", "c55/", "capi", "ccwa", "cdm-",
              "cell", "chtm", "cldc", "cmd-", "cond", "craw", "dait", "dall", "dang",
              "dbte", "dc-s", "devi", "dica", "dmob", "doco", "dopo", "ds-d", "ds12",
              "el49", "elai", "eml2", "emul", "eric", "erk0", "esl8", "ez40", "ez60",
              "ez70", "ezos", "ezwa", "ezze", "fake", "fetc", "fly-", "fly_", "g-mo",
              "g1 u", "g560", "gene", "gf-5", "go.w", "good", "grad", "grun", "haie",
              "hcit", "hd-m", "hd-p", "hd-t", "hei-", "hiba", "hipt", "hita", "hp i",
              "hpip", "hs-c", "htc ", "htc-", "htc_", "htca", "htcg", "htcp", "htcs",
              "htct", "http", "huaw", "hutc", "i-20", "i-go", "i-ma", "i230", "iac",
              "iac-", "iac/", "ibro", "idea", "ig01", "ikom", "im1k", "inno", "ipaq",
              "iris", "jata", "java", "jbro", "jemu", "jigs", "kddi", "keji", "kgt",
              "kgt/", "klon", "kpt ", "kwc-", "kyoc", "kyok", "leno", "lexi", "lg g",
              "lg-a", "lg-b", "lg-c", "lg-d", "lg-f", "lg-g", "lg-k", "lg-l", "lg-m",
              "lg-o", "lg-p", "lg-s", "lg-t", "lg-u", "lg-w", "lg/k", "lg/l", "lg/u",
              "lg50", "lg54", "lge-", "lge/", "libw", "lynx", "m-cr", "m1-w", "m3ga",
              "m50/", "mate", "maui", "maxo", "mc01", "mc21", "mcca", "medi", "merc",
              "meri", "midp", "mio8", "mioa", "mits", "mmef", "mo01", "mo02", "mobi",
              "mode", "modo", "mot ", "mot-", "moto", "motv", "mozz", "mt50", "mtp1",
              "mtv ", "mwbp", "mywa", "n100", "n101", "n102", "n202", "n203", "n300",
              "n302", "n500", "n502", "n505", "n700", "n701", "n710", "nec-", "nem-",
              "neon", "netf", "newg", "newt", "nok6", "noki", "nzph", "o2 x", "o2-x",
              "o2im", "opti", "opwv", "oran", "owg1", "p800", "palm", "pana", "pand",
              "pant", "pdxg", "pg-1", "pg-2", "pg-3", "pg-6", "pg-8", "pg-c", "pg13",
              "phil", "pire", "play", "pluc", "pn-2", "pock", "port", "pose", "prox",
              "psio", "pt-g", "qa-a", "qc-2", "qc-3", "qc-5", "qc-7", "qc07", "qc12",
              "qc21", "qc32", "qc60", "qci-", "qtek", "qwap", "r380", "r600", "raks",
              "rim9", "rove", "rozo", "s55/", "sage", "sama", "samm", "sams", "sany",
              "sava", "sc01", "sch-", "scoo", "scp-", "sdk/", "se47", "sec-", "sec0",
              "sec1", "semc", "send", "seri", "sgh-", "shar", "sie-", "siem", "sk-0",
              "sl45", "slid", "smal", "smar", "smb3", "smit", "smt5", "soft", "sony",
              "sp01", "sph-", "spv ", "spv-", "sy01", "symb", "t-mo", "t218", "t250",
              "t600", "t610", "t618", "tagt", "talk", "tcl-", "tdg-", "teli", "telm",
              "tim-", "topl", "tosh", "treo", "ts70", "tsm-", "tsm3", "tsm5", "tx-9",
              "up.b", "upg1", "upsi", "utst", "v400", "v750", "veri", "virg", "vite",
              "vk-v", "vk40", "vk50", "vk52", "vk53", "vm40", "voda", "vulc", "vx52",
              "vx53", "vx60", "vx61", "vx70", "vx80", "vx81", "vx83", "vx85", "vx98",
              "w3c ", "w3c-", "wap-", "wapa", "wapi", "wapj", "wapm", "wapp", "wapr",
              "waps", "wapt", "wapu", "wapv", "wapy", "webc", "whit", "wig ", "winc",
              "winw", "wmlb", "wonu", "x700", "xda-", "xda2", "xdag", "yas-", "your",
              "zeto", "zte-"))) {
            return 4;
        }
        
        return false;
    }
}

?>