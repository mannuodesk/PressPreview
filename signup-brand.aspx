<%@ Page Language="C#" AutoEventWireup="true" CodeFile="signup-brand.aspx.cs" Inherits="signup_brand" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Signup Brand</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="css/custom.css"/>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css"/>
<script type="application/javascript" src="js/custom.js"></script>

</head>

<body>
<form runat="server" id="form1">
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
 <div class="wrapperlogin">
           <div class="mareb">                   
                                 
                  <div class="col-md-12 signupform">
                      <div id="divAlerts" runat="server" class="alert" visible="False">
                          <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                          <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                              Text="" Visible="True"></asp:Label>
                      </div>
                     <div class="col-md-8 col-xs-12  loginh">
                      Sign Up
                     </div> <!-- col-md-6--><div class="col-md-4 col-xs-12 "> <span class="textt">Switch</span>
                         <select name="selecteb" class="loginebs1">
                             <option selected="selected" name="editor">Editor</option>
                             <option  name="brand">Brand</option>
                         </select>
                     </div> <!-- col-md-6--></div><!-- col-md-12-->
                   
                   
                   <div class="col-md-12" >
                     <div class="col-md-6 col-xs-12 " >
                      <input type="text" runat="server" name="fname" id="txtfname" placeholder="First name" class="logineb" />
                         <asp:RequiredFieldValidator ID="cvFname" runat="server" ErrorMessage="This field is required" Display="Dynamic"
                             ControlToValidate="txtfname" ValidationGroup="gpSignUp" CssClass="validationSummary">
                         </asp:RequiredFieldValidator>
                     </div> <!-- col-md-6--><div class="col-md-6 col-xs-12 " >
                      <input type="text" runat="server" name="lname" id="lname" placeholder="Last name" class="logineb" />
                     </div> <!-- col-md-6--></div><!-- col-md-12-->
                   
               <div class="col-md-12">
                   <div class="col-md-12 col-xs-12 ">
                       <textarea type="text" runat="server" name="or" id="txtBio" placeholder="Brief Biography" class="logineb" />
                       <asp:RequiredFieldValidator ID="cvBio" runat="server" ErrorMessage="This field is required" Display="Dynamic"
                           ControlToValidate="txtBio" ValidationGroup="gpSignUp" CssClass="validationSummary">
                       </asp:RequiredFieldValidator>
                   </div>
                   <!-- col-md-6-->
                  <%-- <div class="col-md-6 col-xs-12 ">
                       <input type="text" runat="server" name="de" id="txtde" placeholder="Designation" class="logineb" />
                       <asp:RequiredFieldValidator ID="cvde" runat="server" ErrorMessage="This field is required" Display="Dynamic"
                           ControlToValidate="txtde" ValidationGroup="gpSignUp" CssClass="validationSummary">
                       </asp:RequiredFieldValidator>
                   </div>--%>
                   <!-- col-md-6-->
               </div><!-- col-md-12-->
                   
               <div class="col-md-12">
                   <div class="col-md-6 col-xs-12 ">
                       <asp:DropDownList ID="ddState" runat="server" CssClass="logineb">
	<asp:ListItem Value="AL">Alabama</asp:ListItem>
	<asp:ListItem Value="AK">Alaska</asp:ListItem>
	<asp:ListItem Value="AZ">Arizona</asp:ListItem>
	<asp:ListItem Value="AR">Arkansas</asp:ListItem>
	<asp:ListItem Value="CA">California</asp:ListItem>
	<asp:ListItem Value="CO">Colorado</asp:ListItem>
	<asp:ListItem Value="CT">Connecticut</asp:ListItem>
	<asp:ListItem Value="DC">District of Columbia</asp:ListItem>
	<asp:ListItem Value="DE">Delaware</asp:ListItem>
	<asp:ListItem Value="FL">Florida</asp:ListItem>
	<asp:ListItem Value="GA">Georgia</asp:ListItem>
	<asp:ListItem Value="HI">Hawaii</asp:ListItem>
	<asp:ListItem Value="ID">Idaho</asp:ListItem>
	<asp:ListItem Value="IL">Illinois</asp:ListItem>
	<asp:ListItem Value="IN">Indiana</asp:ListItem>
	<asp:ListItem Value="IA">Iowa</asp:ListItem>
	<asp:ListItem Value="KS">Kansas</asp:ListItem>
	<asp:ListItem Value="KY">Kentucky</asp:ListItem>
	<asp:ListItem Value="LA">Louisiana</asp:ListItem>
	<asp:ListItem Value="ME">Maine</asp:ListItem>
	<asp:ListItem Value="MD">Maryland</asp:ListItem>
	<asp:ListItem Value="MA">Massachusetts</asp:ListItem>
	<asp:ListItem Value="MI">Michigan</asp:ListItem>
	<asp:ListItem Value="MN">Minnesota</asp:ListItem>
	<asp:ListItem Value="MS">Mississippi</asp:ListItem>
	<asp:ListItem Value="MO">Missouri</asp:ListItem>
	<asp:ListItem Value="MT">Montana</asp:ListItem>
	<asp:ListItem Value="NE">Nebraska</asp:ListItem>
	<asp:ListItem Value="NV">Nevada</asp:ListItem>
	<asp:ListItem Value="NH">New Hampshire</asp:ListItem>
	<asp:ListItem Value="NJ">New Jersey</asp:ListItem>
	<asp:ListItem Value="NM">New Mexico</asp:ListItem>
	<asp:ListItem Value="NY">New York</asp:ListItem>
	<asp:ListItem Value="NC">North Carolina</asp:ListItem>
	<asp:ListItem Value="ND">North Dakota</asp:ListItem>
	<asp:ListItem Value="OH">Ohio</asp:ListItem>
	<asp:ListItem Value="OK">Oklahoma</asp:ListItem>
	<asp:ListItem Value="OR">Oregon</asp:ListItem>
	<asp:ListItem Value="PA">Pennsylvania</asp:ListItem>
	<asp:ListItem Value="RI">Rhode Island</asp:ListItem>
	<asp:ListItem Value="SC">South Carolina</asp:ListItem>
	<asp:ListItem Value="SD">South Dakota</asp:ListItem>
	<asp:ListItem Value="TN">Tennessee</asp:ListItem>
	<asp:ListItem Value="TX">Texas</asp:ListItem>
	<asp:ListItem Value="UT">Utah</asp:ListItem>
	<asp:ListItem Value="VT">Vermont</asp:ListItem>
	<asp:ListItem Value="VA">Virginia</asp:ListItem>
	<asp:ListItem Value="WA">Washington</asp:ListItem>
	<asp:ListItem Value="WV">West Virginia</asp:ListItem>
	<asp:ListItem Value="WI">Wisconsin</asp:ListItem>
	<asp:ListItem Value="WY">Wyoming</asp:ListItem>
