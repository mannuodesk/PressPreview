<%@ Page Language="C#"    CodeFile="massenger.aspx.cs" Inherits="brand_massenger" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>PR::Messenger </title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../css/checkbox.css"/>
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
  <%--  <script src="../js/jquery-3.1.1.js" type="text/javascript"></script>--%>

<link href="../source/jquery.fancybox.css" rel="stylesheet" type="text/css" />
 <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="../js/jquery.autocomplete.js" type="text/javascript"></script>
<style>
  .wrapParagraph{
        display: block;
    text-overflow: ellipsis;
    word-wrap: break-word;
    overflow: hidden;
    max-height: 8.6em;
  }
  @-moz-document url-prefix() {
    .blockme {
        margin-top:5%;
    }
   }
</style>
<script type="text/javascript">
$(document).ready(function () {
    // Handler for .ready() called.
    console.log($('#scroll'));
    //$("#scroll").animate({ scrollTop: $("#scroll")[0].scrollHeight }, 1000);
});
    $(function () {
        initializer();
        setHeight();
        $("#checkAll").click(function () {
            $('input:checkbox').prop('checked', this.checked);
        });

        // To deselect CheckAll when a GridView CheckBox
        // is unchecked
        $("#grdMessageList input[type='checkbox']").click(
        function (e) {
            if (!$(this)[0].checked) {
                $("#checkAll").attr("checked", false);
            }
        });
    });


//    var prmInstance = Sys.WebForms.PageRequestManager.getInstance();
//    prmInstance.add_endRequest(function () {
//        //you need to re-bind your jquery events here
//        initializer();
//        setHeight();
//    });
    function initializer() {
        $("#<%=txtUsername.ClientID%>").autocomplete('Search.ashx', {

            minChars: 1,
            formatItem: function (data, i, n, value) {
                return "<div style='  background: #eee; padding: 10px; width: 100%; overflow-x:hidden; overflow-y:auto; height:100%;' ><div style='width:40px; float:left; height:40px;'><img style = 'width:36px;height:36px; border-radius:50%;' src= ../brandslogoThumb/" + value.split(",")[1] + "></div> <div> <b>" + value.split(",")[0] + "</b><br/>  @" + value.split(",")[2] + "</div> </div>";
            },
            formatResult: function (data, value) {
                window.PageMethods.SetReceiverName(value.split(",")[2]);
                return value.split(",")[0];
            }
        });
    }
    
    function setHeight() {
        var windowHeight = $(window).height();
        var calculatedHeight1 = windowHeight * 0.70813;
        var calculatedHeight2 = windowHeight * 0.60813;
        $('#scroll').css("height", calculatedHeight1);
        $('#scroll1').css("height", calculatedHeight2);
    }
    </script>
<script type="text/javascript">
    $(document).ready(function () {
        
        var prmInstance = Sys.WebForms.PageRequestManager.getInstance();
        prmInstance.add_endRequest(function () {
            //you need to re-bind your jquery events here
            initializer();
            setHeight();
            $("#checkAll").click(function () {
                $('input:checkbox').prop('checked', this.checked);
            });

            // To deselect CheckAll when a GridView CheckBox
            // is unchecked
            $("#grdMessageList input[type='checkbox']").click(
        function (e) {
            if (!$(this)[0].checked) {
                $("#checkAll").attr("checked", false);
            }
        });
           
        });
        //        $('.scroltobottom').live("click", function () {
        ////            //Getting the element's new height now
        ////            var windowHeight = $(window).height();
        ////            var calculatedHeight1 = windowHeight * 0.70813;
        ////            alert(calculatedHeight1);
        ////            //  var sHeight = $('#scroll').height();
        ////            //Scrolling the element to the sHeight
        //            //            $('#scroll').scrollTop(calculatedHeight1);
        //           // $('#scroll').scrollTop(1E10);
        //        });


        $("#btnC").live("click", (function () {
            $("#pnlCompose").show();
            $("#pnlMessage").hide();
        }));
    });
</script>

</head>
<body>
<form runat="server" ID="frmMassener">

<asp:scriptmanager runat="server" EnablePageMethods="True" EnablePartialRendering="True">
    </asp:scriptmanager>
    
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
            <!--#INCLUDE FILE="../includes/messgTopInfluencer.txt" --> 
            </div>   
            <ul class="nav navbar-nav" id="firstbb">
              <li><a href="Default.aspx" tabindex="0">Activity</a></li>
              <li class="active"><a href="discover.aspx" tabindex="1">Discover</a></li>
              <li><a href="brands.aspx" tabindex="2">Brands</a></li>
               <li><a href="events.aspx" tabindex="3">Events</a></li>
            </ul>            
             <!--#INCLUDE FILE="../includes/influencer_settings.txt" -->     
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>

    </div><!--header bg-->
    <div class="topspace"></div>
