$("#city_p_id").change(function(){
    $.ajax({
        type :"POST",
        url:"/official_sale/province_change?id="+$("#city_p_id").attr("value"),
        data :'text',
        success: function(data)
        {
            $("#city_c_id").html(data);
        }
    })
})
$("#city_c_id").change(function(){
    $.ajax({
        type :"POST",
        url:"/official_sale/city_change?id="+$("#city_c_id").attr("value"),
        data :'text',
        success: function(data)
        {
            $("#stores_list_table").html(data);
        }
    })
})

 function sure_logoff(){
      return confirm("确定退出?");
    }