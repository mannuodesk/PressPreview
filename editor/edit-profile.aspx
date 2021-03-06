﻿
<%@ Page Language="C#" ValidateRequest="false" AutoEventWireup="true" CodeFile="edit-profile.aspx.cs"  Inherits="pr_brand_myprofile" %>
<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox, Version=3.3.1.12354, Culture=neutral, PublicKeyToken=5962a4e684a48b87" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Influencer Edit Profile</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
        #txtAbout_toolbarArea{
            display: none
        }
        #txtAbout_TabRow{
            display: none
        }
        #txtTop_toolbarArea{
          display: none
        }
        #txtTop_TabRow{
          display: none;
        }
        #txtECalendar_toolbarArea{
          display: none
        }
         #txtECalendar_TabRow{
          display: none;
        }
  
</style>
<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../css/checkbox.css"/>

<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>

<script type="text/javascript" src="../js/modernizr.custom.79639.js"></script> 
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="../js/sample.js"></script>
<link href="../source/jquery.fancybox.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../jcrop/css/style.css" />
<link rel="stylesheet" href="../jcrop/css/jquery.Jcrop.min.css" type="text/css" />
<script type="text/javascript" src="../jcrop/js/jquery.min.js"></script>
<script src="../jcrop/js/jquery.Jcrop.min.js"></script>
<script type="text/javascript" src="../jcrop/js/script.js"></script>
   <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="../js/bootstrap.js"></script>
   <style>
select {
	    width:100%;
        padding: 12px;
        margin: 0;
        -webkit-appearance:none; /* remove the strong OSX influence from Webkit */
        -moz-appearance: none;
        appearance: none;
		border:#999 solid 1px;
    background: transparent url("../images/earrow.png") no-repeat 98% center;
	outline:none !important;
	outline:0 !important;
    -moz-outline: none !important;
	letter-spacing: 1px;
	cursor:pointer;
	border-left:none;
	color: #000;
  color: rgba(0,0,0,0);
  text-shadow: 0 0 0 #000;
        -ms-appearance: none;
        -o-appearance: none;
}

select option {
	color:#000;
}
     @media only screen and (max-width:767px){
            .reb1{
              width: auto !important
            }
            .reb2{
              width: 70% !important
            }
          }
</style> 
</head>

<body>
<form runat="server" ID="frm_Profile">
     <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
                        </asp:ScriptManager>
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
               <!--#INCLUDE FILE="../includes/logo.txt" -->
            </div>  
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            
            
         <div class="col-md-2">   
            <!--#INCLUDE FILE="../includes/messgTopInfluencer.txt" --> 
         </div>    
            <ul class="nav navbar-nav" id="firstbb">
              <li><a href="Default.aspx">Activity</a></li>
              <li><a href="discover.aspx">Discover</a></li>
              <li><a href="brands.aspx">Brands</a></li>
              <li><a href="events.aspx">Events</a></li>
            </ul> 
            
        <!--#INCLUDE FILE="../includes/influencer_settings.txt" -->  
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>

    </div><!--header bg-->
<!--Headerend-->


<!--text-->
<div class="wrapperblockedit">

<!--Banner-->
    <div class="">
        <asp:Image runat="server" Id="imgCover" class="img-responsive" ImageUrl="../images/bggreyi.jpg"  alt="profileimage" style="width:100%" />
       
    </div>
