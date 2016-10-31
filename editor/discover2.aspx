<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeFile="discover2.aspx.cs" Inherits="home" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Press Preview - Discover Page - Item</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../css/checkbox.css"/>
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<!--lightbox-->
	<script type="text/javascript" src="../source/jquery.fancybox.js?v=2.1.5"></script>
	<link rel="stylesheet" type="text/css" href="../source/jquery.fancybox.css?v=2.1.5" media="screen" />
<script src="../ckeditor/ckeditor.js"></script>
<script src="../js/sample.js"></script>
<script type="text/javascript">
    jQuery(document).ready(function () {
        jQuery('.fancybox').fancybox();
    });
	</script>
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
                        url: "discover.aspx\\GetBrandName",
                        data: "{'empName':'" + document.getElementById('txtsearch').value + "'}",
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
</head>

<body>
<form runat="server" ID="frm_Discover">
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
             <!--#INCLUDE FILE="../includes/messgTop.txt" -->
            
         <div class="col-md-3">   
            
         </div>   
            <ul class="nav navbar-nav" id="firstbb">
              <li><a href="Default.aspx">Activity</a></li>
              <li class="active"><a href="discover.aspx">Discover</a></li>
              <li><a href="brands.aspx">Brands</a></li>
               <li><a href="events.aspx">Events</a></li>
            </ul>           
              <ul class="nav navbar-nav navbar-right">
		     <li> <a href="editor-profile.aspx" style="margin-top: 10px;"><asp:Label runat="server" ID="lblUsername" ></asp:Label></a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                  <asp:Image runat="server" ID="imgUserIcon" ImageUrl="../images/menuright.png" CssClass="img-circle" style="width: 36px; height: 36px;"></asp:Image> <span> <img src="../images/triangle.png" /></span></a>
                <ul class="dropdown-menu"><li><a href="editor-profile.aspx"><img src="../images/profile.png" /><span class="sp"> My Profile</span></a></li>
                  <li><a href="#"><img src="../images/help.png" /><span class="sp"> Help</span></a></li>
                  <li><a href="../logout.aspx"><img src="../images/logout.png" /><span class="sp"> Log Out</span></a></li>
                </ul>
              </li>
            </ul> 
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>

    </div><!--header bg-->
<!--Headerend-->


<!--text-->
 <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                        <ProgressTemplate>
                            <div id="dvLoading"></div>
                        </ProgressTemplate>

                    </asp:UpdateProgress> 
<div class="wrapperwhite">
          
      <div class="colrow"> 
      
       <div class="dropfirst">  
         <span class="folheading"><a href="discover.aspx"  style="color:#4e93ce;"><i class="fa fa-square" style="position:relative; top:-6px; font-size:6px;" ></i> Items</a></span> 
         <span class="folheading" style="margin-left:20px;"><a href="#"><i class="fa fa-square" style="position:relative; top:-6px; font-size:6px;" ></i> Lookbook</a></span> 
         <img src="../images/li.png" />     
       </div>                   
            
<div id="demodmenu">
  
<div id="close">
</div>
<div class="l">
    <asp:Label class="menudlist"  runat="server"  ID="lbCategory">Categories <i class="fa fa-caret-down" aria-hidden="true" style="font-size:14px; margin-left:6px; margin-top:-5px;"></i></asp:Label>
    <div class="menudlist_list" id="list1">
            <div class="mespace"></div>
             <asp:Repeater ID="rptCategories" runat="server" DataSourceID="sdsCategories" 
                onitemcommand="rptCategories_ItemCommand" >
                                <ItemTemplate>
                                    
                                    <li class="menudli">
                                        <asp:LinkButton runat="server" ID="lbtnSeason" CommandName="1" CommandArgument='<%# Eval("Title") %>'>
                                              <i class="fa fa-long-arrow-right" style="font-size:10px; font-weight:bold; margin-right:5px;"></i>
                                              <%#Eval("Title") %>
                                        </asp:LinkButton>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
              <asp:SqlDataSource runat="server" ID="sdsCategories" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' SelectCommand="SELECT [CategoryID], [Title] FROM [Tbl_Categories] ORDER BY [Title]"></asp:SqlDataSource>
            
            <div class="mespace"></div>
    </div>
