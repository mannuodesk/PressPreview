<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="editor.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="cache-control" content="max-age=0" />
<meta http-equiv="expires" content="-1" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<title>Editor Home</title>
<meta name="viewport" content="width=device-width, initial-scale=1"/>

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>

<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

<!--lightbox-->
	<link rel="stylesheet" type="text/css" href="../source/jquery.fancybox.css" media="screen" />
<script src="../ckeditor/ckeditor.js"></script>
<script src="../js/sample.js"></script>
    <script type="text/javascript" src="../js/jssor.slider.min.js"></script>
    <script src="../js/homepage.js"></script>
    <link href="../css/autohide.css" rel="stylesheet" type="text/css" />
     <script type="text/javascript">
         function HideLabel() {
             setTimeout(function () { $('#divAlerts').fadeOut(); }, 4000);

         };
$(window).load(function() {
    
                console.log( $( document ).width());
    console.log( $( document ).height());
    if($( document ).width()>767){
         var imagecontainerHeight=$( document ).width()*0.35807;
          var itemImagecontainerHeight=$( document ).width()*0.23568;
    console.log( imagecontainerHeight);
    console.log( itemImagecontainerHeight);
    $(".featurette-image").height(imagecontainerHeight);   
     $(".featureImageHover").css('background-color',"white");
        $(".itemsimages").height(itemImagecontainerHeight); 
         $(".itemImageHover").css('background-color',"white");
    }
    else{
          var imagecontainerHeight=$( document ).width()*0.716353;
    console.log( imagecontainerHeight);
    $(".featurette-image").height(imagecontainerHeight);  
        $(".featureImageHover").css('background-color',"white");
        $(".itemsimages").height(imagecontainerHeight); 
            $(".itemImageHover").css('background-color',"white"); 
    }
});
$(document).ready(function() {
                   console.log( $( document ).width());
    console.log( $( document ).height());
    if($( document ).width()>767){
         var imagecontainerHeight=$( document ).width()*0.35807;
          var itemImagecontainerHeight=$( document ).width()*0.23568;
    console.log( imagecontainerHeight);
    console.log( itemImagecontainerHeight);
    $(".featurette-image").height(imagecontainerHeight);   
     $(".featureImageHover").css('background-color',"white");
        $(".itemsimages").height(itemImagecontainerHeight); 
         $(".itemImageHover").css('background-color',"white");
    }
    else{
          var imagecontainerHeight=$( document ).width()*0.716353;
    console.log( imagecontainerHeight);
    $(".featurette-image").height(imagecontainerHeight);  
        $(".featureImageHover").css('background-color',"white");
        $(".itemsimages").height(imagecontainerHeight); 
            $(".itemImageHover").css('background-color',"white"); 
    }
    
});
$(document).ready(function() {



$(window).resize(function(){
          console.log( $( document ).width());
    console.log( $( document ).height());
    if($( document ).width()>767){
         var imagecontainerHeight=$( document ).width()*0.35807;
          var itemImagecontainerHeight=$( document ).width()*0.23568;
    console.log( imagecontainerHeight);
    console.log( itemImagecontainerHeight);
    $(".featurette-image").height(imagecontainerHeight);   
     $(".featureImageHover").css('background-color',"white");
        $(".itemsimages").height(itemImagecontainerHeight); 
         $(".itemImageHover").css('background-color',"white");
    }
    else{
          var imagecontainerHeight=$( document ).width()*0.716353;
    console.log( imagecontainerHeight);
    $(".featurette-image").height(imagecontainerHeight);  
        $(".featureImageHover").css('background-color',"white");
        $(".itemsimages").height(imagecontainerHeight); 
            $(".itemImageHover").css('background-color',"white"); 
    }
    });

});
</script>
    <style>
        #featured2{
                font-size: 0px;
        }
  @media screen and (max-width: 320px), (max-device-width: 480px) and (min-device-width: 320px) and (orientation: portrait){
.starter-template {
    padding: 10px 0 0px;
}

.sline{
    margin-top: 0px !important;
}
}
.starter-template2{
        padding: 8px 0px 0px !important;
}
     .starter-template {
         padding: 8px 0 20px;
     }
     .overlay{
             height: auto !important;

     }
     
     
     
     @media (min-width: 767px){
.ehover13:hover .featureImageHover{
    filter:brightness(.6);
    -webkit-filter:brightness(.4)
    }
    .ehover13:hover .itemImageHover{
    filter:brightness(.6);
    -webkit-filter:brightness(.4)
    }
    .ehover13:hover img{
  filter:brightness(1);
    -webkit-filter:brightness(1)
        }
}

     
     @media (max-width: 766px){
.ehover13:hover .featureImageHover{
    filter:brightness(.6);
    -webkit-filter:brightness(.4)
    }
    .ehover13:hover .itemImageHover{
    filter:brightness(.6);
    -webkit-filter:brightness(.4)
    }
    .ehover13:hover img{
  filter:brightness(1);
    -webkit-filter:brightness(1)
        }
}
     
     /*@media (min-width: 992px){
         .col-md-6 {
       float: right;
    }
    }*/

 
    </style>

