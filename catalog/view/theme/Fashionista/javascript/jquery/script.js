/* jQuery SelectBox Styler v1.0.1 | (c) Dimox | http://dimox.name/styling-select-boxes-using-jquery-css/ */
(function($){$.fn.selectbox=function(){$(this).each(function(){var select=$(this);if(select.prev('span.selectbox').length<1){function doSelect(){var option=select.find('option');var optionSelected=option.filter(':selected');var optionText=option.filter(':first').text();if(optionSelected.length)optionText=optionSelected.text();var ddlist='';for(i=0;i<option.length;i++){var selected='';var disabled=' class="disabled"';if(option.eq(i).is(':selected'))selected=' class="selected sel"';if(option.eq(i).is(':disabled'))selected=disabled;ddlist+='<li'+selected+'>'+option.eq(i).text()+'</li>';}var selectbox=$('<span class="selectbox" style="display:inline-block;position:relative">'+'<div class="select" style="float:left;position:relative;z-index:10000"><div class="text">'+optionText+'</div>'+'<b class="trigger"><i class="arrow"></i></b>'+'</div>'+'<div class="dropdown" style="position:absolute;z-index:9999;overflow:auto;overflow-x:hidden;list-style:none">'+'<ul>'+ddlist+'</ul>'+'</div>'+'</span>');select.before(selectbox).css({position:'absolute',top:-9999});var divSelect=selectbox.find('div.select');var divText=selectbox.find('div.text');var dropdown=selectbox.find('div.dropdown');var li=dropdown.find('li');var selectHeight=selectbox.outerHeight();if(dropdown.css('left')=='auto')dropdown.css({left:0});if(dropdown.css('top')=='auto')dropdown.css({top:selectHeight});var liHeight=li.outerHeight();var position=dropdown.css('top');dropdown.hide();divSelect.click(function(){var topOffset=selectbox.offset().top;var bottomOffset=$(window).height()-selectHeight-(topOffset-$(window).scrollTop());if(bottomOffset<0||bottomOffset<liHeight*6){dropdown.height('auto').css({top:'auto',bottom:position});if(dropdown.outerHeight()>topOffset-$(window).scrollTop()-20){dropdown.height(Math.floor((topOffset-$(window).scrollTop()-20)/liHeight)*liHeight);}}else if(bottomOffset>liHeight*6){dropdown.height('auto').css({bottom:'auto',top:position});if(dropdown.outerHeight()>bottomOffset-20){dropdown.height(Math.floor((bottomOffset-20)/liHeight)*liHeight);}}$('span.selectbox').css({zIndex:1}).removeClass('focused');selectbox.css({zIndex:2});if(dropdown.is(':hidden')){$('div.dropdown:visible').hide();dropdown.show();}else{dropdown.hide();}return false;});li.hover(function(){$(this).siblings().removeClass('selected');});var selectedText=li.filter('.selected').text();li.filter(':not(.disabled)').click(function(){var liText=$(this).text();if(selectedText!=liText){$(this).addClass('selected sel').siblings().removeClass('selected sel');option.removeAttr('selected').eq($(this).index()).attr('selected',true);selectedText=liText;divText.text(liText);select.change();}dropdown.hide();});dropdown.mouseout(function(){dropdown.find('li.sel').addClass('selected');});select.focus(function(){$('span.selectbox').removeClass('focused');selectbox.addClass('focused');}).keyup(function(){divText.text(option.filter(':selected').text());li.removeClass('selected sel').eq(option.filter(':selected').index()).addClass('selected sel');});$(document).on('click',function(e){if(!$(e.target).parents().hasClass('selectbox')){dropdown.hide().find('li.sel').addClass('selected');selectbox.removeClass('focused');}});}doSelect();select.on('refresh',function(){select.prev().remove();doSelect();})}});}})(jQuery)