<!--Headerend-->
<!--text-->
<asp:updatepanel runat="server" >
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
<%--<div class="wrapperblockwhite" style="width: 85%;margin-top: 110px;">--%>
    <div class="wrapperblockwhite wrapperblockwhite1" style="height:100%; width: 85%;margin-top: 110px; overflow:hidden;">
            <div class="col-md-4 col-sm-12 col-xs-12 mesblock" id="UserBlock" style="background:#fff;">
      <div class="mesbl1" style="margin-top:-20px;">
           <div class="col-md-8 col-xs-9  mesheading" style="padding-bottom:8px;">
          <ul class="nav navbar-nav navbar-left">
		     <li style="margin-top:15px;"><asp:Image ImageUrl="../images/msg.png"  ID="imgFolders" runat="server"/>  <asp:Label runat="server" ID="lblFoldername"  Text="Inbox"></asp:Label></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="margin-left: -15px; padding-top: 0px; padding-bottom: 0px; margin-top: 10px;" role="button" aria-haspopup="true" aria-expanded="false">
                 <span> <img src="../images/triangle.png" /></span></a>
                <ul class="dropdown-menu" style="margin-top: -2px; min-width: 130px;">
                  <li> <asp:LinkButton runat="server" ID="menuItemInbox" OnClick="menuItemInbox_OnClick"><img src="../images/msg.png"/><span class="sp"> Inbox</span></asp:LinkButton></li>
                  <li><asp:LinkButton runat="server" ID="menuItemArchive" OnClick="menuItemArchive_OnClick"><img src="../images/archm.png"/><span class="sp"> Archive</span></asp:LinkButton></li>
                  <li><asp:LinkButton runat="server" ID="menuItemSpam" OnClick="menuItemSpam_OnClick"><img src="../images/markm.png"/><span class="sp"> Spam</span></asp:LinkButton></li>
                </ul>
              </li>
            </ul> 
           </div>
           <div class="col-md-4 bcompose" >
               <button type="button"   id="btnCompose" onclick="openCompose()"  class="hvr-sweep-to-rightup2" style=" margin-top: 13px;
    margin-left: 13px;" >Compose</button>
           </div>                     
           <div class="col-md-3 col-xs-3 bcomposeimg" id="cmes" >
                <div onclick="showformmess()"><img src="../images/addmessage.png" style="padding-top:12px; padding-left:16px"  /></div>
           </div>
           <div class="col-md-3 col-xs-3  bcomposeimg" id="acmes" style="display:none;">
                <div  onclick="showformmessa()"><img src="../images/addmessagea.png" style="padding-top:12px;  padding-left:16px"   /></div>
           </div>
           
      </div><!--mesbl1-->
      <div ID="dvActionbar" class="selall" style="box-shadow: 0px 3px 0px #ccc;" runat="server">        
           <div class="col-md-7 col-xs-9">
               <asp:CheckBox ID="checkAll" runat="server" Text="Select All"/>
           </div>
           <div class="col-md-5 col-xs-3 actiona">
           
           
