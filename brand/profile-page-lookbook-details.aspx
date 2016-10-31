<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="true" CodeFile="profile-page-lookbook-details.aspx.cs" Inherits="lookbookDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>PR:: Lookbook-Detail (Brand View)</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<script src="../js/bootstrap.js"></script>
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <link href="../css/jquery-ui.css" rel="stylesheet" type="text/css" />
   <script src="../js/jquery-ui.min.js"></script>
   <link href="../source/jquery.fancybox.css" rel="stylesheet" type="text/css" />

   <style>
       .img-responsive2{
           min-height:initial;min-width:initial;
       }
       .boxn2{
           display:none;
       }
       .grid{
           font-size:0px;
       }
   </style>
     <script type="text/javascript">
         $(document).ready(function () {
             SearchText();
            
             GetRecords();
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
         function SearchText() {
             $("#txtsearch").autocomplete({
                 source: function (request, response) {
                     $.ajax({
                         type: "POST",
                         contentType: "application/json; charset=utf-8",
                         url: "profile-page-lookbook-details.aspx\\GetItemTitle",
                         data: "{'lbName':'" + document.getElementById('txtsearch').value + "'}",
                         dataType: "json",
                         success: function (data) {
                             response(data.d);
                         },
                         error: function (result) {
                             //alert("No Match"); 
                             response("No Match Found");
                         }
                     });
                 }
             });
         }

         function DeleteItem(id) {
             //Code to delete the item from the database here
             if (confirm('Are you sure, you want to delete ?')) {
                 $.ajax({
                     type: "POST",
                     url: "profile-page-lookbook-details.aspx\\DeleteItem",
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

         var pageIndex = 0;
         var pageCount;
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
         function GetRecords() {
             pageIndex++;
             if (pageIndex == 1 || pageIndex <= pageCount) {
                 // $('#divPostsLoader').prepend('<img src="../images/ajax-loader.gif">');
                 $('#loader').show();
                 var v='<%= Request.QueryString["v"] %>';
                 //send a query to server side to present new content
                 $.ajax({
                     type: "POST",
                     url: "profile-page-lookbook-details.aspx\\GetData",
                     data: '{pageIndex: ' + pageIndex + ',lookId: "' + v + '"}',
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: OnSuccess
                 });
             } else {
                 $('.loadMore').hide();
                 var masonry = $('.grid');
                 masonry.masonry({
                     itemSelector: '.boxn1'
                 });
                 setTimeout(function () {

                     $(masonry).masonry('reloadItems');
                     $(masonry).masonry('layout');
                     $(".boxn1").css("visibility", "visible");
                 }, 2000);
              //   $('.loadMore').val('No more records');
                 //setTimeout(function () { $('.loadMore').fadeOut(); }, 4000);
             }
         }

         // By category (Default)
         function GetRecordsByCategoryDef(categoryid) {
             pageIndex_cat = 1;
             pageCount_cat = 0;
             $('#loader').show();
                       var v='<%= Request.QueryString["v"] %>';
             //send a query to server side to present new content
             $.ajax({
                 type: "POST",
                 url: "profile-page-lookbook-details.aspx\\GetDataByCategory",
                 data: '{pageIndex: ' + pageIndex_cat + ', categoryid:' + categoryid + ', lookId: "'+v+'"}',
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: OnSuccessCate
             });

             if (pageCount_cat <= 1) {
                 $('.loadMore').hide();
                 var masonry = $('.grid');
                 masonry.masonry({
                     itemSelector: '.boxn1'
                 });
                 setTimeout(function () {

                     $(masonry).masonry('reloadItems');
                     $(masonry).masonry('layout');
                     $(".boxn1").css("visibility", "visible");
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
                           var v='<%= Request.QueryString["v"] %>';
                 //send a query to server side to present new content
                 $.ajax({
                     type: "POST",
                     url: "profile-page-lookbook-details.aspx\\GetDataByCategory",
                     data: '{pageIndex: ' + pageIndex_cat + ', categoryid:' + categoryid + ' , lookId: "'+v+'"}',
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: OnSuccessCate
                 });

             } else {
                 $('.loadMore').hide();
                 var masonry = $('.grid');
                 masonry.masonry({
                     itemSelector: '.boxn1'
                 });

                 setTimeout(function () {

                     $(masonry).masonry('reloadItems');
                     $(masonry).masonry('layout');
                     $(".boxn1").css("visibility", "visible");
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
                       var v='<%= Request.QueryString["v"] %>';
             //send a query to server side to present new content
             $.ajax({
                 type: "POST",
                 url: "profile-page-lookbook-details.aspx\\GetDataBySeason",
                 data: '{pageIndex: ' + pageIndex_season + ',seasonid:' + seasonid + ', lookId: "'+v+'"}',
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
                           var v='<%= Request.QueryString["v"] %>';
                 //send a query to server side to present new content
                 $.ajax({
                     type: "POST",
                     url: "profile-page-lookbook-details.aspx\\GetDataBySeason",
                     data: '{pageIndex: ' + pageIndex_season + ',seasonid:' + seasonid + ', lookId :"'+v+'"}',
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
                       var v='<%= Request.QueryString["v"] %>';
             //send a query to server side to present new content
             $.ajax({
                 type: "POST",
                 url: "profile-page-lookbook-details.aspx\\GetDataByHoliday",
                 data: '{pageIndex: ' + pageIndex_holiday + ', holidayid:' + holidayid + ', lookId: "'+v+'"}',
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
                           var v='<%= Request.QueryString["v"] %>';
                 //send a query to server side to present new content
                 $.ajax({
                     type: "POST",
                     url: "profile-page-lookbook-details.aspx\\GetDataByHoliday",
                     data: '{pageIndex: ' + pageIndex_holiday + ', holidayid:' + holidayid + ',lookid: "'+v+'"}',
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
                           var v='<%= Request.QueryString["v"] %>';
                 //send a query to server side to present new content
                 $.ajax({
                     type: "POST",
                     url: "profile-page-lookbook-details.aspx\\GetDataByTitle",
                     data: '{pageIndex: ' + pageIndex_title + ', title:"' + title + '", lookId:"'+v+'"}',
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

                     $(masonry).masonry('reloadItems');
                     $(masonry).masonry('layout');
                     $(".boxn1").css("visibility", "visible");
                 }, 2000);
                // var mess = '<label id="loadMore"> No more record </label>';
                // $('#divPostsLoader').append(mess);
                 //setTimeout(function () { $('#loadMore').fadeOut(); }, 4000);
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
                 fragment += "<div class='boxn1 boxn2' style='float:left;visibility:hidden'  id='b" + val.ItemId + "'>" +
                     "<div class='disblock'>" +
                         "<a href='itemview1?v=" + val.ItemId + "' class='fancybox'>" +
                             "<div class='dbl'> <div class='hover ehover13'>" +
                                 "<img class='img-responsive img-responsive2' src='../photobank/" + val.FeatureImg + "' alt='' /> " +
                                     "<div class='overlay'>" +
                                         "<h2 class='titlet'>" + val.Title + "</h2> <h2 class='linenew'></h2> <h2>" + val.DatePosted + "</h2></div> <!-- overlay -->" +
                                             "</div><!-- hover ehover13--></div> <!-- dbl -->" +
                                                 "</a>" +
                                                     "<div class='disname'>" +
                                                         "<div class='mesbd'>" +
                                                             "<div class='mimageb'>" +
                                                                 "<div class='mimgd'>" +
                                                                     "<a href=''><img src='../brandslogoThumb/" + val.ProfilePic + "' class='img-circle img-responsive' style='width:px; height:36px' /></a></div> <!-- mimgd -->" +
                                                                         "</div> <!-- mimageb -->" +
                                                                             "<div class='mtextb' style='width:75%; margin-left:15px;'>" +
                                                                                 "<div class='m1'>" +
                                                                                     "<div class='muserd'>" +
                                                                                         "<a href='itemview1?v=" + val.ItemId + "' class='fancybox'>" + val.Title + "</a>" +
                                                                                             "<a ToolTip='Delete Item' OnClick='DeleteItem(" + val.ItemId + ")' OnClientClick='return confirm('Are you sure, you want to delete ?')'  style='margin:auto; float:right; background:#CCC; padding:6px 8px; border-radius:50%;'>" +
                                                                                                 "<i class='fa fa-times' aria-hidden='true' style='font-size:16px;'></i>" +
                                                                                                     "</a>" +
                                                                                                         "<a href='edit-item.aspx?v=" + val.ItemId + "'  style='margin:auto; float:right; background:#CCC; padding:6px 8px; border-radius:50%; margin-right: 3px;'>" +
                                                                                                             "<i class='fa fa-pencil' aria-hidden='true' style='font-size:16px;'></i>" +
                                                                                                                 "</a>" +
                                                                                                                     "</div> <!-- muserd -->" +
                                                                                                                         "<div class='muserdb'>By " + val.Name + "</div>" +
                                                                                                                             "</div> <!-- m1 -->" +
                                                                                                                                 "<div class='m1' style='word-wrap:break-word;'>" +
                                                                                                                                     "<div class='mtextd'> " + val.Description + " </div>" +
                                                                                                                                         "</div> <!-- m1 -->" +
                                                                                                                                             "<div class='m1'>" +
                                                                                                                                                 "<div class='vlike'><img src='../images/views.png' />" + val.Views + "</div> <!-- vlike -->" +
                                                                                                                                                     "<!-- <div class='vlike'><img src='../images/liked.png' />" + val.Likes + "</div> --> <!-- vlike -->" +
                                                                                                                                                         "<div class='mdaysd'><span id='lblDate2' >" + val.Dated + "</span></div> <!-- mdaysd -->" +
                                                                                                                                                             "</div> <!-- m1-->" +
                                                                                                                                                                 "</div> <!-- mtextb -->" +
                                                                                                                                                                     "</div><!-- mesbd -->" +
                                                                                                                                                                         "</div> <!-- disname -->" +
                                                                                                                                                                             "</div></div>";

             });

             
             var masonry = $('.grid');
             masonry.masonry({
                 itemSelector: '.boxn1'
             });
            
             $(masonry).append(fragment);
         

             setTimeout(function () {
                 
                 $(masonry).masonry('reloadItems');
                 $(masonry).masonry('layout');
                 $(".boxn1").css("visibility", "visible");
             }, 2000);
             //$(masonry).append(fragment).masonry('appended', fragment, true);
             //$(masonry).append(fragment).masonry('reload');
             //  $(".grid").append(data.d).masonry('reload');
             $('#loader').hide();
             if (pageCount <= 1) {
                 $('.loadMore').hide();
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
                 fragment += "<div class='boxn1' style='float:left;'  id='b" + val.ItemId + "'>" +
                     "<div class='disblock'>" +
                         "<a href='itemview1?v=" + val.ItemId + "' class='fancybox'>" +
                             "<div class='dbl'> <div class='hover ehover13'>" +
                                 "<img class='img-responsive img-responsive2' src='../photobank/" + val.FeatureImg + "' alt='' /> " +
                                     "<div class='overlay'>" +
                                         "<h2 class='titlet'>" + val.Title + "</h2> <h2 class='linenew'></h2> <h2>" + val.DatePosted + "</h2></div> <!-- overlay -->" +
                                             "</div><!-- hover ehover13--></div> <!-- dbl -->" +
                                                 "</a>" +
                                                     "<div class='disname'>" +
                                                         "<div class='mesbd'>" +
                                                             "<div class='mimageb'>" +
                                                                 "<div class='mimgd'>" +
                                                                     "<a href=''><img src='../brandslogoThumb/" + val.ProfilePic + "' class='img-circle img-responsive' style='width:px; height:36px' /></a></div> <!-- mimgd -->" +
                                                                         "</div> <!-- mimageb -->" +
                                                                             "<div class='mtextb' style='width:75%; margin-left:15px;'>" +
                                                                                 "<div class='m1'>" +
                                                                                     "<div class='muserd'>" +
                                                                                         "<a href='itemview1?v=" + val.ItemId + "' class='fancybox'>" + val.Title + "</a>" +
                                                                                             "<a ToolTip='Delete Item' OnClick='DeleteItem(" + val.ItemId + ")' OnClientClick='return confirm('Are you sure, you want to delete ?')'  style='margin:auto; float:right; background:#CCC; padding:6px 8px; border-radius:50%;'>" +
                                                                                                 "<i class='fa fa-times' aria-hidden='true' style='font-size:16px;'></i>" +
                                                                                                     "</a>" +
                                                                                                         "<a href='edit-item.aspx?v=" + val.ItemId + "'  style='margin:auto; float:right; background:#CCC; padding:6px 8px; border-radius:50%; margin-right: 3px;'>" +
                                                                                                             "<i class='fa fa-pencil' aria-hidden='true' style='font-size:16px;'></i>" +
                                                                                                                 "</a>" +
                                                                                                                     "</div> <!-- muserd -->" +
                                                                                                                         "<div class='muserdb'>By " + val.Name + "</div>" +
                                                                                                                             "</div> <!-- m1 -->" +
                                                                                                                                 "<div class='m1' style='word-wrap:break-word;'>" +
                                                                                                                                     "<div class='mtextd'> " + val.Description + " </div>" +
                                                                                                                                         "</div> <!-- m1 -->" +
                                                                                                                                             "<div class='m1'>" +
                                                                                                                                                 "<div class='vlike'><img src='../images/views.png' />" + val.Views + "</div> <!-- vlike -->" +
                                                                                                                                                     "<!-- <div class='vlike'><img src='../images/liked.png' />" + val.Likes + "</div> --><!-- vlike -->" +
                                                                                                                                                         "<div class='mdaysd'><span id='lblDate2' >" + val.Dated + "</span></div> <!-- mdaysd -->" +
                                                                                                                                                             "</div> <!-- m1-->" +
                                                                                                                                                                 "</div> <!-- mtextb -->" +
                                                                                                                                                                     "</div><!-- mesbd -->" +
                                                                                                                                                                         "</div> <!-- disname -->" +
                                                                                                                                                                             "</div></div>";


             });
             var masonry = $('.grid');
             masonry.masonry({
                 itemSelector: '.boxn1'
             });

             $(masonry).append(fragment);


             setTimeout(function () {

                 $(masonry).masonry('reloadItems');
                 $(masonry).masonry('layout');
                 $(".boxn1").css("visibility", "visible");
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
                 fragment += "<div class='boxn1' style='float:left;'  id='b" + val.ItemId + "'>" +
                     "<div class='disblock'>" +
                         "<a href='itemview1?v=" + val.ItemId + "' class='fancybox'>" +
                             "<div class='dbl'> <div class='hover ehover13'>" +
                                 "<img class='img-responsive img-responsive2' src='../photobank/" + val.FeatureImg + "' alt='' /> " +
                                     "<div class='overlay'>" +
                                         "<h2 class='titlet'>" + val.Title + "</h2> <h2 class='linenew'></h2> <h2>" + val.DatePosted + "</h2></div> <!-- overlay -->" +
                                             "</div><!-- hover ehover13--></div> <!-- dbl -->" +
                                                 "</a>" +
                                                     "<div class='disname'>" +
                                                         "<div class='mesbd'>" +
                                                             "<div class='mimageb'>" +
                                                                 "<div class='mimgd'>" +
                                                                     "<a href=''><img src='../brandslogoThumb/" + val.ProfilePic + "' class='img-circle img-responsive' style='width:px; height:36px' /></a></div> <!-- mimgd -->" +
                                                                         "</div> <!-- mimageb -->" +
                                                                             "<div class='mtextb' style='width:75%; margin-left:15px;'>" +
                                                                                 "<div class='m1'>" +
                                                                                     "<div class='muserd'>" +
                                                                                         "<a href='itemview1?v=" + val.ItemId + "' class='fancybox'>" + val.Title + "</a>" +
                                                                                             "<a ToolTip='Delete Item' OnClick='DeleteItem(" + val.ItemId + ")' OnClientClick='return confirm('Are you sure, you want to delete ?')'  style='margin:auto; float:right; background:#CCC; padding:6px 8px; border-radius:50%;'>" +
                                                                                                 "<i class='fa fa-times' aria-hidden='true' style='font-size:16px;'></i>" +
                                                                                                     "</a>" +
                                                                                                         "<a href='edit-item.aspx?v=" + val.ItemId + "'  style='margin:auto; float:right; background:#CCC; padding:6px 8px; border-radius:50%; margin-right: 3px;'>" +
                                                                                                             "<i class='fa fa-pencil' aria-hidden='true' style='font-size:16px;'></i>" +
                                                                                                                 "</a>" +
                                                                                                                     "</div> <!-- muserd -->" +
                                                                                                                         "<div class='muserdb'>By " + val.Name + "</div>" +
                                                                                                                             "</div> <!-- m1 -->" +
                                                                                                                                 "<div class='m1' style='word-wrap:break-word;'>" +
                                                                                                                                     "<div class='mtextd'> " + val.Description + " </div>" +
                                                                                                                                         "</div> <!-- m1 -->" +
                                                                                                                                             "<div class='m1'>" +
                                                                                                                                                 "<div class='vlike'><img src='../images/views.png' />" + val.Views + "</div> <!-- vlike -->" +
                                                                                                                                                     "<!-- <div class='vlike'><img src='../images/liked.png' />" + val.Likes + "</div> --> <!-- vlike -->" +
                                                                                                                                                         "<div class='mdaysd'><span id='lblDate2' >" + val.Dated + "</span></div> <!-- mdaysd -->" +
                                                                                                                                                             "</div> <!-- m1-->" +
                                                                                                                                                                 "</div> <!-- mtextb -->" +
                                                                                                                                                                     "</div><!-- mesbd -->" +
                                                                                                                                                                         "</div> <!-- disname -->" +
                                                                                                                                                                             "</div></div>";


             });
             var masonry = $('.grid');
             masonry.masonry({
                 itemSelector: '.boxn1'
             });

             $(masonry).append(fragment);


             setTimeout(function () {

                 $(masonry).masonry('reloadItems');
                 $(masonry).masonry('layout');
                 $(".boxn1").css("visibility", "visible");
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
                 fragment += "<div class='boxn1' style='float:left;'  id='b" + val.ItemId + "'>" +
                     "<div class='disblock'>" +
                         "<a href='itemview1?v=" + val.ItemId + "' class='fancybox'>" +
                             "<div class='dbl'> <div class='hover ehover13'>" +
                                 "<img class='img-responsive img-responsive2' src='../photobank/" + val.FeatureImg + "' alt='' /> " +
                                     "<div class='overlay'>" +
                                         "<h2 class='titlet'>" + val.Title + "</h2> <h2 class='linenew'></h2> <h2>" + val.DatePosted + "</h2></div> <!-- overlay -->" +
                                             "</div><!-- hover ehover13--></div> <!-- dbl -->" +
                                                 "</a>" +
                                                     "<div class='disname'>" +
                                                         "<div class='mesbd'>" +
                                                             "<div class='mimageb'>" +
                                                                 "<div class='mimgd'>" +
                                                                     "<a href=''><img src='../brandslogoThumb/" + val.ProfilePic + "' class='img-circle img-responsive' style='width:px; height:36px' /></a></div> <!-- mimgd -->" +
                                                                         "</div> <!-- mimageb -->" +
                                                                             "<div class='mtextb' style='width:75%; margin-left:15px;'>" +
                                                                                 "<div class='m1'>" +
                                                                                     "<div class='muserd'>" +
                                                                                         "<a href='itemview1?v=" + val.ItemId + "' class='fancybox'>" + val.Title + "</a>" +
                                                                                             "<a ToolTip='Delete Item' OnClick='DeleteItem(" + val.ItemId + ")' OnClientClick='return confirm('Are you sure, you want to delete ?')'  style='margin:auto; float:right; background:#CCC; padding:6px 8px; border-radius:50%;'>" +
                                                                                                 "<i class='fa fa-times' aria-hidden='true' style='font-size:16px;'></i>" +
                                                                                                     "</a>" +
                                                                                                         "<a href='edit-item.aspx?v=" + val.ItemId + "'  style='margin:auto; float:right; background:#CCC; padding:6px 8px; border-radius:50%; margin-right: 3px;'>" +
                                                                                                             "<i class='fa fa-pencil' aria-hidden='true' style='font-size:16px;'></i>" +
                                                                                                                 "</a>" +
                                                                                                                     "</div> <!-- muserd -->" +
                                                                                                                         "<div class='muserdb'>By " + val.Name + "</div>" +
                                                                                                                             "</div> <!-- m1 -->" +
                                                                                                                                 "<div class='m1' style='word-wrap:break-word;'>" +
                                                                                                                                     "<div class='mtextd'> " + val.Description + " </div>" +
                                                                                                                                         "</div> <!-- m1 -->" +
                                                                                                                                             "<div class='m1'>" +
                                                                                                                                                 "<div class='vlike'><img src='../images/views.png' />" + val.Views + "</div> <!-- vlike -->" +
                                                                                                                                                     "<!-- <div class='vlike'><img src='../images/liked.png' />" + val.Likes + "</div> --> <!-- vlike -->" +
                                                                                                                                                         "<div class='mdaysd'><span id='lblDate2' >" + val.Dated + "</span></div> <!-- mdaysd -->" +
                                                                                                                                                             "</div> <!-- m1-->" +
                                                                                                                                                                 "</div> <!-- mtextb -->" +
                                                                                                                                                                     "</div><!-- mesbd -->" +
                                                                                                                                                                         "</div> <!-- disname -->" +
                                                                                                                                                                             "</div></div>";


             });
             var masonry = $('.grid');
             masonry.masonry({
                 itemSelector: '.boxn1'
             });

             $(masonry).append(fragment);


             setTimeout(function () {

                 $(masonry).masonry('reloadItems');
                 $(masonry).masonry('layout');
                 $(".boxn1").css("visibility", "visible");
             }, 2000);
             //$(masonry).append(fragment).masonry('appended', fragment, true);
              //$(masonry).append(fragment).masonry('reload');
             //  $(".grid").append(data.d).masonry('reload');
             $('#loader').hide();

         }

         function GetFirstRecordSet() {

             $('#loader').show();
                       var v='<%= Request.QueryString["v"] %>';
             //send a query to server side to present new content
             $.ajax({
                 type: "POST",
                 url: "profile-page-lookbook-details.aspx\\GetData",

                 data: '{pageIndex:1, lookId :"'+v+'"}',
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
             <!--#INCLUDE FILE="../includes/logo.txt" -->
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
    <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <div id="dvLoading"></div>
                </ProgressTemplate>

            </asp:UpdateProgress>
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
          <%--<div class="col-md-10 col-xs-8 ptext">
               <img src="../images/likes.png" alt="image" style="margin-right:6px;"/><a href="overview-likes.aspx">Likes</a>
          </div><!--col-md-12-->
          <div class="col-md-1 col-xs-1 ptext">
             <a href="overview-likes.aspx"><asp:Label runat="server" ID="lblTotolLikes" ></asp:Label></a>       
          </div><!--col-md-12-->--%>
          
          <div class="lines"><hr /></div>
          
          <div class="col-md-8 col-xs-12 cheading">
             Categories
          </div>
          <div class="col-md-11 col-xs-12 ptext1">
              <ul>               
                  <asp:Repeater ID="rptbrdCategories" runat="server" DataSourceID="sdsbrdCategories" >
                      <ItemTemplate>
             <li>
                              <a id="linkcat" href="javascript:void(0);" onclick="GetCategory('<%#Eval("CategoryID") %>');"><%#Eval("Title") %></a>,
                          </li>  
                                                   
                      </ItemTemplate>
                  </asp:Repeater>
                  <asp:SqlDataSource runat="server" ID="sdsbrdCategories" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                  SelectCommand="SELECT Distinct dbo.Tbl_Categories.CategoryID, dbo.Tbl_Categories.Title FROM dbo.Tbl_Lookbooks
                  INNER JOIN dbo.Tbl_LbCategory ON dbo.Tbl_Lookbooks.LookID = dbo.Tbl_LbCategory.LookID
                  INNER JOIN dbo.Tbl_Categories ON dbo.Tbl_Categories.CategoryID=Tbl_LbCategory.CategoryID
                    WHERE Tbl_Lookbooks.UserID=?">
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
                       <li><a id="linkcat" href="javascript:void(0);" onclick="GetSeason('<%#Eval("SeasonID") %>');"><%#Eval("Season") %></a>,</li>                                                
                      </ItemTemplate>
                  </asp:Repeater>
                  </ul>
                  <asp:SqlDataSource runat="server" ID="sdsSeasons" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                  SelectCommand="SELECT Distinct Tbl_Seasons.SeasonID,Tbl_Seasons.Season FROM Tbl_Seasons 
                  INNER JOIN dbo.Tbl_LbSeasons ON dbo.Tbl_Seasons.SeasonID = Tbl_LbSeasons.SeasonID
                  INNER JOIN dbo.Tbl_Lookbooks ON dbo.Tbl_Lookbooks.LookID=Tbl_LbSeasons.LookID
WHERE Tbl_Lookbooks.UserID=?">
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
   <li><a id="linkcat" href="javascript:void(0);" onclick="GetHoliday('<%#Eval("HolidayID") %>');"><%#Eval("Title") %></a>,</li>                         
                                      
                      </ItemTemplate>
                  </asp:Repeater>
                  </ul>
                  <asp:SqlDataSource runat="server" ID="sdsHolidays" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                  SelectCommand="SELECT Distinct Tbl_Holidays.HolidayID,Tbl_Holidays.Title FROM Tbl_Holidays 
                  INNER JOIN dbo.Tbl_LbHolidays ON dbo.Tbl_Holidays.HolidayID = Tbl_LbHolidays.HolidayID
                  INNER JOIN dbo.Tbl_Lookbooks ON dbo.Tbl_Lookbooks.LookID=Tbl_LbHolidays.LookID
WHERE Tbl_Lookbooks.UserID=?">
                      <SelectParameters>
                          <asp:CookieParameter CookieName="FrUserID" Name="?" />
                      </SelectParameters>
                  </asp:SqlDataSource>
          </div>          
          <div class="lines"><hr /></div>
          
          <div class="col-md-8 col-xs-12 cheading">
             Basic Info
          </div>
          <div class="col-md-12 col-xs-12 ptext2" runat="server" ID="dvAbout" style="word-wrap: break-word;">
           <asp:Label ID="lblDescription" runat="server" Text="Label"></asp:Label>
          </div>
          <%--<div class="lines"><hr /></div>
          <div class="col-md-8 col-xs-12 cheading">
             History
          </div>
          <div class="col-md-12 col-xs-12 ptext2" runat="server" ID="dvHistory" style="word-wrap: break-word;">
             <asp:Label ID="lblHistory" runat="server" Text="Label"></asp:Label>
          </div>--%>
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
                         <div class="inwhtext"><a href="profile-page-items.aspx">Items</a></div>
                         <div class="inwhtext"><b><a href="profile-page-lookbooks.aspx" style="color:#000;">Lookbooks</a></b></div>
                             <div class="serinputp">
                                <asp:Button runat="server" ID="btnSearch" style="position: absolute; width: 0px; height: 0px;z-index: -1;"  OnClick="btnSearch_OnClick">
                                </asp:Button>  <span class="fa fa-search"></span>
                                 <asp:TextBox  ID="txtsearch" placeholder="Search" CssClass="seins1" style="padding-left:30px;"    runat="server">
                                     
                                 </asp:TextBox>
                             </div> <!--serinput-->
                       </div><!--searchpro-->
                       <div class="lineclook"></div>
              
              
            <div class="discoverbn">     
           
            <div id="contentbox" style="padding-top:20px;">
                <div id="divAlerts" runat="server" class="alert" visible="False">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                        Text="" Visible="True"></asp:Label>
                </div>
              <div class="grid">
      
                </div>
          
            </div><!--content-->
       
             <%--  <div id="contentbox">
                   <div id="ajaxrequest"></div>
               </div> --%>           
            </div>
             
    </div><!--col-md-10 col-sm-12 col-xs-12-->   

            <!--text-->
           
        </ContentTemplate>
       
    </asp:UpdatePanel>   
    
     <div class="divLoadData"></div>
     <div id="divPostsLoader">
         <div id="loader" style="width:100%; margin:0 auto; display:none;"><img src="../images/ajax-loader.gif" ></div>
          <a href="#"  id="loadMore">Load More</a>
     </div>
</div><!--wrapperblock-->
  
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
         var $parentPage = window.location;
         $(document).ready(function () {
             var v = '<%= Request.QueryString["v"] %>';
             var k = '<%= Request.QueryString["k"] %>';
             $(".fancybox").fancybox({
                 href: $(this).attr('href'),
                 fitToView: true,
                 frameWidth: '100%',
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
                         window.history.replaceState('d', 't', pageUrl);
                     }
                 },
                 afterClose: function () {
                     var currentpageurl = 'http://presspreview.azurewebsites.net/brand/profile-page-lookbook-details.aspx?v=' + v + "&k=" + k;
                     window.history.pushState('d', 't', currentpageurl);


                 }
             });

         });
     </script>
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
