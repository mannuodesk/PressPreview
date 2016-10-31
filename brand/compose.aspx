<%@ Page Language="C#" AutoEventWireup="true" CodeFile="compose.aspx.cs" Inherits="brand_compose" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Compose Message</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../css/checkbox.css"/>
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
 <script src="../js/jquery.autocomplete.js" type="text/javascript"></script>
 <script type="text/javascript">
     $(document).ready(function () {
         
         $("#<%=txtUsername.ClientID%>").autocomplete("Search.ashx", {
             width: 200,
             formatItem: function (data, i, n, value) {
                 return "<div style='width:40px; float:left; height:40px;'><img style = 'width:36px;height:36px; border-radius:50%;' src= ../brandslogoThumb/" + value.split(",")[1] + "></div> <div> <b>" + value.split(",")[0] + "</b><br/>  @" + value.split(",")[2] + "</div> ";
             },
             formatResult: function (data, value) {
                 return value.split(",")[0];
             }
         });
     });
</script>  
<style type="text/css">
    .ac_results {
        width: 53% !important;     
    background: #eee!important;
        height: 40px!important;
        overflow:hidden !important;
        font-size: 12px !important;
    }
    .ac_results li {
        height: 40px;
        padding: 2px;
        margin-left: 20px;
    }
    .ac_results li:hover {
        background: #ccc;
    }
</style>  
</head>

<body>
<form runat="server" ID="frmCompose">
    <asp:scriptmanager runat="server">
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
            <!--#INCLUDE FILE="../includes/messgTop.txt" -->            
         <div class="col-md-3">   
           
         </div>   
             <ul class="nav navbar-nav" id="firstbb">
              <li><div class="gab1"></div></li>
              <li class="dropdown">
                <a href="events.aspx">Events</a>
              </li>
              
              <li class="dropdown">
                     <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Create</a>
                 <ul class="dropdown-menu">
                  <li><a href="add-item.aspx"><img src="" /><span class="sp"> Item</span></a></li>
                  <li><a href="create-lookbook.aspx"><img src="" /><span class="sp"> Lookbook</span></a></li>
                </ul>
              </li>
            </ul>
                        
              <!--#INCLUDE FILE="../includes/settings.txt" -->  
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>

    </div><!--header bg-->
<!--Headerend-->
<!--text-->
<asp:updatepanel runat="server">
      <ContentTemplate>
        <div class="wrapperblockwhite">

            <div class="col-md-4 col-sm-12 col-xs-12 mesblock">
      <div class="mesbl1">
           <div class="col-md-8 col-xs-9  mesheading" style="padding-bottom:8px;">
                <ul class="nav navbar-nav navbar-left">
		     <li style="margin-top:15px;"><asp:Image ImageUrl="../images/msg.png"  ID="imgFolders" runat="server"/>  <asp:Label runat="server" ID="lblFoldername"  Text="Inbox"></asp:Label></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="margin-left: -15px; padding-top: 0px; padding-bottom: 0px; margin-top: 10px;" role="button" aria-haspopup="true" aria-expanded="false">
                 <span> <img src="../images/triangle.png" /></span></a>
                <ul class="dropdown-menu" style="margin-top: -2px; min-width: 130px;margin-left: -97px;">
                  <li> <asp:LinkButton runat="server" ID="menuItemInbox" OnClick="menuItemInbox_OnClick"><img src="../images/msg.png"/><span class="sp"> Inbox</span></asp:LinkButton></li>
                  <li><asp:LinkButton runat="server" ID="menuItemArchive" OnClick="menuItemArchive_OnClick"><img src="../images/archm.png"/><span class="sp"> Archive</span></asp:LinkButton></li>
                  <li><asp:LinkButton runat="server" ID="menuItemSpam" OnClick="menuItemSpam_OnClick"><img src="../images/markm.png"/><span class="sp"> Spam</span></asp:LinkButton></li>
                </ul>
              </li>
            </ul> 
           </div>
           <div class="col-md-4 bcompose">
               <button name="compose" runat="server" id="btnCompose" class="hvr-sweep-to-rightup2" style="margin-top:6px;" OnServerClick="btnSend_OnServerClick">Compose</button>
           </div>                     
           <div class="col-md-3 col-xs-3 bcomposeimg" id="cmes" >
                <div onclick="showformmess()"><img src="../images/addmessage.png" style="padding-top:12px; padding-left:16px"  /></div>
           </div>
           <div class="col-md-3 col-xs-3  bcomposeimg" id="acmes" style="display:none;">
                <div  onclick="showformmessa()"><img src="../images/addmessagea.png" style="padding-top:12px;  padding-left:16px"   /></div>
           </div>
           
      </div><!--mesbl1-->
      
      
      <div ID="dvActionBar" class="selall" runat="server">        
           <div class="col-md-7 col-xs-9">
                <asp:CheckBoxList ID="chkAll2" runat="server" AutoPostBack="True" 
               OnSelectedIndexChanged="chkAll2_SelectedIndexChanged" Height="12px" >
                <asp:ListItem Value="0">Select All</asp:ListItem>
              </asp:CheckBoxList>
           </div>
           <div class="col-md-5 col-xs-3 actiona">
           
           