</div>
<div class="l">
    <button class="menudlist" id="Button1">Seasons <i class="fa fa-caret-down" aria-hidden="true" style="font-size:14px;margin-left:6px; margin-top:-5px;"></i></button>
    <div class="menudlist_list" id="Div1">
            <div class="mespace"></div>
              <asp:Repeater ID="rptSeasons" runat="server" DataSourceID="sdsSeasons" 
                onitemcommand="rptSeasons_ItemCommand" >
                                <ItemTemplate>
                                    
                                    <li class="menudli">
                                        <asp:LinkButton runat="server" ID="lbtnSeason" CommandName="1" CommandArgument='<%# Eval("Season") %>'>
                                              <i class="fa fa-long-arrow-right" style="font-size:10px; font-weight:bold; margin-right:5px;"></i>
                                              <%#Eval("Season")%>
                                        </asp:LinkButton>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
              <asp:SqlDataSource runat="server" ID="sdsSeasons" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' SelectCommand="SELECT [SeasonID], [Season] FROM [Tbl_Seasons] ORDER BY [Season]"></asp:SqlDataSource>
            <div class="mespace"></div>
    </div>
</div>    

<div class="l">
    <button class="menudlist" id="a">Holidays <i class="fa fa-caret-down" aria-hidden="true" style="font-size:14px;margin-left:6px; margin-top:-5px;"></i></button>
    <div class="menudlist_list" id="list2">
            <div class="mespace"></div>
            <asp:Repeater ID="rptHoliday" runat="server" DataSourceID="sdsHoliday" 
                onitemcommand="rptHoliday_OnItemCommand" >
                                <ItemTemplate>
                                    
                                    <li class="menudli">
                                        <asp:LinkButton runat="server" ID="lbtnSeason" CommandName="1" CommandArgument='<%# Eval("Title") %>'>
                                              <i class="fa fa-long-arrow-right" style="font-size:10px; font-weight:bold; margin-right:5px;"></i>
                                              <%#Eval("Title") %>
                                        </asp:LinkButton>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
              <asp:SqlDataSource runat="server" ID="sdsHoliday" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' SelectCommand="SELECT [HolidayID], [Title] FROM [Tbl_Holidays] ORDER BY [Title]"></asp:SqlDataSource>
            <div class="mespace"></div>
    </div>
</div>    

 </div><!--demo-->
 
                                
      </div> <!--per-->
      
</div><!--wrapperwhite-->

 

