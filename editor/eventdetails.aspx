<%@ Page Language="C#" AutoEventWireup="true" CodeFile="eventdetails.aspx.cs" Inherits="events_eventdetails" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Press Preview Events Detail</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
    <link href="../css/act-style-blue.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../css/checkbox.css"/>
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<%-- <link href="http://addtocalendar.com/atc/1.5/atc-style-blue.css" rel="stylesheet" type="text/css">--%>
<!--lightbox-->
	<script type="text/javascript" src="../source/jquery.fancybox.js?v=2.1.5"></script>
	<link rel="stylesheet" type="text/css" href="../source/jquery.fancybox.css?v=2.1.5" media="screen" />
<script src="../ckeditor/ckeditor.js"></script>
<script src="../js/sample.js"></script>
<script type="text/javascript">
    jQuery(document).ready(function () {
        jQuery('.fancybox').fancybox();
        jQuery('.fancybox-buttons').fancybox({
            openEffect: 'none',
            closeEffect: 'none',

            prevEffect: 'none',
            nextEffect: 'none',

            closeBtn: false,

            helpers: {
                title: {
                    type: 'inside'
                },
                buttons: {}
            },

            afterLoad: function () {
                this.title = 'Image ' + (this.index + 1) + ' of ' + this.group.length + (this.title ? ' - ' + this.title : '');
            }
        });
    });
	</script>
    <style>
        .fancybox-inner{
            width:auto !important;
            height:auto !important;
        }
        </style>
     <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBDqfn0oWwSMR8xsTXBKQR61WPC454_0Hw&callback=initMap"
  type="text/javascript"></script>
    
<script language="javascript" type="text/javascript">

    var map;
    var geocoder;
    function InitializeMap() {

        var latlng = new google.maps.LatLng(-34.397, 150.644);
        var myOptions =
        {
            zoom: 15,
            center: latlng,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            disableDefaultUI: true
        };
        map = new google.maps.Map(document.getElementById("map"), myOptions);

        
    }

    function FindLocaiton() {
        geocoder = new google.maps.Geocoder();
        InitializeMap();
      

        var txtAddress = document.getElementById("txtLocation");
        var address = txtAddress.value;
        geocoder.geocode({ 'address': address }, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                map.setCenter(results[0].geometry.location);
                var marker = new google.maps.Marker({
                    map: map,
                    position: results[0].geometry.location
                });
                
            }
            else {
                alert("Geocode was not successful for the following reason: " + status);
            }
        });

        
    }

    function showAddress() {
        geocoder = new google.maps.Geocoder();
        initialize()
        var txtAddress = document.getElementById("txtLocation");
        var address = txtAddress.value;

        geocoder.getLatLng(
                address,
                function (point) {
                    if (!point) {
                        alert(address + " not found");
                    }
                    else {
                        map.setCenter(point, 15);
                        var marker = new GMarker(point);
                        map.addOverlay(marker);
                        marker.openInfoWindow(address);
                    }
                }
            );
    }

    //function Button1_onclick() {
    //   FindLocaiton();
    //}
    
    window.onload = InitializeMap;
    google.map.event.addDomListener(window, 'load', InitializeMap);
</script>

</head>

<body onload="FindLocaiton()">
    <script type="text/javascript">        (function () {
            if (window.addtocalendar) if (typeof window.addtocalendar.start == "function") return;
            if (window.ifaddtocalendar == undefined) {
                window.ifaddtocalendar = 1;
                var d = document, s = d.createElement('script'), g = 'getElementsByTagName';
                s.type = 'text/javascript'; s.charset = 'UTF-8'; s.async = true;
                s.src = ('https:' == window.location.protocol ? 'https' : 'http') + '://addtocalendar.com/atc/1.5/atc.min.js';
                var h = d[g]('body')[0]; h.appendChild(s);
            } 
        })();
    </script>
    <form id="form1" runat="server">

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
            
            <!-- Menu -->
            <ul class="nav navbar-nav" id="firstbb">
              <li><a href="Default.aspx">Activity</a></li>
              <li><a href="discover.aspx">Discover</a></li>
              <li><a href="brands.aspx">Brands</a></li>
              <li class="active"><a href="events.aspx">Events</a></li>
            </ul> 
            <!-- Menu End -->            
            <!--#INCLUDE FILE="../includes/influencer_settings.txt" -->  
            
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>

    </div><!--header bg-->