<div id="demodmenu1">
 <div id="close"></div>
  <div class="l1" style="float:none; left:0;" runat="server" ID="dvInboxActions">
      <ul class="nav navbar-nav navbar-right">
		     <li> <asp:Label runat="server"   Text="Actions"></asp:Label></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="margin-left: -15px; margin-top: -8px; padding-bottom: 0; padding-top: 0;" role="button" aria-haspopup="true" aria-expanded="false">
                 <span> <img src="../images/triangle.png" /></span></a>
                <ul class="dropdown-menu" style="margin-top: -2px;">
                  <li>  <asp:LinkButton runat="server" ID="lbtnArchive" OnClick="lbtnArchive_OnClick"><div class="imgwidth"><img src="../images/archm.png"/></div><span class="sp">Archive</span></asp:LinkButton></li>
                   <li>  <asp:LinkButton runat="server" ID="lbtnRead" OnClick="lbtnRead_OnClick"><div class="imgwidth"><img src="../images/views.png"/></div><span class="sp">Mark as Read</span></asp:LinkButton> </li>
                  <li> <asp:LinkButton runat="server" ID="lbtnSpam" OnClick="lbtnSpam_OnClick"><div class="imgwidth"><img src="../images/markm.png"/></div><span class="sp">Mark as Spam</span></asp:LinkButton></li>
                  <li> <asp:LinkButton runat="server" ID="lbtnDelete" OnClick="lbtnDelete_OnClick"><div class="imgwidth"><img src="../images/delem.png"/></div><span class="sp">Delete Forever</span></asp:LinkButton></li>
                </ul>
              </li>
            </ul>
   
  </div>
  <div class="l1" runat="server" ID="dvArchiveActions">
       <ul class="nav navbar-nav navbar-right">
		     <li> <asp:Label runat="server"   Text="Actions"></asp:Label></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="margin-left: -15px; margin-top: -8px; padding-bottom: 0; padding-top: 0;" role="button" aria-haspopup="true" aria-expanded="false">
                 <span> <img src="../images/triangle.png" /></span></a>
                <ul class="dropdown-menu" style="margin-top: -2px;">
                  <li>  <asp:LinkButton runat="server" ID="lbtnInbox" OnClick="lbtnInbox_OnClick"><div class="imgwidth"><img src="../images/archm.png"/></div><span class="sp">Inbox</span></asp:LinkButton> </li>
                   <li>  <asp:LinkButton runat="server" ID="lbtnReadArchive" OnClick="lbtnReadArchive_OnClick"><div class="imgwidth"><img src="../images/views.png"/></div><span class="sp">Mark as Read</span></asp:LinkButton> </li>
                  <li> <asp:LinkButton runat="server" ID="lbtnSpamArchive" OnClick="lbtnSpamArchive_OnClick"><div class="imgwidth"><img src="../images/markm.png"/></div><span class="sp">Mark as Spam</span></asp:LinkButton></li>
                  <li> <asp:LinkButton runat="server" ID="lbtnDeleteArchive" OnClick="lbtnDeleteArchive_OnClick"><div class="imgwidth"><img src="../images/delem.png"/></div><span class="sp">Delete Forever</span></asp:LinkButton></li>
                </ul>
              </li>
            </ul>
    
  </div>
  <div class="l1" runat="server" ID="dvSpamActions">
       <ul class="nav navbar-nav navbar-right">
		     <li> <asp:Label runat="server"   Text="Actions"></asp:Label></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="margin-left: -15px; margin-top: -8px; padding-bottom: 0; padding-top: 0;" role="button" aria-haspopup="true" aria-expanded="false">
                 <span> <img src="../images/triangle.png" /></span></a>
                <ul class="dropdown-menu" style="margin-top: -2px;">
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
      
      
       <div class="selallm">        
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
    <div id="showformmes" style="display:none;">
       <div class="col-md-12">
           <div class="mesbl2">
             <div class="col-md-11 col-xs-12  mesheading">Message with <span style="color:#5092c9"></span></div>
            
           </div><!--mesbl1-->
       
                    <div class="blockmes" >
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
                   
                   <div class="blockmes" >
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
                   
                   <div class="blockmes" >
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
                   
                   <div class="blockmes" >
                       <div class="mesbm">
                          <div class="mimg"><img src="images/comimg.png" /></div><!--mimageb-->
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
                          <div class="mimg"><img src="images/comimg.png" /></div><!--mimageb-->
                          <div class="mtextcom">
                             <textarea name="comments" id="comments" class="comments" placeholder="Reply to Your Brand Name"></textarea>
                          </div><!--mtextb-->
                          <div class="newmesbl" style="text-align:right;">
                             <button type="submit" name="compose" id="compose" class="hvr-sweep-to-rightup2">Send</button>&nbsp;&nbsp;&nbsp;
                             <button type="submit" name="compose" id="compose" class="hvr-sweep-to-rightup2">Cancel</button>
                      </div><!--newmesbl--> 
                      </div><!--mseb-->
                   </div><!--blockme-->
    
    </div> </div><!--col-md-8--> 
 <!--- mobile form-->  
       <%--<asp:Repeater runat="server" ID="rptMessages" DataSourceID="sdsMessageList" 
                    onitemdatabound="rptMessages_ItemDataBound" >
           <ItemTemplate>
              
           </ItemTemplate>
       </asp:Repeater>--%>
     <asp:gridview runat="server" ID="grdMessageList" 
    AutoGenerateColumns="False" DataSourceID="sdsMessageList" Width="100%" 
          GridLines="None" ShowHeader="False" AllowPaging="True" 
                    onrowdatabound="grdMessageList_RowDataBound" PageSize="5" 
                    onrowcommand="grdMessageList_OnRowCommand" EmptyDataText="No Message">
          <Columns>
             
             <asp:TemplateField>
                  <EditItemTemplate>
                      <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ReadStatus") %>'></asp:TextBox>
                  </EditItemTemplate>
                  <ItemTemplate>
                      <div class="blockme">
                         <input type="checkbox" ID="chkSelect" runat="server"  /><label for="test1" class="chkmes"><asp:LinkButton for="test1" ID="lbtnMessage" CssClass="chkmes" runat="server" CommandName="2" CommandArgument='<%# Eval("ParentID") + "," + Eval("MessageID") %>'>
                       <div class="mesbm">
                          <div class="mimg">
                             <img class="img-circle" src='<%# Eval("U_ProfilePic","../brandslogoThumb/{0}") %>'   alt="image" style=" width:36px; height:36px;"/>
                              <asp:ImageButton runat="server" ID="imgbtnReply"  ImageUrl="../images/arrow.png" CommandName="1" CommandArgument='<%# Eval("ParentID") + "," + Eval("MessageID") %>'/>
                           <%--  <a href=""><img src="../images/arrow.png" /></a>--%>
                          </div><!--mimageb-->
                          <div class="mtextb">
                             <div class="m1">
                               <div class='muserms  <%# Eval("MessageStatus") %>' style="width:70%;"><%# Eval("SenderName")%> </div> 
                                <div class='metext  <%# Eval("MessageStatus") %>' style="width: 30%; position: relative; text-align: right;"><asp:Label runat="server" ID="lblDate2" Text='<%# Eval("DatePosted") %>'></asp:Label></div>
                             </div>
                             <div class='m1 <%# Eval("MessageStatus") %>'>
                                <div class='mtexts  <%# Eval("MessageStatus") %>'><%# Eval("Message")%></div>
                             </div>
                             <div class="m1"></div>
                          </div><!--mtextb-->
                      </div><!--mseb-->
                         </asp:LinkButton>
                         </label>
                     </div>
                  </ItemTemplate>
              </asp:TemplateField>
          </Columns>
         
          <EmptyDataRowStyle Height="100px" HorizontalAlign="Center" 
              VerticalAlign="Middle" />
         
          <PagerStyle CssClass="GridPager" HorizontalAlign="Left" 
              VerticalAlign="Middle" />
         
      </asp:gridview>
     
                   <asp:SqlDataSource ID="sdsMessageList" runat="server" 
    ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
    ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                    
                    SelectCommand="SELECT U_Username, U_Email, m.MessageID, m.Message, m.SenderName, U_ProfilePic,m.ParentID, m.DatePosted,m.MessageStatus  FROM Tbl_Users
                                    INNER JOIN Tbl_Mailbox m ON Tbl_Users.UserID = m.UserID 
                                    WHERE MessageID in (SELECT max(MessageID) FROM Tbl_Mailbox GROUP BY ParentID,ReceiverID ) AND ReceiverID=?  AND MessageType IS NULL order by MessageID desc" 
                    >
                       <SelectParameters>
                           <asp:CookieParameter CookieName="FRUserID" Name="?" />
                       </SelectParameters>
