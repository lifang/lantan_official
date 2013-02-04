$("#city_p_id").change(function(){
    $.ajax({
        type :"POST",
        url:"/homepage/provincechange?id="+$("#city_p_id").attr("value"),
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
        url:"/homepage/citychange?id="+$("#city_c_id").attr("value"),
        data :'text',
        success: function(data)
        {
            $("#stores_list_table").html(data);
        }
    })
})