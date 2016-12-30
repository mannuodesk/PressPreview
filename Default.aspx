<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>The Press Preview</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="css/custom.css"/>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
		<script type="text/javascript" src="js/surprise/supersized.3.2.7.min.js"></script>
		<script type="text/javascript" src="js/surprise/supersized.shutter.min.js"></script>

    <style>
 body {
    background: url(../images/landingimage.jpg) no-repeat top center fixed;
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
  
}
</style>
</head>

<body>
<!--
		<script type="text/javascript">

		    jQuery(function ($) {

		        $.supersized({

		            // Functionality
		            slideshow: 1,			// Slideshow on/off
		            autoplay: 1,			// Slideshow starts playing automatically
		            start_slide: 1,			// Start slide (0 is random)
		            stop_loop: 0,			// Pauses slideshow on last slide
		            random: 0,			// Randomize slide order (Ignores start slide)
		            slide_interval: 3000,		// Length between transitions
		            transition: 6, 			// 0-None, 1-Fade, 2-Slide Top, 3-Slide Right, 4-Slide Bottom, 5-Slide Left, 6-Carousel Right, 7-Carousel Left
		            transition_speed: 1000,		// Speed of transition
		            new_window: 1,			// Image links open in new window/tab
		            pause_hover: 0,			// Pause slideshow on hover
		            keyboard_nav: 1,			// Keyboard navigation on/off
		            performance: 1,			// 0-Normal, 1-Hybrid speed/quality, 2-Optimizes image quality, 3-Optimizes transition speed // (Only works for Firefox/IE, not Webkit)
		            image_protect: 1,			// Disables image dragging and right click with Javascript

		            // Size & Position						   
		            min_width: 0,			// Min width allowed (in pixels)
		            min_height: 0,			// Min height allowed (in pixels)
		            vertical_center: 1,			// Vertically center background
		            horizontal_center: 1,			// Horizontally center background
		            fit_always: 0,			// Image will never exceed browser width or height (Ignores min. dimensions)
		            fit_portrait: 1,			// Portrait images will not exceed browser height
		            fit_landscape: 0,			// Landscape images will not exceed browser width

		            // Components							
		            slide_links: 'blank',	// Individual links for each slide (Options: false, 'num', 'name', 'blank')
		            thumb_links: 1,			// Individual thumb links for each slide
		            thumbnail_navigation: 0,			// Thumbnail navigation
		            slides: [			// Slideshow Images
														{ image: 'http://presspreview.azurewebsites.net/images/landingimage1.jpg' }

		            ],

		            // Theme Options			   
		            progress_bar: 1,			// Timer for each slide							
		            mouse_scrub: 0

		        });
		    });

		</script>-->
        
        
        
        <div class="landingtopblock">
           <div style="margin:auto; float:left; width:50%;">
              <div class="logob"><a href="Default.aspx" style="font-size:22px; margin-top:40px;"><img src="images/logo.png" alt="thePRESSPreview" style="width: 200px; margin-top: 10px;"/></a></div>
              <%--<div class="logos"><a href="Default.aspx">Logo Branding</a></div>--%>
           </div>  
              
              <div class="signinb"><a href="login.aspx">Sign In</a></div>
       </div>   
       
       
       
        <div class="landingtopblock1">
          <div class="landingtext" style="margin-bottom:40px;">
                WELCOME TO<br/>THE PRESS PREVIEW
             <span class="lanstext"></div>
             <div class="landgingbutton"><a href="login.aspx">Join the PRESS Preview</a></div>
          </div>
       </div>       
        
        
        
        
        
        
        

</body>
</html>

