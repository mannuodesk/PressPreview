<%@ Page Language="C#" AutoEventWireup="true" CodeFile="item_view.aspx.cs" Inherits="lightbox_item_view" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>PR::View Item</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<!--lightbox-->
	<script type="text/javascript" src="../source/jquery.fancybox.js?v=2.1.5"></script>
	<link rel="stylesheet" type="text/css" href="../source/jquery.fancybox.css?v=2.1.5" media="screen" />
<script src="../ckeditor/ckeditor.js"></script>
<script src="../js/sample.js"></script>
<script type="text/javascript">
    jQuery(document).ready(function () {
        jQuery('.fancybox').fancybox();
    });
	</script>
</head>
<body>
    <form id="form1" runat="server">
   <div id="inline1" style="max-width:1150px; width:100%;">

      <div class="lightboxheaderblock">
        <div class="lightboxblockmain">
          <div class="lightboxheaderimg"><img class="img-responsive" src="../images/follo.png" /></div><!--lightboxheaderimg-->
          <div class="lightboxheadertext">Itme Name Goes Here</div><!--lightboxtext-->
          <div class="lightboxheadertext1">
                  <div class="lightb"><i class="fa fa-eye" aria-hidden="true"></i> &nbsp; 500 Views</div>
                  <a href="#"><i class="fa fa-heart" aria-hidden="true"></i> &nbsp; Message</a>
                  <div class="lightb1"><i class="fa fa-plus-circle" aria-hidden="true"></i> &nbsp; Wishlist</div>
          </div><!--lightboxtext1-->
        </div><!--lightboxblockmain--> 
         

<div class="lightboxblockmain1">
          <ul class="nav navbar-nav" id="firstbb">
              <li class="dropdown">
                 <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                 <i class="fa fa-gift" aria-hidden="true"></i> Get A Gift </a>
                 <ul class="dropdown-menu" style="margin-top:-1px;">
                  <li><form action="">
                        <textarea class="texarea" placeholder="Leave a comment"></textarea>
                        <input type="submit" class="textsub" value="Request" />
                    </form></li>
                </ul>
              </li>
              
              
              <li class="dropdown">
                 <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                 <i class="fa fa-tags" aria-hidden="true"></i> Request Sample</a>
                 <ul class="dropdown-menu" style="margin-top:-1px;">
                  <li><form action="">
                        <textarea class="texarea" placeholder="Leave a comment"></textarea>
                        <input type="submit" class="textsub" value="Request" />
                    </form></li>
                </ul>
              </li>
              
           </ul>   
