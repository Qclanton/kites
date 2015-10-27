<?php
class ControllerModuleTwitter extends Controller {
	
	public function __construct($registry){
	
	
		parent::__construct($registry);
	}
	
	public function index() { 
		$this->load->language("module/twitter");

		$this->data["heading_title"] = $this->language->get("heading_title");
		$twitter = $this->config->get("twitter");
		
		if(!isset($twitter['mod']) || !$twitter['mod']){
			$twitter['mod'] == 'username';
		}
		
		if(!isset($twitter['keyword']) || !$twitter['keyword'] || $twitter['keyword'] == ''){
			$twitter['keyword'] = 'opencart';
		}
		if(!isset($twitter['username']) || !$twitter['username'] || $twitter['username'] == ''){
			$twitter['username'] = 'Pro_Shop';
		}
		if(!isset($twitter['count']) || !$twitter['count'] || $twitter['count'] == ''){
			$twitter['count'] = 10;
		}

		$this->data["twitter"] = $twitter;
		
		if (file_exists(DIR_TEMPLATE . $this->config->get("config_template") . "/template/module/twitter.tpl")) {
			$this->template = $this->config->get("config_template") . "/template/module/twitter.tpl";
		} else {
			$this->template = "default/template/module/twitter.tpl";
		}
		
		
	$this->render();
	}
}
?>
