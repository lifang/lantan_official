$(document).ready(function(){
    $("#city_province_id").change(function(){
        var id = $("#city_province_id").val();
        $.ajax({
            async:true,
            type : 'get',
            dataType : 'script',
            url:"/official_sale/province_change",
            data : {id : id}
        })
    });

    $("#city_city_id").change(function(){
        var city_id = $("#city_city_id").val();
        $.ajax({
            type : 'get',
            url:"/official_sale/city_change",
            data : {id : city_id}
        })
    });
})