</div><!--lightboxblockmain--> 

        
        
        
<div class="lightboxblockmain1m">
<ul class="nav navbar-nav" id="firstbb">
              <li class="dropdown" style="width:100%;">
                 <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                 <i class="fa fa-gift" aria-hidden="true"></i> Get A Gift </a>
                 <ul class="dropdown-menu" style="margin-top:-1px; width:100%; height:100%">
                  <li><form action="">
                        <textarea class="texarea" placeholder="Leave a comment"></textarea>
                        <input type="submit" class="textsub" value="Request" />
                    </form></li>
                </ul>
              </li>
              
              
              <li class="dropdown" style="width:100%;">
                 <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                 <i class="fa fa-tags" aria-hidden="true"></i> Request Sample</a>
                 <ul class="dropdown-menu" style="margin-top:-1px; width:100%; height:100%">
                  <li><form action="">
                        <textarea class="texarea" placeholder="Leave a comment"></textarea>
                        <input type="submit" class="textsub" value="Request" />
                    </form></li>
                </ul>
              </li>
              
           </ul>   
     </div><!--lightboxblockmain--> 
      </div>  
    
    
    <div class="lightboxmaintext" >
         <div class="col-md-7 col-xs-12 prolightimg" >
             <a href="#"><img src="../images/proimg1.png" width="100%" /><br /></a>
             <a href="#"><img src="../images/proimg1.png" width="100%" /><br /></a>
             <a href="#"><img src="../images/proimg1.png" width="100%" /><br /></a>
         </div><!--col-md-7-->
         
         <div class="col-md-5 col-xs-12" >
         
         
                  <div class="discrigblock">
                    <div class="searchb">
                     <div class="serheading1">Like this Item</div> 
                     
                       <div class="biglike">
                           <a href="#"><i class="fa fa-heart" aria-hidden="true" id="round"></i>  Likes (245)</a>
                       </div>
                       
                    </div> 
                  </div> 
                  
                  <div class="dissp1"></div>
                  
                  
             <!--basic ino-->     
                <div class="discrigblock">
                  <div class="searchb"><div class="serheading1">Basic Info</div> </div>
                  <div class="lightboxpicdata"> 
                      Little Mistress Heavily Embellished<br />
                      Gold and Black Bandeau Maxi Dress<br /><br />
                      code: AW15-AAD053-24<br /><br />
                      Item: 39970281<br /><br />
                      A maxi bandeau dress with heavily<br />
                      embellished art deco black sequins. <br />
                      Model wears a size 10.<br />
                      REF: L673D1A<br />
                      Product Care<br />
                      Material: Outer: 100% polyester<br />
                      Hand wash only /do not tumble dry/<br />
                      iron on reverse side/ do not dry clean<br />
               </div></div>
           <div class="dissp1"></div>  
           
           
           
           <!--stylenumber-->     
                <div class="discrigblock">
                 
                 <div class="rpri">
                     <div class="searchb"><div class="serheading1">Retail Price</div> 
                        <div class="lightbtext">$350.00</div>
                     </div>
                 </div>    
                     
                 <div class="rpri1">
                     <div class="searchb"><div class="serheading1">Wholesale Price</div> 
                        <div class="lightbtext">$200.00</div>
                     </div>
                 </div>   
                     
                </div>
           <div class="dissp1"></div>      
           
           
           <!--stylenumber-->     
                <div class="discrigblock">
                     <div class="searchb"><div class="serheading1">Style Number</div> 
                        <div class="lightbtext">#40127391</div>
                     </div>
                     

                </div>
           <div class="dissp1"></div>    
           
           
            <!--stylename-->     
                <div class="discrigblock">
                     <div class="searchb"><div class="serheading1">Style Name</div> 
                      <div class="lightbtext">Silk/Green/Olive</div>
                     </div>
                </div>
           <div class="dissp1"></div>    
           
           
            <!--tags-->     
                <div class="discrigblock">
                         <div class="searchb">
                             <div class="serheading1">Related Tags</div> 
                             
                             <div class="serheading1">
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
                             
                            <div id="tagfewer11">
                             <div class="tagblock"><a href="">Name</a></div>
                             <div class="tagblock"><a href="">Long Name</a></div>
                             <div class="tagblock"><a href="">Name</a></div>
                             <div class="tagblock"><a href="">NA</a></div>
                             <div class="tagblock"><a href="">NA</a></div>
                             <div class="tagblock"><a href="">1</a></div>
                             <div class="tagblock"><a href="">Name</a></div>
                             <div class="tagblock"><a href="">Tag Name</a></div>
                             <div class="tagblock"><a href="">1</a></div>
                             <div class="tagblock"><a href="">2</a></div>
                            </div>
                          </div>  
                             
                         </div><!--search-->
                         
                         
                       <div class="serheading1">
                         <div class="fewer" onclick="showtags11()">See fewer tags</div>
                         <div class="fewerf" onclick="showtagsf11()" style="display:none;">See full tags</div>
                       </div>  
                </div>
               <div class="dissp1"></div>  
               
               
               <!--comments-->
                <div class="discrigblock">
                    <div class="searchb">
                     <div class="serheading1">Comments - (24)</div> 
                     
                 <div class="col-md-12" style="margin-top:20px;">
                    <div class="col-md-2"><img src="../images/follo.png" /></div>
                    <div class="col-md-10">
                        <textarea placeholder="Leave A Comments" class="textanew" name="texta" id="texta"></textarea>
                    </div> 
                    <div class="lightboxblockmain2">
                        <div class="lightboxeditbutton"><a href="">Post a Comment</a></div><!--lightboxeditbutton-->
                    </div><!--lightboxblockmain-->    
                </div><!--col-md-12-->
                
                <div class="col-md-12" style="margin:30px 0 30px 0; float:left; width:100%; border-bottom:#dadbdd solid 3px;"></div>   
          
              <div class="col-md-12">
                      <div class="col-md-2" id="comimg"><a href=""><img class="img-circle" src="../images/comimg.png"   alt="image" style="margin-top:6px;"/></a></div>
                      <div class="col-md-10">
                          <span class="commh"><a href="">Caroline K. Colon</a> <br /></span>
                          <span class="commtext">Proin vel tellus quis erat luctus suscipit a vitae enim. Maecenas non leo eu risus elementum consequat et sit amet nisl. Nunc ornare diam nec augue luctus, ac tempor nulla cursus.</span>
                          <div class="col-md-12 reply"><img src="../images/reply.png" /></div>
                      </div>
              </div><!--col-md-12--> 
              
              <div class="col-md-11" style="margin-left:40px;">
                      <div class="col-md-2" id="comimg"><a href=""><img class="img-circle" src="../images/comimg.png"   alt="image" style="margin-top:6px;"/></a></div>
                      <div class="col-md-10">
                          <span class="commh"><a href="">Caroline K. Colon</a> <br /></span>
                          <span class="commtext">Nunc ornare diam nec augue luctus, ac tempor nulla cursus. </span>
                          <div class="col-md-12 reply"><img src="../images/reply.png" /></div>
                      </div>
              </div><!--col-md-12--> 
              
              <div class="col-md-12">
                      <div class="col-md-2" id="comimg"><a href=""><img class="img-circle" src="../images/comimg.png"   alt="image" style="margin-top:6px;"/></a></div>
                      <div class="col-md-10">
                          <span class="commh"><a href="">John Doe</a> <br /></span>
                          <span class="commtext">Proin vel tellus quis erat luctus suscipit a vitae enim. Maecenas non leo eu risus elementum consequat et sit amet nisl. Nunc ornare diam nec augue luctus, ac tempor nulla cursus.</span>
                          <div class="col-md-12 reply"><img src="../images/reply.png" /></div>
                      </div>
              </div><!--col-md-12--> 
              
              <div class="col-md-12">
                      <div class="col-md-2" id="comimg"><a href=""><img class="img-circle" src="../images/comimg.png"   alt="image" style="margin-top:6px;"/></a></div>
                      <div class="col-md-10">
                          <span class="commh"><a href="">John Doe</a> <br /></span>
                          <span class="commtext">Proin vel tellus quis erat luctus suscipit a vitae enim. Maecenas non leo eu risus elementum consequat et sit amet nisl. Nunc ornare diam nec augue luctus, ac tempor nulla cursus.</span>
                          <div class="col-md-12 reply"><img src="../images/reply.png" /></div>
                      </div>
              </div><!--col-md-12--> 
                       
                    </div> 
                  </div> 
                  
                  <div class="dissp1"></div>  

         </div><!--col-md-5-->
    </div><!--lightboxmaintext--> 
</div>
    </form>
      <!-- Javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="../js/bootstrap.js"></script>
    <script src="../masonry/js/libs/imagesloaded.3.1.8.min.js"></script>
    <script src="../masonry/js/libs/jquery.masonry.3.2.1.min.js"></script>
    <script src="../masonry/js/base1.js" type="text/javascript"></script>


	<script>	    window.jQuery || document.write('<script src="customscroller/jquery-1.11.0.min.js"><\/script>')</script>
	<!-- custom scrollbar plugin -->
	<script src="../customscroller/jquery.mCustomScrollbar.concat.min.js"></script>
    <script>
        jQuery(".menudli1st1").click(function (e) {
            e.stopPropagation();
            jQuery(".menudli1st1_list").not(jQuery(this).next()).hide();
            jQuery(this).next().toggle();

        });
        jQuery(".menudli1st1_list").find("li").click(function (e) {
            e.stopPropagation();
            alert(jQuery(this).text());
        });
        jQuery(document).click(function (e) {

            jQuery(".menudli1st1_list").hide();
        });
</script>
<script type="application/javascript" src="../js/custom.js"></script>
</body>
</html>
