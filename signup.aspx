<%@ Page Language="C#" AutoEventWireup="true" CodeFile="signup.aspx.cs" Inherits="signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Signup Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="css/custom.css"/>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css"/>
<script type="application/javascript" src="js/custom.js"></script>
<script type="text/javascript">
    function ShowPopup(message) {
        $(function () {
            $("#dialog").html(message);
            $("#dialog").dialog({
                title: "Account Created",
                width: 500,
                height:300,
                buttons: {
                    Close: function () {
                        //                        $(this).dialog('close');
                        window.location = 'http://presspreview.azurewebsites.net';
                    }
                },
                show: {
                    effect: "Slide down",
                    duration: 1000
                },
                hide: {
                    effect: "Slide up",
                    duration: 1000
                },
                modal: true
            });
        });
    };
</script>
    <style>
        .colpadL{
       padding-left:20%;
   }
   .colpadR{
       padding-right:20%;
   }
        .signup {
    margin-top: 77px;
    min-height: 200px;
    background: #333;
}
   @media only screen and (max-width:767px){
#btnEditor{
    margin-bottom: 20%;
}
   }
   @media only screen and (min-width:2000px){
       .signupimage img {
            width: 40%;
        }
        .col-md-12 .signupbrand {
            margin-top: 30px;
            font-family: Raleway-Medium;
            font-size: 6em;
            color: #494949;
        }
        .hvr-sweep-to-right1, .hvr-sweep-to-rightup1 {
            border-radius: 2px;
            width: 50%;
            height: 85px;
            transition-property: color;
            transition-duration: .3s;
            font-size: 3em;
        }
        #signupor img {
            width: 20% !important;
        }
        
   }
   @media (max-width: 992px){
    .colpadL{
       padding-left:inherit !important;
   }
   .colpadR{
       padding-right:inherit !important;
   }
   }
    </style>
</head>

<body>
<form runat="server" ID="frm_signup">
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
      <div class="col-md-12" style="margin-bottom: 34px;">
          <div id="divAlerts" runat="server" class="alert" Visible="False">
                                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                         <asp:Label runat="server" ID="lblStatus" for="PageMessage"  Text="" Visible="True"></asp:Label>
           </div>
           <div class="col-md-5 col-xs-12 colpadL">
                   <div class="col-md-12 signupimage"><img src="images/signupbrand.png" /></div>
                   <div class="col-md-12 signupbrand">I am a brand</div>
                   <div class="col-md-12"><button type="submit" runat="server" name="signup" ID="btnBrand" OnServerClick="btnBrand_ServerClick"  class="hvr-sweep-to-rightup1" style="margin-top:20px;">brand</button> </div>
           </div><!--.col-md-5 -->
           <div class="col-md-2 col-xs-12" id="signupor"><img src="images/or.png" /></div><!--.col-md-4 -->
           <div class="col-md-2 col-xs-12" id="signuporn"><img src="images/orn.png" /></div><!--.col-md-4 -->
           <div class="col-md-5 col-xs-12 colpadR">
                   <div class="col-md-12 signupimage"><img src="images/signupeditor.png" /></div>
                   <div class="col-md-12 signupbrand">I am a Influencer</div> 
                   <div class="col-md-12" ><button type="submit" name="signup" runat="server" ID="btnEditor" OnServerClick="btnEditor_ServerClick" class="hvr-sweep-to-rightup1" style="margin-top:20px;">influencer</button> </div>
           </div><!--.col-md-5 -->
           
           <div id="dialog" style="display: none;">
           </div>
      </div><!--col-md-10-->
<!--text-->  

<!--footer-->
  <div class="footerbg">
     <div class="starter-template">
        <div class="col-md-12">©2016 Press Preview</div>
     </div>    
  </div><!--footer-->
<!--footer-->

</div><!--wrapper-->
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>
    <link href="css/jquery-ui.css" rel="stylesheet" type="text/css" />
</form>
</body>
</html>


