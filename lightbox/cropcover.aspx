<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeFile="cropcover.aspx.cs" Inherits="home" %>
<%@ Register TagPrefix="cc1" Namespace="CS.WebControls" Assembly="CS.WebControls.WebCropImage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Resize Cover Picture</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
   <link rel="stylesheet" href="../jcrop/css/jquery.Jcrop.min.css" type="text/css" />
<script type="text/javascript" src="../jcrop/js/jquery.min.js"></script>
<script src="../jcrop/js/jquery.Jcrop.min.js"></script>
<%--<script type="text/javascript" src="../jcrop/js/script.js"></script>--%>
 <style>
.jcrop-holder{
margin:0 auto;
text-align:center;
}
</style>
</head>

<body>
<form runat="server" id="frmBrands">
      <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
                        </asp:ScriptManager>
    <div id="divAlerts" runat="server" class="alert" visible="False">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                Text="" Visible="True"></asp:Label> 
        </div>
    <div class="row">
        <div class="col-md-12" style="margin-top:30px">
            <h2 style="text-align:center;">Resize photo</h2>
    <p style="text-align:center;">Recommended image size for cover photo is 1300 x 250 (width x height)</p>
        </div>
        <div class="col-md-offset-5 col-md-12" style="margin-top:15px;margin-bottom:30px;">
            <button type="button" runat="server"  name="login" ID="btnCrop"  class="hvr-sweep-to-rightup2" OnServerClick="btnCrop_OnServerClick" style="margin-left:30px;">Crop</button>
       <button type="button" runat="server"  name="login" ID="btnSave"  class="hvr-sweep-to-rightup2" Visible="False" onserverclick="save_btn_OnServerClick" onClick="window.parent.jQuery.fancybox.close();" style="margin-left:30px;">Save</button>
       <!-- <button type="button" runat="server"  name="login" ID="upload_btn"  class="hvr-sweep-to-rightup2" OnServerClick="upload_btn_OnServerClick" >Upload New</button> -->
        </div>
    </div>
    
    <div ID="loading_progress" runat="server"></div>
    <asp:Image ID="imgCrop" runat="server" />
      <br />
      <asp:HiddenField ID="X" runat="server" />
      <asp:HiddenField ID="Y" runat="server" />
      <asp:HiddenField ID="W" runat="server" />
      <asp:HiddenField ID="H" runat="server" />
       
    
 
<script src="../js/bootstrap.js"></script>
  <script type="text/javascript">
      jQuery(document).ready(function () {
          var targetW = 1300;
          var targetH = 250;
          jQuery('#imgCrop').Jcrop({
              boxWidth: 600,
              boxHeight: 600,
              aspectRatio: targetW / targetH,
              setSelect: [100, 100, targetW, targetH],
              onSelect: storeCoords
          },function(){
        jcrop_api = this;
    });
      });

      function storeCoords(c) {
          jQuery('#X').val(c.x);
          jQuery('#Y').val(c.y);
          jQuery('#W').val(c.w);
          jQuery('#H').val(c.h);
      };


    
</script> 
</form>

</body>
</html>
