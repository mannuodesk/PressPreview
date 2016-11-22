<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="true" CodeFile="notifications.aspx.cs" Inherits="home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>PR: Profile Item Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link href="../admin/font-awesome/css/font-awesome.css" rel="stylesheet">
<%--<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>--%>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <link href="../css/jquery-ui.css" rel="stylesheet" type="text/css" />
   <script src="../js/jquery-ui.min.js"></script>
   <link href="../source/jquery.fancybox.css" rel="stylesheet" type="text/css" />
     
     
 
 
  <script type="text/javascript">
      function HideLabel() {
          setTimeout(function () { $('#divAlerts').fadeOut(); }, 4000);
      };
</script>
</head>

<body>
<form runat="server" id="frmBrands">
      <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
      
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


<!--text-->
<div class="wrapperblock">
    
            <div class="col-md-3 col-xs-12 blockp" style="background:#fff;">
          <div class="editblock">
          <div class="col-md-8 col-xs-12 pheading">
               <a href="#" runat="server" id="lbBrandName" style="word-wrap: break-word;"></a>                
          </div><!--col-md-12-->
          <div class="editbut">
              <button type="button" runat="server" ID="btnEditProfile" OnServerClick="btnEditProfile_OnServerClick"   class="hvr-sweep-to-rightp12"><i class="fa fa-pencil"></i>Edit Profile</button>                  
                 
            </div>
       </div>
         
          <div class="col-md-5 col-xs-12 pimage">
              <asp:Image runat="server" id="imgProfile" CssClass="img-circle" ImageUrl="../images/imagep.png" alt="image" style="width: 93px; height: 93px;"/>
          </div><!--col-md-12-->
          <div class="col-md-7 col-xs-12 phtext">
               <img src="../images/location.png" alt="location" style="margin-right:6px;"  /> <asp:Label runat="server" ID="lblCity"></asp:Label>, <span><asp:Label runat="server" ID="lblCountry"></asp:Label></span><br />
               <a runat="server" id="lbWebURL" href="#" target="_blank" style="word-wrap: break-word;"></a>               
          </div><!--col-md-12-->
          <div class="lines"><hr /></div>
          <div class="mesblockinf">
               <asp:LinkButton runat="server" ID="lbtnMassenger" 
                  PostBackUrl="massenger.aspx" >
                   <i class="fa fa-envelope" aria-hidden="true"></i> Messenger
               </asp:LinkButton>
             <%--   <a href="massenger.aspx"></a>--%>
          </div>
          <div class="col-md-10 col-xs-8 ptext">
               <img src="../images/views.png" alt="image" style="margin-right:6px;"/><label>Views</label>
          </div><!--col-md-12-->
          <div class="col-md-1 col-xs-1 ptext">
              <asp:Label runat="server" ID="lblTotolViews" ></asp:Label>           
          </div><!--col-md-12-->
          <div class="col-md-10 col-xs-8 ptext">
               <img src="../images/likes.png" alt="image" style="margin-right:6px;"/><a href="#">Likes</a>
          </div><!--col-md-12-->
          <div class="col-md-1 col-xs-1 ptext">
              <a href="overview-likes.aspx"><asp:Label runat="server" ID="lblTotolLikes" ></asp:Label></a>        
          </div><!--col-md-12-->
          
          <div class="lines"><hr /></div>
          
          <div class="col-md-8 col-xs-12 cheading">
             Categories
          </div>
          <div class="col-md-11 col-xs-12 ptext1">
              <ul>               
                  <asp:Repeater ID="rptbrdCategories" runat="server" DataSourceID="sdsbrdCategories" >
                      <ItemTemplate>
                          <li><%#Eval("Title") %>,</li>   
                                                   
                      </ItemTemplate>
                  </asp:Repeater>
                  <asp:SqlDataSource runat="server" ID="sdsbrdCategories" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                  SelectCommand="SELECT Distinct dbo.Tbl_Categories.CategoryID, dbo.Tbl_Categories.Title FROM dbo.Tbl_Items 
                  INNER JOIN dbo.Tbl_ItemsCategory ON dbo.Tbl_Items.ItemID = dbo.Tbl_ItemsCategory.ItemID
                  INNER JOIN dbo.Tbl_Categories ON dbo.Tbl_Categories.CategoryID=Tbl_ItemsCategory.CategoryID
                    WHERE Tbl_Items.UserID=?">
                      <SelectParameters>
                          <asp:CookieParameter CookieName="FrUserID" Name="?" />
                      </SelectParameters>
                  </asp:SqlDataSource>
              </ul>            
          </div>
           <div class="lines"><hr /></div>
          
          <div class="col-md-8 col-xs-12 cheading">
             Seasons
          </div>
          <div class="col-md-11 col-xs-12 ptext1">
              <ul>
             <asp:Repeater ID="rptSeason" runat="server" DataSourceID="sdsSeasons" >
                      <ItemTemplate>
                          <li><%#Eval("Season") %>,</li>                         
                      </ItemTemplate>
                  </asp:Repeater>
                  </ul>
                  <asp:SqlDataSource runat="server" ID="sdsSeasons" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                  SelectCommand="SELECT Distinct Tbl_Seasons.SeasonID,Tbl_Seasons.Season FROM Tbl_Seasons 
                  INNER JOIN dbo.Tbl_ItemSeasons ON dbo.Tbl_Seasons.SeasonID = Tbl_ItemSeasons.SeasonID
                  INNER JOIN dbo.Tbl_Items ON dbo.Tbl_Items.ItemID=Tbl_ItemSeasons.ItemID