<div class="col-md-12 col-xs-12  discoverb">     
     <div class="discovewrapn1"> 
           <div id="divAlerts" runat="server" class="alert" visible="False">
                       <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                       <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                           Text="" Visible="True"></asp:Label>
                   </div>
                   <div id="contentbox">
                       <asp:Repeater runat="server" ID="rptLookbook"  OnItemDataBound="rptLookbook_ItemDataBound">
                           <ItemTemplate>
                               <div class="box">
                                   <div class="disblock">
                                       <a href="../lightbox/brand-item-view?v=<%# Eval("ItemID") %>" class="fancybox">
                                           <div class="dbl">
                                               <div class="hover ehover13">
                                                   <img class="img-responsive" src="../photobank/<%# Eval("FeatureImg") %>" alt="<%# Eval("Title","{0}") %>" /><div class="overlay">
                                                       <h2 class="titlet"><%# Eval("Title","{0}") %></h2>
                                                       <h2 class="linenew"></h2>
                                                       <h2>
                                                           <asp:Label runat="server" ID="lblDate" Text='<%# Eval("DatePosted") %>'></asp:Label></h2>
                                                   </div>
                                                   <!--overlay-->
                                               </div>
                                               <!--hover ehover13-->
                                           </div>
                                       </a>
                                       <div class="disname">
                                           <div class="mesbd">
                                               <div class="mimageb">
                                                   <div class="mimgd">
                                                       <a href="">
                                                           <img src='../brandslogoThumb/<%# Eval("logo") %>' style="width:36px; height:36px;" class="img-circle" /></a>
                                                   </div>
                                               </div>
                                               <!--mimageb-->
                                               <div class="mtextb" style="width: 75%; margin-left: 15px;">
                                                   <div class="m1">
                                                       <div class="muserd"><a href="../lightbox/brand-item-view?v=<%# Eval("ItemID") %>" class="fancybox"><%# Eval("Title","{0}") %></a></div>
                                                       <div class="muserdb">By <%# Eval("Name","{0}") %></div>
                                                   </div>
                                                   <div class="m1">
                                                       <div class="mtextd"><%# Eval("Description","{0}") %></div>
                                                   </div>
                                                   <div class="m1" style="margin-left: -20px;">
                                                       <div class="vlike">
                                                           <img src="../images/views.png" />
                                                           &nbsp;<%# Eval("Views") %></div>
                                                       <div class="vlike">
                                                           <img src="../images/liked.png" />
                                                           &nbsp;<asp:Label runat="server" ID="lblLikes" Text='<%# Eval("ItemID") %>'></asp:Label>
                                                       </div>
                                                       <div class="mdaysd" style="margin-top: -18px;">
                                                           <asp:Label runat="server" ID="lblDate2"><%# Eval("DatePosted") %></asp:Label>
                                                       </div>
                                                   </div>
                                               </div>
                                               <!--mtextb-->
                                           </div>
                                           <!--mseb-->
                                       </div>
                                   </div>
                               </div>
                               <!--box-->

                           </ItemTemplate>
                            <FooterTemplate>
                         <asp:Label ID="lblEmptyData" style="margin-left: 40%;" runat="server" Visible='<%# ((Repeater)Container.NamingContainer).Items.Count == 0 %>' Text="No item found" />
                     </FooterTemplate>
                       </asp:Repeater>
                       <asp:SqlDataSource runat="server" ID="sdsLookbooks" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                       SelectCommand="SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, dbo.Tbl_Brands.Logo, dbo.Tbl_Items.ItemID, dbo.Tbl_Items.Title, ItemKey, dbo.Tbl_Items.Description, dbo.Tbl_Items.FeatureImg,dbo.Tbl_Items.Views, CAST(dbo.Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted, dbo.Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands INNER JOIN dbo.Tbl_Items ON dbo.Tbl_Brands.UserID = dbo.Tbl_Items.UserID
                      Where dbo.Tbl_Items.IsDeleted IS NULL AND dbo.Tbl_Items.IsPublished=1
                                ORDER BY dbo.Tbl_Items.DatePosted DESC"></asp:SqlDataSource>
                       <!--box-->
                   </div>         
