<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeFile="forgetpassword.aspx.cs" Inherits="forgetpassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Forget Password Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="css/custom.css"/>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
</head>

<body>

<div class="wrapper">
<!--Header-->
    <div class="headerbg">
       <div class="wrapperblockmh">
          <div class="col-md-9 col-xs-12">
              <div class="logob"><a href="Default.aspx"><img src="images/logo.png" alt="thePRESSPreview" style="width: 200px; margin-top: 10px;"/></a></div>
             <%-- <div class="logos"><a href="Default.aspx">Logo Branding</a></div>--%>
          </div>
          <div class="col-md-3 col-xs-12 alre">
             Already have an account ? <span><a href="login.aspx">&nbsp;Log In</a></span>
          </div>
       </div>
    </div><!--header bg-->
<!--Headerend-->



<!--text-->
    <div class="wrapperforget" runat="server" ID="divEmailSection">
          <div class="textforget">Password Reset</div>
          <div class="textforgett">Enter email address that you used to register. An email will be sent to you with a link to reset you password</div>
          
          <div class="forgetform">
               
             <form name="forpass" id="forget" runat="server">
                 <div id="divAlerts" runat="server" class="alert" visible="False">
                     <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                     <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                         Text="" Visible="True"></asp:Label>
                 </div>
                 <div class="form-group" runat="server">
                 <input type="text" runat="server" id="txtEmail" placeholder="Email Address" name="forpass" class="forpass" />
                  <asp:RequiredFieldValidator ID="cvEmail" runat="server" ErrorMessage="This field is required" Display="Dynamic"
                            ControlToValidate="txtEmail" validationgroup="gpForgot" ClientValidationFunction="changeSignUpColor" CssClass="validationSummary">

                       </asp:RequiredFieldValidator>
                       <asp:RegularExpressionValidator ID="RevEmail" runat="server"   ErrorMessage="Enter a valid email address" validationgroup="gpForgot" ControlToValidate="txtEmail" CssClass="validationSummary" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                 <button type="submit" runat="server" name="forbut" id="btnSend" class="hvr-sweep-to-right" style="float:none;" validationgroup="gpForgot" onserverclick="btnSend_ServerClick">Send</button>
                </div>
             </form>
          </div><!--forgetform-->
          
          <div class="textfor">If you still need help, contact <a href="mailto:presspreview@gmail.com">Press Perview.</a></div>
    </div>  
    <div class="wrapperforget"  ID="divMessage" >
         <div class="forgetform">
             
                 <div id="divAlerts2" runat="server" class="alert" visible="False">
                     <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                     <asp:Label runat="server" ID="lblMessage" for="PageMessage"
                         Text="" Visible="True"></asp:Label>
                 </div>
                  <a href="Default.aspx" class="hvr-sweep-to-right" runat="server" ID="lbGotoHome" Visible="False" style="float:none; text-align:center; margin-left:35px;">Back to Home Page</a>                          
                <%-- <button type="submit" runat="server" name="forbut" id="btnGoTo" class="hvr-sweep-to-right"    style="float:none; text-align:center; margin-left:35px;" Visible="False" OnServerClick="btnGoTo_OnServerClick">Back to Home Page</button>--%>
           
          </div><!--forgetform-->
         
    </div>  

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
    <script src="js/bootstrap.js"></script>
</body>
</html>