</asp:DropDownList>
                       
                   </div>
                   <!-- col-md-6-->
                   <div class="col-md-6 col-xs-12 ">
                       <input type="text" runat="server" name="ci" id="txtci" placeholder="City" class="logineb" />
                    <asp:RequiredFieldValidator ID="cvci" runat="server" ErrorMessage="This field is required" Display="Dynamic"
                             ControlToValidate="txtci" ValidationGroup="gpSignUp" CssClass="validationSummary">
                         </asp:RequiredFieldValidator>
                   </div>
                   <!-- col-md-6-->
               </div><!-- col-md-12-->
                   
                   <div class="col-md-12" >
                     <div class="col-md-6 col-xs-12 " >
                       <input type="text" runat="server" name="zip" id="txtzip" placeholder="zip/Postal Code" class="logineb" />
                    <asp:RequiredFieldValidator ID="cvzip" runat="server" ErrorMessage="This field is required" Display="Dynamic"
                             ControlToValidate="txtzip" ValidationGroup="gpSignUp" CssClass="validationSummary">
                         </asp:RequiredFieldValidator>
                     </div> <!-- col-md-6-->
                     <div class="col-md-6 col-xs-12 " >
                     
                     </div> <!-- col-md-6--></div><!-- col-md-12-->
                   
                   <div class="col-md-12" >
                     <div class="col-md-12" >
                      <input type="text" runat="server" name="addr" id="txtaddr" placeholder="Address 1" class="logineb" />
                     <asp:RequiredFieldValidator ID="cvaddr" runat="server" ErrorMessage="This field is required" Display="Dynamic"
                             ControlToValidate="txtaddr" ValidationGroup="gpSignUp" CssClass="validationSummary">
                         </asp:RequiredFieldValidator>
                     </div> <!-- col-md-6-->
                       <div class="col-md-6 col-xs-12 "></div> <!-- col-md-6--></div><!-- col-md-12-->
                   
                                     
                   <div class="col-md-12" >
                     <div class="col-md-6 col-xs-12 " >
                         <input type="text" runat="server" name="off" id="txtoff" placeholder="Office Number" class="logineb" />
                     <asp:RequiredFieldValidator ID="cvoff" runat="server" ErrorMessage="This field is required" Display="Dynamic"
                             ControlToValidate="txtoff" ValidationGroup="gpSignUp" CssClass="validationSummary">
                         </asp:RequiredFieldValidator>
                     </div> <!-- col-md-6--><div class="col-md-6 col-xs-12 " >
                      <input type="text" runat="server" name="web" id="web" placeholder="Website URL" class="logineb" />
                     </div> <!-- col-md-6--></div><!-- col-md-12-->
                   
                   <div class="col-md-12" >
                     <div class="col-md-6 col-xs-12 " >
                      <input type="text" runat="server" name="cell" id="cell" placeholder="Cell Phone" class="logineb" />
                     </div> <!-- col-md-6--><div class="col-md-6 col-xs-12 " >
                      <input type="text" runat="server" name="fb" id="fb" placeholder="FB Account URL" class="logineb" />
                     </div> <!-- col-md-6--></div><!-- col-md-12-->
                   
                   <div class="col-md-12" >
                     <div class="col-md-6 col-xs-12 " >
                      <input type="text" runat="server" name="ph" id="ph" placeholder="Home Phone Number" class="logineb" />
                     </div> <!-- col-md-6--><div class="col-md-6 col-xs-12 " >
                      <input type="text" runat="server" name="tw" id="tw" placeholder="Twitter Account URL" class="logineb" />
                     </div> <!-- col-md-6--></div><!-- col-md-12-->
                   
                   <div class="col-md-12" >
                     <div class="col-md-6 col-xs-12 " >
                      <input type="text" runat="server" name="emaila" id="txtemail" placeholder="Email Address" class="logineb" />
                     <asp:RequiredFieldValidator ID="cvemail" runat="server" ErrorMessage="This field is required" Display="Dynamic"
                             ControlToValidate="txtemail" ValidationGroup="gpSignUp" CssClass="validationSummary">
                         </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="Revemail" runat="server"   ErrorMessage="Enter a valid email address" validationgroup="gpSignUp" ControlToValidate="txtemail" CssClass="validationSummary" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                     </div> <!-- col-md-6--><div class="col-md-6 col-xs-12 " >
                      <input type="text" runat="server" name="ins" id="ins" placeholder="Instagram Account URL" class="logineb" />
                     </div> <!-- col-md-6--></div><!-- col-md-12-->
                   
                   <div class="col-md-12" >
                     <div class="col-md-12" >
                      <textarea name="des" runat="server" id="des" placeholder="Description" class="loginebd"></textarea>
                     </div> <!-- col-md-6-->
                       <div class="col-md-6 col-xs-12 " ></div> <!-- col-md-6--></div><!-- col-md-12-->
                   
                   <div class="col-md-12" >
                       <div class="col-md-12" style="margin:auto; float:left; text-align:right;">
                           <button type="submit" runat="server" name="signup" id="signup" class="hvr-sweep-to-right1" onserverclick="signup_ServerClick" validationgroup="gpSignUp">Submit</button>                     
                       </div> <!-- col-md-6--></div><!-- col-md-12-->
                   
                 
      </div><!--mar-->
 </div>     
<!--text-->  

<!--footer-->
   <!--#INCLUDE FILE="includes/footer.txt" -->
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
    <script src="admin/js/jquery-2.1.1.js"></script>
    <script src="admin/js/jquery-ui-1.10.4.min.js"></script>
</form>
</body>
</html>