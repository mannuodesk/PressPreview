<%@ Page Language="C#" AutoEventWireup="true" CodeFile="discover-lookbook.aspx.cs" Inherits="editor_discover_lookbook" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Press Preview - Discover Page - Lookbook</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
      .menudlist{
        margin: 12px 0 0 !important;
        color: #a4a4a4 !important;
      }
        .grid{
            font-size:0px;
        }

 @media only screen and (max-width:767px){
    
        .addlineblock1, .colrow {
    display: block !important;
    
}
    
}
 @media only screen and (max-width:766px){
    
       #lbCategory{
     padding-bottom: 13%
       }
 
        #seasonDiv{
          margin-left: 24% 
      }
      
}
  @media only screen and (max-width:557px){
    
       #lbCategory{
           font-size: 13px;
    padding-bottom : 24%;
    margin: 22px 0px 0px 0px;
       }
        #btnSeason{
           font-size: 13px;
       }
       #btnHoiday{
           font-size: 13px;
       }
       
      #seasonDiv{
          margin-left: 24% 
      }
      
}
 @media only screen and (max-width:416px){
    
       #lbCategory{
           font-size: 11px;
    padding : 0px;
        padding-bottom: 26px;
    margin: 26px 0px 0px 0px !important;
       }
        #btnSeason{
           font-size: 11px;
       }
       #btnHoiday{
           font-size: 11px;
       }
       
      #seasonDiv{
          margin-left: 18% 
      }
}
 @media only screen and (max-width:354px){
    
       #lbCategory{
           font-size: initial;
    padding : 0px;
    margin: 12px 0px 0px 0px;
       }
        #btnSeason{
           font-size: initial;
       }
       #btnHoiday{
           font-size: initial;
       }
       
      #seasonDiv{
          margin-left: 0% 
      }
      .l{float: none !important}
}

 #contentbox{
          height: inherit  !important;
        }
    </style>
<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../css/checkbox.css"/>
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
 <link href="../source/jquery.fancybox.css" rel="stylesheet" type="text/css" />
