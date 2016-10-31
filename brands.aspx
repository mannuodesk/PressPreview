﻿<%@ Page Language="C#" AutoEventWireup="true"  EnableViewStateMac="false" CodeFile="brands.aspx.cs" Inherits="home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Brands List</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<!--lightbox-->
	<script type="text/javascript" src="../source/jquery.fancybox.js?v=2.1.5"></script>
	<link rel="stylesheet" type="text/css" href="../source/jquery.fancybox.css?v=2.1.5" media="screen" />
<script src="../ckeditor/ckeditor.js"></script>
<script src="../js/sample.js"></script>
<script type="text/javascript">
		jQuery(document).ready(function() {
			jQuery('.fancybox').fancybox();
		});
	</script>   
<script>
   jQuery(document).ready(function(){
   jQuery("#loaddata").click(function(){ 
   jQuery.ajax({url:"loadpage/home1.html",success:function(ajaxresult){
   jQuery("#ajaxrequest").html(ajaxresult);
  }});
 });
 
 jQuery("#loaddatan").click(function(){ 
   jQuery.ajax({url:"loadpage/home1.html",success:function(ajaxresult){
   jQuery("#ajaxrequest").html(ajaxresult);
  }});
 });
});
</script>
     
    <style type="text/css">
        .alphbets
        {
            margin:0 auto; padding: 0 10px; cursor: pointer; display: inline; color: #212121;
        }
        .alphbets:active
        {
           font-weight:bold;
        }
    </style>
</head>

<body>
<form runat="server" id="frmBrands">
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
            <!--#INCLUDE FILE="../includes/messgTop.txt" -->            
         <div class="col-md-3">   
           
         </div>   
                       
            <ul class="nav navbar-nav" id="firstbb">
              <li><a href="Default.aspx">Activity</a></li>
              <li><a href="discover.aspx">Discover</a></li>
              <li class="active"><a href="brands.aspx">Brands</a></li>
               <li><a href="events.aspx">Events</a></li>
            </ul>            
             
              <ul class="nav navbar-nav navbar-right">
		     <li> <a href="editor-profile.aspx" style="margin-top: 10px;"><asp:Label runat="server" ID="lblUsername" ></asp:Label></a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                  <asp:Image runat="server" ID="imgUserIcon" ImageUrl="../images/menuright.png" CssClass="img-circle" style="width: 36px; height: 36px;"></asp:Image> <span> <img src="../images/triangle.png" /></span></a>
                <ul class="dropdown-menu"><li><a href="editor-profile.aspx"><img src="../images/profile.png" /><span class="sp"> My Profile</span></a></li>
                  <li><a href="#"><img src="../images/help.png" /><span class="sp"> Help</span></a></li>
                  <li><a href="../logout.aspx"><img src="../images/logout.png" /><span class="sp"> Log Out</span></a></li>
                </ul>
              </li>
            </ul> 
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>

    </div><!--header bg-->
<!--Headerend-->

<!--Banner-->
     <!--#INCLUDE FILE="../includes/banner.txt" --> 
<!--bannerend-->


<!--text-->
<div class="wrapper">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <div id="dvLoading"></div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="col-md-12">
                <div id="divAlerts" runat="server" class="alert" visible="False">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                        Text="" Visible="True"></asp:Label>
                </div>
                <div class="starter-template">
                    <h6>BRAND</h6>
                    <h1>The List</h1>
                    <div class="sline">
                        <img src="../images/line.png" /></div>
                </div>
            </div>
            <div class="col-md-12 col-xs-12">
                <div style="width: 100%; text-align: center;">
                    <asp:Repeater ID="rptAlphabets" runat="server">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkAlphabet" runat="server" CssClass="alphbets" Text='<%#Eval("Value")%>' OnClick="Alphabet_Click"
                                Enabled='<%# Eval("isNotSelected")%>' />

                        </ItemTemplate>
                    </asp:Repeater>

                </div>
               
            </div>
            <!--col-md-12-->

            <!--text-->
            <!-- START THE BRANDS LIST -->
            <div class="col-md-12" id="letter2">
                <div style="width: 80%; margin: 0 auto;">
                     <div class="starter-template">
                    <h6><asp:Label ID="lblView" runat="server" Text=""></asp:Label></h6>
                   <div class="sline">
                        <img src="../images/line.png" /></div>
                </div>
                  
                    <asp:DataList ID="dlBrands" runat="server" CssClass="brandlist" RepeatColumns="3" Width="100%">
                        <ItemTemplate>
                            <ul>
                                <li><a class="fancybox" href="profile-page-items.aspx?v=<%# Eval("UserID") %>"><%# Eval("Name","{0}") %></a></li>
                            </ul>
                        </ItemTemplate>
                    </asp:DataList>
                </div>
                <!--col-md-6-->
                <!--col-md-6-->

            </div>
            <!--col-md-12-->
            <!-- /END THE BRANDS LIST -->
        </ContentTemplate>
    </asp:UpdatePanel>   
</div><!--wrapperblock-->
<!--footer-->
  <div class="footerbg">
     <div class="row">
       <div class="col-md-11 col-xs-10">©<%: DateTime.Now.Year %> Press Preview</div>
        <div class="col-md-pull-1 col-xs-pull-1">
           <div class="f1"><a id="loaddata"></a></div>
           <div class="f2"><a id="loaddatan">Expand>/div>
        </div>
      </div>    
  </div><!--footer-->
<!--footer-->

</div><!--wrapper-->

<script src="../js/bootstrap.js"></script>
</form>

</body>
</html>