</asp:SqlDataSource>          
  </div><!--col-md-6-->
            <div class="col-md-8" id="formmess">
      <div id="divAlerts" runat="server" class="alert" visible="False">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                Text="" Visible="True"></asp:Label>
        </div>
       <div class="col-md-12">
           <div class="mesbl2">
             <div class="col-md-12 mesheading">New Message</div>
           </div><!--mesbl1-->
       
        <form name="messform" action="" id="messform">     
          <div class="newmesbl">
             <div class="mesheading1">To</div>
             <div class="mesbl">
                 <asp:TextBox ID="txtUsername" CssClass="logininput1" placeholder="Username"  runat="server"/>
                 <asp:requiredfieldvalidator runat="server" errormessage="This field is required" ControlToValidate="txtUsername" Display="Static" ValidationGroup="gpNewMessage">
                 </asp:requiredfieldvalidator>
             </div>
          </div><!--newmesbl--> 
          
          <div class="newmesbl">
             <div class="mesheading1">Message</div>
             <div class="mesbl">
                 <textarea runat="server" name="comments" ID="txtMessage" class="comments1"></textarea>
                <asp:requiredfieldvalidator runat="server" errormessage="This field is required" ControlToValidate="txtMessage" Display="Static" ValidationGroup="gpNewMessage">
                 </asp:requiredfieldvalidator>
             </div>
          </div><!--newmesbl--> 
          
          <div class="newmesbl" style="text-align:right;">
             <button type="button" runat="server" name="compose" ID="btnSend" class="hvr-sweep-to-rightup2" OnServerClick="btnSend_OnServerClick" ValidationGroup="gpNewMessage">Send</button>&nbsp;&nbsp;&nbsp;
             <button type="button" runat="server" name="compose" ID="btnCancel" class="hvr-sweep-to-rightup2" OnServerClick="btnCancel_OnServerClick">Cancel</button>
          </div><!--newmesbl--> 
        </form> 
    </div> 
    
 </div><!--col-md-6-->
      