<script type="text/javascript">

    $(function () {
        $("div").slice(0, 4).show();
        $(".loadMore").on('click', function (e) {
            e.preventDefault();
            $("div:hidden").slice(0, 4).slideDown();
            if ($("div:hidden").length == 0) {
                $("#load").fadeOut('slow');
            }
            GetRecords();
        });
    });

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

    ///////////
    var pageIndex = 0;
    var pageCount;

    function GetRecords() {

        pageIndex++;
  
            // $('#divPostsLoader').prepend('<img src="../images/ajax-loader.gif">');
            $('#loader').show();

            //send a query to server side to present new content
            $.ajax({
                type: "POST",
                url: "Default.aspx\\GetData",
                data: '{pageIndex: ' + pageIndex + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    //  data = JSON.parse(data);
                    parseResonse(data);

                }
            });
    }
    var hasItem = false;
    function parseResonse(data) {
        var items = data.d;
        var fragment;
        if (items.length != 0) {
            $('#LoaderItem').show();
            var hasItem = false;
            $.each(items, function (index, val) {
                console.log(index);
                console.log(val);
                pageCount = val.PageCount;
                fragment += " <div class='col-md-4 col-sm-6 col-xs-12' style='padding-bottom:0px;    margin-top: 21px;' > " +
                    " <div class='hover ehover13'> " +
                        "     <a href='itemview2?v=" + val.ItemId + "' class='fancybox'> " +
                        "<div class='itemImageHover'>"+
                                                   "     <img class='itemsimages img-responsive center-block' src='../photobank/" + val.FeatureImg + "' style='object-fit:contain;'  alt=''> " +
                                                   "</div>"+
                            // "     <img class='img-responsive' src='../imgLarge/" + val.FeatureImg + "' style='width:100%; height:333px;' alt=''> " +
                                "     <div class='overlay'> " +
                                    "         <h2>" + val.Name + " </h2> " +
                                        "         <h3><a href='itemview2?v=" + val.ItemId + "' class='fancybox'>" + val.Title + "</a></h3> " +
                                            "         <h2 class='linenew'></h2> " +
                                                "         <h2>" + val.DatePosted + "</h2> " +
                                                    "     </div> " +
                                                        "     </a>" +
                                                            "     &nbsp;<!--overlay--></div> " +
                                                                "   <!--hover ehover13--> " +
                                                                    "  </div><!--col-md-4 col-sm-6 col-xs-12-->";

            });
            $('#featured2').append(fragment);
                  console.log( $( document ).width());
    console.log( $( document ).height());
    if($( document ).width()>767){
         var imagecontainerHeight=$( document ).width()*0.35807;
          var itemImagecontainerHeight=$( document ).width()*0.23568;
    console.log( imagecontainerHeight);
    console.log( itemImagecontainerHeight);
    $(".featurette-image").height(imagecontainerHeight);   
     $(".featureImageHover").css('background-color',"white");
        $(".itemsimages").height(itemImagecontainerHeight); 
         $(".itemImageHover").css('background-color',"white");
    }
    else{
          var imagecontainerHeight=$( document ).width()*0.716353;
    console.log( imagecontainerHeight);
    $(".featurette-image").height(imagecontainerHeight);  
        $(".featureImageHover").css('background-color',"white");
        $(".itemsimages").height(imagecontainerHeight); 
            $(".itemImageHover").css('background-color',"white"); 
    }
            $('#LoaderItem').hide();
        } else if (hasItem == false) {
            $('#LoaderItem').hide();
            //$('#norecord').html("No Record Found");
            //$('#norecord').show();
        } else {
            $('#LoaderItem').hide();
            //$('#norecord').html("No More Record Found");
            //$('#norecord').show();
        }

        

        $('#loader').hide();
        if (pageCount <= 1) {
            $('.loadMore').hide();
        }
    }

    //    GetRecords.done(function (data) {
    //        var items = data.d;
    //        var fragment;

    //        $.each(items, function (index, val) {
    //            alert(val.ItemId);
    //            console.log(index);
    //            console.log(val.ItemId);
    //            pageCount = val.PageCount;
    //            fragment += " <div class='col-md-4 col-sm-6 col-xs-12' > " +
    //                " <div class='hover ehover13'> " +
    //                    "     <a href='itemview2?v=" + val.ItemId + "' class='fancybox'> " +
    //                        "     <img class='img-responsive' src='../imgLarge/" + val.FeatureImg + "' style='width:100%; height:333px;' alt=''> " +
    //                            "     <div class='overlay'> " +
    //                                "         <h2>" + val + " </h2> " +
    //                                    "         <h3><a href='itemview2?v=" + val.ItemId + "' class='fancybox'>" + val.Title + "</a></h3> " +
    //                                        "         <h2 class='linenew'></h2> " +
    //                                            "         <h2>" + val.Dated + "</h2> " +
    //                                                "     </div> " +
    //                                                    "     </a>" +
    //                                                        "     &nbsp;<!--overlay--></div> " +
    //                                                            "   <!--hover ehover13--> " +
    //                                                                "  </div><!--col-md-4 col-sm-6 col-xs-12-->";

    //        });


    //        $('#featured2').append(fragment);
    //        $('#featured2 undefined').remove();
    //        $('#loader').hide();
    //        if (pageCount <= 1) {
    //            $('.loadMore').hide();
    //        }


    //    });

    //    function GetFirstRecordSet() {

    //        $('#loader').show();

    //        //send a query to server side to present new content
    //        $.ajax({
    //            type: "POST",
    //            url: "Default.aspx\\GetData",
    //            data: '{pageIndex:1}',
    //            contentType: "application/json; charset=utf-8",
    //            dataType: "json",
    //            success: OnSuccess
    //        });

    //    }

    function OnSuccess(data, cb) {
        //  console.log(data);
        $('#featured2').empty();
        var items = data.d;
        var fragment;

        $.each(items, function (index, val) {
            console.log(index);
            console.log(val.ItemId);
            pageCount = val.PageCount;
            fragment += " <div class='col-md-4 col-sm-6 col-xs-12' style='padding-bottom:0px;    margin-top: 21px;' > " +
                " <div class='hover ehover13'> " +
                    "     <a href='itemview2?v=" + val.ItemId + "' class='fancybox'> " +
                        "     <img class='img-responsive' src='../photobank/" + val.FeatureImg + "' style='width:100%; height:333px;' alt=''> " +
                            "     <div class='overlay'> " +
                                "         <h2>" + val + " </h2> " +
                                    "         <h3><a href='itemview2?v=" + val.ItemId + "' class='fancybox'>" + val.Title + "</a></h3> " +
                                        "         <h2 class='linenew'></h2> " +
                                            "         <h2>" + val.Dated + "</h2> " +
                                                "     </div> " +
                                                    "     </a>" +
                                                        "     &nbsp;<!--overlay--></div> " +
                                                            "   <!--hover ehover13--> " +
                                                                "  </div><!--col-md-4 col-sm-6 col-xs-12-->";

        });


        $('#featured2').append(fragment);
        if ($.isFunction(cb)) {
            cb.call();
        }
        $('#loader').hide();
        if (pageCount <= 1) {
            $('.loadMore').hide();
        }

    }
    $(document).ready(function () {
        $('#LoaderItem').show();
        $('#featured2').empty();
        GetRecords();

    });
    //When scroll down, the scroller is at the bottom with the function below and fire the lastPostFunc function
    $(window).scroll(function () {
        if ($(window).scrollTop() == $(document).height() - $(window).height()) {
            // $("#loadMore").fadeIn();
            GetRecords();
        }
    });
     </script>
