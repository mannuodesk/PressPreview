<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="true" CodeFile="itemview2.aspx.cs" Inherits="lightbox_item_view" Async="true" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>PR::Influencer Item View</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
 <link href="../css/jquery-ui.css" rel="stylesheet" type="text/css" />
 <link href="../source/jquery.fancybox.css" rel="stylesheet" type="text/css" />
<script src="../ckeditor/ckeditor.js"></script>
  <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <style type="text/css">
        .liked{
            color:#4c92c6;
            display:block !important;
        }
        .unliked{
            color:#808080;
            display:block !important;
        }
             @media only screen and (max-width: 540px) {
               .lightboxblockmain{
                   width: 100% !important
               }
               .lightboxblockmain1m{
                       margin: 0px 20px 0 0 !important;
               }
           }
    </style>
<script type="text/javascript">
    function ChangeColor(val)
    {
        alert($('#Label200').val());
        if(val == "rgb(26, 26, 26)")
        {
            alert($('#lbtnLike').css('color','rgb(0, 0, 0)'));
        }
        else
        {
            $('#lbtnLike').css('color', '#4c92c6');
        }
    }
    $(document).ready(function () {
        $("#btnGetGift").on('click', function (e) {
            e.preventDefault();
            var v = '<%= Request.QueryString["v"] %>';
            var message = jQuery('#txtGift').val();
            // alert(message);
            $.ajax({
                type: "POST",
                url: "itemview2.aspx\\PostGiftRequest",
                contentType: "application/json; charset=utf-8",
                data: "{'message':'" + message + "', 'v':" + v + "}",
                dataType: "json",
                async: true,
                error: function (jqXhr, textStatus, errorThrown) {
                    // alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
                },
                success: function (msg) {
                    //                    if (msg.d == true) {

                    $('#dvmessage').show("slow");
                    $('#txtGift').val("");
                    jQuery('#req').hide();
                    setTimeout(function () { $('#dvmessage').fadeOut(); }, 4000);
                    return false;
                }
            });

        });

        $("#btnRequestSample").on('click', function (e) {
            e.preventDefault();
            var v = '<%= Request.QueryString["v"] %>';
            var message = jQuery('#txtSample').val();
            //  alert(message);
            $.ajax({
                type: "POST",
                url: "itemview2.aspx\\PostSampleRequest",
                contentType: "application/json; charset=utf-8",
                data: "{'message':'" + message + "', 'v':" + v + "}",
                dataType: "json",
                async: true,
                error: function (jqXhr, textStatus, errorThrown) {
                    // alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
                },
                success: function (msg) {
                    //                    if (msg.d == true) {

                    $('#dvmessage').show("slow");
                    $('#txtSample').val("");
                    jQuery('#req1').hide();
                    setTimeout(function () { $('#dvmessage').fadeOut(); }, 4000);
                    return false;
                }
            });

        });

        $("#lbtnWishList").on('click', function (e) {
            e.preventDefault();
            var v = '<%= Request.QueryString["v"] %>';
            var userId = '<%= Request.Cookies["FRUserId"].Value %>';
            //  alert(message);
            $.ajax({
                type: "POST",
                url: "itemview2.aspx\\AddToWishList",
                contentType: "application/json; charset=utf-8",

                data: "{'v':'" + v + "', 'userid':'" + userId + "'}",
                //data: "{'v':'" + v + "', 'userId':" + userId + "}",
                dataType: "json",
                async: true,
                error: function (jqXhr, textStatus, errorThrown) {
                    // alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
                },
                success: function (msg) {
                    //                    if (msg.d == true) {

                    $('#dvWmessage').show("slow");
                    $('#dvlbtnWishlist').hide();
                    $('#dvlbwishlist').show();
                    setTimeout(function () { $('#dvWmessage').fadeOut(); }, 4000);
                    return false;
                }
            });

        });
        jQuery('.mnLikes').live('mouseover', (function (e) {
            //                e.preventDefault();
            //                e.stopPropagation();

            jQuery(".menudlist_list").not(jQuery(this).next()).hide();
            jQuery(this).next().show();

        }));
        jQuery(".menudlist_list").find("li").live('click', (function (e) {
            // e.stopPropagation();
            // alert(jQuery(this).text());
        }));
        jQuery('.mnLikes').live('mouseout', (function (e) {
            jQuery(".menudlist_list").hide();
            jQuery("#menuPost").hide();

        }));
        $(".textsub").live('click', (function (e) {
            jQuery(".menudlist_list").hide();
        }));


    });

