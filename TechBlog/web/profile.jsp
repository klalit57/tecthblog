<%@page import="com.tech.blog.entities.Categories"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.User" %>
<%@page errorPage="error_page.jsp" %>
<%@page import="com.tech.blog.entities.Message" %>

<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("Register_page.jsp");
    }


%>




<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>

        <!-- css bootstrap-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <!-- css sheet-->
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <!-- font awesome 4 css-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
            .banner-background{
                clip-path:polygon(30% 0%, 70% 0%, 100% 0, 99% 79%, 70% 100%, 28% 79%, 0 100%, 0 0);
            }
        </style>

    </head>
    <body>
        <!-- temporaray
        <%= user.getId()%>
        <br>
        <%= user.getEmail()%>
        <br>
        <%= user.getName()%>
        <br>
        <%= user.getPassword()%>
        <br>
        <%= user.getAbout()%>
        <br>
        <%= user.getGender()%>
        <br>
        <%= user.getProfile()%>
        <br>
        <%= user.getDateTime()%>
        <br>
        -->

        <!-- Start navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <a class="navbar-brand" href="index.jsp"><span class="fa fa-book"></span> Tech Blog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#"><span class="fa fa-edit"></span> Learn Code with Lalit! <span class="sr-only">(current)</span></a>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="fa fa-bars"></span> Categories
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Programming Language</a>
                            <a class="dropdown-item" href="#">Project Implementation</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Data Structure</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><span class="fa fa-address-book"></span> Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"   data-toggle="modal" data-target="#add-post-modal" ><span class="fa fa-address-file"></span> Do post</a>
                    </li>


                </ul>

                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal" ><span class="fa fa-user"></span> <%= user.getName()%> </a>
                    </li> 
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet"><span class="fa fa-remove"></span> Logout </a>
                    </li>

                </ul>

            </div>
        </nav>



        <!-- end navbar -->

        <%
            Message m = (Message) session.getAttribute("msg");
            if (m != null) {
        %>
        <div class="alert <%= m.getCssClass()%>" role="alert">
            <%= m.getContent()%>
        </div>
        <%
                session.removeAttribute("msg");
            }
        %>

        <!-- Start Main body of the page -->

        <main>
            <div class="container" >
                <div class="row mt-4" >
                    <!-- first column -->
                    <div class="col-md-4" >
                        <!-- categories -->

                        <div class="list-group">
                            <a href="#" onclick="getPosts(0,this)" class="c-link list-group-item list-group-item-action active">
                                All Posts
                            </a>

                            <%
                                PostDao d = new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Categories> list1 = d.getAllCategories();
                                for (Categories cc : list1) {

                            %>
                            <a href="#" onclick="getPosts(<%= cc.getcId()  %>, this)" class="c-link list-group-item list-group-item-action"> <%= cc.getName()%>  </a>
                            <%
                                }
                            %>

                        </div>


                    </div>
                    <!-- second column -->
                    <div class="col-md-8">
                        <!-- posts -->
                        <div class="container text-center" id="loader">
                            <i class="fa fa-refresh fa-4x fa-spin"  ></i> 
                            <h3 class="mt-2">Loading...</h3>
                        </div>
                        
                        <div class="container-fluid" id="post-container">
                            
                        </div>

                    </div>

                </div>

            </div>
        </main>

        <!-- End Main body of the page -->


        <!-- start of profile modal -->

        <!-- Button trigger modal 
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#profile-modal">
            Launch demo modal
        </button>

        -->


        <!-- Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white text-center">
                        <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">            
                            <img src="pics/<%= user.getProfile()%>" alt="profile Picture" width="200" 
                                 height="200" style="border-radius: 50%"/>
                            <br>
                            <h5 class="modal-title mt-3" id="exampleModalLabel"> <%= user.getName()%> </h5>

                            <!-- details start-->
                            <div id="profile-details">
                                <table class="table">

                                    <tbody>
                                        <tr>
                                            <th scope="row">ID :</th>
                                            <td><%= user.getId()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Email :</th>
                                            <td><%= user.getEmail()%></td>

                                        </tr>

                                        <tr>
                                            <th scope="row">Gender :</th>
                                            <td><%= user.getGender()%></td>

                                        </tr>

                                        <tr>
                                            <th scope="row">About :</th>
                                            <td> <%= user.getAbout()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Registered on :</th>
                                            <td> <%= user.getDateTime().toString()%></td>

                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                            <!-- details finish -->

                            <!-- profile edit start -->
                            <div id="profile-edit" style="display:none;"> 
                                <h3 class="mt-2" >Please Edit Carefully</h3>
                                <form action="EditServlet" method="post" enctype="multipart/form-data">
                                    <table class="table">
                                        <tr>
                                            <td>ID :</td>
                                            <td><%= user.getId()%> </td>
                                        </tr>

                                        <tr>
                                            <td>Email :</td>
                                            <td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail()%>" > </td>
                                        </tr>

                                        <tr>
                                            <td>Name :</td>
                                            <td><input type="text" class="form-control" name="user_name" value="<%= user.getName()%>"> </td>

                                        </tr>
                                        <tr>
                                            <td>Password :</td>
                                            <td><input type="password" class="form-control" name="user_password" value="<%= user.getPassword()%>"> </td>

                                        </tr>
                                        <tr>
                                            <td>Gender :</td>
                                            <td><%= user.getGender().toUpperCase()%> </td>

                                        </tr>
                                        <tr>
                                            <td>About :</td>
                                            <td>
                                                <textarea rows="3" class="form-control" name="user_about"><%= user.getAbout()%></textarea>
                                            </td>

                                        </tr>

                                        <tr>
                                            <td>Profile Photo :</td>
                                            <td>
                                                <input type="file" name="image" claass="form-control" >  
                                            </td>

                                        </tr>

                                    </table>

                                    <div class="container">
                                        <button type="submit" class="btn btn-outline-primary" >Save </button>
                                    </div>

                                </form>
                            </div>
                            <!-- profile edit finish -->
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                    </div>
                </div>
            </div>
        </div>


        <!-- end of profile modal -->

        <!-- add post modal -->

        <!-- Modal -->
        <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel"> Post details </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">

                        <form id="add-post-form" action="AddPostServlet" method="post">

                            <div class="form-group">
                                <select class="form-control" name="cid" >
                                    <option selected disabled> --- select category --- </option>

                                    <%
                                        PostDao postD = new PostDao(ConnectionProvider.getConnection());
                                        ArrayList<Categories> list = postD.getAllCategories();
                                        for (Categories c : list) {
                                    %>
                                    <option value="<%= c.getcId()%>"><%= c.getName()%></option>
                                    <%
                                        }
                                    %>

                                </select>

                            </div>

                            <div form-group>
                                <input name="pTitle" type="text" placeholder="enter post title" class="form-control">
                            </div>

                            <div form-group>
                                <textarea name="pContent" style="height:100px" placeholder="enter your content" class="form-control"></textarea>
                            </div>

                            <div form-group>
                                <textarea name="pCode" style="height:100px" placeholder="enter your code (if any) " class="form-control"></textarea>
                            </div>

                            <div>
                                <label>add an image</label>
                                <br>
                                <input name="pic" type="file">
                            </div>

                            <div class="container text-center" >
                                <button type="submit" class="btn btn-outline-primary"> Post </button>
                            </div>


                        </form>

                    </div>

                    <!--
    <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
    </div>
                    -->
                </div>
            </div>
        </div>


        <!-- end post modal -->



        <!-- jquery cdn-->
        <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
        <!-- javascript bootstrap-->
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <!-- js sheet-->
        <script src="js/myjs.js" type="text/javascript"></script>

       <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

                        <script>
        $(document).ready(function () {
                                    let editStatus = false;
                            $('#edit-profile-button').click(function () {
                            if (!editStatus) {
                            $('#profile-details').hide();
                            $('#profile-edit').show();
                            editStatus = true;
                            $(this).text("Back");
                            } else {
                            $('#profile-details').show();
                            $('#profile-edit').hide();
                            editStatus = false;
                            $(this).text("Edit");
                            }

                            });
                            });
                            </script>
        
       <!-- Now we use javascript for adding post -->
       
                <script>
                
                $(document).ready(function( e ){
                                    //
                                    $("#add-post-form").on("submit", function(event){
                            // this code runs  when post form is submited
                            event.preventDefault();
                            console.log("clicked on submitted");
                            let form = new FormData(this);
                            //now requesting to server
                            $.ajax({
                            url: "AddPostServlet",
                                    type: 'POST',
                                    data: form,
                                    success: function(data, textStatus, jqXHR){
                                    //success
                                    console.log(data);
                                    if (data.trim() ==='done'){
                    swal("Good job!", "Post saved successfully", "success");
                                    } else{
                    swal("Error!", "Something went wrong! Post not saved ", "error");
                                    }
                                    },
                                    error: function(jqXHR, textStatus, errorThrown){
                                    swal("Error!", "Something went wrong! Post not saved ", "error");
                                    },
                                    processData: false,
                                    contentType: false
                            });
                            });
                            });
                        
                        </script>
                    
            

<!-- load_post jsp -->
                        <script> 
                            
                            function getPosts(catId,temp){
                             $("#loader").show();
                             $("#post-container").hide();
                             
                             $(".c-link").removeClass('active');
                            
                             $.ajax({
                              url:"load_post.jsp",
                              data: {cid:catId},
                              success: function(data, textStatus, jqXHR){
                                 console.log(data); 
                                 $("#loader").hide();
                                 $("#post-container").show();
                                 $("#post-container").html(data);
                                 $(temp).addClass('active');
                                }
                               });
                            }
                            
                          $(document).ready( function(e){
                              let allPostRef= $('.c-link')[0];
                            getPosts(0,allPostRef);
                            
                          });
                        </script>   
         


    </body>
</html>
