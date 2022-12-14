 <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration Page</title>


        <!-- css bootstrap-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <!-- css sheet-->
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <!-- font awesome 4 css-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    </head>
    <body>

        <%@include file="normal_navbar.jsp" %>

        <main class="primary-background banner-background" style="padding-bottom: 100px">
            <div class="container">
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-header text-center primary-background   text-white">
                            <span class="fa fa-user-plus fa-2x"></span>
                            <br>
                            <p>Register here</p>
                        </div>
                        <div class="card-body">
                            <form id="reg-form" action="RegisterServlet" method="post">
                                <div class="form-group">
                                    <label for="exampleInputUser"><span class="fa fa-id-card-o"></span> User Name</label>
                                    <input name="user_name" type="text" class="form-control" id="exampleInputUse" aria-describedby="emailHelp" placeholder="Enter User Name">

                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1"><span class="fa fa-at"></span> Email address</label>
                                    <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1"><span class="fa fa-key"> Password</label>
                                    <input name="user_password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputGender"><span class=""> Gender  </label>
                                    <input name="user_gender" type="radio"  id="exampleInputGender" id="gender" value="male"> Male
                                    <input name="user_gender" type="radio"  id="exampleInputGender" id="gender" value="female"> Female
                                </div>
                                <div class="form-group">
                                    <textarea name="user_about" class="form-control" id="" rows="5" placeholder="enter something about you!"></textarea>

                                </div>
                                <div class="form-check">
                                    <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                    <label class="form-check-label" for="exampleCheck1"> Accept terms & Conditions! </label>
                                </div>
                                <br>
                                <div id="loader" style="display: none" class="container text-center">
                                    <span class="fa fa-refresh fa-spin "></span>
                                    <h6>Please wait...</h6>
                                </div>
                                <button id="submit-btn" type="submit" class="btn btn-primary">Register</button>
                            </form>

                        </div>

                    </div>
                </div>
            </div> 

        </main>




        <!-- jquery cdn-->
        <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
        <!-- javascript bootstrap-->
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <!-- js sheet-->
        <script src="js/myjs.js" type="text/javascript"></script>

        <!-- sweetAlert cdn-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

        <script>
            $(document).ready(function () {
                console.log("Loaded...");

                $("#reg-form").on("submit", function (event) {
                    event.preventDefault();
                    let form = new FormData(this);

                    $("#submit-btn").hide();
                    $("#loader").show();


                    //send register servlet

                    $.ajax({
                        url: "RegisterServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            $("#loader").hide();
                            $("#submit-btn").show();
                            
                            if(data.trim()==='done'){

                            swal("Successfully Registered. redirecting to login page")
                                    .then((value) => {
                                        window.location="login_page.jsp";
                             
                                    });
                                }else{
                                   swal(data) ;
                                }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(jqXHR);
                            $("#loader").hide();
                            $("#submit-btn").show();
                            
                            swal("Something went wrong...Try again");
                            
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });
        </script>
    </body>
</html>
