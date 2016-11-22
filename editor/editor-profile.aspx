<%@ Page Language="C#" AutoEventWireup="true" CodeFile="editor-profile.aspx.cs" Inherits="editor_editor_profile" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Editor Profile Page Information</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="../source/jquery.fancybox.css" media="screen" />

<!--custom scroller-->

    <link rel="stylesheet" type="text/css" href="../customscroller/jquery.mCustomScrollbar.css" media="screen" />

	<script src="../customscroller/jquery.mCustomScrollbar.concat.min.js"></script>
	<script>
	    (function (jQuery) {
	        jQuery(window).load(function () {

	            jQuery("#content-1").mCustomScrollbar({
	                theme: "minimal"
	            });

	        });
	    })(jQuery);
	</script>
    
    <script type="text/javascript">
        function HideLabel() {
            setTimeout(function () { $('#divAlerts').fadeOut(); }, 4000);

        };
</script>
</head>

<body>
<form runat="server" ID="frmProfile">
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
<!--Banner-->
    <div class="banner"><asp:Image runat="server" Id="imgCover" class="img-responsive" ImageUrl="../images/bggreyi.jpg"  alt="profileimage" style="width:100%" /></div>
<!--bannerend-->

<!--text-->
<div class="wrapperblockwhite">
     <div class="col-md-3 col-xs-12 blockp">
         <div class="editblock">
          <div class="col-md-8 col-xs-12 pheading">
                <a href="#" runat="server" id="lblEditorName"></a>                
          </div><!--col-md-12-->
          <div class="editbut">
              <a href="edit-profile.aspx" class="hvr-sweep-to-rightp12"> <i class="fa fa-pencil" aria-hidden="true"></i> Edit Profile</a>                  
                <%-- <button type="button" runat="server" name="signup" ID="btnEditProfile" OnServerClick="btnEditProfile_OnServerClick" class="hvr-sweep-to-rightp12" >
                <i class="fa fa-pencil" aria-hidden="true"></i> Edit Profile</button> --%>
            </div>
       </div> <!--editblock--> 
          <div class="col-md-5 col-xs-12 pimage">
               <asp:Image ID="imgProfile" CssClass="img-circle"  ImageUrl="../images/follo.png" runat="server" style="border-radius:50%;"/>
          </div><!--col-md-12-->
          <div class="col-md-7 col-xs-12 phtext">
               <img src="../images/location.png" alt="location" style="margin-right:6px;"  /> <asp:Label runat="server" ID="lblCity"></asp:Label>, <asp:Label runat="server" ID="lblCountry"></asp:Label><br />
               <a href="#" runat="server" ID="lblWebURL" target="_blank" style="word-wrap: break-word;"></a>               
          </div><!--col-md-12-->
          
       <div class="mesblockinf">
               <asp:LinkButton runat="server" ID="lbtnMassenger" 
                   onclick="lbtnMassenger_Click" >
                   <i class="fa fa-envelope" aria-hidden="true"></i> Messenger
               </asp:LinkButton>
                <a href="massenger.aspx"></a>
          </div>
          <div class="col-md-10 col-xs-8 ptext">
                <i class="fa fa-eye" aria-hidden="true"></i> Views
          </div><!--col-md-12-->
          <div class="col-md-1 col-xs-1 ptext">
              <asp:Label runat="server" ID="lblTotolViews" ></asp:Label>          
          </div><!--col-md-12-->
          <!--<div class="col-md-10 col-xs-8 ptext">
               <img src="images/followers.png" alt="image" style="margin-left:-4px; margin-right:6px;"/><a href="">Followers</a>
          </div><!--col-md-12
          <div class="col-md-1 col-xs-1 ptext">
              96        
          </div><!--col-md-12-->
          <div class="lines"><hr /></div>
          
          <!--<div class="col-md-8 col-xs-12 cheading">
             Categories
          </div>
          <div class="col-md-11 col-xs-12 ptext1">
             <ul><li><a href="">Dresses,</a></li> 
                 <li><a href="">Heels,</a></li> 
                 <li><a href="">Tops,</a></li> 
                 <li><a href="">Outdoor</a></li></ul>
          </div>
           <div class="lines"><hr /></div>
          
          <div class="col-md-8 col-xs-12 cheading">
             Seasons
          </div>
          <div class="col-md-11 col-xs-12 ptext1">
             <ul><li><a href="">Summer,</a></li> 
                 <li><a href="">Fall,</a></li> 
                 <li><a href="">Winter,</a></li> 
                 <li><a href="">Spring</a></li></ul>
          </div>          
          <div class="lines"><hr /></div>-->
          
         
         <div id="socaill"> 
          <div class="col-md-8 col-xs-12 cheading">
             On The Web
          </div>
          <div class="col-md-12 col-xs-12 ptext2">
           <asp:Repeater ID="Repeater2" runat="server" DataSourceID="sdsSocialLinks">
                      <ItemTemplate>
                          <a href="<%# Eval("InstagramURL") %>" target="_blank"><img src="../images/pins.jpg" /></a> 
                          <a href="<%# Eval("TwitterURL") %>" target="_blank"><img src="../images/ptw.jpg" /></a>
                           <a href="<%# Eval("FbURL") %>" target="_blank"><img src="../images/pfb.jpg" /></a>
                            <a href="<%# Eval("YoutubeURL") %>" target="_blank"><img src="../images/youtube.png" /></a>
                            <a href="<%# Eval("PinterestURL") %>" target="_blank"><img src="../images/ppin.jpg" /></a>                         
                      </ItemTemplate>
                  </asp:Repeater>
                  <asp:SqlDataSource runat="server" ID="sdsSocialLinks" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                    SelectCommand="SELECT 'http://' + REPLACE(FbURL,'http://','') as FbURL,'http://' + REPLACE(TwitterURL,'http://','') as TwitterURL ,
