<?php

class ControllerPaymentInterkassa extends Controller {
    private $order;
    private $log;
    private static $LOG_OFF = 0;
    private static $LOG_SHORT = 1;
    private static $LOG_FULL = 2;

    public function __construct($registry) {
        parent::__construct($registry);
        $this->language->load('payment/interkassa');
    }

    protected function index() {
        $this->data['text_confirm_title'] = $this->language->get('text_confirm_title');
        $this->data['button_confirm'] = $this->language->get('button_confirm');
        $this->data['button_back'] = $this->language->get('button_back');

        $this->data['return'] = HTTPS_SERVER . 'index.php?route=checkout/success';

        if ($this->request->get['route'] != 'checkout/guest_step_3') {
            $ik_baggage_fields = 'index.php?route=checkout/payment';
        } else {
            $ik_baggage_fields = 'index.php?route=checkout/guest_step_2';
        }
        $this->data['back'] = HTTPS_SERVER . $ik_baggage_fields;

        $this->load->model('checkout/order');
        $order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);

        $ik_payment_amount = number_format($this->currency->format($order_info['total'], $this->config->get('interkassa_currency'), $this->currency->getValue($this->config->get('interkassa_currency')), FALSE), 2, '.', '');
        $ik_payment_id = $this->session->data['order_id'];
        $ik_paysystem_alias = '';

        $this->_setData(array(
            'action' => 'http://www.interkassa.com/lib/payment.php',
            //Идентификатор магазина
            //Идентификатор магазина зарегистрированного в системе «INTERKASSA». Узнать его можно в разделе «Настройки магазина».
            //Пример: 64C18529-4B94-0B5D-7405-F2752F2B716C
            'ik_shop_id' => $this->config->get('interkassa_shop_id'),
            //Сумма платежа
            //Сумма платежа, которую продавец желает получить от покупателя (с учетом валюты и курса магазина, настраивается в «Настройки магазина»). Сумма должна быть больше нуля, дробная часть отделяется точкой.
            //Пример: 1.00
            'ik_payment_amount' => $ik_payment_amount,
            //Идентификатор платежа
            //В этом поле продавец задает идентификатор покупки в соответствии со своей системой учета. Желательно использовать уникальный номер для каждого платежа, что позволит быстро получить относящуюся к нему информацию через другие интерфейсы системы Interkassa Payment Interface.
            'ik_payment_id' => $ik_payment_id,
            //Описание платежа
            //Описание товара или услуги. Формируется продавцом. Строка добавляется в назначение платежа.
            //Максимальная длина - 255 символов.
            //Пример: iPod 80Gb черный
            'ik_payment_desc' => sprintf($this->language->get('text_ik_payment_desc'), $this->session->data['order_id']),
            //Способ оплаты (пока не используется)
            //Поле позволяет заранее определить способ оплаты для покупателя. Для того, что бы покупатель мог сам выбрать способ оплаты, оставьте это поле пустым.
            //Возможные значения:
            //<ПУСТО>, webmoneyz, webmoneyu, webmoneyr, webmoneye, ukrmoneyu, ukrmoneyz, ukrmoneyr, ukrmoneye, liberty, pecunix…
            'ik_paysystem_alias' => $ik_paysystem_alias,
            //Пользовательское поле (записывается URL возврата на платежа)
            //Это поле обрабатываются сервисом Interkassa Payment Interface автоматически и передается на веб-сайт продавца после выполнения платежа.
            //Максимальная длина - 255 символов.
            //Пример: email: mail@mail.com, tel: +380441234567
            'ik_baggage_fields' => $ik_baggage_fields,
            //Электронная подпись
            //Контрольная подпись оповещения о выполнении платежа, которая используется для проверки целостности полученной информации и однозначной идентификации отправителя. Несмотря на то, что параметр является не обязательным, мы рекомендуем всегда задавать его для повышения безопасности и сведения к минимуму возможности подделки данных платежа злоумышленником.
            'ik_sign_hash' => strtoupper(md5($this->config->get('interkassa_shop_id') . ':' .
                    $ik_payment_amount . ':' .
                    $ik_payment_id . ':' .
                    $ik_paysystem_alias . ':' .
                    $ik_baggage_fields . ':' .
                    $this->config->get('interkassa_sign_hash'))),
            'ik_success_url' => HTTPS_SERVER . 'index.php?route=payment/interkassa/success',
            'ik_success_method' => 'POST',
            'ik_fail_url' => HTTPS_SERVER . 'index.php?route=payment/interkassa/fail',
            'ik_fail_method' => 'POST',
            'ik_status_url' => HTTPS_SERVER . 'index.php?route=payment/interkassa/status',
            'ik_status_method' => 'POST',
        ));