</head>

<body >
<form runat="server" id="form1">
<asp:scriptmanager runat="server" ID="scriptmanager1" EnablePageMethods="True"></asp:scriptmanager>

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
              <li class="active"><a  href="Default.aspx">Activity</a></li>
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
    <!--Banner-->
    <div class="topspace"></div>
    <div>
    <div id="jssor_1" style="position: relative; margin: 0 auto; top: 0px; left: 0px; width: 1300px; height: 300px; overflow: hidden; visibility:visible;">
        <!-- Loading Screen -->
        <div data-u="loading" style="position: absolute; top: 0px; left: 0px;">
            <div style="filter: alpha(opacity=70); opacity: 0.7; position: absolute; display: block; top: 0px; left: 0px; width: 100%; height: 100%;"></div>
            <div style="position:absolute;display:block;background:url('img/loading.gif') no-repeat center center;top:0px;left:0px;width:100%;height:100%;"></div>
        </div>
        <div data-u="slides" style="cursor: default; position: relative; top: 0px; left: 0px; width: 1300px; height: 300px; overflow: hidden;">
            <asp:repeater runat="server" ID="rptSlider"  DataSourceID="sdsSlider">
                <ItemTemplate>
                    <div data-p="225.00" style="display: none;">
                        <a href='<%# Eval("BannerLink","{0}") %>' target="_blank"><img data-u="image" src='<%# Eval("BannerImg","../photobank/{0}") %>' /></a>
                    </div>
                </ItemTemplate>
            </asp:repeater>
             <asp:SqlDataSource ID="sdsSlider" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                        ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" SelectCommand="SELECT  BannerID, BannerImg, SortOrder,BannerLink FROM Tbl_ActivityBanners ORDER BY SortOrder">
            </asp:SqlDataSource>
          
        
        </div>
        <!-- Arrow Navigator -->
        <span data-u="arrowleft" class="jssora22l" style="top:0px;left:12px;width:40px;height:58px;" data-autocenter="2"></span>
        <span data-u="arrowright" class="jssora22r" style="top:0px;right:12px;width:40px;height:58px;" data-autocenter="2"></span>
    </div>
    </div>
    <script>
        jssor_1_slider_init();
    </script>
