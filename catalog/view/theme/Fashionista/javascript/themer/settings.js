$(function($){

	$('body').append(
		$('<div></div>')
		.attr({
			id : 'themer'
		})
	);	
	
		var $arr = ['Primary Background Color', 'Primary Text Color', 'Secondary Background Color', 'Color 3', 'Color 4']; 
		var $arr_class = ['.c1', '.c1_color', '.c2', '.c3', '.c4'];
		var $arr_type = ['bg', 'color', 'bg', 'bg', 'bg'];
		var $cont;
		
		$cont = '<a class="themer_toggle themer_option themer_off" href="#"><span>Settings</span></a>';
		
		$.each($arr, function(index, value) { 
			
			var $style;
			
			if($arr_type[index] == 'bg')
			{
				$style = 'background-color: '+$($arr_class[index]).css('backgroundColor');
			} else {
				$style = 'background-color: '+$($arr_class[index]).css('color');
			}
			
			$cont += '<div class="themer_option" id="themer_'+index+'">'+value+': <div class="colorSelector" id="selector_'+index+'" style="'+$style+'"></div></div>';
		});
		
		$('#themer').append($cont);

	$('.themer_option .colorSelector').each(function (index, value){
		
		var $rel_id = $(this).attr('id');
		
		$('#'+$rel_id).ColorPicker({
		color: $('#'+$rel_id).css('backgroundColor'),
		onShow: function (colpkr) {
			$(colpkr).fadeIn(500);
			return false;
		},
		onHide: function (colpkr) {
			$(colpkr).fadeOut(500);
			Cufon.refresh();
			return false;
		},
		onChange: function (hsb, hex, rgb) {
	
			$('#'+$rel_id).css('backgroundColor', '#' + hex);
			
			if($arr_type[index] == 'bg')
			{
				$($arr_class[index]).css('backgroundColor', '#'+hex);

			} else {
				$($arr_class[index]).css('color', '#'+hex);
			}
			
		}
		});			
		
	});

	$('#themer .themer_toggle').live('click', function (event){
		event.preventDefault();
		if($(this).hasClass('themer_off')) {
			
			$('#themer div').each(function (i){
				$(this).delay(100*i).animate({
					right : 0
				}, 'slow', function (){
					
				})
			});
			
			$(this).toggleClass('themer_off themer_on');

			
		} else {
			
			$('#themer div').each(function (i){
				$(this).delay(50*i).animate({
					right : -300
				}, 'fast')
			});
			
			$(this).toggleClass('themer_off themer_on');
		}
		
	})
	

});
