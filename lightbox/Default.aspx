<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeFile="Default.aspx.cs" Inherits="home" %>

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
         
    </script>  
     
    
</head>

<body>
<form runat="server" id="frmBrands">
      <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
                        </asp:ScriptManager>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server" >
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <div id="dvLoading"></div>
                </ProgressTemplate>

            </asp:UpdateProgress>
            <div id="inline1" style="max-width: 1100px; width: 100%;">

                <div class="lightboxheaderblock">
                    <div class="lightboxblockmain">
                        <div class="lightboxheaderimg">
                            <img class="img-responsive" src="../images/follo.png" /></div>
                        <!--lightboxheaderimg-->
                        <div class="lightboxheadertext"><asp:Label runat="server" ID="lblLookbookName"></asp:Label></div>
                        <!--lightboxtext-->
                        <div class="lightboxheadertext1">
                            <a href="">
                                <img src="../images/views.png" />
                                &nbsp; <asp:Label runat="server" ID="lblTotalViews"></asp:Label> Views</a>
                            <a href="">
                                <img src="../images/msg.png" />
                                &nbsp; MESSAGE</a>
                            <a href="">
                                <img src="../images/fol.png" />
                                &nbsp; FOLLOW</a>
                        </div>
                        <!--lightboxtext1-->
                    </div>
                    <!--lightboxblockmain-->

                    <div class="lightboxblockmain1">
                        <div class="lightboxeditbutton"><a href=""><i class="fa fa-pencil"></i>Edit profile</a></div>
                        <!--lightboxeditbutton-->
                    </div>
                    <!--lightboxblockmain-->
                </div>
                <!--lightboxheaderblock-->
                <div id="divAlerts" runat="server" class="alert" visible="False">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                        Text="" Visible="True"></asp:Label>
                </div>

                <div class="lightboxmaintext">
                    <div class="lightboxtextm"><asp:Label runat="server" ID="lblLbDescription"></asp:Label> </div>
                </div>
                <!--lightboxmaintext-->
                <asp:Repeater runat="server" ID="rptLbItems">
                    <ItemTemplate>
                        <div class="lightboxmaintext">
                            <div class="col-md-7">
                                <img src="../photobank/<%# Eval("Image") %>" width="100%" />
                            </div>
                            <!--5-->
                            <div class="col-md-5">
                                <div class="lightboxpicdata">
                                    <%-- <div class="lightboximgtitle">First Item's Title Name</div>--%>
                                    <asp:Label runat="server" ID="lblItemDecription" Text='<%# Eval("ItemDescription") %>'></asp:Label>
                                </div>
                            </div>
                            <!--7-->
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <!--lightboxmaintext-->


                
                <div class="lightboxsecondblock">

                    <div class="col-md-8" style="margin-top: 30px; background: #FFF;">
                        <div class="col-md-12 commheading">Comments - (<asp:Label runat="server" ID="lblTotalComments" Text="10"></asp:Label>)</div>
                        <div class="col-md-12" style="margin-top: 20px;">
                            <div class="col-md-2">
                                <img src="../images/follo.png" /></div>
                            <div class="col-md-10">
                                <textarea runat="server" placeholder="Leave A Comments" class="textanew" name="texta" id="txtComment"></textarea>
                            </div>
                            <div class="lightboxblockmain2">
                                <div class="lightboxeditbutton"><asp:LinkButton runat="server" type="submit" ID="btnPostComment" onserverclick="btnPostComment_ServerClick">Post a Comment</asp:LinkButton></div>
                                <!--lightboxeditbutton-->
                            </div>
                            <!--lightboxblockmain-->
                        </div>
                        <!--col-md-12-->

                        <div class="col-md-12" style="margin: 0 0 20px 0; float: left; width: 100%; border-bottom: #a8a8a8 solid 1px;"></div>
                        <div class="col-md-12">
                            <div class="col-md-2" id="comimg"><a href="">
                                <img class="img-circle" src="images/comimg.png" alt="image" style="margin-top: 6px;" /></a></div>
                            <div class="col-md-10">
                                <span class="commh"><a href="">Caroline K. Colon</a>
                                    <br />
                                </span>
                                <span class="commtext">Proin vel tellus quis erat luctus suscipit a vitae enim. Maecenas non leo eu risus elementum consequat et sit amet nisl. Nunc ornare diam nec augue luctus, ac tempor nulla cursus.</span>
                                <div class="col-md-12 reply">
                                    <img src="../images/reply.png" /></div>
                            </div>
                        </div>
                        <!--col-md-12-->
                    </div>
                    <!--7-->


                    <div class="col-md-4">

                        <div class="dissp1"></div>
                        <div class="discrigblock">
                            <div class="searchb">
                                <div class="serheading" style="margin-bottom: 20px;">Like this Item</div>

                                <div class="biglike">
                                    <asp:LinkButton runat="server" ID="lbtnLike" OnClick="lbtnLike_Click">
                                        <img src="../images/biglike.png" />
                                        Likes (<asp:Label runat="server" ID="lblTotalLikes"></asp:Label>)</asp:LinkButton>
                                </div>

                            </div>
                        </div>

                        <div class="dissp1"></div>
                        <!--tags-->
                        <div class="discrigblock">
                            <div class="searchb">
                                <div class="serheading" style="margin-bottom: 20px;">Related Tags</div>

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

                            </div>
                            <!--search-->

                            <div class="fewer" onclick="showtags()">See fewer tags</div>
                            <div class="fewerf" onclick="showtagsf()" style="display: none;">See full tags</div>
                        </div>
                        <!--colmd12-->
                        <div class="dissp"></div>
                    </div>
                    <!--3-->

                </div>
                <!--lightboxsecondblock-->

                <div id="demo">
                    <section id="examples">
                        <div class="content mCustomScrollbar">
                        </div>
                    </section>
                </div>
            </div><!--inline-->
           
        </ContentTemplate>
    </asp:UpdatePanel>   
<!--footer-->
    <div class="footerbg">
        <div class="row">
            <div class="col-md-11 col-xs-10">©<%: DateTime.Now.Year %> Press Preview</div>
            <div class="col-md-pull-1 col-xs-pull-1">
                <div class="f1"><a id="loaddata">
                    <img src="../images/footerarrow.png" /></a></div>
                <div class="f2">
                    <a id="loaddatan">Expand</a></div>
                </div>
            </div>
        </div>
    </div><!--footer-->
<!--footer-->

<!--wrapper-->

<script src="../js/bootstrap.js"></script>
</form>

</body>
</html>