<%--<!--bannerend-->
     <!--#INCLUDE FILE="../includes/banner.txt" --> 
<!--bannerend-->--%>


<!--text-->
<div class="wrapper">
<div class="col-md-12">
    <div id="divAlerts" runat="server" class="alert" visible="False">
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <asp:Label runat="server" ID="lblStatus"  for="PageMessage"
            Text="" Visible="True"></asp:Label>
    </div>
    
       <div class="starter-template">
        <h6><br />BRANDS</h6>
        <h1> This Week's Brands</h1>
        <div class="sline" style="margin-top: 19px;"><img src="../images/line.png" /></div>
      </div>
</div><!--col-md-10-->
</div><!--wrapperblock-->
<!--text-->  


    <!-- START THE FEATURETTES -->

         <div class="col-md-12">
           <div class="row featurette">
               <asp:Repeater ID="rptFeatured1" runat="server" DataSourceID="sdsFeatured1">
                   <ItemTemplate>
                       <div class="col-md-6 col-sm-6 col-xs-12" style="padding-bottom:0px;    margin-top: 0px;">
                 <div class="hover ehover13">
                       <a href="itemview2?v=<%# Eval("ItemID") %>" class="fancybox">
                      <div class=" featureImageHover">
                   
                    <!--<img class="featurette-image img-responsive center-block" src='<%# Eval("FeatureImg","../imgLarge/{0}") %>' style="width:100%; height:480px;" alt="">-->
                                   <%-- <img class="featurette-image img-responsive center-block" src='<%# Eval("FeatureImg","../photobank/{0}") %>' style="width:100%;height: 510px;" alt="">--%> 
                                        <img class="featurette-image img-responsive center-block" src='<%# Eval("FeatureImg","../photobank/{0}") %>' style="object-fit:contain" alt="">
                     
                      </div>
                      </a>
                         <a href="itemview2?v=<%# Eval("ItemID") %>" class="fancybox">
                        <div class=" overlay">
							<h2><%# Eval("Name","{0}") %> </h2>
							<h4><a href="itemview2?v=<%# Eval("ItemID") %>" class="fancybox"><%# Eval("Title","{0}") %></a></h4>
                            <h2 class="linenew"></h2>
							<h2><%# Eval("DatePosted","{0}") %></h2>
						</div><!--overlay-->
                      </a>	
                    		
				&nbsp;</div><!--hover ehover13-->
              </div>
                   </ItemTemplate>
               </asp:Repeater>
               <asp:SqlDataSource ID="sdsFeatured1" runat="server" 
                   ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                   ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                   SelectCommand="SELECT Tbl_Items.ItemID, Tbl_Items.Title, Tbl_Brands.Name, Tbl_Items.FeatureImg, CAST(Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted  FROM Tbl_Brands INNER JOIN Tbl_Items ON Tbl_Brands.UserID = Tbl_Items.UserID  WHERE (Tbl_Items.IsFeatured1 = 1) AND (Tbl_Items.IsPublished = 1) AND (Tbl_Items.IsDeleted IS NULL) AND IsFeatured2 IS NULL  ORDER BY Tbl_Items.SortOrder">
               </asp:SqlDataSource>
              <!--col-md-6-->
              <!--col-md-6-->
          </div><!--<!--row featurette-->
         </div><!--col-md-12-->
     <!-- /END THE FEATURETTES -->
     
     <!--text-->