</script>
<script src="../js/sample.js"></script>
  <script language="JavaScript" type="text/javascript">
      function ToggleDisplay(id) {
          var elem = document.getElementById('d' + id);
          var replybutton = document.getElementById('b' + id);
          var replyimg = document.getElementById('h' + id);
          if (elem) {
              if (elem.style.display != 'block') {
                  elem.style.display = 'block';
                  elem.style.visibility = 'visible';
                  replybutton.style.display = 'block';
                  replybutton.visibility = 'visible';
                  // hide the reply image
                  replyimg.style.display = 'none';
                  replyimg.style.visibility = 'hidden';
              }
              else {
                  elem.style.display = 'none';
                  elem.style.visibility = 'hidden';
                  replybutton.style.display = 'none';
                  replybutton.visibility = 'hidden';
              }
          }
      }

      function showdeletebutton(id) {

          var m1 = document.getElementById('pm' + id);
          if (m1) {
              m1.style.display = 'block';
              m1.style.visibility = 'visible';
          }


      }

      function hidedeletebutton(id) {
          var m1 = document.getElementById('pm' + id);
          m1.style.display = 'none';
          m1.style.visibility = 'hidden';

      }

      function showreplyDelete(id) {
          var m1 = document.getElementById('cm' + id);
          if (m1) {
              m1.style.display = 'block';
              m1.style.visibility = 'visible';
          }
      }

      function hidereplyDelete(id) {
          var m1 = document.getElementById('cm' + id);
          if (m1) {
              m1.style.display = 'none';
              m1.style.visibility = 'hidden';
          }
      }

      function ToggleDisplayDeleteButton(id) {
          var elem = document.getElementById('pb' + id);

          if (elem) {
              if (elem.style.display != 'block') {
                  elem.style.display = 'block';
                  elem.style.visibility = 'visible';
              }
              else {
                  elem.style.display = 'none';
                  elem.style.visibility = 'hidden';
              }
          }
      }


  </script>
    <script type="text/javascript">
        function HideLabel() {
            setTimeout(function () { $('#divAlerts').fadeOut(); }, 4000);

        };
</script>

</head>
<body>
    <form id="form1" runat="server">
   <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True"  EnablePartialRendering="True">
                        </asp:ScriptManager>
   <asp:HiddenField ID="hidField" runat="server" />
 <div id="inline1" style="max-width:1150px; margin:0 auto;">
    <asp:updatepanel ID="Updatepanel1" runat="server" UpdateMode="Conditional">
     <ContentTemplate>
         <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                  <ProgressTemplate>
                     <div id="dvLoading" style="top: 115px; left: 60%;"></div>
                  </ProgressTemplate>

            </asp:UpdateProgress> 
            
            <script type="text/javascript" language="javascript">
                function pageLoad() {
                    setTimeout(function () { $('#divAlerts').fadeOut(); }, 4000);
                }
            </script>
      <div class="lightboxheaderblock" >
        <div class="lightboxblockmain" style="width:65%;">
          <div class="lightboxheaderimg"><asp:Image CssClass="img-responsive img-circle" runat="server" ID="imgProfile" ImageUrl="../images/follo.png" /></div><!--lightboxheaderimg-->
          <div class="lightboxheadertext" ><asp:Label runat="server" ID="lblItemTitle" Text="Item Name Goes Here"></asp:Label><asp:Label runat="server" ID="lblUserID" Visible="False"></asp:Label> 
              <asp:Label runat="server" ID="lblItemID" Visible="False"></asp:Label></div><!--lightboxtext-->
          <div class="lightboxheadertext1">
                  <div class="lightb"><i class="fa fa-eye" aria-hidden="true"></i> &nbsp; <asp:Label runat="server" ID="lblTotolViews" ></asp:Label> Views</div>
                  
                  <div class="lightb1">
                      <a href='itobmessage.aspx?v=<% Response.Write(Request.QueryString["v"]); %>' id="lbtnMessage"  class="fancybox" target="_top"><i class="fa fa-heart" aria-hidden="true"></i> &nbsp; Message</a>
                  </div>
                  <div class="lightb1" runat="server" ID="dvlbtnWishlist">
                        <label id="lbtnWishList"><i class="fa fa-plus-circle" aria-hidden="true"></i> &nbsp; Wishlist</label>
                       <%-- <asp:LinkButton runat="server" ID="lbtnWishList" OnClick="lbtnWishList_OnClick" Enabled="False">
                                       <i class="fa fa-plus-circle" aria-hidden="true"></i> &nbsp; Wishlist </asp:LinkButton>--%>
                       
                      
                  </div>
                  <div class="lblwishlist" runat="server" ID="dvlbwishlist">
                       <asp:Label runat="server" ID="lblWishlist">
                            <i class="fa fa-plus-circle" aria-hidden="true"></i> &nbsp; Wishlist
                        </asp:Label>
                  </div>
          </div><!--lightboxtext1-->
        </div><!--lightboxblockmain--> 
         

