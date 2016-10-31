<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeFile="profile.aspx.cs" Inherits="home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Brands List</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
   <script src="../js/jquery-ui.min.js"></script>
    <link href="../js/jquery-ui.css" rel="stylesheet" />
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
            'height': 600,
                });
            });
    </script>
<!--custom scroller-->
    <link rel="stylesheet" type="text/css" href="customscroller/jquery.mCustomScrollbar.css" media="screen" />
	<script>window.jQuery || document.write('<script src="customscroller/jquery-1.11.0.min.js"><\/script>')</script>
	<script src="customscroller/jquery.mCustomScrollbar.concat.min.js"></script>
	<script>
		(function(jQuery){
			jQuery(window).load(function(){
				
				jQuery("#content-1").mCustomScrollbar({
					theme:"minimal"
				});
				
			});
		})(jQuery);
	</script>
<!--load data-->
 <script>
   jQuery(document).ready(function(){
   jQuery("#loaddata").click(function(){ 
   jQuery.ajax({url:"loadpage/profile1.html",success:function(ajaxresult){
   jQuery("#ajaxrequest").html(ajaxresult);
  }});
 });
 
 jQuery("#loaddatan").click(function(){ 
   jQuery.ajax({url:"loadpage/profile1.html",success:function(ajaxresult){
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
                        url: "profile.aspx\\GetLookbookTitle",
                        data: "{'lbName':'" + document.getElementById('txtsearch').value + "'}",
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
     
    <style type="text/css">
        .alphbets
        {
            margin:0 auto; padding: 0 10px; cursor: pointer; display: inline; color: #212121;
        }
        .alphbets:active
        {
           font-weight:bold;
        }
    </style>
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
              <li><a href="discover.aspx">Discover</a></li>
              <li class="active"><a href="brands.aspx">Brands</a></li>
              <li><a href="event.aspx">Event</a></li>
            </ul>            
             <!--#INCLUDE FILE="../includes/settings.txt" -->   
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
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" >
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <div id="dvLoading"></div>
                </ProgressTemplate>

            </asp:UpdateProgress>
            <div class="col-md-3 col-xs-12 blockp" style="background:#fff;">
          <div class="col-md-12 col-xs-12 pheading">
               <a href="#" runat="server" id="lbBrandName"></a> 
              <%-- <span class="buymain"><a href="profile-page-edit.html"> <button type="submit" name="login" id="login" class="hvr-sweep-to-rightp"><i class="fa fa-pencil"></i>Edit Profile</button></a></span>
               <div class="butedit" style="margin-top:20px;"><a href="profile-page-edit.html"><button type="submit" name="login" id="login" class="hvr-sweep-to-rightp"><i class="fa fa-pencil"></i>Edit Profile</button></a></div>--%>
          </div><!--col-md-12-->
          <div class="col-md-5 col-xs-12 pimage">
               <a href="#"><img runat="server" id="imgLogo" class="img-circle" src="../images/imagep.png" alt="image"/></a>
          </div><!--col-md-12-->
          <div class="col-md-7 col-xs-12 phtext">
               <img src="../images/location.png" alt="location" style="margin-right:6px;"  /> <asp:Label runat="server" ID="lblCity"></asp:Label>, <asp:Label runat="server" ID="lblCountry"></asp:Label><br />
               <a runat="server" id="lbWebURL" href="#"></a>               
          </div><!--col-md-12-->
          <div class="lines"><hr /></div>
          
          <div class="col-md-10 col-xs-8 ptext">
               <img src="../images/views.png" alt="image" style="margin-right:6px;"/><a href="followers-page.html">Views</a>
          </div><!--col-md-12-->
          <div class="col-md-1 col-xs-1 ptext">
              <asp:Label runat="server" ID="lblTotolViews" ></asp:Label>           
          </div><!--col-md-12-->
          <div class="col-md-10 col-xs-8 ptext">
               <img src="../images/likes.png" alt="image" style="margin-right:6px;"/><a href="followers-page.html">Likes</a>
          </div><!--col-md-12-->
          <div class="col-md-1 col-xs-1 ptext">
              <asp:Label runat="server" ID="lblTotolLikes" ></asp:Label>        
          </div><!--col-md-12-->
          <div class="col-md-10 col-xs-8 ptext">
               <img src="../images/followers.png" alt="image" style="margin-left:-4px; margin-right:6px;"/><a href="followers-page.html">Followers</a>
          </div><!--col-md-12-->
          <div class="col-md-1 col-xs-1 ptext">
            <asp:Label runat="server" ID="lblTotalFollowers" ></asp:Label>        
          </div><!--col-md-12-->
          <div class="lines"><hr /></div>
          
          <div class="col-md-8 col-xs-12 cheading">
             Categories
          </div>
          <div class="col-md-11 col-xs-12 ptext1">
              <ul>               
                  <asp:Repeater ID="rptbrdCategories" runat="server" DataSourceID="sdsbrdCategories" OnItemCommand="rptbrdCategories_ItemCommand">
                      <ItemTemplate>
                          <li><asp:LinkButton runat="server" ID="lbtnCategory" CommandName="1" CommandArgument='<%# Eval("CategoryID") %>'><%#Eval("Title") %></asp:LinkButton>,</li>   
                                                   
                      </ItemTemplate>
                  </asp:Repeater>
                  <asp:SqlDataSource runat="server" ID="sdsbrdCategories" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' SelectCommand="SELECT Distinct dbo.Tbl_Categories.CategoryID, dbo.Tbl_Categories.Title FROM dbo.Tbl_Lookbooks INNER JOIN dbo.Tbl_Categories ON dbo.Tbl_Lookbooks.CategoryID = dbo.Tbl_Categories.CategoryID
WHERE Tbl_Lookbooks.BrandID=?">
                      <SelectParameters>
                          <asp:QueryStringParameter QueryStringField="v" Name="?"></asp:QueryStringParameter>
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
             <asp:Repeater ID="rptSeason" runat="server" DataSourceID="sdsSeasons" OnItemCommand="rptSeason_ItemCommand">
                      <ItemTemplate>
                          <li><asp:LinkButton runat="server" ID="lbtnSeason" CommandName="1" CommandArgument='<%# Eval("SeasonID") %>'><%#Eval("Season") %></asp:LinkButton>,</li>                         
                      </ItemTemplate>
                  </asp:Repeater>
                  </ul>
                  <asp:SqlDataSource runat="server" ID="sdsSeasons" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' SelectCommand="SELECT Distinct Tbl_Seasons.SeasonID,Tbl_Seasons.Season FROM Tbl_Seasons INNER JOIN dbo.Tbl_Lookbooks ON dbo.Tbl_Lookbooks.CategoryID = Tbl_Seasons.SeasonID
WHERE Tbl_Lookbooks.BrandID=?">
                      <SelectParameters>
                          <asp:QueryStringParameter QueryStringField="v" Name="?"></asp:QueryStringParameter>
                      </SelectParameters>
                  </asp:SqlDataSource>
          </div>          
          <div class="lines"><hr /></div>
          
          <div class="col-md-8 col-xs-12 cheading">
             About
          </div>
          <div class="col-md-12 col-xs-12 ptext2">
           <asp:Label runat="server" ID="lblAbout"></asp:Label>
          </div>
          <div class="lines"><hr /></div>
          
          <div class="col-md-8 col-xs-12 cheading">
             On The Web
          </div>
          <div class="col-md-12 col-xs-12 ptext2">
            <asp:Repeater ID="Repeater2" runat="server" DataSourceID="sdsSocialLinks">
                      <ItemTemplate>
                           <a href="<%# Eval("FbURL") %>" target="_blank"><img src="../images/pfb.jpg" /></a>
                            <a href="<%# Eval("TwitterURL") %>" target="_blank"><img src="../images/ptw.jpg" /></a>
                            <a href="<%# Eval("InstagramURL") %>" target="_blank"><img src="../images/pins.jpg" /></a>                           
                      </ItemTemplate>
                  </asp:Repeater>
                  <asp:SqlDataSource runat="server" ID="sdsSocialLinks" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                      SelectCommand="SELECT FbURL,TwitterURL,InstagramURL From Tbl_Brands WHERE BrandID=?">
                      <SelectParameters>
                          <asp:QueryStringParameter QueryStringField="v" Name="?"></asp:QueryStringParameter>
                      </SelectParameters>
                  </asp:SqlDataSource>  
          
         </div>
     </div><!--blockp-->
            <div class="col-md-9 col-xs-12">
            <div class="searchpro" style="background:#fff;padding-top:20px;">
                             <div class="serinputp">
                                 <span class="fa fa-search"></span>
                                <asp:TextBox runat="server" ID="txtsearch" placeholder="Search" value="" class="sein1" OnTextChanged="txtsearch_TextChanged"></asp:TextBox>
                             </div> <!--serinput-->
                       </div><!--searchpro-->
              
            <div class="discoverbn">     
           
            <div id="contentbox">
                <div id="divAlerts" runat="server" class="alert" visible="False">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                        Text="" Visible="True"></asp:Label>
                </div>
                <asp:Repeater runat="server" ID="rptLookbook" DataSourceID="sdsLookbooks" OnItemDataBound="rptLookbook_ItemDataBound">
                    <ItemTemplate>
                        <div class="box">
                            <div class="disblock">
                                <a href="../lightbox_comments/?v=<%# Eval("LookID") %>" class="fancybox">
                                    <div class="dbl">
                                        <div class="hover ehover13">
                                            <img class="img-responsive" src="../imgSmall/<%# Eval("MainImg") %>" alt="<%# Eval("Title","{0}") %>" /><div class="overlay">
                                                <h2 class="titlet"><%# Eval("Title","{0}") %></h2>
                                                <h2 class="linenew"></h2>
                                                <h2><asp:Label runat="server" ID="lblDate" Text='<%# Eval("DatePosted") %>'></asp:Label></h2>
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
                                        <div class="mtextb" style="width:75%; margin-left:15px;">
                                            <div class="m1">
                                                <div class="muserd"> <a href="../lightbox_comments/?v=<%# Eval("LookID") %>" class="fancybox"><%# Eval("Title","{0}") %></div>
                                                <div class="muserdb">By <%# Eval("Name","{0}") %></div>
                                            </div>
                                            <div class="m1">
                                                <div class="mtextd"><%# Eval("Description","{0}") %></div>
                                            </div>
                                            <div class="m1" style="margin-left:-20px;">
                                                <div class="vlike">
                                                    <img src="../images/views.png" />
                                                    &nbsp;<%# Eval("Views") %></div>
                                                <div class="vlike">
                                                    <img src="../images/liked.png" />
                                                    &nbsp;<asp:Label runat="server" ID="lblLikes" Text='<%# Eval("LookID") %>'></asp:Label>
                                                </div>
                                                <div class="mdaysd">
                                                    <asp:Label runat="server" ID="lblDate2"><%# Eval("DatePosted") %></asp:Label></div>
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
Where dbo.Tbl_Brands.BrandID=? AND dbo.Tbl_Lookbooks.IsDeleted IS NULL AND dbo.Tbl_Lookbooks.IsPublished=1
ORDER BY dbo.Tbl_Lookbooks.DatePosted DESC">
                    <SelectParameters>
                        <asp:QueryStringParameter QueryStringField="v" Name="?"></asp:QueryStringParameter>
                    </SelectParameters>
                </asp:SqlDataSource>
            </div><!--content-->
       
       <div id="contentbox">
           <div id="ajaxrequest"></div>
       </div>          
</div>
    </div><!--col-md-10 col-sm-12 col-xs-12-->   

            <!--text-->
           
        </ContentTemplate>
    </asp:UpdatePanel>   
</div><!--wrapperblock-->
    <div id="inline1" style="max-width:1100px; width:95%; display: none;">

     <div class="col-md-12">

        <div class="col-md-5"><img src="images/profileim.jpg" width="100%" /><br /><br /><img src="images/image2.jpg" width="100%" /> <br /><br /><img src="images/images6.jpg" width="100%" /><br /><br /><img src="images/images4.jpg" width="100%" /></div><!--5-->
        <div class="col-md-7"> 
           
           <div class="col-md-12">
                   <div class="col-md-8 col-xs-12">
                    <div class="liimg"><img class="img-circle" src="images/liimg.png" alt="image"/></div>
                   <div>
                    <div class="litext">Little Mistress               <div class="litext">Little Mistress</div>
                    <div class="ltext"><img src="images/views.png" /> 500 Views</div>
                    </div>
               </div>
               <div class="col-md-4 col-xs-12 addto">
                  <ul>
                    <li><a href="followers-page.html"><img src="images/fol.png" style="margin-right:6px;" /> FOLLOW</a></li>
                    <li><a href=""><img src="images/msg.png" style="margin-right:4px;" /> MESSAGE</a></li>
                    <li><a href=""><img src="images/add.png" style="margin-right:6px;" /> ADD TO</a></li>
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
               <img src="images/like.png" style="margin-right:6px;" /> Like (99)</a></div>
               <div class="col-md-4 lightch" style="border-right:#a8a8a8 solid 1px;" ><a href="profile-page-comments.html">
               <img src="images/comm.png" style="margin-right:6px;" /> Comment (24)</a></div>
               <div class="col-md-4 lightch"><a href="followers-page.html"><img src="images/star.png" style="margin-right:6px;"  /> Ratings (244)</a></div>
          </div><!--col-md-12-->  
        
        </div><!--7-->
  
     </div><!--12-->
     
</div><!--inline-->
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

</div><!--wrapper-->

<script src="../js/bootstrap.js"></script>
</form>

</body>
</html>
