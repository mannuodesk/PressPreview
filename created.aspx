<%@ Page Language="C#" AutoEventWireup="true" CodeFile="created.aspx.cs" Inherits="forgetpassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Account Created</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="css/custom.css"/>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css"/>
<script type="application/javascript" src="js/custom.js"></script>

</head>

<body>

<div class="wrapper">
<!--Header-->
    <div class="headerbg">
       <div class="wrapperblockmh">
          <div class="col-md-9 col-xs-12">
              <div class="logob"><a href="Default.aspx">Press Preview</a></div>
              <div class="logos"><a href="Default.aspx">Logo Branding</a></div>
          </div>
          <div class="col-md-3 col-xs-12 alre">
             Already have an account? <span><a href="login.aspx">Log In</a></span>
          </div>
       </div>
    </div><!--header bg-->
<!--Headerend-->



<!--text-->
    <div class="col-md-12 wrapperforget">
          <div class="textforget">Thank you for signing up!</div>
          <div class="textforgett">We are excited to have you join us in Press Preview community</div>
          
          <div class="forgetform">
               <div id="divAlerts" runat="server" class="alert" Visible="False">
                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                             <asp:Label runat="server" ID="lblStatus" for="PageMessage"   
                                 Text="" Visible="True"></asp:Label>
                </div>
            <div class="textfor">
                <p>
                    To complete the signup process,
                    please confirm your email address by opening the link in the email we sent you when you signed up. </p>
                 <p>Confirming your email address helps us know we're sending your account info to the right place.
                </p>
            </div>
          </div><!--forgetform-->          
         
    </div>  
<!--text-->  

<!--footer-->
  <!--#INCLUDE FILE="includes/footer.txt" -->
<!--footer-->
<!--footer-->

</div><!--wrapper-->
<script src="admin/js/jquery-2.1.1.js"></script>
    <script src="admin/js/jquery-ui-1.10.4.min.js"></script>
</body>
</html>

