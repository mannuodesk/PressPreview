<%@ Page Language="C#" AutoEventWireup="true" CodeFile="editor-wishlist.aspx.cs" Inherits="editor_wishlist" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Influencer Wishlist</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<!--lightbox-->
	<link href="../source/jquery.fancybox.css" rel="stylesheet" type="text/css" />
<!--custom scroller-->
    
     <script type="text/javascript">
         $(document).ready(function () {
             SearchText();
         });

         function SearchText() {
             $("#txtsearch").autocomplete({
                 source: function (request, response) {
                     $.ajax({
                         type: "POST",
                         contentType: "application/json; charset=utf-8",
                         url: "editor-wishlist\\GetItemTitle",
                         data: "{'lbName':'" + document.getElementById('txtsearch').value + "'}",
                         dataType: "json",
                         success: function (data) {
                             response(data.d);
                         },
                         error: function (result) {
                             alert("No Match");
                         }
                     });
                 }
             });
         }  
    </script> 
    <script type=text/javascript>
        function doClick(buttonName, e) {
            //the purpose of this function is to allow the enter key to 
            //point to the correct button to click.
            var key;

            if (window.event)
                key = window.event.keyCode;     //IE
            else
                key = e.which;     //firefox

            if (key == 13) {
                //Get the button the user wants to have clicked
                var btn = document.getElementById(buttonName);
                if (btn != null) { //If we find the button click it
                    btn.click();
                    event.keyCode = 0
                }
            }
        }
</script>
<script type="text/javascript">
    function HideLabel() {
        setTimeout(function () { $('#divAlerts').fadeOut(); }, 4000);

    };
</script>
</head>

