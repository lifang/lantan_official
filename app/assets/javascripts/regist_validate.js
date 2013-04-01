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
