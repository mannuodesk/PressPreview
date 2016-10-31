<%@ Page Language="C#" AutoEventWireup="true" CodeFile="forgot_password.aspx.cs" Inherits="admin_Login" %>

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
    <form id="form1" runat="server">
    <div class="loginColumns animated fadeInDown">
        <div class="row">
            <div class="col-md-3">   

            </div>
            <div class="col-md-6">
                <div class="ibox-content">

                    <h2 class="font-bold">Forgot password</h2>

                    <p>
                        Enter your email address and your password will be emailed to you.
                    </p>

                    <div class="row">

                        <div class="col-lg-12">
                            <form class="m-t" role="form">
                                <div class="form-group">
                                    <input type="text" runat="server" id="txtEmail" class="form-control" placeholder="Email address" required="">
                                </div>
                                 <div class="form-group">
                                    <asp:Label runat="server" ID="lblMessage"   Text=""></asp:Label>
                                </div>
                                <asp:Button runat="server" ID="btnSubmit" type="submit" class="btn btn-primary block full-width m-b" Text="Send new password" OnClick="btnSubmit_Click"></asp:Button>

                            </form>
                        </div>
                        <div class="col-sm-12 col-xs-12">
	                        <div id="divAlerts" runat="server" class="alert" Visible="False">
                                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                 <asp:Label runat="server" ID="lblStatus" for="PageMessage"   
                                     Text="" Visible="True"></asp:Label>
                            </div>
	                     </div>
                    </div>
                </div>
                <div class="label-danger">
                      <asp:Button runat="server" ID="btnBack" type="submit" class="btn btn-black block full-width m-b" Text="Back to login" PostBackUrl="login.aspx" formnovalidate="formnovalidate"></asp:Button>
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
               <small> <p>Copyright PP &copy; <%: DateTime.Now.Year %> - </p></small>
            </div>
            <div class="col-md-3">               
            </div>
        </div>
    </div>
        <!-- Mainly scripts -->
    <script src="js/jquery-2.1.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
    </form>
</body>

</html>

