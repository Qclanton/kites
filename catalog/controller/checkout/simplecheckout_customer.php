<?php 
/*
@author	Dmitriy Kubarev
@link	http://www.simpleopencart.com
@link	http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4811
*/  

class ControllerCheckoutSimpleCheckoutCustomer extends Controller {
    static $static_data = array();
    private $error = array();
    private $language_code = '';
    private $cookies = array();
    
    public function index() {
    
        $this->load->model('account/address');
        $this->load->model('account/customer');

        $this->language->load('checkout/simplecheckout');
        
        $this->data['text_checkout_customer'] = $this->language->get('text_checkout_customer');
        $this->data['text_checkout_shipping_address'] = $this->language->get('text_checkout_shipping_address');
        $this->data['text_checkout_customer_login'] = $this->language->get('text_checkout_customer_login');
        $this->data['text_checkout_customer_cancel'] = $this->language->get('text_checkout_customer_cancel');
        $this->data['text_private'] = $this->language->get('text_private');
        $this->data['text_company'] = $this->language->get('text_company');
        $this->data['text_select'] = $this->language->get('text_select');
        $this->data['text_add_new'] = $this->language->get('text_add_new');
        $this->data['text_your_company'] = $this->language->get('text_your_company');
        $this->data['text_select_address'] = $this->language->get('text_select_address');
        $this->data['entry_register'] = $this->language->get('entry_register');
        $this->data['entry_newsletter'] = $this->language->get('entry_newsletter');
        $this->data['entry_password'] = $this->language->get('entry_password');
        $this->data['entry_password_confirm'] = $this->language->get('entry_password_confirm');
        $this->data['entry_address_same'] = $this->language->get('entry_address_same');
        $this->data['text_yes'] = $this->language->get('text_yes');
        $this->data['text_no'] = $this->language->get('text_no');
        $this->data['button_update'] = $this->language->get('button_update');
        
        $this->data['simple_customer_generate_password'] = $this->config->get('simple_customer_generate_password');
        $this->data['simple_customer_action_subscribe'] = $this->config->get('simple_customer_action_subscribe');
        $this->data['simple_customer_view_customer_type'] = $this->config->get('simple_customer_view_customer_type');
        $this->data['simple_customer_view_email'] = $this->config->get('simple_customer_view_email');
        $this->data['simple_customer_action_register'] = $this->config->get('simple_customer_action_register');
        $this->data['simple_customer_view_password_confirm'] = $this->config->get('simple_customer_view_password_confirm');
        $this->data['simple_customer_view_login'] = !$this->customer->isLogged() ? $this->config->get('simple_customer_view_login') : false;
        $this->data['simple_customer_view_address_select'] = $this->config->get('simple_customer_view_address_select');
        $this->data['simple_shipping_view_address_select'] = $this->config->get('simple_shipping_view_address_select');
        
        $this->data['login_link'] = $this->url->link('checkout/simplecheckout_customer/login', '', 'SSL');
        $this->data['default_login_link'] = $this->url->link('account/login', '', 'SSL');
        
        $this->data['text_you_will_be_registered'] = '';
        if (!$this->customer->isLogged() && $this->config->get('simple_show_will_be_registered') && $this->data['simple_customer_action_register'] == 1) {
            $this->data['text_you_will_be_registered'] = $this->language->get('text_you_will_be_registered');
        }
        
        if (!$this->customer->isLogged()) {
            $this->session->data['redirect'] = $this->url->link('checkout/simplecheckout', '', 'SSL');
        }
        
        $this->data['customer_logged'] = $this->customer->isLogged();
        
        $this->load_cookies();
        $this->load_adresses();
		$this->load_main_address();
        $this->load_fields_and_filter();
        $this->save_cookies();
        
        if (!$this->validate()) {
            $this->simple->error = 'customer';
        }
        
        $payment_address = $this->simple->payment_address;
        if (!empty($payment_address)) {
            $this->data['customer_address_id'] = $payment_address['address_id'];
        } else {
            $this->data['customer_address_id'] = 0;
        }
        
        $shipping_address = $this->simple->shipping_address;
        if (!empty($shipping_address)) {
            $this->data['shipping_address_id'] = $shipping_address['address_id'];
        } else {
            $this->data['shipping_address_id'] = 0;
        }
        
        $this->data['simple_show_shipping_address'] = $this->simple->show_shipping_address;
        $this->data['shipping_address_same'] = $this->simple->shipping_address_same;
        
        $this->data['register'] = $this->simple->register;
        $this->data['subscribe'] = $this->simple->subscribe;
        $this->data['customer_type'] = $this->simple->customer_type;
        $this->data['password'] = $this->simple->password;
		$this->data['password_confirm'] = $this->simple->password_confirm;
		
        $this->data['simple_create_order'] = !empty($this->request->post['simple_create_order']);
        
        $this->data['simple_customer_two_column'] = $this->config->get('simple_customer_two_column'); 
        
        $this->data['simple_customer_registered'] = '';
        if (isset($this->session->data['simple_customer_registered'])) {
            $this->data['simple_customer_registered'] = $this->session->data['simple_customer_registered'];
            unset($this->session->data['simple_customer_registered']);
        }
        
        $this->data['simple_debug'] = $this->config->get('simple_debug');
        $this->data['customer'] = $this->simple->customer;
        $this->data['comment'] = $this->simple->comment;
                
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/simplecheckout_customer.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/checkout/simplecheckout_customer.tpl';
        } else {
            $this->template = 'default/template/checkout/simplecheckout_customer.tpl';
        }
          
