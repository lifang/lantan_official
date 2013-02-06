function regist_validate(){
    if ($.trim($("#name").value) == ""){
        alert("用户名不能为空！")
        return false;
    }
    if($.trim($("#car_num").val()) == ""){
        alert("车牌号不能为空!")
        return false;
    }
    if($.trim($("#mobilephone").val()) == ""){
        alert("手机号不能为空!")
        return false;
    }
    if($.trim($("#address").val()) == ""){
        alert("地址不能为空!")
        return false;
    }
    return true;
}