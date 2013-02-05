$("#city_province_id").change(function(){
    $.ajax({
        type :"POST",
        url:"/official_sale/province_change?id="+$("#city_province_id").attr("value"),
        data :'text',
        success: function(data)
        {
            $("#city_city_id").html(data);
        }
    })
})
$("#city_city_id").change(function(){
    $.ajax({
        type :"POST",
        url:"/official_sale/city_change?id="+$("#city_city_id").attr("value"),
        data :'text',
        success: function(data)
        {
            $("#stores_list").html(data);
        }
    })
})