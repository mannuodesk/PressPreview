﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="edit-profile.aspx.cs" Inherits="home" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<%@ Register TagPrefix="cc1" Namespace="CS.WebControls" Assembly="CS.WebControls.WebCropImage" %>

<!DOCTYPE>

<html>
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Edit Profile</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../css/checkbox.css"/>

<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
<script type="text/javascript" src="../js/modernizr.custom.79639.js"></script> 
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <link href="../source/jquery.fancybox.css" rel="stylesheet" type="text/css" />
    
<script src="../ckeditor/ckeditor.js"></script>
<script src="../js/sample.js"></script>
<script type="text/javascript" src="../js/jssor.slider.min.js"></script>
<script src="../js/homepage.js"></script>
<link rel="stylesheet" href="../jcrop/css/style.css" />
<link rel="stylesheet" href="../jcrop/css/jquery.Jcrop.min.css" type="text/css" />
<script type="text/javascript" src="../jcrop/js/jquery.min.js"></script>
<script src="../jcrop/js/jquery.Jcrop.min.js"></script>
<script type="text/javascript" src="../jcrop/js/script.js"></script>
  
<%-- <script type="text/javascript">
    jQuery(document).ready(function () {
        jQuery('#imgCrop').Jcrop({
            onSelect: storeCoords
        });
    });

    function storeCoords(c) {
        jQuery('#X').val(c.x);
        jQuery('#Y').val(c.y);
        jQuery('#W').val(c.w);
        jQuery('#H').val(c.h);
    };

    
</script>--%>
   <%--<script type="text/javascript">
       function previewFile() {
           var preview = document.querySelector('#<%=imgMain.ClientID %>');
           var file = document.querySelector('#<%=photo.ClientID %>').files[0];
           var reader = new window.FileReader();
           reader.onload = function (e) {
               var img = new Image;
               img.onload = function () {
                   $('#cropbox').attr('src', e.target.result).css('max-width', '640px');
               };
               img.src = reader.result;
           };
           reader.onloadend = function () {
               preview.src = reader.result;
               reader.result.width = '640px';
               preview.height = '480px';
               show_popup_crop(preview.src);
           };
           if (file) {
               reader.readAsDataURL(file);
           } else {
               preview.src = "";
           }
       }
    </script>--%>
    
   
</head>

<body>
    
<form runat="server" ID="frm_Profile">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
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
            <div class="col-md-3">   
            <!--#INCLUDE FILE="../includes/messgTop.txt" --> 
            </div>    
             <ul class="nav navbar-nav" id="firstbb">
              <li><div class="gab1"></div></li>
              <li class="dropdown">
                <a href="event.aspx">Events</a>
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


<!--text-->
<div class="wrapperblockedit" style="background:#fff;">

<!--Banner-->
    <div class="" id="photo_container">
      <a href="#" ><asp:Image runat="server" Id="imgCover" class="img-responsive" ImageUrl="../images/bggreyi.jpg"  alt="profileimage" style="width:100%; height:252px;" /></a>
         
    </div>
   
