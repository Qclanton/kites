

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ");
}

		/* Ajax Cart function */
		$.AjaxCart = function()
		{
		$.ajax({
			url: 'index.php?route=checkout/cart/update',
			dataType: 'json',
			success: function(json) {
				console.log(json);
				if (json['output']) {
					$('#basket_content').html(json['output']);
				}
			},
			error: function(res) {

			}
		});            
		}

$(document).ready(function() {

	$.AjaxCart();

	var ovall= $('.second .total').html();
	$('.allpages').text(ovall);

	$('.sidebar .goods > ul > li > ul li a.active').parent().parent().show();

	$('.sidebar .goods > ul > li > a').click(function(){
		$(this).parent().find('ul:first').toggle(400);
	});

	$('.main.how_much .tri_btn.up').click(function(){
		var pr = parseInt($(this).parent().find('.mainrealprice').text()) + parseInt($('ul.sizes li a.active').attr('price'));
		var price = $(this).parent().find('.main.price_red');
		$('#quantity-opt').val(parseInt($('#quantity-opt').val()) + 1);
		var priceres = parseInt($('#quantity-opt').val()) * pr;
		price.text(numberWithCommas(priceres) +' р.');
	});
	$('.main.how_much .tri_btn.low').click(function(){
		if (parseInt($('#quantity-opt').val()) > 1) { 
			var pr = parseInt($(this).parent().find('.mainrealprice').text()) + parseInt($('ul.sizes li a.active').attr('price'));
			var price = $(this).parent().find('.main.price_red');
			$('#quantity-opt').val(parseInt($('#quantity-opt').val()) - 1); 
			var priceres = parseInt($('#quantity-opt').val()) * pr;
			price.text(numberWithCommas(priceres) +' р.');
		}
	});
	$('#quantity-opt').change(function(){
			var pr = parseInt($(this).parent().find('.mainrealprice').text()) + parseInt($('ul.sizes li a.active').attr('price'));
			var price = $(this).parent().find('.main.price_red');
			var priceres = parseInt($('#quantity-opt').val()) * pr;
			price.text(numberWithCommas(priceres) +' р.');
	});

	$('.main.line ul.sizes li a').click(function(e){
		e.preventDefault();
		if ($(this).hasClass('active')) {

		} else {
			$('.main.line ul.sizes li a').removeClass('active');
			$(this).addClass('active');
			var price = $('.main.how_much > .main.price_red');
			var pr = parseInt($('.mainrealprice').text()) + parseInt($('.main.line ul.sizes li a.active').attr('price'));
			var priceres = parseInt($('#quantity-opt').val()) * pr;
			price.text(numberWithCommas(priceres) +' р.');
		}
	});

	$('.accessoryblock .acheck').click(function(){
		$(this).parent().find('.red').toggle();
		$(this).parent().find('.old').toggle();
		$(this).parent().find('.how_much').toggle();
		$(this).parent().find('.aoptions').toggle();
	});

        $('a.korzinalink').hover(function(){
		$('#basket_content').show(200);
	}, function(){
		$('#basket_content').hide(200);
	});
			

    $('#main_column_st .product-image .image').hover(function(){
    	
    	$(this).append(
    		$('<a></a>')
    		.addClass('magnify fancybox')
    		.attr(
    			{
    				href : $(this).find('a').attr('href'),
    				title : $(this).find('a').attr('title'),
    				rel : "fancybox"
    			}
    		)
    	);
    	
    	$(this).find('.magnify').fadeIn();
    	$('.fancybox').fancybox({cyclic: true});
    	
    }, function(){
    	$(this).find('.magnify').fadeOut('fast', function(){
    		$(this).remove()
    	});
    })

    // TABS
    $('#tab1, #tab2').click(function(e) {
        var tab = e.target;
        if (tab.className != 'active') {
            tab.className = 'active';
            if (tab.id == 'tab1') {
                $('#tab2').removeClass('active');
                $('.select_block_tab2').removeClass('active');
                $('.select_block_tab1').addClass('active');
            } else {
                $('#tab1').removeClass('active');
                $('.select_block_tab1').removeClass('active');
                $('.select_block_tab2').addClass('active');
            }
        }
    });

    // SCROLL HEADER
    var lastScrollTop = 0;
    $(document).scroll(function(event){
       var st = $(this).scrollTop();
       if (st > lastScrollTop){
           //вниз
           if (st >= 115) {
                $('#logo').css('display', 'none');
                $('header').css({
                    'position': 'fixed',
                    'height': '60px'
                });
                $('header .info').css('top', '10px');
                $('header .person_nav').css('top', '20px');
            }
       } else {
          // вверх
       }
       lastScrollTop = st;
       if (st == 0) {
        console.log('UPPER');
        $('#logo').css('display', 'block');
            $('header').css({
                'position': 'relative',
                'height': '140px'
            });
            $('header .info').css('top', '0');
            $('header .person_nav').css('top', '0');
       }
    });
   
	// product image & video selection
	$('.sidebar_goods .img_container .img_little').click(function(e){
		e.preventDefault(e);
		if ($(this).hasClass('videolink')) {
			$('.sidebar_goods .img_container .img_little').removeClass('active');
			$(this).addClass('active');
			$(this).parent().css({'background-image':'url(/catalog/view/image/fffone.jpg)'});
			$(this).parent().find('div.videobox').remove();
			$(this).parent().prepend('<div class="videobox">'+$(this).parent().find('.videocontainer').html()+'</div>');
			$(this).parent().find('.videobox').css({'top': ($(this).parent().height() - $(this).parent().find('.videobox').height()) / 2 +'px'});
		} else {
			$('.sidebar_goods .img_container .img_little').removeClass('active');
			$(this).addClass('active');
			$(this).parent().find('div.videobox').remove();
			$(this).parent().css({'background-image':'url('+$(this).attr('href')+')'});
		}
	});

	// rating stars hovering
	$('.stars li.starhover').hover(function(){
		$(this).find('img').attr({'src':'img/star_red.png'});
	}, function(){
		if ($(this).find('img').hasClass('red')) { $(this).find('img').attr({'src':'img/star_red.png'}); }
		else { $(this).find('img').attr({'src':'img/star_blue.png'}); }
	});

	//obzor - get info from description and create round =obzor= link    
	var obzor = $('.select_block_tab1 a:last');
		var txt = obzor.text().toLowerCase();
		var ntxt = obzor.text();

    // SLIDER
    $("#slider").slider({
        min: 0,
        max: 1000,
        values: [0,1000],
        range: true,
        create: function(event, ui) {
            $('.ui-slider-handle').html('<div class="val_price">' + $("#slider").slider("values",0) + '</div>');
            $('.ui-slider-handle + .ui-slider-handle').html('<div class="val_price">' + $("#slider").slider("values",1) + '</div>');
        },
        stop: function(event, ui) {
            $('.ui-slider-handle').html('<div class="val_price">' + $("#slider").slider("values",0) + '</div>');
            $('.ui-slider-handle + .ui-slider-handle').html('<div class="val_price">' + $("#slider").slider("values",1) + '</div>');
        },
        slide: function(event, ui){
            $('.ui-slider-handle').html('<div class="val_price">' + $("#slider").slider("values",0) + '</div>');
            $('.ui-slider-handle + .ui-slider-handle').html('<div class="val_price">' + $("#slider").slider("values",1) + '</div>');
        }
    });

    $("input#minCost").change(function(){
        var value1=$("input#minCost").val();
        var value2=$("input#maxCost").val();
        if(parseInt(value1) > parseInt(value2)){
            value1 = value2;
            $("input#minCost").val(value1);
        }
        $("#slider").slider("values",0,value1);
    });

    $("input#maxCost").change(function(){
        var value1=$("input#minCost").val();
        var value2=$("input#maxCost").val();

        if (value2 > 1000) { value2 = 1000; $("input#maxCost").val(1000)}

        if(parseInt(value1) > parseInt(value2)){
            value2 = value1;
            $("input#maxCost").val(value2);
        }
        $("#slider").slider("values", 1, value2);
    });

    // COLORS
    $('.colors.first div').click(function(e) {
        var th = '.' + e.target.className;
        $('.colors.first div.active').removeClass('active');
        var a = $(th).css('background-color');
        var color = '10px solid ' + a;
        var after = th + '.active .triangle';
        $(th).addClass('active');
        $(after).css('border-top', color);
    });

    $('.colors.second div').click(function(e) {
        var th = '.' + e.target.className;
        $('.colors.second div.active').removeClass('active');
        var a = $(th).css('background-color');
        var color = '10px solid ' + a;
        var after = th + '.active .triangle';
        $(th).addClass('active');
        $(after).css('border-top', color);
    });

    // TABS
    $('#tab1, #tab2').click(function(e) {
        var tab = e.target;
        if (tab.className != 'active') {
            tab.className = 'active';
            if (tab.id == 'tab1') {
                $('#tab2').removeClass('active');
                $('.select_block_tab2').removeClass('active');
                $('.select_block_tab1').addClass('active');
            } else {
                $('#tab1').removeClass('active');
                $('.select_block_tab1').removeClass('active');
                $('.select_block_tab2').addClass('active');
            }
        }
    });

    // SLIDER IN MODAL WINDOW IMAGES
    $('.modal_img #prev').click(function(){change_Img(false)});
    $('.modal_img #next').click(function(){change_Img(true)});

    function change_Img(switcher) {
        var switcher = switcher;
        var zMainImg = $('.modal_img #mainImg').css('z-index');
        var zMainImg2 = $('.modal_img #mainImg2').css('z-index');

        // Which image is upper
        if (zMainImg > zMainImg2) {
            var imgLower = $('.modal_img #mainImg2');
            var imgUpper = $('.modal_img #mainImg');
            var srcImg = imgUpper.attr('src');
        }
        else {
            var imgLower = $('.modal_img #mainImg');
            var imgUpper = $('.modal_img #mainImg2');
            var srcImg = imgUpper.attr('src');
        }

        var i;

        //Getting number of image
        i = parseInt(srcImg.substr(-5, 1));

        //Previous or next image
        if (switcher) {
            if (i >= 3) {i = 1;}
            else {++i;}
        } else {
            if (i <= 1) {i = 3;}
            else {--i;}
        }

        // Setting new source of image
        srcImg = 'img/index/gallery/' + i + '.jpg';
        imgLower.attr('src', srcImg);
        imgLower.fadeIn(1);

        imgUpper.fadeOut(1000, function() {
            imgLower.css('z-index', '2');
            imgUpper.css('z-index', '1');
        });
    }

    
});
