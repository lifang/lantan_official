// JavaScript Document

// 自动轮换内容
$(document).ready(function(){
	var objStr = ".change ul li";
	$(objStr + ":not(:first)").css("display","none");
	setInterval(function(){
	if( $(objStr + ":last").is(":visible")){
		$(objStr + ":first").fadeIn("slow").addClass("in");
		$(objStr + ":last").hide()
	}
	else{
		$(objStr + ":visible").addClass("in");
		$(objStr + ".in").next().fadeIn("slow");
		$(objStr + ".in").hide().removeClass("in")}
	},4000) //每3秒钟切换
})

<!-- 自动轮换内容 -->

//product
$(function(){
	$(".product li").hover(
		 function () {
    		$(this).children("a").css("display","block");
 		 },function () {
   			$(this).children("a").css("display","none");
 		 }
	)
})

//产品放大效果
$(document).ready(function(){
$(".jqzoom").jqueryzoom({
				xzoom: 300, //zooming div default width(default width value is 200)
				yzoom: 300, //zooming div default width(default height value is 200)
				offset: 10, //zooming div default offset(default offset value is 10)
				position: "right", //zooming div position(default position value is "right")
 				preload:1,
				lens:1
			});
});

//jqzoom产品小图点击替换大图效果
$(function(){
	$('.pic_show li img').click(function(){
		var imgSrc = $(this).attr('src');
		var i = imgSrc.lastIndexOf('.');
		var jpg = imgSrc.substring(i);
		imgSrc = imgSrc.substring(0,i);
		var imgSrc_big = imgSrc + '_big' + jpg;
		var imgSrc_show = imgSrc + '_show' + jpg;
		$('.bigImg img').attr('src',imgSrc_big);
		$('.bigImg img').attr('jqimg',imgSrc_show);
		//alert(0);
	})	
})

