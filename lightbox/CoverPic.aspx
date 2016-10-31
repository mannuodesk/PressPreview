<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeFile="CoverPic.aspx.cs" Inherits="home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Resize Cover Picture</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <link href="../css/jquery.jcrop.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery.Jcrop.min.js" type="text/javascript"></script>
    
        <link rel="stylesheet" href="../jcrop/css/style.css" />
<link rel="stylesheet" href="../jcrop/css/jquery.Jcrop.min.css" type="text/css" />
<script type="text/javascript" src="../jcrop/js/jquery.min.js"></script>
<script src="../jcrop/js/jquery.Jcrop.min.js"></script>
<script type="text/javascript" src="../jcrop/js/script.js"></script>
    <link href="../css/plugins/ladda/ladda-themeless.min.css" rel="stylesheet" type="text/css" /> 
</head>

<body>
<form runat="server" id="frmBrands">
      <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
                        </asp:ScriptManager>
<div id="popup_upload">
     <div id="divAlerts" runat="server" class="alert" visible="False">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                Text="" Visible="True"></asp:Label> 
        </div>
        <div class="form_upload">
           <%-- <span class="close" onClick="close_popup('popup_upload')">x</span>--%>
             
            <h3>Upload Image</h3>
              <asp:FileUpload ID="photo" runat="server" class="file_input"/>  
                <div ID="loading_progress" runat="server"></div>
                <%--<asp:Button runat="server" ID="upload_btn" Text="Upload" OnClick="upload_btn_OnClick"/>--%>
                <div class="row">
                    <div class="col-md-6"></div>
                     <div class="col-md-6" style="float:right;">
                          <button type="button" runat="server"  name="login" ID="upload_btn"  class="ladda-button hvr-sweep-to-rightup2" OnServerClick="upload_btn_OnClick" >Upload</button>
                  <button type="button" runat="server"  name="login" ID="btnCancel"  class="hvr-sweep-to-rightup2"  onClick="window.parent.jQuery.fancybox.close();" >Cancel</button>
                     </div>
                </div>
                
             
            <iframe name="upload_frame" class="upload_frame"></iframe>
        </div>
    </div>

<script src="../js/bootstrap.js"></script>
<script src="../js/plugins/ladda/ladda.min.js" type="text/javascript"></script>
<script src="../js/plugins/ladda/spin.min.js" type="text/javascript"></script>
 <script>

     $(document).ready(function () {

         // Bind normal buttons
         $('.ladda-button').ladda('bind', { timeout: 2000 });

         // Bind progress buttons and simulate loading progress
         Ladda.bind('.progress-demo .ladda-button', {
             callback: function (instance) {
                 var progress = 0;
                 var interval = setInterval(function () {
                     progress = Math.min(progress + Math.random() * 0.1, 1);
                     instance.setProgress(progress);

                     if (progress === 1) {
                         instance.stop();
                         clearInterval(interval);
                     }
                 }, 200);
             }
         });


         var l = $('.ladda-button-demo').ladda();

         l.click(function () {
             // Start loading
             l.ladda('start');

             // Timeout example
             // Do something in backend and then stop ladda
             setTimeout(function () {
                 l.ladda('stop');
             }, 12000)


         });

     });

</script>
</form>

</body>
</html>