<div class="lightboxblockmain1m"  style="width:30%; margin: 60px 20px 0 0; display:block;">
    <ul class="navreq">
  <li class="button-dropdownreq">
    <a href="javascript:void(0)" class="dropdownreq-toggle" data-toggle="dropdownreq" role="button" aria-haspopup="true" aria-expanded="false">
                 <i class="fa fa-gift" aria-hidden="true"></i> Get A Gift </a>
    <ul class="dropdownreq-menu" id="req">
      <li>
        <a href="#">
            <form >
                    <textarea class="texarea" runat="server" ID="txtGift" placeholder="Leave a comment"></textarea>
                    <button type="button" id="btnGetGift" class="textsub" >Request</button>
                       <%-- <asp:Button runat="server" ID="btnGetGift" Text="Request" CssClass="textsub" OnClick="btnGetGift_OnClick" OnClientClick="hideRequestGift()"/>--%>
            </form>
        </a>
      </li>
      <li>
         <button class="textsub1" value="Cancel" onclick="callreq()" >Cancel</button>
      </li>
    </ul>
  </li>
  <li class="button-dropdownreq">
    <a href="javascript:void(0)" class="dropdownreq-toggle" data-toggle="dropdownreq" role="button" aria-haspopup="true" aria-expanded="false">
                 <i class="fa fa-tags" aria-hidden="true"></i> Request Sample</a>
    <ul class="dropdownreq-menu" id="req1" runat="server">
      <li>
        <a href="#">
           <%-- <form>--%>
                 <textarea class="texarea" runat="server" ID="txtSample" placeholder="Leave a comment"></textarea>
                 <button type="button" id="btnRequestSample" class="textsub" >Request</button>
               <%-- <asp:Button runat="server" ID="btnRequestSample" Text="Request" CssClass="textsub" OnClick="btnRequestSample_OnClick" OnClientClick="hideRequestSample()" />--%>
         <%-- </form>--%>
        </a>
      </li>
      <li>
         <button class="textsub1" value="Cancel" onclick="callreq1()" >Cancel</button>
      </li>
    </ul>
  </li>
</ul>
     
</div><!--lightboxblockmain--> 

        
        
        
<div class="lightboxblockmain1m"  style="display:none;">
<ul class="nav navbar-nav" id="firstbb">
              <li class="dropdown" style="width:100%;">
                 <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                 <i class="fa fa-gift" aria-hidden="true"></i> Get A Gift </a>
                 <ul class="dropdown-menu" style="margin-top:-1px; width:100%; height:100%">
                  <li>
                        <textarea class="texarea" placeholder="Leave a comment"></textarea>
                        <input type="submit" class="textsub" value="Request" />
                    </li>
                </ul>
              </li>
              
              
              <li class="dropdown" style="width:100%;">
                 <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                 <i class="fa fa-tags" aria-hidden="true"></i> Request Sample</a>
                 <ul class="dropdown-menu" style="margin-top:-1px; width:100%; height:100%">
                  <li>
                        <textarea class="texarea" placeholder="Leave a comment"></textarea>
                        <input type="submit" class="textsub" value="Request" />
                    </li>
                </ul>
              </li>
              
           </ul>   