<!--Headerend-->
<!--text-->



<div class="wrapperblocke" style="margin-top:70px;">

       <div class="eventleftblock">
           <asp:Label runat="server" ID="lblRSVPType" Visible="False"></asp:Label>
           <asp:Label runat="server" ID="lblMediaType" Visible="False"></asp:Label>
           <asp:Label runat="server" ID="lblVideoLink" Visible="False"></asp:Label>
            <div class="eventtitle">
                 <asp:Label runat="server" ID="lblEventTitle"></asp:Label>
            </div><!--event title-->
            <div class="eventtime">
                 <asp:Label runat="server" ID="lblEventDateTime"></asp:Label><br/>
                 <asp:Label runat="server" ID="lblEndDateTime"></asp:Label><br/>
                 <asp:Label runat="server" ID="lblLocation"></asp:Label><br/>
            </div><!--event title-->
            
            <div class="eventtext">
            
              <div class="etblock">
                 <div class="etitle">Events Details</div>
                 <div class="ebut">
                    <%-- <a runat="server" ID="btnRSVPLink" target="_blank" class="hvr-sweep-to-right2" Visible="False">RSVP</a>--%>
                    <%-- <a runat="server" ID="btnMailTo" class="hvr-sweep-to-right2" Visible="False">RSVP</a>--%>
                     <a runat="server" ID="btnRSVPLink" target="_blank" class="hvr-sweep-to-rightup2" style="text-align: center;padding: 12px; text-decoration:none;">
                         RSVP
                         <%--<button type="button"  class="hvr-sweep-to-rightup2" runat="server"  value="RSVP"/>--%>
                     </a>
                     <a runat="server" ID="btnMailTo"  class="hvr-sweep-to-rightup2" style="text-align: center;padding: 12px; text-decoration:none;" >
                         RSVP
                     </a>
                 </div>
              </div><!--etblock--> 
              
              <hr />
              
              <div class="etblock">
                 <div class="textev">
                    <asp:Label runat="server" ID="lblPara1"></asp:Label>
                 </div><!--textev-->
                 
                 <div class="eventimg">
                     <asp:Image runat="server" ID="imgCenter" ImageUrl="../images/eventdes.png" Width="100%" Visible="False"/>
                     <asp:GridView ID="grdVideo" runat="server" Visible="False" AutoGenerateColumns="False" 
                                            CssClass="table table-striped table-bordered table-hover table-responsive skin-1 responsive" 
                                            DataSourceID="sdsCms" ShowHeader="False" 
                        >
                                            <Columns>
                                                <asp:TemplateField HeaderText="Video" SortExpression="Video_Code">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("EventMedia") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <embed runat="server" ID="vidPlayer"  width="100%" height="350"  src='<%# Eval("EventMedia").ToString() %>' />
                                                        
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                              
                                            </Columns>
                                            <HeaderStyle CssClass="label-info" />
                                        </asp:GridView>
				 <asp:SqlDataSource ID="sdsCms" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                            ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                            SelectCommand="SELECT EventMedia From Tbl_Events WHERE ([EventID] = ?)">
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="EventID" QueryStringField="e"  Type="String"/>
                                            </SelectParameters>
                                        </asp:SqlDataSource>  
                    <%-- <img src="images/eventde.png" width="100%" />--%>
                 </div>
                 
                 <div class="textev">
                      <asp:Label runat="server" ID="lblPara2"></asp:Label>
                 </div><!--textev-->
              </div><!--etblock-->
              
              <div class="eventsimg">
                  <asp:Repeater runat="server"  
                      DataSourceID="sdsEventImages" ID="dlEventImages" >
                      <ItemTemplate>
                          <div class="simge"><a class="fancybox-buttons" data-fancybox-group="button" href='<%# Eval("EImg","../eventpics/{0}") %>'><img src='<%# Eval("EImg","../eventpics/{0}") %>' style="width:222px; height:162px;" /></a></div>
                          
                      </ItemTemplate>
                  </asp:Repeater>
                  
                  <asp:SqlDataSource ID="sdsEventImages" runat="server" 
                      ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                      ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                      SelectCommand="SELECT [EImgID], [EImg] FROM [Tbl_EventImages] WHERE ([EventID] = ?)">
                      <SelectParameters>
                          <asp:QueryStringParameter Name="EventID" QueryStringField="e" Type="Int32" />
                      </SelectParameters>
                  </asp:SqlDataSource>
                  
                
              </div><!--eventsimg-->
               
            </div><!--eventtext-->            
            
       </div><!--event left block-->
       
       <div class="eventrightblock">
            <div class="eventrimgs">
                <asp:Image runat="server" ID="imgFeature" ImageUrl="../images/eventdes.png"/>
                
            </div>
            
            <div class="eventmayblock">
                 <div class="etitle1">Where</div>
                 
                 <div class="emaploc">
                     <asp:TextBox type="text" runat="server" ID="txtLocation" 
                          onblur="return FindLocaiton()"  style="z-index: -20;position: absolute;"></asp:TextBox>
                     <div id="map" style="width:100%; height: 300px"></div>
                 </div>
                 
                 
            <div class="addressevent">
                <%-- Falucka Lounge<br>162 Bleecker Street<br />New York, NY 100212<br /><br />
                 Sat, April 8, 2016 at 8:00 PM <br />
                 Sun, April 9, 2016 at 3:00 PM (EDT)<br />--%>
                 <asp:Label runat="server" ID="lblEventDateTime1"></asp:Label><br/>
                 <asp:Label runat="server" ID="lblEndDateTime1"></asp:Label><br/>
                 <asp:Label runat="server" ID="lblLocation1"></asp:Label><br/>
                 <asp:Label runat="server" ID="lblStartDate2"  Visible="False"></asp:Label> <asp:Label runat="server" ID="lblStartTime2" Visible="False"></asp:Label>
                 <asp:Label runat="server" ID="lblEndDate2"  Visible="False"/> <asp:Label runat="server" ID="lblEndTime2" Visible="False"></asp:Label>
            </div><!--event title-->
            
            <div class="calendere">
                <img src="../images/calender.png"  style="float:left; margin-right:5px"/> <span class="addtocalendar atcb-link">
        <var class="atc_event">
            <var class="atc_date_start"><% Response.Write(lblStartDate2.Text);%></var>
            <var class="atc_date_end"><% Response.Write(lblEndDate2.Text);%></var>
            <var class="atc_timezone">Europe/London</var>
            <var class="atc_title"><% Response.Write(lblEventTitle.Text);%></var>
            <var class="atc_description"><% Response.Write(lblPara1.Text);%> <p></p> <% Response.Write(lblPara2.Text);%></var>
            <var class="atc_location"><% Response.Write(lblLocation1.Text);%></var>
           <%-- <var class="atc_organizer">Luke Skywalker</var>
            <var class="atc_organizer_email">luke@starwars.com</var>--%>
        </var>
    </span>
                 <%--<img src="../images/calender.png" /> <span style="color:#06F"><a href="">Add to my calender</a></span>--%>
            </div><!--event title-->
            
            </div><!--eventmap-->
            
       </div><!--event right block-->
       
</div><!--wrapp
erblock-->

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

    <!-- Placed at the end of the document so the pages load faster -->
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