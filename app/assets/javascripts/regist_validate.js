function regist_validate(){
    if ($.trim($("#name").val()) == ""){
        tishi_alert("用户名不能为空！")
        return false;
    }
    if($.trim($("#car_num").val()) == ""){
        tishi_alert("车牌号不能为空!")
        return false;
    }
    if($.trim($("#mobilephone").val()) == ""){
        tishi_alert("手机号不能为空!")
        return false;
    }
    if($.trim($("#address").val()) == ""){
        tishi_alert("地址不能为空!")
        return false;
    }
    return true;
}

function pop_xieyi(){
    var scolltop = document.body.scrollTop|document.documentElement.scrollTop;
    var win_height = document.documentElement.clientHeight;//jQuery(document).height();
    var z_layer_height = $("#xieyi_div").height();
    $("#xieyi_div").css('top',(win_height-z_layer_height)/2 + scolltop);

    var doc_width = $(document).width();
    var layer_width = $("#xieyi_div").width();
    $("#xieyi_div").css('left',(doc_width-layer_width)/2);
    $("#xieyi_div").css('display','block');
    $("#xieyi_div .close").click(function(){
        $("#xieyi_div").css('display','none');
    })
}