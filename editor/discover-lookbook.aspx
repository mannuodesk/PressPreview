<%@ Page Language="C#" AutoEventWireup="true" CodeFile="discover-lookbook.aspx.cs" Inherits="editor_discover_lookbook" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Press Preview - Discover Page - Lookbook</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        .grid{
            font-size:0px;
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
      $(document).ready(function () {

          GetRecords();
      });



      var $container = $('.grid');
      $container.on('imagesLoaded', (function () {
          $container.masonry({
              itemSelector: '.box',
              isFitWidth: true,
              isAnimated: true
          });
      }));
      //    $('.grid').masonry({
      //    // options
      //        itemSelector: '.boxn1'
      //    });

      var masonryUpdate = function () {
          setTimeout(function () {
              $('.grid').masonry();
          }, 5000);
      };


      var pageIndex = -1;
      var pageCount;
      function GetRecords() {
          pageIndex++;
          if (pageIndex == 0 || pageIndex <= pageCount) {
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
          } else {
              $('.loadMore').hide();
              var masonry = $('.grid');
              masonry.masonry({
                  itemSelector: '.box'
              });

              setTimeout(function () {
                  $(masonry).show();
                  $(masonry).masonry('reloadItems');
                  $(masonry).masonry('layout');
                  $(".box").css("visibility", "visible");
              }, 2000);
              //   $('.loadMore').val('No more records');
              //setTimeout(function () { $('.loadMore').fadeOut(); }, 4000);
          }
      }


      function navigate(val) {
          alert(val);
      }



      function OnSuccess(data) {
          console.log(data);
          var items = data.d;
          var fragment;

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
                                                                                                                          "                  <div class='muserd'><a href='/editor/discover-lookbook-details.aspx?v=" + val.LookBookKey + "'class='fancybox'>" + val.Title + "</a></div> " +
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
                                                                                                                                                                                      "                      <span ID='lblDate2'>" + val.dated + "</span> " +
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


          var masonry = $('.grid');
          masonry.masonry({
              itemSelector: '.box'
          });

          $(masonry).append(fragment);
          $(masonry).hide();
          setTimeout(function () {
              $(masonry).show();
              $(masonry).masonry('reloadItems');
              $(masonry).masonry('layout');
              $(".box").css("visibility", "visible");
          }, 2000);
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
                      $('.grid').masonry('destroy');
                      GetRecords();
                      break;
                  case 'byCategory':
                      $('.loadMore').show();
                      $('.grid').masonry('destroy');
                      GetRecordsByCategory(selectedcat);
                      break;
                  case 'bySeason':
                      $('.loadMore').show();
                      $('.grid').masonry('destroy');
                      GetRecordsBySeason(selectedseason);
                      break;
                  case 'byHoliday':
                      $('.loadMore').show();
                      $('.grid').masonry('destroy');
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
<div class="l">
    <button class="menudlist" id="a">Seasons <i class="fa fa-caret-down" aria-hidden="true" style="font-size:14px;margin-left:6px; margin-top:-5px;"></i></button>
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
    <button class="menudlist" id="a">Holidays <i class="fa fa-caret-down" aria-hidden="true" style="font-size:14px;margin-left:6px; margin-top:-5px;"></i></button>
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
                       <div class="grid" id="mygrid" style="height:auto !important;">

                       </div>
                        <div id="divPostsLoader" style="margin-bottom:40px;">
                     <div id="loader" style="width:100%; margin:0 auto; display:none;">
                     <img src="../images/ajax-loader.gif" style="padding-bottom: 20px; position: relative; top: 40px; left: 60px;" ></div>
                     <a href="#" id="default"  class="loadMore">Load More</a>
                 </div>
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
                                 <asp:TextBox  runat="server" ID="txtsearch" placeholder="search by brand name" value="" CssClass="sein"  />
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

