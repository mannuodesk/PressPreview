
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="pr_brand_myprofile" %>
<%@ Register TagPrefix="cc1" Namespace="CS.WebControls" Assembly="CS.WebControls.WebCropImage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Change Cover Image</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../css/checkbox.css"/>
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="../js/modernizr.custom.79639.js"></script> 
<link href="../css/jquery.jcrop.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery.Jcrop.min.js" type="text/javascript"></script>
<script type="text/javascript">
    function previewFile() {
        var preview = document.querySelector('#<%=imgMain.ClientID %>');
        var file = document.querySelector('#<%=fupCover.ClientID %>').files[0];
        var reader = new window.FileReader();

        reader.onloadend = function () {
            preview.src = reader.result;
        };
        if (file) {
            reader.readAsDataURL(file);
        } else {
            preview.src = "";
        }
    }
    </script>

</head>

<body>
<form runat="server" ID="frm_Profile">
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
              <div class="logob"><a href="">Press Preview</a></div>
              <div class="logos"><a href="">Logo Branding</a></div>
            </div>  
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            
            
         <div class="col-md-4">   
            <ul class="nav navbar-nav" id="firstb">
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><img src="images/menumail.png" /></a>
                <ul class="dropdown-menu"  id="emailblock"><li><a href="">
                      <div class="mesb">
                        <div class="mtext3">Your Messages</div> 
                        <div class="mtext2"> | &nbsp; Compose</div>
                       </div> 
                   </a></li>
                  <li role="separator" class="divider"></li>
                  
                  
                  <li><a href="#">
                      <div class="mesb">
                          <div class="mimageb"><div class="mimg"><img src="../images/comimg.png" /></div></div><!--mimageb-->
                          <div class="mtextb">
                             <div class="m1">
                               <div class="muser">User Name</div> 
                                <div class="mdays">2 days</div>
                             </div>
                             <div class="m1">
                                <div class="mtext">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</div>
                             </div>
                             <div class="m1"></div>
                          </div><!--mtextb-->
                      </div><!--mseb-->
                  </a></li>
                  
                  <li><a href="#">
                      <div class="mesb">
                          <div class="mimageb"><div class="mimg"><img src="../images/comimg.png" /></div></div><!--mimageb-->
                          <div class="mtextb">
                             <div class="m1">
                               <div class="muser">User Name</div> 
                                <div class="mdays">14 days</div>
                             </div>
                             <div class="m1">
                                <div class="mtext">Morbi id justo eu lacus molestie tempor a lacus. Suspendisse non justo ut ante sol...</div>
                             </div>
                             <div class="m1"></div>
                          </div><!--mtextb-->
                      </div><!--mseb-->
                  </a></li>
                  
                  <li><a href="#">
                      <div class="mesb">
                          <div class="mimageb"><div class="mimg"><img src="../images/comimg.png" /></div></div><!--mimageb-->
                          <div class="mtextb">
                             <div class="m1">
                               <div class="muser">User Name</div> 
                                <div class="mdays">13 days</div>
                             </div>
                             <div class="m1">
                                <div class="mtext">Vestibulum mattis est ligula, eget tempus magna elementum sed.</div>
                             </div>
                             <div class="m1"></div>
                          </div><!--mtextb-->
                      </div><!--mseb-->
                  </a></li>
                  
                  <li><a href="#">
                      <div class="mesb">
                          <div class="mimageb"><div class="mimg"><img src="../images/comimg.png" /></div></div><!--mimageb-->
                          <div class="mtextb">
                             <div class="m1">
                               <div class="muser">User Name</div> 
                                <div class="mdays">12 days</div>
                             </div>
                             <div class="m1">
                                <div class="mtext">ed eleifend quam fermentum, interdum orci sed, sagittis arcu. Donec lacinia aug...</div>
                             </div>
                             <div class="m1"></div>
                          </div><!--mtextb-->
                      </div><!--mseb-->
                  </a></li>
                  <li role="separator" class="divider"></li>
                  
                  <li><a href=""><div class="mtext1">See All Messages <img src="../images/seeall.png" /></div></a></li>
                  
                </ul>
              
              <li class="dropdown" style="margin-top:-5px;">
                <a href="#"><img src="../images/alram.png" /></a>
              </li>
            </ul>
         </div>   
            <ul class="nav navbar-nav" id="firstbb">
              <li><a href="Default.aspx">Activity</a></li>
              <li><a href="discover.aspx">Discover</a></li>
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


<!--text-->
<div class="wrapperblockedit">

<!--Banner-->
    <div class="">
        <a href=""><asp:Image runat="server" Id="imgCover" class="img-responsive" src="../images/bggreyi.jpg"  alt="profileimage" style="width:100%" /></a>
       
    </div>
