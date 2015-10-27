/*
@author	Dmitriy Kubarev
@link	http://www.simpleopencart.com
@link	http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4811
*/

function simplecheckout_submit() {
    if (can_submit_payment_form()) {
        payment_form_submit(); 
    } else {
        $('#simple_create_order').val(1);
        simplecheckout_reload('from_submit');
    }
}

function can_submit_payment_form() {
    return $('#simplecheckout_payment_form').length && $('#simplecheckout_payment_form #payment_form_reload').length == 0 && $('#simplecheckout_payment_form .simplecheckout_overlay').length == 0 && $('.agree-warning:visible').length == 0;
}

function payment_form_submit() {
    var simplecheckout_payment_form = $('#simplecheckout_payment_form .simplecheckout-block-content');
    var gateway_link = simplecheckout_payment_form.find('div.buttons a:last').attr('href');
    var submit_button = simplecheckout_payment_form.find('div.buttons a:last,div.buttons input[type=button]:last,div.buttons input[type=submit]:last');
    var last_button = simplecheckout_payment_form.find('input[type=button]:last,input[type=submit]:last');
    var last_link = simplecheckout_payment_form.find('a:last').attr('href');
    
    var proceed_show = false;
    
    if (typeof gateway_link != 'undefined' && gateway_link != '' && gateway_link != '#') {
        location = gateway_link;
        proceed_show = true;
    } else if (submit_button.length) {
        !submit_button.attr('disabled') && submit_button.click();
        proceed_show = true;
    } else if (last_button.length) {
        !last_button.attr('disabled') && last_button.click();
        proceed_show = true;
    } else if (typeof last_link != 'undefined' && last_link != '' && last_link != '#') {
        location = last_link;
        proceed_show = true;
    } 
    
    if (proceed_show && !payment_form_visible()) {
        $('#simplecheckout_proceed_payment').show();
    } 
}

function payment_form_visible() {
    return $('#simplecheckout_payment_form .simplecheckout-block-content :visible:not(form)').length > 0;
}

function payment_form_hide() {
    if (!payment_form_visible()) {
        $('#simplecheckout_payment_form').hide();
    }
}

function block_form() {
    $('input,select,textarea','#simplecheckout_form').attr('disabled', 'disabled');
}

function overlay_block(selector) {
    var obj = $("#" + selector);
    if (obj.length > 0) {
        var blockHeight = obj.height();
        var blockWidth =  obj.width();
        var blockOffset = obj.offset();
        obj.append("<div class='simplecheckout_overlay'></div>");
        $("#" + selector + " .simplecheckout_overlay")
            .css({
                'background' : 'url(catalog/view/image/loading.gif) no-repeat center center',
                'opacity' : 0.4,
                'position': 'absolute',
                'width': blockWidth,
                'height': blockHeight,
                'z-index': 5000
            })
            .offset({top: blockOffset.top,left: blockOffset.left});
    }
}

function customer_field_changed() {
    if (payment_form_visible()) {
        $('#simplecheckout_payment_form').show();
    }
    $('#simplecheckout_button_confirm span').text($('#save_changes').text());
    var obj = $('#simplecheckout_payment_form');
    if (obj.length > 0 && obj.find('#payment_form_reload').length == 0) {
        obj.find('.simplecheckout-block-content').empty().append('<div id="payment_form_reload" style="padding:5px;height:60px;cursor:pointer;background:url(catalog/view/image/simple_update.png) no-repeat center center" onclick="simplecheckout_submit(\'from_payment_form\');">'+$('#need_save_changes').text()+'</div>');
    }
}

function overlay_simplecheckout() {
    overlay_block('simplecheckout_cart');
    overlay_block('simplecheckout_customer');
    overlay_block('simplecheckout_shipping');
    overlay_block('simplecheckout_payment');
    overlay_block('simplecheckout_payment_form');
}