<!--bannerend-->
  <style>
      #imgCover{
        cursor: pointer;
      }
    </style>

     <div class="remainblock">
         
           <div class="replaytext">
             <a class="fancybox" id="coverPicChange"  href="../lightbox/CoverPic.aspx?v=c" ><img src="../images/replaceimage.png" /></a>
          </div><div class="lines"><hr /></div>
          <a class="fancybox"  href="../lightbox/CoverPic.aspx?v=p" >
          <div class="replaimg"><asp:Image ID="imgProfile"  ImageUrl="../images/follo.png" runat="server" CssClass="img-circle" style="border-width:0px;width: 93px;height: 93px;"/></div>
          <div class="replaimg"><img  src="../images/replaceimage1.png" /></div>
          </a>
          <div class="lines"><hr /></div>
           <asp:updatepanel runat="server">
             <ContentTemplate>
              <script type="text/javascript" language="javascript">
                  function pageLoad() {
                      setTimeout(function () { $('#dvAlert2').fadeOut(); }, 4000);
                  }
        </script>
              <div id="dvAlert2" runat="server" class="alert" visible="False" style="margin:20px;">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <asp:Label runat="server" ID="lblSocialS" for="PageMessage"
                Text="" Visible="True"></asp:Label> 
        </div>  
          <div class="likeblock">
            <div class="blockshare">
              <div class="lineimage"><img src="../images/additemline.jpg" /></div>
              <div class="lineimage1" style="margin-left:-10px;"><img src="../images/sminsta.jpg" /></div>
              <div class="reinput"><input runat="server" ID="txtInstagram" class="seinre" placeholder="Enter User Name" /></div>
             </div>   
             
              <div class="relinw"></div>
          </div><!--likeblock-->
          
          <div class="likeblock">
            <div class="blockshare">
              <div class="lineimage"><img src="../images/additemline.jpg" /></div>
              <div class="lineimage1" style="margin-left:-10px;"><img src="../images/smtwitter.jpg" /></div>
              <div class="reinput"><input class="seinre" runat="server" ID="txtTwitter" placeholder="Enter User Name" /></div>
            </div>  
             
              <div class="relinw"></div>
          </div><!--likeblock-->
          
          <div class="likeblock">
            <div class="blockshare">
              <div class="lineimage"><img src="../images/additemline.jpg" /></div>
              <div class="lineimage1" style="margin-left:-10px;"><img src="../images/smfacebook.jpg" /></div>
              <div class="reinput"><input class="seinre" runat="server" ID="txtFacebook" placeholder="Enter User Name" /></div>
            </div>  
             
              <div class="relinw"></div>
          </div><!--likeblock-->
          
          <div class="likeblock">
            <div class="blockshare">
              <div class="lineimage"><img src="../images/additemline.jpg" /></div>
              <div class="lineimage1" style="margin-left:-10px;"><img src="../images/smyoutube.jpg" /></div>
              <div class="reinput"><input class="seinre" runat="server" ID="txtYoutube" placeholder="Enter User Name" /></div>
            </div>   
             
              <div class="relinw"></div>
          </div><!--likeblock-->
          
          <div class="likeblock">
            <div class="blockshare">
              <div class="lineimage"><img src="../images/additemline.jpg" /></div>
              <div class="lineimage1" style="margin-left:-10px;"><img src="../images/smpinterest.jpg" /></div>
              <div class="reinput"><input class="seinre" runat="server" ID="txtPinterest" placeholder="Enter User Name" /></div>
            </div>  
             
              <div class="relinw"></div>
          </div><!--likeblock-->
          
          <div class="likeblock">
              <div class="lineimage"><img src="../images/additemline.jpg" /></div>
             <%-- <div class="reinput"><input class="seinre" placeholder="Enter Link" /></div>--%>
              <%--<div class="resubtext"><a href="">Submit</a></div>--%>
               <div class="resubtext">
                   <button type="button" runat="server" name="signup" ID="btnSubmit_Social_Links" class="hvr-sweep-to-rightup2" style="margin-top: -14px; margin-right: 48px; margin-bottom: 10px; float:right;"   OnServerClick="btnSubmit_Social_Links_OnServerClick" >Submit</button> 
                </div>
             <%-- <div class="recross"><a href=""><img src="../images/smcross.jpg" /></a></div>--%>
          </div><!--likeblock-->
          </ContentTemplate>
         </asp:updatepanel>
          
     </div><!--col-md-3 col-xs-12-->
     

     
   <div class="remainblock1">
      <div class="wrapreblock">
      
      <div class="reblockadd">
        <div class="textforget">Influencer Information</div> 
        <div id="divAlerts" runat="server" class="alert" visible="False">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                Text="" Visible="True"></asp:Label> 
        </div>    
      </div>
      
      
    
      <div class="col-md-6 col-xs-12 " style="" >
          <input type="text" runat="server" name="fname" ID="txtfname" placeholder="First Name" class="logineb" />
          <%--<asp:RequiredFieldValidator ID="rfvFname" EnableViewState="false" runat="server" ErrorMessage="Firstname is required" Display="Dynamic"
                       ControlToValidate="txtfname"  ValidationGroup="gpProfile" ></asp:RequiredFieldValidator>--%>
      </div> 
      
      <div class="col-md-6 col-xs-12 " style="" >
          <input type="text" runat="server" name="lname" ID="txtlname" placeholder="Last Name" class="logineb" />
                    
      </div> 
      <div class="col-md-6 col-xs-12 " style="" >
          <input type="text" runat="server" name="org" ID="txtorg" placeholder="Organization" class="logineb" />
         <%-- <asp:RequiredFieldValidator ID="rfvtxtorg" EnableViewState="false" runat="server" ErrorMessage="Organization is required" Display="Dynamic"
                       ControlToValidate="txtorg"  ValidationGroup="gpProfile"  CssClass="col-md-6 col-xs-12"></asp:RequiredFieldValidator>--%>
      </div> 
      <div class="col-md-6 col-xs-12 " style="" >
          <input type="text" runat="server" name="desig" ID="txtdesig" placeholder="Designation" class="logineb" />
         <%-- <asp:RequiredFieldValidator ID="rfvdesignation" EnableViewState="false" runat="server" ErrorMessage="Designation is required" Display="Dynamic"
                       ControlToValidate="txtdesig"  ValidationGroup="gpProfile"  CssClass="col-md-6 col-xs-12"></asp:RequiredFieldValidator>--%>
      </div>
      
      <div class="relinw"></div>  
      
      <div class="reblockadd">
        <div class="textforget">Description</div>     
      </div>
      
      <div class="reblockadd1">
       <div class="col-md-12" >
           <%--<textarea name="text1" runat="server" ID="txtAbout" placeholder="About Influencer" class="loginebd"></textarea>--%>
            <FTB:FreeTextBox runat="server" ID="txtAbout" ButtonSet="OfficeMac" 
          Height="200px" 
          ToolbarLayout="JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent; InsertRule|Cut,Copy,Paste;Print" 
          ToolbarStyleConfiguration="Office2000" Width="100%"></FTB:FreeTextBox>
           <asp:RequiredFieldValidator ID="rfvAbout" EnableViewState="false" runat="server" ErrorMessage="This field is required" Display="Dynamic"
                       ControlToValidate="txtAbout"  ValidationGroup="gpProfile" ></asp:RequiredFieldValidator>
       </div>   
      </div>
      
      <div class="reblockadd">
        <div class="textforget">Timeline of Projects</div>     
      </div>
      
      <div class="reblockadd1">
       <div class="col-md-12" >
          <%--<textarea name="editor1" class="ckeditor" runat="server" ID="txtTop" Height="200px" Width="100%"></textarea>
   <script type="text/javascript">
       CKEDITOR.replace('editor1');
       CKEDITOR.add            
   </script>--%>
    <FTB:FreeTextbox runat="server" ID="txtTop" ButtonSet="OfficeMac" 
          Height="200px" 
          ToolbarLayout="JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent; InsertRule|Cut,Copy,Paste;Print" 
          ToolbarStyleConfiguration="Office2000" Width="100%"></FTB:FreeTextbox>
       </div>   
      </div>
      
      <div class="reblockadd">
        <div class="textforget">Editorial Calender</div>     
      </div>
      
      <div class="reblockadd1">
       <div class="col-md-12" >
           <%--<textarea name="editor1" class="ckeditor" runat="server" ID="txtECalendar" Height="200px" Width="100%"></textarea>
   <script type="text/javascript">
       CKEDITOR.replace('editor1');
       CKEDITOR.add            
   </script>  --%>
    <FTB:FreeTextbox runat="server" ID="txtECalendar" ButtonSet="OfficeMac" 
          Height="200px" 
          ToolbarLayout="JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent; InsertRule|Cut,Copy,Paste;Print" 
          ToolbarStyleConfiguration="Office2000" Width="100%"></FTB:FreeTextbox>
       </div>   
      </div>
      <div class="relinw"></div> 
      
      <div class="reblockadd">
        <div class="textforget">Website URL</div>     
      </div> 
      
        <div style=" clear:both; margin-left:28px;"><b><i>Sample URL:</i></b> www.abc.com</div>
      <div class="rewebblock">
         <div class="reb1"><label  name="login" id="login" class="hvr-sweep-to-right3">Http://</label></div>
         <div class="reb2"><input type="text" runat="server" name="search" ID="txtWeb" placeholder="" value="" class="sein2" /></div>   
      </div>
      
      <div class="relinw"></div>
      
      
      <div class="reblockadd">
        <div class="textforget">Location</div>     
      </div> 
      
    <div class="reblockadd1">
       <div class="col-md-12" ><input type="text" runat="server" name="add1" ID="txtAddress1" placeholder="Address 1" class="logineb" />
        <asp:RequiredFieldValidator ID="rfvAddress1" EnableViewState="false" runat="server" ErrorMessage="Address 1 is required" Display="Dynamic"
                       ControlToValidate="txtAddress1"  ValidationGroup="gpProfile"  ></asp:RequiredFieldValidator>  
       </div> 
    </div>
    
    <div class="reblockadd1">
       <div class="col-md-12" ><input type="text" runat="server" name="add2" ID="txtAddress2" placeholder="Address 2 Optional" class="logineb" /></div>   
    </div>
    
      <div class="col-md-6 col-xs-12 " style="" ><input type="text" runat="server" name="country" ID="txtCountry" placeholder="USA" value="USA" class="logineb" readonly="readonly" />
    </div> 
    
    
      <div class="col-md-6 col-xs-12 " style="margin-bottom:1px;" >
         <asp:dropdownlist runat="server" ID="ddStates" CssClass="loginebs">
              <asp:ListItem  Value="0">--- Select ---</asp:ListItem>
              <asp:ListItem>Alabama</asp:ListItem>
	<asp:ListItem>Alaska</asp:ListItem>
	<asp:ListItem>Arizona</asp:ListItem>
	<asp:ListItem>Arkansas</asp:ListItem>
	<asp:ListItem>California</asp:ListItem>
	<asp:ListItem>Colorado</asp:ListItem>
	<asp:ListItem>Connecticut</asp:ListItem>
	<asp:ListItem>Delaware</asp:ListItem>
	<asp:ListItem>District Of Columbia</asp:ListItem>
	<asp:ListItem>Florida</asp:ListItem>
	<asp:ListItem>Georgia</asp:ListItem>
	<asp:ListItem>Hawaii</asp:ListItem>
	<asp:ListItem>Idaho</asp:ListItem>
	<asp:ListItem>Illinois</asp:ListItem>
	<asp:ListItem>Indiana</asp:ListItem>
	<asp:ListItem>Iowa</asp:ListItem>
	<asp:ListItem>Kansas</asp:ListItem>
	<asp:ListItem>Kentucky</asp:ListItem>
	<asp:ListItem>Louisiana</asp:ListItem>
	<asp:ListItem>Maine</asp:ListItem>
	<asp:ListItem>Maryland</asp:ListItem>
	<asp:ListItem>Massachusetts</asp:ListItem>
	<asp:ListItem>Michigan</asp:ListItem>
	<asp:ListItem>Minnesota</asp:ListItem>
	<asp:ListItem>Mississippi</asp:ListItem>
	<asp:ListItem>Missouri</asp:ListItem>
	<asp:ListItem>Montana</asp:ListItem>
	<asp:ListItem>Nebraska</asp:ListItem>
	<asp:ListItem>Nevada</asp:ListItem>
	<asp:ListItem>New Hampshire</asp:ListItem>
	<asp:ListItem>New Jersey</asp:ListItem>
	<asp:ListItem>New Mexico</asp:ListItem>
	<asp:ListItem>New York</asp:ListItem>
	<asp:ListItem>North Carolina</asp:ListItem>
	<asp:ListItem>North Dakota</asp:ListItem>
	<asp:ListItem>Ohio</asp:ListItem>
	<asp:ListItem>Oklahoma</asp:ListItem>
	<asp:ListItem>Oregon</asp:ListItem>
	<asp:ListItem>Pennsylvania</asp:ListItem>
	<asp:ListItem>Rhode Island</asp:ListItem>
	<asp:ListItem>South Carolina</asp:ListItem>
	<asp:ListItem>South Dakota</asp:ListItem>
	<asp:ListItem>Tennessee</asp:ListItem>
	<asp:ListItem>Texas</asp:ListItem>
	<asp:ListItem>Utah</asp:ListItem>
	<asp:ListItem>Vermont</asp:ListItem>
	<asp:ListItem>Virginia</asp:ListItem>
	<asp:ListItem>Washington</asp:ListItem>
	<asp:ListItem>West Virginia</asp:ListItem>
	<asp:ListItem>Wisconsin</asp:ListItem>
	<asp:ListItem>Wyoming</asp:ListItem>
    </asp:dropdownlist>
     <asp:RequiredFieldValidator ID="rfvState" EnableViewState="false" runat="server" ErrorMessage="State is required" Display="Dynamic"
                       ControlToValidate="ddStates"  ValidationGroup="gpProfile" InitialValue="0" ></asp:RequiredFieldValidator> 
    </div> 
      
      <div class="col-md-6 col-xs-12 " style="" >
          <input type="text" runat="server" name="city" ID="txtCity" placeholder="City" class="logineb" />
           <asp:RequiredFieldValidator ID="rfvCity" EnableViewState="false" runat="server" ErrorMessage="City is required" Display="Dynamic"
                       ControlToValidate="txtCity"  ValidationGroup="gpProfile"  ></asp:RequiredFieldValidator> 
      </div> 
      <div class="col-md-6 col-xs-12 " style="" >
          <input type="text" runat="server" name="zip" ID="txtzip" placeholder="zip/Postal Code" class="logineb" />
           <asp:RequiredFieldValidator ID="rfvZip" EnableViewState="false" runat="server" ErrorMessage="This field is required" Display="Dynamic"
                       ControlToValidate="txtzip"  ValidationGroup="gpProfile" ></asp:RequiredFieldValidator> 
      </div>
      
      <div class="col-md-6 col-xs-12 " style="" >
          <input type="text" runat="server" name="phone" ID="txtPhone" placeholder="Phone Number" class="logineb" />
           <asp:RequiredFieldValidator ID="rfvPhone" EnableViewState="false" runat="server" ErrorMessage="Phone Number is required" Display="Dynamic"
                       ControlToValidate="txtPhone"  ValidationGroup="gpProfile" ></asp:RequiredFieldValidator> 
      </div> 
      <div class="col-md-6 col-xs-12 " style="" >
          <input type="text" runat="server" name="email" ID="txtEmail" 
              placeholder="Email Address" class="logineb" readonly="readonly" />
           <asp:RequiredFieldValidator ID="rfvEmail" EnableViewState="false" runat="server" ErrorMessage="Email is required" Display="Dynamic"
                       ControlToValidate="txtEmail"  ValidationGroup="gpProfile" ></asp:RequiredFieldValidator> 
          <asp:regularexpressionvalidator runat="server" ID="revEmail" 
              errormessage="Please enter valid email address" ControlToValidate="txtEmail" 
              ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:regularexpressionvalidator>
          
      </div>
      
      
      <div class="relinw" style="display:none;"></div>
      <div class="reblockadd1">
            <div class="col-md-12">
                <button type="button" runat="server" name="signup" ID="btnSignup" class="hvr-sweep-to-rightup2" style="float:right" ValidationGroup="gpProfile" OnServerClick="btnSignup_ServerClick">Submit</button>                     
            </div> <!-- col-md-6-->
      </div>

    
    
   </div></div><!--col-md-10 col-sm-12 col-xs-12--> 
   
   
       
