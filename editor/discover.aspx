﻿<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="true" CodeFile="discover.aspx.cs" Inherits="home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Discover</title>
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
                   url: "discover.aspx\\LoadData",
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
                       "  <a href='itemview2.aspx?v=" + val.ItemId + "' class='fancybox'> " +
                           "      <div class='dbl'> " +
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
                                                                                                                           "                  <div class='muserd'><a href='itemview2.aspx?v=" + val.ItemID + "'class='fancybox'>" + val.Title + "</a></div> " +
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
               $(masonry).show();
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



         // Page variables for search by Category
         var pageIndex_cat = 0;
         var pageCount_cat = 0;
         // Page variables for search by Season
         var pageIndex_season = 0;
         var pageCount_season;
         // Page variables for search by Holiday
         var pageIndex_holiday = 0;
         var pageCount_holiday;
         // Page variables for search by Title
         var pageIndex_title = 0;
         var pageCount_title;
         var temp = 'Test';
         var selectedcat = 0;
         function GetCategory(categoryid) {
             selectedcat = categoryid;
             $('.loadMore').prop('id', 'byCategory');
             $('.loadMore').show();
             GetRecordsByCategoryDef(categoryid);
         }

         var selectedseason = 0;
         function GetSeason(seasonid) {
             selectedseason = seasonid;
             $('.loadMore').prop('id', 'bySeason');
             $('.loadMore').show();
             GetRecordsBySeasonDef(seasonid);
         }

         var selectedholiday = 0;
         function GetHoliday(hoidayid) {
             selectedholiday = hoidayid;
             $('.loadMore').prop('id', 'byHoliday');
             $('.loadMore').show();
             GetRecordsByHolidayDef(hoidayid);
         }

         function GetTitle(title) {
             alert($('#' + title).val());
             GetRecordsByTitle(title);
         }
         // Defualt


         // By category (Default)
         function GetRecordsByCategoryDef(categoryid) {
             pageIndex_cat = 1;
             pageCount_cat = 0;
             $('#loader').show();

             //send a query to server side to present new content
             $.ajax({
                 type: "POST",
                 url: "profile-page-items.aspx\\GetDataByCategory",
                 data: '{pageIndex: ' + pageIndex_cat + ', categoryid:' + categoryid + '}',
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: OnSuccessCate
             });

             if (pageCount_cat <= 1) {
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
                 // var mess = '<label class="loadMore"> No more record </label>';
                 //  $('#divPostsLoader').append(mess);
                 //setTimeout(function () { $('.loadMore').fadeOut(); }, 4000);
             } else {

             }

         }

         // By Category (load More)
         function GetRecordsByCategory(categoryid) {
             pageIndex_cat++;
             if (pageIndex_cat == 1 || pageIndex_cat <= pageCount_cat) {
                 // $('#divPostsLoader').prepend('<img src="../images/ajax-loader.gif">');
                 $('#loader').show();

                 //send a query to server side to present new content
                 $.ajax({
                     type: "POST",
                     url: "profile-page-items.aspx\\GetDataByCategory",
                     data: '{pageIndex: ' + pageIndex_cat + ', categoryid:' + categoryid + '}',
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: OnSuccessCate
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
                 // var mess = '<label class="loadMore"> No more record </label>';
                 // $('#divPostsLoader').append(mess);
                 //setTimeout(function () { $('.loadMore').fadeOut(); }, 4000);
             }
         }

         // By Season (Defualt)
         function GetRecordsBySeasonDef(seasonid) {
             pageIndex_season = 1;
             $('#loader').show();
             pageCount_season = 0;
             //send a query to server side to present new content
             $.ajax({
                 type: "POST",
                 url: "profile-page-items.aspx\\GetDataBySeason",
                 data: '{pageIndex: ' + pageIndex_season + ',seasonid:' + seasonid + '}',
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: OnSuccessSession
             });
             if (pageCount_season < 1) {
                 $('.loadMore').hide();
                 var masonry = $('.grid');
                 masonry.masonry({
                     itemSelector: '.boxn1'
                 });

                 setTimeout(function () {
                     $(masonry).show();
                     $(masonry).masonry('reloadItems');
                     $(masonry).masonry('layout');
                     $(".boxn1").css("visibility", "visible");
                 }, 2000);
                 //var mess = '<label class="loadMore"> No more record </label>';
                 //$('#divPostsLoader').append(mess);
                 //setTimeout(function () { $('.loadMore').fadeOut(); }, 4000);
             }
         }

         // By Season pagination

         // By Season
         function GetRecordsBySeason(seasonid) {
             pageIndex_season++;
             if (pageIndex_season == 1 || pageIndex_season <= pageCount_season) {
                 // $('#divPostsLoader').prepend('<img src="../images/ajax-loader.gif">');
                 $('#loader').show();

                 //send a query to server side to present new content
                 $.ajax({
                     type: "POST",
                     url: "profile-page-items.aspx\\GetDataBySeason",
                     data: '{pageIndex: ' + pageIndex_season + ',seasonid:' + seasonid + '}',
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: OnSuccessSession
                 });
             } else {
                 $('.loadMore').hide();
                 var masonry = $('.grid');
                 masonry.masonry({
                     itemSelector: '.boxn1'
                 });

                 setTimeout(function () {
                     $(masonry).show();
                     $(masonry).masonry('reloadItems');
                     $(masonry).masonry('layout');
                     $(".boxn1").css("visibility", "visible");
                 }, 2000);
                 //var mess = '<label class="loadMore"> No more record </label>';
                 // $('#divPostsLoader').append(mess);
                 // setTimeout(function () { $('.loadMore').fadeOut(); }, 4000);
             }
         }



         // By Holiday
         function GetRecordsByHolidayDef(holidayid) {
             pageIndex_holiday = 1;
             pageCount_holiday = 0;
             // $('#divPostsLoader').prepend('<img src="../images/ajax-loader.gif">');
             $('#loader').show();

             //send a query to server side to present new content
             $.ajax({
                 type: "POST",
                 url: "profile-page-items.aspx\\GetDataByHoliday",
                 data: '{pageIndex: ' + pageIndex_holiday + ', holidayid:' + holidayid + '}',
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: OnSuccessHoliday
             });
             if (pageCount_holiday < 1) {
                 $('.loadMore').hide();
                 var masonry = $('.grid');
                 masonry.masonry({
                     itemSelector: '.boxn1'
                 });
                 setTimeout(function () {
                     $(masonry).show();
                     $(masonry).masonry('reloadItems');
                     $(masonry).masonry('layout');
                     $(".boxn1").css("visibility", "visible");
                 }, 2000);
                 //var mess = '<label class="loadMore"> No more record </label>';
                 //$('#divPostsLoader').append(mess);
                 //setTimeout(function () { $('.loadMore').fadeOut(); }, 4000);
             }
         }


         // By Holiday
         function GetRecordsByHoliday(holidayid) {
             pageIndex_holiday++;
             if (pageIndex_holiday == 1 || pageIndex_holiday <= pageCount_holiday) {
                 // $('#divPostsLoader').prepend('<img src="../images/ajax-loader.gif">');
                 $('#loader').show();

                 //send a query to server side to present new content
                 $.ajax({
                     type: "POST",
                     url: "profile-page-items.aspx\\GetDataByHoliday",
                     data: '{pageIndex: ' + pageIndex_holiday + ', holidayid:' + holidayid + '}',
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: OnSuccessHoliday
                 });
             } else {
                 $('.loadMore').hide();
                 var masonry = $('.grid');
                 masonry.masonry({
                     itemSelector: '.boxn1'
                 });
                 setTimeout(function () {
                     $(masonry).show();
                     $(masonry).masonry('reloadItems');
                     $(masonry).masonry('layout');
                     $(".boxn1").css("visibility", "visible");
                 }, 2000);
                 // var mess = '<label class="loadMore"> No more record </label>';
                 /// $('#divPostsLoader').append(mess);
                 //setTimeout(function () { $('.loadMore').fadeOut(); }, 4000);
             }
         }

         // By Title
         function GetRecordsByTitle(title) {
             $('.grid').empty();
             pageIndex_title = 1;
             //pageIndex_title++;
             if (pageIndex_title == 1 || pageIndex_title <= pageCount_title) {
                 // $('#divPostsLoader').prepend('<img src="../images/ajax-loader.gif">');
                 $('#loader').show();

                 //send a query to server side to present new content
                 $.ajax({
                     type: "POST",
                     url: "profile-page-items.aspx\\GetDataByTitle",
                     data: '{pageIndex: ' + pageIndex_title + ', title:"' + title + '"}',
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: OnSuccess

                 });
             } else {
                 alert("error");
                 $('#loadMore').remove();
                 var masonry = $('.grid');
                 masonry.masonry({
                     itemSelector: '.boxn1'
                 });
                 setTimeout(function () {
                     $(masonry).show();
                     $(masonry).masonry('reloadItems');
                     $(masonry).masonry('layout');
                     $(".boxn1").css("visibility", "visible");
                 }, 2000);
                 // var mess = '<label id="loadMore"> No more record </label>';
                 // $('#divPostsLoader').append(mess);
                 //setTimeout(function () { $('#loadMore').fadeOut(); }, 4000);
             }
         }



         function OnSuccessCate(data) {
             var items = data.d;
             $('.grid').empty();
             var fragment;
             $.each(items, function (index, val) {
                 pageCount_cat = val.PageCount;
                 if (pageCount_cat <= 1) {
                     $('.loadMore').hide();
                     // var mess = '<label class="loadMore"> No more record </label>';
                     //  $('#divPostsLoader').append(mess);
                     //setTimeout(function () { $('.loadMore').fadeOut(); }, 4000);
                 }
                 fragment += "<div class='box'  id='b" + val.ItemId + "'> " +
                     " <div class='disblock'> " +
                         "  <a href='itemview2.aspx?v=" + val.ItemId + "' class='fancybox'> " +
                             "      <div class='dbl'> " +
                                 "          <div class='hover ehover13'> " +
                                     "              <img class='img-responsive' src='../photobank/" + val.FeatureImg + "' alt='" + val.Title + "' /><div class='overlay'> " +
                                         "                  <h2 class='titlet'>" + val.Title + "</h2> " +
                                             "                  <h2 class='linenew'></h2> " +
                                                 "                  <h2> " +
                                                     "                      <span ID='lblDate' Text='" + val.DatePosted + "'></span></h2> " +
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
                                                                                                                             "                  <div class='muserd'><a href='itemview2.aspx?v=" + val.ItemID + "'class='fancybox'>" + val.Title + "</a></div> " +
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
             //  $(masonry).append(fragment).masonry('appended', fragment, true);
             // $(masonry).append(fragment).masonry('reload');
             //  $(".grid").append(data.d).masonry('reload');
             $('#loader').hide();

         }

         function OnSuccessSession(data) {
             var items = data.d;
             $('.grid').empty();
             var fragment;
             $.each(items, function (index, val) {
                 pageCount_season = val.PageCount;
                 if (pageCount_cat <= 1) {
                     $('.loadMore').hide();
                     // var mess = '<label class="loadMore"> No more record </label>';
                     //  $('#divPostsLoader').append(mess);
                     //setTimeout(function () { $('.loadMore').fadeOut(); }, 4000);
                 }
                 fragment += "<div class='box'  id='b" + val.ItemId + "'> " +
                     " <div class='disblock'> " +
                         "  <a href='itemview2.aspx?v=" + val.ItemId + "' class='fancybox'> " +
                             "      <div class='dbl'> " +
                                 "          <div class='hover ehover13'> " +
                                     "              <img class='img-responsive' src='../photobank/" + val.FeatureImg + "' alt='" + val.Title + "' /><div class='overlay'> " +
                                         "                  <h2 class='titlet'>" + val.Title + "</h2> " +
                                             "                  <h2 class='linenew'></h2> " +
                                                 "                  <h2> " +
                                                     "                      <span ID='lblDate' Text='" + val.DatePosted + "'></span></h2> " +
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
                                                                                                                             "                  <div class='muserd'><a href='itemview2.aspx?v=" + val.ItemID + "'class='fancybox'>" + val.Title + "</a></div> " +
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

         }

         function OnSuccessHoliday(data) {
             var items = data.d;
             $('.grid').empty();
             var fragment;
             $.each(items, function (index, val) {
                 pageCount_holiday = val.PageCount;
                 if (pageCount_cat <= 1) {
                     $('.loadMore').hide();
                     // var mess = '<label class="loadMore"> No more record </label>';
                     //  $('#divPostsLoader').append(mess);
                     //setTimeout(function () { $('.loadMore').fadeOut(); }, 4000);
                 }
                 fragment += "<div class='box'  id='b" + val.ItemId + "'> " +
                     " <div class='disblock'> " +
                         "  <a href='itemview2.aspx?v=" + val.ItemId + "' class='fancybox'> " +
                             "      <div class='dbl'> " +
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
                                                                                                                             "                  <div class='muserd'><a href='itemview2.aspx?v=" + val.ItemID + "'class='fancybox'>" + val.Title + "</a></div> " +
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
                                                                                                                                                                                         "                      <asp:Label runat='server' ID='lblDate2'>" + val.dated + "</asp:Label> " +
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

         }

         function GetFirstRecordSet() {

             $('#loader').show();

             //send a query to server side to present new content
             $.ajax({
                 type: "POST",
                 url: "profile-page-items.aspx\\GetData",
                 data: '{pageIndex:1}',
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: OnSuccess
             });
             //              if(pageCount=1) {
             //                  $('#loadMore').remove();
             //                  var mess = '<label id="loadMore"> No more record </label>';
             //                  $('#divPostsLoader').append(mess);
             //                  setTimeout(function () { $('#loadMore').fadeOut(); }, 4000);
             //              }
         }
         $(document).ready(function () {
             //$('.grid').masonry('destroy');
             //var masonry = $('.grid');
             //masonry.masonry({
             //    itemSelector: '.boxn1'
             //});
             //$(masonry).masonry('reloadItems');
             //$(masonry).masonry('layout');
             //When scroll down, the scroller is at the bottom with the function below and fire the lastPostFunc function
             $(window).scroll(function () {
                 if ($(window).scrollTop() == $(document).height() - $(window).height()) {
                     //   $("#loadMore").fadeIn();
                     //  GetRecords();
                 }
             });

             $("#txtsearch").keydown(function (e) {
                 if (e.keyCode == 13) { // enter
                     GetRecordsByTitle($("#txtsearch").val());
                     return false; //you can also say e.preventDefault();
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
                                 <asp:TextBox  runat="server" ID="txtsearch" placeholder=" search by brand name" value="" CssClass="sein"   />
                               
                                    
                             </div> <!--serinput-->
                         </div><!--search-->
                  </div><!--colmd12-->
                  <div class="dissp"></div>
                  
           <!--colors-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading" style="margin-bottom:10px;">Color <span class="text-danger">*</span></div> 
                              <div id="trigger" style="width:100%;">
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
                                     <div class="tagblock"><asp:LinkButton runat="server" ID="lbtnRemoveTag" CommandName="1" CommandArgument='<%# Eval("TagID","{0}")%>'><%# Eval("Title") %></asp:LinkButton> </div>
                                 </ItemTemplate>
                             </asp:Repeater>
                                  <asp:SqlDataSource ID="sdsTags" runat="server" 
                                      ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                      ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                      
                                      SelectCommand="SELECT Top 25 [TagID], [Title] FROM [Tbl_ItemTags]   ORDER BY [TagID]">
                                      
                                  </asp:SqlDataSource>
                                  
                                  <asp:SqlDataSource ID="sdsMoreTags" runat="server" 
                                      ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                      ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                      
                                      SelectCommand="SELECT Top 50 [TagID], [Title] FROM [Tbl_ItemTags]   ORDER BY [TagID]">
                                     
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
