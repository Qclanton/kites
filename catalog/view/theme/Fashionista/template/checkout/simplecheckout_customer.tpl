<div class="simplecheckout-block-heading">
    <?php echo $text_checkout_customer ?>
    <?php if ($simple_customer_view_login) { ?>
    <span class="simplecheckout-block-heading-button">
        <a href="<?php echo $default_login_link ?>" onclick="simple_login_open();return false;" id="simplecheckout_customer_login"><?php echo $text_checkout_customer_login ?></a>
    </span>
    <?php } ?>
</div>  
<div class="simplecheckout-block-content">
    <?php if ($simple_customer_registered) { ?>
        <div class="success" style="text-align:left;"><?php echo $simple_customer_registered ?></div>
    <?php } ?>
    <?php if ($text_you_will_be_registered) { ?>
        <div class="you-will-be-registered"><?php echo $text_you_will_be_registered ?></div>
    <?php } ?>
    <?php if ($simple_customer_view_address_select && !empty($addresses)) { ?>
        <div class="simplecheckout-customer-address">
        <span><?php echo $text_select_address ?>:</span>&nbsp;
        <select name='customer_address_id' id="customer_address_id" reload='from_customer'>
            <option value="0" <?php echo $customer_address_id == 0 ? 'selected="selected"' : '' ?>><?php echo $text_add_new ?></option>
            <?php foreach($addresses as $address) { ?>
                <option value="<?php echo $address['address_id'] ?>" <?php echo $customer_address_id == $address['address_id'] ? 'selected="selected"' : '' ?>><?php echo $address['firstname']; ?> <?php echo !empty($address['lastname']) ? ' '.$address['lastname'] : ''; ?><?php echo !empty($address['address_1']) ? ', '.$address['address_1'] : ''; ?><?php echo !empty($address['city']) ? ', '.$address['city'] : ''; ?></option>
            <?php } ?>
        </select>
        </div>
    <?php } ?>
    <input type="hidden" name="customer[address_id]" id="customer_address_id" value="<?php echo $customer_address_id ?>" />
    <?php
        $count_fields = 0;
        foreach ($display_customer_fields as $field) { 
            if ($field['type'] == 'hidden') { 
                continue; 
            }
            $count_fields++;
        }
        $split_fields = ceil($count_fields/2); 
    ?>
    <?php $i = 0; ?>
    <div class="simplecheckout-customer-block">
    <table class="<?php echo $simple_customer_two_column ? 'simplecheckout-customer-two-column-left' : 'simplecheckout-customer-one-column' ?>">
        <?php $email_field_exists = false; ?>
        <?php foreach ($display_customer_fields as $field) { ?>
            <?php if ($field['type'] == 'hidden') { continue; } ?>
            <?php if ($customer_logged && $field['id'] == 'main_email') { continue; } ?>
            <?php if (!$customer_logged && $field['id'] == 'main_email' && !$simple_customer_action_register &&  !$simple_customer_view_email) { continue; } ?>
            <?php if (!$customer_logged && $field['id'] == 'main_email' && $simple_customer_action_register == 2) { ?>
                <tr>
                    <td class="simplecheckout-customer-left">
                       <?php echo $entry_register; ?>
                    </td>
                    <td class="simplecheckout-customer-right">
                      <label><input type="radio" name="register" value="1" <?php echo $register == 1 ? 'checked="checked"' : ''; ?> reload="from_customer" /><?php echo $text_yes ?></label>&nbsp;
                      <label><input type="radio" name="register" value="0" <?php echo $register == 0 ? 'checked="checked"' : ''; ?> reload="from_customer" /><?php echo $text_no ?></label>
                    </td>
                </tr>
            <?php } ?>
            <?php if ($field['id'] == 'main_email') { $email_field_exists = true; } ?>
            <tr<?php echo $field['id'] == 'main_email' ? ' id="email_row"' : '' ?><?php echo $field['id'] == 'main_email' && $simple_customer_action_register == 2 && !$register && !$simple_customer_view_email ? ' style="display:none;"' : '' ?>>
                <td class="simplecheckout-customer-left">
                    <?php if ($field['required']) { ?>
                        <span class="simplecheckout-required"<?php echo ($field['id'] == 'main_email' && $simple_customer_view_email == 1 && ($simple_customer_action_register == 0 || ($simple_customer_action_register == 2 && !$register))) ? ' style="display:none"' : '' ?>>*</span>
                    <?php } ?>
                    <?php echo $field['label'] ?>
                </td>
                <td class="simplecheckout-customer-right">
                    <?php if ($field['type'] == 'text' || $field['type'] == 'date') { ?>
                        <input type="text" <?php echo !empty($field['error']) ? 'class="simplecheckout-red-border"' : '' ?> id="customer_<?php echo $field['id'] ?>" name="customer[<?php echo $field['id'] ?>]" value="<?php echo $field['value'] ?>" <?php echo !empty($field['mask']) ? ' mask="'.$field['mask'].'"' : '' ?> <?php echo !empty($field['placeholder']) ? ' placeholder="'.$field['placeholder'].'"' : '' ?><?php echo $field['autocomplete'] ? ' autocomplete="1"' : '' ?><?php echo $field['reload'] ? ' reload="from_customer"' : '' ?><?php echo $field['type'] == 'date' ? ' jdate="1"' : '' ?><?php echo !empty($field['date_min']) ? ' date_min="'.$field['date_min'].'"' : '' ?><?php echo !empty($field['date_max']) ? ' date_max="'.$field['date_max'].'"' : '' ?><?php echo !empty($field['date_start']) ? ' date_start="'.$field['date_start'].'"' : '' ?><?php echo !empty($field['date_end']) ? ' date_end="'.$field['date_end'].'"' : '' ?><?php echo !empty($field['date_only_business']) ? ' date_only_business="'.$field['date_only_business'].'"' : '' ?>>
                    <?php } ?>
                    <?php if ($field['type'] == 'textarea') { ?>
                        <textarea type="text" <?php echo !empty($field['error']) ? 'class="simplecheckout-red-border"' : '' ?> id="customer_<?php echo $field['id'] ?>" name="customer[<?php echo $field['id'] ?>]" <?php echo $field['reload'] ? 'reload="from_customer"' : '' ?><?php echo !empty($field['placeholder']) ? ' placeholder="'.$field['placeholder'].'"' : '' ?>><?php echo $field['value'] ?></textarea>
                    <?php } ?>
                    <?php if ($field['type'] == 'select') { ?>
                        <select <?php echo !empty($field['error']) ? 'class="simplecheckout-red-border"' : '' ?> id="customer_<?php echo $field['id'] ?>" name="customer[<?php echo $field['id'] ?>]" <?php if ($field['id'] == 'main_country_id') { ?>onchange="$('#customer_main_zone_id').load('index.php?route=checkout/simplecheckout_customer/zone&country_id=' + this.value);"<?php } ?> <?php echo $field['reload'] ? 'reload="from_customer"' : '' ?>>
                            <option value=""><?php echo $text_select ?></option>
                            <?php foreach ($field['values'] as $key => $value) { ?>
                                <option value="<?php echo $key ?>" <?php if ($key == $field['value']) { ?>selected="selected"<?php } ?>><?php echo $value ?></option>
                            <?php } ?>
                        </select>
                    <?php } ?>
                    <?php if ($field['type'] == 'select_from_api') { ?>
                        <select <?php echo !empty($field['error']) ? 'class="simplecheckout-red-border"' : '' ?> id="customer_<?php echo $field['id'] ?>" name="customer[<?php echo $field['id'] ?>]" <?php echo $field['reload'] ? 'reload="from_customer"' : '' ?> >
                            <?php foreach ($field['values'] as $key => $value) { ?>
                                <option value="<?php echo $key ?>" <?php if ($key == $field['value']) { ?>selected="selected"<?php } ?>><?php echo $value ?></option>
                            <?php } ?>
                        </select>
                    <?php } ?>
                    <?php if ($field['type'] == 'radio') { ?>
                        <?php foreach ($field['values'] as $key => $value) { ?>
                            <label><input type="radio" id="customer_<?php echo $field['id'] ?>" name="customer[<?php echo $field['id'] ?>]" value="<?php echo $key ?>" <?php if ($key == $field['value']) { ?>checked="checked"<?php } ?> <?php echo $field['reload'] ? 'reload="from_customer"' : '' ?>>&nbsp;<?php echo $value ?></label><br>
                        <?php } ?>
                    <?php } ?>
                    <?php if (!empty($field['error']) && $simple_create_order) { ?>
                        <?php if ($field['id'] != 'main_email') { ?>
                        <span class="simplecheckout-error-text"><?php echo $field['error']; ?></span>
                        <?php } else { ?>
                        <span class="simplecheckout-error-text"><?php echo $field['error']['email']; ?></span>
                        <?php } ?>
                    <?php } ?>
                </td>
            </tr>
            <?php if (!$customer_logged && $field['id'] == 'main_email' && $simple_customer_action_register) { ?>
                <tr id="password_row"<?php echo ($field['id'] == 'main_email' && $simple_customer_action_register == 2 && !$register) || $simple_customer_generate_password ? ' style="display:none;"' : '' ?> <?php echo $simple_customer_generate_password ? 'autogenerate="1"' : '' ?>>
                    <td class="simplecheckout-customer-left">
                        <span class="simplecheckout-required">*</span>
                        <?php echo $entry_password ?>
                    </td>
                    <td class="simplecheckout-customer-right">
                        <input <?php echo !empty($field['error']['password']) ? 'class="simplecheckout-red-border"' : '' ?> type="password" name="password" value="<?php echo $password ?>">
                        <?php if (!empty($field['error']['password']) && $simple_create_order) { ?>
                            <span class="simplecheckout-error-text"><?php echo $field['error']['password']; ?></span>
                        <?php } ?>
                    </td>
                </tr>
                <?php if ($simple_customer_view_password_confirm) { ?>
                <tr id="confirm_password_row"<?php echo ($field['id'] == 'main_email' && $simple_customer_action_register == 2 && !$register) || $simple_customer_generate_password ? ' style="display:none;"' : '' ?> <?php echo $simple_customer_generate_password ? 'autogenerate="1"' : '' ?>>
                    <td class="simplecheckout-customer-left">
                        <span class="simplecheckout-required">*</span>
                        <?php echo $entry_password_confirm ?>
                    </td>
                    <td class="simplecheckout-customer-right">
                        <input <?php echo !empty($field['error']['password']) ? 'class="simplecheckout-red-border"' : '' ?> type="password" name="password_confirm" value="<?php echo $password_confirm ?>">
                        <?php if (!empty($field['error']['password_confirm']) && $simple_create_order) { ?>
                            <span class="simplecheckout-error-text"><?php echo $field['error']['password_confirm']; ?></span>
                        <?php } ?>
                    </td>
                </tr>
                <?php } ?>
            <?php } ?>
            <?php $i++; if ($i == $split_fields) { ?>
                </table>
                <table class="<?php echo $simple_customer_two_column ? 'simplecheckout-customer-two-column-right' : 'simplecheckout-customer-one-column' ?>">
            <?php } ?>
        <?php } ?>
        <?php if ($simple_customer_action_subscribe == 2 && $email_field_exists) { ?>
            <tr id="subscribe_row"<?php echo $simple_customer_action_register == 2 && !$register && !$simple_customer_view_email ? ' style="display:none;"' : '' ?>>
                <td class="simplecheckout-customer-left">
                   <?php echo $entry_newsletter; ?>
                </td>
                <td class="simplecheckout-customer-right">
                  <label><input type="radio" name="subscribe" value="1" <?php echo $subscribe == 1 ? 'checked="checked"' : ''; ?> /><?php echo $text_yes ?></label>&nbsp;
                  <label><input type="radio" name="subscribe" value="0" <?php echo $subscribe == 0 ? 'checked="checked"' : ''; ?> /><?php echo $text_no ?></label>
                </td>
            </tr>
        <?php } ?>
        <?php if ($simple_customer_view_customer_type) { ?>
            <tr>
                <td class="simplecheckout-customer-left">
                </td>
                <td class="simplecheckout-customer-right">
                    <label><input type="radio" name="customer_type" value="private" <?php if ($customer_type == 'private') { ?>checked="checked"<?php } ?> reload="from_customer">&nbsp;<?php echo $text_private ?></label>
                    <label><input type="radio" name="customer_type" value="company" <?php if ($customer_type == 'company') { ?>checked="checked"<?php } ?> reload="from_customer">&nbsp;<?php echo $text_company ?></label>
                </td>
            </tr>
        <?php } ?>
    </table>
    <?php foreach ($display_customer_fields as $field) { ?>
        <?php if ($field['type'] != 'hidden') { continue; } ?>
        <input type="hidden" id="customer_<?php echo $field['id'] ?>" name="customer[<?php echo $field['id'] ?>]" value="<?php echo $field['value'] ?>" >
    <?php } ?>
    </div>
