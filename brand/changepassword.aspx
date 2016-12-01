<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeFile="changepassword.aspx.cs" Inherits="frmlogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Change Password</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../css/custom.css" rel="stylesheet" />
    <link href="../css/bootstrap.css" rel="stylesheet" />

        <link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
          <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    
    <script src="../js/bootstrap.js"></script>
    <script src="../js/custom.js"></script>
     <script type="text/javascript">  <script type="text/javascript">
         function HideLabel() {
             setTimeout(function () { $('#divAlerts').fadeOut(); }, 4000);

         };
</script>

</head>

<body>
    <form runat="server" id="frm_login">
    
<div class="wrapper">
<!--Header-->
    <div class="headerbgm">
           <nav class="navbar navbar-default">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <div style="margin-top:15px;">
               <!--#INCLUDE FILE="../includes/logo2.txt" -->
            </div>  
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <div class="col-md-3">   
            <!--#INCLUDE FILE="../includes/messgTop.txt" --> 
            </div> 
            <ul class="nav navbar-nav" id="firstbb">
              <li><div class="gab1"></div></li>
              <li class="dropdown">
                <a href="events.aspx">Events</a>
              </li>
              
              <li class="dropdown">
                     <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Create</a>
                 <ul class="dropdown-menu">
                  <li><a href="add-item.aspx"><img src="" /><span class="sp"> Item</span></a></li>
                  <li><a href="create-lookbook.aspx"><img src="" /><span class="sp"> Lookbook</span></a></li>
                </ul>
              </li>
            </ul>
            
              <!--#INCLUDE FILE="../includes/settings.txt" --> 
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>

    </div><!--header bg-->
<!--Headerend-->
<div class="topspace"></div>


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
      <div class="col-md-12" style="padding-bottom: 14%;">
          
           <div class="col-md-3 col-xs-12 mar"></div><!--.col-md-3 -->
         
           <div class="col-md-6 col-xs-12" style="margin-top:10%;">
                <div id="divAlerts" runat="server" class="alert" visible="False">
                  <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                  <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                      Text="" Visible="True"></asp:Label>   
                </div>
                
                <div id="dvForm" runat="server">
               <div class="col-md-12 loginhn" style="margin-top: 10px;">Change Password</div>
               <div class="col-md-12 logintn">Please enter your old & new password.</div>
               
               <div class="col-md-12" style="text-align: left;">
                   <input type="password" runat="server" id="txtOldPassword" EnableViewState="false"  placeholder="Your Old Password *" class="logininput" tabindex="1"  validationgroup="gpSignUp" />
                   <asp:RequiredFieldValidator ID="cvOldPassword" EnableViewState="false" runat="server" ErrorMessage="This field is required" Display="Dynamic"
                       ControlToValidate="txtOldPassword" ValidationGroup="gpSignUp" ClientValidationFunction="changeSignUpColor" CssClass="validationSummary">

                   </asp:RequiredFieldValidator>
                   
               </div>
               <div class="col-md-12" style="text-align: left;">
                   <input type="password" runat="server" id="txtSignUpPassword" EnableViewState="false" placeholder="New Password *" class="logininput" tabindex="2" validationgroup="gpSignUp" />
                   <asp:RequiredFieldValidator ID="cvSignUpPassword" EnableViewState="false" runat="server" ErrorMessage="This field is required" Display="Dynamic"
                       ControlToValidate="txtSignUpPassword" ClientValidationFunction="changeSignUpColor" ValidationGroup="gpSignUp" CssClass="validationSummary">

                   </asp:RequiredFieldValidator>
                    <asp:regularexpressionvalidator display="Dynamic" id="RegularExpressionValidator1" ValidationGroup="gpSignUp" errormessage="Password must be 6-15 characters long alphanumeric value." forecolor="Red" validationexpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d$@$!%*#?&]{6,15}$" controltovalidate="txtSignUpPassword" runat="server">
                   </asp:regularexpressionvalidator>
               </div>
               <div class="col-md-12" style="text-align: left;">
                   <input type="password" runat="server" id="txtRpassword" EnableViewState="false" placeholder="Confirm New Password *" class="logininput" tabindex="3" validationgroup="gpSignUp" />
                   <asp:CompareValidator ID="cvRpassword" runat="server" EnableViewState="false" ClientValidationFunction="changeSignUpColor" ErrorMessage="Confirm password does not match with new password" ValidationGroup="gpSignUp" CssClass="validationSummary" Display="Dynamic" ControlToValidate="txtRpassword" ControlToCompare="txtSignUpPassword"></asp:CompareValidator>
               </div>
               <div class="col-md-12" style="text-align: left;">
                   <button runat="server" id="btnChangePass"  EnableViewState="false"  OnServerClick="btnChangePass_OnServerClick" tabindex="4" class="hvr-sweep-to-right" validationgroup="gpSignUp">Submit</button>
                  
               </div>  
            </div>
                
               
           </div><!--.col-md-5 -->
           <div class="col-md-3 col-xs-12 mar"></div>
      </div><!--col-md-12-->
<!--text-->  

<!--footer-->
     <!--#INCLUDE FILE="../includes/footer.txt" -->
  <!--footer-->
<!--footer-->
<!--#INCLUDE FILE="../includes/backtotop.txt" -->
<script src="../js/backtotop.js" type="text/javascript"></script>
</div><!--wrapper-->
    <script language="javascript" type="text/javascript">
        function changeColor(source, args) {
            var txtuser = document.getElementById('txtLoginEmail');
            var strimg = new Array();
            strimg = [txtuser];
            if (args.Value == "") {
                args.IsValid = false;
                document.getElementById(source.id.replace('cv', 'txt')).style.border = '1px solid red';
            }
            else {
                args.IsValid = true;
                document.getElementById(source.id.replace('cv', 'txt')).style.border = '1px solid #7d7d7d';
            }
        }
</script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>
    <link href="../css/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            var userId = '<%= Request.Cookies["FRUserId"].Value %>';
            $("#lbViewMessageCount").mouseover(function () {

                $.ajax({
                    type: "POST",
                    url: $(location).attr('pathname') + "\\UpdateMessageStatus",
                    contentType: "application/json; charset=utf-8",
                    data: "{'userID':'" + userId + "'}",
                    dataType: "json",
                    async: true,
                    error: function (jqXhr, textStatus, errorThrown) {
                        alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
                    },
                    success: function (msg) {
                        //                    if (msg.d == true) {

                        $('#<%=lblTotalMessages.ClientID%>').hide("slow");
                        $('#<%=lblTotalMessages.ClientID%>').val = "";
                        return false;
                    }
                });

            });


            $("#lbViewAlerts").mouseover(function () {

                $.ajax({
                    type: "POST",
                    url: $(location).attr('pathname') + "\\UpdateNotifications",
                    contentType: "application/json; charset=utf-8",
                    data: "{'userID':'" + userId + "'}",
                    dataType: "json",
                    async: true,
                    error: function (jqXhr, textStatus, errorThrown) {
                        alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
                    },
                    success: function (msg) {
                        //                    if (msg.d == true) {

                        $('#<%=lblTotalNotifications.ClientID%>').hide("slow");
                        $('#<%=lblTotalNotifications.ClientID%>').val = "";
                        return false;
                    }
                });

            });

        });
    </script>   
 </form>
    
</body>
</html>