function scroll_to_error() {
    if ($('.simplecheckout-warning-block').length > 0) {
        $('.simplecheckout-warning-block').parent().show();
    } 
    
    if ($('.simplecheckout-error-text').length > 0 || $('.simplecheckout-warning-block').length > 0) {
        var offset1 = $('.simplecheckout-error-text:first').prev().offset();
        offset1 = offset1 ? offset1.top : 10000;
        var offset2 = $('.simplecheckout-warning-block:first').offset();
        offset2 = offset2 ? offset2.top : 10000;
        var offset = offset1 >= offset2 ? offset2 : offset1;
        
        $('html, body').animate({ scrollTop: offset }, 'slow');
    } 
}

function make_tab() {
    if (typeof simplecheckout_reload.field !== 'undefined') {
        var fields = [];
        $('input[type=text]:visible,select:visible,textarea:visible','#simplecheckout_customer').each(function(){
            fields[fields.length] = $(this).attr('id');
        });
        
        var focus = false;
        var focus_key = '';
        for (var i=0;i<fields.length;i++) {
            if (focus) {
                focus_key = fields[i];
                break;
            }
            if (fields[i] == simplecheckout_reload.field) {
                focus = true;
            }
        }
        focus_key = focus_key ? focus_key : simplecheckout_reload.field;
        $('#'+focus_key).focus();
    }
}

function simplecheckout_reload(from) {
    var data = $('#simplecheckout_form').find('input,select,textarea').serialize();
    
    if (!data.length) {
        return;
    }
    
    $.ajax({
        url: 'index.php?route=checkout/simplecheckout',
        data: data,
        type: 'POST',
        dataType: 'text',
        beforeSend: function() {
            block_form();
            overlay_simplecheckout();
            $('#payment_form_reload').text($('#saving_changes').text());
        },
        success: function(data) {
            $('#simplecheckout_form').replaceWith(data);    
            simplecheckout_init();
            make_tab();  
            scroll_to_error(); 
            payment_form_hide();
            if (from == 'from_submit' && can_submit_payment_form() && !payment_form_visible()) {
                payment_form_submit();
            }
        }
    }); 
}

function no_weekends_or_holidays(date) {
    var noWeekend = $.datepicker.noWeekends(date);
    if (noWeekend[0]) {
        return national_days(date);
    } else {
        return noWeekend;
    }
}

function national_days(date) {
    var natDays = [
      [1, 1, 'ru'],
      [1, 7, 'ru'],
      [5, 9, 'ru']
    ];
    
    for (i = 0; i < natDays.length; i++) {
        if (date.getMonth() == natDays[i][0] - 1 && date.getDate() == natDays[i][1]) {
            return [false, natDays[i][2] + '_day'];
        }
    }
    return [true, ''];
}

function add_week_days(weekDaysToAdd) {
    var daysToAdd = 0
    var mydate = new Date()
    var day = mydate.getDay()
    weekDaysToAdd = weekDaysToAdd - (5 - day)
    if ((5 - day) < weekDaysToAdd || weekDaysToAdd == 1) {
        daysToAdd = (5 - day) + 2 + daysToAdd
    } else { // (5-day) >= weekDaysToAdd
        daysToAdd = (5 - day) + daysToAdd
    }
    while (weekDaysToAdd != 0) {
        var week = weekDaysToAdd - 5
        if (week > 0) {
            daysToAdd = 7 + daysToAdd
            weekDaysToAdd = weekDaysToAdd - 5
        } else { // week < 0
            daysToAdd = (5 + week) + daysToAdd
            weekDaysToAdd = weekDaysToAdd - (5 + week)
        }
    }

    return daysToAdd;
}

function set_datepickers() {

    //if ($.browser.msie && $.browser.version <= 7) {
    //   $('.datepicker').bgIframe();
    //}

    $('input[jdate]').each(function() {
        if (typeof($(this).datepicker) !== 'undefined') {
            if ($(this).attr('date_min')) {
                var dateMin = $(this).attr('date_min');
            } else if ($(this).attr('date_start') !== undefined) {
                var dateMin = new Date();
                dateMin.setDate(dateMin.getDate() + add_week_days($(this).attr('date_start')));
            }
            
            if ($(this).attr('date_max')) {
                var dateMax = $(this).attr('date_max');
            } else if ($(this).attr('date_end') !== undefined) {
                var dateMax = new Date();
                dateMax.setDate(dateMax.getDate() + add_week_days($(this).attr('date_end')));
            }
            
            $(this).datepicker({
                beforeShowDay: $(this).attr('date_only_business') ? no_weekends_or_holidays : null,
                minDate: dateMin ? dateMin : null,
                maxDate: dateMax ? dateMax : null,
                onSelect: function(dateText, inst) {
                    customer_field_changed(this);
                }
            });
        }
    });
}