</div><!--lightboxblockmain--> 
      </div>  
     
    <div class="lightboxmaintext" >
       
         <div class="col-md-7 col-xs-12 prolightimg" >
             <div>
                  <div id="divAlerts" runat="server" class="alert" visible="False">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                Text="" Visible="True"></asp:Label>
        </div>
        <div id="dvmessage" style="display:none; margin-bottom:20px;">
            <asp:Label runat="server" ID="lblMess" for="PageMessage" CssClass="alert alert-success fade in"
                Text="Message sent successfully." Visible="True"></asp:Label>
        </div>
        
        <div id="dvWmessage" style="display:none; margin-bottom:20px;">
            <asp:Label runat="server" ID="Label1" for="PageMessage" CssClass="alert alert-success fade in"
                Text="This item has been added to your wish list." Visible="True"></asp:Label>
        </div>
             </div>
            
             <asp:Repeater runat="server" ID="rptImages" DataSourceID="sdsItemImages">
                  <ItemTemplate>
                       <img src='<%# Eval("ItemImg","../photobank/{0}") %>' width="100%" /><br />
                   </ItemTemplate>
             </asp:Repeater>
            
             <asp:SqlDataSource ID="sdsItemImages" runat="server" 
                 ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                 ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                 SelectCommand="SELECT [ImgID], [ItemImg] FROM [Tbl_ItemImages] WHERE ([ItemID] = ?)">
                 <SelectParameters>
                     <asp:QueryStringParameter Name="ItemID" QueryStringField="v" Type="Int32" />
                 </SelectParameters>
             </asp:SqlDataSource>
            
         </div><!--col-md-7-->
         
         <div class="col-md-5 col-xs-12" >
                <div class="discrigblock">
                    <asp:updatepanel runat="server">
                 <ContentTemplate>
                    <div class="searchb">
                     <div class="serheading1">Like this Item</div> 
                     
                       <div class="biglike">
                           <asp:Label runat="server" ID="Label200" Visible="False"></asp:Label>
                            <asp:LinkButton runat="server" ID="lbtnLike" CssClass="mnLikes" Visible="true" OnClick="lbtnLike_Click" style="display:none"></asp:LinkButton>
                           <a id="demoBtn" onclick="likeUnlike()" style="cursor:pointer">
                                        <%--<img src="../images/biglike.png" />--%>
                                        <i class="fa fa-heart " runat="server" aria-hidden="true" Id="round"></i>
                                        <asp:Label runat="server" ID="LikesLabel" Visible="True">Likes</asp:Label> <asp:Label runat="server" ID="bracket1" Visible="True">(</asp:Label><asp:Label runat="server"   ID="lblTotalLikes"></asp:Label><asp:Label runat="server" ID="bracket2" Visible="True">)</asp:Label></a>
                                        <% if (lblTotalLikes.Text != "0")
                                           {%>
                                        <%--<div class="menudlist_list" id="list2" style="margin-top:20px;">
                                            <div class="mespace"></div>--%>
                                             <asp:Repeater ID="rptHoliday" runat="server" DataSourceID="sdsLikes" >
                                                <ItemTemplate>
                                    
                                                    <%--<li class="menudli" style="line-height: 30px;">
                                                        <a href="#" style="cursor:default; top:0px; padding: 0px 0px 5px 5px;">
                                                              <i class="fa fa-long-arrow-right" style="font-size:10px; font-weight:bold; margin-right:5px;"></i>
                                                              <%#Eval("Name")%>
                                                        </a>
                                                    </li>   --%>  
                                                </ItemTemplate>
                                            </asp:Repeater>
                                     <asp:SqlDataSource runat="server" ID="sdsLikes" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                                        SelectCommand="select distinct U_Firstname + ' ' + U_Lastname as Name, U_ProfilePic, UserKey, Tbl_Users.UserID FROM Tbl_Users INNER JOIN 
                                        Tbl_Item_Likes ON Tbl_Users.UserID=Tbl_Item_Likes.UserID  Where Tbl_Item_Likes.ItemID=?  AND Tbl_Item_Likes.UserID !=0">
                                    <SelectParameters>
                                          <asp:QueryStringParameter QueryStringField="v" Name="?" runat="server"></asp:QueryStringParameter>
                                      </SelectParameters>   
                  
                                        </asp:SqlDataSource>
                                    <%--<div class="mespace"></div>
                                    </div>--%>
                                    <% } %>
                          
                       </div>
                       
              

                    </div> 
                 </ContentTemplate>
             </asp:updatepanel>
                  </div>  
                <div class="dissp1"></div>
             <!--basic ino-->     
                <div class="discrigblock">
                  <div class="searchb"><div class="serheading1">Basic Info</div> </div>
                  <div class="lightboxpicdata" style="clear:both;"> 
                     <asp:Label runat="server" ID="lblDescription"></asp:Label>
               </div>
               </div>
                <div class="dissp1"></div>  
                <!--stylenumber-->     
                <div class="discrigblock">
                 
                 <div class="rpri">
                     <div class="searchb"><div class="serheading1">Retail Price</div> 
                        <div class="lightbtext">$ <asp:Label runat="server" ID="lblRetailPrice"></asp:Label></div>
                     </div>
                 </div>    
                     
                 <div class="rpri1">
                     <div class="searchb"><div class="serheading1">Wholesale Price</div> 
                        <div class="lightbtext">$ <asp:Label runat="server" ID="lblWholesalePrice"></asp:Label></div>
                     </div>
                 </div>   
                     
                </div>
                <div class="dissp1"></div>      
                <!--stylenumber-->     
                <div class="discrigblock">
                     <div class="searchb"><div class="serheading1">Style Number</div> 
                        <div class="lightbtext"><asp:Label runat="server" ID="lblStyleNumber"></asp:Label></div>
                     </div> 

                </div>
                <div class="dissp1"></div>    
                <!--stylename-->     
                <div class="discrigblock">
                     <div class="searchb"><div class="serheading1">Style Name</div> 
                      <div class="lightbtext"><asp:Label runat="server" ID="lblStyleName"></asp:Label></div>
                     </div>
                </div>
                <div class="dissp1"></div>    
           
           
            <!--tags-->     
             <asp:updatepanel runat="server">
                 <ContentTemplate>
                      <div class="discrigblock">
                         <div class="searchb">
                             <div class="serheading1">Related Tags</div> 
                             
                             <div class="serheading1">
                                 <asp:Repeater runat="server" ID="rptTags" DataSourceID="sdsTags">
                                 <ItemTemplate>
                                     <div class="tagblock"><a><i class="fa fa-times-circle-o"></i> <%# Eval("TagName") %></a></div>
                                 </ItemTemplate>
                             </asp:Repeater>
                                  <asp:SqlDataSource ID="sdsTags" runat="server" 
                                      ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                      ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>"
                                      SelectCommand="SELECT [TagID], [TagName] FROM [Tbl_Tags] Where [TagID] IN (Select [TagID] from [Tbl_ItemTagsMapping] where ItemID=?)  ORDER BY [TagID]"> 
                                      <SelectParameters>
                                          <asp:QueryStringParameter Name="ItemID" QueryStringField="v" Type="Int32" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                                   <asp:SqlDataSource ID="sdsMoreTags" runat="server" 
                                      ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                      ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                      SelectCommand="SELECT Top 40 [TagID], [Title] FROM [Tbl_ItemTags] 