</div>
<?php if ($simple_customer_view_customer_type) { ?>
<div class="simplecheckout-block-heading simplecheckout-company" <?php if ($customer_type == 'private') { ?> style="display:none"<?php } ?>>
    <?php echo $text_your_company ?>
</div>
<div class="simplecheckout-block-content simplecheckout-company" <?php if ($customer_type == 'private') { ?> style="display:none"<?php } ?>>
    <?php
        $count_fields = 0;
        foreach ($display_company_fields as $field) { 
            if ($field['type'] == 'hidden') { 
                continue; 
            }
            $count_fields++;
        }
        $split_fields = ceil($count_fields/2); 
    ?>
    <?php $i = 0; ?>
    <table class="<?php echo $simple_customer_two_column ? 'simplecheckout-customer-two-column-left' : 'simplecheckout-customer-one-column' ?>">
        <?php foreach ($display_company_fields as $field) { ?>
            <?php if ($field['type'] == 'hidden') { continue; } ?>
            <tr>
                <td class="simplecheckout-customer-left">
                    <?php if ($field['required']) { ?>
                        <span class="simplecheckout-required">*</span>
                    <?php } ?>
                    <?php echo $field['label'] ?>
                </td>
                <td class="simplecheckout-customer-right">
                    <?php if ($field['type'] == 'text' || $field['type'] == 'date') { ?>
                        <input <?php echo !empty($field['error']) ? 'class="simplecheckout-red-border"' : '' ?> type="text" id="customer_<?php echo $field['id'] ?>" name="customer[<?php echo $field['id'] ?>]" value="<?php echo $field['value'] ?>" <?php echo !empty($field['mask']) ? ' mask="'.$field['mask'].'"' : '' ?> <?php echo !empty($field['placeholder']) ? ' placeholder="'.$field['placeholder'].'"' : '' ?><?php echo $field['reload'] ? ' reload="from_customer"' : '' ?><?php echo $field['type'] == 'date' ? ' jdate="1"' : '' ?><?php echo !empty($field['date_min']) ? ' date_min="'.$field['date_min'].'"' : '' ?><?php echo !empty($field['date_max']) ? ' date_max="'.$field['date_max'].'"' : '' ?><?php echo !empty($field['date_start']) ? ' date_start="'.$field['date_start'].'"' : '' ?><?php echo !empty($field['date_end']) ? ' date_end="'.$field['date_end'].'"' : '' ?><?php echo !empty($field['date_only_business']) ? ' date_only_business="'.$field['date_only_business'].'"' : '' ?>>
                    <?php } ?>
                    <?php if ($field['type'] == 'textarea') { ?>
                        <textarea <?php echo !empty($field['error']) ? 'class="simplecheckout-red-border"' : '' ?> type="text" id="customer_<?php echo $field['id'] ?>" name="customer[<?php echo $field['id'] ?>]" <?php echo !empty($field['placeholder']) ? ' placeholder="'.$field['placeholder'].'"' : '' ?>><?php echo $field['value'] ?></textarea>
                    <?php } ?>
                    <?php if ($field['type'] == 'select') { ?>
                        <select <?php echo !empty($field['error']) ? 'class="simplecheckout-red-border"' : '' ?> id="customer_<?php echo $field['id'] ?>" name="customer[<?php echo $field['id'] ?>]">
                            <option value=""><?php echo $text_select ?></option>
                            <?php foreach ($field['values'] as $key => $value) { ?>
                                <option value="<?php echo $key ?>" <?php if ($key == $field['value']) { ?>selected="selected"<?php } ?>><?php echo $value ?></option>
                            <?php } ?>
                        </select>
                    <?php } ?>
                    <?php if ($field['type'] == 'select_from_api') { ?>
                        <select <?php echo !empty($field['error']) ? 'class="simplecheckout-red-border"' : '' ?> id="customer_<?php echo $field['id'] ?>" name="customer[<?php echo $field['id'] ?>]">
                            <?php foreach ($field['values'] as $key => $value) { ?>
                                <option value="<?php echo $key ?>" <?php if ($key == $field['value']) { ?>selected="selected"<?php } ?>><?php echo $value ?></option>
                            <?php } ?>
                        </select>
                    <?php } ?>
                    <?php if ($field['type'] == 'radio') { ?>
                        <?php foreach ($field['values'] as $key => $value) { ?>
                            <label><input type="radio" id="customer_<?php echo $field['id'] ?>" name="customer[<?php echo $field['id'] ?>]" value="<?php echo $key ?>" <?php if ($key == $field['value']) { ?>checked="checked"<?php } ?> >&nbsp;<?php echo $value ?></label><br>
                        <?php } ?>
                    <?php } ?>
                    <?php if (!empty($field['error']) && $simple_create_order) { ?>
                        <span class="simplecheckout-error-text"><?php echo $field['error']; ?></span>
                    <?php } ?>
                </td>
            </tr>
            <?php $i++; if ($i == $split_fields) { ?>
                </table>
                <table class="<?php echo $simple_customer_two_column ? 'simplecheckout-customer-two-column-right' : 'simplecheckout-customer-one-column' ?>">
            <?php } ?>
        <?php } ?>
    </table>
    <?php foreach ($display_company_fields as $field) { ?>
        <?php if ($field['type'] != 'hidden') { continue; } ?>
        <input type="hidden" id="customer_<?php echo $field['id'] ?>" name="customer[<?php echo $field['id'] ?>]" value="<?php echo $field['value'] ?>" >
    <?php } ?>
</div>
<?php } ?>
<?php if ($simple_show_shipping_address) { ?>
<div class="simplecheckout-customer-same-address">
    <label><input type="checkbox" name="shipping_address_same" id="shipping_address_same" value="1" <?php if ($shipping_address_same) { ?>checked="checked"<?php } ?> reload="from_customer">&nbsp;<?php echo $entry_address_same ?></label>
</div>
<div class="simplecheckout-block-heading simplecheckout-shipping-address" <?php if ($shipping_address_same) { ?>style="display:none;"<?php } ?>>
    <?php echo $text_checkout_shipping_address ?>
</div>  
<div class="simplecheckout-block-content simplecheckout-shipping-address" <?php if ($shipping_address_same) { ?>style="display:none;"<?php } ?>>
    <?php if ($simple_shipping_view_address_select && !empty($addresses)) { ?>
        <div class="simplecheckout-customer-address">
        <span><?php echo $text_select_address ?>:</span>&nbsp;
        <select name='shipping_address_id' id="shipping_address_id" reload='from_customer'>
            <option value="0" <?php echo $shipping_address_id == 0 ? 'selected="selected"' : '' ?>><?php echo $text_add_new ?></option>
            <?php foreach($addresses as $address) { ?>
                <option value="<?php echo $address['address_id'] ?>" <?php echo $shipping_address_id == $address['address_id'] ? 'selected="selected"' : '' ?>><?php echo $address['firstname']; ?> <?php echo !empty($address['lastname']) ? ' '.$address['lastname'] : ''; ?><?php echo !empty($address['address_1']) ? ', '.$address['address_1'] : ''; ?><?php echo !empty($address['city']) ? ', '.$address['city'] : ''; ?></option>
            <?php } ?>
        </select>
        </div>
    <?php } ?>
    <input type="hidden" name="shipping_address[address_id]" id="shipping_address_id" value="<?php echo $shipping_address_id ?>" />
    <?php
        $count_fields = 0;
        foreach ($display_shipping_address_fields as $field) { 
            if ($field['type'] == 'hidden') { 
                continue; 
            }
            $count_fields++;
        }
        $split_fields = ceil($count_fields/2); 
    ?>
    <?php $i = 0; ?>
    <div class="simplecheckout-customer-block">
    <table class="<?php echo $simple_customer_two_column ? 'simplecheckout-customer-two-column-left' : 'simplecheckout-customer-one-column' ?>">
        <?php foreach ($display_shipping_address_fields as $field) { ?>
            <?php if ($field['type'] == 'hidden') { continue; } ?>
            <tr class="simple_table_row">
                <td class="simplecheckout-customer-left">
                    <?php if ($field['required']) { ?>
                        <span class="simplecheckout-required"<?php echo ($field['id'] == 'main_email' && $simple_customer_view_email == 1 && ($simple_customer_action_register == 0 || ($simple_customer_action_register == 2 && !$register))) ? ' style="display:none"' : '' ?>>*</span>
                    <?php } ?>
                    <?php echo $field['label'] ?>
                </td>
                <td class="simplecheckout-customer-right">
                    <?php if ($field['type'] == 'text' || $field['type'] == 'date') { ?>
                        <input <?php echo !empty($field['error']) ? 'class="simplecheckout-red-border"' : '' ?> type="text" id="shipping_address_<?php echo $field['id'] ?>" name="shipping_address[<?php echo $field['id'] ?>]" value="<?php echo $field['value'] ?>" <?php echo !empty($field['mask']) ? ' mask="'.$field['mask'].'"' : '' ?> <?php echo !empty($field['placeholder']) ? ' placeholder="'.$field['placeholder'].'"' : '' ?><?php echo $field['reload'] ? ' reload="from_customer"' : '' ?><?php echo $field['autocomplete'] ? ' autocomplete="1"' : '' ?><?php echo $field['type'] == 'date' ? ' jdate="1"' : '' ?><?php echo !empty($field['date_min']) ? ' date_min="'.$field['date_min'].'"' : '' ?><?php echo !empty($field['date_max']) ? ' date_max="'.$field['date_max'].'"' : '' ?><?php echo !empty($field['date_start']) ? ' date_start="'.$field['date_start'].'"' : '' ?><?php echo !empty($field['date_end']) ? ' date_end="'.$field['date_end'].'"' : '' ?><?php echo !empty($field['date_only_business']) ? ' date_only_business="'.$field['date_only_business'].'"' : '' ?>>
                    <?php } ?>
                    <?php if ($field['type'] == 'textarea') { ?>
                        <textarea <?php echo !empty($field['error']) ? 'class="simplecheckout-red-border"' : '' ?> type="text" id="shipping_address_<?php echo $field['id'] ?>" name="shipping_address[<?php echo $field['id'] ?>]" <?php echo !empty($field['placeholder']) ? ' placeholder="'.$field['placeholder'].'"' : '' ?>><?php echo $field['value'] ?></textarea>
                    <?php } ?>
                    <?php if ($field['type'] == 'select') { ?>
                        <select <?php echo !empty($field['error']) ? 'class="simplecheckout-red-border"' : '' ?> id="shipping_address_<?php echo $field['id'] ?>" name="shipping_address[<?php echo $field['id'] ?>]" <?php if ($field['id'] == 'payment_country_id') { ?>onchange="$('#shipping_address_main_zone_id').load('index.php?route=checkout/simplecheckout_customer/zone&country_id=' + this.value);"<?php } ?> <?php echo $field['reload'] ? 'reload="from_customer"' : '' ?>>
                            <option value=""><?php echo $text_select ?></option>
                            <?php foreach ($field['values'] as $key => $value) { ?>
                                <option value="<?php echo $key ?>" <?php if ($key == $field['value']) { ?>selected="selected"<?php } ?>><?php echo $value ?></option>
                            <?php } ?>
                        </select>
                    <?php } ?>
                    <?php if ($field['type'] == 'select_from_api') { ?>
                        <select <?php echo !empty($field['error']) ? 'class="simplecheckout-red-border"' : '' ?> id="shipping_address_<?php echo $field['id'] ?>" name="shipping_address[<?php echo $field['id'] ?>]" <?php echo $field['reload'] ? 'reload="from_customer"' : '' ?>>
                            <?php foreach ($field['values'] as $key => $value) { ?>
                                <option value="<?php echo $key ?>" <?php if ($key == $field['value']) { ?>selected="selected"<?php } ?>><?php echo $value ?></option>
                            <?php } ?>
                        </select>
                    <?php } ?>
                    <?php if ($field['type'] == 'radio') { ?>
                        <?php foreach ($field['values'] as $key => $value) { ?>
                            <label><input type="radio" id="shipping_address_<?php echo $field['id'] ?>" name="shipping_address[<?php echo $field['id'] ?>]" value="<?php echo $key ?>" <?php if ($key == $field['value']) { ?>checked="checked"<?php } ?> <?php echo $field['reload'] ? 'reload="from_customer"' : '' ?>>&nbsp;<?php echo $value ?></label><br>
                        <?php } ?>
                    <?php } ?>
                    <?php if (!empty($field['error']) && $simple_create_order) { ?>
                        <span class="simplecheckout-error-text"><?php echo $field['error']; ?></span>
                    <?php } ?>
                </td>
            </tr>
            <?php $i++; if ($i == $split_fields) { ?>
                </table>
                <table class="<?php echo $simple_customer_two_column ? 'simplecheckout-customer-two-column-right' : 'simplecheckout-customer-one-column' ?>">
            <?php } ?>
        <?php } ?>
    </table>
    <?php foreach ($display_shipping_address_fields as $field) { ?>
        <?php if ($field['type'] != 'hidden') { continue; } ?>
        <input type="hidden" id="shipping_address_<?php echo $field['id'] ?>" name="shipping_address[<?php echo $field['id'] ?>]" value="<?php echo $field['value'] ?>" >
    <?php } ?>
    </div>
</div>
<?php } ?>
<?php if ($simple_debug) print_r($customer); ?>
<?php if ($simple_debug) print_r($comment); ?>