function set_masks() {
    var masked = [];
    $('input[mask]').each(function(indx) {
        var mask = $(this).attr('mask');
        var id = $(this).attr('id');
        if (mask && id) {
            masked[id] = mask;
        }
    });
    for(var i in masked) {
        $('input[id=' + i + ']').mask(masked[i]);
    }
}

function set_placeholders() {
    $('input[placeholder]').placeholder();
}

function set_autocomplete() {
    if (typeof($('input[autocomplete]').autocomplete) !== 'undefined') {
        $('input[autocomplete]').autocomplete({
            source: function( request, response ) {
                $.ajax({
                    url: "index.php?route=account/simpleregister/geo",
                    dataType: "json",
                    data: {
                        term: request.term
                    },
                    success: function( data ) {
                        response( $.map( data, function( item ) {
                            return {
                                id: item.id,
                                label: item.full,
                                value: item.city,
                                postcode: item.postcode,
                                zone_id: item.zone_id,
                                country_id: item.country_id,
                                city: item.city
                            }
                        }));
                    }
                });
            },
            minLength: 2,
            delay: 300,
            select: function( event, ui ) {
                var name = $(this).attr('name');
                var block = name.substr(0, name.indexOf('['));
                block = block ? block : 'customer'; 
                if (ui.item) {
                    if (block == 'customer') {
                        var country = $('#customer_main_country_id').val();
                        if (country != ui.item.country_id) {
                            $('#customer_main_zone_id').load('index.php?route=account/simpleregister/zone&country_id=' + ui.item.country_id, function() {
                                ui.item.country_id && $('#customer_main_country_id').val(ui.item.country_id);
                                ui.item.zone_id && $('#customer_main_zone_id').val(ui.item.zone_id);
                                ui.item.city && $('#customer_main_city').val(ui.item.city);
                                ui.item.postcode && $('#customer_main_postcode').val(ui.item.postcode);
                                simplecheckout_reload('from_autocomplete');
                            });
                        } else {
                            ui.item.country_id && $('#customer_main_country_id').val(ui.item.country_id);
                            ui.item.zone_id && $('#customer_main_zone_id').val(ui.item.zone_id);
                            ui.item.city && $('#customer_main_city').val(ui.item.city);
                            ui.item.postcode && $('#customer_main_postcode').val(ui.item.postcode);
                            simplecheckout_reload('from_autocomplete');
                        }
                    } else if (block == 'shipping_address') {
                        var country = $('#shipping_address_main_country_id').val();
                        if (country != ui.item.country_id) {
                            $('#shipping_address_main_zone_id').load('index.php?route=account/simpleregister/zone&country_id=' + ui.item.country_id, function() {
                                ui.item.country_id && $('#shipping_address_main_country_id').val(ui.item.country_id);
                                ui.item.zone_id && $('#shipping_address_main_zone_id').val(ui.item.zone_id);
                                ui.item.city && $('#shipping_address_main_city').val(ui.item.city);
                                ui.item.postcode && $('#shipping_address_main_postcode').val(ui.item.postcode);
                                simplecheckout_reload('from_autocomplete');
                            });
                        } else {
                            ui.item.country_id && $('#shipping_address_main_country_id').val(ui.item.country_id);
                            ui.item.zone_id && $('#shipping_address_main_zone_id').val(ui.item.zone_id);
                            ui.item.city && $('#shipping_address_main_city').val(ui.item.city);
                            ui.item.postcode && $('#shipping_address_main_postcode').val(ui.item.postcode);
                            simplecheckout_reload('from_autocomplete');
                        }
                    }
                }
            }
        });
    }
}

