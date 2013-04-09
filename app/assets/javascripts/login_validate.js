function login_validate(){
    if($.trim($("#user_name").val()) == ""){
        tishi_alert("用户名不能为空!");
        return false;
    }
    else if($.trim($("#user_password").val()) == ""){
        tishi_alert("密码不能为空!");
        return false;
    }
    else{
        return true;
    }
}