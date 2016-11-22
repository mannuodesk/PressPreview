<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Brand_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Brand Home</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
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
<script type = "text/javascript" >
    function preventBack() { window.history.forward(); }
    setTimeout("preventBack()", 0);
    window.onunload = function () { null };
</script>
</head>

<body>

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
              <div class="logob"><a href="../Default.aspx"><img src="../images/logo.png" alt="thePRESSPreview"/></a></div>
                <!--#INCLUDE FILE="../includes/logo2.txt" -->
            </div>  
          </div>
          <div id="navbar" class="navbar-collapse collapse">
                <!--#INCLUDE FILE="../includes/messgTop.txt" -->            
         <div class="col-md-3"></div> 
             <ul class="nav navbar-nav" id="firstbb">
              <li><div class="gab1"></div></li>
              <li class="dropdown">
                <a href="events.aspx">Events</a>
              </li>
              
              <li class="dropdown">
                     <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Create</a>
                 <ul class="dropdown-menu">
                  <li><a href="add-item.aspx"><img src="" /><span class="sp"> Item</span></a></li>
                  <li><a href="profile-page-lookbooks.aspx"><img src="" /><span class="sp"> Lookbook</span></a></li>
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
     <!--#INCLUDE FILE="../includes/banner.txt" --> 
<!--bannerend-->


<!--text-->
<div class="wrapper">
<div class="col-md-12">
    <div id="divAlerts" runat="server" class="alert" visible="False">
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <asp:Label runat="server" ID="lblStatus" for="PageMessage"
            Text="" Visible="True"></asp:Label>
    </div>
      <div class="starter-template">
        <h6><br />Our's PICKS</h6>
        <h1> This Weeks Picks </h1>
        <div class="sline"><img src="../images/line.png" /></div>
      </div>
</div><!--col-md-10-->
</div><!--wrapperblock-->
<!--text-->  


    <!-- START THE FEATURETTES -->

         <div class="col-md-12">
           <div class="row featurette">
               <asp:Repeater ID="rptFeatured1" runat="server">
                   <ItemTemplate>
                       <div class="col-md-6 col-sm-6 col-xs-12">
                 <div class="hover ehover13">
					<img class="featurette-image img-responsive center-block" src='<%# Eval("MainImg","../imgLarge/{0}") %>' alt="">
						<div class="overlay">
							<h2><%# Eval("Name","{0}") %> (Author)</h2>
							<h4><a href="../lightbox/?v=<%# Eval("LookID") %>" class="fancybox"><%# Eval("Title","{0}") %></a>h4>
                            <h2 class="linenew"></h2>
							<h2><%# Eval("DatePosted","{0}") %></h2>
						</div><!--overlay-->				
				</div><!--hover ehover13-->
              </div>
                   </ItemTemplate>
               </asp:Repeater>
              <!--col-md-6-->
              <!--col-md-6-->
          </div><!--<!--row featurette-->
         </div><!--col-md-12-->
     <!-- /END THE FEATURETTES -->
     
     
     <!-- START THE FEATURETTES -->
         <div class="col-md-12">
           <div class="row featurette">
               <asp:Repeater ID="rptFeatured2" runat="server">
                   <ItemTemplate>
                       <div class="col-md-4 col-sm-6 col-xs-12 homelist">
                           <div class="hover ehover13">
                               <img class="img-responsive" src='<%# Eval("MainImg","../imgMedium/{0}") %>' alt="">
                               <div class="overlay">
                                   <h2><%# Eval("Name","{0}") %> (Author)</h2>
                                   <h3><a href="../lightbox/?v=<%# Eval("LookID") %>" class="fancybox"><%# Eval("Title","{0}") %></a></h3>
                                   <h2 class="linenew"></h2>
                                   <h2><%# Eval("dated","{0}") %></h2>
                               </div>
                               <!--overlay-->
                           </div>
                           <!--hover ehover13-->
                       </div><!--col-md-4 col-sm-6 col-xs-12-->
                       
                   </ItemTemplate>
               </asp:Repeater>
                          
             <div id="ajaxrequest"></div>
              
          </div><!--<!--row featurette-->
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

</div><!--wrapper-->

<script src="../js/bootstrap.js"></script>


</body>
</html>