function set_popups() {
    if (typeof($.fancybox) == 'function') {
        $('.fancybox').fancybox({
        	width: 560,
        	height: 560,
        	autoDimensions: false
        });
    }
    
    if (typeof($.colorbox) == 'function') {
        $('.colorbox').colorbox({
            width: 560,
            height: 560
        });  
    }
    
    if (typeof($.prettyPhoto) !== 'undefined') {
        $("a[rel^='prettyPhoto']").prettyPhoto({
    	   theme: 'light_square', 
    	   opacity: 0.5,
    	   social_tools: "",
    	   deeplinking: false
        });
    }
}

function simplecheckout_init() {
    set_masks();
    set_placeholders();    
    set_datepickers();    
    set_autocomplete();
    set_popups();
    payment_form_hide();
}

function simplecheckout_login() {
    $.ajax({
        url: 'index.php?route=checkout/simplecheckout_customer/login',
        data: $('#simplecheckout_login input'),
        type: 'POST',
        dataType: 'text',
        success: function(data) {
            $('#simplecheckout_login').replaceWith(data);    
        }
    });
}

function simple_login_open() {
    var parent_position = $('#simple_login_layer').parent().css('position');
    if ($('#simple_login_layer').length == 0 || parent_position == 'fixed' || parent_position == 'relative' || parent_position == 'absolute') {
        $('#simple_login_layer').remove();
        $('#simple_login').remove();
        $('body').append('<div id="simple_login_layer" onclick="simple_login_close();"></div><div id="simple_login"><div id="simple_login_header"><img style="cursor:pointer;" src="catalog/view/image/close.png" onclick="simple_login_close();"></div><div id="simple_login_content"></div></div>');
    }
    $('#simple_login').show();
    $('#simple_login_content').load('index.php?route=checkout/simplecheckout_customer/login');
    var loginHeight = $(document).height();
	var loginWidth = $(window).width();
	$('#simple_login_layer').css('height', loginHeight);
	var winH = $(window).height();
	var winW = $(window).width();
	$('#simple_login').css('top',  winH/2-$('#simple_login').height()/2);
	$('#simple_login').css('left', winW/2-$('#simple_login').width()/2);				
	$('#simple_login_layer').fadeTo(500,0.8);
	return false;
}

function simple_login_close() {
    $('#simple_login_layer').fadeOut(500, function() {
		$('#simple_login_layer').hide().css('opacity','1');
	});
    $('#simple_login').fadeOut(500, function() {
		$('#simple_login').hide();
        $('#simple_login_content').empty();
	});
}

$(function(){
    
    simplecheckout_init();
    
    $('input[reload]:not([autocomplete]),select[reload],textarea[reload]').live('change', function(){
        var from = $(this).attr('reload');
        simplecheckout_reload.field = null;
        if (from == 'from_customer') {
            simplecheckout_reload.field = $(this).attr('id');
        }
        simplecheckout_reload(from);
    });
    
    $('#simplecheckout_customer input, #simplecheckout_customer textarea').live('keydown', function(){
        customer_field_changed();
    });
    
    $('#simplecheckout_customer input[type=radio]:not([reload]),#simplecheckout_customer select:not([reload])').live('change', function(){
        customer_field_changed();
    });
    
    $('#agree').live('change', function(){
        var checked = $(this).attr('checked') ? 1 : 0;
        if (!checked) {
            $('.agree-warning').show();
        } else {
            $('.agree-warning').hide();
        }
    });
    
    $('#customer_main_email').live('change',function(){
        $(this).next().remove();
        if ($(this).parent().prev().find('.simplecheckout-required').length && $(this).val()) {
            var register = ~~$('input[name=register]:checked').val();
            $.ajax({
                url: 'index.php?route=checkout/simplecheckout_customer/check_email',
                data: { email : $(this).val(), register : register },
                type: 'GET',
                dataType: 'text',
                success: function(data) {
                    if (data) {
                        $('#customer_main_email').after('<span class="simplecheckout-error-text">'+data+'</span>');
                    }
                }
            });
        }
    });
    
    $('table.cart td.remove img,.mini-cart-info td.remove img,table.s_cart_items a.s_button_remove').live('click', function(){
        simplecheckout_reload('from_cart');
    });
});