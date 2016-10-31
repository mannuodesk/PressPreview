<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeFile="Copy of discover.aspx.cs" Inherits="home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Discover</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../css/checkbox.css"/>
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <link href="../css/jquery-ui.css" rel="stylesheet" type="text/css" />
     <script src="../js/jquery-ui.min.js"></script>
    	<script type="text/javascript" src="../source/jquery.fancybox.js?v=2.1.5"></script>
	<link rel="stylesheet" type="text/css" href="../source/jquery.fancybox.css?v=2.1.5" media="screen" />
<script src="../ckeditor/ckeditor.js"></script>
<script src="../js/sample.js"></script>
    <!-- Fency box Resources -->
    <link href="../fencybox/source/jquery.fancybox.css" rel="stylesheet" type="text/css" />
    <link href="../fencybox/source/helpers/jquery.fancybox-buttons.css" rel="stylesheet"
        type="text/css" />
    <link href="../fencybox/source/helpers/jquery.fancybox-thumbs.css" rel="stylesheet"
        type="text/css" />
     <script src="../fencybox/lib/jquery.mousewheel-3.0.6.pack.js" type="text/javascript"></script>
     <script src="../fencybox/source/jquery.fancybox.js" type="text/javascript"></script>
    <script src="../fencybox/source/jquery.fancybox.pack.js" type="text/javascript"></script>
    <script type="text/javascript">
        
        $(document).ready(function () {
            $(".fancybox").fancybox({
                type: 'iframe',
                transitionIn:    'elastic',
                transitionOut:    'elastic',
                speedIn:600,
                speedOut:200,
                overlayShow: false,
                'frameWidth': 1100, // set the width
                'frameHeight': 600,
            'width': 1100,
            'height': 600
                });
            });
    </script>
<script>
   jQuery(document).ready(function(){
   jQuery("#loaddata").click(function(){ 
   jQuery.ajax({url:"loadpage/home1.html",success:function(ajaxresult){
   jQuery("#ajaxrequest").html(ajaxresult);
  }});
 });
 
 jQuery("#loaddatan").click(function(){ 
   jQuery.ajax({url:"loadpage/home1.html",success:function(ajaxresult){
   jQuery("#ajaxrequest").html(ajaxresult);
  }});
 });
});
</script>
     <script type="text/javascript">  
        $(document).ready(function() {  
            SearchText();  
        });
         
       function SearchText() {  
            $("#txtsearch").autocomplete({
                source: function(request, response) {  
                    $.ajax({  
                        type: "POST",  
                        contentType: "application/json; charset=utf-8",  
                        url: "discover.aspx\\GetBrandName",
                        data: "{'empName':'" + document.getElementById('txtsearch').value + "'}",
                        dataType: "json",  
                        success: function(data) {  
                            response(data.d);  
                        },  
                        error: function(result) {  
                            alert("No Match");  
                        }  
                    });  
                }  
            });  
        }  
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
              <div class="logob"><a href="../Default.aspx">Press Preview</a></div>
              <div class="logos"><a href="../Default.aspx">Logo Branding</a></div>
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
               <li><a href="event.aspx">Event</a></li>
            </ul>            
             <ul class="nav navbar-nav navbar-right">
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                 <span style="margin-right:5px;"><asp:Label runat="server" ID="lblUsername" ></asp:Label></span> <asp:Image runat="server" ID="imgUserIcon" ImageUrl="../images/menuright.png"></asp:Image></a>
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

<!--Banner-->
     <!--#INCLUDE FILE="../includes/banner.txt" --> 
<!--bannerend-->


