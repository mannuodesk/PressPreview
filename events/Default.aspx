<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="events_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Press Preview - Events List</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../css/checkbox.css"/>
<link rel="stylesheet" href="../css/bootstrap-select.css">
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
<script type="application/javascript" src="../js/custom.js"></script>



</head>

<body>
<form runat="server" ID="frm_Events">
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
            
            
         <div class="col-md-4">   
            <ul class="nav navbar-nav" id="firstb">
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><img src="../images/menumail.png" /></a>
                <ul class="dropdown-menu"  id="emailblock"><li>
                      <div class="mesb">
                        <div class="mtext3"><a href="../Massenger-Page.html">Your Messages</a></div> 
                        <div class="mtext2"> | &nbsp; <a href="../Compose-Page.html">Compose</a></div>
                       </div> 
                   </li>
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
                  
                  <li><a href="../Massenger-Page.html"><div class="mtext1">See All Messages <img src="..images/seeall.png" /></div></a></li>
                  
                </ul>
              
              <li class="dropdown" style="margin-top:-5px;">
                <a href="#"><img src="../images/alram.png" /></a>
              </li>
            </ul>
         </div>   
            
             <ul class="nav navbar-nav" id="firstbb">
              <li><div class="gab1"></div></li>
              <li class="dropdown">
                <a href="../events/">Event</a>
              </li>
              
              <li class="dropdown">
                     <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Create</a>
                 <ul class="dropdown-menu">
                  <li><a href="../brand/add-item.aspx"><img src="" /><span class="sp"> Item</span></a></li>
                  <li><a href="../brand/createLookbook.aspx"><img src="" /><span class="sp"> Lookbook</span></a></li>
                </ul>
              </li>
            </ul>
                        
              <!--#INCLUDE FILE="../includes/settings.txt" -->

          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>

    </div><!--header bg-->
<!--Headerend-->
<div class="seacrheventblock">
   <div class="sevblock">
      
            <div class="seventinputb"><input type="text" runat="server" ID="txtEventTitle" placeholder="Search For Events" name="sevents" class="logineb" /></div>
            <%----%>
            <div class="seventinputb">
                <asp:DropDownList ID="ddCity" runat="server" CssClass="loginebsn" DataSourceID="sdsCity" 
                    DataTextField="ECity" DataValueField="ECity" AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Search By City</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsCity" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                    ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                    SelectCommand="SELECT Distinct [ECity] FROM [Tbl_Events] Where [ECity] IS NOT NULL ORDER BY ECity">
                </asp:SqlDataSource>
            </div>
            <div class="seventinputb">
                <asp:DropDownList ID="ddCategory" runat="server" CssClass="loginebsn" DataSourceID="sdsCategory" 
                    DataTextField="ECategory" DataValueField="ECategoryID" 
                    AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Search By City</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsCategory" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                    ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                    SelectCommand="SELECT DISTINCT [ECategoryID],[ECategory] FROM [Tbl_EventCategory] ORDER BY [ECategory]">
                </asp:SqlDataSource>
            </div>
            <div class="seventinputb1"><button type="submit" runat="server" name="login" ID="buteventl" OnServerClick="btnSearch_OnServerClick" class="hvr-sweep-to-righta1">Search</button></div>
     
    </div>   
    <div>
         <div id="divAlerts" runat="server" class="alert" visible="False">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                Text="" Visible="True"></asp:Label> 
        </div> 
    </div>
</div><!--searcheventblock-->

<!--text-->

<div class="wrappereventlist">
      <div class="col-md-12 col-xs-12 etitle">
        Upcoming Events
      </div><!--col-md-12-->
    
        <asp:datalist runat="server" DataKeyField="EventID" DataSourceID="sdsEvent" 
          RepeatColumns="3" RepeatDirection="Horizontal" ID="dlEvents" Width="100%">
            <ItemTemplate>
                  <div class="ntlistbev">
                       <div class="listimge"><a href='<%# Eval("EventID","eventdetails.aspx?e={0}") %>'><img src='<%# Eval("EFeaturePic","../eventpics/{0}") %>' width="353px" height="171px"/></a></div>
                       <div class="elistdate"><asp:Label runat="server" 
                               Text='<%# Eval("StartDate", "{0:D}") %>' ID="lblDate"></asp:Label> 
                           <asp:Label runat="server" 
                               Text='<%# Eval("StartTime", "{0}") %>' ID="lblTime"></asp:Label></div>
                       <div class="elisttitle"><a href='<%# Eval("EventID","eventdetails.aspx?e={0}") %>'><%# Eval("EventTitle") %></a></div>
                       <div class="elistdate"><%# Eval("ELocation") %></div>  
                  </div>
                
            </ItemTemplate>
        </asp:datalist> 
        <asp:SqlDataSource ID="sdsEvent" runat="server" 
          ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
          ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
          SelectCommand="SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where EventTitle IS NOT NULL ">
      </asp:SqlDataSource>
       
        <asp:SqlDataSource ID="sdsSearchEvents" runat="server" 
          ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
          ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
          SelectCommand="">
           
      </asp:SqlDataSource>
       
       <%-- <div class="ntlistbev">
           <div class="listimge"><a href=""><img src="images/eventlistimg.png" width="100%"/></a></div>
           <div class="elistdate">Sat, April 8 8:00 PM</div>
           <div class="elisttitle"><a href="">A Long Event Name Will Stack In Two Line Here</a></div>
           <div class="elistdate">Name of Place Here</div>
        </div>--%>

        
        
    
</div><!--wrappereventlist-->

<!--text-->  

<!--footer-->
  <div class="footerbg">
     <div class="starter-template">
        <div class="col-md-12">©2016 Press Preview</div>
     </div>    
  </div><!--footer-->
<!--footer-->

</div><!--wrapper-->
       
</form>
</body>
</html>