<div id="demodmenu1">
 <div id="close"></div>
  <div  style="float:none; left:0;" runat="server" ID="dvInboxActions">
      <ul class="nav navbar-nav navbar-right">
		     <li> <asp:Label runat="server"   Text="Actions"></asp:Label></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="margin-left: -18px; margin-top: -8px; padding-bottom: 0; padding-top: 0;" role="button" aria-haspopup="true" aria-expanded="false">
                 <span> <img src="../images/triangle.png" /></span></a>
                <ul class="dropdown-menu dropmenu" >
                  <li>  <asp:LinkButton runat="server" ID="lbtnArchive" OnClick="lbtnArchive_OnClick"><div class="imgwidth"><img src="../images/archm.png"/></div><span class="sp">Archive</span></asp:LinkButton></li>
                   <li>  <asp:LinkButton runat="server" ID="lbtnRead" OnClick="lbtnRead_OnClick"><div class="imgwidth"><img src="../images/views.png"/></div><span class="sp">Mark as Read</span></asp:LinkButton> </li>
                  <li> <asp:LinkButton runat="server" ID="lbtnSpam" OnClick="lbtnSpam_OnClick"><div class="imgwidth"><img src="../images/markm.png"/></div><span class="sp">Mark as Spam</span></asp:LinkButton></li>
                  <li> <asp:LinkButton runat="server" ID="lbtnDelete" OnClick="lbtnDelete_OnClick"><div class="imgwidth"><img src="../images/delem.png"/></div><span class="sp">Delete Forever</span></asp:LinkButton></li>
                </ul>
              </li>
            </ul>
   
  </div>
  <div  runat="server" ID="dvArchiveActions">
       <ul class="nav navbar-nav navbar-right">
		     <li> <asp:Label runat="server"   Text="Actions"></asp:Label></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="margin-left: -18px; margin-top: -8px; padding-bottom: 0; padding-top: 0;" role="button" aria-haspopup="true" aria-expanded="false">
                 <span> <img src="../images/triangle.png" /></span></a>
                <ul  class="dropdown-menu dropmenu" >
                  <li>  <asp:LinkButton runat="server" ID="lbtnInbox" OnClick="lbtnInbox_OnClick"><div class="imgwidth"><img src="../images/archm.png"/></div><span class="sp">Inbox</span></asp:LinkButton> </li>
                   <li>  <asp:LinkButton runat="server" ID="lbtnReadArchive" OnClick="lbtnReadArchive_OnClick"><div class="imgwidth"><img src="../images/views.png"/></div><span class="sp">Mark as Read</span></asp:LinkButton> </li>
                  <li> <asp:LinkButton runat="server" ID="lbtnSpamArchive" OnClick="lbtnSpamArchive_OnClick"><div class="imgwidth"><img src="../images/markm.png"/></div><span class="sp">Mark as Spam</span></asp:LinkButton></li>
                  <li> <asp:LinkButton runat="server" ID="lbtnDeleteArchive" OnClick="lbtnDeleteArchive_OnClick"><div class="imgwidth"><img src="../images/delem.png"/></div><span class="sp">Delete Forever</span></asp:LinkButton></li>
                </ul>
              </li>
            </ul>
    
  </div>
  <div  runat="server" ID="dvSpamActions">
       <ul class="nav navbar-nav navbar-right">
		     <li> <asp:Label runat="server"   Text="Actions"></asp:Label></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="margin-left: -18px; margin-top: -8px; padding-bottom: 0; padding-top: 0;" role="button" aria-haspopup="true" aria-expanded="false">
                 <span> <img src="../images/triangle.png" /></span></a>
                <ul  class="dropdown-menu dropmenu" >
                  <li>   <asp:LinkButton runat="server" ID="lbtnSpam2Inbox" OnClick="lbtnSpam2Inbox_OnClick"><div class="imgwidth"><img src="../images/archm.png"/></div><span class="sp">Inbox</span></asp:LinkButton> </li>
                   <li>  <asp:LinkButton runat="server" ID="lbtnReadSpam" OnClick="lbtnReadSpam_OnClick"><div class="imgwidth"><img src="../images/views.png"/></div><span class="sp">Mark as Read</span></asp:LinkButton> </li>
                  <li> <asp:LinkButton runat="server" ID="lbtnSpam2Archive" OnClick="lbtnSpam2Archive_OnClick"><div class="imgwidth"><img src="../images/markm.png"/></div><span class="sp">Archive</span></asp:LinkButton></li>
                  <li> <asp:LinkButton runat="server" ID="lbtnDeleteSpam" OnClick="lbtnDeleteSpam_OnClick"><div class="imgwidth"><img src="../images/delem.png"/></div><span class="sp">Delete Forever</span></asp:LinkButton></li>
                </ul>
              </li>
            </ul>
    
  </div>
</div><!--demo-->
 </div>
</div><!--selall-->
       <div class="selallm" style="display:none">        
           <div class="col-md-8 col-xs-9">
                 <input type="checkbox" id="tests2323"/><label for="tests2323"> Select all</label>
           </div>
           
<%--<div id="demodmenu2">
 <div id="close"></div>
  <div class="l2">
    <button class="menudli2st2" id="a"><i class="fa fa-cog fa-fw" aria-hidden="true" style="font-size:14px;  margin-top:0px;"></i></button>
    <div class="menudli2st2_list" id="list2">
            <div class="mespace"></div>
            <li class="menudli2"><a href="#"><div class="imgwidth"><img src="..images/archm.png"/></div><span class="sp">Archive</span></a></li>
            <li class="menudli2"><a href="#"><div class="imgwidth"><img src="..images/markm.png"/></div><span class="sp">Mark as Spam</span></a></li>
            <li class="menudli2"><a href="#"><div class="imgwidth"><img src="..images/delem.png"/></div><span class="sp">Delete Forever</span></a></li>
            <li class="menudli2"><a href="#"><div class="imgwidth"><img src="..images/blockm.png"/></div><span class="sp">Block User</span></a></li>
            <div class="mespace"></div>
    </div>
  </div>
