<%@ Page Language="C#" AutoEventWireup="true" CodeFile="itobmessage.aspx.cs" Inherits="lightbox_message" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<!--lightbox-->
	<script type="text/javascript" src="../source/jquery.fancybox.js?v=2.1.5"></script>
	<link rel="stylesheet" type="text/css" href="../source/jquery.fancybox.css" media="screen" />
    <link href="../css/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-ui.min.js" type="text/javascript"></script>
    <style type="text/css">
    .fancybox-inner{
            background: #fff;
    border-radius:10px;
    padding:10px
    }
    
    .fancybox-lock .fancybox-overlay {
        margin-top: 0px;
    }
</style>

<script type="text/javascript">
    function closefancybox() {

        setTimeout(function () { window.parent.jQuery.fancybox.close(); }, 2000);
    }
   
</script>
</head>
<body>
    <form id="form1" runat="server">
         <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True"  EnablePartialRendering="True">
                        </asp:ScriptManager>
     <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server" >
                <ContentTemplate>
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                        <ProgressTemplate>
                            <div id="dvLoading"></div>
                        </ProgressTemplate>

                    </asp:UpdateProgress>
                     <script type="text/javascript" language="javascript">
                         function closefancybox() {
                             setTimeout(function () { window.parent.jQuery.fancybox.close(); }, 2000);
                         }
        </script>--%>
     <div id="myMessage" style="text-align:center; background:#fff; height: 300px;">
       
         <div class="col-sm-12 pull-left" style="font-weight:bold; margin-top:15px; margin-bottom:15px;">
             <a href="#" class="dropdown-toggle" data-toggle="dropdown"  role="button" aria-haspopup="true" aria-expanded="false">
                 <i class="fa fa-envelope" aria-hidden="true"></i> Message to <asp:Label runat="server" ID="lblBrandName" Text=""></asp:Label> </a>
        </div>
      
        <div class="col-sm-12">
            <asp:TextBox runat="server" ID="txtMessage" TextMode="MultiLine" Height="150" Width="560" style="margin-bottom:15px;"></asp:TextBox>
             <asp:RequiredFieldValidator ID="RfvTags" runat="server" 
                                     ErrorMessage="This field is required" ControlToValidate="txtMessage" 
                                     ValidationGroup="gpMain"></asp:RequiredFieldValidator>
          
         </div> 
        
             <div class="col-md-8" style="float:left;  margin-top: -25px; width:100%; text-align: left;">
                   <div id="divAlerts" runat="server" class="alert" visible="False">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                        Text="" Visible="True"></asp:Label>
                </div>
            </div>
            <div class="col-md-4" style="float:right">
                 <button type="button" runat="server" name="login" ID="btnPublish" 
                                      style="position: relative; right: 5px; margin-top: -25px;"  ValidationGroup="gpMain" 
                                      class="hvr-sweep-to-rightup2" Text=""  
                                      OnServerClick="btnPublish_OnServerClick"  >Send</button>
            </div>
            
            
          
        </div>
      
    <%--</ContentTemplate>
      
    </asp:UpdatePanel>--%>
    </form>
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="../js/bootstrap.js"></script>
</body>
</html>