$(document).ready(function() {
    // SELECT
    $('select').selectbox();

    // Checkbox checked red
    $('.inputs input').click(function() {
        if ($(this).prop('checked')) {
            var id = $(this).prop('id');
            $('label[for="' + id + '"]').css('color', '#E54B4B');
        }
        else {
            var id = $(this).prop('id');
            $('label[for="' + id + '"]').css('color', '#505050');
        }
    });

    // MODAL WINDOW - IMAGES
    $('.mins .opacity.imgs').click(function() {
        $('#modal_img_overlay').css('display', 'block');
        $('#modal_img_overlay').fadeIn(400,
            function() {
                $('#modal_img')
                    .css('display', 'block')
                    .animate({
                        opacity: 1,
                        top: "50%"
                    }, 200);
    });

    // CLOSE MODAL WINDOW
    $('#modal_img_close').click(function() {
        $('#modal_img').animate({
            opacity: 0,
            top: '45%'
        }, 200,
            function() {
                $('#modal_img').css('display', 'none');
                $('#modal_img_overlay').fadeOut(400);
                $('#modal_img_overlay').css('display', 'none');
            });
    });

    $('#modal_img_overlay').click(function() {
        $('#modal_img').animate({
            opacity: 0,
            top: '45%'
        }, 200,
            function() {
                $('#modal_img').css('display', 'none');
                $('#modal_img_overlay').fadeOut(400);
                $('#modal_img_overlay').css('display', 'none');
            });
        });

    });

    // MODAL WINDOW - REGISTRATION
    $('#register').click(function() {
        $('#modal_reg_overlay').css('display', 'block');
        $('#modal_reg_overlay').fadeIn(400,
            function() {
                $('#modal_reg')
                    .css('display', 'block')
                    .animate({
                        opacity: 1,
                        top: "50%"
                    }, 200);
    });

    // CLOSE MODAL WINDOW
    $('#modal_reg_close').click(function() {
        $('#modal_reg').animate({
            opacity: 0,
            top: '45%'
        }, 200,
            function() {
                $('#modal_reg').css('display', 'none');
                $('#modal_reg_overlay').fadeOut(400);
                $('#modal_reg_overlay').css('display', 'none');
            });
    });

    $('#modal_reg_overlay').click(function() {
        $('#modal_reg').animate({
            opacity: 0,
            top: '45%'
        }, 200,
            function() {
                $('#modal_reg').css('display', 'none');
                $('#modal_reg_overlay').fadeOut(400);
                $('#modal_reg_overlay').css('display', 'none');
            });
        });

    });

    // MODAL WINDOW - THANKS
    $('#next_btn').click(function() {
        $('#modal_thanks_overlay').css('display', 'block');
        $('#modal_thanks_overlay').fadeIn(400,
            function() {
                $('#modal_thanks')
                    .css('display', 'block')
                    .animate({
                        opacity: 1,
                        top: "50%"
                    }, 200);
    });

    // CLOSE MODAL WINDOW
    $('#modal_thanks_close').click(function() {
        $('#modal_thanks').animate({
            opacity: 0,
            top: '45%'
        }, 200,
            function() {
                $('#modal_thanks').css('display', 'none');
                $('#modal_thanks_overlay').fadeOut(400);
                $('#modal_thanks_overlay').css('display', 'none');
            });
    });

    $('#modal_thanks_overlay').click(function() {
        $('#modal_thanks').animate({
            opacity: 0,
            top: '45%'
        }, 200,
            function() {
                $('#modal_thanks').css('display', 'none');
                $('#modal_thanks_overlay').fadeOut(400);
                $('#modal_thanks_overlay').css('display', 'none');
            });
        });

    });

    // MODAL WINDOW - ENTER
    $('#enter').click(function() {
        $('#modal_enter_overlay').css('display', 'block');
        $('#modal_enter_overlay').fadeIn(400,
            function() {
                $('#modal_enter')
                    .css('display', 'block')
                    .animate({
                        opacity: 1,
                        top: "50%"
                    }, 200);
    });

    // CLOSE MODAL WINDOW
    $('#modal_enter_close').click(function() {
        $('#modal_enter').animate({
            opacity: 0,
            top: '45%'
        }, 200,
            function() {
                $('#modal_enter').css('display', 'none');
                $('#modal_enter_overlay').fadeOut(400);
                $('#modal_enter_overlay').css('display', 'none');
            });
    });

    $('#modal_enter_overlay').click(function() {
        $('#modal_enter').animate({
            opacity: 0,
            top: '45%'
        }, 200,
            function() {
                $('#modal_enter').css('display', 'none');
                $('#modal_enter_overlay').fadeOut(400);
                $('#modal_enter_overlay').css('display', 'none');
            });
        });

    });

    // MODAL WINDOW - FAST BUY
    $('.buy').click(function() {
        $('#modal_buy_overlay').css('display', 'block');
        $('#modal_buy_overlay').fadeIn(400,
            function() {
                $('#modal_buy')
                    .css('display', 'block')
                    .animate({
                        opacity: 1,
                        top: "50%"
                    }, 200);
    });

    // CLOSE MODAL WINDOW
    $('#modal_buy_close').click(function() {
        $('#modal_buy').animate({
            opacity: 0,
            top: '45%'
        }, 200,
            function() {
                $('#modal_buy').css('display', 'none');
                $('#modal_buy_overlay').fadeOut(400);
                $('#modal_buy_overlay').css('display', 'none');
            });
    });

    $('#modal_buy_overlay').click(function() {
        $('#modal_buy').animate({
            opacity: 0,
            top: '45%'
        }, 200,
            function() {
                $('#modal_buy').css('display', 'none');
                $('#modal_buy_overlay').fadeOut(400);
                $('#modal_buy_overlay').css('display', 'none');
            });
        });

    });

    var z = 1;
    var x = 1;
    var y = 1;

    // Slide Toggle
    $('.price h1 .tri.first').click(function(){
        $('.slider').slideToggle("slow");
        if (z == 1) {
            $(this).rotate({animateTo: -90});
            z = 0;
        } else {
            $(this).rotate({animateTo: 0});
            z = 1;
        }
    });

    $('.producers h1 .tri.second').click(function(){
        $('.list1').slideToggle("slow");
        if (x == 1) {
            $(this).rotate({animateTo: -90});
            x = 0;
        } else {
            $(this).rotate({animateTo: 0});
            x = 1;
        }
    });

    $('.year h1 .tri.third').click(function(){
        $('.list2').slideToggle("slow");
        if (y == 1) {
            $(this).rotate({animateTo: -90});
            y = 0;
        } else {
            $(this).rotate({animateTo: 0});
            y = 1;
        }
    });

    var read_more = 1;

    // Slide Toggle READ MORE
    $('.more_text').hide();
    $('.read_more').click(function(){
        $('.more_text').slideToggle("slow");
        if (read_more == 1) {
            $('.read_more').html('Свернуть обратно');
            read_more = 0;
        } else {
            $('.read_more').html('Читать соглашение');
            read_more = 1;
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




