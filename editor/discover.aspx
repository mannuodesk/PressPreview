<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="true" CodeFile="discover.aspx.cs" Inherits="home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Discover</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        #contentbox2, .wishlistitemsa {
    margin: auto;
    float: left;
    width: 100%;
}
        .grid{
            font-size:0px;
        }
        .hideresetbutton{
            display:none;
        }
        .showresetbutton{
            display:block;
        }
    </style>
<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../css/checkbox.css"/>
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
<link rel="stylesheet" type="text/css" href="../css/styleweb.css"/>

<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

<!--lightbox-->
	<link rel="stylesheet" type="text/css" href="../source/jquery.fancybox.css" media="screen" />
    <link href="../css/jquery-ui.css" rel="stylesheet" type="text/css" />
   <script src="../js/jquery-ui.min.js"></script>
     <link href="../css/breadcrumb.css" rel="stylesheet" type="text/css" />
   
      
  
    <script src="../js/JSession.js" type="text/javascript"></script>
   <script type="text/javascript">
       $(document).ready(function () {

           GetRecords();
       });

       $(window).scroll(function () {
           if ($(window).scrollTop() == $(document).height() - $(window).height()) {
               //   $("#loadMore").fadeIn();
               GetRecords();
           }
       });
       var pageIndex = 0;
       var pageCount;
       function GetRecords() {
           pageIndex++;
           //////if (pageIndex == 1 || pageIndex <= pageCount) {
           // $('#divPostsLoader').prepend('<img src="../images/ajax-loader.gif">');
           $('#loader').show();

           //send a query to server side to present new content
           $.ajax({
               type: "POST",
               url: "discover.aspx\\LoadData",
               data: '{pageIndex: ' + pageIndex + '}',
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: OnSuccess
           });
           ////////} else {
           ////////    $('.loadMore').hide();
           ////////    var masonry = $('.grid');
           ////////    masonry.masonry({
           ////////        itemSelector: '.box'
           ////////    });
           ////////    setTimeout(function () {
           ////////        $(masonry).show();
           ////////        $(masonry).masonry('reloadItems');
           ////////        $(masonry).masonry('layout');
           ////////        $(".box").css("visibility", "visible");
           ////////    }, 5000);
           ////////    //   $('.loadMore').val('No more records');
           ////////    //setTimeout(function () { $('.loadMore').fadeOut(); }, 4000);
           ////////}
       }




       var hasItem = false;
       function OnSuccess(data) {
           $("#contentbox").removeAttr("style");
           $('#norecord').hide();
           $('#LoaderItem').show();
           console.log(data);
           var items = data.d;
           var fragment;
           if (items.length != 0) {
               hasItem = true;
               var $grid = $('.grid');
               $grid.masonry({
                   itemSelector: '.box',
                   transitionDuration: '0.4s',
               });
               $.each(items, function (index, val) {
                   console.log(index);
                   console.log(val.ItemId);
                   pageCount = val.PageCount;
                   fragment += "<div class='box'  id='b" + val.ItemId + "'> " +
                                    " <div class='disblock'> " +
                                        "  <a href='itemview2.aspx?v=" + val.ItemId + "' class='fancybox'> " +
                                                "<div class='dbl'> " +
                                        "          <div class='hover ehover13'> " +
                                                        "<img class='img-responsive' src='../photobank/" + val.FeatureImg + "' alt='" + val.Title + "' /><div class='overlay'> " +
                                           "                  <h2 class='titlet'>" + val.Title + "</h2> " +
                                               "              <h2 class='linenew'></h2> " +
                                                   "          <h2> " +
                                                       "          <span Id='lblDate' Text='" + val.DatePosted + "'></span></h2> " +
                                                    "</div> " +
                                                               "              <!--overlay--> " +
                                                 "</div> " +
                                                 "<!--hover ehover13--> " +
                                                                           "      </div> " +
                                                                               "  </a> " +
                                                                                   "  <div class='disname'> " +
                                                                                       "      <div class='mesbd'> " +
                                                                                           "          <div class='mimageb'> " +
                                                                                               "              <div class='mimgd'> " +
                                                                                                   "                  <a href=''> " +
                                                                                                       "                      <img src='../brandslogoThumb/" + val.ProfilePic + "' style='width:36px; height:36px;' class='img-circle' /></a> " +
                                                                                                           "              </div> " +
                                                                                                               "          </div> " +
                                                                                                                   "          <!--mimageb--> " +
                                                                                                                       "          <div class='mtextb' style='width: 75%; margin-left: 15px;'> " +
                                                                                                                           "              <div class='m1'> " +
                                                                                                                               "                  <div class='muserd'><a href='itemview2.aspx?v=" + val.ItemId + "'class='fancybox'>" + val.Title + "</a></div> " +
                                                                                                                                   "                  <div class='muserdb'>By " + val.Name + "</div> " +
                                                                                                                                       "              </div> " +
                                                                                                                                           "              <div class='m1'> " +
                                                                                                                                               "                  <div class='mtextd'>" + val.Description + "</div> " +
                                                                                                                                                   "              </div> " +
                                                                                                                                                       "              <div class='m1' style='font-size:12px;'> " +
                                                                                                                                                           "                  <div class='vlike'> " +
                                                                                                                                                               "                      <img src='../images/views.png' /> " +
                                                                                                                                                                   "                      &nbsp;" + val.Views + "</div> " +
                                                                                                                                                                       "                  <div class='vlike'> " +
                                                                                                                                                                           "                      <img src='../images/liked.png' /> " + val.Likes + "  </div> " +
                                                                                                                                                                                       "                  <div class='mdaysd' > " +
                                                                                                                                                                                           "                      <span ID='lblDate2'>" + val.DatePosted + "</span> " +
                                                                                                                                                                                               "                  </div> " +
                                                                                                                                                                                                   "              </div> " +
                                                                                                                                                                                                       "          </div> " +
                                                                                                                                                                                                           "          <!--mtextb--> " +
                                                                                                                                                                                                               "      </div> " +
                                                                                                                                                                                                                   "      <!--mseb--> " +
                                                                                                                                                                                                                       "  </div> " +
                                                                                                                                                                                                                           " </div> " +
                                                                                                                                                                                                                               " </div>";

               });
           }
           else if (hasItem == false) {
               $('#LoaderItem').hide();
               $('#norecord').html("No Record Found");
               $('#norecord').show();
           }
           else {
               $('#LoaderItem').hide();
               $('#norecord').html("No More Record Found");
               $('#norecord').show();
           }


           var $items = $(fragment);
           $items.hide();
           $grid.append($items);
           $grid.masonry('layout');
           $items.imagesLoaded(function () {
               $grid.masonry('appended', $items);
               $grid.masonry('layout');
               $items.show();
               $('#LoaderItem').hide();
           });
           //var $items = $(fragment);
           //$items.hide();
           //$grid.append($items).masonry('appended', $items);
           //$grid.masonry('layout');
           //$items.imagesLoaded(function () {
           //    $grid.masonry('layout');

           //});

           //$items.imagesLoaded().Done(function () {
           //    $items.show();

           //});


           //$items.imagesLoaded().progress(function (imgLoad, image) {
           //    // get item
           //    // image is imagesLoaded class, not <img>, <img> is image.img
           //    var $item = $(image.img).parents('.item');
           //    $grid.masonry('layout');
           //    // un-hide item
           //    $item.show();
           //    // masonry does its thing
           //    $grid.masonry('appended', $item);
           //});





           $('#loader').hide();
           if (pageCount <= 1) {
               $('.loadMore').hide();
           }

       }






       $(function () {
           $("div").slice(0, 4).show();
           $(".loadMore").on('click', function (e) {


               e.preventDefault();
               var id = $(this).attr('id');
               $("div:hidden").slice(0, 4).slideDown();
               if ($("div:hidden").length == 0) {
                   $("#load").fadeOut('slow');
               }

               switch (id) {
                   case 'default':
                       $('.loadMore').show();
                       //$('.grid').masonry('destroy');
                       GetRecords();
                       break;
                   case 'byCategory':
                       $('.loadMore').show();
                       //$('.grid').masonry('destroy');
                       GetRecordsByCategory(selectedcat);
                       break;
                   case 'bySeason':
                       $('.loadMore').show();
                       //$('.grid').masonry('destroy');
                       GetRecordsBySeason(selectedseason);
                       break;
                   case 'byHoliday':
                       $('.loadMore').show();
                       //$('.grid').masonry('destroy');
                       GetRecordsByHoliday(selectedholiday);
                       break;
               }

           });
       });


       //$(window).resize(function ()
       //{
       //    $('.grid').masonry('destroy');
       //    var masonry = $('.grid');
       //    masonry.masonry({
       //        itemSelector: '.boxn1'
       //    });
       //    //$(masonry).append(fragment);
       //    $(masonry).masonry('reloadItems');
       //    $(masonry).masonry('layout');

       //});


       //$(window).load(function () {
       //    $('.grid').masonry('destroy');
       //    var masonry = $('.grid');
       //    masonry.masonry({
       //        itemSelector: '.boxn1'
       //    });
       //    //$(masonry).append(fragment);
       //    $(masonry).masonry('reloadItems');
       //    $(masonry).masonry('layout');

       //});


       function DeleteItem(id) {
           //Code to delete the item from the database here
           if (confirm('Are you sure, you want to delete ?')) {
               $.ajax({
                   type: "POST",
                   url: "profile-page-items.aspx\\DeleteItem",
                   data: "{'id':'" + id + "'}",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   async: true,
                   cache: false,
                   success: function (data) {
                       var box = '#b' + id;
                       $(box).remove();
                   }
               });
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
<form runat="server" id="frmBrands" DefaultFocus="txtsearch" DefaultButton="btnSearch">
      <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True"  EnablePartialRendering="True">
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
              <li><a href="Default.aspx" tabindex="0">Activity</a></li>
              <li class="active"><a href="discover.aspx" tabindex="1">Discover</a></li>
              <li><a href="brands.aspx" tabindex="2">Brands</a></li>
               <li><a href="events.aspx" tabindex="3">Events</a></li>
            </ul>            
             <!--#INCLUDE FILE="../includes/influencer_settings.txt" -->   
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>

    </div><!--header bg-->
<!--Headerend-->

<!--Banner-->
   
<!--bannerend-->


<!--text-->
  <div class="wrapperwhite">

                <div class="colrow">
                    <div class="dropfirst">  
                     <span class="folheading"><a href="discover.aspx" tabindex="10"  style="color:#4e93ce;"><i class="fa fa-square" style="position:relative; top:-6px; font-size:6px;" ></i> Items</a></span> 
                     <span class="folheading" style="margin-left:20px;"><a href="discover-lookbook.aspx" tabindex="11"><i class="fa fa-square" style="position:relative; top:-6px; font-size:6px;" ></i> Lookbook</a></span> 
                    <img src="../images/li.png" />     
                    </div>
                    <div id="demodmenu">
  
                        <div id="close"></div>
                        <div class="l">
    <asp:Label class="menudlist"  runat="server"  ID="lbCategory" Text="Categories" tabindex="12">Categories <i class="fa fa-caret-down" aria-hidden="true" style="font-size:14px; margin-left:6px; margin-top:-5px;"></i></asp:Label>
    <div class="menudlist_list" id="list1">
            <div class="mespace"></div>
             <asp:Repeater ID="rptCategories" runat="server" DataSourceID="sdsCategories" 
                onitemcommand="rptCategories_ItemCommand" >
                                <ItemTemplate>
                                    
                                    <li class="menudli">
                                        <asp:LinkButton runat="server" ID="lbtnCategory" CommandName="1" CommandArgument='<%# Eval("CategoryID") %>'>
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
    <button class="menudlist" id="btnSeason" tabindex="13">Seasons <i class="fa fa-caret-down" aria-hidden="true" style="font-size:14px;margin-left:6px; margin-top:-5px;"></i></button>
    <div class="menudlist_list" id="list2">
            <div class="mespace"></div>
              <asp:Repeater ID="rptSeasons" runat="server" DataSourceID="sdsSeasons" 
                onitemcommand="rptSeasons_ItemCommand" >
                                <ItemTemplate>
                                    
                                    <li class="menudli">
                                        <asp:LinkButton runat="server" ID="lbtnSeason" CommandName="1" CommandArgument='<%# Eval("SeasonID") %>'>
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
    <button class="menudlist" id="btnHoiday" tabindex="14">Holidays <i class="fa fa-caret-down" aria-hidden="true" style="font-size:14px;margin-left:6px; margin-top:-5px;"></i></button>
    <div class="menudlist_list" id="list2">
            <div class="mespace"></div>
            <asp:Repeater ID="rptHoliday" runat="server" DataSourceID="sdsHoliday" 
                onitemcommand="rptHoliday_OnItemCommand" >
                                <ItemTemplate>
                                    
                                    <li class="menudli">
                                        <asp:LinkButton runat="server" ID="lbtnHoliday" CommandName="1" CommandArgument='<%# Eval("HolidayID") %>'>
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
                   
                </div>
                <!--per-->
            </div><!--wrapperwhite-->
     <div class="col-md-12 col-xs-12  discoverb">
           <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                        <ProgressTemplate>
                            <div id="dvLoading"></div>
                        </ProgressTemplate>

                    </asp:UpdateProgress>    
             <script type="text/javascript" language="javascript">
                 function pageLoad() {
                     setTimeout(function () { $('#divAlerts').fadeOut(); }, 4000);
                 }
        </script>
            <!--col-md-12-->

              <asp:LinkButton runat="server" PostBackUrl=""></asp:LinkButton>
               <div class="discovewrapn1" >
                   <div style="display:none">
                                 <div id="divAlerts" runat="server" class="alert" visible="False">
                       <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                       <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                           Text="" Visible="True"></asp:Label>
                   </div>
                   </div>
         
                   <div id="contentbox" style="height:none">
                       <div class="grid" id="mygrid" style="height:auto !important;">

                       </div>
                       <div id="LoaderItem"  style="display:none;">
                           <center>
         <%--                  <i class="fa fa-spinner" aria-hidden="true"></i>--%>
                           <img src="../images/ring.gif" />
                           <%-- <img src="../images/Rainbow.gif"  /> --%>
                           </center>

                       </div>
                       
                       
                       
                       <div id="norecord" style="display:none;    margin-bottom: 63px;">
                           No Record Found
                       </div>
                        <%--<div id="divPostsLoader" style="margin-bottom:40px;">
                     <div id="loader" style="width:100%; margin:0 auto; display:none;">
                     <img src="../images/ajax-loader.gif" style="padding-bottom: 20px; position: relative; top: 40px; left: 60px;" ></div>
                     <a href="#" id="default"  class="loadMore">Load More</a>
                 </div>--%>
                       <!--box-->
                   </div>
                   <!--content-->
              

               </div><!--col-md-10 col-sm-12 col-xs-12-->    
                 
              <div class="discovewrapsn1">
              
              <!--search-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading">Search</div> 
                             <asp:Button runat="server" ID="btnSearch" style="position: absolute; width: 0px; height: 0px;z-index: -1;"  OnClick="btnSearch_OnClick">
                                </asp:Button>
                             <div class="serinput">
                                 <span class="fa fa-search"></span>
                                 <asp:TextBox  runat="server" ID="txtsearch" placeholder=" search by item name" value="" CssClass="sein"   />
                               
                                    
                             </div> <!--serinput-->
                         </div><!--search-->
                  </div><!--colmd12-->
                  <div class="dissp"></div>
                  
           <!--colors-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading" style="margin-bottom:10px;">Color <span class="text-danger">*</span></div> 
                              <div id="trigger" style="width:100%;">
                                  <button id="eliminateColor" runat="server" onserverclick="eliminateColor_Click"  class="btn btn-link"><i class="fa fa-times-circle"></i> Reset</button>
                                   <input type="text" runat="server"  name="search" id="colbtn" placeholder="" readonly="readonly" value="" class="sein1" style="cursor:pointer; background: #F4F4F4;" tabindex="8">
                                        <%--<i class='ace-icon fa fa-pencil' style='position: relative;right: 26px; top: 13px;'></i>--%>
                                         <img src="../images/color.png"  alt="" style='position: relative; right: 16px; top: -26px; float: right;;'/>
                                   </input> 
                                 <%-- <img src="../images/button.png" id="colbtn" alt="" style="cursor:pointer;"/>--%>  
                                <%-- <a href="#" rel="popuprel" class="popup"><img src="../images/button.png" /></a>--%>
                               </div>
                         </div><!--search-->
                         
                         
                  </div><!--colmd12-->
                  <div class="dissp"></div>   
                   <div class="popupbox" id="popuprel">
                        <div class="block" id="block1"> 
                            <asp:Repeater runat="server" ID="rptColorlist" DataSourceID="sdsColorlist" OnItemCommand="rptColorlist_OnItemCommand">
                           <ItemTemplate>
                                 <div class="colum1">
                                     <div>
                                      <asp:LinkButton runat="server" ID="lbtnColor" CommandName="1" CommandArgument='<%# Eval("Colorid") %>'>
                                              <div class='color<%# Eval("status") %>'  style='background:#<%# Eval("Colorid") %>;'></div>
                                        </asp:LinkButton>
                                      </div> 
                                    
                              
                          </div><!--column--> 
                           </ItemTemplate>
                           </asp:Repeater>
                          <asp:SqlDataSource runat="server" ID="sdsColorlist" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                       SelectCommand="select ID,Colorid,status from Tbl_Colorlist"></asp:SqlDataSource>
                          </div> <!--block-->
                          <img src="../images/img.png" style="margin-top:135px;"/> 
                        </div> <!--popurel-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading" style="margin-bottom:10px;">Retail Price</div> 
                             
                             <div class="dblock">
                              <asp:CheckBox ID="chkP1" runat="server" oncheckedchanged="chkP1_CheckedChanged" 
                                              Text="$0-$100" AutoPostBack="True" EnableViewState="True"/>
                              
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
                              <asp:checkboxlist runat="server" ID="chkBrands"  OnSelectedIndexChanged="chkBrands_OnSelectedIndexChanged" AutoPostBack="True"
                                         DataSourceID="sdsMoreBrands" DataTextField="Name" DataValueField="UserID" >
                                     </asp:checkboxlist>
                              <asp:SqlDataSource runat="server" ID="sdsbrandsSearch" 
                             ConnectionString='<%$ ConnectionStrings:GvConnection %>' 
                             ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                             SelectCommand="SELECT Top 6 [BrandID], [BrandKey], [Name],[UserID] FROM [Tbl_Brands] ORDER BY [TotalViews] DESC"></asp:SqlDataSource>
                             
                             <asp:SqlDataSource runat="server" ID="sdsMoreBrands" 
                             ConnectionString='<%$ ConnectionStrings:GvConnection %>' 
                             ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                             SelectCommand="SELECT Top 10 [BrandID], [BrandKey], [Name],[UserID] FROM [Tbl_Brands] ORDER BY [TotalViews] DESC"></asp:SqlDataSource>
                            
                             <%--<asp:Button runat="server"  ID="btnSearchBrands"  class="hvr-sweep-to-right3" Text="Apply" OnClick="btnSearchBrands_OnClick"></asp:Button>--%>
                             </div>
                             
                              <div class="bmore"><asp:LinkButton runat="server" ID="btn_ViewMore" 
                                     CssClass="bmore" Text="View More" onclick="btn_ViewMore_Click"></asp:LinkButton> 
                                 <asp:LinkButton runat="server" CssClass="bmore" ID="btn_ViewLess" 
                                     Text="See fewer" Visible="False" onclick="btn_ViewLess_Click"></asp:LinkButton></div>
                                 </ContentTemplate>
                             </asp:updatepanel>
                            
                         </div><!--search-->
                         
                  </div><!--colmd12-->
                         
                  <div class="dissp"></div>                  
              
          <!--tags-->
                  <div class="col-md-12 discrigblock">
                  <asp:updatepanel runat="server" ID="up_Tags">
                          <ContentTemplate>
                         <div class="searchb">
                             <div class="serheading" style="margin-bottom:20px;">Related Tags</div> 
                             
                              <asp:Repeater runat="server" ID="rptTags" DataSourceID="sdsTags" 
                                      onitemcommand="rptTags_ItemCommand">
                                 <ItemTemplate>
                                     <div class="tagblock"><asp:LinkButton runat="server" ID="lbtnRemoveTag" CommandName="1" CommandArgument='<%# Eval("TagID","{0}")%>'><%# Eval("TagName") %></asp:LinkButton> </div>
                                 </ItemTemplate>
                             </asp:Repeater>
                                  <asp:SqlDataSource ID="sdsTags" runat="server" 
                                      ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                      ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                      SelectCommand="SELECT Top 25 [TagID], [TagName] FROM [Tbl_Tags] ORDER BY [TagID]">
                                      <%--SelectCommand="SELECT Top 25 [TagID], [Title] FROM [Tbl_ItemTags]   ORDER BY [TagID]">--%>
                                      
                                  </asp:SqlDataSource>
                                  
                                  <asp:SqlDataSource ID="sdsMoreTags" runat="server" 
                                      ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                      ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                      SelectCommand="SELECT [TagID], [TagName] FROM [Tbl_Tags] ORDER BY [TagID]">

                                      <%--SelectCommand="SELECT [TagID], [Title] FROM [Tbl_ItemTags]   ORDER BY [TagID]">--%>
                                     
                                  </asp:SqlDataSource>
                             
                         </div><!--search-->
                         
                           <div class="fewer" runat="server" ID="dvTagToggles">
                              <asp:LinkButton runat="server" ID="btn_MoreTags" 
                                     CssClass="fewer" Text="see full tags" onclick="btn_MoreTags_Click" ></asp:LinkButton> 
                                 <asp:LinkButton runat="server" CssClass="fewer" ID="btn_LessTags" 
                                     Text="See fewer tags" Visible="False" onclick="btn_LessTags_Click" ></asp:LinkButton></div>
                         </ContentTemplate>
                      </asp:updatepanel>
                  </div><!--colmd12-->
                  <div class="dissp"></div>                                 
          
              
     </div><!--discoverwraps-->
     </ContentTemplate>
      <Triggers>
          <asp:AsyncPostBackTrigger runat="server" ControlID="rptCategories" EventName="ItemCommand"/>
          <asp:AsyncPostBackTrigger runat="server" ControlID="rptSeasons" EventName="ItemCommand"/>
          <asp:AsyncPostBackTrigger runat="server" ControlID="rptHoliday" EventName="ItemCommand"/>
      </Triggers>
    </asp:UpdatePanel> 
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
</div><!--wrapper-->

<script src="../js/bootstrap.js"></script>
  <!-- Placed at the end of the document so the pages load faster -->
   <script src="../masonry/js/libs/imagesloaded.3.1.8.min.js"></script>
    <script src="../masonry/js/libs/jquery.masonry.3.2.1.min.js"></script>
    <script src="../masonry/js/base2.js" type="text/javascript"></script>
   
<script>
    jQuery(".menudlist").click(function (e) {
        e.preventDefault();
        e.stopPropagation();

        jQuery(".menudlist_list").not(jQuery(this).next()).hide();
        jQuery(this).next().toggle();

    });
    jQuery(".menudlist_list").find("li").click(function (e) {
        // e.stopPropagation();
        // alert(jQuery(this).text());
    });
    jQuery(document).click(function (e) {
        jQuery(".menudlist_list").hide();

    });
</script>
<script type="text/javascript">
    
    $("#colbtn").click(function (e) {
        e.preventDefault();
        e.stopPropagation();
        $(".popupbox").toggle();


    });
    //    window.onclick = function(e) {
    //        $(".popupbox").hide();
    //    };
    //    $(document).click(function (e) {
    //        $(".popupbox").hide();

    //    });
</script>
<script type="application/javascript" src="../js/custom.js"></script>
 <script src="../js/jquery-ui.min.js"></script>
 <script src="../js/color1.js" type="text/javascript"></script>
 
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
    <script type="text/javascript">
   
</script>  
    <script src="../source/jquery.fancybox.pack.js" type="text/javascript"></script>
   <script type="text/javascript">
       $(document).ready(function () {

           $(".fancybox").fancybox({
               fitToView: true,
               frameWidth: '80%',
               frameHeight: '100%',
               width: '87%',
               height: '100%',
               autoSize: false,
               closeBtn: true,
               closeClick: true,
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
                       //alert(url);
                       //var id = url.substring(url.lastIndexOf("/") + 1, url.length);
                       var id = url[1];
                       var pageUrl = 'http://presspreview.azurewebsites.net/editor/itemview2?v=' + id;
                       //  window.location = pageUrl;
                       window.history.pushState('d', 't', pageUrl);
                   }

               },
               beforeClose: function () {
                   var pageUrl = document.referrer; window.history.pushState('d', 't', 'http://presspreview.azurewebsites.net/editor/discover');
               }
           });

       });
</script>


</form>

</body>
</html>
