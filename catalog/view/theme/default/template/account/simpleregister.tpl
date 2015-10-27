<?php echo $header; ?>
<?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
    <h1><?php echo $heading_title; ?></h1>
    <?php if ($error_warning) { ?>
        <div class="simpleregister-warning-block"><?php echo $error_warning; ?></div>
    <?php } ?>
    <link rel="stylesheet" type="text/css" href="<?php echo $simple_aceshop ?>catalog/view/theme/<?php echo $template ?>/stylesheet/simple.css" />
    <script type="text/javascript" src="<?php echo $simple_aceshop ?>catalog/view/javascript/simpleregister.js"></script>
    <script type="text/javascript" src="<?php echo $simple_aceshop ?>catalog/view/javascript/jquery/jquery.maskedinput-1.3.min.js"></script>
    <script type="text/javascript" src="<?php echo $simple_aceshop ?>catalog/view/javascript/jquery/jquery.placeholder.min.js"></script>
    <script type="text/javascript" src="<?php echo $simple_aceshop ?>catalog/view/javascript/jquery/ui/i18n/jquery.ui.datepicker-<?php echo $language_code ?>.js"></script>

    <p class="simpleregister-have-account"><?php echo $text_account_already; ?></p>
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="simpleregister">
        <div class="simpleregister">
            <h2 class="simpleregister-title"><?php echo $text_your_details; ?></h2>
            <div class="simpleregister-block-content">
                <table class="simplecheckout-customer">
                    <?php foreach ($display_customer_fields as $field) { ?>
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
                                    <input type="text" id="<?php echo $field['id'] ?>" name="<?php echo $field['id'] ?>" value="<?php echo $field['value'] ?>" <?php echo !empty($field['mask']) ? ' mask="'.$field['mask'].'"' : '' ?> <?php echo !empty($field['placeholder']) ? ' placeholder="'.$field['placeholder'].'"' : '' ?><?php echo $field['autocomplete'] ? ' autocomplete="1"' : '' ?><?php echo $field['type'] == 'date' ? ' jdate="1"' : '' ?><?php echo !empty($field['date_min']) ? ' date_min="'.$field['date_min'].'"' : '' ?><?php echo !empty($field['date_max']) ? ' date_max="'.$field['date_max'].'"' : '' ?><?php echo !empty($field['date_start']) ? ' date_start="'.$field['date_start'].'"' : '' ?><?php echo !empty($field['date_end']) ? ' date_end="'.$field['date_end'].'"' : '' ?><?php echo !empty($field['date_only_business']) ? ' date_only_business="'.$field['date_only_business'].'"' : '' ?>>
                                <?php } ?>
                                <?php if ($field['type'] == 'textarea') { ?>
                                    <textarea type="text" id="<?php echo $field['id'] ?>" name="<?php echo $field['id'] ?>" ><?php echo $field['value'] ?></textarea>
                                <?php } ?>
                                <?php if ($field['type'] == 'select') { ?>
                                    <select id="<?php echo $field['id'] ?>" name="<?php echo $field['id'] ?>" <?php if ($field['id'] == 'main_country_id') { ?>onchange="$('#main_zone_id').load('index.php?route=account/simpleregister/zone&country_id=' + this.value);"<?php } ?>>
                                        <option value=""><?php echo $text_select ?></option>
                                        <?php foreach ($field['values'] as $key => $value) { ?>
                                            <option value="<?php echo $key ?>" <?php if ($key == $field['value']) { ?>selected="selected"<?php } ?>><?php echo $value ?></option>
                                        <?php } ?>
                                    </select>
                                <?php } ?>
                                <?php if ($field['type'] == 'select_from_api') { ?>
                                    <select id="<?php echo $field['id'] ?>" name="<?php echo $field['id'] ?>">
                                        <?php foreach ($field['values'] as $key => $value) { ?>
                                            <option value="<?php echo $key ?>" <?php if ($key == $field['value']) { ?>selected="selected"<?php } ?>><?php echo $value ?></option>
                                        <?php } ?>
                                    </select>
                                <?php } ?>
                                <?php if ($field['type'] == 'radio') { ?>
                                    <?php foreach ($field['values'] as $key => $value) { ?>
                                        <label><input type="radio" id="<?php echo $field['id'] ?>" name="<?php echo $field['id'] ?>" value="<?php echo $key ?>" <?php if ($key == $field['value']) { ?>checked="checked"<?php } ?> >&nbsp;<?php echo $value ?></label><br>
                                    <?php } ?>
                                <?php } ?>
                                <?php if (!empty($field['error'])) { ?>
                                    <span class="simplecheckout-error-text"><?php echo $field['error']; ?></span>
                                <?php } ?>
                            </td>
                        </tr>
                        <?php if ($field['id'] == 'main_email') { ?>
                            <tr <?php echo $simple_registration_generate_password ? 'style="display:none;"' : '' ?>>
                                <td class="simplecheckout-customer-left">
                                    <span class="simplecheckout-required">*</span>
                                    <?php echo $entry_password ?>:
                                </td>
                                <td class="simplecheckout-customer-right">
                                    <input type="password" name="password" value="<?php echo $password ?>">
                                    <?php if ($error_password) { ?>
                                        <span class="simplecheckout-error-text"><?php echo $error_password; ?></span>
                                    <?php } ?>
                                </td>
                            </tr>
                            <?php if ($simple_registration_password_confirm) { ?>
                            <tr <?php echo $simple_registration_generate_password ? 'style="display:none;"' : '' ?>>
                                <td class="simplecheckout-customer-left">
                                    <span class="simplecheckout-required">*</span>
                                    <?php echo $entry_password_confirm ?>:
                                </td>
                                <td class="simplecheckout-customer-right">
                                    <input type="password" name="password_confirm" value="<?php echo $password_confirm ?>">
                                    <?php if ($error_password_confirm) { ?>
                                        <span class="simplecheckout-error-text"><?php echo $error_password_confirm; ?></span>
                                    <?php } ?>
                                </td>
                            </tr>
                            <?php } ?>
                        <?php } ?>
                    <?php } ?>
                    <?php if ($simple_registration_subscribe == 2) { ?>
                        <tr>
                          <td class="simplecheckout-customer-left"><?php echo $entry_newsletter; ?></td>
                          <td class="simplecheckout-customer-right">
                            <label><input type="radio" name="subscribe" value="1" <?php if ($subscribe) { ?>checked="checked"<?php } ?> /><?php echo $text_yes; ?></label>
                            <label><input type="radio" name="subscribe" value="0" <?php if (!$subscribe) { ?>checked="checked"<?php } ?> /><?php echo $text_no; ?></label>
                        </tr>
                    <?php } ?>
                    <?php if ($simple_registration_captcha) { ?>
                        <tr>
                            <td class="simplecheckout-customer-left">
                                <span class="simplecheckout-required">*</span>
                                <?php echo $entry_captcha ?>:
                            </td>
                            <td class="simplecheckout-customer-right">
                                <input type="text" name="captcha" value="" />
                                <?php if ($error_captcha) { ?>
                                    <span class="simplecheckout-error-text"><?php echo $error_captcha; ?></span>
                                <?php } ?>
                            </td>
                        </tr>
                        <tr>
                          <td class="simplecheckout-customer-left"></td>
                          <td class="simplecheckout-customer-right"><img src="index.php?route=product/product/captcha" alt="" id="captcha" /></td>
                        </tr>
                    <?php } ?> 
                    <?php if ($simple_registration_view_customer_type) { ?>
                        <tr>
                            <td class="simplecheckout-customer-left"></td>
                            <td class="simplecheckout-customer-right">
                                <label><input type="radio" name="customer_type" value="private" <?php if ($customer_type == 'private') { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_private ?></label>
                                <label><input type="radio" name="customer_type" value="company" <?php if ($customer_type == 'company') { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_company ?></label>
                            </td>
                        </tr>
                    <?php } ?>
                </table>        
                <?php foreach ($display_customer_fields as $field) { ?>
                    <?php if ($field['type'] != 'hidden') { continue; } ?>
                    <input type="hidden" id="<?php echo $field['id'] ?>" name="<?php echo $field['id'] ?>" value="<?php echo $field['value'] ?>" >
                <?php } ?>              
            </div>
            <?php if ($simple_registration_view_customer_type && !empty($display_company_fields)) { ?>
            <h2 class="simpleregister-company" <?php echo $customer_type == 'private' ? 'style="display:none"' : ''?>><?php echo $text_company_details; ?></h2>
            <div class="simpleregister-block-content simpleregister-company" <?php echo $customer_type == 'private' ? 'style="display:none"' : ''?>>
                <table class="simplecheckout-customer">
                    <?php foreach ($display_company_fields as $field) { ?>
                        <tr>
                            <td class="simplecheckout-customer-left">
                                <?php if ($field['required']) { ?>
                                    <span class="simplecheckout-required">*</span>
                                <?php } ?>
                                <?php echo $field['label'] ?>
                            </td>
                            <td class="simplecheckout-customer-right">
                                <?php if ($field['type'] == 'text' || $field['type'] == 'date') { ?>
                                    <input type="text" id="<?php echo $field['id'] ?>" name="<?php echo $field['id'] ?>" value="<?php echo $field['value'] ?>" <?php echo !empty($field['mask']) ? ' mask="'.$field['mask'].'"' : '' ?> <?php echo !empty($field['placeholder']) ? ' placeholder="'.$field['placeholder'].'"' : '' ?><?php echo $field['autocomplete'] ? ' autocomplete="1"' : '' ?><?php echo $field['type'] == 'date' ? ' jdate="1"' : '' ?><?php echo !empty($field['date_min']) ? ' date_min="'.$field['date_min'].'"' : '' ?><?php echo !empty($field['date_max']) ? ' date_max="'.$field['date_max'].'"' : '' ?><?php echo !empty($field['date_start']) ? ' date_start="'.$field['date_start'].'"' : '' ?><?php echo !empty($field['date_end']) ? ' date_end="'.$field['date_end'].'"' : '' ?><?php echo !empty($field['date_only_business']) ? ' date_only_business="'.$field['date_only_business'].'"' : '' ?>>
                                <?php } ?>
                                <?php if ($field['type'] == 'textarea') { ?>
                                    <textarea type="text" id="<?php echo $field['id'] ?>" name="<?php echo $field['id'] ?>" ><?php echo $field['value'] ?></textarea>
                                <?php } ?>
                                <?php if ($field['type'] == 'select') { ?>
                                    <select id="<?php echo $field['id'] ?>" name="<?php echo $field['id'] ?>">
                                        <option value=""><?php echo $text_select ?></option>
                                        <?php foreach ($field['values'] as $key => $value) { ?>
                                            <option value="<?php echo $key ?>" <?php if ($key == $field['value']) { ?>selected="selected"<?php } ?>><?php echo $value ?></option>
                                        <?php } ?>
                                    </select>
                                <?php } ?>
                                <?php if ($field['type'] == 'select_from_api') { ?>
                                    <select id="<?php echo $field['id'] ?>" name="<?php echo $field['id'] ?>">
                                        <?php foreach ($field['values'] as $key => $value) { ?>
                                            <option value="<?php echo $key ?>" <?php if ($key == $field['value']) { ?>selected="selected"<?php } ?>><?php echo $value ?></option>
                                        <?php } ?>
                                    </select>
                                <?php } ?>
                                <?php if ($field['type'] == 'radio') { ?>
                                    <?php foreach ($field['values'] as $key => $value) { ?>
                                        <label><input type="radio" id="<?php echo $field['id'] ?>" name="<?php echo $field['id'] ?>" value="<?php echo $key ?>" <?php if ($key == $field['value']) { ?>checked="checked"<?php } ?> >&nbsp;<?php echo $value ?></label><br>
                                    <?php } ?>
                                <?php } ?>
                                <?php if (!empty($field['error'])) { ?>
                                    <span class="simplecheckout-error-text"><?php echo $field['error']; ?></span>
                                <?php } ?>
                            </td>
                        </tr>
                    <?php } ?>
                </table>                      
            </div>
            <?php } ?>
        </div>
        <div class="simpleregister-button-block">
            <div class="simpleregister-button-right">
                <?php if ($simple_registration_agreement_checkbox) { ?><label><input type="checkbox" name="agree" value="1" <?php if ($agree == 1) { ?>checked="checked"<?php } ?> /><?php echo $text_agree; ?></label>&nbsp;<?php } ?><a onclick="$('#simpleregister').submit();" class="simplecheckout-button"><span><?php echo $button_continue; ?></span></a>
            </div>
        </div>  
    </form>
</div>
<?php echo $content_bottom; ?>
<?php echo $footer; ?>