        $this->response->setOutput($this->render());            
    }
    
    private function load_main_address() {
        if ($this->customer->isLogged()) {
            if (!isset(self::$static_data['address'])) {
                self::$static_data['address'] = array();
                $main_address_id = $this->customer->getAddressId();
                if (!empty(self::$static_data['addresses'][$main_address_id])) {
                    self::$static_data['address'] = self::$static_data['addresses'][$main_address_id];
                } else {
                    self::$static_data['address'] = $this->model_account_address->getAddress($main_address_id);
                }
            }
            $this->data['address'] = self::$static_data['address'];
        }
    }
    
    private function load_adresses() {
        if ($this->customer->isLogged()) {
            if (!isset(self::$static_data['addresses'])) {
                self::$static_data['addresses'] = array();
                $addresses = $this->model_account_address->getAddresses();
                foreach ($addresses as $address) {
                    self::$static_data['addresses'][$address['address_id']] = $address;
                }
            }
            $this->data['addresses'] = self::$static_data['addresses'];
        }
    }
    
    private function load_custom_data($address_id) {
        if ($this->customer->isLogged()) {
            if (!isset(self::$static_data['custom_customer_data'])) {
                self::$static_data['custom_customer_data'] = array();
                if (file_exists(DIR_APPLICATION . 'model/tool/simpledata.php')) {
        			$this->load->model('tool/simpledata');
                    if (method_exists($this->model_tool_simpledata,'loadCustomerData')) {
                        self::$static_data['custom_customer_data'] = $this->model_tool_simpledata->loadCustomerData($this->customer->getId());
                    }
        		}
                $this->data['custom_customer_data'] = self::$static_data['custom_customer_data'];
            }
            if (!isset(self::$static_data['custom_address_data'])) {
                self::$static_data['custom_address_data'] = array();
            }
            if (!isset(self::$static_data['custom_address_data'][$address_id])) {
                self::$static_data['custom_address_data'][$address_id] = array();
                if (file_exists(DIR_APPLICATION . 'model/tool/simpledata.php')) {
        			$this->load->model('tool/simpledata');
                    if ($address_id && method_exists($this->model_tool_simpledata,'loadAddressData')) {
                        self::$static_data['custom_address_data'][$address_id] = $this->model_tool_simpledata->loadAddressData($address_id);
                    }
        		}
                $this->data['custom_address_data'][$address_id] = self::$static_data['custom_address_data'][$address_id];
            }
        }
    }
    
    private function set_password_value() {
        $eng = "qwertyuiopasdfghjklzxcvbnm1234567890";
        $password = '';
        $password_confirm = '';
        
        $min_length = $this->config->get('simple_customer_view_password_length_min');
        $generated_password = '';
        while ($min_length) {
            $generated_password .= $eng[rand(0,35)]; 
            $min_length--;
        }
        
        if (!$this->customer->isLogged()) {
            $password = $this->config->get('simple_customer_generate_password') ? $generated_password : (isset($this->request->post['password']) ? trim($this->request->post['password']) : '');
            $password_confirm = $this->config->get('simple_customer_generate_password') ? $password : (isset($this->request->post['password_confirm']) ? trim($this->request->post['password_confirm']) : '');
            
            if (!$this->config->get('simple_customer_view_password_confirm')) {
                $password_confirm = $password;
            }
        }
        
        $this->simple->password = $password;
        $this->simple->password_confirm = $password_confirm;
    }
    
    private function set_customer_type_value() {
        $customer_type = 'private';
        
        if (isset($this->request->post['customer_type'])) {
            $customer_type = $this->request->post['customer_type'];
            $this->session->data['simple']['customer_type'] = $customer_type;
        } elseif ($this->request->server['REQUEST_METHOD'] == 'GET' && isset($this->session->data['simple']['customer_type'])) {
            $customer_type = $this->session->data['simple']['customer_type'];
        } 
        
        if ($customer_type != 'private' && $customer_type != 'company') {
            $customer_type = 'private';
            $this->session->data['simple']['customer_type'] = $customer_type;
        }
        
        $this->simple->customer_type = $customer_type;
    }
    
    private function set_register_value() {
        $register_customer = false;
        
        if (!$this->customer->isLogged()) {
            if ($this->request->server['REQUEST_METHOD'] == 'POST') {
                if ($this->config->get('simple_customer_action_register') == 2) {
                    if (isset($this->request->post['register'])) {
                        $register_customer = $this->request->post['register'];
                        $this->session->data['simple']['register'] = $register_customer;
                    } else {
                        $register_customer = false;
                    }
                } else {
                     $register_customer = $this->config->get('simple_customer_action_register') == 1;
                }
            } elseif ($this->request->server['REQUEST_METHOD'] == 'GET') {
                if ($this->config->get('simple_customer_action_register') == 2) {
                    if (isset($this->session->data['simple']['register'])) {
                        $register_customer = $this->session->data['simple']['register'];
                    } else {
                        $register_customer = $this->config->get('simple_customer_view_customer_register_init');
                    }
                } else {
                    $register_customer = $this->config->get('simple_customer_action_register') == 1;
                }
            } 
        }
        
        $this->simple->register = $register_customer;
    }
    
    private function set_subscribe_value() {
        $subscribe_customer = false;
        
        if (!$this->customer->isLogged()) {
            if ($this->request->server['REQUEST_METHOD'] == 'POST') {
                if ($this->config->get('simple_customer_action_subscribe') == 2) {
                    if (isset($this->request->post['subscribe'])) {
                        $subscribe_customer = $this->request->post['subscribe'];
                        $this->session->data['simple']['subscribe'] = $subscribe_customer;
                    } else {
                        $subscribe_customer = false;
                    }
                } else {
                     $subscribe_customer = $this->config->get('simple_customer_action_subscribe') == 1;
                }
            } elseif ($this->request->server['REQUEST_METHOD'] == 'GET') {
                if ($this->config->get('simple_customer_action_subscribe') == 2) {
                    if (isset($this->session->data['simple']['subscribe'])) {
                        $subscribe_customer = $this->session->data['simple']['subscribe'];
                    } else {
                        $subscribe_customer = $this->config->get('simple_customer_view_customer_subscribe_init');
                    }
                } else {
                    $subscribe_customer = $this->config->get('simple_customer_action_subscribe') == 1;
                }
            } 
        }
        
        $this->simple->subscribe = $subscribe_customer;
    }
    
    private function load_cookies() {
        if ($this->config->get('simple_use_cookies') && isset($this->request->cookie['simple'])) {
            $this->cookies = unserialize(base64_decode($this->request->cookie['simple']));
        }
    }
    
    private function save_cookies() {
        if ($this->config->get('simple_use_cookies')) {
            setcookie('simple', base64_encode(serialize($this->cookies)), time() + 60 * 60 * 24 * 30);
        }
    }
    
    public function update() {
        
        $this->load->model('account/address');
        $this->load->model('account/customer');
        
        if (!empty($this->request->post['shipping_address_same'])) {
            if (isset($this->request->post['customer']['address_id'])) {
                $this->request->post['shipping_address']['address_id'] = $this->request->post['customer']['address_id'];
            } 
            
            if (isset($this->request->post['customer_address_id'])) {
                $this->request->post['shipping_address_id'] = $this->request->post['customer_address_id'];
            }   
            
            $shipping_address_fields = array('address_id','main_firstname','main_lastname','main_company','main_company_id','main_tax_id','main_address_1','main_address_2','main_city','main_postcode','main_zone_id','main_country_id');
            
            foreach ($shipping_address_fields as $field) {
                $this->request->post['shipping_address'][$field] = '';
            }
        }
        
        $this->load_cookies();
        $this->load_adresses();
        $this->load_main_address();
        $this->load_fields_and_filter();
        
        $address = $this->prepare_address($this->get_value('customer','zone_id'), $this->get_value('customer','country_id'));
        
        $form_address_id = isset($this->request->post['customer']['address_id']) ? $this->request->post['customer']['address_id'] : -1;
        $selected_address_id = isset($this->request->post['customer_address_id']) ? $this->request->post['customer_address_id'] : (!empty($this->data['address']['address_id']) ? $this->data['address']['address_id'] : -1);
   
        if ($selected_address_id >= 0 && $form_address_id != $selected_address_id) {
            $address_id = $selected_address_id;
        } else {
            $address_id = $form_address_id;
        }
        
        $address['address_id'] = $address_id >= 0 ? $address_id : 0;
        $address['firstname'] = $this->get_total_value('customer','firstname');
        $address['lastname'] = $this->get_total_value('customer','lastname');
        $address['company'] = $this->get_total_value('customer','company');
        $address['company_id'] = $this->get_total_value('customer','company_id');
        $address['tax_id'] = $this->get_total_value('customer','tax_id');
        $address['address_1'] = $this->get_total_value('customer','address_1');
        $address['address_2'] = $this->get_total_value('customer','address_2');
        $address['postcode'] = $this->get_total_value('customer','postcode');
        $address['city'] = $this->get_total_value('customer','city');
        
        $simple_show_shipping_address = $this->cart->hasShipping() ? $this->config->get('simple_show_shipping_address') : 0;
        
        $this->simple->payment_address = $address;
        $this->simple->shipping_address = $address;
        $this->simple->shipping_address_same = true;
        $this->simple->show_shipping_address = $simple_show_shipping_address;
        
        $comment = $this->get_total_value('customer','comment');
        
        if ($simple_show_shipping_address && $this->request->server['REQUEST_METHOD'] == 'POST' && empty($this->request->post['shipping_address_same'])) {
            $address = $this->prepare_address($this->get_value('shipping_address','zone_id'), $this->get_value('shipping_address','country_id'));
        
            $form_address_id = isset($this->request->post['shipping_address']['address_id']) ? $this->request->post['shipping_address']['address_id'] : -1;
            $selected_address_id = isset($this->request->post['shipping_address_id']) ? $this->request->post['shipping_address_id'] : (!empty($this->data['address']['address_id']) ? $this->data['address']['address_id'] : -1);
       
            if ($selected_address_id >= 0 && $form_address_id != $selected_address_id) {
                $address_id = $selected_address_id;
            } else {
                $address_id = $form_address_id;
            }
            
            $address['address_id'] = $address_id >= 0 ? $address_id : 0;
            $address['firstname'] = $this->get_total_value('shipping_address','firstname');
            $address['lastname'] = $this->get_total_value('shipping_address','lastname');
            $address['company'] = $this->get_total_value('shipping_address','company');
            $address['company_id'] = $this->get_total_value('shipping_address','company_id');
            $address['tax_id'] = $this->get_total_value('shipping_address','tax_id');
            $address['address_1'] = $this->get_total_value('shipping_address','address_1');
            $address['address_2'] = $this->get_total_value('shipping_address','address_2');
            $address['postcode'] = $this->get_total_value('shipping_address','postcode');
            $address['city'] = $this->get_total_value('shipping_address','city');
            
            $this->simple->shipping_address = $address;
            $comment .= ' '.$this->get_total_value('shipping_address','comment');
            
            $this->simple->shipping_address_same = false;
        }
        
        $email = $this->customer->isLogged() && $this->customer->getEmail() != '' ? $this->customer->getEmail() : $this->get_value('customer','email');
        
        $telephone = $this->get_total_value('customer','telephone');
        $fax = $this->get_total_value('customer','fax');
         
        $this->simple->customer = array(
            'customer_id' => $this->customer->isLogged() && $this->customer->getId() ? $this->customer->getId() : 0,
            'customer_group_id' => $this->customer->isLogged() ? $this->customer->getCustomerGroupId() : $this->get_value('customer','customer_group_id'),
            'email' => $email,
            'password' => $this->simple->password,
            'password_confirm' => $this->simple->password_confirm,
            'firstname' => $this->customer->isLogged() ? $this->customer->getFirstName() : $this->get_total_value('customer','firstname'),
            'lastname' => $this->customer->isLogged() ? $this->customer->getLastName() : $this->get_total_value('customer','lastname'),
            'telephone' => $this->customer->isLogged() ? (!empty($telephone) && $this->customer->getTelephone() != $telephone ? $telephone : $this->customer->getTelephone()) : $telephone,
            'fax' => $this->customer->isLogged() ? (!empty($fax) && $this->customer->getFax() != $fax ? $fax : $this->customer->getFax()) : $fax,
            'newsletter' => $this->simple->subscribe
        );
        
        $this->simple->comment = $comment;
        
        $this->validate();
        
        if (!$this->error) {
            $this->save_customer_data();
        }
        
        $this->save_to_session();
    }
    
    private function save_to_session() {
        if (!$this->customer->isLogged() && !$this->error) {
            $this->session->data['guest'] = $this->simple->customer;
        }
        
        $this->session->data['comment'] = $this->simple->comment;
                
        $version = $this->simple->version;
        
        $address = $this->simple->shipping_address;
        
        if (!$this->customer->isLogged() && !$this->error) {
            $this->session->data['guest']['shipping'] = $address;
        }
        
        unset($this->session->data['shipping_address_id']);	
		unset($this->session->data['shipping_country_id']);	
		unset($this->session->data['shipping_zone_id']);	
		unset($this->session->data['shipping_postcode']);
                
        if (!empty($address['address_id'])) {
            $this->session->data['shipping_address_id'] = $address['address_id'];
        } 
        
        if (!empty($address['country_id'])) {
            $this->session->data['shipping_country_id'] = $address['country_id'];
        } else {
            $this->session->data['shipping_country_id'] = 0;
        }
        
        if (!empty($address['zone_id'])) {
            $this->session->data['shipping_zone_id'] = $address['zone_id'];
        } else {
            $this->session->data['shipping_zone_id'] = 0;
        }
        
        if (!empty($address['postcode'])) {
            $this->session->data['shipping_postcode'] = $address['postcode'];
		}
        
        if ($version == 152 && !empty($this->session->data['guest']['shipping']) && is_array($this->session->data['guest']['shipping'])) {
            $clear = true;
            foreach ($this->session->data['guest']['shipping'] as $key => $value) {
                if ($value) {
                    $clear = false;
                    break;
                }
            }
            if ($clear) {
                unset($this->session->data['guest']['shipping']);
            }
        }
       
        if ($this->session->data['shipping_country_id'] || $this->session->data['shipping_zone_id']) {
            if ($version > 151) {
                $this->tax->setShippingAddress($this->session->data['shipping_country_id'], $this->session->data['shipping_zone_id']);
            } else {
                $this->tax->setZone($this->session->data['shipping_country_id'], $this->session->data['shipping_zone_id']);
            	
				$this->session->data['country_id'] = $this->session->data['shipping_country_id'];
				$this->session->data['zone_id'] = $this->session->data['shipping_zone_id'];
                if (isset($this->session->data['shipping_postcode'])) {
				    $this->session->data['postcode'] = $this->session->data['shipping_postcode'];
                }
            }
        } else {
            unset($this->session->data['shipping_country_id']);
            unset($this->session->data['shipping_zone_id']);
            
            if ($version > 151) {
                $this->tax->setShippingAddress(0, 0);
            } else {
                $this->tax->setZone(0, 0);
            }
                
            if (!$this->customer->isLogged() && $this->config->get('config_tax_default') == 'shipping') {
                if ($version > 151) {
                    $this->tax->setShippingAddress($this->config->get('config_country_id'), $this->config->get('config_zone_id'));
                } else {
                    $this->tax->setZone($this->config->get('config_country_id'), $this->config->get('config_zone_id'));
                }
            }
        }
        
        if (!empty($address['postcode'])) {
            $this->session->data['shipping_postcode'] = $address['postcode'];
        }
        
        $address = $this->simple->payment_address;
        
        if (!$this->customer->isLogged() && !$this->error) {
            $this->session->data['guest']['payment'] = $address;
        }
        
        unset($this->session->data['payment_address_id']);	
		unset($this->session->data['payment_country_id']);	
		unset($this->session->data['payment_zone_id']);	
        
        if (!empty($address['address_id'])) {
            $this->session->data['payment_address_id'] = $address['address_id'];
        } 
        
        if (!empty($address['country_id'])) {
            $this->session->data['payment_country_id'] = $address['country_id'];
		} else {
            $this->session->data['payment_country_id'] = 0;
		}
        
        if (!empty($address['zone_id'])) {
            $this->session->data['payment_zone_id'] = $address['zone_id'];
        } else {
            $this->session->data['payment_zone_id'] = 0;
        }
        
        if ($version == 152 && !empty($this->session->data['guest']['payment']) && is_array($this->session->data['guest']['payment'])) {
            $clear = true;
            foreach ($this->session->data['guest']['payment'] as $key => $value) {
                if ($value) {
                    $clear = false;
                    break;
                }
            }
            if ($clear) {
                unset($this->session->data['guest']['payment']);
            }
        }
        
        if ($version > 151) {
            if ($this->session->data['payment_country_id'] || $this->session->data['payment_zone_id']) {
                $this->tax->setPaymentAddress($this->session->data['payment_country_id'], $this->session->data['payment_zone_id']);
            } else {
                unset($this->session->data['payment_country_id']);
                unset($this->session->data['payment_zone_id']);
                
                $this->tax->setPaymentAddress(0, 0);
            
                if (!$this->customer->isLogged() && $this->config->get('config_tax_default') == 'payment') {
                    $this->tax->setPaymentAddress($this->config->get('config_country_id'), $this->config->get('config_zone_id'));
                }
            }
        }
    }
        
    private function prepare_address($zone_id, $country_id = 0) {
        $this->load->model('localisation/zone');
        $this->load->model('localisation/country');
    
        if ($zone_id) {
            $zone = $this->model_localisation_zone->getZone($zone_id);
            if ($zone) {
                if ($zone['country_id'] != $country_id) {
                    $zone_id = 0;
                } else {
                    $country = $this->model_localisation_country->getCountry($zone['country_id']);
                    
                    if ($country) {
                        return array(
                            'address_id'     => 0,
            				'firstname'      => '',
            				'lastname'       => '',
            				'company'        => '',
            				'company_id'     => '',
            				'tax_id'         => '',
            				'address_1'      => '',
            				'address_2'      => '',
            				'postcode'       => '',
            				'city'           => '',
            				'zone_id'        => $zone['zone_id'],
            				'zone'           => $zone['name'],
            				'zone_code'      => $zone['code'],
            				'country_id'     => $zone['country_id'],
            				'country'        => $country['name'],	
            				'iso_code_2'     => $country['iso_code_2'],
            				'iso_code_3'     => $country['iso_code_3'],
            				'address_format' => $country['address_format']
                        );
                    }
                }
            }
        } 
        if ($country_id && !$zone_id) {
            $country = $this->model_localisation_country->getCountry($country_id);
                
            if ($country) {
                return array(
                    'address_id'     => 0,
    				'firstname'      => '',
    				'lastname'       => '',
    				'company'        => '',
    				'company_id'     => '',
    				'tax_id'         => '',
    				'address_1'      => '',
    				'address_2'      => '',
    				'postcode'       => '',
    				'city'           => '',
    				'zone_id'        => $zone_id,
    				'zone'           => '',
    				'zone_code'      => '',
    				'country_id'     => $country['country_id'],
    				'country'        => $country['name'],	
    				'iso_code_2'     => $country['iso_code_2'],
    				'iso_code_3'     => $country['iso_code_3'],
    				'address_format' => $country['address_format']
                );
            }
        }
        
        return array(
            'address_id'     => 0,
    		'firstname'      => '',
    		'lastname'       => '',
    		'company'        => '',
    		'company_id'     => '',
			'tax_id'         => '',
			'address_1'      => '',
    		'address_2'      => '',
    		'postcode'       => '',
    		'city'           => '',
    		'zone_id'        => 0,
    		'zone'           => '',
    		'zone_code'      => '',
    		'country_id'     => 0,
    		'country'        => '',	
    		'iso_code_2'     => '',
    		'iso_code_3'     => '',
    		'address_format' => ''
        );
    }
    
    private function prepare_fields($set, $fields) {
        $reload = $this->config->get('simple_fields_for_reload');
        $reload = !empty($reload) ? $reload : 'main_country_id,main_zone_id,main_postcode';
        $reload = explode(',', $reload);
        
        if (empty($this->data[$set])) {
            $this->data[$set] = array();
            
            foreach ($fields as $field_name => $field_settings) {
                $value = $this->get_field_value($field_settings, $set);
                $values = $this->get_field_values($field_settings, $set);
                
                if ($field_settings['id'] == 'main_zone_id') {
                    if (!array_key_exists($value, $values)) {
                        $value = '';
                    }
                    if (count($values) == 1 && array_key_exists(0, $values)) {
                        $value = 0;
                    }
                }
                
                $this->data[$set][$field_name] = array(
                    'id' => $field_settings['id'],
                    'label' => !empty($field_settings['label'][$this->get_language_code()]) ? html_entity_decode($field_settings['label'][$this->get_language_code()]) : $field_settings['id'],
                    'required' => ($field_settings['validation_type'] > 0 ? true : false),
                    'type' => $field_settings['type'],
                    'value' => $value,
                    'values' => $values,
                    'error' => $this->validate_field($field_settings, $value, $values, $set),
                    'save_to' => $field_settings['save_to'],
                    'save_label' => !empty($field_settings['save_label']) ? $field_settings['save_label'] : false,
                    'mask' => !empty($field_settings['mask']) ? $field_settings['mask'] : '',
                    'placeholder' => !empty($field_settings['placeholder'][$this->get_language_code()]) ? $field_settings['placeholder'][$this->get_language_code()] : '',
                    'autocomplete' => !empty($field_settings['autocomplete']) ? true : false,
                    'reload' => in_array($field_settings['id'], $reload) ? true : false,
                    'date_min' => isset($field_settings['date_min']) ? $field_settings['date_min'] : '',
                    'date_max' => isset($field_settings['date_max']) ? $field_settings['date_max'] : '',
                    'date_start' => isset($field_settings['date_start']) ? $field_settings['date_start'] : '',
                    'date_end' => isset($field_settings['date_end']) ? $field_settings['date_end'] : '',
                    'date_only_business' => isset($field_settings['date_only_business']) ? $field_settings['date_only_business'] : ''  
                );
            }
        }
    }
    
    private function filter_fields($sets, $display_set, $set) {
        $shipping_method = $this->simple->shipping_method;
        $payment_method = $this->simple->payment_method;
        
        if (!empty($shipping_method['code'])) {
            $shipping_method_code_full = $shipping_method['code'];
            $tmp = explode('.', $shipping_method['code']);
            $shipping_method_code = is_array($tmp) ? $tmp[0] : false;
        }
        
        if (!empty($payment_method['code'])) {
            $payment_method_code = $payment_method['code'];
        }
        
        $current_set = $sets['default'];
        if (!empty($shipping_method_code) && !empty($sets['shipping'][$shipping_method_code])) {
            $current_set = $sets['shipping'][$shipping_method_code];
        }
        
        if (!empty($shipping_method_code_full) && !empty($sets['shipping'][$shipping_method_code_full])) {
            $current_set = $sets['shipping'][$shipping_method_code_full];
        }
        
        if (!empty($payment_method_code) && !empty($sets['payment'][$payment_method_code])) {
            $current_set = $sets['payment'][$payment_method_code];
        }
        
        $this->data[$display_set] = array();
        
        $fields = explode(',',$current_set);
        if (is_array($fields) && count($fields) > 0) {
            foreach ($fields as $id) {
                if (!empty($this->data[$set][$id])) {
                    $this->data[$display_set][$id] = $this->data[$set][$id];
                }
            }          
        }
        if (!empty($this->data[$set]) && is_array($this->data[$set])) {
            foreach ($this->data[$set] as $id => $settings) {
                if (strpos($id, 'main_') == 0 && !array_key_exists($id, $this->data[$display_set])) {
                    $tmp = $settings;
                    $tmp['type'] = 'hidden';
                    $this->data[$display_set][$id] = $tmp;
                }
            }  
        }
    }
    
    private function load_fields() {
        $simple_customer_fields_settings = $this->config->get('simple_customer_fields_settings');
        $simple_customer_fields_settings = is_array($simple_customer_fields_settings) ? $simple_customer_fields_settings : array();
        
        $simple_custom_fields_settings = $this->config->get('simple_custom_fields_settings');
        $simple_custom_fields_settings = is_array($simple_custom_fields_settings) ? $simple_custom_fields_settings : array();
        
        $customer_fields_settings = $simple_customer_fields_settings + $simple_custom_fields_settings;
            
        $this->prepare_fields('customer_fields', $customer_fields_settings);     
        
        $simple_company_fields_settings = $this->config->get('simple_company_fields_settings');
        $simple_company_fields_settings = is_array($simple_company_fields_settings) ? $simple_company_fields_settings : array();
        
        $this->prepare_fields('company_fields', $simple_company_fields_settings);     
        
        $simple_shipping_address_fields_settings = array();
        
        $shipping_address_fields = array('main_firstname','main_lastname','main_company','main_company_id','main_tax_id','main_address_1','main_address_2','main_city','main_postcode','main_zone_id','main_country_id');
        foreach ($customer_fields_settings as $settings) {
            if (in_array($settings['id'], $shipping_address_fields)) {
                $simple_shipping_address_fields_settings[$settings['id']] = $settings;
            }
        }
        
        $this->prepare_fields('shipping_address_fields', $simple_shipping_address_fields_settings + $simple_custom_fields_settings);       
    }
    
    private function load_fields_and_filter() {
        $this->set_register_value();
        $this->set_subscribe_value();
        $this->set_customer_type_value();
        $this->set_password_value();
        
        $this->load_fields();
        
        $this->filter_fields($this->config->get('simple_customer_fields_set'),'display_customer_fields','customer_fields');
        $this->filter_fields($this->config->get('simple_company_fields_set'),'display_company_fields','company_fields');
        $this->filter_fields($this->config->get('simple_shipping_address_fields_set'),'display_shipping_address_fields','shipping_address_fields');
    
        $this->simple->payment_address_fields = $this->data['display_customer_fields'];
        $this->simple->shipping_address_fields = $this->data['display_shipping_address_fields'];    
    }
    
    private function get_language_code() {
        if (empty($this->language_code)) {
            $this->language_code = str_replace('-', '_', strtolower($this->config->get('config_language')));
        }
        return $this->language_code;
    }
    
    private function load_value($from, $address_id, $id) {
        
        $value = '';
        if ($this->customer->isLogged()) {
            $customer_fields = array('main_firstname','main_lastname','main_customer_group_id','main_email','main_telephone','main_fax');
                
            $id_c = str_replace('main_', '', $id);
            if ($address_id && isset($this->data['addresses'][$address_id][$id_c])) {
                $value = $this->data['addresses'][$address_id][$id_c];
            } elseif (in_array($id, $customer_fields)) {
                if ($id == 'main_firstname') {
                    $value = $this->customer->getFirstName();
                } elseif ($id == 'main_lastname') {
                    $value = $this->customer->getLastName();
                } elseif ($id == 'main_customer_group_id') {
                    $value = $this->customer->getCustomerGroupId();
                } elseif ($id == 'main_email') {
                    $value = $this->customer->getEmail();
                } elseif ($id == 'main_telephone') {
                    $value = $this->customer->getTelephone();
                } elseif ($id == 'main_fax') {
                    $value = $this->customer->getFax();
                }
            } else {
                $this->load_custom_data($address_id);
                
                if (isset($this->data['custom_customer_data'][$id])) {
                    $value = $this->data['custom_customer_data'][$id];
                } elseif (isset($this->data['custom_address_data'][$address_id][$id])) {
                    $value = $this->data['custom_address_data'][$address_id][$id];
                }
            }
        } else {
            if (isset($this->session->data['simple'][$from][$id])) {
                $value = $this->session->data['simple'][$from][$id];
            } elseif (isset($this->cookies[$from.'_'.$id])) {
                $value = $this->cookies[$from.'_'.$id];
            }
        }
        return $value;
    }
    
    private function get_field_value($fields_settings, $set) {
        $this->load->model('tool/simplegeo');
        $id = $fields_settings['id'];
        
        if ($set == 'customer_fields' || $set == 'company_fields') {
            $from = 'customer';
            $address_id_name = 'customer_address_id';
        } elseif ($set == 'shipping_address_fields') {
            $from = 'shipping_address';
            $address_id_name = 'shipping_address_id';
        }
        
        $load_from_model = false;
        
        $form_address_id = isset($this->request->post[$from]['address_id']) ? $this->request->post[$from]['address_id'] : -1;
        $selected_address_id = isset($this->request->post[$address_id_name]) ? $this->request->post[$address_id_name] : (!empty($this->data['address']['address_id']) ? $this->data['address']['address_id'] : -1);
        
        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            if ($form_address_id >= 0 && $selected_address_id >= 0 && $form_address_id != $selected_address_id) {
                $load_from_model = true;
            }
        } elseif ($this->request->server['REQUEST_METHOD'] == 'GET') {
            if ($this->customer->isLogged() || isset($this->session->data['simple'][$from][$id]) || isset($this->cookies[$from.'_'.$id])) {
                $load_from_model = true;
            }
        }
        
        $value = '';
        if ($this->request->server['REQUEST_METHOD'] == 'POST' && !$load_from_model && isset($this->request->post[$from][$fields_settings['id']])) {
            $value = trim($this->request->post[$from][$fields_settings['id']]);
            $this->session->data['simple'][$from][$fields_settings['id']] = $value;
            $this->cookies[$from.'_'.$fields_settings['id']] = $value;
        } elseif ($load_from_model) { 
            $value = $this->load_value($from,$selected_address_id,$fields_settings['id']);
        } else {
            if (!empty($fields_settings['init_geoip']) && $geo = $this->model_tool_simplegeo->getGeoIp()) {
                if ($fields_settings['id'] == 'main_country_id' && !empty($geo['country_id'])) {
                    $value = $geo['country_id'];
                }
                
                if ($fields_settings['id'] == 'main_zone_id' && !empty($geo['zone_id'])) {
                    $value = $geo['zone_id'];
                }
                
                if ($fields_settings['id'] == 'main_city' && !empty($geo['city'])) {
                    $value = $geo['city'];
                }
                
                if ($fields_settings['id'] == 'main_postcode' && !empty($geo['postcode'])) {
                    $value = $geo['postcode'];
                }
            }
            
            $value = empty($value) && !empty($fields_settings['init']) ? $fields_settings['init'] : $value;
        }
        
        if ($fields_settings['id'] == 'main_customer_group_id' && $value === '') {
            $value = $this->config->get('config_customer_group_id');
        }
        
        return $value;
    }
    
    private function get_field_values($fields_settings, $set) {
        $return_values = array();
        if ($fields_settings['type'] == 'select' || $fields_settings['type'] == 'radio') {
            if ($fields_settings['values'] == 'countries') {
                $this->load->model('localisation/country');
                $values = $this->model_localisation_country->getCountries();
                foreach ($values as $value) {
                    $return_values[$value['country_id']] = $value['name'];
                }
            } elseif ($fields_settings['values'] == 'zones') {
                $this->load->model('localisation/zone');
                $values = $this->model_localisation_zone->getZonesByCountryId(!empty($this->data[$set]['main_country_id']['value']) ? $this->data[$set]['main_country_id']['value'] : 0);
                foreach ($values as $value) {
                    $return_values[$value['zone_id']] = $value['name'];
                }
                if (empty($return_values)) {
        		  	$return_values[0] = $this->language->get('text_none');
        		}
            } elseif ($fields_settings['values'] == 'groups') {
                $file  = DIR_APPLICATION . 'model/account/customer_group.php';
    		
                if (file_exists($file)) {
                    $this->load->model('account/customer_group');
                
                    if (method_exists($this->model_account_customer_group,'getCustomerGroups')) {
                        $customer_groups = $this->model_account_customer_group->getCustomerGroups();
    			
                        $config_customer_group_display = $this->config->get('config_customer_group_display');
                        
                        if (!empty($config_customer_group_display) && is_array($config_customer_group_display)) {
                			foreach ($customer_groups as $customer_group) {
                                if (in_array($customer_group['customer_group_id'], $config_customer_group_display)) {
                					$return_values[$customer_group['customer_group_id']] = $customer_group['name'];
                				}
                			}
                        } else {
                            foreach ($customer_groups as $customer_group) {
                                $return_values[$customer_group['customer_group_id']] = $customer_group['name'];
                			}
                        }
                    }
                } else {
                    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer_group");
                    foreach ($query->rows as $row) {
                        $return_values[$row['customer_group_id']] = $row['name'];
                    }
                }
            } elseif (!empty($fields_settings['values'][$this->get_language_code()])) {
                $values = $fields_settings['values'][$this->get_language_code()];
                $values = explode(';', $values);
                if (!empty($values) && count($values) > 0) {
                    foreach ($values as $value) {
                        $parts = explode('=', $value, 2);
                        if (!empty($parts) && count($parts) == 2) {
                            $return_values[$parts[0]] = $parts[1];
                        }
                    }
                }
            }
        }
        
        if ($fields_settings['type'] == 'select_from_api') {
            if (file_exists(DIR_APPLICATION . 'model/tool/simpledata.php')) {
				$this->load->model('tool/simpledata');
                if (method_exists($this->model_tool_simpledata,'select_'.$fields_settings['id'])) {
                    return $this->model_tool_simpledata->{'select_'.$fields_settings['id']}();
                }
			}            
        }
        
        return $return_values;
    }
    
    private function validate_field($fields_settings, $value, $values, $set) {
        
        if ($set == 'customer_fields' || $set == 'company_fields') {
            $from = 'customer';
        } elseif ($set == 'shipping_address_fields') {
            $from = 'shipping_address';
        }
        
        $error_msg = !empty($fields_settings['validation_error'][$this->get_language_code()]) ? $fields_settings['validation_error'][$this->get_language_code()] : 'Error';
        
        if ($fields_settings['id'] == 'main_email') {
            if (!$this->customer->isLogged()) {
                $register_customer = $this->simple->register;
                
                $email = $value;
                
                $error = false;
                
                $error_txt = array(
                    'email' => '',
                    'password' => '',
                    'password_confirm' => ''
                );
                
                if (!$register_customer && empty($email) && ($this->config->get('simple_customer_view_email') == 0 || ($this->config->get('simple_customer_view_email') == 1))) {
                    return '';
                }
                
                if ($register_customer && !empty($email) && $this->model_account_customer->getTotalCustomersByEmail($email)) {
                    $error = true;
                    $error_txt['email'] = $this->language->get('error_exists');
                }
                
                if (!preg_match($fields_settings['validation_regexp'], $email)) {
                    $error = true;
                    $error_txt['email'] = $error_msg;
                }
                
                $password_length_min = $this->config->get('simple_customer_view_password_length_min');
                $password_length_min = !empty($password_length_min) ? $password_length_min : 4;
                
                $password_length_max = $this->config->get('simple_customer_view_password_length_max');
                $password_length_max = !empty($password_length_max) ? $password_length_max : 20;
                
                $password = $this->simple->password;
                $password_confirm = $this->simple->password_confirm;
                
                if ($register_customer && !$this->config->get('simple_customer_generate_password')) {
                    if (strlen(utf8_decode($password)) < $password_length_min || strlen(utf8_decode($password)) > $password_length_max) {
                        $error = true;
                        $error_txt['password'] = sprintf($this->language->get('error_password'), $password_length_min, $password_length_max);
                    }
                    
                    if ($this->config->get('simple_customer_view_password_confirm') && $password != $password_confirm) {
                        $error = true;
                        $error_txt['password_confirm'] = $this->language->get('error_password_confirm');
                    }
                }
            
                return $error ? $error_txt : '';
            }
            
            return '';
        }
        
        if ($fields_settings['validation_type'] == 0) {
            return '';
        } elseif ($fields_settings['validation_type'] == 1) {
            if (empty($value)) {
                return $error_msg;
            }
        } elseif ($fields_settings['validation_type'] == 2) {
            if (strlen(utf8_decode($value)) < $fields_settings['validation_min'] || strlen(utf8_decode($value)) > $fields_settings['validation_max']) {
                return $error_msg;
            }
        } elseif ($fields_settings['validation_type'] == 3) {
            if (!preg_match($fields_settings['validation_regexp'], $value)) {
                return $error_msg;
            }
        } elseif ($fields_settings['validation_type'] == 4) {
            if (!array_key_exists($value, $values)) {
                return $error_msg;
            }
        } elseif ($fields_settings['validation_type'] == 5) {
            if (file_exists(DIR_APPLICATION . 'model/tool/simpledata.php')) {
				$this->load->model('tool/simpledata');
                if (method_exists($this->model_tool_simpledata,'validate_'.$fields_settings['id'])) {
                    return $this->model_tool_simpledata->{'validate_'.$fields_settings['id']}($value);
                }
			}
        }
        
        return '';
    }
    
    private function get_total_value($from, $id) {
        $this->load_fields();
        $value = null;
        
        if ($from == 'customer') {
            foreach ($this->data['customer_fields'] as $field) {
                if ($field['save_to'] == $id && isset($field['value'])) {
                    $v = $field['value'];
                    if (($field['type'] == 'select' || $field['type'] == 'radio') && !empty($field['values'][$field['value']])) {
                        $v = $field['values'][$field['value']];
                    }
                    $lv = ($field['save_label'] ? $field['label'].': ' : '').$v;
                    if (!empty($v)) {
                        if (!empty($value)) {
                            $value = trim($value).' '.$lv;
                        } else {
                            $value = $lv;
                        }
                    }
                }
            }
            
            foreach ($this->data['company_fields'] as $field) {
                if ($field['save_to'] == $id && isset($field['value'])) {
                    $v = $field['value'];
                    if (($field['type'] == 'select' || $field['type'] == 'radio') && !empty($field['values'][$field['value']])) {
                        $v = $field['values'][$field['value']];
                    }
                    $lv = ($field['save_label'] ? $field['label'].': ' : '').$v;
                    if (!empty($v)) {
                        if (!empty($value)) {
                            $value = trim($value).' '.$lv;
                        } else {
                            $value = $lv;
                        }
                    }
                }
            }
        }
        
        if ($from == 'shipping_address') {
            foreach ($this->data['shipping_address_fields'] as $field) {
                if ($field['save_to'] == $id && isset($field['value'])) {
                    $v = $field['value'];
                    if (($field['type'] == 'select' || $field['type'] == 'radio') && !empty($field['values'][$field['value']])) {
                        $v = $field['values'][$field['value']];
                    }
                    $lv = ($field['save_label'] ? $field['label'].': ' : '').$v;
                    if (!empty($v)) {
                        if (!empty($value)) {
                            $value = trim($value).' '.$lv;
                        } else {
                            $value = $lv;
                        }
                    }
                }
            }
        }
        
        return isset($value) ? $value : '';
    }
    
    private function get_value($from, $id) {
        $this->load_fields();
        $value = null;
        
        if ($from == 'customer') {
            foreach ($this->data['customer_fields'] as $field) {
                if ($field['save_to'] == $id && $field['id'] == 'main_'.$id && isset($field['value'])) {
                    $value = $field['value'];
                    break;
                }
            }
        }
        
        if ($from == 'shipping_address') {
            foreach ($this->data['shipping_address_fields'] as $field) {
                if ($field['save_to'] == $id  && $field['id'] == 'main_'.$id && isset($field['value'])) {
                    $value = $field['value'];
                    break;
                }
            }
        }
        
        return isset($value) ? $value : '';
    }
    
    public function zone() {
		$output = '<option value="">' . $this->language->get('text_select') . '</option>';
		
		$this->load->model('localisation/zone');

    	$results = $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id']);
        
      	foreach ($results as $result) {
        	$output .= '<option value="' . $result['zone_id'] . '"';
	    	if (isset($this->request->get['zone_id']) && ($this->request->get['zone_id'] == $result['zone_id'])) {
	      		$output .= ' selected="selected"';
	    	}
	    	$output .= '>' . $result['name'] . '</option>';
    	} 
		
		if (!$results) {
		  	$output .= '<option value="0">' . $this->language->get('text_none') . '</option>';
		}
	
		$this->response->setOutput($output);
  	}  
    
    public function login() {
        $this->language->load('checkout/simplecheckout');
        
        $json = array();
        
        $this->data['error_login'] = '';
        $this->data['redirect'] = '';
        
        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            if ($this->customer->login($this->request->post['email'], $this->request->post['password'])) {
                unset($this->session->data['guest']);
                $this->data['redirect'] = $this->url->link('checkout/simplecheckout', '', 'SSL');
            } else {
                $this->data['error_login'] = $this->language->get('error_login');
            }
        }
        
        $this->data['text_checkout_customer'] = $this->language->get('text_checkout_customer');
        $this->data['text_checkout_customer_login'] = $this->language->get('text_checkout_customer_login');
        $this->data['text_checkout_customer_cancel'] = $this->language->get('text_checkout_customer_cancel');
        $this->data['text_forgotten'] = $this->language->get('text_forgotten');
        $this->data['entry_email'] = $this->language->get('entry_email');
        $this->data['entry_password'] = $this->language->get('entry_password');
        $this->data['button_login'] = $this->language->get('button_login');

        $this->data['action'] = $this->url->link('checkout/simplecheckout_customer/login', '', 'SSL');
        $this->data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');
        
        if (isset($this->request->post['email'])) {
            $this->data['email'] = trim($this->request->post['email']);
        } else {
            $this->data['email'] = '';
        }
                    
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/simplecheckout_login.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/checkout/simplecheckout_login.tpl';
            $this->data['template'] = $this->config->get('config_template');
        } else {
            $this->template = 'default/template/checkout/simplecheckout_login.tpl';
            $this->data['template'] = 'default';
        }
            
        $this->response->setOutput($this->render());
    }
    
    private function validate() {
        $error = false;
        
        foreach ($this->data['display_customer_fields'] as $field) {
            if ($field['error'] != '' && $field['type'] != 'hidden') {
                $error = true; 
                break;
            }
        }
        
        $simple_show_shipping_address = $this->simple->show_shipping_address;
        $shipping_address_same = $this->simple->shipping_address_same;
        
        if ($this->cart->hasShipping() && $simple_show_shipping_address && !$shipping_address_same) {
            foreach ($this->data['display_shipping_address_fields'] as $field) {
                if ($field['error'] != '' && $field['type'] != 'hidden') {
                    $error = true;
                    break;
                }
            }
        }
        
        $customer_type = $this->simple->customer_type;
        
        if ($this->config->get('simple_customer_view_customer_type') && $customer_type == 'company') {
            foreach ($this->data['display_company_fields'] as $field) {
                if ($field['error'] != '' && $field['type'] != 'hidden') {
                    $error = true;
                    break;
                }
            }
        }
        
        $this->error = $error;
        
    	return !$error;
    }
    
    public function check_email() {
        $error = '';
        
        if (!$this->customer->isLogged()) {
            $register_customer = false;
            
            if ($this->config->get('simple_customer_action_register') != 2) {
                $register_customer = $this->config->get('simple_customer_action_register') == 1;
            } elseif (isset($this->request->get['register'])) {
                $register_customer = $this->request->get['register'];
            } 
            
            if (!empty($this->request->get['email'])) {
                if ($register_customer) {
                    $this->load->model('account/customer');
                    $this->language->load('checkout/simplecheckout');
                
                    if ($this->model_account_customer->getTotalCustomersByEmail($this->request->get['email'])) {
                        $error = $this->language->get('error_exists');
                    }
                }
                
                $settings = $this->config->get('simple_customer_fields_settings');
                
                if (!empty($settings['main_email']['validation_regexp'])) {
                    $regexp = $settings['main_email']['validation_regexp'];
                    if (!preg_match($regexp, trim($this->request->get['email']))) {
                        $error = $settings['main_email']['validation_error'][$this->get_language_code()];
                    }
                }
            }
        }
        
        $this->response->setOutput($error);
    }
    
    private function save_customer_data() {
        if ($this->customer->isLogged()) {
            $customer_id = $this->customer->getId();
            
            $payment_address = $this->simple->payment_address;
            
            if (!empty($payment_address)) {
                if (!$payment_address['address_id']) {
                    $payment_address_id = $this->model_account_address->addAddress($payment_address);
                    $payment_address['address_id'] = $payment_address_id;
                    $this->simple->payment_address = $payment_address;
                } else {
                    $this->model_account_address->editAddress($payment_address['address_id'], $payment_address);
                }
                if (!isset(self::$static_data['addresses'])) {
                    self::$static_data['addresses'] = array();
                }
                self::$static_data['addresses'][$payment_address['address_id']] = $payment_address;
            }
            
            $shipping_address = $this->simple->shipping_address;
            $shipping_address_same = $this->simple->shipping_address_same;
            
            if (!$shipping_address_same) {
                if (!$shipping_address['address_id']) {
                    $shipping_address_id = $this->model_account_address->addAddress($shipping_address);
                    $shipping_address['address_id'] = $shipping_address_id;
                    $this->simple->shipping_address = $shipping_address;
                } else {
                    $this->model_account_address->editAddress($shipping_address['address_id'], $shipping_address);
                }
                if (!isset(self::$static_data['addresses'])) {
                    self::$static_data['addresses'] = array();
                }
                self::$static_data['addresses'][$shipping_address['address_id']] = $shipping_address;
            }
        } else {
            $register_customer = $this->simple->register;
            $customer = $this->simple->customer;
            $payment_address = $this->simple->payment_address;
            
            if ($register_customer && !empty($customer) && !empty($payment_address)) {
                $data = array(
                    'firstname' =>         $customer['firstname'],
                    'lastname' =>          $customer['lastname'],
                    'email' =>             $customer['email'],
                    'password' =>          $customer['password'],
                    'telephone' =>         $customer['telephone'],
                    'fax' =>               $customer['fax'],
                    'newsletter' =>        $customer['newsletter'],
                    'company' =>           $payment_address['company'],
                    'company_id' =>        $payment_address['company_id'],
                    'tax_id' =>            $payment_address['tax_id'],
                    'address_1' =>         $payment_address['address_1'],
                    'address_2' =>         $payment_address['address_2'],
                    'postcode' =>          $payment_address['postcode'],
                    'city' =>              $payment_address['city'],
                    'country_id' =>        $payment_address['country_id'],
                    'zone_id' =>           $payment_address['zone_id'],
                    'customer_group_id' => $customer['firstname']
                );
                
                if ($data['email'] == '') {
                    $this->simple->error = 'customer';
                    $this->error = true;
                    return;
                }
                
                $this->model_account_customer->addCustomer($data);
                $this->customer->login($data['email'], $data['password']);
                
                if (file_exists(DIR_APPLICATION . 'model/tool/simpledata.php')) {
                    $this->load->model('tool/simpledata');
                    if (method_exists($this->model_tool_simpledata,'saveRegistrationData')) {
                        $this->model_tool_simpledata->saveRegistrationData($this->customer->getId(), $this->request->post);
                    }
                }
                
                $customer['customer_id'] = $this->customer->getId();
                $customer['customer_group_id'] = $this->customer->getCustomerGroupId();
                $this->simple->customer = $customer;
                
                $payment_address['address_id'] = $this->customer->getAddressId();
                $this->simple->payment_address = $payment_address;
                
                if (!isset(self::$static_data['addresses'])) {
                    self::$static_data['addresses'] = array();
                }
                self::$static_data['addresses'][$payment_address['address_id']] = $payment_address;
                
                $address_same = $this->simple->shipping_address_same;
                if (!$address_same) {
                    $shipping_address = $this->simple->shipping_address;
                    
                    $shipping_address['address_id'] = $this->model_account_address->addAddress($shipping_address);
                    $this->simple->shipping_address = $shipping_address;
                    self::$static_data['addresses'][$shipping_address['address_id']] = $shipping_address;
                }
                
                $this->session->data['simple_customer_registered'] = $this->language->get('text_account_created');
            }
        }
    }
}
?>