</div><!--discover-->     
         
         
     
     <div class="discovewrapsn1">
              
              <!--search-->
                  <div class="col-md-12 discrigblock">
                          <div class="searchb">
                             <div class="serheading">Search</div> 
                             <div class="serinput">
                                 <span class="fa fa-search"></span>
                                 <input type="text" runat="server" id="txtsearch" placeholder="search" value="" class="sein" OnServerChange="txtsearch_OnServerChange" />
                             </div> <!--serinput-->
                         </div><!--search-->
                  </div><!--colmd12-->
                  <div class="dissp"></div>
                  
            <!--colors-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                            <div class="serheading" style="margin-bottom:10px;">Color <span class="text-danger">*</span></div> 
                             <asp:Label runat="server" ID="lblColor1" Visible="False"  Text=""/>
                             <img src="../images/button.png"  class="cp-align" />
                         </div><!--search-->
                  </div><!--colmd12-->
                  <div class="dissp"></div> 
                  
                  
                                    
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading" style="margin-bottom:10px;">Retail Price</div> 
                             
                             <div class="dblock">
                              <asp:CheckBox ID="chkP1" runat="server" oncheckedchanged="chkP1_CheckedChanged" 
                                              Text="$0-$100" AutoPostBack="True"/>
                              
                             </div> 
                              <div class="dblock">
                              <asp:CheckBox ID="chkP2" runat="server" oncheckedchanged="chkP2_OnCheckedChanged" 
                                              Text="$100-$200" AutoPostBack="True"/>
                              
                             </div> 
                              <div class="dblock">
                              <asp:CheckBox ID="chkP3" runat="server" oncheckedchanged="chkP3_OnCheckedChanged" 
                                              Text="$200-$300" AutoPostBack="True" />
                              
                             </div> 
                              <div class="dblock">
                              <asp:CheckBox ID="chkP4" runat="server" oncheckedchanged="chkP4_OnCheckedChanged" 
                                              Text="$300-$400" AutoPostBack="True"/>
                              
                             </div> 
                              <div class="dblock">
                              <asp:CheckBox ID="chkP5" runat="server" oncheckedchanged="chkP5_OnCheckedChanged" 
                                              Text="$400-$500" AutoPostBack="True"/>
                              
                             </div> 
                              <div class="dblock">
                              <asp:CheckBox ID="chkP6" runat="server" oncheckedchanged="chkP6_OnCheckedChanged" 
                                              Text="$500 and above" AutoPostBack="True"/>
                              
                             </div> 
                             
                         </div><!--search-->
                  </div><!--colmd12-->
                         
                  <div class="dissp"></div> 
     
                  
                  
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading" style="margin-bottom:10px;">Brands</div> 
                             <asp:updatepanel runat="server" ID="up_Categories" >
                                 <ContentTemplate>
                             <div id="brandlst">
                              <asp:checkboxlist runat="server" ID="chkBrands" 
                                         DataSourceID="sdsMoreBrands" DataTextField="Name" DataValueField="UserID">
                                     </asp:checkboxlist>
                              <asp:SqlDataSource runat="server" ID="sdsbrandsSearch" 
                             ConnectionString='<%$ ConnectionStrings:GvConnection %>' 
                             ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                             SelectCommand="SELECT Top 6 [BrandID], [BrandKey], [Name],[UserID] FROM [Tbl_Brands] ORDER BY [TotalViews] DESC"></asp:SqlDataSource>
                             
                             <asp:SqlDataSource runat="server" ID="sdsMoreBrands" 
                             ConnectionString='<%$ ConnectionStrings:GvConnection %>' 
                             ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                             SelectCommand="SELECT Top 10 [BrandID], [BrandKey], [Name],[UserID] FROM [Tbl_Brands] ORDER BY [TotalViews] DESC"></asp:SqlDataSource>
                             </div>
                              <div class="bmore"><asp:LinkButton runat="server" ID="btn_ViewMore" 
                                     CssClass="bmore" Text="View More" onclick="btn_ViewMore_Click"></asp:LinkButton> 
                                 <asp:LinkButton runat="server" CssClass="bmore" ID="btn_ViewLess" 
                                     Text="See fewer" Visible="False" onclick="btn_ViewLess_Click"></asp:LinkButton></div>
                                 </ContentTemplate>
                             </asp:updatepanel>
                         </div><!--search-->
                         
                        <%-- <div class="bmore" onclick="showbmore()">View More</div>
                         <div class="bfewer" onclick="showbfewer()" style="display:none;">See fewer</div>--%>
                         
                  </div><!--colmd12-->
                         
                  <div class="dissp"></div> 
                  
                  
          <!--tags-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading" style="margin-bottom:20px;">Related Tags</div> 
                             
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> Name</a></div>
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> Long Name</a></div>
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> Name</a></div>
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> NA</a></div>
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> NA</a></div>
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> Long Name</a></div>
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> 1</a></div>
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> Name</a></div>
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> Tag Name</a></div>
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> 1</a></div>
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> 2</a></div>
                             
                            <div id="tagfewer">
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> Name</a></div>
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> Long Name</a></div>
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> Name</a></div>
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> NA</a></div>
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> NA</a></div>
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> Long Name</a></div>
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> 1</a></div>
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> Name</a></div>
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> Tag Name</a></div>
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> 1</a></div>
                             <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> 2</a></div>
                            </div> 
                             
                         </div><!--search-->
                         
                         <div class="fewer" onclick="showtags()">See fewer tags</div>
                         <div class="fewerf" onclick="showtagsf()" style="display:none;">See full tags</div>
                  </div><!--colmd12-->
                  <div class="dissp"></div>                                 

              
              
     </div><!--discoverwraps-->
     
     
</div><!--col-md-12-->

 </ContentTemplate>
      <Triggers>
          <asp:AsyncPostBackTrigger ControlID="rptCategories" EventName="ItemCommand"/>
          <asp:AsyncPostBackTrigger ControlID="rptSeasons" EventName="ItemCommand"/>
          <asp:AsyncPostBackTrigger ControlID="rptHoliday" EventName="ItemCommand"/>
      </Triggers>
    </asp:UpdatePanel> 