</div>--%><!--demo-->


      </div><!--selall-->
  <!--- mobile form-->
    <div id="showformmes" class="blockmes1" style="display:none;">
       <div class="col-md-12 blockmes1">
           <div class="mesbl2">
             <div class="col-md-11 col-xs-12  mesheading">Message with <span style="color:#5092c9"></span></div>
            
           </div><!--mesbl1-->
       
                    <div class="blockmes blockmes1" >
                       <div class="mesbm">
                          <div class="mimg"><img src="../images/comimg.png" /></div><!--mimageb-->
                          <div class="mcom">
                             <div class="m1">
                               <div class="usercom">Username</div> 
                               <div class="metext">2 days</div>
                             </div>
                             <div class="m1">
                                <div class="mtexts">Hello</div>
                             </div>
                             <div class="m1"></div>
                          </div><!--mtextb-->
                      </div><!--mseb-->
                   </div><!--blockme--> 
                   
                   <div class="blockmes blockmes1" >
                       <div class="mesbm">
                          <div class="mimg"><img src="../images/comimg.png" /></div><!--mimageb-->
                          <div class="mcom">
                             <div class="m1">
                               <div class="usercom">Recipient</div> 
                               <div class="metext">2 days</div>
                             </div>
                             <div class="m1">
                                <div class="mtexts">What size do you have available</div>
                             </div>
                             <div class="m1"></div>
                          </div><!--mtextb-->
                      </div><!--mseb-->
                   </div><!--blockme--> 
                   
                   <div class="blockmes blockmes1" >
                       <div class="mesbm">
                          <div class="mimg"><img src="images/comimg.png" /></div><!--mimageb-->
                          <div class="mcom">
                             <div class="m1">
                               <div class="usercom">Username</div>
                               <div class="metext">2 days</div> 
                             </div>
                             <div class="m1">
                                <div class="mtexts">All size are available</div>
                             </div>
                             <div class="m1"></div>
                          </div><!--mtextb-->
                      </div><!--mseb-->
                   </div><!--blockme--> 
                   
                   <div class="blockmes blockmes1" >
                       <div class="mesbm">
                          <div class="mimg"><img src="../images/comimg.png" /></div><!--mimageb-->
                          <div class="mcom">
                             <div class="m1">
                               <div class="usercom">Recipient</div> 
                               <div class="metext">2 days</div>
                             </div>
                             <div class="m1">
                                <div class="mtexts">Perfect, Can I get Large</div>
                             </div>
                             <div class="m1"></div>
                          </div><!--mtextb-->
                      </div><!--mseb-->
                   </div><!--blockme--> 
                   
                   
                   <div class="blockmes" >
                       <div class="mesbm">
                          <div class="mimg"><img src="../images/comimg.png" /></div><!--mimageb-->
                          <div class="mtextcom">
                             <textarea name="comments" id="comments" class="comments" placeholder="Reply to Your Brand Name"></textarea>
                          </div><!--mtextb-->
                          <div class="newmesbl" style="text-align:right;">
                             <button type="submit" name="compose" id="compose11" class="hvr-sweep-to-rightup2">Send</button>&nbsp;&nbsp;&nbsp;
                             <button type="submit" name="compose" id="compose22" class="hvr-sweep-to-rightup2">Cancel</button>
                      </div><!--newmesbl--> 
                      </div><!--mseb-->
                   </div><!--blockme-->
    
    </div> </div><!--col-md-8--> 
 <!--- mobile form-->  
    <div id="scroll1" style="width:100%; overflow:auto; overflow-x:hidden">
    <asp:GridView runat="server" 
                    ID="grdMessageList" 
                    AutoGenerateColumns="False" 
                    DataSourceID="sdsMessageList" 
                    Width="100%" 
                    GridLines="None" 
                    AllowPaging="False" 
                    onrowdatabound="grdMessageList_RowDataBound" 
                    PageSize="5" 
                    onrowcommand="grdMessageList_RowCommand" 
                    EmptyDataText="No Message">
          <Columns>
              <asp:TemplateField>
                <ItemTemplate>
                    
                    <div class="blockme" style="border:none;     margin-top: -35px;">
                        <asp:CheckBox ID="chkCtrl" runat="server" OnCheckedChanged="chkCtrl_OnCheckedChanged" Text=" " />
                    </div>
                   
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField>
                  <EditItemTemplate>
                      <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ReadStatus") %>'></asp:TextBox>
                  </EditItemTemplate>
                  <ItemTemplate>
                      <div class="blockme">
                          <asp:Label runat="server" ID="lblParentID" Visible="False" Text='<%# Eval("ParentID") %>'></asp:Label>
                         
                        <%--<input type="checkbox"  ID="test1" runat="server"/><label for="test1" class="chkmes">--%>  <asp:LinkButton for="test1" ID="lbtnMessage" CssClass="chkmes" runat="server" CommandName="2" CommandArgument='<%# Eval("ParentID") + "," + Eval("MessageID") %>' > <div class="mesbm" style="margin:0 0 -10px;"><div class="mimg"><img class="img-circle" src='<%# Eval("U_ProfilePic","../brandslogoThumb/{0}") %>'   alt="image" style=" width:36px; height:36px;"/><asp:ImageButton runat="server" ID="imgbtnReply"  ImageUrl="../images/arrow.png" CommandName="1" CommandArgument='<%# Eval("ParentID") + "," + Eval("MessageID") %>'/></div><!--mimageb--><div class="mtextb"><div class="m1"><div class='muserms  <%# Eval("MessageStatus") %>' style="width:65%;"><%# Eval("Name")%></div><div class='metext' style="width: 35%; position: relative; text-align: right;"><asp:Label runat="server" ID="lblDate2" Text='<%# Eval("DatePosted") %>'></asp:Label></div></div><div class='m1 <%# Eval("MessageStatus") %>'><div class='mtexts'><%# Eval("Message")%></div></div><div class="m1"></div></div><!--mtextb--></div><!--mseb--></asp:LinkButton>
                      <%--   </label>--%>
                         
                     </div>
                  </ItemTemplate>
              </asp:TemplateField>
          </Columns>
          <EmptyDataRowStyle Height="100px" HorizontalAlign="Center" VerticalAlign="Middle" />
          <PagerStyle CssClass="GridPager" HorizontalAlign="Left" VerticalAlign="Middle" />
      </asp:GridView>
     
        <asp:SqlDataSource ID="sdsMessageList" runat="server" 
                           ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                           ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                           SelectCommand="SELECT Tbl_Mailbox.ParentID, U_Email,U_ProfilePic,SenderID,ReceiverID,SenderName, Tbl_Users.U_Firstname + ' ' + Tbl_Users.U_Lastname as Name,MessageID,SUBSTRING (Message ,0 , 50 )+ '...' as  Message,DatePosted, MessageStatus 
                    FROM Tbl_Mailbox INNER JOIN Tbl_MailboxMaster ON Tbl_MailboxMaster.ParentID=Tbl_Mailbox.ParentID 
                    INNER JOIN Tbl_Users ON Tbl_MailboxMaster.ReceiverID=Tbl_Users.UserID 
                    WHERE MessageID IN (SELECT MAX(MessageID) From Tbl_Mailbox Group By ParentID) AND SenderID= ? AND MessageType IS NULL AND  BlockStatus IS NULL AND Tbl_Mailbox.SDeleted IS NULL   ORDER BY DatePosted DESC" >
                           <SelectParameters>
                                 <asp:CookieParameter CookieName="FRUserID" Name="?" />
                           </SelectParameters>
       </asp:SqlDataSource>
     </div>
  </div><!--col-md-6-->
     
  
  <div class="col-md-8 col-sm-12 col-xs-12" id="formmess" style="background:#fff; padding-left:0px; padding-right:0px; overflow:visible">
        <div id="divAlerts" runat="server" class="alert" Visible="false" >
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                Text="" Visible="True"></asp:Label>
        </div>
      <%--<asp:Panel runat="server" ID="pnlMessage11" Visible="True">--%>
      <div id="pnlMessage">
       <div class="col-md-12 col-sm-12 col-xs-12" runat="server" ID="dvMessageDetailBox" style="overflow:hidden; padding-left:0px; padding-right:0px;">
           <div class="mesbl2" style="box-shadow: 3px 3px 3px #eee;">
             <div class="col-md-9 col-sm-9 col-xs-9 mesheading" style="margin-left:20px">Message with <span style="color:#5092c9"><asp:Label runat="server" ID="lblBrandName"></asp:Label></span></div>
             <div class="col-md-2 mesheading" style="margin-top:10px; margin-left:20px">
                 <ul class="nav navbar-nav navbar-right">
		     <li> <i class="fa fa-cog fa-fw" aria-hidden="true" style="font-size:14px;  margin-top:-5px; margin-right:5px;"></i></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="margin-left: -25px; margin-top: -8px; padding-bottom: 0; padding-top: 0;" role="button" aria-haspopup="true" aria-expanded="false">
                 <span> <img src="../images/triangle.png" /></span></a>
                <ul class="dropdown-menu dropmenu" >
                  <li>  <asp:LinkButton runat="server" ID="lbtnmpInbox" OnClick="lbtnmpInbox_OnClick"><div class="imgwidth"><img src="../images/archm.png"/></div><span class="sp">Move to Inbox</span></asp:LinkButton> </li>
                  <li>  <asp:LinkButton runat="server" ID="lbtnmpArchive" OnClick="lbtnmpArchive_OnClick"><div class="imgwidth"><img src="../images/archm.png"/></div><span class="sp">Move to Archive</span></asp:LinkButton></li>
                   <li>  <asp:LinkButton runat="server" ID="lbtnmpRead" OnClick="lbtnmpRead_OnClick"><div class="imgwidth"><img src="../images/views.png"/></div><span class="sp">Mark as Read</span></asp:LinkButton> </li>
                  <li> <asp:LinkButton runat="server" ID="lbtnmpSpam" OnClick="lbtnmpSpam_OnClick"><div class="imgwidth"><img src="../images/markm.png"/></div><span class="sp">Mark as Spam</span></asp:LinkButton></li>
                  <li> <asp:LinkButton runat="server" ID="lbtnmpDelete" OnClick="lbtnmpDelete_OnClick"><div class="imgwidth"><img src="../images/delem.png"/></div><span class="sp">Delete Forever</span></asp:LinkButton></li>
                </ul>
              </li>
            </ul>
             </div>
           </div><!--mesbl1-->
                 <div id="scroll" style="width:100%; overflow:auto; overflow-x:hidden">
                    <asp:Repeater runat="server" ID="rptMessageDetail" DataSourceID="sdsMessageDetails" onitemdatabound="rptMessageDetail_ItemDataBound" >
                        <ItemTemplate>
                            <div class="blockmes" >
                       <div class="mesbm">
                          <div class="mimg">
                              <a href="#">
                                   <img class="img-circle" src='<%# Eval("U_ProfilePic","../brandslogoThumb/{0}") %>'   alt="image" style=" width:36px; height:36px; margin-left:-10px;"/>
                              </a>
                          </div><!--mimageb-->
                          <div class="mcom">
                             <div class="m1">
                               <div class="usercom" style="width:80%;"><%# Eval("SenderName")%></div> 
                               <div class="metext" style="width:20%; text-align:right;"><asp:Label runat="server" ID="lblDate" Text='<%# Eval("DatePosted") %>'></asp:Label></div>
                             </div>
                             <div class="m1">
                                <div class="mtexts"><%# Eval("Message")%></div>
                             </div>
                             <div class="m1"></div>
                             <asp:Label ID="lblItemID" runat="server" Text='<%# Eval("ItemID") %>' Visible="False"></asp:Label>
                            <asp:Repeater runat="server" ID="rptChild">
                                <ItemTemplate>
                                    <div class="replyimgblock">
                                          <div class="repimg">
                                              <a href="itemview2?v=<%# Eval("ItemID") %>" class="fancybox"><img class="img-responsive" src="../photobank/<%# Eval("FeatureImg") %>" style="height: 150px; width: 150px;" alt="<%# Eval("Title","{0}") %>" /> </a>
                                          </div>
                                          <div class="retext wrapParagraph">
                                              <b><%# Eval("Title")%>" </b><br />
                                              By <%# Eval("Name")%>" <br />
                                              <br />
                                              <%# Eval("Description") %>" <br />
                                          </div>
                                    </div><!--replyimgblock-->
                                </ItemTemplate>
                            </asp:Repeater>
                             <!-- nested repeater -->
                           
                             
                          </div><!--mtextb-->
                      </div><!--mseb-->
                   </div><!--blockme-->
                        </ItemTemplate>
                         <FooterTemplate>
                             <asp:Image ID="lblEmptyData"  runat="server" Visible='<%# rptMessageDetail.Items.Count == 0 %>' ImageUrl="../images/no_message.png" />
                         </FooterTemplate>
                    </asp:Repeater>
                
                      <asp:SqlDataSource ID="sdsMessageDetails" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                        ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                        SelectCommand="SELECT Tbl_Mailbox.ParentID, U_Email,U_ProfilePic,SenderID,ReceiverID, U_Firstname + ' '+ U_Lastname as SenderName,MessageID,Message,DatePosted ,ItemID 
                                       FROM Tbl_MailboxMaster INNER JOIN Tbl_Mailbox ON Tbl_MailboxMaster.ParentID=Tbl_Mailbox.ParentID
                                       INNER JOIN Tbl_Users ON Tbl_Mailbox.UserID=Tbl_Users.UserID
                                       WHERE  Tbl_Mailbox.ParentID=? AND Tbl_Mailbox.SDeleted IS NULL
                                        ORDER BY  Tbl_Mailbox.MessageID" >
                          <SelectParameters>
                              <asp:CookieParameter CookieName="ParentId" Name="?" />
                          </SelectParameters>
                    </asp:SqlDataSource>  
                    <asp:SqlDataSource ID="sdsItem" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                        ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" >
                       
                    </asp:SqlDataSource>
                    
                   <div class="blockmes" >
                       <div class="mesbm">
                           <div class="mimg"><img src="#"  runat="server" ID="imgrply" class="img-circle"  style="width:36px; height:36px;"/></div><!--mimageb-->
                          <div class="mtextcom">
                             
                             <textarea runat="server" name="comments" ID="txtMessage" class="comments" placeholder="Reply to your Influencer"></textarea>
                              <asp:requiredfieldvalidator runat="server" errormessage="This field is required" ControlToValidate="txtMessage" Display="Static" ValidationGroup="gpReplyMessage"> </asp:requiredfieldvalidator>
                          </div><!--mtextb-->
                      </div><!--mseb-->
                      <div class="newmesbl" style="text-align:right; margin-top: -6px; padding-bottom:15px;">
                             <button type="button" runat="server"  ID="btnSend" class="hvr-sweep-to-rightup2" OnServerClick="btnSend_OnServerClick" ValidationGroup="gpReplyMessage">Send</button>
                            <button type="button" runat="server"  ID="btnCancel" class="hvr-sweep-to-rightup2" >Cancel</button>
                      </div><!--newmesbl--> 
                   </div><!--blockme-->
                </div>
          </div> 
      <div class="col-md-12" runat="server" ID="dvMessageDetailBoxEmpty" style="text-align:center;">
           <img src="../images/no_message.png" alt="" style="width:200px; margin-top:50px;"/>
         <%--  <p style="text-align:center"><h4 style="text-align: center; margin-top: 10%;">No Message Selected</h4></p>--%>
       </div>
       
       </div>
     <%--</asp:Panel>--%>
    <%-- <asp:Panel runat="server" ID="pnlCompose" Visible="False">--%>
       <div  id="pnlCompose11" style="display:none;">
          <div class="col-md-12">
           <div class="mesbl2" style="margin-bottom: 20px;">
             <div class="col-md-12 mesheading">New Message</div>
           </div><!--mesbl1-->
       
              <div class="newmesbl">
                  <div class="mesheading1">
                      To</div>
                  <div class="mesbl">
                      <asp:TextBox ID="txtUsername" runat="server" CssClass="logininput1" 
                          placeholder="Username" TabIndex="1" />
                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUsername" 
                          Display="Static" errormessage="This field is required" 
                          ValidationGroup="gpNewMessage"> </asp:RequiredFieldValidator>
                  </div>
              </div>
              <!--newmesbl-->
              <div class="newmesbl">
                  <div class="mesheading1">
                      Message</div>
                  <div class="mesbl">
                      <textarea ID="txtComposeMessage" runat="server" class="comments1" 
                          name="comments" TabIndex="2"></textarea>
                      <asp:RequiredFieldValidator runat="server" 
                          ControlToValidate="txtComposeMessage" Display="Static" 
                          errormessage="This field is required" ValidationGroup="gpNewMessage"> </asp:RequiredFieldValidator>
                  </div>
              </div>
              <!--newmesbl-->
              <div class="newmesbl" style="text-align:right; margin-top: -6px;">
                  <button ID="btnPostMessage" runat="server" class="hvr-sweep-to-rightup2" 
                      OnServerClick="btnPostMessage_OnServerClick" TabIndex="3" type="button" 
                      ValidationGroup="gpNewMessage">
                      Send
                  </button>
                  &nbsp;&nbsp;&nbsp;
                  <button ID="btnCancelMessage" runat="server" class="hvr-sweep-to-rightup2" 
                      type="button">
                      Cancel
                  </button>
              </div>
              <!--newmesbl--> 
    </div> 
       </div>
     <%-- </asp:Panel>--%>
    </div><!--col-md-6-->
      
    </div> <!-- wrapperblockwhitemess -->
       