WHERE Tbl_Items.UserID=?">
                     <SelectParameters>
                          <asp:CookieParameter CookieName="FrUserID" Name="?" />
                      </SelectParameters>
                  </asp:SqlDataSource>
          </div>          
          <div class="lines"><hr /></div>
          
           <div class="col-md-8 col-xs-12 cheading">
             Holidays
          </div>
          <div class="col-md-11 col-xs-12 ptext1">
              <ul>
             <asp:Repeater ID="rptHolidays" runat="server" DataSourceID="sdsHolidays" >
                      <ItemTemplate>
                          <li><%#Eval("Title") %>,</li>                         
                      </ItemTemplate>
                  </asp:Repeater>
                  </ul>
                  <asp:SqlDataSource runat="server" ID="sdsHolidays" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                  SelectCommand="SELECT Distinct Tbl_Holidays.HolidayID,Tbl_Holidays.Title FROM Tbl_Holidays 
                  INNER JOIN dbo.Tbl_ItemHolidays ON dbo.Tbl_Holidays.HolidayID = Tbl_ItemHolidays.HolidayID
                  INNER JOIN dbo.Tbl_Items ON dbo.Tbl_Items.ItemID=Tbl_ItemHolidays.ItemID
WHERE Tbl_Items.UserID=?">
                      <SelectParameters>
                          <asp:CookieParameter CookieName="FrUserID" Name="?" />
                      </SelectParameters>
                  </asp:SqlDataSource>
          </div>          
          <div class="lines"><hr /></div>
          
          <div class="col-md-8 col-xs-12 cheading">
             About
          </div>
          <div class="col-md-12 col-xs-12 ptext2" runat="server" ID="dvAbout" style="word-wrap: break-word;">
            <asp:Label ID="lblAbout" runat="server" Text="Label"></asp:Label>
          </div>
          <div class="lines"><hr /></div>
          <div class="col-md-8 col-xs-12 cheading">
             History
          </div>
          <div class="col-md-12 col-xs-12 ptext2" runat="server" ID="dvHistory" style="word-wrap: break-word;">
               <asp:Label ID="lblHistory" runat="server" Text="Label"></asp:Label>
          </div>
          <div class="lines"><hr /></div>
          <div class="col-md-8 col-xs-12 cheading">
             On The Web
          </div>
          <div class="col-md-12 col-xs-12 ptext2">
            <asp:Repeater ID="Repeater2" runat="server" DataSourceID="sdsSocialLinks">
                      <ItemTemplate>
                           <a href="<%# Eval("InstagramURL") %>" target="_blank"><img src="../images/pins.jpg" /></a> 
                          <a href="<%# Eval("TwitterURL") %>" target="_blank"><img src="../images/ptw.jpg" /></a>
                           <a href="<%# Eval("FbURL") %>" target="_blank"><img src="../images/pfb.jpg" /></a>
                            <a href="<%# Eval("YoutubeURL") %>" target="_blank"><img src="../images/youtube.png" /></a>
                            <a href="<%# Eval("PinterestURL") %>" target="_blank"><img src="../images/ppin.jpg" /></a>                         
                      </ItemTemplate>
                  </asp:Repeater>
                  <asp:SqlDataSource runat="server" ID="sdsSocialLinks" 
                  ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                      SelectCommand="SELECT 'http://' + REPLACE(FbURL,'http://','') as FbURL,'http://' + REPLACE(TwitterURL,'http://','') as TwitterURL ,