<div id="inline1" style="max-width:1150px; width:100%; display: none;">

      <div class="lightboxheaderblock">
        <div class="lightboxblockmain">
          <div class="lightboxheaderimg"><img class="img-responsive" src="images/follo.png" /></div><!--lightboxheaderimg-->
          <div class="lightboxheadertext">Itme Name Goes Here</div><!--lightboxtext-->
          <div class="lightboxheadertext1">
                  <div class="lightb"><i class="fa fa-eye" aria-hidden="true"></i> &nbsp; 500 Views</div>
                  <a href="Massenger-Page.html"><i class="fa fa-heart" aria-hidden="true"></i> &nbsp; Message</a>
                  <div class="lightb1"><i class="fa fa-plus-circle" aria-hidden="true"></i> &nbsp; Wishlist</div>
          </div><!--lightboxtext1-->
        </div><!--lightboxblockmain--> 
         

<div class="lightboxblockmain1">
          <ul class="nav navbar-nav" id="firstbb">
              <li class="dropdown">
                 <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                 <i class="fa fa-gift" aria-hidden="true"></i> Get A Gift </a>
                 <ul class="dropdown-menu" style="margin-top:-1px;">
                  <li><form action="">
                        <textarea class="texarea" placeholder="Leave a comment"></textarea>
                        <input type="submit" class="textsub" value="Request" />
                    </form></li>
                </ul>
              </li>
              
              
              <li class="dropdown">
                 <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                 <i class="fa fa-tags" aria-hidden="true"></i> Request Sample</a>
                 <ul class="dropdown-menu" style="margin-top:-1px;">
                  <li><form action="">
                        <textarea class="texarea" placeholder="Leave a comment"></textarea>
                        <input type="submit" class="textsub" value="Request" />
                    </form></li>
                </ul>
              </li>
              
           </ul>   
