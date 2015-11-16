// Conevrting functions
function makePriceNumber(priceString) {
	return Number(priceString.toString().replace(' ', '').replace('р.', ''));
}

function makePriceString(priceNumber) {				
	return priceNumber.toString().split(/(?=(?:\d{3})+$)/).join(' ') + ' р.';
}
	
$(document).ready(function() {					
	// Function for product
	$.fn.Product = function(productValues) {		
		var Element = this;			
		var Product = {		
			// Fields
			getFields: function() {
				return {
					// Required
					quantity: Element.find('[data-product-entity="quantity"]'),
					unitPrice: Element.find('[data-product-entity="unit-price"]'),
					
					// Optional
					chosenOptions: Element.find('[data-product-entity="options"] .active'),
					chosenAccesories: Element.find('input[name="accessories[]"]:checked'),
					totalPrice: $('[data-product-entity="total-price"]')
				}
			},
			
		
		
			// Values
			values: {
				unitPrice: '',
				quantity: 1
			},
			
			setValues: function(values) {
				if ('unitPrice' in values) {
					this.values.unitPrice = makePriceNumber(values.unitPrice);
				}
				
				if ('quantity' in values) {
					this.values.quantity = Number(values.quantity);
				}
			},
			
			setBindedValues: function() {
				var fields = this.getFields();
				
				this.setValues({
					unitPrice: fields.unitPrice.attr('data-price'),
					quantity: fields.quantity.val()
				});
			},
			
			getValues: function() {
				return this.values;
			},
			
			
			
			
			// Calc
			calcPrice: function() {
				this.setBindedValues();
				
				var fields = this.getFields();
				var values = this.getValues();


				// Get base data
				var unitPrice = values.unitPrice;
				var quantity = values.quantity;
				var totalPrice = unitPrice*quantity;
				
				
				
				// Get additional data
				var additionalPrice = 0;
				var chosenOptions = fields.chosenOptions;

				
				if (chosenOptions.length > 0) {
					chosenOptions.each(function() { 
						additionalPrice += makePriceNumber($(this).data('price'));
					});
				}
				
				
				
				// Get data about accessories
				var accessoriesPrice = 0;
				var accessories = fields.chosenAccesories;
				
				if (accessories.length > 0) {
					accessories.each(function(index, accessory) {
						var accessoryPrice = makePriceNumber($(this).data('price'));
						var accessoryProductId = $(this).val();					
						var accessoryQuantityField = $('#accessory-quantity-' + accessoryProductId);
						var accessoryQuantity = (accessoryQuantityField.length > 0 ? accessoryQuantityField.val() : 1);

						// Additional prices
						var accessoryAdditionalPrice = 0;
						var accessoryActiveOptions = $('.options-' + accessoryProductId + ' .active');
						
						if (accessoryActiveOptions.length > 0) {
							accessoryActiveOptions.each(function() { 
								accessoryAdditionalPrice += makePriceNumber($(this).data('price'));
							});
						}
						
						// Recalculate accessory price
						accessoryPrice += accessoryAdditionalPrice;
						
						// Show recalculated price				
						$('#accessory-price-' + accessoryProductId).html(makePriceString(accessoryPrice));
						
						// Increase price of the all accessories
						accessoriesPrice += (accessoryQuantity*accessoryPrice);
					});
				}
					
					
						
				// Calculate
				unitPrice = unitPrice+additionalPrice;
				totalPrice = unitPrice*quantity+accessoriesPrice;



				// Set result
				fields.unitPrice.html(makePriceString(unitPrice));
				
				if (fields.totalPrice.length > 0) {
					fields.totalPrice.html(makePriceString(totalPrice));
				}
			},
			
			
			
			// Add to cart
			addToCart: function() {					
				var fields = this.getFields();
				
				// Add all accessories to cart
				var accessories = fields.chosenAccesories;
				
				if (accessories.length > 0) {
					accessories.each(function() { 
						var productId = $(this).val();
						
						$.ajax({
							url: 'index.php?route=checkout/cart/add',
							type: 'post',
							data: $('#accessory-quantity-' + productId + ', input[type="hidden"].accessory-' + productId + ', .options-' + productId + ' input[type="hidden"]'),
							dataType: 'json',
							success: function(response) {
								console.log(response);						
								/*
								if (response['success']) {
									// Reload cart
									$('#cart').load('index.php #cart');				
									$('html, body').animate({ scrollTop: 0 }, 'slow'); 
								}
								*/
							}
						});
					});
				}
				
				
				// Add product
				// console.log(Element.find('[data-product-entity="option"], [data-product-entity="quantity"]'));
	
				$.ajax({
					url: 'index.php?route=checkout/cart/add',
					type: 'post',
					data: Element.find('[data-product-entity="option"], [data-product-entity="quantity"]'),
					dataType: 'json',
					success: function(response) {		
						if (response['error']) {
							console.log(response);
						} 
						
						
						if (response['success']) {
							// Reload cart
							$('#cart').load('index.php #cart > *');	
							
							
							
							// Show modal "cart added"
							var cartAddedModal = $('body').find('[data-product-entity="cart-added-popup"]');
							// console.log(cartAddedModal);
							
							if (cartAddedModal.length > 0) {
								cartAddedModal.fadeIn('fast');
								
								cartAddedModal.find('.close').bind('click', function() {
									cartAddedModal.fadeOut('fast');
								});
							}

							
							
							// Close modal "fast buy"
							var closeButton = Element.find('[data-product-entity="close_button"]');
							
							if (closeButton.length > 0)	{
								closeButton.click();
							}		
							// $('html, body').animate({ scrollTop: 0 }, 'slow'); 
						}	
					}
				});
			}
		}	
		
		
		
		// Handlers
		function setHandlers() {			
			// Handler for size options
			Element.delegate('.sizes li', 'click', function(ev) {
				ev.preventDefault();
				
				// Set active
				$(this).siblings().removeClass('active');
				$(this).addClass('active');	
				
				// Set size
				var size = $(this).data('size');
				var inputField = $(this).data('input-field');
				$(inputField).val(size);
				
				// Recalculate
				Product.calcPrice();
			});
		
			
			
			
			
			// Handler of color options
			Element.delegate('.colors li', 'click', function(ev) {
				ev.preventDefault();
				
				// Set active
				$(this).siblings().removeClass('active');
				$(this).addClass('active');	
				
				// Set color
				var color = $(this).data('color');	
				var inputField = $(this).data('input-field');			
				$(inputField).val(color);
				
				// Activate necessary image
				if ($(this).parents('[data-product-entity="options"]').length > 0) {
					var colorIndex = $(this).index();
					var imageLink = $('.img_container .img_little').eq(colorIndex);
					
					if (imageLink.length > 0 && !imageLink.hasClass('active')) {
						imageLink.click();
					}
				}
				
				// Recalculate prices
				Product.calcPrice();
			});
			
			
			
			
			// Handler for little image clicks
			$('.img_container .img_little').bind('click', function() { 
				var imageIndex = $(this).index();
				var colorOption = $('[data-product-entity="options"] .colors li').eq(imageIndex);

				if (colorOption.length > 0 && !colorOption.hasClass('active')) {
					colorOption.click();
				}
			});

			
			
			
			// Add handlers for inсreace and descrease of quantity events
			$('.increase-quantity, .decrease-quantity').bind('click', function() {
				var quantityField = $(this).siblings('input[name="quantity"]');
				var quantity = Number(quantityField.val());
				var newQuantity = ($(this).hasClass('increase-quantity') ? quantity+1 : quantity-1); 
				
				// Set new quantity
				if (newQuantity > 0) {
					quantityField.val(newQuantity);
					
					Product.setValues({ 
						quantity: newQuantity
					});
				}
				
				// Recalculate price
				Product.calcPrice();	
			});
			
			$('input[name="quantity"]').bind('change', function() { 
				if ($(this).val() < 1) {
					$(this).val(1);
				}
				
				Product.calcPrice();	
			});	
			
			
		
			// Add handlers for accessories
			Element.delegate('input[name="accessories[]"]', 'change', function(ev) {	
				Product.calcPrice();	
			});
			
			
			
			
			// Add handler for button "buy"		
			$('body').delegate('#button-cart', 'click', function() {
				Product.addToCart();			
			});
			
			
			
			// Mark as initialized
			Element.data('product-handlers-setted', true);
		}
		
		
		
		
		// Set handlers
		var isHandlersSetted = (Element.data('product-handlers-setted') == true);
		
		if (!isHandlersSetted) {
			setHandlers();
		}
		
		
		
		// Do the action	
		productValues = productValues || null;
		
		if (productValues === null) {
			Product.setBindedValues();
			Product.calcPrice();							
		} else {
			Product.setValues(productValues);
			Product.calcPrice();
			Product.setBindedValues();
		}
	}
	
	
	
	var ovall= $('.second .total').html();
	$('.allpages').text(ovall);

	$('.sidebar .goods > ul > li > ul li a.active').parent().parent().show();

	$('.sidebar .goods > ul > li > a').click(function(){
		$(this).parent().find('ul:first').toggle(400);
	});

	/*
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
			
			// Set value in input
			$('#option-size').val($(this).data('size'));
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
	*/	

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
                $('.logo').css('display', 'none');
                $('header').css({
                    'position': 'fixed',
                    'width': '100%',
                    'border-bottom': '1px solid #a2c5bf',
                    'z-index': '200'
                });
                $('header .top_menu').css('padding', '10px 0');
                $('header .universal__wrapper').css('padding', '10px 30px');
            }
       } else {
          // вверх
       }
       lastScrollTop = st;
       if (st == 0) {
        $('.logo').css('display', 'inline-block');
            $('header').css({
                'position': 'relative',
                'height': 'auto',
                'border-bottom': 'none'
            });
            $('header .top_menu').css('padding', '30px 0 15px');
            $('header .universal__wrapper').css('padding', '20px 30px 10px');
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
    /*
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
	*/
	
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
