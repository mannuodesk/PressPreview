<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="login.aspx.cs" Inherits="frmlogin" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Login Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />

    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/custom.css" rel="stylesheet" />
    <script src="js/bootstrap.js"></script>
    <script src="js/custom.js"></script>
    <script type="text/javascript">
        function HideLabel() {
           setTimeout(function () { $('#divAlerts').fadeOut(); }, 4000);
        };
</script>
<style>
     @media only screen and (min-width:2000px){
     input[type="text"],input[type="password"] {
      width: 450px !important   
     }
     .col-md-12 input{
         width: auto;
     }
     .mar1{
         width: 500px !important
     }
     /*.signupWraper{
             width: 73% !important;
    margin-left: 15% !important;
     }*/
     .signupWraper{
         margin-left: 21% !important
     }
 }
</style>
</head>

<body>
    <form runat="server" id="frm_login" DefaultFocus="txtLoginEmail"  >
        <asp:toolkitscriptmanager ID="Toolkitscriptmanager1" runat="server"></asp:toolkitscriptmanager>
<div class="wrapper">
<!--Header-->
    <div class="headerbg" style="position:relative;">
       <div class="wrapperblockmh">
          <div class="col-md-9 col-xs-12">
              <div class="logob"><a href="Default.aspx"><img src="images/logo.png" alt="thePRESSPreview" style="width: 200px; margin-top: 10px;"/></a></div>
             <%-- <div class="logos"><a href="Default.aspx">Logo Branding</a></div>--%>
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
        <div class="heading">Sign Up To The PRESS Preview</div>
        <div class="sheading">Register Now</div>
      </div>
    </div><!--col-md-12-->
    </div><!--signup-->
<!--signup-->