</div><!--wrapperblock-->
<!--text-->  


<!--footer-->
  <div class="footerbg">
     <div class="row">
        <div class="col-md-11 col-xs-10">©2016 Press Preview</div>
        <div class="col-md-pull-1 col-xs-pull-1">
           <%--<div class="f1"><a href=""></a></div>
           <div class="f2"><a href="">EXPAND</a></div>--%>
        </div>
      </div>    
  </div><!--footer-->
<!--footer-->
<!--#INCLUDE FILE="../includes/backtotop.txt" -->
<script src="../js/backtotop.js" type="text/javascript"></script>
</div><!--wrapper-->

    <!-- Javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->

    <script src="../masonry/js/libs/imagesloaded.3.1.8.min.js"></script>
    <script src="../masonry/js/libs/jquery.masonry.3.2.1.min.js"></script>
    <script src="../masonry/js/base.js" type="text/javascript"></script>
    		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    		<script type="text/javascript">

    		    function DropDown(el) {
    		        this.dd = el;
    		        this.initEvents();
    		    }
    		    DropDown.prototype = {
    		        initEvents: function () {
    		            var obj = this;

    		            obj.dd.on('click', function (event) {
    		                jQuery(this).toggleClass('active');
    		                event.stopPropagation();
    		            });
    		        }
    		    }

    		    jQuery(function () {

    		        var dd = new DropDown($('#dd'));

    		        jQuery(document).click(function () {
    		            // all dropdowns
    		            jQuery('.wrapper-dropdown-5').removeClass('active');
    		        });

    		    });

    		    jQuery(function () {

    		        var dd = new DropDown(jQuery('#dd1'));

    		        jQuery(document).click(function () {
    		            // all dropdowns
    		            jQuery('.wrapper-dropdown-5').removeClass('active');
    		        });

    		    });

		</script>
        <script type="application/javascript" src="../js/custom.js"></script>
        <script type="text/javascript">
            function openfileDialog() {
                $("#fupCover").click();
            }

            function openprofilePicDialog() {
                $("#fupCover").click();
            }

            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new window.FileReader();
                    reader.onload = function(e) {
                        $('#blah')
                            .attr('src', e.target.result)
                            .width('100%')
                            .height(200);
                    };

                    reader.readAsDataURL(input.files[0]);
                }
            }

            $("#fupCover").change(function () {
                readURL(this);
            });
        </script>
       <script type="text/javascript">
          $("#imgCover").click(function(){
      $("#coverPicChange").click(); 
     });
           $(document).ready(function () {
               var userId = '<%= Request.Cookies["FRUserId"].Value %>';
               $("#lbViewMessageCount").click(function () {

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


               $("#lbViewAlerts").click(function () {

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
    <script src="../source/jquery.fancybox.pack.js" type="text/javascript"></script>
      <script type="text/javascript">
          $(document).ready(function () {
              $(".fancybox").fancybox({
                  fitToView: true,
                  frameWidth: '100%',
                  frameHeight: '100%',
                  width: '100%',
                  height: '100%',
                  autoSize: false,
                  helpers: {
                      overlay: { closeClick: false} // prevents closing when clicking OUTSIDE fancybox 
                  },
                  closeClick: true,
                  openEffect: 'fade',
                  closeEffect: 'fade',
                  type: "iframe",
                  opacity: 0.7,
                  afterClose: function () {
                      location.reload();
                      return;
                  },
                  onStart: function () {
                      $("#fancybox-overlay").css({ "position": "fixed" });
                  }
              });
          });
</script>

</form>
</body>
</html>