<body>
<form runat="server" ID="frm_Wishlist">
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
                <button type="submit" runat="server" name="signup" ID="btnEditProfile" OnServerClick="btnEditProfile_OnServerClick" class="hvr-sweep-to-rightp12" >
                <i class="fa fa-pencil" aria-hidden="true"></i> Edit Profile</button> 
            </div>
       </div> <!--editblock--> 
          <div class="col-md-5 col-xs-12 pimage">
               <asp:Image ID="imgProfile" CssClass="img-circle"  ImageUrl="../images/follo.png" runat="server" style="border-radius:50%;"/>
          </div><!--col-md-12-->
          <div class="col-md-7 col-xs-12 phtext">
               <img src="../images/location.png" alt="location" style="margin-right:6px;"  /> <asp:Label runat="server" ID="lblCity"></asp:Label>, <asp:Label runat="server" ID="lblCountry"></asp:Label><br />
               <a href="#" runat="server" ID="lbWebURL" target="_blank" style="word-wrap: break-word;"></a>               
          </div><!--col-md-12-->
          
          <div class="mesblockinf">
                <a href="#"><i class="fa fa-envelope" aria-hidden="true"></i> Messenger</a>
          </div><!--mesblock-->
          
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
           <asp:Repeater ID="Repeater2" runat="server" DataSourceID="sdsSocialLinks" 
                  onitemdatabound="Repeater2_ItemDataBound">
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
     
     
    <div class="wishlistmar">
           
                       <div class="searchpro1">
                         <div class="inwhtext"><a href="editor-profile.aspx">Information</a></div>
                         <div class="inwhtext"><b><a href="editor-wishlist.aspx" style="color:#000;">Wishlist</a></b></div>
                             <div class="serinputp">
                                 <asp:Button runat="server" ID="btnSearch" style="position: absolute; width: 0px; height: 0px;z-index: -1;"  OnClick="btnSearch_OnClick">
                                </asp:Button>
                                <%-- <span class="fa fa-search"></span>--%>
                                <asp:TextBox  ID="txtsearch" placeholder="Search" CssClass="seins1"  runat="server"></asp:TextBox>
                             </div> <!--serinput-->
                       </div><!--searchpro-->
                       <div class="lineclook"></div>
           
            <div id="contentbox" style="padding-top:20px;">
                <div id="divAlerts" runat="server" class="alert" visible="False">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                        Text="" Visible="True"></asp:Label>
                </div>
                 <asp:Repeater runat="server" ID="rptLookbook" DataSourceID="sdsLookbooks" 
                    OnItemDataBound="rptLookbook_ItemDataBound" 
                    onitemcommand="rptLookbook_ItemCommand">
                    <ItemTemplate>
                       
                    <div class="boxn1">
                    <div class="disblock">
                    <div>
                        <a href="itemview2?v=<%# Eval("ItemID") %>" class="fancybox">
                            <div class="dbl">
                                <div class="hover ehover13">
                                     <img class="img-responsive"  src="../photobank/<%# Eval("FeatureImg") %>" alt="<%# Eval("Title","{0}") %>"/>
                                     <div class="overlay">
                                         <h2 class="titlet"><%# Eval("Title","{0}") %></h2>
                                         <h2 class="linenew"></h2>
                                         <h2><asp:Label runat="server" ID="lblDate" Text='<%# Eval("DatePosted") %>'></asp:Label></h2>
                                     </div><!--overlay-->
                                 </div><!--hover ehover13-->
                            </div>
                        </a>
                    </div>
                  <!-- Delete button -->
                 <div class="smalcress">
                    
                    <%-- <a href=""></a>--%>
                 </div> <!-- Delete button -->
                 <div class="disname"><div class="mesbd">
                          <div class="mimageb">
                              <div class="mimgd">
                              <a href="" style="width:36px;"><img src='../brandslogoThumb/<%# Eval("logo") %>'  class="img-circle" style="width:36px; height:36px;"/></a>
                           </div>
                          </div><!--mimageb-->
                          <div class="mtextb">
                             <div class="m1">
                              <div class="muserd">
                                   <a href="itemview2?v=<%# Eval("ItemID") %>" class="fancybox"><%# Eval("Title","{0}") %></a>
                                    <asp:LinkButton runat="server" ID="lbtnRemove" OnClientClick="return confirm('Are you sure, you want to delete ?')" CommandName="1" CommandArgument='<%# Eval("ItemID") %>' style="margin:auto; float:right; background:#CCC; padding:6px 8px; border-radius:50%;">
                                    <i class="fa fa-times" aria-hidden="true" style="font-size:16px;"></i>
                                    </asp:LinkButton>
                              </div>
                              <div class="muserdb">By <%# Eval("Name","{0}") %></div> 
                                               
                                                            
                             </div>
                             <div class="m1">
                               <div class="mtextd"><%# Eval("Description","{0}") %></div>
                             </div>
                             <div class="m1">
                                <div class="vlike"><img src="../images/views.png" /> &nbsp;<%# Eval("Views") %></div>
                                <div class="vlike"><img src="../images/liked.png" /> &nbsp;<asp:Label runat="server" ID="lblLikes" Text='<%# Eval("ItemID") %>'></asp:Label></div>
                                <div class="mdaysd"><asp:Label runat="server" ID="lblDate2"><%# Eval("DatePosted") %></asp:Label></div>
                             </div>
                          </div><!--mtextb-->
                      </div><!--mseb--></div>
               </div><div class="lineclook"></div></div><!--box-->
                    </ItemTemplate>
                </asp:Repeater>
                <asp:SqlDataSource runat="server" ID="sdsLookbooks" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                SelectCommand="SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, 
                dbo.Tbl_Brands.Logo, dbo.Tbl_Items.ItemID, dbo.Tbl_Items.Title, 
                ItemKey, dbo.Tbl_Items.Description, dbo.Tbl_Items.FeatureImg, 
                dbo.Tbl_Items.Views, CAST(dbo.Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted, 
                dbo.Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands 
                INNER JOIN dbo.Tbl_Items ON dbo.Tbl_Brands.UserID = dbo.Tbl_Items.UserID 
                INNER JOIN dbo.Tbl_WishList ON Tbl_WishList.ItemID=Tbl_Items.ItemID
Where Tbl_WishList.UserID=? AND  dbo.Tbl_Items.IsDeleted IS NULL AND dbo.Tbl_Items.IsPublished=1
ORDER BY dbo.Tbl_Items.DatePosted DESC">
                    <SelectParameters>
                          <asp:SessionParameter SessionField="UserID" Name="?" runat="server"></asp:SessionParameter>
                      </SelectParameters>
                </asp:SqlDataSource>
               
            </div><!--content-->
       
           <div id="contentbox">
               <div id="ajaxrequest"></div>
           </div>          

</div>
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

