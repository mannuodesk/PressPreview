﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="eventdetails.aspx.cs" Inherits="events_eventdetails" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Press Preview Events Detail</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../css/checkbox.css"/>
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
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
     <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
    
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
             <div class="logob"><a href="../Default.aspx">Press Preview</a></div>
              <div class="logos"><a href="../Default.aspx">Logo Branding</a></div>
            </div>  
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            
            
         <div class="col-md-4">   
            <ul class="nav navbar-nav" id="firstb">
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><img src="../images/menumail.png" /></a>
                <ul class="dropdown-menu"  id="emailblock"><li>
                      <div class="mesb">
                        <div class="mtext3"><a href="../Massenger-Page.html">Your Messages</a></div> 
                        <div class="mtext2"> | &nbsp; <a href="../Compose-Page.html">Compose</a></div>
                       </div> 
                  </li>
                  <li role="separator" class="divider"></li>
                  
                  
                  <li><a href="#">
                      <div class="mesb">
                          <div class="mimageb"><div class="mimg"><img src="../images/comimg.png" /></div></div><!--mimageb-->
                          <div class="mtextb">
                             <div class="m1">
                               <div class="muser">User Name</div> 
                                <div class="mdays">2 days</div>
                             </div>
                             <div class="m1">
                                <div class="mtext">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</div>
                             </div>
                             <div class="m1"></div>
                          </div><!--mtextb-->
                      </div><!--mseb-->
                  </a></li>
                  
                  <li><a href="#">
                      <div class="mesb">
                          <div class="mimageb"><div class="mimg"><img src="../images/comimg.png" /></div></div><!--mimageb-->
                          <div class="mtextb">
                             <div class="m1">
                               <div class="muser">User Name</div> 
                                <div class="mdays">14 days</div>
                             </div>
                             <div class="m1">
                                <div class="mtext">Morbi id justo eu lacus molestie tempor a lacus. Suspendisse non justo ut ante sol...</div>
                             </div>
                             <div class="m1"></div>
                          </div><!--mtextb-->
                      </div><!--mseb-->
                  </a></li>
                  
                  <li><a href="#">
                      <div class="mesb">
                          <div class="mimageb"><div class="mimg"><img src="../images/comimg.png" /></div></div><!--mimageb-->
                          <div class="mtextb">
                             <div class="m1">
                               <div class="muser">User Name</div> 
                                <div class="mdays">13 days</div>
                             </div>
                             <div class="m1">
                                <div class="mtext">Vestibulum mattis est ligula, eget tempus magna elementum sed.</div>
                             </div>
                             <div class="m1"></div>
                          </div><!--mtextb-->
                      </div><!--mseb-->
                  </a></li>
                  
                  <li><a href="#">
                      <div class="mesb">
                          <div class="mimageb"><div class="mimg"><img src="../images/comimg.png" /></div></div><!--mimageb-->
                          <div class="mtextb">
                             <div class="m1">
                               <div class="muser">User Name</div> 
                                <div class="mdays">12 days</div>
                             </div>
                             <div class="m1">
                                <div class="mtext">ed eleifend quam fermentum, interdum orci sed, sagittis arcu. Donec lacinia aug...</div>
                             </div>
                             <div class="m1"></div>
                          </div><!--mtextb-->
                      </div><!--mseb-->
                  </a></li>
                  <li role="separator" class="divider"></li>
                  
                  <li><a href="#"><div class="mtext1">See All Messages <img src="../images/seeall.png" /></div></a></li>
                  
                </ul>
              
              <li class="dropdown" style="margin-top:-5px;">
                <a href="#"><img src="../images/alram.png" /></a>
              </li>
            </ul>
         </div>   
            
            
            <ul class="nav navbar-nav" id="firstbb">
              <li><div class="gab1"></div></li>
              <li class="dropdown">
                <a href="../events/">Event</a>
              </li>
              
              <li class="dropdown">
                     <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Create</a>
                 <ul class="dropdown-menu">
                  <li><a href="../brand/add-item.aspx"><img src="" /><span class="sp"> Item</span></a></li>
                  <li><a href="../brand/createLookbook.aspx"><img src="" /><span class="sp"> Lookbook</span></a></li>
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



<div class="wrapperblocke">

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
                     <a runat="server" ID="btnMailTo" target="_blank" class="hvr-sweep-to-rightup2" style="text-align: center;padding: 12px; text-decoration:none;" >
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
                          <div class="simge"><a class="fancybox-buttons" data-fancybox-group="button" href='<%# Eval("EImg","../eventpics/{0}") %>'><img src='<%# Eval("EImg","../eventpics/{0}") %>' /></a></div>
                          
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
            </div><!--event title-->
            
            <div class="calendere">
                 <img src="../images/calender.png" /> <span style="color:#06F"><a href="">Add to my calender</a></span>
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


</div><!--wrapper-->

    <!-- Placed at the end of the document so the pages load faster -->
    <script src="../js/bootstrap.js"></script>
    <script type="application/javascript" src="../js/custom.js"></script>


    </form>


  </body>
</html>