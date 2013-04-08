$("#city_p_id").change(function(){
    var id = $("#city_p_id").val();
    $.ajax({
        async:true,
        type : 'get',
        dataType : 'script',
        url:"/official_sale/province_change?common=footer",
        data : {id : id}
    })
})
$("#city_c_id").change(function(){
    var city_id = $("#city_c_id").val();
    $.ajax({
        type : 'get',
        url:"/official_sale/city_change?common=footer",
        data : {id : city_id}
    })
})