'http://' + REPLACE(InstagramURL,'http://','') as InstagramURL ,
'http://' + REPLACE(YoutubeURL,'http://','') as YoutubeURL,
'http://' + REPLACE(PinterestURL,'http://','') as PinterestURL
 From Tbl_Brands WHERE UserID=?">
                      <SelectParameters>
                          <asp:SessionParameter SessionField="UserID" Name="?"></asp:SessionParameter>
                      </SelectParameters>
                  </asp:SqlDataSource>  
          
         </div>
     </div><!--blockp-->
    
           <div class="wishlistmar">
             <div class="searchpro1">
                         <div class="inwhtext"><b><a href="notifications.aspx" style="color:#000;">Notifications</a></b></div>
                         
                             <div class="serinputp">
                                <%--<asp:Button runat="server" ID="btnSearch" style="position: absolute; width: 0px; height: 0px;z-index: -1;"  OnClick="btnSearch_OnClick">
                                </asp:Button> <span class="fa fa-search"></span>
                                 <asp:TextBox  ID="txtsearch" placeholder="Search" CssClass="seins1" style="padding-left:30px;"    runat="server">
                                     
                                 </asp:TextBox>--%>
                                <%--<asp:DropDownList  ID="lstSearch" runat="server" CssClass="seins1" 
                                     style="margin-top: 15px;" AppendDataBoundItems="True" Height="35px"   >
                                    <asp:ListItem></asp:ListItem>
                                 </asp:DropDownList>--%>
                             </div> <!--serinput-->
                       </div><!--searchpro-->
                       <div class="lineclook"></div>
              
               <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" >
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                <ProgressTemplate>
                    <div id="dvLoading"></div>
                </ProgressTemplate>

            </asp:UpdateProgress>
            <div class="discoverbn">     
           
            <div id="contentbox" style="padding-top:20px; width: 97%; margin-left: 20px; margin-top:20px; background:#fff;">
                <div id="divAlerts" runat="server" class="alert" visible="False">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                        Text="" Visible="True"></asp:Label>
                </div>
               
                 <asp:GridView ID="grdNotifications11" runat="server" AllowPaging="True" 
                                            AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
                                            BorderStyle="None" BorderWidth="1px" 
                    CellPadding="4" CellSpacing="2" 
                                            CssClass="table table-hover" 
                                            DataSourceID="sdsNotifications11" 
                    ForeColor="Black" GridLines="Horizontal" Width="90%"  style="margin:0 auto;" 
                                             PageSize="15" AllowSorting="True" 
                                                EmptyDataText="No record found !" 
                    ShowHeader="False" onrowdatabound="grdNotifications11_RowDataBound" 
                    onrowcommand="grdNotifications11_RowCommand">
                                            <Columns>
                                                 <asp:TemplateField>
                <ItemTemplate>
					    <div class="mesb">
							  <div class="mimageb">
									<div class="mimg">
									    <a href="influencer-profile.aspx?v=<%# Eval("UserKey") %>">
										  <img class="img-circle" src='<%# Eval("U_ProfilePic","../brandslogoThumb/{0}") %>'   alt="image" style="width:36px; height:36px;"/>
									    </a>
                                    </div>
							  </div><!--mimageb-->
							  <div class="mtextb">
								  <div class="m1">
									<a href='../brand/itemview1?v=<%# Eval("ItemID") %>' class="fancybox">
									<div class="mtext"><%# Eval("Title") %></div>
									<div class="mdays" style="width: 30%; position: relative; text-align: right;"><asp:Label runat="server" ID="lblDatePosted" Text='<%# Eval("DatePosted") %>'></asp:Label></div>
									</a>
								 </div>
                             
							  </div><!--mtextb-->
                      </div><!--mseb-->
                </ItemTemplate>
                </asp:TemplateField>
                                                 <asp:TemplateField>
                                                    <ItemTemplate>
                                                         <asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="return confirm('Are you sure, you want to delete ?')" CommandName="2" CommandArgument='<%# Eval("NotifyID", "{0}") %>'
                                                            Text="<i class='ace-icon fa fa-trash fa-2x'></i>"
                                                            CssClass="col-xs-4 col-sm-1 btn btn-sm" ToolTip="Remove Notification" Width="40">                                                       
                                                        </asp:LinkButton>
                                                    </ItemTemplate>
                                                 </asp:TemplateField>
 </Columns>
                                            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                            <PagerSettings FirstPageText="First" Mode="NumericFirstLast" />
                                            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" 
                                                CssClass="GridPager" />
                                            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                            <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                            <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                            <SortedDescendingHeaderStyle BackColor="#242121" />
                                            <sortedascendingcellstyle backcolor="#F7F7F7" />
                                            <sortedascendingheaderstyle backcolor="#4B4B4B" />
                                            <sorteddescendingcellstyle backcolor="#E5E5E5" />
                                            <sorteddescendingheaderstyle backcolor="#242121" />
                                            <sortedascendingcellstyle backcolor="#F7F7F7" />
                                            <sortedascendingheaderstyle backcolor="#4B4B4B" />
                                            <sorteddescendingcellstyle backcolor="#E5E5E5" />
                                            <sorteddescendingheaderstyle backcolor="#242121" />
                                            <sortedascendingcellstyle backcolor="#F7F7F7" />
                                            <sortedascendingheaderstyle backcolor="#4B4B4B" />
                                            <sorteddescendingcellstyle backcolor="#E5E5E5" />
                                            <sorteddescendingheaderstyle backcolor="#242121" />
                                        </asp:GridView>
               
                 <asp:SqlDataSource ID="sdsNotifications11" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                            ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" SelectCommand="SELECT Distinct  Tbl_Users.UserID, Tbl_Users.UserKey, Tbl_Users.U_Firstname + ' ' + Tbl_Users.U_Lastname as SenderName, Title,U_ProfilePic,Tbl_Notifications.DatePosted,ISNULL(ReadStatus,0) as ReadStatus, ItemID, Tbl_Notifications.NotifyID  From 
