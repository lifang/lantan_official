 function regist_validate(){
    if ($("#name").value == ""){
      alert("用户名不能为空！")
      return false;
    }
    else if($("#car_num").val() == ""){
      alert("车牌号不能为空!")
      return false;
    }
    else if($("#mobilephone").val() == ""){
        alert("手机号不能为空!")
        return false;
      }
    else if($("#address").val() == ""){
        alert("地址不能为空!")
        return false;
      }
      else{
        return true;
      }
  }