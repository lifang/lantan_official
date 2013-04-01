function login_validate(){
    if($.trim($("#name").val()) == ""){
        tishi_alert("用户名不能为空!");
        return false;
    }
    else if($.trim($("#mobilephone").val()) == ""){
        tishi_alert("手机号不能为空!");
        return false;
    }
    else{
        return true;
    }
}