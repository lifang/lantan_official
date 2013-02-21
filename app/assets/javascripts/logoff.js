function sure_logoff(){
    return confirm("确定退出?");
}

function nav(){
    if (window.location.pathname =="/user_info/svcard_records")
    {
        $('a[href$="svcard_records"]').parent().attr("class","hover");
    }
    if (window.location.pathname == "/user_info/con_records"||window.location.pathname == "/user_info/search")
    {
        $('a[href$="con_records"]').parent().attr("class","hover");
    }
}
nav();