<!--text-->
<div class="wrapper">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <div id="dvLoading"></div>
                </ProgressTemplate>

            </asp:UpdateProgress>
            <div class="wrapperwhite">

                <div class="colrow">
                    <div class="dropfirst">  
                     <span class="folheading"><a href="#"  style="color:#4e93ce;"><i class="fa fa-square" style="position:relative; top:-6px; font-size:6px;" ></i> Items</a></span> 
                     <span class="folheading" style="margin-left:20px;"><a href="#"><i class="fa fa-square" style="position:relative; top:-6px; font-size:6px;" ></i> Lookbook</a></span> 
                    <img src="../images/li.png" />     
                    </div>
                    <div class="dropdowndis">
                        <span class="folheading"><a href="#">Categories</a> <span class="caret"></span></span>
                        <div class="dropdowndis-content">
                            <asp:Repeater ID="rptCategories" runat="server" DataSourceID="sdsCategories" OnItemCommand="rptCategories_ItemCommand">
                                <ItemTemplate>
                                    <p class="submen"><asp:LinkButton runat="server" ID="lbtnSeason" CommandName="1" CommandArgument='<%# Eval("CategoryID") %>'><%#Eval("Title") %></asp:LinkButton></p>
                                </ItemTemplate>
                            </asp:Repeater>

                            <asp:SqlDataSource runat="server" ID="sdsCategories" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' SelectCommand="SELECT [CategoryID], [Title] FROM [Tbl_Categories] ORDER BY [Title]"></asp:SqlDataSource>
                        </div>
                        <!--dropdowndis-content-->
                    </div>
                    <!--dropdowndis-->

                    <div class="dropdowndis">
                        <span class="folheading"><a href="#">Season</a> <span class="caret"></span></span>
                        <div class="dropdowndis-content1">
                            <asp:Repeater ID="rptSeasons" runat="server" DataSourceID="sdsSeasons" OnItemCommand="rptSeasons_ItemCommand">
                                <ItemTemplate>
                                    <p class="submen"><asp:LinkButton runat="server" ID="lbtnSeason" CommandName="1" CommandArgument='<%# Eval("SeasonID") %>'><%#Eval("Season") %></asp:LinkButton></p>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:SqlDataSource runat="server" ID="sdsSeasons" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' SelectCommand="SELECT [SeasonID], [Season] FROM [Tbl_Seasons]"></asp:SqlDataSource>
                        </div>
                        <!--dropdowndis-content-->
                    </div>
                    <!--dropdowndis-->
                </div>
                <!--per-->
            </div><!--wrapperwhite-->
            <!--col-md-12-->

           <div class="col-md-12 col-xs-12  discoverb">     
               <div class="discovewrap">
                   <div id="divAlerts" runat="server" class="alert" visible="False">
                       <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                       <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                           Text="" Visible="True"></asp:Label>
                   </div>
                   <div id="contentbox">
                       <asp:Repeater runat="server" ID="rptLookbook" DataSourceID="sdsLookbooks" OnItemDataBound="rptLookbook_ItemDataBound">
                           <ItemTemplate>
                               <div class="box">
                                   <div class="disblock">
                                       <a href="../lightbox/?v=<%# Eval("LookID") %>" class="fancybox">
                                           <div class="dbl">
                                               <div class="hover ehover13">
                                                   <img class="img-responsive" src="../imgSmall/<%# Eval("MainImg") %>" alt="<%# Eval("Title","{0}") %>" /><div class="overlay">
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
                                                           <img src='../brandslogoThumb/<%# Eval("logo") %>' /></a>
                                                   </div>
                                               </div>
                                               <!--mimageb-->
                                               <div class="mtextb" style="width: 75%; margin-left: 15px;">
                                                   <div class="m1">
                                                       <div class="muserd"><a href="../lightbox/?v=<%# Eval("LookID") %>" class="fancybox"><%# Eval("Title","{0}") %></a></div>
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
                                                           &nbsp;<asp:Label runat="server" ID="lblLikes" Text='<%# Eval("LookID") %>'></asp:Label>
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
                       </asp:Repeater>
                       <asp:SqlDataSource runat="server" ID="sdsLookbooks" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' SelectCommand="SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, dbo.Tbl_Brands.Logo, dbo.Tbl_Lookbooks.LookID, dbo.Tbl_Lookbooks.Title, dbo.Tbl_Lookbooks.LookKey, dbo.Tbl_Lookbooks.Description, dbo.Tbl_Lookbooks.MainImg, dbo.Tbl_Lookbooks.Views, CAST(Tbl_Lookbooks.DatePosted AS VARCHAR(12)) as DatePosted, Tbl_Lookbooks.DatePosted as [dated] FROM dbo.Tbl_Brands INNER JOIN dbo.Tbl_Lookbooks ON dbo.Tbl_Brands.BrandID = dbo.Tbl_Lookbooks.BrandID
                                Where dbo.Tbl_Lookbooks.IsDeleted IS NULL AND dbo.Tbl_Lookbooks.IsPublished=1
                                ORDER BY dbo.Tbl_Lookbooks.DatePosted DESC"></asp:SqlDataSource>
                       <!--box-->
                   </div>
                   <!--content-->
                   <div id="contentbox">
                       <div id="ajaxrequest"></div>
                   </div>

               </div><!--col-md-10 col-sm-12 col-xs-12-->     
               
     
     <div class="discovewraps">
              
              <!--search-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading">Search</div> 
                             <div class="serinput">
                                 <span class="fa fa-search"></span>
                                 <input type="text" runat="server" id="txtsearch" placeholder="search" value="" class="sein" onserverchange="txtsearch_ServerChange" />
                             </div> <!--serinput-->
                         </div><!--search-->
                  </div><!--colmd12-->
                  <div class="dissp"></div>
                  
            <!--colors-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading" style="margin-bottom:10px;">Color</div> 
                               <asp:TextBox ID="txtColor" runat="server" CssClass="color" TextMode="Color" Width="280" BorderStyle="None" ToolTip="Click here to choose color">#FFFFFF</asp:TextBox>

                         </div><!--search-->
                  </div><!--colmd12-->
                  <div class="dissp"></div>      
                 
                  
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading" style="margin-bottom:10px;">Brands</div> 
                             <div id="brandlst">
                             <asp:Repeater ID="rptBrandsSearch" runat="server" DataSourceID="sdsbrandsSearch">
                                 <ItemTemplate>
                                     <div class="dblock">
                                         <input runat="server" type="checkbox" id="chkbrand"/><label for="test6"><div><%# Eval("Name") %></div>
                                         </label>
                                     </div>
                                 </ItemTemplate>
                             </asp:Repeater></div>
                             <asp:SqlDataSource runat="server" ID="sdsbrandsSearch" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' SelectCommand="SELECT Top 6 [BrandID], [BrandKey], [Name] FROM [Tbl_Brands] ORDER BY [TotalViews] DESC"></asp:SqlDataSource>
                         </div><!--search-->
                         
                         <div class="bmore" onclick="showbmore()">View More</div>
                         <div class="bfewer" onclick="showbfewer()" style="display:none;">See fewer</div>
                         
                  </div><!--colmd12-->
                         
                  <div class="dissp"></div>                  
              
          <!--tags-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading" style="margin-bottom:20px;">Related Tags</div> 
                             
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
                             
                            <div id="tagfewer">
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
                            </div> 
                             
                         </div><!--search-->
                         
                         <%--<div class="fewer" onclick="showtags()">See fewer tags</div>
                         <div class="fewerf" onclick="showtagsf()" style="display:none;">See full tags</div>--%>
                  </div><!--colmd12-->
                  <div class="dissp"></div>                                 
          
              
     </div><!--discoverwraps-->
     
     
</div>
        </ContentTemplate>
    </asp:UpdatePanel>   

<!--footer-->
  <div class="footerbg">
     <div class="row">
       <div class="col-md-11 col-xs-10">©<%: DateTime.Now.Year %> Press Preview</div>
        <div class="col-md-pull-1 col-xs-pull-1">
           <div class="f1"><a id="loaddata"><img src="../images/footerarrow.png" /></a></div>
           <div class="f2"><a id="loaddatan">Expand>/div>
        </div>
      </div>    
  </div><!--footer-->
<!--footer-->

</div>

</div><!--wrapper-->

<script src="../js/bootstrap.js"></script>
</form>

</body>
</html>