<script src="../ckeditor/ckeditor.js"></script>
<script src="../js/sample.js"></script>
 <link href="../css/jquery-ui.css" rel="stylesheet" type="text/css" />
   <script src="../js/jquery-ui.min.js"></script>

  <script type="text/javascript">
      function doClick(ee,e)
      {
          if (e.key == "Enter")
          {
              $('#btnSearch').click();
          }
          
      }
      function GetTitle(title) {
          pageIndex_title = 0;
          pageCount_title = 0;
          $('.grid').empty();
          $('.grid').masonry('destroy');
          //alert($('#' + title).val());
          GetRecordsByTitle(title);
      }
      function GetRecordsByTitle(title) {
          titlee = title;
          selectedSorting = "title";
          // Page variables for search by Category
          pageIndex_cat = 0;
          pageCount_cat = 0;
          // Page variables for search by Season
          pageIndex_season = 0;
          pageCount_season = 0;
          // Page variables for search by Holiday
          pageIndex_holiday = 0;
          pageCount_holiday = 0;

          //pageIndex_title = 1;
          pageIndex_title++;
          //if (pageIndex_title == 1 || pageIndex_title <= pageCount_title) {


          // $('#divPostsLoader').prepend('<img src="../images/ajax-loader.gif">');
          $('#loader').show();

          //send a query to server side to present new content
          $.ajax({
              type: "POST",
              url: "discover-lookbook.aspx\\GetDataByTitle",
              data: '{pageIndex: ' + pageIndex_title + ', title:"' + title + '"}',
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              success: OnSuccess

          });

      }

      
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
          //if (pageIndex == 0 || pageIndex <= pageCount) {
          // $('#divPostsLoader').prepend('<img src="../images/ajax-loader.gif">');
          $('#loader').show();

          //send a query to server side to present new content
          $.ajax({
              type: "POST",
              url: "discover-lookbook.aspx\\LoadData",
              data: '{pageIndex: ' + pageIndex + '}',
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              success: OnSuccess
          });
          //} else {
          //    $('.loadMore').hide();
          //    var masonry = $('.grid');
          //    masonry.masonry({
          //        itemSelector: '.box'
          //    });

          //    setTimeout(function () {
          //        $(masonry).show();
          //        $(masonry).masonry('reloadItems');
          //        $(masonry).masonry('layout');
          //        $(".box").css("visibility", "visible");
          //    }, 2000);
          //    //   $('.loadMore').val('No more records');
          //    //setTimeout(function () { $('.loadMore').fadeOut(); }, 4000);
          //}
      }


      //function navigate(val) {
      //    alert(val);
      //}


      var hasItem = false;
      function OnSuccess(data) {
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
                              "      <div class='dbl'> " +
                                  "      <a href='/editor/discover-lookbook-details.aspx?v=" + val.LookBookKey + "' class=''> " +
                                  "          <div class='hover ehover13'> " +
                                      "              <img class='img-responsive' src='../photobank/" + val.FeatureImg + "' alt='" + val.Title + "' /><div class='overlay'> " +
                                          "                  <h2 class='titlet'>" + val.Title + "</h2> " +
                                              "                  <h2 class='linenew'></h2> " +
                                                  "                  <h2> " +
                                                      "                      <span Id='lblDate' Text='" + val.DatePosted + "'></span></h2> " +
                                                          "              </div> " +
                                                              "              <!--overlay--> " +
                                                                  "          </div> " +
                                                                      "          <!--hover ehover13--> " +
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
                                                                                                                              "                  <div class='muserd'><a href='/editor/discover-lookbook-details.aspx?v=" + val.LookBookKey + "' >" + val.Title + "</a></div> " +
                                                                                                                                  "                  <div class='muserdb'>By " + val.Name + "</div> " +
                                                                                                                                      "              </div> " +
                                                                                                                                          "              <div class='m1'> " +
                                                                                                                                              "                  <div class='mtextd'>" + val.Description + "</div> " +
                                                                                                                                                  "              </div> " +
                                                                                                                                                      "              <div class='m1' style='font-size:12px;'> " +
                                                                                                                                                          "                  <div class='vlike'> " +
                                                                                                                                                              "                      <img src='../images/views.png' /> " +
                                                                                                                                                                  "                      &nbsp;" + val.Views + "</div> " +
                                                                                                                                                                      "                  <!-- <div class='vlike'> " +
                                                                                                                                                                          "                      <img src='../images/liked.png' /> " + val.Likes + "  </div> --> " +
                                                                                                                                                                                      "                  <div class='mdaysd' > " +
                                                                                                                                                                                          "                      <span ID='lblDate2'>" + val.Dated + "</span> " +
                                                                                                                                                                                              "                  </div> " +
                                                                                                                                                                                                  "              </div> " +
                                                                                                                                                                                                      "          </div> " +
                                                                                                                                                                                                          "          <!--mtextb--> " +
                                                                                                                                                                                                              "      </div> " +
                                                                                                                                                                                                                  "      <!--mseb--> " +
                                                                                                                                                                                                                      "  </div> " +
                                                                                                                                                                                                                          " <div class='lineclook'></div></div> " +
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
          //$(masonry).append(fragment).masonry('appended', fragment, true);
          //$(masonry).append(fragment).masonry('reload');
          //  $(".grid").append(data.d).masonry('reload');
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
<form runat="server" id="frmBrands">
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
              <li class="active"><a href="discover.aspx">Discover</a></li>
              <li><a href="brands.aspx">Brands</a></li>
               <li><a href="events.aspx">Events</a></li>
            </ul>            
             <!--#INCLUDE FILE="../includes/influencer_settings.txt" -->   
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>

    </div><!--header bg-->
<!--Headerend-->


<!--text-->

<div class="wrapperwhite">
          
      <div class="colrow"> 
      
       <div class="dropfirst">  
         <span class="folheading"><a href="discover.aspx"><i class="fa fa-square" style="position:relative; top:-6px; font-size:6px;" ></i> Items</a></span> 
         <span class="folheading" style="margin-left:20px;"><a href="discover-lookbook.aspx" style="color:#4e93ce;"><i class="fa fa-square" style="position:relative; top:-6px; font-size:6px;" ></i> Lookbook</a></span> 
         <img src="../images/li.png" />     
       </div>                 
            
<div id="demodmenu">
  
<div id="close">
</div>
<div class="l">
    <asp:Label class="menudlist"  runat="server"  ID="lbCategory" Text="Categories">Categories <i class="fa fa-caret-down" aria-hidden="true" style="font-size:14px; margin-left:6px; margin-top:-5px;"></i></asp:Label>
    <div class="menudlist_list" id="list1">
            <div class="mespace"></div>
             <asp:Repeater ID="rptCategories" runat="server" DataSourceID="sdsCategories" 
                onitemcommand="rptCategories_ItemCommand" >
                                <ItemTemplate>
                                    
                                    <li class="menudli">
                                        <asp:LinkButton runat="server" ID="lbtnSeason" CommandName="1" CommandArgument='<%# Eval("CategoryID") %>'>
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
<div class="l" id="seasonDiv">
    <asp:Label class="menudlist"  runat="server"  ID="btnSeason" Text="Seasons" tabindex="13">Seasons <i class="fa fa-caret-down" aria-hidden="true" style="font-size:14px; margin-left:6px; margin-top:-5px;"></i></asp:Label>
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
    <asp:Label class="menudlist"  runat="server"  ID="btnHoiday" Text="Holidays" tabindex="13">Holidays <i class="fa fa-caret-down" aria-hidden="true" style="font-size:14px; margin-left:6px; margin-top:-5px;"></i></asp:Label>
    <div class="menudlist_list" id="list2">
            <div class="mespace"></div>
            <asp:Repeater ID="rptHoliday" runat="server" DataSourceID="sdsHoliday" 
                onitemcommand="rptHoliday_OnItemCommand" >
                                <ItemTemplate>
                                    
                                    <li class="menudli">
                                        <asp:LinkButton runat="server" ID="lbtnSeason" CommandName="1" CommandArgument='<%# Eval("HolidayID") %>'>
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
                       <div class="grid" id="mygrid" style="">

                       </div>
               <div id="LoaderItem"  style="display:none;">
                           <center>
         <%--                  <i class="fa fa-spinner" aria-hidden="true"></i>--%>
                           <img src="../images/ring.gif" />
                           <%-- <img src="../images/Rainbow.gif"  /> --%>
                           </center>

                       </div>
                        <div id="norecord" style="display:none;">
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
                                 <asp:TextBox  runat="server" ID="txtsearch2" placeholder="search by lookbook name" value="" CssClass="sein"  />
                             </div> <!--serinput-->
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
                                         DataSourceID="sdsbrandsSearch" DataTextField="Name" DataValueField="UserID" >
                                     </asp:checkboxlist>
                              <asp:SqlDataSource runat="server" ID="sdsbrandsSearch" 
                             ConnectionString='<%$ ConnectionStrings:GvConnection %>' 
                             ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                             SelectCommand="SELECT Top 6 [BrandID], [BrandKey], [Name],Tbl_Brands.UserID FROM [Tbl_Brands],[Tbl_Users] Where (Tbl_Users.UserID = Tbl_Brands.UserID AND Tbl_Users.IsApproved=1) ORDER BY [TotalViews] DESC"></asp:SqlDataSource>
                             
                             <asp:SqlDataSource runat="server" ID="sdsMoreBrands" 
                             ConnectionString='<%$ ConnectionStrings:GvConnection %>' 
                             ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                             SelectCommand="SELECT [BrandID], [BrandKey], [Name],Tbl_Brands.UserID FROM [Tbl_Brands],[Tbl_Users]Where (Tbl_Users.UserID = Tbl_Brands.UserID AND Tbl_Users.IsApproved=1) ORDER BY [TotalViews] DESC"></asp:SqlDataSource>
                            
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
                                     <div class="tagblock"><asp:LinkButton runat="server" ID="lbtnRemoveTag" CommandName="1" CommandArgument='<%# Eval("TagID","{0}")%>'><%# Eval("Title") %></asp:LinkButton> </div>
                                 </ItemTemplate>
                             </asp:Repeater>
                                  <asp:SqlDataSource ID="sdsTags" runat="server" 
                                      ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                      ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                      
                                      SelectCommand="SELECT Top 25 [TagID], [Title] FROM [Tbl_LBTags]   ORDER BY [TagID]">
                                      
                                  </asp:SqlDataSource>
                                  
                                  <asp:SqlDataSource ID="sdsMoreTags" runat="server" 
                                      ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                      ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                      
                                      SelectCommand="SELECT Top 50 [TagID], [Title] FROM [Tbl_LBTags]   ORDER BY [TagID]">
                                     
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

                  <%--<div class="col-md-12 discrigblock">
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
                  </div>--%><!--colmd12-->
                  <div class="dissp"></div>                                 

              
              
     </div><!--discoverwraps-->
     
     
</div><!--col-md-12-->



<!--footer-->
  <div class="footerbg">
     <div class="row">
        <div class="col-md-11 col-xs-10">©2016 Press Preview</div>
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

    <!-- Placed at the end of the document so the pages load faster -->
    <script src="../js/bootstrap.js"></script>
    <script src="../masonry/js/libs/imagesloaded.3.1.8.min.js"></script>
    <script src="../masonry/js/libs/jquery.masonry.3.2.1.min.js"></script>
    <script src="../masonry/js/base2.js" type="text/javascript"></script>


	
	<!-- custom scrollbar plugin -->
	<script src="../customscroller/jquery.mCustomScrollbar.concat.min.js"></script>
    
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


            $("#lbViewAlerts").click(function () {

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
        <script src="../source/jquery.fancybox.pack.js" type="text/javascript"></script>
      <script type="text/javascript">
          $(document).ready(function () {
              $(".fancybox").fancybox({
                  fitToView: true,
                  frameWidth: '100%',
                  frameHeight: '100%',
                  width: '100%',
                  height: '100%',
                  autoSize: false,

                  closeClick: true,
                  openEffect: 'fade',
                  closeEffect: 'fade',
                  type: "iframe",
                  opacity: 0.7,
                  onStart: function () {
                      $("#fancybox-overlay").css({ "position": "fixed" });
                  }
              });
          });
</script>
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
        // e.stopPropagation();
        // alert(jQuery(this).text());
    });
    jQuery(document).click(function (e) {
        jQuery(".menudlist_list").hide();
    });
</script>
<script type="application/javascript" src="../js/custom.js"></script>