</div><!--lightboxblockmain--> 

        
        
        
<div class="lightboxblockmain1m">
<ul class="nav navbar-nav" id="firstbb">
              <li class="dropdown" style="width:100%;">
                 <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                 <i class="fa fa-gift" aria-hidden="true"></i> Get A Gift </a>
                 <ul class="dropdown-menu" style="margin-top:-1px; width:100%; height:100%">
                  <li><form action="">
                        <textarea class="texarea" placeholder="Leave a comment"></textarea>
                        <input type="submit" class="textsub" value="Request" />
                    </form></li>
                </ul>
              </li>
              
              
              <li class="dropdown" style="width:100%;">
                 <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                 <i class="fa fa-tags" aria-hidden="true"></i> Request Sample</a>
                 <ul class="dropdown-menu" style="margin-top:-1px; width:100%; height:100%">
                  <li><form action="">
                        <textarea class="texarea" placeholder="Leave a comment"></textarea>
                        <input type="submit" class="textsub" value="Request" />
                    </form></li>
                </ul>
              </li>
              
           </ul>   
     </div><!--lightboxblockmain--> 
      </div>  
    
    
    <div class="lightboxmaintext" >
         <div class="col-md-7 col-xs-12 prolightimg" >
             <a href="Profile-Page-Items-without-edit.html"><img src="images/proimg1.png" width="100%" /><br /></a>
             <a href="Profile-Page-Items-without-edit.html"><img src="images/proimg1.png" width="100%" /><br /></a>
             <a href="Profile-Page-Items-without-edit.html"><img src="images/proimg1.png" width="100%" /><br /></a>
         </div><!--col-md-7-->
         
         <div class="col-md-5 col-xs-12" >
         
         
                  <div class="discrigblock">
                    <div class="searchb">
                     <div class="serheading1">Like this Item</div> 
                     
                       <div class="biglike">
                           <a href="Overview-Likes.html"><i class="fa fa-heart" aria-hidden="true" id="round"></i>  Likes (245)</a>
                       </div>
                       
                    </div> 
                  </div> 
                  
                  <div class="dissp1"></div>
                  
                  
             <!--basic ino-->     
                <div class="discrigblock">
                  <div class="searchb"><div class="serheading1">Basic Info</div> </div>
                  <div class="lightboxpicdata"> 
                      Little Mistress Heavily Embellished<br />
                      Gold and Black Bandeau Maxi Dress<br /><br />
                      code: AW15-AAD053-24<br /><br />
                      Item: 39970281<br /><br />
                      A maxi bandeau dress with heavily<br />
                      embellished art deco black sequins. <br />
                      Model wears a size 10.<br />
                      REF: L673D1A<br />
                      Product Care<br />
                      Material: Outer: 100% polyester<br />
                      Hand wash only /do not tumble dry/<br />
                      iron on reverse side/ do not dry clean<br />
               </div></div>
           <div class="dissp1"></div>  
           
           
           
           <!--stylenumber-->     
                <div class="discrigblock">
                 
                 <div class="rpri">
                     <div class="searchb"><div class="serheading1">Retail Price</div> 
                        <div class="lightbtext">$350.00</div>
                     </div>
                 </div>    
                     
                 <div class="rpri1">
                     <div class="searchb"><div class="serheading1">Wholesale Price</div> 
                        <div class="lightbtext">$200.00</div>
                     </div>
                 </div>   
                     
                </div>
           <div class="dissp1"></div>      
           
           
           <!--stylenumber-->     
                <div class="discrigblock">
                     <div class="searchb"><div class="serheading1">Style Number</div> 
                        <div class="lightbtext">#40127391</div>
                     </div>
                     

                </div>
           <div class="dissp1"></div>    
           
           
            <!--stylename-->     
                <div class="discrigblock">
                     <div class="searchb"><div class="serheading1">Style Name</div> 
                      <div class="lightbtext">Silk/Green/Olive</div>
                     </div>
                </div>
           <div class="dissp1"></div>    
           
           
            <!--tags-->     
                <div class="discrigblock">
                         <div class="searchb">
                             <div class="serheading1">Related Tags</div> 
                             
                             <div class="serheading1">
                             <div class="tagblock"><a href="">Name</a></div>
                             <div class="tagblock"><a href="">Long Name</a></div>
                             <div class="tagblock"><a href="">Name</a></div>
                             <div class="tagblock"><a href="">NA</a></div>
                             <div class="tagblock"><a href="">NA</a></div>
                             <div class="tagblock"><a href="">Long Name</a></div>
                             <div class="tagblock"><a href="">1</a></div>
                             <div class="tagblock"><a href="">Name</a></div>
                             <div class="tagblock"><a href="">Tag Name</a></div>
                             <div class="tagblock"><a href="">1</a></div>
                             <div class="tagblock"><a href="">2</a></div>
                             
                            <div id="tagfewer11">
                             <div class="tagblock"><a href="">Name</a></div>
                             <div class="tagblock"><a href="">Long Name</a></div>
                             <div class="tagblock"><a href="">Name</a></div>
                             <div class="tagblock"><a href="">NA</a></div>
                             <div class="tagblock"><a href="">NA</a></div>
                             <div class="tagblock"><a href="">1</a></div>
                             <div class="tagblock"><a href="">Name</a></div>
                             <div class="tagblock"><a href="">Tag Name</a></div>
                             <div class="tagblock"><a href="">1</a></div>
                             <div class="tagblock"><a href="">2</a></div>
                            </div>
                          </div>  
                             
                         </div><!--search-->
                         
                         
                       <div class="serheading1">
                         <div class="fewer" onclick="showtags11()">See fewer tags</div>
                         <div class="fewerf" onclick="showtagsf11()" style="display:none;">See full tags</div>
                       </div>  
                </div>
               <div class="dissp1"></div>  
               
               
               <!--comments-->
                <div class="discrigblock">
                    <div class="searchb">
                     <div class="serheading1">Comments - (24)</div> 
                     
                 <div class="col-md-12" style="margin-top:20px;">
                    <div class="col-md-2"><img src="images/follo.png" /></div>
                    <div class="col-md-10">
                        <textarea placeholder="Leave A Comments" class="textanew" name="texta" id="texta"></textarea>
                    </div> 
                    <div class="lightboxblockmain2">
                        <div class="lightboxeditbutton"><a href="">Post a Comment</a></div><!--lightboxeditbutton-->
                    </div><!--lightboxblockmain-->    
                </div><!--col-md-12-->
                
                <div class="col-md-12" style="margin:30px 0 30px 0; float:left; width:100%; border-bottom:#dadbdd solid 3px;"></div>   
          
              <div class="col-md-12">
                      <div class="col-md-2" id="comimg"><a href=""><img class="img-circle" src="images/comimg.png"   alt="image" style="margin-top:6px;"/></a></div>
                      <div class="col-md-10">
                          <span class="commh"><a href="">Caroline K. Colon</a> <br /></span>
                          <span class="commtext">Proin vel tellus quis erat luctus suscipit a vitae enim. Maecenas non leo eu risus elementum consequat et sit amet nisl. Nunc ornare diam nec augue luctus, ac tempor nulla cursus.</span>
                          <div class="col-md-12 reply"><img src="images/reply.png" /></div>
                      </div>
              </div><!--col-md-12--> 
              
              <div class="col-md-11" style="margin-left:40px;">
                      <div class="col-md-2" id="comimg"><a href=""><img class="img-circle" src="images/comimg.png"   alt="image" style="margin-top:6px;"/></a></div>
                      <div class="col-md-10">
                          <span class="commh"><a href="">Caroline K. Colon</a> <br /></span>
                          <span class="commtext">Nunc ornare diam nec augue luctus, ac tempor nulla cursus. </span>
                          <div class="col-md-12 reply"><img src="images/reply.png" /></div>
                      </div>
              </div><!--col-md-12--> 
              
              <div class="col-md-12">
                      <div class="col-md-2" id="comimg"><a href=""><img class="img-circle" src="images/comimg.png"   alt="image" style="margin-top:6px;"/></a></div>
                      <div class="col-md-10">
                          <span class="commh"><a href="">John Doe</a> <br /></span>
                          <span class="commtext">Proin vel tellus quis erat luctus suscipit a vitae enim. Maecenas non leo eu risus elementum consequat et sit amet nisl. Nunc ornare diam nec augue luctus, ac tempor nulla cursus.</span>
                          <div class="col-md-12 reply"><img src="images/reply.png" /></div>
                      </div>
              </div><!--col-md-12--> 
              
              <div class="col-md-12">
                      <div class="col-md-2" id="comimg"><a href=""><img class="img-circle" src="images/comimg.png"   alt="image" style="margin-top:6px;"/></a></div>
                      <div class="col-md-10">
                          <span class="commh"><a href="">John Doe</a> <br /></span>
                          <span class="commtext">Proin vel tellus quis erat luctus suscipit a vitae enim. Maecenas non leo eu risus elementum consequat et sit amet nisl. Nunc ornare diam nec augue luctus, ac tempor nulla cursus.</span>
                          <div class="col-md-12 reply"><img src="images/reply.png" /></div>
                      </div>
              </div><!--col-md-12--> 
                       
                    </div> 
                  </div> 
                  
                  <div class="dissp1"></div>  

         </div><!--col-md-5-->
    </div><!--lightboxmaintext--> 
