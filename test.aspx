<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="test" %>

<!DOCTYPE>
<head id="Head1" runat="server">
    <title></title>
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
            //disableDefaultUI: true
            };
        map = new google.maps.Map(document.getElementById("map"), myOptions);
    }

    function FindLocaiton() {
        geocoder = new google.maps.Geocoder();
        InitializeMap();

        
        var txtAddress = document.getElementById("txtAddress");
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
        var txtAddress = document.getElementById("txtAddress");
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

</script>

</head>
<body>
    <form id="form1" runat="server">
   <h2>Gecoding Demo JavaScript: </h2>
   <asp:Label runat="server"  ID="lblSent"></asp:Label>
    <p>
        <asp:CheckBox runat="server" ID="chkToggle"/>
        <asp:Button ID="btnPnl1" runat="server" Text="Show Panel 1" OnClientClick="javascript:return showPanel1();" />
&nbsp;<asp:Button ID="btnPnl2" runat="server" Text="Show Panel 2" />
    </p>
    <asp:Panel ID="pnl2" runat="server" Visible="False">
        This is panel 2</asp:Panel>
    <asp:Panel ID="pnl1" runat="server" Visible="False">
        This is Panel 1</asp:Panel>
<table>
<tr>
<td>
<input id='txtAddress' />
</td>
<td>
    <input id="Button1" type="button" value="Find" onclick="return FindLocaiton()" /></td>
</tr>
<tr>
<td colspan ="2">
<div id="map" style="width: 350px; height: 300px">
    <br />
    </div>
</td>
</tr>
</table>
 <ul class="nav navbar-nav navbar-right">
		     <li> <a href="profile-page-items.aspx" style="margin-top: 10px;"><asp:Label runat="server" ID="lblUsername" ></asp:Label></a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                  <asp:Image runat="server" ID="imgUserIcon" ImageUrl="../images/menuright.png" CssClass="img-circle" style="width: 36px; height: 36px;"></asp:Image> <span> <img src="../images/triangle.png" /></span></a>
                <ul class="dropdown-menu"><li><a href="profile-page-items.aspx"><img src="../images/profile.png" /><span class="sp"> My Profile</span></a></li>
                  <li><a href="#"><img src="../images/help.png" /><span class="sp"> Help</span></a></li>
                  <li><a href="../logout.aspx"><img src="../images/logout.png" /><span class="sp"> Log Out</span></a></li>
                </ul>
              </li>
            </ul> 
    </form>
</body>
</html>