Tbl_Users INNER JOIN Tbl_Notifications ON Tbl_Users.UserID=Tbl_Notifications.UserID 
INNER JOIN Tbl_NotifyFor ON Tbl_Notifications.NotifyID=Tbl_NotifyFor.NotifyID
Where RecipID=?
ORDER BY Tbl_Notifications.DatePosted DESC">
                            <SelectParameters>
                               <asp:CookieParameter CookieName="FrUserID" Name="?" />
                            </SelectParameters>
                        </asp:SqlDataSource>
            </div><!--content-->
       
             <%--  <div id="contentbox">
                   <div id="ajaxrequest"></div>
               </div> --%>           
            </div>
                </ContentTemplate>
                    <Triggers>
                       
                    </Triggers>
                </asp:UpdatePanel>
                  <div class="divLoadData">
                     
                 </div>
                 <div id="divPostsLoader">
                 </div>
    </div><!--col-md-10 col-sm-12 col-xs-12-->   

            <!--text-->
           
         
</div><!--wrapperblock-->
    <div id="inline1" style="max-width:1100px; width:95%; display: none;">

     <div class="col-md-12">

        <div class="col-md-5"><img src="../images/profileim.jpg" width="100%" /><br /><br /><img src="../images/image2.jpg" width="100%" /> <br /><br /><img src="../images/images6.jpg" width="100%" /><br /><br /><img src="../images/images4.jpg" width="100%" /></div><!--5-->
        <div class="col-md-7"> 
           
           <div class="col-md-12">
                   <div class="col-md-8 col-xs-12">
                    <div class="liimg"><img class="img-circle" src="../images/liimg.png" alt="image"/></div>
                   <div>
                    <div class="litext">Little Mistress               <div class="litext">Little Mistress</div>
                    <div class="ltext"><img src="../images/views.png" /> 500 Views</div>
                    </div>
               </div>
               <div class="col-md-4 col-xs-12 addto">
                  <ul>
                    <li><a href="followers-page.html"><img src="../images/fol.png" style="margin-right:6px;" /> FOLLOW</a></li>
                    <li><a href=""><img src="../images/msg.png" style="margin-right:4px;" /> MESSAGE</a></li>
                    <li><a href=""><img src="../images/add.png" style="margin-right:6px;" /> ADD TO</a></li>
                  </ul> 
               </div>
          </div><!--col-md-12--> 
          <div class="col-md-12" style="margin:0 0 20px 0; float:left; width:100%; border-bottom:#a8a8a8 solid 1px;"></div>  
          
          <div class="col-md-12 lighttext">
                      Little Mistress Heavily Embellished<br />
                      Gold and Black Bandeau Maxi Dress<br /><br />

                      code: AW15-AAD053-24<br />

                      Item: 39970281<br /><br />

                      A maxi bandeau dress with heavily<br />
                      embellished art deco black sequins. <br /> <br />
                      Model wears a size 10.<br />
                      REF: L673D1A<br />

                      Product Care<br /><br />

                      Material: Outer: 100% polyester<br />
                      Hand wash only /do not tumble dry<br />
                      iron on reverse side/ do not dry clean<br />
              </div><!--lightcom-->
              
          <div class="col-md-12" style="margin:20px 0 20px 0; border-bottom:#a8a8a8 solid 1px;"></div>            
          <div class="col-md-12">
               <div class="col-md-4 lightch" style="border-right:#a8a8a8 solid 1px;"><a href="followers-page.html">
               <img src="../images/like.png" style="margin-right:6px;" /> Like (99)</a></div>
               <div class="col-md-4 lightch" style="border-right:#a8a8a8 solid 1px;" ><a href="profile-page-comments.html">
               <img src="../images/comm.png" style="margin-right:6px;" /> Comment (24)</a></div>
               <div class="col-md-4 lightch"><a href="followers-page.html"><img src="../images/star.png" style="margin-right:6px;"  /> Ratings (244)</a></div>
          </div><!--col-md-12-->  
        
        </div><!--7-->
  
     </div><!--12-->
     
</div><!--inline-->
     </div>
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
     <script src="../source/jquery.fancybox.pack.js" type="text/javascript"></script>
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
                      window.history.pushState('d', 't', 'http://presspreview.azurewebsites.net/brand/notifications.aspx');

                  }

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