<!--bannerend-->


     <div class="remainblock">
         
          <div class="replaytext">
             <a id="coverpic"  href="../lightbox/CoverPic.aspx" ><img src="../images/replaceimage.png" /></a>
          </div><div class="lines"><hr /></div>
          <div class="replaimg"><a href="#"><asp:Image ID="imgProfile"  ImageUrl="../images/follo.png" runat="server" CssClass="img-circle" style="border-width:0px;width: 93px;height: 93px;"/></a></div>
          <div class="replaimg"><a href="../changeProfile/" ><img  src="../images/replaceimage1.png" /></a></div>
          <div class="lines"><hr /></div>
          <asp:updatepanel runat="server">
             <ContentTemplate>
             
              <div id="dvAlert2" runat="server" class="alert" visible="False" style="margin:20px;">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <asp:Label runat="server" ID="lblSocialS" for="PageMessage"
                Text="" Visible="True"></asp:Label> 
        </div>  
          <div class="likeblock">
            <div class="blockshare">
              <div class="lineimage"><img src="../images/additemline.jpg" /></div>
              <div class="lineimage1" style="margin-left:-10px;"><img src="../images/sminsta.jpg" /></div>
              <div class="reinput"><input runat="server" ID="txtInstagram" class="seinre" placeholder="Enter Instagram Link" /></div>
             </div>   
             
              <div class="relinw"></div>
          </div><!--likeblock-->
          
          <div class="likeblock">
            <div class="blockshare">
              <div class="lineimage"><img src="../images/additemline.jpg" /></div>
              <div class="lineimage1" style="margin-left:-10px;"><img src="../images/smtwitter.jpg" /></div>
              <div class="reinput"><input class="seinre" runat="server" ID="txtTwitter" placeholder="Enter Twitter Link" /></div>
            </div>  
             
              <div class="relinw"></div>
          </div><!--likeblock-->
          
          <div class="likeblock">
            <div class="blockshare">
              <div class="lineimage"><img src="../images/additemline.jpg" /></div>
              <div class="lineimage1" style="margin-left:-10px;"><img src="../images/smfacebook.jpg" /></div>
              <div class="reinput"><input class="seinre" runat="server" ID="txtFacebook" placeholder="Enter Facebook Link" /></div>
            </div>  
             
              <div class="relinw"></div>
          </div><!--likeblock-->
          
          <div class="likeblock">
            <div class="blockshare">
              <div class="lineimage"><img src="../images/additemline.jpg" /></div>
              <div class="lineimage1" style="margin-left:-10px;"><img src="../images/smyoutube.jpg" /></div>
              <div class="reinput"><input class="seinre" runat="server" ID="txtYoutube" placeholder="Enter Youtube Link" /></div>
            </div>   
             
              <div class="relinw"></div>
          </div><!--likeblock-->
          
          <div class="likeblock">
            <div class="blockshare">
              <div class="lineimage"><img src="../images/additemline.jpg" /></div>
              <div class="lineimage1" style="margin-left:-10px;"><img src="../images/smpinterest.jpg" /></div>
              <div class="reinput"><input class="seinre" runat="server" ID="txtPinterest" placeholder="Enter Pinterest Link" /></div>
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
        <div class="textforget">Brand Information</div> 
        <div id="divAlerts" runat="server" class="alert" visible="False">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                Text="" Visible="True"></asp:Label> 
        </div>    
      </div>
      
      <div class="reblockadd1">
       <div class="col-md-12" >
           <input type="text" runat="server" name="bname" ID="txtbname" placeholder="Brand Name" class="logineb" />
            <asp:RequiredFieldValidator ID="rfvBname" EnableViewState="false" runat="server" ErrorMessage="Name is required" Display="Dynamic"
                       ControlToValidate="txtbname"  ValidationGroup="gpProfile"  ></asp:RequiredFieldValidator>
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
           <textarea name="text1" runat="server" ID="txtAbout" placeholder="About The Brand" class="loginebd"></textarea>
           <asp:RequiredFieldValidator ID="rfvAbout" EnableViewState="false" runat="server" ErrorMessage="This field is required" Display="Dynamic"
                       ControlToValidate="txtAbout"  ValidationGroup="gpProfile"  CssClass="validationSummary"></asp:RequiredFieldValidator>
       </div>   
      </div>
      
      <div class="reblockadd">
        <div class="textforget">Brand History</div>     
      </div>
      
      <div class="reblockadd1">
       <div class="col-md-12" ><textarea name="text2" runat="server" ID="txtHistory" placeholder="Brand History " class="loginebd"></textarea></div>   
      </div>
      
      <div class="relinw"></div> 
      
      <div class="reblockadd">
        <div class="textforget">Website URL</div>     
      </div> 
      
      <div style=" clear:both; margin-left:28px;"><b><i>Sample URL:</i></b> www.abc.com</div>
      <div class="rewebblock">
         <div class="reb1"><label type="submit" name="login" id="login" class="hvr-sweep-to-right3">Http://</label></div> 
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
          <input type="text" runat="server" name="email" ID="txtEmail" readonly="readonly" placeholder="Email Address" class="logineb" />
           <asp:RequiredFieldValidator ID="rfvEmail" EnableViewState="false" runat="server" ErrorMessage="Email is required" Display="Dynamic"
                       ControlToValidate="txtEmail"  ValidationGroup="gpProfile" ></asp:RequiredFieldValidator> 
          <asp:regularexpressionvalidator runat="server" ID="revEmail" 
              errormessage="Please enter valid email address" ControlToValidate="txtEmail" 
              ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:regularexpressionvalidator>
          
      </div>
      
      <div class="relinw"></div>
      
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
           <div class="f1"><a href=""><img src="../images/footerarrow.png" /></a></div>
           <div class="f2"><a href="">EXPAND</a></div>
        </div>
      </div>    
  </div><!--footer-->
<!--footer-->

</div><!--wrapper-->

 
    <!-- Javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="../js/bootstrap.js"></script>
    <script src="../masonry/js/libs/imagesloaded.3.1.8.min.js"></script>
    <script src="../masonry/js/libs/jquery.masonry.3.2.1.min.js"></script>
    <script src="../masonry/js/base.js" type="text/javascript"></script>
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
    <script src="../source/jquery.fancybox.pack.js" type="text/javascript"></script>
      <script type="text/javascript">
          $(document).ready(function () {
              $("#coverpic").fancybox({
                 fitToView   : true,
    frameWidth  : '100%',
    frameHeight: '100%',
    width:'100%',
                 height:'100%',
    autoSize    : false,
    closeClick  : true,
    openEffect  : 'none',
    closeEffect : 'none',
    type: "iframe",
    opacity:0.7
   
              });
          });
</script>
	<!-- custom scrollbar plugin -->
	<%--<script src="../customscroller/jquery.mCustomScrollbar.concat.min.js"></script>--%>
</form>
</body>
</html>
