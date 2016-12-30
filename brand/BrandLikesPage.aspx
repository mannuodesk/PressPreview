<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BrandLikesPage.aspx.cs" Inherits="brand_BrandLikesPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>PR: Profile Item Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
   <script src="../js/jquery-ui.min.js"></script>
    <script src="../js/jquery.nested.js" type="text/javascript"></script>
   
       
     <script type="text/javascript">
         $(document).ready(function () {

             function lastPostFunc() {
                 $('#divPostsLoader').html('<img src="../images/ajax-loader.gif">');

                 //send a query to server side to present new content
                 $.ajax({
                     type: "POST",
                     url: "overview.aspx\\GetData",
                     data: "{}",
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function(data) {

                         if (data != "") {
                             $('.divLoadData:last').after(data.d);
                         }
                         $('#divPostsLoader').empty();
                     }
                 });
             };

             //When scroll down, the scroller is at the bottom with the function below and fire the lastPostFunc function
             $(window).scroll(function () {
                 if ($(window).scrollTop() == $(document).height() - $(window).height()) {
                     lastPostFunc();
                 }
             });

         });
    </script>
   
    

  <script type="text/javascript">
      function HideLabel() {
          setTimeout(function () { $('#divAlerts').fadeOut(); }, 4000);
      };
</script>
</head>

<body style="overflow-y:auto;">
<form runat="server" id="frmBrands">
      <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
      
  <div class="wrapper">
<!--Header-->
      <asp:Label runat="server" ID="Label200" Visible="False"></asp:Label>
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
                  <li><a href="add-item.aspx"><img src="" /><span class="sp"> Item</span></a></li>
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

<!--Banner-->
    <div class="banner">
     
       <asp:Image runat="server" Id="imgCover" class="img-responsive" ImageUrl="../images/bggreyi.jpg"  alt="profileimage" style="width:100%; height:252px;" />
   
         
    </div>
   
<!--bannerend-->
<div id="likes" >

<div class="wrapperblockh">
    <div class="col-md-12 loginhn">
        Likes (<asp:Label runat="server" ID="lblLikeCounter"></asp:Label>)
    </div><!--col-md-12-->
</div><!--wrapperblockh--> 
 
<div class="wrapperblock" style="background:#fff;">
  <div class="col-md-12">
      <div id="divAlerts" runat="server" class="alert" visible="False">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                        Text="" Visible="True"></asp:Label>
                </div>
      <asp:Repeater ID="rptLikes" runat="server" DataSourceID="sdsLikes">
          <ItemTemplate>
              
              <div class="col-md-2 col-sm-4 col-xs-6">
                   <div class="folblock">
                     <a href="influencer-profile.aspx?v=<%# Eval("UserKey") %>"><img class="img-responsive img-circle" src='../brandslogoThumb/<%# Eval("U_ProfilePic") %>' style="width:93px; height:93px; padding-bottom: 0px;" alt="image"/></a>
                     <div class="folname"><a href="influencer-profile.aspx?v=<%# Eval("UserKey") %>"><%# Eval("Name") %></a></div>
                   </div>
                </div>
              
              
              <!--col-md-2 col-sm-4 col-xs-6-->
          </ItemTemplate>
          <FooterTemplate>
                         <asp:Label ID="lblEmptyData" style="margin-left: 40%;" runat="server" Visible='<%# ((Repeater)Container.NamingContainer).Items.Count == 0 %>' Text="No Likes Yet" />
                     </FooterTemplate>
      </asp:Repeater>
      <asp:SqlDataSource runat="server" ID="sdsLikes" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                SelectCommand="select distinct U_Firstname + ' ' + U_Lastname as Name, U_ProfilePic,U_Type, UserKey, Tbl_Users.UserID FROM Tbl_Users INNER JOIN 
                                        Tbl_Item_Likes ON Tbl_Users.UserID=Tbl_Item_Likes.UserID  Where Tbl_Item_Likes.ItemID=?  AND Tbl_Item_Likes.UserID !=0 AND Tbl_Item_Likes.UserID!=?">
                    <SelectParameters>
                         <asp:QueryStringParameter QueryStringField="ItemId" Name="?" runat="server"></asp:QueryStringParameter>
                        <asp:CookieParameter CookieName="FrUserID" Name="?" />
                      </SelectParameters>
                </asp:SqlDataSource>   
        
  </div><!--col-md-12-->
    
</div></div><!--wrapperblock-->
    
<!--footer-->
  <div class="footerbg">
     <div class="row">
       <div class="col-md-11 col-xs-10">©<%: DateTime.Now.Year %> Press Preview</div>
        <div class="col-md-pull-1 col-xs-pull-1">
           <div class="f1"><a id="loaddata"></a></div>
           <div class="f2"></div>
        </div>
      </div>    
  </div><!--footer-->
<!--footer-->
<!--#INCLUDE FILE="../includes/backtotop.txt" -->
<script src="../js/backtotop.js" type="text/javascript"></script>
</div>
<!--wrapper-->
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
     
<script src="../js/bootstrap.js"></script>
<script src="../masonry/masonry.js" type="text/javascript"></script>
<script type="text/javascript">
    $('.grid').masonry({
        // options
        itemSelector: '.boxn1'
    });
</script>
</form>

</body>
</html>

