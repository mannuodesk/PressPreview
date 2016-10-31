<%@ Page Language="C#" AutoEventWireup="true" CodeFile="massenger.aspx.cs" Inherits="brand_massenger" %>

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
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

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
            <!--#INCLUDE FILE="../includes/messgTop.txt" --> 
         </div>   
             <ul class="nav navbar-nav" id="firstbb">
              <li><div class="gab1"></div></li>
              <li class="dropdown">
                <a href="event.aspx">Events</a>
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
                <img src="../images/menumail.png" style="margin-top:-4px;"/> Messenger
           </div>
           <div class="col-md-4 bcompose">
               <button name="compose" runat="server" id="btnCompose" class="hvr-sweep-to-rightup2" style="margin-top:6px;" OnServerClick="btnCompose_OnServerClick">Compose</button>
           </div>                     
           <div class="col-md-3 col-xs-3 bcomposeimg" id="cmes" >
                <div onclick="showformmess()"><img src="../images/addmessage.png" style="padding-top:12px; padding-left:16px"  /></div>
           </div>
           <div class="col-md-3 col-xs-3  bcomposeimg" id="acmes" style="display:none;">
                <div  onclick="showformmessa()"><img src="../images/addmessagea.png" style="padding-top:12px;  padding-left:16px"   /></div>
           </div>
           
      </div><!--mesbl1-->
      
      
      <div class="selall">        
           <div class="col-md-7 col-xs-9">
                <asp:CheckBoxList ID="chkAll2" runat="server" AutoPostBack="True" 
               OnSelectedIndexChanged="chkAll2_SelectedIndexChanged" Height="12px" Visible="False">
                <asp:ListItem Value="0">Select All</asp:ListItem>
              </asp:CheckBoxList>
           </div>
           <div class="col-md-5 col-xs-3 actiona">
           
           
<div id="demodmenu1">
 <div id="close"></div>
  <div class="l1">
    <button class="menudli1st1" id="a">Actions <i class="fa fa-cog fa-fw" aria-hidden="true" style="font-size:14px;  margin-top:-5px;"></i></button>
    <div class="menudli1st1_list" id="list1">
            <div class="mespace"></div>
            <li class="menudli1">
                <asp:LinkButton runat="server" ID="lbtnArchive"><div class="imgwidth"><img src="../images/archm.png"/></div><span class="sp">Archive</span></asp:LinkButton>
               <%-- <a href="#"><div class="imgwidth"><img src="../images/archm.png"/></div><span class="sp">Archive</span></a>--%>
            </li>
            <li class="menudli1">
                 <asp:LinkButton runat="server" ID="lbtnSpam"><div class="imgwidth"><img src="../images/markm.png"/></div><span class="sp">Mark as Spam</span></asp:LinkButton>
               <%-- <a href="#"><div class="imgwidth"><img src="../images/markm.png"/></div><span class="sp">Mark as Spam</span></a>--%>
            </li>
            <li class="menudli1">
                 <asp:LinkButton runat="server" ID="lbtnDelete"><div class="imgwidth"><img src="../images/delem.png"/></div><span class="sp">Delete Forever</span></asp:LinkButton>
                <%--<a href="#"><div class="imgwidth"><img src="../images/delem.png"/></div><span class="sp">Delete Forever</span></a>--%>
            </li>
           
            <div class="mespace"></div>
    </div>
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
                    onrowcommand="grdMessageList_RowCommand">
          <Columns>
             <asp:TemplateField>
                  <EditItemTemplate>
                      <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ReadStatus") %>'></asp:TextBox>
                  </EditItemTemplate>
                  <ItemTemplate>
                      <div class="blockme">
                        <%-- <asp:CheckBox ID="chkSelect" runat="server" CssClass="chkmes"/>--%>
                          <input type="checkbox" ID="chkSelect" runat="server" /><asp:LinkButton for="test1" ID="lbtnMessage" CssClass="chkmes" runat="server" CommandName="2" CommandArgument='<%# Eval("ParentID") + "," + Eval("MessageID") %>'>
                       <div class="mesbm">
                          <div class="mimg">
                             <img class="img-circle" src='<%# Eval("U_ProfilePic","../brandslogoThumb/{0}") %>'   alt="image" style=" width:36px; height:36px;"/>
                              <asp:ImageButton runat="server" ID="imgbtnReply"  ImageUrl="../images/arrow.png" CommandName="1" CommandArgument='<%# Eval("U_Username","{0}") %>'/>
                           <%--  <a href=""><img src="../images/arrow.png" /></a>--%>
                          </div><!--mimageb-->
                          <div class="mtextb">
                             <div class="m1">
                               <div class="muserms" style="width:70%;"><%# Eval("SenderName")%></div> 
                                <div class="metext" style="width: 30%; position: relative; text-align: right;"><asp:Label runat="server" ID="lblDate2" Text='<%# Eval("DatePosted") %>'></asp:Label></div>
                             </div>
                             <div class="m1">
                                <div class="mtexts"><%# Eval("Message")%></div>
                             </div>
                             <div class="m1"></div>
                          </div><!--mtextb-->
                      </div><!--mseb-->
                         </asp:LinkButton>
                     </div>
                  </ItemTemplate>
              </asp:TemplateField>
          </Columns>
         
          <PagerStyle CssClass="GridPager" HorizontalAlign="Left" 
              VerticalAlign="Middle" />
         
      </asp:gridview>
     
                   <asp:SqlDataSource ID="sdsMessageList" runat="server" 
    ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
    ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" SelectCommand="SELECT U_Username, U_Email, MessageID, Message, SenderName, U_ProfilePic, ParentID, Tbl_Mailbox.DatePosted, ReadStatus FROM Tbl_Users INNER JOIN Tbl_Mailbox ON Tbl_Users.UserID = Tbl_Mailbox.UserID
