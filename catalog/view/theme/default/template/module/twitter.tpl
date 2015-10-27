<script src="http://platform.twitter.com/anywhere.js?id=AZumvGuPTo2WkFmTSjOgNg&v=1" type="text/javascript"></script>
<script type="text/javascript">
//function twitterCallback2(twitters) {
//	  var statusHTML = [];
//	  for (var i=0; i<twitters.length; i++){
//	    var username = twitters[i].user.screen_name;
//	    var status = twitters[i].text.replace(/((https?|s?ftp|ssh)\:\/\/[^"\s\<\>]*[^.,;'">\:\s\<\>\)\]\!])/g, function(url) {
//	      return '<a href="'+url+'">'+url+'</a>';
//	    }).replace(/\B@([_a-z0-9]+)/ig, function(reply) {
//	      return  reply.charAt(0)+'<a href="http://twitter.com/'+reply.substring(1)+'">'+reply.substring(1)+'</a>';
//	    });
//	    statusHTML.push('<li><span>'+status+'</span> <a style="font-size:85%" href="http://twitter.com/'+username+'/statuses/'+twitters[i].id_str+'">'+relative_time(twitters[i].created_at)+'</a></li>');
//	  }
//	  document.getElementById('twitter_update_list').innerHTML = statusHTML.join('');
//	}

	function relative_time(time_value) {
	  var values = time_value.split(" ");
	  console.dir(time_value.split(" "))
	  if(values[5] != '+0000')
	  	time_value = values[1] + " " + values[2] + ", " + values[5] + " " + values[3];
	  else
		time_value = values[1] + " " + values[3] + ", " + values[2] + " " + values[4]; 

	  
	  var parsed_date = Date.parse(time_value);
	  var relative_to = (arguments.length > 1) ? arguments[1] : new Date();
	  var delta = parseInt((relative_to.getTime() - parsed_date) / 1000);
	  delta = delta + (relative_to.getTimezoneOffset() * 60);

	  if (delta < 60) {
	    return 'less than a minute ago';
	  } else if(delta < 120) {
	    return 'about a minute ago';
	  } else if(delta < (60*60)) {
	    return (parseInt(delta / 60)).toString() + ' minutes ago';
	  } else if(delta < (120*60)) {
	    return 'about an hour ago';
	  } else if(delta < (24*60*60)) {
	    return 'about ' + (parseInt(delta / 3600)).toString() + ' hours ago';
	  } else if(delta < (48*60*60)) {
	    return '1 day ago';
	  } else {
	    return (parseInt(delta / 86400)).toString() + ' days ago';
	  }
	}

	
		var buildString = '<?php echo $twitter['keyword'] ?>';
		var lastID = 0;

		
		function naitiVesnu(){
		try{
			$.ajax({ 
					<?php if($twitter['mod'] == 'username'):?> 
				  		url : "http://twitter.com/statuses/user_timeline/<?php echo $twitter['username'] ?>.json?count=<?php echo $twitter['count'] ?>&callback=?",  
				  	<?php else:?>
				  		url : "http://search.twitter.com/search.json?since_id=" + lastID + "&q=" + buildString + "&rpp=<?php echo $twitter['count'] ?>&callback=?",
				  	<?php endif;?>
				  	dataType : "json",  
				  	//timeout:15000,  
		  
					success : function(data)   
				  	{ 
				  		$("#data").html("");
				  		<?php if($twitter['mod'] == 'username'):?>
 				  		for (i=0; i<data.length; i++){  
 	 				  		//console.log(parseInt(data[i].created_at.length))
 	 				  		var date = data[i].created_at;
 	 	 				  	var status = data[i].text.replace(/((https?|s?ftp|ssh)\:\/\/[^"\s\<\>]*[^.,;'">\:\s\<\>\)\]\!])/g, function(url) {
 	  	 				      return '<a href="'+url+'">'+url+'</a>';
 	  	 				    })/*.replace(/\B@([_a-z0-9]+)/ig, function(reply) {
 	  	 				      return  reply.charAt(0)+'<a href="http://twitter.com/'+reply.substring(1)+'">'+reply.substring(1)+'</a>';
 	  	 				    });*/
 				  			$("#data").append("<span class='date'>" + relative_time(date) +"</span>"); 
 				  			$("#data").append("<p>" + status +"</p>");   
				  		}   
						<?php else:?>
						for (i=0; i<data.results.length; i++){  
							var status = data.results[i].text.replace(/((https?|s?ftp|ssh)\:\/\/[^"\s\<\>]*[^.,;'">\:\s\<\>\)\]\!])/g, function(url) {
	 	  	 				    return '<a href="'+url+'">'+url+'</a>';
	 	  	 				})/*.replace(/\B@([_a-z0-9]+)/ig, function(reply) {
	 	  	 				    return  reply.charAt(0)+'<a href="http://twitter.com/'+reply.substring(1)+'">'+reply.substring(1)+'</a>';
	 	  	 				});*/
							var date = data.results[i].created_at
						 	//$("#data").append("<div class='post'></div>")
							$("#data").append("<span class='autor'>@"+ data.results[i].from_user+"&nbsp;</span>"); 
							$("#data").append("<span class='date'>" + relative_time(date) +"</span>"); 
							$("#data").append("<p>" + status +"</p>");  
						}
						<?php endif;?>

					twttr.anywhere(function (T) {
						 T.linkifyUsers();
						 T.hovercards();
					});
				  },  
		  
				  error : function()  
				  {  
				     // alert("Failure!");  
				  },  
		  
			 });
			}catch(e){}
		}
		naitiVesnu();
		window.setInterval(function(){naitiVesnu()}, <?php echo $twitter['update'] ?> * 1000);

	
</script>
<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
  <?php if($twitter['mod'] == 'username'):?>
  @<?php echo $twitter['username']?><br />
  <?php endif;?>
    <div id="data">
		
	</div>
  </div>
</div>