<!--bannerend-->


     <div class="remainblock">
         
          <%-- <input type="file" id="fupCover" runat="server" name="files" title="Load File"  style="margin-top:-23px;"   />--%>
          <div class="replaytext"> <a href="../lightbox/CoverPic.aspx"  class="fancybox"><img src="../images/replaceimage.png" /></a></div><div class="lines"><hr /></div>
          <div class="replaimg"><a href=""><asp:Image ID="imgProfile"  ImageUrl="../images/follo.png" runat="server" style="border-radius:50%;"/></a></div>
          <div class="replaimg"><a href="../lightbox/ProfilePic.aspx"  class="fancybox"><img  src="../images/replaceimage1.png" /></a></div>
          <div class="lines"><hr /></div>
          
        
             
             
          </div><!--likeblock-->
        
   <div class="remainblock1">
      <div class="wrapreblock">
      
      <div class="reblockadd">
        <div class="textforget">Upload Cover Photo</div> 
        <div id="divAlerts" runat="server" class="alert" visible="False">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                Text="" Visible="True"></asp:Label> 
        </div>    
      </div>
     
     
      <div class="reblockadd1">
       <div class="col-md-12" >
               
                    <div class="col-md-12" style="margin-top: 30px; background: #FFF;">
                        <div class="col-md-12 commheading"><span class="danger">Note:</span> Required image size is 1300 x 300 </div>
                        <div class="col-md-12" style="margin-top: 20px;">
                            
                            <div class="col-md-6">
                                <asp:FileUpload ID="fupCover"  runat="server" onchange="previewFile()"  CssClass="form-control"></asp:FileUpload>
                            </div>
                            <div class="col-md-4">
                                <div class="lightboxblockmain2">
                                <div class="lightboxeditbutton">
                                    <asp:LinkButton runat="server" ID="btnUpload" OnClick="btnUpload_OnClick">Upload</asp:LinkButton>
                                    <asp:LinkButton runat="server" ID="btnSave" OnClick="btnSave_OnClick" 
                                        Visible="False">Crop & Save</asp:LinkButton>
                                </div>
                                <!--lightboxeditbutton-->
                            </div>
                            </div>
                            
                        </div>
                        <!--col-md-12-->

                        <div class="col-md-12" style="margin: 0 0 20px 0; float: left; width: 100%; border-bottom: #a8a8a8 solid 1px;">
                            <asp:Image runat="server" ID="imgMain" ImageUrl=""/>
                            <cc1:WebCropImage ID="WebCropImage2" runat="server" CropButtonID="btnSave" CropImage="imgMain"
                                                        CssClass="jquery.jcrop.css" H="150" IncludeJQuery="true" MaxSize="1300,300" MinSize="1300,300"
                                                        ScriptPath="~/js/" Style="position: relative" ToolTip="Resize the image"
                                                        W="1300" />
                           
                        </div>
                        
                        <!--col-md-12-->
                    </div>
                    <!--7-->
                    
                    <!--3-->
           
           
       </div>   
      </div>
      
   </div></div><!--col-md-10 col-sm-12 col-xs-12-->      
          
          
     </div><!--col-md-3 col-xs-12-->
     

  
   
   
       
</div><!--wrapperblock-->
<!--text-->  


<!--footer-->
  <div class="footerbg">
     <div class="row">
        <div class="col-md-11 col-xs-10">©2016 Press Preview</div>
        <div class="col-md-pull-1 col-xs-pull-1">
           <div class="f1"><a href=""><img src="images/footerarrow.png" /></a></div>
           <div class="f2"><a href="">EXPAND</a></div>
        </div>
      </div>    
  </div><!--footer-->
<!--footer-->

</div><!--wrapper-->

    <!-- Javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="../js/bootstrap.js"></script>
    <script src="../masonry/js/libs/imagesloaded.3.1.8.min.js"></script>
    <script src="../masonry/js/libs/jquery.masonry.3.2.1.min.js"></script>
    <script src="../masonry/js/base.js" type="text/javascript"></script>
    		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    		<script type="text/javascript">

    		    function DropDown(el) {
    		        this.dd = el;
    		        this.initEvents();
    		    }
    		    DropDown.prototype = {
    		        initEvents: function () {
    		            var obj = this;

    		            obj.dd.on('click', function (event) {
    		                jQuery(this).toggleClass('active');
    		                event.stopPropagation();
    		            });
    		        }
    		    }

    		    jQuery(function () {

    		        var dd = new DropDown($('#dd'));

    		        jQuery(document).click(function () {
    		            // all dropdowns
    		            jQuery('.wrapper-dropdown-5').removeClass('active');
    		        });

    		    });

    		    jQuery(function () {

    		        var dd = new DropDown(jQuery('#dd1'));

    		        jQuery(document).click(function () {
    		            // all dropdowns
    		            jQuery('.wrapper-dropdown-5').removeClass('active');
    		        });

    		    });

		</script>
        <script type="application/javascript" src="../js/custom.js"></script>
        <script type="text/javascript">
            function openfileDialog() {
                $("#fupCover").click();
            }

            function openprofilePicDialog() {
                $("#fupCover").click();
            }

            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new window.FileReader();
                    reader.onload = function(e) {
                        $('#blah')
                            .attr('src', e.target.result)
                            .width('100%')
                            .height(200);
                    };

                    reader.readAsDataURL(input.files[0]);
                }
            }

            $("#fupCover").change(function () {
                readURL(this);
            });
        </script>
        


</form>
</body>
</html>
