﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="events.aspx.cs" Inherits="events_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Press Preview - Events List</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../css/checkbox.css"/>
<link rel="stylesheet" href="../css/bootstrap-select.css">
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>


<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="application/javascript" src="../js/custom.js"></script>
 <link href="../source/jquery.fancybox.css" rel="stylesheet" type="text/css" />
      <script src="../source/jquery.fancybox.pack.js" type="text/javascript"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
   <script src="../js/bootstrap.js"></script>
     <script type="text/javascript">
          $(document).ready(function () {

              $(".fancybox").fancybox({
                  href: $(this).attr('href'),
                  fitToView: true,
                  frameWidth: '90%',
                  frameHeight: '100%',
                  width: '87%',
                  height: '100%',
                  autoSize: false,
                  closeBtn: true,
                  closeClick: false,
                  openEffect: 'fade',
                  closeEffect: 'fade',
                  type: "iframe",
                  opacity: 0.7,
                  onStart: function () {
                      $("#fancybox-overlay").css({ "position": "fixed" });
                  },
                  beforeShow: function () {

                      var url = $(this).attr('href');
                      url = (url == null) ? '' : url.split('?');
                      if (url.length > 1) {
                          url = url[1].split('=');

                          // var id = url.substring(url.lastIndexOf("/") + 1, url.length);
                          var id = url[1];
                          var pageUrl = 'http://presspreview.azurewebsites.net/brand/itemview1?v=' + id;
                          //window.location = pageUrl;
                          window.history.pushState('d', 't', pageUrl);
                      }
                  },
                  beforeClose: function () {
                      window.history.pushState('d', 't', 'http://presspreview.azurewebsites.net/brand/profile-page-items.aspx');

                  }

              });

          });
      </script>
 <script type="text/javascript">
     function HideLabel() {
         setTimeout(function () { $('#divAlerts').fadeOut(); }, 4000);
         $.ajax({
             type: "POST",
             url: "events.aspx\\GetEvents",
             contentType: "application/json; charset=utf-8",
             dataType: "json",
             async: true,
             error: function (jqXhr, textStatus, errorThrown) {
                 alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
             },
             success: function (msg) {
                 var array = [];
                 array = msg.d;
                 for (var i = 0 ; i < array.length; i++) {
                     var temp = "<div class='ntlistbev'>" +
                        "<div class='listimge'>" +
                            "<a href='eventdetails.aspx?e=" + array[i].EventID + "'>" +
                                "<img alt='' style='width:100%' src='../eventpics/" + array[i].EFeaturePic + "' width='353px' height='171px'/>" +
                            "</a>" +
                        "</div>" +
                        "<div class='elistdate'>" +
                            "<label id='lblDate'>" + array[i].StartDate + "<Label>" +
                            "  <label id='lblTime'>" + array[i].StartTime + "<label>" +
                        "</div>" +
                        "<div class='elisttitle'>" +
                            "<a href='eventdetails.aspx?e=" + array[i].EventID + "'>" + array[i].EventTitle + "</a>" +
                        "</div>" +
                        "<div class='elistdate'>" +
                     array[i].EventLocation
                     "</div>  " +
                "</div>";
                     $('#elements').append(temp);
                 }

                 console.log(msg);
             }
         });
     };
     function SearchEvent() {
         console.log("{'title':'" + $('#txtEventTitle').val() + ",city:'" + $('#ddCity').val() + "',category:'" + $('#ddCategory').val() + "'}");
         console.log($('#txtEventTitle').val());
         console.log($('#ddCategory').val());
         $.ajax({
             type: "POST",
             url: "events.aspx\\GetEventsSearching",
             contentType: "application/json; charset=utf-8",
             data: "{'title':'" + $('#txtEventTitle').val() + "',city:'" + $('#ddCity').val() + "',category:'" + $('#ddCategory').val() + "'}",
             dataType: "json",
             async: true,
             error: function (jqXhr, textStatus, errorThrown) {
                 alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
             },
             success: function (msg) {
                 $('#elements').empty();
                 var array = [];
                 array = msg.d;
                 for (var i = 0 ; i < array.length; i++) {
                     var temp = "<div class='ntlistbev'>" +
                        "<div class='listimge'>" +
                            "<a href='eventdetails.aspx?e=" + array[i].EventID + "'>" +
                                "<img alt='' style='width:100%' src='../eventpics/" + array[i].EFeaturePic + "' width='353px' height='171px'/>" +
                            "</a>" +
                        "</div>" +
                        "<div class='elistdate'>" +
                            "<label id='lblDate'>" + array[i].StartDate + "<Label>" +
                            "  <label id='lblTime'>" + array[i].StartTime + "<label>" +
                        "</div>" +
                        "<div class='elisttitle'>" +
                            "<a href='eventdetails.aspx?e='" + array[i].EventID + "'>" + array[i].EventTitle + "</a>" +
                        "</div>" +
                        "<div class='elistdate'>" +
                     array[i].EventLocation
                     "</div>  " +
                "</div>";
                     $('#elements').append(temp);
                 }

                 console.log(msg);
             }
         });
     };