<%--</div>--%><!--wrapperblock-->
    
 </ContentTemplate>
 </asp:updatepanel>
 <div class="bottomspace"></div>
<!--footer-->
  <div class="footerbg">
     <div class="row">
        <div class="col-md-11 col-xs-10">©2016 Press Preview</div>
        <div class="col-md-pull-1 col-xs-pull-1">
           <div class="f1"><a id="loaddata"></a></div>
           <div class="f2"></div>
        </div>
      </div>    
  </div><!--footer-->
  <!--#INCLUDE FILE="../includes/backtotop.txt" -->
<script src="../js/backtotop.js" type="text/javascript"></script>
  </div>

</form>
    <!-- Placed at the end of the document so the pages load faster -->
   
    <script src="../js/bootstrap.js"></script>
    <script src="../js/custom.js" type="text/javascript"></script>
   <script type="text/javascript">
       $(document).ready(function () {
           var userId = '<%= Request.Cookies["FRUserId"].Value %>';
           var viewpnl = '<%= Request.Cookies["viewpnl"].Value %>';
           if (viewpnl == "1") {

               $('#pnlCompose11').hide();
               $('#pnlMessage').show();
           } else if (viewpnl == "2") {
               $('#pnlCompose11').show();
               $('#pnlMessage').hide();
           } else {

               $('#pnlCompose11').hide();
               $('#pnlMessage').show();
           }
           $("#lbViewMessageCount").mouseover(function () {

               $.ajax({
                   type: "POST",
                   url: "massenger.aspx\\UpdateMessageStatus",
                   contentType: "application/json; charset=utf-8",
                   data: "{'userID':'" + userId + "'}",
                   dataType: "json",
                   async: true,
                   error: function (jqXhr, textStatus, errorThrown) {
                      // alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
                   },
                   success: function (msg) {
                       //                    if (msg.d == true) {

                       $('#<%=lblTotalMessages.ClientID%>').hide("slow");
                       $('#<%=lblTotalMessages.ClientID%>').val = "";
                       return false;
                   }
               });

           });


           $("#lbViewAlerts").mouseover(function () {

               $.ajax({
                   type: "POST",
                   url: "massenger.aspx\\UpdateNotifications",
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
           
           $('#btnCompose').live("click", (function (e) {

               $('#pnlCompose11').show();
               $('#pnlMessage').hide();
               window.PageMethods.SetSession('2');
               
           }));

           $('#btnCancelMessage').live("click", (function (e) {

               $('#pnlCompose11').hide();
               $('#pnlMessage').show();
                                  var width = (window.innerWidth > 0) ? window.innerWidth : screen.width;
               if (width < 767) {
                     jQuery('#UserBlock').show();
                                      jQuery('#formmess').hide();
                                      jQuery('#dvMessageDetailBoxEmpty').show();
                                        jQuery('#pnlCompose11').hide();
              $('#dvActionbar').show();
                               $('.selallm').hide();
              $('#demodmenu1').hide();
               }
               window.PageMethods.SetSession('1');

           }));

           $('#btnCancel').live("click", (function (e) {

               $('#dvMessageDetailBox').hide();
               $('#dvMessageDetailBoxEmpty').show();
                         var width = (window.innerWidth > 0) ? window.innerWidth : screen.width;
               if (width < 767) {
                  $("#UserBlock").show();
                 
                   $("#showformmes").hide();
                        $('#dvActionbar').show();
              $('#demodmenu1').hide();
               }
               window.PageMethods.SetSession('1');

           }));

       });
   </script>   
    
    <script src="../source/jquery.fancybox.pack.js" type="text/javascript"></script>
       <script type="text/javascript">
       function openCompose()
           {
             $('#pnlCompose11').show();
               $('#pnlMessage').hide();
               window.PageMethods.SetSession('2');
           }
           $(document).ready(function () {
           var width = (window.innerWidth > 0) ? window.innerWidth : screen.width;		
    if(width<767){
      $("#dvActionbar").show();
$("#demodmenu1").hide();
    }
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
                     helpers   : { 
   overlay : {closeClick: false} // prevents closing when clicking OUTSIDE fancybox 
  },
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
                       var pageUrl = 'http://presspreview.azurewebsites.net/editor/itemview2?v=' + id;
                       //window.location = pageUrl;
                       window.history.pushState('d', 't', pageUrl);
                        }

                   },
                   beforeClose: function () {
                       
                       window.history.pushState('d', 't', 'http://presspreview.azurewebsites.net/editor/massenger');
                   }
               });

           });
       </script>