'http://' + REPLACE(InstagramURL,'http://','') as InstagramURL ,
'http://' + REPLACE(YoutubeURL,'http://','') as YoutubeURL,
'http://' + REPLACE(PinterestURL,'http://','') as PinterestURL
 From Tbl_Editors WHERE UserID=?"> 
                      <SelectParameters>
                          <asp:SessionParameter SessionField="UserID" Name="?"></asp:SessionParameter>
                      </SelectParameters>
                  </asp:SqlDataSource>  
         </div>
         </div>
     </div><!--blockp-->
     
     <div class="col-md-9 col-xs-12">
           
                       <div class="searchpro1">
                         <div class="inwhtext"><b><a href="editor-profile.aspx" style="color:#000">Information</a></b></div>
                         <div class="inwhtext"><a href="editor-wishlist.aspx">Wishlist</a></div>
                            
                       </div><!--searchpro-->
                       <div class="lines"><hr /></div>
           
           
    <!-- START THE FEATURETTES -->
         <div class="col-md-12">
             <div id="divAlerts" runat="server" class="alert" visible="False">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                        Text="" Visible="True"></asp:Label>
                </div>
           <div class="col-md-11 col-xs-12 cheading">
             About
          </div>
          <div class="col-md-12 col-xs-12 ptext2">
            <asp:Label runat="server" ID="lblAbout"></asp:Label>
          </div>
          
         </div><!--col-md-12-->
     <!-- /END THE FEATURETTES -->
     <div class="lines"><hr /></div>
     
     <!-- START THE FEATURETTES -->
         <div class="col-md-12">
           <div class="col-md-11 col-xs-12 cheading">
             Timeline of Project
          </div>
          <div class="col-md-12 col-xs-12 ptext2list">
             <asp:Label runat="server" ID="lblTimeLine"></asp:Label>
           </div>          
         </div><!--col-md-12-->
     <!-- /END THE FEATURETTES -->
     
     <div class="lines"><hr /></div>
     
      <!-- START THE FEATURETTES -->
         <div class="col-md-12">
           <div class="col-md-11 col-xs-12 cheading">
             Editorial Calender
          </div>
          <div class="col-md-12 col-xs-12 ptext2list">
           <asp:Label runat="server" ID="lblEditorialCalender"></asp:Label>   
          </div>
          
         </div><!--col-md-12-->
     <!-- /END THE FEATURETTES -->
     
     
     <div class="lines"><hr /></div>
     
     <div class="row" style="display:none;">
          <div class="col-md-4">
            <input type="password" runat="server" name="oldPass" ID="oldPassword" placeholder="Old Password" class="logineb" />
          </div>
          <div class="col-md-4">
            <input type="password" runat="server" name="newPass" ID="newPassword" placeholder="New Password" class="logineb" />
          </div>
          <div class="col-md-4">
            <button ID="btnChange" runat="server" class="hvr-sweep-to-rightup2" OnServerClick="btnChange_ServerClick">
            Change
        </button>
          </div>
     
     </div><!--list-->
     
     
     <%--<div id="socailm">
          <div class="col-md-12 col-xs-12 cheading">
             On The Web
          </div>
          <div class="col-md-12 col-xs-12 ptext2" >
           <a href="https://www.facebook.com" target="_blank"><img src="images/pfb.jpg" /></a>
           <a href="https://www.twitter.com" target="_blank"><img src="images/ptw.jpg" /></a>
           <a href="https://www.instagram.com/?hl=en" target="_blank"><img src="images/pins.jpg" /></a>
           <a href="https://www.pinterest.com/" target="_blank"><img src="images/pic.jpg" /></a>
           <a href="https://www.pinterest.com/" target="_blank"><img src="images/ppin.jpg" /></a>
         </div>
         <div class="lines"><hr /></div>
    </div>--%>     
     
</div><!--wrapperblock-->
<!--text-->  




<!--footer-->
  <div class="footerbg">
     <div class="row">
        <div class="col-md-11 col-xs-10">©2016 Press Preview</div>
        <div class="col-md-pull-1 col-xs-pull-1">
           <div class="f1"><a id="loaddata"></a></div>
           <div class="f2"><a id="loaddatan">EXPAND</a></div>
        </div>
      </div>    
  </div><!--footer-->
<!--footer-->
<!--#INCLUDE FILE="../includes/backtotop.txt" -->
<script src="../js/backtotop.js" type="text/javascript"></script>
</div><!--wrapper-->

    <script src="../js/bootstrap.js"></script>
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
     
</form>
</body>
</html>

