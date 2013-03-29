$(document).ready(function(){
    $("#next_step").click(function(){
        if( $.trim($("#customer_name").val()) == ""){
            tishi_alert("用户名不能为空!");
        }else if($.trim($("#car_number").val()) == ""){
            tishi_alert("车牌不能为空!");
        }else if($.trim($("#telephone").val()) == ""){
            tishi_alert("电话号码不能为空!");
        }else if($.trim($("#datepicker").val()) == ""){
            tishi_alert("预约时间不能为空!");
        }else{
            $("#loginmessage").hide();
            $("#selectservice").show();
        }
    });
});
function my_validate(){
    var services = document.getElementsByName("select_service[]");
    var flag = false;
    for(var i=0;i<services.length;i++){
        if(services[i].checked){
            flag = true;
            return flag;
        }
    }
    tishi_alert("请至少选择一个服务项目!");
    return flag;
}

$(document).ready(function(){
    $( "#datepicker" ).datepicker({
        inline: true
    });
})