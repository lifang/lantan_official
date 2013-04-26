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
function get_btn_over(user_id) {
    if (user_id==""){
        tishi_alert("请登录");
        return false;
    }
    var sv_card =$('input:radio[name="sv_card"]:checked').val();
    if (sv_card == null)
    {
        tishi_alert("请选择你要购买的储值卡！");
    }else{
        var a =$('input:radio[name="sv_card"]:checked').val().split("_");
        var card_id = $('input:radio[name="sv_card"]:checked').attr("id");
        if (parseInt($("#f_types"))==parseInt(a[0])){
            $.ajax({
                async:true,
                type : 'POST',
                dataType : 'JSON',
                url : "/cards/check_card",
                data : {
                    user_id : user_id,
                    card_id : card_id,
                    fee_type :　a[0],
                    total_fee : a[1]
                },
                success : function (data){
                    if (data.checked){
                        $(".btn_three").attr("target","_blank");
                        $(".btn_three").attr("href", "/cards/alipay_exercise?sv_card=" + data.card_id +"&total_fee="+
                            data.total_fee+"&fee_type="+data.fee_type);
                        show_center("#alipay_confirm");
                        $(".btn_three").trigger("onclick");
                       
                    }else{
                        if (confirm("您已购买该打折卡，确认是否再次购买？")){
                            $(".btn_three").attr("target","_blank");
                            $(".btn_three").attr("href", "/cards/alipay_exercise?sv_card=" + data.card_id + "&total_fee="+
                                data.total_fee+"&fee_type="+data.fee_type);
                            show_center("#alipay_confirm");
                            $(".btn_three").trigger("onclick");
                          
                        }
                    }

                }
            });
        }else{
            $(".btn_three").attr("target","_blank");
            $(".btn_three").attr("href", "/cards/alipay_exercise?sv_card=" +card_id+ "&total_fee=" + a[1]+"&fee_type="+a[0]);
        }
    }
}