Where ItemID=? 
 ORDER BY [TagID]">
                                      <SelectParameters>
                                          <asp:QueryStringParameter Name="ItemID" QueryStringField="v" Type="Int32" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                         </div>
                          <div class="fewer" runat="server" ID="dvTagToggles">
                              <asp:LinkButton runat="server" ID="btn_MoreTags" 
                                     CssClass="fewer" Text="View More" onclick="btn_MoreTags_Click" ></asp:LinkButton> 
                                 <asp:LinkButton runat="server" CssClass="fewer" ID="btn_LessTags" 
                                     Text="See fewer" Visible="False" onclick="btn_LessTags_Click" ></asp:LinkButton></div>
                          </div>  
                             
                         </div><!--search-->
                      <div class="dissp1"></div>  
                 </ContentTemplate>
             </asp:updatepanel>
               <!--comments-->
                <div class="discrigblock">
                    <asp:updatepanel runat="server" ID="up_Comments" >
                         <ContentTemplate>
                    <div class="searchb">
                     <div class="serheading1">Comments - (<asp:Label runat="server" ID="lblPostCount"></asp:Label>)</div> 
                     
                 <div class="col-md-12">
                     <asp:Panel runat="server" DefaultButton="btnAddPost">
                    <div class="col-md-2"><asp:Image CssClass="img-circle img-responsive" runat="server" ID="imgProfile2" ImageUrl="../images/follo.png" /></div>
                    <div class="col-md-10">
                        <textarea runat="server" placeholder="Leave A Comments" class="textanew" name="texta" ID="txtComment" style="margin-bottom:-5px; line-height:1.3;"></textarea>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Please enter some text"  style="float: right; padding: 5px;" Display="Static" ControlToValidate="txtComment" ValidationGroup="gpComment"></asp:RequiredFieldValidator>
                    </div> 
                    <div class="lightboxblockmain2">
                        <div class="lightboxeditbutton">
                            <asp:LinkButton runat="server" ID="btnAddPost" CssClass="hvr-sweep-to-rightup2" Text="Post a Comment" OnClick="btnAddPost_OnServerClick" ValidationGroup="gpComment" style="width:200px; padding-top: 6px; padding-left: 30px;"></asp:LinkButton>
                        <%--    <a href=""> <button type="button" runat="server"  name="login" ID="btnAddPost"   OnServerClick="" >Post a Comment</button></a>--%>
                           <%-- <a >Post a Comment</a>--%>
                        </div><!--lightboxeditbutton-->
                    </div><!--lightboxblockmain-->  
                    </asp:Panel>  
                </div><!--col-md-12-->
                
                <div class="col-md-12" style="margin:30px 0 30px 0; float:left; width:100%; border-bottom:#dadbdd solid 3px;"></div>   
              <asp:Repeater runat="server" DataSourceID="sdsPosts" ID="rptPosts" OnItemDataBound="rptPosts_OnItemDataBound" OnItemCommand="rptPosts_OnItemCommand">
                  <ItemTemplate>
                   
                      <div class="col-md-12" id='ph<%# Eval("PostId","{0}") %>'  onmouseover='showdeletebutton(<%# Eval("PostId") %>);' onmouseout="hidedeletebutton(<%# Eval("PostId") %>)">
                       <asp:Label runat="server" Visible="False" ID="lblPostID" Text='<%# Eval("PostId","{0}") %>'></asp:Label>
                       <asp:Label runat="server" Visible="False" ID="lblUserID" Text='<%# Eval("UserID","{0}") %>'></asp:Label>
                      <div class="col-md-2" ><a href="#"><img class="img-circle" src='<%# Eval("U_ProfilePic","../brandslogoThumb/{0}") %>'   alt="image" style=" width:24px; height:24px;"/></a></div>
                      <div class="col-md-10" style="margin-left: -20px;" >
                          
                          <span class="commh"><asp:Label runat="server" Visible="False" ID="lblUsername" Text='<%# Eval("Username") %>'></asp:Label><a href="#"><%# Eval("Username") %></a> <br /></span>
                          <span class="commtext"><%# Eval("Message","{0}") %></span>
                          
                          <span runat="server" ID="spDelmenuP">
                               <ul class="nav navbar-nav navbar-left" id='pm<%# Eval("PostId","{0}") %>'   style="display:none; position: absolute; right: -50px;">
                              <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" style=" padding-top: 0px; padding-bottom: 0px; margin-top: -10px" role="button" aria-haspopup="true" aria-expanded="false">
                                 <span> <img src="../images/triangle.png" /></span></a>
                                <ul class="dropdown-menu" style="margin-top: -2px; min-width: 130px; margin-left: -82px;">
                                  <li> <asp:LinkButton runat="server" ID="menuDeleteComment" style="padding: 5px 5px 3px 10px; margin-bottom:0px;" CommandName="3" CommandArgument='<%# Eval("PostID","{0}") %>' OnClientClick="return confirm('are you sure, you want to delete ?')"><span class="sp"> Delete</span></asp:LinkButton></li>
                  
                                </ul>
                              </li>
                        </ul>
                          </span>
                         
                              <asp:Repeater runat="server" ID="rptComments"   OnItemCommand="rptComments_OnItemCommand"  OnItemDataBound="rptComments_OnItemDataBound">
                                  <ItemTemplate>
                                       <div class="col-md-12" id='ch<%# Eval("CommentId","{0}") %>' onmouseover="showreplyDelete(<%# Eval("CommentId","{0}") %>)" onmouseout="hidereplyDelete(<%# Eval("CommentId","{0}") %>)"  style="padding: 10px; background: #f0efef; opacity:0.7;">
                                         <div class="col-md-2" ><a href="#"><img class="img-circle" src='<%# Eval("U_ProfilePic","../brandslogoThumb/{0}") %>'   alt="image" style=" width:24px; height:24px; max-width:none;"/></a></div>
                                          <div class="col-md-10">
                                              <asp:Label runat="server" Visible="False" ID="lblUserID" Text='<%# Eval("UserID","{0}") %>'></asp:Label>
                                               <span class="commh"><a href="#"><%# Eval("Username") %></a> <br /></span>
                                                <span class="commtext"><%# Eval("Message","{0}") %></span>
                                              <%--<div class="col-md-12 reply"><img src="../images/reply.png" /></div>--%>
                                               <span runat="server" ID="spDelmenuC">
                                                    <ul class="nav navbar-nav navbar-left" id='cm<%# Eval("CommentId","{0}") %>'     style=" display:none; position: absolute; right: -50px;">
                                                  <li class="dropdown">
                                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" style=" padding-top: 0px; padding-bottom: 0px; margin-top: -10px;" role="button" aria-haspopup="true" aria-expanded="false">
                                                     <span> <img src="../images/triangle.png" /></span></a>
                                                    <ul class="dropdown-menu" style="margin-top: -2px; min-width: 130px;  margin-left: -82px;">
                                                      <li> <asp:LinkButton runat="server" ID="Deletereply"  style="padding: 5px 5px 3px 10px; margin-bottom:0px;" OnClientClick="return confirm('are you sure, you want to delete ?')"  CommandName="4" CommandArgument='<%# Eval("CommentId","{0}") %>'><span class="sp"> Delete</span></asp:LinkButton></li>
                
                                                    </ul>
                                                  </li> 
                                                </ul> 
                                               </span>
                                              
                                          </div>
                                          
                                        </div><!--col-md-12-->    
                                  </ItemTemplate>
                              </asp:Repeater>
                              
                          <div class="col-md-12" id='d<%# Eval("PostId") %>' style="display: none; margin-top: 5px; padding: 0;">
                              <asp:TextBox runat="server"  ID="txtReply"  TextMode="MultiLine"     style="width:100%; margin-bottom:-10px; font-size:12px; line-height:1.3;"  />
                             <asp:Button runat="server" style="display:none;" ID="btnSearch" CommandName="2" CommandArgument='<%# Eval("PostId","{0}") %>'/> 
                          </div>
                        <div  class="col-md-12 " id='b<%# Eval("PostId") %>'   style="display: none;">
                              
                              <asp:Button runat="server" ID="imgbtnReply" CssClass="reply"  CommandName="1" CommandArgument='<%# Eval("PostId","{0}") %>' BorderStyle="None" style="margin-right: -15px;"/>
                          </div>
                           <div class="col-md-12 reply" id='h<%# Eval("PostId") %>' onclick='ToggleDisplay(<%# Eval("PostId") %>);'  style="margin-top: 5px;">
                               <%--<img src="../images/reply.png" alt="reply"/>--%>
                              
                            </div>
                           
                      </div>
                      
                      
              </div><!--col-md-12--> 
             
                  </ItemTemplate>
              </asp:Repeater>
                        <asp:SqlDataSource ID="sdsPosts" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                            ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                            SelectCommand="SELECT Tbl_Posts.Message, Tbl_Posts.DatePosted, U_Firstname + '  ' + U_Lastname as Username, Tbl_Users.U_ProfilePic, Tbl_Posts.PostId, Tbl_Posts.UserID  FROM Tbl_Users INNER JOIN Tbl_Posts ON Tbl_Users.UserID = Tbl_Posts.UserID WHERE (Tbl_Posts.ItemID = ?) ORDER BY PostId DESC">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="?" QueryStringField="v" />
                            </SelectParameters>
                        </asp:SqlDataSource>
              
                       <asp:SqlDataSource ID="sdsComments" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                            ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                            SelectCommand="SELECT Tbl_Comments.Message, Tbl_Comments.DatePosted, U_Firstname + '  ' + U_Lastname as Username, Tbl_Users.U_ProfilePic, Tbl_Comments.PostId, CommentId  FROM Tbl_Users INNER JOIN 
                            Tbl_Comments ON Tbl_Comments.UserID=Tbl_Users.UserID WHERE (Tbl_Comments.PostId = ?)">
                           
                        </asp:SqlDataSource>
                    </div> 
                    </ContentTemplate>
                       
                     </asp:updatepanel>  
                  </div> 
                 
                <div class="dissp1"></div>  
             
         </div><!--col-md-5-->
    </div><!--lightboxmaintext--> 
    
     </ContentTemplate>
        <%--<Triggers>
            <asp:AsyncPostBackTrigger ControlID="lbtnWishList" EventName="click" />
            <asp:AsyncPostBackTrigger ControlID="btnRequestSample" EventName="click"/>
            <asp:AsyncPostBackTrigger  ControlID="btnGetGift" EventName="click"/>
        </Triggers>--%>
    </asp:updatepanel>
  
