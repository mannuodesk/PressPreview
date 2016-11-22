<%@ Page Language="C#" AutoEventWireup="true" CodeFile="confirm.aspx.cs" Inherits="forgetpassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Account Confirmed</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="css/custom.css"/>
    <link href="admin/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="css/animate.css" rel="stylesheet" />
    <link href="admin/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.css"/>
<script type="application/javascript" src="js/custom.js"></script>
    <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

</head>

<body>
  <form name="forpass" id="forget" runat="server">  
<div class="wrapper">
<!--Header-->
    <div class="headerbg">
       <div class="wrapperblockmh">
          <div class="col-md-9 col-xs-12">
              <div class="logob"><a href="Default.aspx"><img src="images/logo.png" alt="thePRESSPreview" style="width: 200px; margin-top: 10px;"/></a></div>
              <%--<div class="logos"><a href="Default.aspx">Logo Branding</a></div>--%>
          </div>
          <div class="col-md-3 col-xs-12 alre">
             Already have an account? <span><a href="login.aspx">Log In</a></span>
          </div>
       </div>
    </div><!--header bg-->
<!--Headerend-->



<!--text-->
    <div runat="server" id="dvFailed" class="col-md-12 wrapperforget">
         <div id="divAlerts" runat="server" class="alert" Visible="False">
             <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
             <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                 Text="" Visible="True"></asp:Label>
          </div>  
    </div>
   <%-- <div class="col-md-3"></div>--%>
    <div runat="server" id="dvSuccess" class="col-md-12 wrapperforget;" style="text-align:center; margin-top:120px;">
          <div class="textforget" style="text-align: center">Congratulations!</div>
          <div class="textforgett">Your account has been created. An email will be sent to you after your account is <br />approved by the admin. <br/> <br/><br/> Please check your inbox.</div>          
          <div class="forgetform">                                 
                 <button type="submit" runat="server" name="forbut" id="btnGoTo" class="hvr-sweep-to-right"   style="float:none; text-align:center;" onserverclick="btnGoTo_ServerClick">Back to Home Page</button>
          </div><!--forgetform-->          
         
    </div> 
    <%--<div class="col-md-3"></div> --%>
<!--text-->  

<!--footer-->
 <div class="footerbg" style="position:fixed; bottom:0;">
     <div class="starter-template">
        <div class="col-md-12">©<%: DateTime.Now.Year %> Press Preview</div>
     </div>    
  </div>
<!--footer-->
<!--footer-->

</div><!--wrapper-->
          
  </form>
</body>
</html>

