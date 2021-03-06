$(document).ready(function(){
  /* OnSubmit loginForm */
  $("#loginForm").on("submit", function(e){
    e.preventDefault();

    $.ajax({
      type : "POST",
      url : "resources/server/authenCore.php",
      data : $(this).serialize(),
      dataType : "JSON",
      encode : true,
    }).done(function(res){
      if(res.success){
        Swal.fire({
          type : "success",
          title : "Login Successful!",
          text : "Enjoy your skins",
          heightAuto : false
        });
        setTimeout(function(){ location.reload(); }, 350);
      } else if(res.error.code == 401){
        Swal.fire({
          type : "error",
          title : "Invalid username/password!",
          text : res.error.data,
          heightAuto : false
        });
        console.log(res);
      } else if(res.error.code == 429){
        Swal.fire({
          type : "error",
          title : "You're rate limited!",
          text : res.error.data,
          heightAuto : false
        });
        console.log(res);
      } else {
        Swal.fire({
          type : "error",
          title : "Something went wrong!",
          text : "Please re-login or contact WebMaster",
          heightAuto : false
        });
        console.log(res.data);
      }
    }).fail(function(){
      console.log("[ERROR] AJAX FAILED!");
    });
  });
});