</div><!--inline-->



<!--footer-->
  <div class="footerbg">
     <div class="row">
        <div class="col-md-11 col-xs-10">©2016 Press Preview</div>
        <div class="col-md-pull-1 col-xs-pull-1">
           <div class="f1"><a id="loaddata"><img src="images/footerarrow.png" /></a></div>
           <div class="f2"></div>
        </div>
      </div>    
  </div><!--footer-->
<!--footer-->

</div><!--wrapper-->

    <!-- Placed at the end of the document so the pages load faster -->
    <script src="../js/bootstrap.js"></script>
    <script src="../masonry/js/libs/imagesloaded.3.1.8.min.js"></script>
    <script src="../masonry/js/libs/jquery.masonry.3.2.1.min.js"></script>
    <script src="../masonry/js/base2.js" type="text/javascript"></script>


	<script>	    window.jQuery || document.write('<script src="customscroller/jquery-1.11.0.min.js"><\/script>')</script>
	<!-- custom scrollbar plugin -->
	<script src="../customscroller/jquery.mCustomScrollbar.concat.min.js"></script>
    </form>
</body>
</html>

<script>
    jQuery(".menudlist").click(function (e) {
        e.preventDefault();
        e.stopPropagation();
        jQuery(".menudlist_list").not(jQuery(this).next()).hide();
        jQuery(this).next().toggle();

    });
    jQuery(".menudlist_list").find("li").click(function (e) {
        e.stopPropagation();
        alert(jQuery(this).text());
    });
    jQuery(document).click(function (e) {

        jQuery(".menudlist_list").hide();
    });
</script>
<script type="application/javascript" src="js/custom.js"></script>