Where ReceiverID=?
ORDER BY  Tbl_Mailbox.DatePosted DESC">
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
             <div class="col-md-11 mesheading">Message with <span style="color:#5092c9"><asp:Label runat="server" ID="lblBrandName"></asp:Label></span></div>
             
            
           </div><!--mesbl1-->
                    <asp:Repeater runat="server" ID="rptMessageDetail" 
               DataSourceID="sdsMessageDetails" 
               onitemdatabound="rptMessageDetail_ItemDataBound">
                        <ItemTemplate>
                            <div class="blockmes" >
                       <div class="mesbm">
                          <div class="mimg">
                              <a href="#">
                                   <img class="img-circle" src='<%# Eval("U_ProfilePic","../brandslogoThumb/{0}") %>'   alt="image" style=" width:36px; height:36px;"/>
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
                             <!-- nested repeater -->
                            <%-- <div class="replyimgblock">
                                  <div class="repimg"><img src="../images/replyimg.png" /></div>
                                  <div class="retext">
                                      <b>Item's Name</b><br />
                                      By Brand Name<br />
                                      <br />
                                      Product Info lorem ipsum dolor sit amet, consectetur<br />
                                  </div>
                             </div>--%><!--replyimgblock-->
                             
                          </div><!--mtextb-->
                      </div><!--mseb-->
                   </div><!--blockme-->
                        </ItemTemplate>
                         <FooterTemplate>
                         <asp:Image ID="lblEmptyData"  runat="server" Visible='<%# ((Repeater)Container.NamingContainer).Items.Count == 0 %>' ImageUrl="../images/no_message.png" />
                     </FooterTemplate>
                    </asp:Repeater>
                      <asp:SqlDataSource ID="sdsMessageDetails" runat="server" 
    ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
    ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" SelectCommand="SELECT U_Username, U_Email, MessageID, Message, SenderName, U_ProfilePic, Tbl_Mailbox.DatePosted, ReadStatus FROM Tbl_Users INNER JOIN Tbl_Mailbox ON Tbl_Users.UserID = Tbl_Mailbox.UserID
Where ParentID=?
ORDER BY  Tbl_Mailbox.MessageID">
                       <SelectParameters>
                           <asp:CookieParameter CookieName="ParentId" Name="?" />
                       </SelectParameters>
</asp:SqlDataSource>  
                   <div class="blockmes" >
                       <div class="mesbm">
                          <div class="mimg"><img src="../images/comimg.png" /></div><!--mimageb-->
                          <div class="mtextcom">
                             <textarea runat="server" name="comments" ID="txtMessage" class="comments" placeholder="Reply to Your Brand Name"></textarea>
                              <asp:requiredfieldvalidator runat="server" errormessage="This field is required" ControlToValidate="txtMessage" Display="Static" ValidationGroup="gpNewMessage">
                 </asp:requiredfieldvalidator>
                          </div><!--mtextb-->
                      </div><!--mseb-->
                      <div class="newmesbl" style="text-align:right;">
                             <button type="button" runat="server" name="compose" ID="btnSend" class="hvr-sweep-to-rightup2" OnServerClick="btnSend_OnServerClick" ValidationGroup="gpNewMessage">Send</button>
                            <button type="button" runat="server" name="compose" ID="btnCancel" class="hvr-sweep-to-rightup2" OnServerClick="btnCancel_OnServerClick">Cancel</button>
                      </div><!--newmesbl--> 
                   </div><!--blockme-->
    
    </div> </div><!--col-md-6-->
       
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
     <script src="../js/autosize.js" type="text/javascript"></script>
    <script src="../js/jquery.timeago.js" type="text/javascript"></script> 
    <script>

        $(document).ready(function () {
            $(".metext").timeago();
            $(".mdays").timeago();
            autosize(document.querySelectorAll('textarea'));


        });
    </script>
  </body>
</html>

<script>
    jQuery(".menudli1st1").live("click", (function (e) {
        e.preventDefault();
        e.stopPropagation();
        jQuery(".menudli1st1_list").not(jQuery(this).next()).hide();
        jQuery(this).next().toggle();

    }));
    jQuery(".menudli1st1_list").find("li").live("click",(function (e) {
        e.stopPropagation();
       // alert(jQuery(this).text());
    }));
    jQuery(document).live("click",(function (e) {

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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>