</div>
  
   <script type="text/javascript">
       function likeUnlike()
       {
           $('#demobtn').css('color', '#FFF');
           if ($('#demoBtn').hasClass('liked'))
           {
               $('#demobtn').css('color', '#000');
               //document.getElementById('demoBtn').classList.remove('liked');
               //document.getElementById('demoBtn').classList.add('unliked');
           }
           else
           {
               $('#demobtn').css('color', '#FFF');
               //document.getElementById('demoBtn').classList.remove('unliked');
               //document.getElementById('demoBtn').classList.add('liked');
           }
           document.getElementById('lbtnLike').click();
           //__doPostBack('lbtnLike_Click', '');
       }
   </script>
    </form>
     <!-- Javascript
      <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
  
    <script src="../js/bootstrap.js"></script>
    <script src="../masonry/js/libs/imagesloaded.3.1.8.min.js"></script>
    <script src="../masonry/js/libs/jquery.masonry.3.2.1.min.js"></script>
    <script src="../masonry/js/base1.js" type="text/javascript"></script>


	<!-- custom scrollbar plugin -->
	<script src="../customscroller/jquery.mCustomScrollbar.concat.min.js"></script>
  
<script type="application/javascript" src="../js/custom.js"></script>
    <script src="../js/autosize.js" type="text/javascript"></script>
    <script src="../js/jquery.timeago.js" type="text/javascript"></script> 
    <script type="text/javascript">
        $(document).ready(function () {
            $("timeago").timeago();
            autosize(document.querySelectorAll('textarea'));
        });
    </script>
     <script src="../source/jquery.fancybox.pack.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            //  var content = $('#myMessage').html();
            $("#lbtnMessage").fancybox({
                //  content:content,
                fitToView: true,
                frameWidth: '600px',
                frameHeight: '300px',
                width: '600px',
                height: '300px',
                autoSize: false,
                closeBtn: true,
                closeClick: false,
                openEffect: 'fade',
                closeEffect: 'fade',
                type: "iframe",
                opacity: 0.7,
                onStart: function () {
                    $("#fancybox-overlay").css({ "position": "fixed" });
                }
                //               beforeShow: function () {

                //                   // var url = $(this).attr('href');
                //                   //                   url = (url == null) ? '' : url.split('?');
                //                   //                   if (url.length > 1) {
                //                   //                       url = url[1].split('=');

                //                   // var id = url.substring(url.lastIndexOf("/") + 1, url.length);
                //                   //  var id = url[1];
                //                   var pageUrl = window.location.href + "#myMessage";
                //                   //  window.location = pageUrl;
                //                   window.history.pushState('d', 't', pageUrl);
                //                   // }

                //               },
                //               beforeClose: function () {
                //                   window.location = window.history.back(-2);
                //               }
            });

        });
