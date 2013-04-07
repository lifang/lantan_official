$(document).ready(function(){
    $("#next_step").click(function(){ //预约验证
        if( $.trim($("#customer_name").val()) == ""){
            tishi_alert("用户名不能为空!");
        }else if($.trim($("#car_number").val()) == ""){
            tishi_alert("车牌不能为空!");
        }else if($.trim($("#telephone").val()) == ""){
            tishi_alert("电话号码不能为空!");
        }else if($.trim($("#datepicker").val()) == ""){
            tishi_alert("预约时间不能为空!");
        }else if(new Date($("#datepicker").val()) < new Date()){
            tishi_alert("预约时间必须在当前时间之后!");
        }else{
            $("#loginmessage").hide();
            $("#selectservice").show();
        }
    });

    $("#check").click(function(){ //预约选择项目验证
        if(($(".td_item :checked").length + $(".td_item_ul :checked").length) <= 0){
           tishi_alert("请至少选择一个服务项目!");
           return false;
        }
    })

    $( "#datepicker" ).datepicker({ //预约时间插件
        inline: true
    });
});