</script>
<style>
    .ntlistbev{
        width:31%;
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
<form runat="server" ID="frm_Events">
    <asp:scriptmanager runat="server" EnablePageMethods="True" EnablePartialRendering="True"></asp:scriptmanager>
    
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
                  <li><a href="../brand/add-item.aspx"><img src="" /><span class="sp"> Item</span></a></li>
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
<div class="seacrheventblock">
   <div class="sevblock">
      
            <div class="seventinputb"><input type="text" runat="server" ID="txtEventTitle" placeholder="Search For Events" name="sevents" class="loginebsn" /></div>
            <%----%>
            <div class="seventinputb">
                <asp:DropDownList ID="ddCity" runat="server" CssClass="loginebsn" DataSourceID="sdsCity" 
                    DataTextField="ECity" DataValueField="ECity" AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Search By City</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsCity" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                    ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                    SelectCommand="SELECT Distinct [ECity] FROM [Tbl_Events] Where [ECity] IS NOT NULL ORDER BY ECity">
                </asp:SqlDataSource>
            </div>
            <div class="seventinputb">
                <asp:DropDownList ID="ddCategory" runat="server" CssClass="loginebsn" DataSourceID="sdsCategory" 
                    DataTextField="ECategory" DataValueField="ECategoryID" 
                    AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Search By Category</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsCategory" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                    ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                    SelectCommand="SELECT DISTINCT [ECategoryID],[ECategory] FROM [Tbl_EventCategory] ORDER BY [ECategory]">
                </asp:SqlDataSource>
            </div>
            <div class="seventinputb1"><button type="button" name="login" style="height: 44px;" id="buteventl" onclick="SearchEvent()" class="hvr-sweep-to-righta1">Search</button></div>
     
    </div>   
    <div style="margin-top:60px;">
         <div id="divAlerts" runat="server" class="alert" visible="False">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                Text="" Visible="True"></asp:Label> 
        </div> 
    </div>
</div><!--searcheventblock-->

<!--text-->

<div class="wrappereventlist" style="margin-bottom:5%">
      <div class="col-md-12 col-xs-12 etitle">
        Upcoming Events
      </div><!--col-md-12-->
      <div id="elements">

      </div>
        <%--<asp:datalist runat="server" DataKeyField="EventID" DataSourceID="sdsEvent" 
          RepeatColumns="3" RepeatDirection="Horizontal" ID="dlEvents" Width="100%">
            <ItemTemplate>
                  <div class="ntlistbev" style="background: #fff; padding-left: 0px; padding-right: 0px;">
                       <div class="listimge"><a href='<%# Eval("EventID","eventdetails.aspx?e={0}") %>'><img src='<%# Eval("EFeaturePic","../eventpics/{0}") %>' width="353px" height="171px"/></a></div>
                       <div class="elistdate"><asp:Label runat="server" 
                               Text='<%# Eval("StartDate", "{0:D}") %>' ID="lblDate"></asp:Label> 
                           <asp:Label runat="server" 
                               Text='<%# Eval("StartTime", "{0}") %>' ID="lblTime"></asp:Label></div>
                       <div class="elisttitle"><a href='<%# Eval("EventID","eventdetails.aspx?e={0}") %>'><%# Eval("EventTitle") %></a></div>
                       <div class="elistdate"><%# Eval("ELocation") %></div>  
                  </div>
                
            </ItemTemplate>
        </asp:datalist> 
     
        <asp:SqlDataSource ID="sdsEvent" runat="server" 
          ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
          ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
          SelectCommand="SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where EventTitle IS NOT NULL  ORDER BY EventID DESC">
      </asp:SqlDataSource>
       
        <asp:SqlDataSource ID="sdsSearchEvents" runat="server" 
          ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
          ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
          SelectCommand="">
           
      </asp:SqlDataSource>--%>
       
       <%-- <div class="ntlistbev">
           <div class="listimge"><a href=""><img src="images/eventlistimg.png" width="100%"/></a></div>
           <div class="elistdate">Sat, April 8 8:00 PM</div>
           <div class="elisttitle"><a href="">A Long Event Name Will Stack In Two Line Here</a></div>
           <div class="elistdate">Name of Place Here</div>
        </div>--%>

        
        
    
</div><!--wrappereventlist-->

<!--text-->  

<!--footer-->
  <div class="footerbg">
     <div class="starter-template">
        <div class="col-md-12">©2016 Press Preview</div>
     </div>    
  </div><!--footer-->
<!--footer-->
<!--#INCLUDE FILE="../includes/backtotop.txt" -->
<script src="../js/backtotop.js" type="text/javascript"></script>
</div><!--wrapper-->
<script type="text/javascript">
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
//                    alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
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
//                    alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
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
