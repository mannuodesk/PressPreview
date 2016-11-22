

﻿<%@ Page Language="C#" ValidateRequest="false" AutoEventWireup="true" CodeFile="myprofile.aspx.cs" Inherits="pr_brand_myprofile" %>
<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox, Version=3.3.1.12354, Culture=neutral, PublicKeyToken=5962a4e684a48b87" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Complete Your Profile</title>
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
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="../js/modernizr.custom.79639.js"></script> 
 <script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="../js/sample.js"></script>
<link href="../source/jquery.fancybox.css" rel="stylesheet" type="text/css" />
<style>
  #imgUserIcon{
    min-width: 61px;
    margin-right: -22px;
  }
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
</style> 

</head>

<body>
<form runat="server" ID="frm_Profile">
<asp:scriptmanager runat="server">
</asp:scriptmanager>
<div class="wrapper">
<!--Header-->
    <div class="headerbg">
       <div class="wrapperblockmh">
          <div class="col-md-9 col-xs-12">
              <div class="logob"><a href="../Default.aspx"><img src="../images/logo.png" alt="thePRESSPreview" style="width: 200px; margin-top: 10px;"/></a></div>
              <%--<div class="logos"><a href="../Default.aspx">Logo Branding</a></div>--%>
          </div>
          <div class="col-md-3 col-xs-12 alre">
             Already have an account? <span><a href="../login.aspx">Log In</a></span>
          </div>
       </div>
    </div><!--header bg-->
<!--Headerend-->


<!--text-->
<div class="wrapperblockedit">

<!--Banner-->
    <div class="">
         <a href=""><asp:Image runat="server" Id="imgCover" class="img-responsive" ImageUrl="../images/bggreyi.jpg"  alt="profileimage" style="width:100%" /></a>
       
    </div>
<!--bannerend-->


     <div class="remainblock">
          <div class="replaytext">
             <a class="fancybox"  href="../lightbox/CoverPic.aspx?v=c" ><img src="../images/replaceimage.png" /></a>
          </div><div class="lines"><hr /></div>
          <a class="fancybox"  href="../lightbox/CoverPic.aspx?v=p" >
          <div class="replaimg"><a href="#"><asp:Image ID="imgProfile"  ImageUrl="../images/follo.png" runat="server" CssClass="img-circle" style="border-width:0px;width: 93px;height: 93px;"/></a></div>
           <div class="replaimg"><img  src="../images/replaceimage1.png" /></div>
           </a>
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
          
          <%--<div class="likeblock">
              <div class="lineimage"><img src="../images/additemline.jpg" /></div>
             <%-- <div class="reinput"><input class="seinre" placeholder="Enter Link" /></div>--%>
              <%--<div class="resubtext"><a href="">Submit</a></div>
               <div class="resubtext">
                   <button type="button" runat="server" name="signup" ID="btnSubmit_Social_Links" class="hvr-sweep-to-rightup2" style="margin-top: -14px; margin-right: 48px; margin-bottom: 10px; float:right;"   OnServerClick="btnSubmit_Social_Links_OnServerClick" >Submit</button> 
                </div>
             <%-- <div class="recross"><a href=""><img src="../images/smcross.jpg" /></a></div>
          </div>--%><!--likeblock-->
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
          <%--<textarea name="editor1" class="ckeditor" runat="server" ID="txtTop" Height="200px" Width="100%">
       
    </textarea>
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
        <div class="textforget">Editorial Calendar</div>     
      </div>
      
      <div class="reblockadd1">
       <div class="col-md-12" >
            <%--<textarea name="editor1" class="ckeditor" runat="server" ID="txtECalendar" Height="200px" Width="100%"></textarea>
   <script type="text/javascript">
       CKEDITOR.replace('editor1');
       CKEDITOR.add            
   </script>--%>
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
    
    
      <div class="col-md-6 col-xs-12 " style="margin-bottom:1px;" ><select name="selestate" runat="server" ID="ddStates" class="loginebs">
    <option value="0">State/Province</option>  
	<option value="AL">Alabama</option>
	<option value="AK">Alaska</option>
	<option value="AZ">Arizona</option>
	<option value="AR">Arkansas</option>
	<option value="CA">California</option>
	<option value="CO">Colorado</option>
	<option value="CT">Connecticut</option>
	<option value="DE">Delaware</option>
	<option value="DC">District Of Columbia</option>
	<option value="FL">Florida</option>
	<option value="GA">Georgia</option>
	<option value="HI">Hawaii</option>
	<option value="ID">Idaho</option>
	<option value="IL">Illinois</option>
	<option value="IN">Indiana</option>
	<option value="IA">Iowa</option>
	<option value="KS">Kansas</option>
	<option value="KY">Kentucky</option>
	<option value="LA">Louisiana</option>
	<option value="ME">Maine</option>
	<option value="MD">Maryland</option>
	<option value="MA">Massachusetts</option>
	<option value="MI">Michigan</option>
	<option value="MN">Minnesota</option>
	<option value="MS">Mississippi</option>
	<option value="MO">Missouri</option>
	<option value="MT">Montana</option>
	<option value="NE">Nebraska</option>
	<option value="NV">Nevada</option>
	<option value="NH">New Hampshire</option>
	<option value="NJ">New Jersey</option>
	<option value="NM">New Mexico</option>
	<option value="NY">New York</option>
	<option value="NC">North Carolina</option>
	<option value="ND">North Dakota</option>
	<option value="OH">Ohio</option>
	<option value="OK">Oklahoma</option>
	<option value="OR">Oregon</option>
	<option value="PA">Pennsylvania</option>
	<option value="RI">Rhode Island</option>
	<option value="SC">South Carolina</option>
	<option value="SD">South Dakota</option>
	<option value="TN">Tennessee</option>
	<option value="TX">Texas</option>
	<option value="UT">Utah</option>
	<option value="VT">Vermont</option>
	<option value="VA">Virginia</option>
	<option value="WA">Washington</option>
	<option value="WV">West Virginia</option>
	<option value="WI">Wisconsin</option>
	<option value="WY">Wyoming</option>
	                                     </select>
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
          <%-- <div class="f1"><a href=""><img src="images/footerarrow.png" /></a></div>
           <div class="f2"><a href="">EXPAND</a></div>--%>
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

                  closeClick: true,
                  openEffect: 'fade',
                  closeEffect: 'fade',
                  type: "iframe",
                  opacity: 0.7,
                  afterClose: function () {
                      location.reload();
                      return;
                  }

              });
          });
</script>


</form>
</body>
</html>