<script type="text/javascript">
	$(document).ready(function () {		
   var width = (window.innerWidth > 0) ? window.innerWidth : screen.width;		
    if(width<767){		
           $("#UserBlock").css("display","block");		
      $("#formmess").css("display","none");		
    }		
});
    jQuery(".menudli1st1").live("click", (function (e) {
        e.preventDefault();
        e.stopPropagation();
        jQuery(".menudli1st1_list").not(jQuery(this).next()).hide();
        jQuery(this).next().toggle();

    }));
    jQuery(".menudli1st1_list").find("li").live("click", (function (e) {
        e.stopPropagation();
        // alert(jQuery(this).text());
    }));
    jQuery(document).live("click", (function (e) {

        jQuery(".menudli1st1_list").hide();
    }));


</script>
     <script type="text/javascript">		
         function MyFunc() {		
            		
             var width = (window.innerWidth > 0) ? window.innerWidth : screen.width;		
         		
             if (width < 767) {		
                  $('#formmess').show();	
                 $("#UserBlock").hide();		
                 $('#pnlMessage').show();		
                 window.PageMethods.SetSession('2');		
             }		
         };		
</script>
<style>
   
      @media only screen and (max-width:767px){
        
        .navbar-nav>li>.dropdown-menu {
      margin-left: -5px !important 
    }
        .blockmes1{
      display: none
    }
    #scroll{
      padding: 0 0 0 2%;
}
.mcom{
      margin-left: 5%;
}
.newmesbl button{
  margin-bottom: 5%;
}
#cmes{
      margin-top: 22px;
}
      }
</style>
  </body>
</html>


   


