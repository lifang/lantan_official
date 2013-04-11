
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
    if ($(".jqzoom").length > 0) {
        $(".jqzoom").jqueryzoom({
            xzoom: 300, //zooming div default width(default width value is 200)
            yzoom: 300, //zooming div default width(default height value is 200)
            offset: 10, //zooming div default offset(default offset value is 10)
            position: "right", //zooming div position(default position value is "right")
            preload:1,
            lens:1
        });
    }
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
    })
})

//弹出层
function tishi_alert(message){
    $(".tabox_h").html(message);
    var scolltop = document.body.scrollTop|document.documentElement.scrollTop;
    var win_height = document.documentElement.clientHeight;//jQuery(document).height();
    var z_layer_height = $(".tab_alert").height();
    $(".tab_alert").css('top',(win_height-z_layer_height)/2 + scolltop);

    var doc_width = $(document).width();    
    var layer_width = $(".tab_alert").width();
    $(".tab_alert").css('left',(doc_width-layer_width)/2);
    $(".tab_alert").css('display','block');
    jQuery('.tab_alert').fadeTo("slow",1);
    $(".tab_alert .x").click(function(){
        $(".tab_alert").css('display','none');
    })
    setTimeout(function(){
        jQuery('.tab_alert').fadeTo("slow",0);
    }, 3000);
    setTimeout(function(){
        $(".tab_alert").css('display','none');
    }, 3000);
}