</div><!--wrapperblock-->
   </ContentTemplate>       
    </asp:updatepanel> 
<!--footer-->
  <div class="footerbg">
     <div class="row">
        <div class="col-md-11 col-xs-10">©2016 Press Preview</div>
        <div class="col-md-pull-1 col-xs-pull-1">
           <div class="f1"><a id="loaddata"><img src="../images/footerarrow.png" /></a></div>
           <div class="f2"><a id="loaddatan">Expand</a></div>
        </div>
      </div>    
  </div><!--footer-->
<!--footer-->

</div><!--wrapper-->
</form>
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="../js/bootstrap.js"></script>
<script>
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

    jQuery(".menudli2st2").click(function (e) {
        e.stopPropagation();
        jQuery(".menudli2st2_list").not(jQuery(this).next()).hide();
        jQuery(this).next().toggle();

    });
    jQuery(".menudli2st2_list").find("li").click(function (e) {
        e.stopPropagation();
        alert(jQuery(this).text());
    });
    jQuery(document).click(function (e) {

        jQuery(".menudli2st2_list").hide();
    });
</script>
    
<script type="application/javascript" src="../js/custom.js"></script>
<script src="../js/autosize.js" type="text/javascript"></script>
    <script src="../js/jquery.timeago.js" type="text/javascript"></script> 
    <script>

        $(document).ready(function () {
            $(".metext").timeago();
            autosize(document.querySelectorAll('textarea'));
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            var userId = '<%= Request.Cookies["FRUserId"].Value %>';
            $("#lbViewMessageCount").mouseover(function () {

                $.ajax({
                    type: "POST",
                    url: $(location).attr('pathname') + "\\UpdateMessageStatus",
                    contentType: "application/json; charset=utf-8",
                    data: "{'userID':'" + userId + "'}",
                    dataType: "json",
                    async: true,
                    error: function (jqXhr, textStatus, errorThrown) {
                        alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
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
                    url: $(location).attr('pathname') + "\\UpdateNotifications",
                    contentType: "application/json; charset=utf-8",
                    data: "{'userID':'" + userId + "'}",
                    dataType: "json",
                    async: true,
                    error: function (jqXhr, textStatus, errorThrown) {
                        alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
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

  </body>
</html>