<div class="wrapper">
<div class="col-md-12">
      <div class="starter-template starter-template2">
        <h6><br />INFLUENCER'S PICKS</h6>
        <h1> This Week's Picks </h1>
        <div class="sline" style="margin-top: 19px;"><img src="../images/line.png" /></div>
      </div>
</div><!--col-md-10-->
</div><!--wrapperblock-->
<!--text-->   
     <!-- START THE FEATURETTES -->
         <div class="col-md-12" style="padding-bottom: 70px;">
           <div id="featured2" class="row featurette">
<%--               <asp:Repeater ID="rptFeatured2" runat="server" DataSourceID="sdsFeatured2">
                   <ItemTemplate>
                       <div class="col-md-4 col-sm-6 col-xs-12 homelist" style="padding-bottom:0px">
                           <div class="hover ehover13">
                               <a href="itemview2?v=<%# Eval("ItemID") %>" class="fancybox">
                               <!--<img class="img-responsive" src='<%# Eval("FeatureImg","../imgLarge/{0}") %>' style="width:100%; height:333px;" alt="">-->
                                                             <img class="img-responsive" src='<%# Eval("FeatureImg","../photobank/{0}") %>' style="width:100%;" alt="">
                               <div class="overlay">
                                   <h2><%# Eval("Name","{0}") %> </h2>
                                   <h3><a href="itemview2?v=<%# Eval("ItemID") %>" class="fancybox"><%# Eval("Title","{0}") %></a></h3>
                                   <h2 class="linenew"></h2>
                                   <h2><%# Eval("dated", "{0}")%></h2>
                               </div>
                               </a>
                               &nbsp;<!--overlay--></div>
                           <!--hover ehover13-->
                       </div><!--col-md-4 col-sm-6 col-xs-12-->
                       
                   </ItemTemplate>
               </asp:Repeater>
                          
               <asp:SqlDataSource ID="sdsFeatured2" runat="server" 
                   ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                   ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" SelectCommand="SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID,a.row, 
                            a.ItemID,  a.Title,ItemKey,a.FeatureImg,  
                            a.DatePosted as [dated] 
                            FROM ( SELECT ROW_NUMBER() OVER (ORDER BY ItemID ASC) AS row, ItemID, dbo.Tbl_Items.Title, 
									ItemKey, dbo.Tbl_Items.FeatureImg, 
									dbo.Tbl_Items.DatePosted as [dated],UserID,IsDeleted,IsPublished, IsFeatured2, IsFeatured1,SortOrder,DatePosted  FROM Tbl_Items ) AS a 
									INNER JOIN Tbl_Brands ON Tbl_Brands.UserID=a.UserID  
									
                            WHERE IsFeatured2=1 AND IsPublished=1 AND IsDeleted IS NULL AND IsFeatured1 IS NULL AND SortOrder BETWEEN 1 AND 10  ORDER BY SortOrder"></asp:SqlDataSource>
                          --%>
             
              
          </div>
             
             
                         <div id="LoaderItem"  style="display:none;">
                           <center>
         <%--                  <i class="fa fa-spinner" aria-hidden="true"></i>--%>
                           <img src="../images/ring.gif" />
                           <%-- <img src="../images/Rainbow.gif"  /> --%>
                           </center>

                       </div>
                       
                       
                       <div style="display:none">
                       <div id="norecord" style="display:none;    margin-bottom: 63px;">
                           No Record Found
                       </div>
             </div>
             <script>
                 $(function () {
                     $('#log_grid_1.paginated').each(function () {
                         var currentPage = 0;
                         var numPerPage = 3;
                         var $grid = $(this);
                         $grid.bind('repaginate', function () {
                             $grid.find('.log_grid_1_record').hide().slice(currentPage * numPerPage, (currentPage + 1) * numPerPage).show();
                         });
                         $grid.trigger('repaginate');
                         var numRows = $grid.find('.log_grid_1_record').length;
                         var numPages = Math.ceil(numRows / numPerPage);
                         var $pager = $('<div>Page </div>');
                         for (var page = 0; page < numPages; page++) {
                             $('<span></span>').text(page + 1).bind('click', {
                                 newPage: page
                             }, function (event) {
                                 currentPage = event.data['newPage'];
                                 $grid.trigger('repaginate');
                                 $(this).addClass('active').siblings().removeClass('active');
                             }).appendTo($pager).addClass('clickable');
                         }
                         $pager.insertBefore($grid).find('span.page-number:first').addClass('active');
                     });
                 });