</script>
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


    jQuery(document).ready(function (e) {
        function t(t) {
            e(t).live("click", function (t) {
                t.preventDefault();
                e(this).parent().fadeOut();
            });
        }
        e(".dropdownreq-toggle").live('click', (function () {
            var t = e(this).parents(".button-dropdownreq").children(".dropdownreq-menu").is(":hidden");
            e(".button-dropdownreq .dropdownreq-menu").hide();
            e(".button-dropdownreq .dropdownreq-toggle").removeClass("active");
            if (t) {
                e(this).parents(".button-dropdownreq").children(".dropdownreq-menu").toggle().parents(".button-dropdownreq").children(".dropdownreq-toggle").addClass("active");
            }
        }));
        e(document).live("click", function (t) {
            var n = e(t.target);
            if (!n.parents().hasClass("button-dropdownreq")) e(".button-dropdownreq .dropdownreq-menu").hide();
        });
        e(document).live("click", function (t) {
            var n = e(t.target);
            if (!n.parents().hasClass("button-dropdownreq")) e(".button-dropdownreq .dropdownreq-toggle").removeClass("active");
        });
    });


    function callreq() {
        jQuery('#txtGift').val = '';
        jQuery('#req').hide();
    }

    function callreq1() {
        jQuery('#txtSample').html('');
        jQuery('#req1').hide();
    }

    function hideRequestGift() {
        jQuery('#txtGift').html('');
        jQuery('#req').hide();
        jQuery('#dvmessage').show();
    }

    function hideRequestSample() {

        jQuery('#txtSample').html('');
        jQuery('#req1').hide();
        jQuery('#dvmessage').show();
    }
</script>
    <script type="text/javascript">
        function closeFancybox() {

            parent.document.location.href = "http://localhost:60797//massenger.aspx";
            window.parent.jQuery.fancybox.close();


        }
    </script>
</body>
</html>
