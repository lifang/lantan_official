// JavaScript Document
//nav
//储值卡

function get_btn_tow() {
    $(".card_one").animate({
        opacity:0
    },600,function(){
        $(".card_one").hide();
        $(".card_two").css("display", "block");
        $(".card_two").animate({
            opacity:1
        },600,function(){});
    });
}

function get_btn_three() {
    $(".card_two").animate({
        opacity:0
    },600,function(){
        $(".card_two").hide();
        $(".card_three").css("display", "block");
        $(".card_three").animate({
            opacity:1
        },600,function(){});
    });
}
  
$(function(){
    var xxx,re;
    var hover= $(".hover").position().left;
    $(".nav_bg").css("left",hover);
    $(".nav li").mouseover(function(){
        xxx=$(this).position().left;
        $(".nav_bg").stop().animate({
            left:xxx
        })
        clearTimeout(re);
    }).mouseout(function(){
        clearTimeout(re);
        re=setTimeout(function(){
            $(".nav_bg").stop().animate({
                left:hover
            })
        },100);
    })
})
//second_menu
$(function(){
    $(".menu").hover(
        function(){
            $(this).find(".second_menu").slideDown("slow");
        },
        function(){
            $(this).find(".second_menu").slideUp("slow");
        })
});

//首页轮播
$(function(){
    var t = n = 0, count = $(".scroll_show a").size();
    $(".scroll_show a:not(:first-child)").hide();
    $(".scroll_text").html($(".scroll_show a:first-child").find("img").attr('alt'));
    $(".scroll_num a:first").css({
        "background":"url(/assets/scroll_num_a0.png)"
    });
    $(".scroll_text").click(function(){
        window.open($(".scroll_show a:first-child").attr('href'), "_blank")
    });
    $(".scroll_num a").click(function() {
        var i = $(this).text() - 1;
        n = i;
        if (i >= count) return;
        $(".scroll_text").html($(".scroll_show a").eq(i).find("img").attr('alt'));
        $(".scroll_text").unbind().click(function(){
            window.open($(".scroll_show a").eq(i).attr('href'), "_blank")
        })
        $(".scroll_show a").filter(":visible").hide().parent().children().eq(i).fadeIn(500);
        $(this).css({
            "background":"url(/assets/scroll_num_a0.png)"
        }).siblings().css({
            "background":"url(/assets/scroll_num_a.png)"
        });
    });
    function showAuto()
    {
        n = n >= (count - 1) ? 0 : ++n;
        $(".scroll_num a").eq(n).trigger('click');
    }
    t = setInterval(showAuto, 5000);
    $(".scroll_play").hover(function(){
        clearInterval(t)
    },
    function(){
        t = setInterval(showAuto, 5000);
    });
});


//支付宝支付
 function get_btn_over() {
    var sv_card =$('input:radio[name="sv_card"]:checked').val();
    if (sv_card == null)
    {
        tishi_alert("请选择你要购买的储值卡！");
    }else{
        var a =$('input:radio[name="sv_card"]:checked').val()
        $(".btn_three").attr("href", "/cards/alipay_exercise?sv_card=" +
            $('input:radio[name="sv_card"]:checked').attr("id") + "&total_fee=" + a);
    }
 }