<!--text-->
      <div class="col-md-12 signupWraper">
          <div id="divAlerts" runat="server" class="alert" visible="False">
              <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
              <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                  Text="" Visible="True"></asp:Label>
          </div>
           <div class="col-md-5 col-xs-12 mar mar1">
               <div class="col-md-12 loginh">Sign In</div>
               <div class="col-md-12 logint">Hello. Welcome to your account.</div>
              
               <div class="col-md-12" style="text-align: left;">
                   <asp:TextBox runat="server" ID="txtLoginEmail" placeholder="Username or Email Address" EnableViewState="false" class="logininput" ValidationGroup="gpLogin" TabIndex="1"/>
                   <asp:CustomValidator ID="cvLoginEmail" ValidationGroup="gpLogin" runat="server" SetFocusOnError="true" Display="Dynamic"
                       ValidateEmptyText="true" ControlToValidate="txtLoginEmail" ClientValidationFunction="changeColor" align="left" CssClass="validationSummary">This field is required</asp:CustomValidator>

               </div>
               <div class="col-md-12" style="text-align: left;">
                   <asp:TextBox TextMode="Password" runat="server" ID="txtLoginPassword" 
                       placeholder="Password" EnableViewState="false" class="logininput" 
                       ValidationGroup="gpLogin" TabIndex="2" />
                   <asp:CustomValidator ID="cvLoginPassword" ValidationGroup="gpLogin" runat="server" SetFocusOnError="true" Display="Dynamic"
                       ValidateEmptyText="true" ControlToValidate="txtLoginPassword" ClientValidationFunction="changeColor" align="left" CssClass="validationSummary">This field is required</asp:CustomValidator>
               </div>
                   <div class="col-md-12 col-xs-12 rem" style="text-align:left;">
                      <asp:CheckBox  runat="server" ID="chkRemember" TabIndex="2" style="margin-left: -3%;"/><label for="chkRemember"><div style="margin-top:5px">&nbsp; Remember me!</div></label>
                      <span class="col-sm-12 col-xs-12 forget"><a href="forgetpassword.aspx"  style="margin-top: -5%;float: right;" tabindex="9">Forgot Your Password?</a></span>
                   </div>
                   <div class="col-md-12 col-xs-12" style="text-align:left;">
                       <button type="submit"  runat="server"   id="login" class="hvr-sweep-to-right" 
                           enableviewstate="false"  validationgroup="gpLogin" 
                           onserverclick="login_ServerClick" tabindex="3">Login</button>
                       
                   </div>  
                    
           </div><!--.col-md-5 -->
           <div class="col-md-1 col-xs-12" id="signupor" style="margin-top:10%; text-align:center;"><img src="images/or.png" /></div><!--.col-md-4 -->
           <div class="col-md-1 col-xs-12" id="signuporn" style="text-align:center;"><img src="images/orn.png" /></div><!--.col-md-4 -->
           <div class="col-md-5 col-xs-12 mar1" style="margin-bottom: 50px;">
               <div class="col-md-12 loginhn" style="margin-top: 10px;">Create A new Account</div>
               <div class="col-md-12 logintn">Create your own Press Preview account.</div>
                 
               <div class="col-md-12" style="text-align: left;">
                   <input type="text" runat="server" id="txtSignUpEmail" EnableViewState="false" 
                       placeholder="Email Address *" class="logininput" validationgroup="gpSignUp" 
                       tabindex="4" />
                   <asp:RequiredFieldValidator ID="cvSignUpEmail" EnableViewState="false" runat="server" ErrorMessage="This field is required" Display="Dynamic"
                       ControlToValidate="txtSignUpEmail" ValidationGroup="gpSignUp" ClientValidationFunction="changeSignUpColor" CssClass="validationSummary">

                   </asp:RequiredFieldValidator>
                   <asp:RegularExpressionValidator ID="RegularExpressionValidator2" 
                       display="Dynamic" runat="server" ErrorMessage="Enter a valid email address" 
                       ValidationGroup="gpSignUp" ControlToValidate="txtSignUpEmail" 
                       ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                   
               </div>
               
               <div class="col-md-12" style="text-align: left;">
                   <input type="text" runat="server" id="txtUsername" EnableViewState="false" placeholder="Username *" class="logininput" validationgroup="gpSignUp" tabindex="5"  />
                   <asp:RequiredFieldValidator ID="cvUsername" EnableViewState="false" runat="server" ErrorMessage="This field is required" Display="Dynamic"
                       ControlToValidate="txtUsername" ValidationGroup="gpSignUp" ClientValidationFunction="changeSignUpColor" CssClass="validationSummary">

                   </asp:RequiredFieldValidator>
                   
               </div>
               <div class="col-md-12" style="text-align: left;">
                   <asp:TextBox TextMode="Password" runat="server" ID="txtSignUpPassword" EnableViewState="false" placeholder="Password *" class="logininput" validationgroup="gpSignUp" tabindex="6" > </asp:TextBox>
                   <asp:RequiredFieldValidator ID="cvSignUpPassword" EnableViewState="false" runat="server" ErrorMessage="This field is required" Display="Dynamic"
                       ControlToValidate="txtSignUpPassword" ClientValidationFunction="changeSignUpColor" ValidationGroup="gpSignUp" CssClass="validationSummary">

                   </asp:RequiredFieldValidator>
                   <asp:regularexpressionvalidator display="Dynamic" id="RegularExpressionValidator1" ValidationGroup="gpSignUp" errormessage="Password must be 6-15 characters long alphanumeric value." forecolor="Red" validationexpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d$@$!%*#?&]{6,15}$" controltovalidate="txtSignUpPassword" runat="server">
                   </asp:regularexpressionvalidator>
                  <%-- (?=^.{6,15}$)(?=.*\d)(?=.*\W+)(?![.\n])(?=.*[a-zA-Z]).*$--%>
                <%--   (?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{6,15})$--%>
               </div>
               <div class="col-md-12" style="text-align: left;">
                   <input type="password" runat="server" id="txtRpassword" EnableViewState="false" placeholder="Re-Type Password *" class="logininput" validationgroup="gpSignUp"  tabindex="7" />
                   <asp:CompareValidator ID="cvRpassword" runat="server" EnableViewState="false" ClientValidationFunction="changeSignUpColor" ErrorMessage="Retyped password does not match with password" ValidationGroup="gpSignUp" CssClass="validationSummary" Display="Dynamic" ControlToValidate="txtRpassword" ControlToCompare="txtSignUpPassword"></asp:CompareValidator>
               </div>
               <div class="col-md-12" style="text-align: left;">
                   <button runat="server" id="btnSignUp"  EnableViewState="false" onserverclick="btnSignUp_ServerClick" class="hvr-sweep-to-right" validationgroup="gpSignUp" tabindex="8" >Sign Up</button>
                  
               </div>  
                
               
           </div><!--.col-md-5 -->
      </div><!--col-md-12-->
<!--text-->  

<!--footer-->
  <div class="footerbg" >
     <div class="row">
        <div class="col-md-11 col-xs-10">©2016 Press Preview</div>
        <div class="col-md-pull-1 col-xs-pull-1">
           <div class="f1"><a id="loaddata"><img src="images/footerarrow.png" /></a></div>
           <div class="f2"></div>
        </div>
      </div>    
  </div><!--footer-->

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
