/*
@author	Dmitriy Kubarev
@link	http://www.simpleopencart.com
@link	http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4811
*/ 

function noWeekendsOrHolidays(date) {
    var noWeekend = $.datepicker.noWeekends(date);
    if (noWeekend[0]) {
        return nationalDays(date);
    } else {
        return noWeekend;
    }
}

function nationalDays(date) {
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

function AddWeekDays(weekDaysToAdd) {
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
    //	$('.datepicker').bgIframe();
    //}

    $('input[jdate]').each(function() {
        
        if ($(this).attr('date_min')) {
            var dateMin = $(this).attr('date_min');
        } else if ($(this).attr('date_start') !== undefined) {
            var dateMin = new Date();
            dateMin.setDate(dateMin.getDate() + AddWeekDays($(this).attr('date_start')));
        }
        
        if ($(this).attr('date_max')) {
            var dateMax = $(this).attr('date_max');
        } else if ($(this).attr('date_end') !== undefined) {
            var dateMax = new Date();
            dateMax.setDate(dateMax.getDate() + AddWeekDays($(this).attr('date_end')));
        }
        
        $(this).datepicker({
            beforeShowDay: $(this).attr('date_only_business') ? noWeekendsOrHolidays : null,
            minDate: dateMin ? dateMin : null,
            maxDate: dateMax ? dateMax : null
        });
    });

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
                if (ui.item) {
                    var country = $('#main_country_id').val();
                    if (country != ui.item.country_id) {
                        $('#main_zone_id').load('index.php?route=account/simpleregister/zone&country_id=' + ui.item.country_id, function() {
                            ui.item.country_id && $('#main_country_id').val(ui.item.country_id);
                            ui.item.zone_id && $('#main_zone_id').val(ui.item.zone_id);
                        });
                    } else {
                        ui.item.country_id && $('#main_country_id').val(ui.item.country_id);
                        ui.item.zone_id && $('#main_zone_id').val(ui.item.zone_id);
                    }
                    ui.item.city && $('#main_city').val(ui.item.city);
                    ui.item.postcode && $('#main_postcode').val(ui.item.postcode);
                }
            }
    	});
    }
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

$(function() {
    
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
    
    $('#simpleregister input[name=customer_type]').live('change', function(){
        if ($(this).val() == 'company') {
            $('.simpleregister-company').show();
        } else {
            $('.simpleregister-company').hide();
        }
    });
    
    set_masks();
    set_placeholders();
    set_datepickers();
    set_autocomplete();
});