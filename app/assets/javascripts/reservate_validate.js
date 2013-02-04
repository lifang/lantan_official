$(document).ready(function(){
    $("#next_step").click(function(){
        if( $("#customer_name").val() == ""){
            alert("用户名不能为空!");
        }else if( $("#car_number").val() == ""){
            alert("车牌不能为空!");
        }else if($("#telephone").val() == ""){
            alert("电话号码不能为空!");
        }else if( $("#datepicker").val() == ""){
            alert("预约时间不能为空!");
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
    alert("请至少选择一个服务项目!");
    return flag;
}
$(document).ready(function(){
    $( "#datepicker" ).datepicker({
        inline: true
    });
})