</script>
             
             
             <!--<!--row featurette-->
             <div style="display:none">
            <div id="divPostsLoader">
                     <div id="loader" style="width:100%; margin:0 auto; display:none;"><img src="../images/ajax-loader.gif" ></div>
                     <a href="#"  class="loadMore">Load More</a>
                 </div>
                 </div>
         </div><!--col-md-12-->
          
     <!-- /END THE FEATURETTES -->


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
    </form>
   <script type="text/javascript">
       $(document).ready(function () {
           var userId = '<%= Request.Cookies["FRUserId"].Value %>';
           $("#lbViewMessageCount").hover(function () {

               $.ajax({
                   type: "POST",
                   url: "Default.aspx\\UpdateMessageStatus",
                   contentType: "application/json; charset=utf-8",
                   data: "{'userID':'" + userId + "'}",
                   dataType: "json",
                   async: true,
                   error: function (jqXhr, textStatus, errorThrown) {
                   //    alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
                   },
                   success: function (msg) {
                       //                    if (msg.d == true) {

                       $('#<%=lblTotalMessages.ClientID%>').hide("slow");
                       $('#<%=lblTotalMessages.ClientID%>').val = "";
                       return false;
                   }
               });

           });


           $("#lbViewAlerts").hover(function () {

               $.ajax({
                   type: "POST",
                   url: "Default.aspx\\UpdateNotifications",
                   contentType: "application/json; charset=utf-8",
                   data: "{'userID':'" + userId + "'}",
                   dataType: "json",
                   async: true,
                   error: function (jqXhr, textStatus, errorThrown) {
                      // alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
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
                  frameWidth: '100%',
                  frameHeight: '100%',
                  width: '87%',
                  height: '100%',
                  preload: '40',
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

                          //  var id = url.substring(url.lastIndexOf("/") + 1, url.length);
                          var id = url[1];
                          var pageUrl = 'http://presspreview.azurewebsites.net/editor/itemview2?v=' + id;
                          //var pageUrl = 'http://localhost:2080/editor/' + id;
                          //window.location = pageUrl;
                          window.history.pushState('d', 't', pageUrl);
                      }

                  },
                  beforeClose: function () {
                      window.history.pushState('d', 't', 'http://presspreview.azurewebsites.net/editor/');
                      //window.history.pushState('d', 't', 'http://localhost:2080/editor/');
                  }
              });

          });
</script>

</body>
</html>
