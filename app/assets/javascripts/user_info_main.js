// JavaScript Document

 
//偶数行变色
$(function(){
    $(".data_table > tbody > tr:odd").addClass("tbg");
    $(".data_tab_table > tbody > tr:odd").addClass("tbg");
});

//点击单选框
$("#search_btn").click(function (){
    var time_value= $('input:radio[name="time"]:checked').val();
    var is_billing = $("#is_billing").attr("value");
    location.href = "/user_info/search?time="+time_value+"&is_billing="+is_billing;
});