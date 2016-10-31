<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="admin_Login" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>PP :: Login</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet">

    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

</head>

<body class="gray-bg">

    <div class="loginColumns animated fadeInDown">
        <div class="row">

            <div class="col-md-3">   

            </div>
            <div class="col-md-6">
                <h2 class="font-bold" style="margin-bottom:25px;"><img src="../images/logo.png" alt="thePRESSPreview" /></h2> 
                <div class="ibox-content">
                    <form class="m-t" role="form"  runat="server">
                        <div class="form-group">
                            <input type="text" runat="server" id="txtEmail" class="form-control" placeholder="Username" required="">
                        </div>
                        <div class="form-group">
                            <input type="password" runat="server"  id="txtPassword" class="form-control" placeholder="Password" required="">
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="lblMessage" Visible="false"  Text="Invalid user name or password !"></asp:Label>
                        </div>
                        <asp:Button runat="server" ID="btnSubmit" type="submit" class="btn btn-primary block full-width m-b" Text="Login" OnClick="btnSubmit_Click"></asp:Button>

                        <a href="forgot_password.aspx">
                            <small>Forgot password?</small>
                        </a>                       
                    </form>
                   
                </div>
            </div>
            <div class="col-md-3">                          

            </div>
        </div>
        <hr/>
        <div class="row">
            <div class="col-md-3">               
            </div>
            <div class="col-md-6 text-right">
               <small> <p>Copyright PP &copy; <%: DateTime.Now.Year %> </p></small>
            </div>
            <div class="col-md-3">               
            </div>
        </div>
    </div>

</body>

</html>