        $this->id = 'payment';

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/interkassa.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/payment/interkassa.tpl';
        } else {
            $this->template = 'default/template/payment/interkassa.tpl';
        }

        $this->render();
    }

    public function status() {
        $this->logWrite('StatusURL: ', self::$LOG_FULL);
        $this->logWrite('  POST:' . var_export($this->request->post, true), self::$LOG_FULL);
        $this->logWrite('  GET:' . var_export($this->request->get, true), self::$LOG_FULL);

        if (!$this->validate()) {
            return;
        }

        if ($this->request->post['ik_payment_state'] == 'success') {
            $this->model_checkout_order->confirm($this->order['order_id'],
                $this->config->get('interkassa_order_status_id'),
                sprintf($this->language->get('text_comment'),
                    $this->request->post['ik_paysystem_alias'],
                    $this->request->post['ik_payment_amount'],
                    $this->request->post['ik_trans_id']
                ));
        }

        $this->sendOk();
    }

    public function success() {
        $this->logWrite('SuccessURL', self::$LOG_FULL);
        $this->logWrite('  POST:' . var_export($this->request->post, true), self::$LOG_FULL);
        $this->logWrite('  GET:' . var_export($this->request->get, true), self::$LOG_FULL);

        if ($this->validate()) {
            $this->redirect(HTTPS_SERVER . 'index.php?route=checkout/success');
        } else {
            if (isset($this->request->post['ik_baggage_fields'])) {
                $this->redirect(HTTPS_SERVER . $this->request->post['ik_baggage_fields']);
            } else {
                $this->redirect(HTTPS_SERVER . 'index.php?route=checkout/payment');
            }
        }
        return true;
    }

    public function fail() {
        $this->logWrite('FailURL', self::$LOG_FULL);
        $this->logWrite('  POST:' . var_export($this->request->post, true), self::$LOG_FULL);
        $this->logWrite('  GET:' . var_export($this->request->get, true), self::$LOG_FULL);
        $this->redirect(HTTPS_SERVER . $this->request->post['ik_baggage_fields']);
        return true;
    }

    private function validate() {
        $this->load->model('checkout/order');

        if ($this->request->server['REQUEST_METHOD'] != 'POST') {
            $this->sendForbidden($this->language->get('text_error_post'));
            return false;
        }
        ;

        $ik_sign_hash_string =
                $this->config->get('interkassa_shop_id') . ':' .
                        $this->request->post['ik_payment_amount'] . ':' .
                        $this->request->post['ik_payment_id'] . ':' .
                        $this->request->post['ik_paysystem_alias'] . ':' .
                        $this->request->post['ik_baggage_fields'] . ':' .
                        $this->request->post['ik_payment_state'] . ':' .
                        $this->request->post['ik_trans_id'] . ':' .
                        $this->request->post['ik_currency_exch'] . ':' .
                        $this->request->post['ik_fees_payer'] . ':' .
                        $this->config->get('interkassa_sign_hash');
        $ik_sign_hash = strtoupper(md5($ik_sign_hash_string));

        if (strtoupper($this->request->post['ik_sign_hash']) != $ik_sign_hash) {
            $this->sendForbidden($this->language->get('text_error_ik_sign_hash'));

            $this->logWrite($ik_sign_hash . '=md5(' . $ik_sign_hash_string . ')', self::$LOG_SHORT);

            return false;
        }
        ;

        $this->order = $this->model_checkout_order->getOrder($this->request->post['ik_payment_id']);

        if (!$this->order) {
            $this->sendForbidden(sprintf($this->language->get('text_error_order_not_found'), $this->request->post['ik_payment_id']));
            return false;
        }

        return true;
    }

    private function sendForbidden($error) {
        $this->logWrite('ERROR: ' . $error, self::$LOG_SHORT);

        header('HTTP/1.1 403 Forbidden');

        echo "<html>
                <head>
                   <title>403 Forbidden</title>
                </head>
                <body>
                    <p>$error.</p>
                </body>
        </html>";
    }

    private function sendOk() {
        $this->logWrite('OK: ' . http_build_query($this->request->post, '', ','), self::$LOG_SHORT);

        header('HTTP/1.1 200 OK');

        echo "<html><head><title>200 OK</title></head></html>";
    }

    private function _setData($values) {
        foreach ($values as $key => $value) {
            if (is_int($key)) {
                $this->data[$value] = $this->language->get($value);
            } else {
                $this->data[$key] = $value;
            }
        }
    }

    private function logWrite($message, $type) {
        switch ($this->config->get('interkassa_log')){
            case self::$LOG_OFF:
                return;
            case self::$LOG_SHORT:
                if ($type == self::$LOG_FULL){
                    return;
                }
        }

        if (!$this->log) {
            $this->log = new Log('interkassa.log');
        }
        $this->log->Write($message);
    }
}
?>