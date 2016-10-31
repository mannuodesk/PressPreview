<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeFile="changepassword.aspx.cs" Inherits="frmlogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Change Password</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />

    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/custom.css" rel="stylesheet" />
    <script src="js/bootstrap.js"></script>
    <script src="js/custom.js"></script>
    

</head>

<body>
    <form runat="server" id="frm_login">
<div class="wrapper">
<!--Header-->
    <div class="headerbg">
       <div class="wrapperblockmh">
          <div class="col-md-9 col-xs-12">
              <div class="logob"><a href="Default.aspx"><img src="images/logo.png" alt="thePRESSPreview" style="width: 200px; margin-top: 10px;"/></a></div>
           <%--   <div class="logos"><a href="Default.aspx">Logo Branding</a></div>--%>
          </div>
          <div class="col-md-3 col-xs-12 alre">
             Already have an account ? <span>&nbsp;<a href="login.aspx">Log In</a></span>
          </div>
       </div>
    </div><!--header bg-->
<!--Headerend-->

<!--signup-->
    <div class="signup">
    <div class="col-md-12">
      <div class="starter-template">
        <div class="heading">Change Your Password</div>
       
      </div>
    </div><!--col-md-12-->
    </div><!--signup-->
<!--signup-->

<!--text-->
      <div class="col-md-12">
          
           <div class="col-md-3 col-xs-12 mar"></div><!--.col-md-3 -->
         
           <div class="col-md-6 col-xs-12" style="margin-top:10%;">
               
                <div id="divAlerts" runat="server" class="alert" visible="False">
                  <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                  <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                      Text="" Visible="True"></asp:Label>   
                </div>
                <a href="login.aspx" class="hvr-sweep-to-right" runat="server" ID="lbGotoHome" Visible="False" style="float:none; text-align:center; margin-left:35px;">Login</a>  
                <div id="dvForm" runat="server">
               <div class="col-md-12 loginhn" style="margin-top: 10px;">Change Password</div>
               <div class="col-md-12 logintn">Please enter your new password.</div>
               <div class="col-md-12" style="text-align: left;">
                   <input type="password" runat="server" id="txtSignUpPassword" EnableViewState="false" placeholder="New Password *" class="logininput" validationgroup="gpSignUp" />
                   <asp:RequiredFieldValidator ID="cvSignUpPassword" EnableViewState="false" runat="server" ErrorMessage="This field is required" Display="Dynamic"
                       ControlToValidate="txtSignUpPassword" ClientValidationFunction="changeSignUpColor" ValidationGroup="gpSignUp" CssClass="validationSummary">

                   </asp:RequiredFieldValidator>
                   <asp:regularexpressionvalidator display="Dynamic" id="RegularExpressionValidator1" ValidationGroup="gpSignUp" errormessage="Password must be 6-15 characters long alphanumeric value." forecolor="Red" validationexpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d$@$!%*#?&]{6,15}$" controltovalidate="txtSignUpPassword" runat="server">
                   </asp:regularexpressionvalidator>
               </div>
               <div class="col-md-12" style="text-align: left;">
                   <asp:TextBox TextMode="Password" runat="server" ID="txtRpassword" EnableViewState="false" placeholder="Confirm New Password *" CssClass="logininput" ValidationGroup="gpSignUp" />
                   <asp:CompareValidator ID="cvRpassword" runat="server" EnableViewState="false" ClientValidationFunction="changeSignUpColor" ErrorMessage="Confirm password does not match with new password" ValidationGroup="gpSignUp" CssClass="validationSummary" Display="Dynamic" ControlToValidate="txtRpassword" ControlToCompare="txtSignUpPassword"></asp:CompareValidator>
               </div>
               <div class="col-md-12" style="text-align: left;">
                   <button type="button" runat="server" id="btnChangePass" CausesValidation="True"  EnableViewState="false"  OnServerClick="btnChangePass_OnServerClick" class="hvr-sweep-to-right" validationgroup="gpSignUp">Submit</button>
                  
               </div>  
               </div> 
               
           </div><!--.col-md-5 -->
           <div class="col-md-3 col-xs-12 mar"></div>
      </div><!--col-md-12-->
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
    <script language="javascript" type="text/javascript">
        function changeColor(source, args) {
    var txtuser = document.getElementById('txtLoginEmail');
    var strimg = new Array();
    strimg = [txtuser];
if (args.Value == "") {
args.IsValid = false;
document.getElementById(source.id.replace('cv','txt')).style.border = '1px solid red';
}
else {
args.IsValid = true;
document.getElementById(source.id.replace('cv', 'txt')).style.border = '1px solid #7d7d7d';
}
}
</script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>
    <link href="css/jquery-ui.css" rel="stylesheet" type="text/css" />
 </form>
    
</body>
</html>
