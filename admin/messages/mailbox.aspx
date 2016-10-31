<%@ Page Language="C#" AutoEventWireup="true" CodeFile="mailbox.aspx.cs" Inherits="admin_home_Default" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PP :: Dashboard</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="../css/animate.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">
    <link href="../css/ajaxtabs.css" rel="stylesheet" type="text/css" />
    
</head>

<body>
    <form id="form1" runat="server" role="form">
    <div id="wrapper">
    <!--#INCLUDE FILE="../includes/leftmenu.txt" -->

        <div id="page-wrapper" class="gray-bg">
        <div class="row border-bottom">
         <!--#INCLUDE FILE="../includes/header.txt" -->
        </div>
            <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-lg-8">
                    <h2>Mailbox</h2>
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                    <ol class="breadcrumb">
                        <li>
                            <a href="../home/">Home</a>
                        </li>
                        
                    </ol>
                </div>
                <div class="col-lg-4 pull-right">
                    <h2>
                    
                    </h2>
                </div>
                
            </div>
            <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                        <ProgressTemplate>
                            <div id="dvLoading">Please wait.....</div>
                        </ProgressTemplate>

                    </asp:UpdateProgress>--%>
            <div class="wrapper wrapper-content animated fadeInRight">
                  <div class="col-lg-12">
                        <div class="ibox float-e-margins">
                           <div class="ibox-content"> 
                <div class="row">
                      <div id="divAlerts" runat="server" class="alert" Visible="False">
                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                             <asp:Label runat="server" ID="lblStatus" for="PageMessage"   
                                 Text="" Visible="True"></asp:Label>
                </div>
									<div id="user-profile-3" class="user-profile">
										<div class="col-sm-offset-1 col-sm-10">
											<div class="tabbable">
                                                <ul class="nav nav-tabs padding-16">
                                                    <li class="active"><a data-toggle="tab" runat="server" id="tab1" href="#edit-basic"><i class="green ace-icon fa fa-sign-in bigger-125"></i>Inbox </a></li>
                                                    <li><a data-toggle="tab" runat="server" id="tab2" href="#edit-password"><i class="blue ace-icon fa fa-sign-out bigger-125"></i>Outbox </a></li>
                                                    <li><a data-toggle="tab" runat="server" id="tab3" href="#archive"><i class="blue ace-icon fa fa-archive bigger-125"></i>Archive </a></li>
                                                     <li><a data-toggle="tab" runat="server" id="tab4" href="#spam"><i class="blue ace-icon fa fa-flag-o bigger-125"></i>Spam </a></li>
                                                </ul>
                                                <div class="tab-content profile-edit-tab-content">
                                                   
                                                    <div id="edit-basic" class="tab-pane in active" style="margin-top:30px;">
                                                     <asp:updatepanel runat="server">
                                                        <ContentTemplate>
                                                     <div class="col-md-2">
                                                         <asp:CheckBoxList ID="chkAllInbox" runat="server" AutoPostBack="True" 
               OnSelectedIndexChanged="chkAll2_SelectedIndexChanged" >
                <asp:ListItem Value="0">Select All</asp:ListItem>
              </asp:CheckBoxList>
                                                     </div> 
                                                     <div class="col-md-2">
                                                         <asp:LinkButton ID="btnDeleteAllInbox" runat="server" OnClientClick="return confirm('Are you sure, you want to delete ?')" OnClick="btnDeleteAll_OnClick" 
                                                        Text="<i class='ace-icon fa fa-trash fa-2x'></i>" 
                                                             CssClass="col-xs-4 col-sm-1 btn btn-sm" ToolTip="Delete Message" Width="40"
                                                        >                                                       
                                                    </asp:LinkButton>
                                                     </div>  
                                        <asp:GridView ID="grdInbox" runat="server" AllowPaging="True" 
                                            AutoGenerateColumns="False" CellPadding="4" 
                                            CssClass="table table-striped table-bordered table-hover" 
                                            DataSourceID="sdsInbox" ForeColor="#333333" GridLines="None" Width="100%" 
                                                            ShowHeader="False" onrowdatabound="grdInbox_RowDataBound" 
                                                            onrowcommand="grdInbox_RowCommand" PageSize="15" 
                                                            EmptyDataText="Inbox tab is empty">
                                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkSelect" runat="server"  Height="20px"  Width="20px"/>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                                </asp:TemplateField>
                                              
                                              <asp:TemplateField HeaderText="U_ProfilePic" SortExpression="U_ProfilePic">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("U_ProfilePic") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                         <img class="img-circle" src='<%# Eval("U_ProfilePic","../../brandslogoThumb/{0}") %>'   alt="image" style=" width:36px; height:36px;"/>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="SenderName" SortExpression="SenderName">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("SenderName") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("SenderName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Message" SortExpression="Message">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Message") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Message") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="DatePosted" SortExpression="DatePosted">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("DatePosted") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDate" runat="server" Text='<%# Bind("DatePosted") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                         <asp:LinkButton ID="lbView" runat="server" CommandName="1"  PostBackUrl='<%# Eval("ParentID", "view.aspx?v={0}") %>'
                                                        Text="<i class='ace-icon fa fa-eye fa-2x'></i>" 
                                                             CssClass="col-xs-4 col-sm-1 btn btn-sm" ToolTip="View Message" Width="40">                                                       
                                                    </asp:LinkButton>
                                                     <asp:LinkButton ID="lbDelete" runat="server" OnClientClick="return confirm('Are you sure, you want to delete ?')" CommandName="2" CommandArgument='<%# Eval("MessageID", "{0}") %>' 
                                                        Text="<i class='ace-icon fa fa-trash fa-2x'></i>" 
                                                             CssClass="col-xs-4 col-sm-1 btn btn-sm" ToolTip="Delete Message" Width="40">                                                       
                                                    </asp:LinkButton>
                                                    </ItemTemplate>
                                                   
                                                </asp:TemplateField>
                                               
                                            </Columns>
                                            <EditRowStyle BackColor="#999999" />
                                            <EmptyDataRowStyle Height="100px" HorizontalAlign="Center" 
                                                VerticalAlign="Middle" />
                                            <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" 
                                                CssClass="GridPager" />
                                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                            <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                            <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                            <SortedDescendingHeaderStyle BackColor="#242121" />

                                            <SortedAscendingCellStyle BackColor="#E9E7E2"></SortedAscendingCellStyle>
                                            <SortedAscendingHeaderStyle BackColor="#506C8C"></SortedAscendingHeaderStyle>
                                            <SortedDescendingCellStyle BackColor="#FFFDF8"></SortedDescendingCellStyle>
                                            <SortedDescendingHeaderStyle BackColor="#6F8DAE"></SortedDescendingHeaderStyle>
                                        </asp:GridView>
                                                        
                                                       
                                                        
                                        <asp:SqlDataSource ID="sdsInbox" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                            ProviderName="<%$ ConnectionStrings:dbConnectionPP.ProviderName %>"   SelectCommand="SELECT Tbl_Mailbox.ParentID, U_Email,U_ProfilePic,SenderID,Tbl_Mailbox.ParentID
                                            ReceiverID,SenderName,MessageID,Message,DatePosted , MessageStatus 
                                            FROM Tbl_Mailbox INNER JOIN Tbl_MailboxMaster ON Tbl_MailboxMaster.ParentID=Tbl_Mailbox.ParentID
                                            INNER JOIN Tbl_Users ON Tbl_MailboxMaster.SenderID=Tbl_Users.UserID 
                                            WHERE MessageID IN (SELECT MAX(MessageID) From Tbl_Mailbox Group By ParentID) AND ReceiverID=? AND BlockStatus IS NULL AND MessageType IS NULL" >
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="?" QueryStringField="v" />
                                            </SelectParameters>
                                         </asp:SqlDataSource>
                                                     </ContentTemplate>       
                                                        </asp:updatepanel>     
                                                    </div>
                                                     
                                                     
                                                    
                                                    <div id="edit-password" class="tab-pane" style="margin-top:30px;">
                                                         <asp:updatepanel runat="server">
                                                        <ContentTemplate>
                                                      <div class="col-md-2">
                                                         <asp:CheckBoxList ID="chkAllOutbox" runat="server" AutoPostBack="True" 
               OnSelectedIndexChanged="chkAllOutbox_OnSelectedIndexChanged" >
                <asp:ListItem Value="0">Select All</asp:ListItem>
              </asp:CheckBoxList>
                                                     </div> 
                                                     <div class="col-md-2">
                                                         <asp:LinkButton ID="btnDeleteAllOutbox" runat="server" OnClientClick="return confirm('Are you sure, you want to delete ?')" OnClick="btnDeleteAllOutbox_OnClick" 
                                                        Text="<i class='ace-icon fa fa-trash fa-2x'></i>" 
                                                             CssClass="col-xs-4 col-sm-1 btn btn-sm" ToolTip="Delete Message" Width="40"
                                                        >                                                       
                                                    </asp:LinkButton>
                                                     </div>    
                                                      <asp:GridView ID="grdOutbox" runat="server" AllowPaging="True" 
                                            AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
                                            BorderStyle="None" BorderWidth="1px" CellPadding="4" CellSpacing="2" 
                                            CssClass="table table-striped table-bordered table-hover" 
                                            DataSourceID="sdsOutbox" ForeColor="Black" GridLines="Horizontal" Width="100%" 
                                                            ShowHeader="False" onrowdatabound="grdOutbox_OnRowDataBound" 
                                                            onrowcommand="grdOutbox_OnRowCommand" PageSize="15" EmptyDataText="Outbox tab is empty">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkSelect" runat="server"  Height="20px"  Width="20px"/>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                                </asp:TemplateField>
                                              
                                              <asp:TemplateField HeaderText="U_ProfilePic" SortExpression="U_ProfilePic">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("U_ProfilePic") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                         <img class="img-circle" src='<%# Eval("U_ProfilePic","../../brandslogoThumb/{0}") %>'   alt="image" style=" width:36px; height:36px;"/>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="SenderName" SortExpression="SenderName">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("SenderName") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("SenderName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Message" SortExpression="Message">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Message") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Message") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="DatePosted" SortExpression="DatePosted">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("DatePosted") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDate" runat="server" Text='<%# Bind("DatePosted") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                         <asp:LinkButton ID="lbView" runat="server" CommandName="1"  PostBackUrl='<%# Eval("ParentID", "view.aspx?v={0}") %>'
                                                        Text="<i class='ace-icon fa fa-eye fa-2x'></i>" 
                                                             CssClass="col-xs-4 col-sm-1 btn btn-sm" ToolTip="View Message" Width="40"
                                                        >                                                       
                                                    </asp:LinkButton>
                                                     <asp:LinkButton ID="lbDelete" runat="server" OnClientClick="return confirm('Are you sure, you want to delete ?')" CommandName="2" CommandArgument='<%# Eval("MessageID", "{0}") %>' 
                                                        Text="<i class='ace-icon fa fa-trash fa-2x'></i>" 
                                                             CssClass="col-xs-4 col-sm-1 btn btn-sm" ToolTip="Delete Message" Width="40"
                                                        >                                                       
                                                    </asp:LinkButton>
                                                    </ItemTemplate>
                                                   
                                                </asp:TemplateField>
                                               
                                            </Columns>
                                            <EmptyDataRowStyle Height="100px" HorizontalAlign="Center" 
                                                VerticalAlign="Middle" />
                                            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                            <PagerSettings Mode="NumericFirstLast" />
                                            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" 
                                                CssClass="GridPager" />
                                            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                            <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                            <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                            <SortedDescendingHeaderStyle BackColor="#242121" />

<SortedAscendingCellStyle BackColor="#F7F7F7"></SortedAscendingCellStyle>

<SortedAscendingHeaderStyle BackColor="#4B4B4B"></SortedAscendingHeaderStyle>

<SortedDescendingCellStyle BackColor="#E5E5E5"></SortedDescendingCellStyle>

<SortedDescendingHeaderStyle BackColor="#242121"></SortedDescendingHeaderStyle>
                                        </asp:GridView>
                                                        
                                                       
                                                        
                                        <asp:SqlDataSource ID="sdsOutbox" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                            ProviderName="<%$ ConnectionStrings:dbConnectionPP.ProviderName %>"   SelectCommand="SELECT Tbl_Mailbox.ParentID, U_Email,U_ProfilePic,SenderID,Tbl_Mailbox.ParentID
                                            ReceiverID,ReceiverName as [SenderName],MessageID,Message,DatePosted , MessageStatus 
                                            FROM Tbl_Mailbox INNER JOIN Tbl_MailboxMaster ON Tbl_MailboxMaster.ParentID=Tbl_Mailbox.ParentID
                                            INNER JOIN Tbl_Users ON Tbl_MailboxMaster.SenderID=Tbl_Users.UserID 
                                            WHERE MessageID IN (SELECT MAX(MessageID) From Tbl_Mailbox Group By ParentID) AND SenderID=? AND BlockStatus IS NULL AND MessageType IS NULL" >
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="?" QueryStringField="v" />
                                            </SelectParameters>
                                         </asp:SqlDataSource>
                                         </ContentTemplate>       
                                                    </asp:updatepanel> 
                                                    </div>
                                                    
                                                    
                                                    <div id="archive" class="tab-pane" style="margin-top:30px;">
                                                        <asp:updatepanel runat="server">
                                                    <ContentTemplate>
                                                      <div class="col-md-2">
                                                         <asp:CheckBoxList ID="chkAllArchive" runat="server" AutoPostBack="True" 
               OnSelectedIndexChanged="chkAllArchive_OnSelectedIndexChanged" >
                <asp:ListItem Value="0">Select All</asp:ListItem>
              </asp:CheckBoxList>
                                                     </div> 
                                                     <div class="col-md-2">
                                                         <asp:LinkButton ID="btnDeleteAllArchive" runat="server" OnClientClick="return confirm('Are you sure, you want to delete ?')" OnClick="btnDeleteAllArchive_OnClick" 
                                                        Text="<i class='ace-icon fa fa-trash fa-2x'></i>" 
                                                             CssClass="col-xs-4 col-sm-1 btn btn-sm" ToolTip="Delete Message" Width="40"
                                                        >                                                       
                                                    </asp:LinkButton>
                                                     </div>    
                                                      <asp:GridView ID="grdArchive" runat="server" AllowPaging="True" 
                                            AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
                                            BorderStyle="None" BorderWidth="1px" CellPadding="4" CellSpacing="2" 
                                            CssClass="table table-striped table-bordered table-hover" 
                                            DataSourceID="sdsArchive" ForeColor="Black" GridLines="Horizontal" Width="100%" 
                                                            ShowHeader="False" onrowdatabound="grdArchive_OnRowDataBound" 
                                                            onrowcommand="grdArchive_OnRowCommand" PageSize="15" EmptyDataText="Archive tab is empty">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkSelect" runat="server"  Height="20px"  Width="20px"/>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                                </asp:TemplateField>
                                              
                                              <asp:TemplateField HeaderText="U_ProfilePic" SortExpression="U_ProfilePic">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("U_ProfilePic") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                         <img class="img-circle" src='<%# Eval("U_ProfilePic","../../brandslogoThumb/{0}") %>'   alt="image" style=" width:36px; height:36px;"/>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="SenderName" SortExpression="SenderName">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("SenderName") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("SenderName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Message" SortExpression="Message">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Message") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Message") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="DatePosted" SortExpression="DatePosted">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("DatePosted") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDate" runat="server" Text='<%# Bind("DatePosted") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                         <asp:LinkButton ID="lbView" runat="server" CommandName="1"  PostBackUrl='<%# Eval("ParentID", "view.aspx?v={0}") %>'
                                                        Text="<i class='ace-icon fa fa-eye fa-2x'></i>" 
                                                             CssClass="col-xs-4 col-sm-1 btn btn-sm" ToolTip="View Message" Width="40"
                                                        >                                                       
                                                    </asp:LinkButton>
                                                     <asp:LinkButton ID="lbDelete" runat="server" OnClientClick="return confirm('Are you sure, you want to delete ?')" CommandName="2" CommandArgument='<%# Eval("MessageID", "{0}") %>' 
                                                        Text="<i class='ace-icon fa fa-trash fa-2x'></i>" 
                                                             CssClass="col-xs-4 col-sm-1 btn btn-sm" ToolTip="Delete Message" Width="40"
                                                        >                                                       
                                                    </asp:LinkButton>
                                                    </ItemTemplate>
                                                   
                                                </asp:TemplateField>
                                               
                                            </Columns>
                                            <EmptyDataRowStyle Height="100px" HorizontalAlign="Center" 
                                                VerticalAlign="Middle" />
                                            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                            <PagerSettings Mode="NumericFirstLast" />
                                            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" 
                                                CssClass="GridPager" />
                                            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                            <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                            <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                            <SortedDescendingHeaderStyle BackColor="#242121" />

<SortedAscendingCellStyle BackColor="#F7F7F7"></SortedAscendingCellStyle>

<SortedAscendingHeaderStyle BackColor="#4B4B4B"></SortedAscendingHeaderStyle>

<SortedDescendingCellStyle BackColor="#E5E5E5"></SortedDescendingCellStyle>

<SortedDescendingHeaderStyle BackColor="#242121"></SortedDescendingHeaderStyle>
                                        </asp:GridView>
                                                        
                                                       
                                                        
                                        <asp:SqlDataSource ID="sdsArchive" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                            ProviderName="<%$ ConnectionStrings:dbConnectionPP.ProviderName %>" SelectCommand="SELECT Tbl_Mailbox.ParentID, U_Email,U_ProfilePic,SenderID,Tbl_Mailbox.ParentID
                                            ReceiverID,SenderName,MessageID,Message,DatePosted , MessageStatus 
                                            FROM Tbl_Mailbox INNER JOIN Tbl_MailboxMaster ON Tbl_MailboxMaster.ParentID=Tbl_Mailbox.ParentID
                                            INNER JOIN Tbl_Users ON Tbl_MailboxMaster.SenderID=Tbl_Users.UserID 
                                            WHERE MessageID IN (SELECT MAX(MessageID) From Tbl_Mailbox Group By ParentID) AND ReceiverID=? AND BlockStatus IS NULL AND MessageType='A'" >
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="?" QueryStringField="v" />
                                            </SelectParameters>
                                         </asp:SqlDataSource>
                                          </ContentTemplate>       
                                                    </asp:updatepanel>
                                                    </div>
                                                    <div id="Div1" class="tab-pane" style="margin-top:30px;">
                                                        <asp:updatepanel runat="server">
                                                    <ContentTemplate>
                                                      <div class="col-md-2">
                                                         <asp:CheckBoxList ID="chkAllSpam" runat="server" AutoPostBack="True" 
               OnSelectedIndexChanged="chkAllSpam_OnSelectedIndexChanged" >
                <asp:ListItem Value="0">Select All</asp:ListItem>
              </asp:CheckBoxList>
                                                     </div> 
                                                     <div class="col-md-2">
                                                         <asp:LinkButton ID="btnDeleteAllSpam" runat="server" OnClientClick="return confirm('Are you sure, you want to delete ?')" OnClick="btnDeleteAllSpam_OnClick" 
                                                        Text="<i class='ace-icon fa fa-trash fa-2x'></i>" 
                                                             CssClass="col-xs-4 col-sm-1 btn btn-sm" ToolTip="Delete Message" Width="40"
                                                        >                                                       
                                                    </asp:LinkButton>
                                                     </div>    
                                                      <asp:GridView ID="grdSpam" runat="server" AllowPaging="True" 
                                            AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
                                            BorderStyle="None" BorderWidth="1px" CellPadding="4" CellSpacing="2" 
                                            CssClass="table table-striped table-bordered table-hover" 
                                            DataSourceID="sdsSpam" ForeColor="Black" GridLines="Horizontal" Width="100%" 
                                                            ShowHeader="False" onrowdatabound="grdSpam_OnRowDataBound" 
                                                            onrowcommand="grdSpam_OnRowCommand" PageSize="15" EmptyDataText="Archive tab is empty">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkSelect" runat="server"  Height="20px"  Width="20px"/>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                                </asp:TemplateField>
                                              
                                              <asp:TemplateField HeaderText="U_ProfilePic" SortExpression="U_ProfilePic">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("U_ProfilePic") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                         <img class="img-circle" src='<%# Eval("U_ProfilePic","../../brandslogoThumb/{0}") %>'   alt="image" style=" width:36px; height:36px;"/>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="SenderName" SortExpression="SenderName">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("SenderName") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("SenderName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Message" SortExpression="Message">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Message") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Message") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="DatePosted" SortExpression="DatePosted">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("DatePosted") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDate" runat="server" Text='<%# Bind("DatePosted") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                         <asp:LinkButton ID="lbView" runat="server" CommandName="1"  PostBackUrl='<%# Eval("ParentID", "view.aspx?v={0}") %>'
                                                        Text="<i class='ace-icon fa fa-eye fa-2x'></i>" 
                                                             CssClass="col-xs-4 col-sm-1 btn btn-sm" ToolTip="View Message" Width="40"
                                                        >                                                       
                                                    </asp:LinkButton>
                                                     <asp:LinkButton ID="lbDelete" runat="server" OnClientClick="return confirm('Are you sure, you want to delete ?')" CommandName="2" CommandArgument='<%# Eval("MessageID", "{0}") %>' 
                                                        Text="<i class='ace-icon fa fa-trash fa-2x'></i>" 
                                                             CssClass="col-xs-4 col-sm-1 btn btn-sm" ToolTip="Delete Message" Width="40"
                                                        >                                                       
                                                    </asp:LinkButton>
                                                    </ItemTemplate>
                                                   
                                                </asp:TemplateField>
                                               
                                            </Columns>
                                            <EmptyDataRowStyle Height="100px" HorizontalAlign="Center" 
                                                VerticalAlign="Middle" />
                                            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                            <PagerSettings Mode="NumericFirstLast" />
                                            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" 
                                                CssClass="GridPager" />
                                            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                            <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                            <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                            <SortedDescendingHeaderStyle BackColor="#242121" />

<SortedAscendingCellStyle BackColor="#F7F7F7"></SortedAscendingCellStyle>

<SortedAscendingHeaderStyle BackColor="#4B4B4B"></SortedAscendingHeaderStyle>

<SortedDescendingCellStyle BackColor="#E5E5E5"></SortedDescendingCellStyle>

<SortedDescendingHeaderStyle BackColor="#242121"></SortedDescendingHeaderStyle>
                                        </asp:GridView>
                                                        
                                                       
                                                        
                                        <asp:SqlDataSource ID="sdsSpam" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                            ProviderName="<%$ ConnectionStrings:dbConnectionPP.ProviderName %>" SelectCommand="SELECT Tbl_Mailbox.ParentID, U_Email,U_ProfilePic,SenderID,Tbl_Mailbox.ParentID
                                            ReceiverID,SenderName,MessageID,Message,DatePosted , MessageStatus 
                                            FROM Tbl_Mailbox INNER JOIN Tbl_MailboxMaster ON Tbl_MailboxMaster.ParentID=Tbl_Mailbox.ParentID
                                            INNER JOIN Tbl_Users ON Tbl_MailboxMaster.SenderID=Tbl_Users.UserID 
                                            WHERE MessageID IN (SELECT MAX(MessageID) From Tbl_Mailbox Group By ParentID) AND ReceiverID=?  AND MessageType='S'" >
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="?" QueryStringField="v" />
                                            </SelectParameters>
                                         </asp:SqlDataSource>
                                          </ContentTemplate>       
                                                    </asp:updatepanel>
                                                    </div>
                                                </div>
                                            </div>
										</div><!-- /.span -->
									</div>

									<!-- /.col -->
								</div>  
                               </div>
                            </div>
                      </div>             

           </div>
            
        <%-- <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                                                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />--%>
        <div class="footer">
             <div>
                <strong>Copyright</strong> Press Preview &copy; <%--</ContentTemplate>
            </asp:UpdatePanel>--%>-<%: DateTime.Now.Year %>
            </div>
        </div>
        </div>        
    </div>

    <!-- Mainly scripts -->
    <script src="../js/jquery-2.1.1.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="../js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
                 
    <!-- Flot -->
    <script src="../js/plugins/flot/jquery.flot.js"></script>
    <script src="../js/plugins/flot/jquery.flot.tooltip.min.js"></script>
    <script src="../js/plugins/flot/jquery.flot.spline.js"></script>
    <script src="../js/plugins/flot/jquery.flot.resize.js"></script>
    <script src="../js/plugins/flot/jquery.flot.pie.js"></script>
    <script src="../js/plugins/flot/jquery.flot.symbol.js"></script>
    <script src="../js/plugins/flot/jquery.flot.time.js"></script>

    <!-- Peity -->
    <script src="../js/plugins/peity/jquery.peity.min.js"></script>
    <script src="../js/demo/peity-demo.js"></script>

    <!-- Custom and plugin javascript -->
    <script src="../js/inspinia.js"></script>
    <script src="../js/plugins/pace/pace.min.js"></script>

    <!-- jQuery UI -->
    <script src="../js/plugins/jquery-ui/jquery-ui.min.js"></script>

    <!-- Jvectormap -->
    <script src="../js/plugins/jvectormap/jquery-jvectormap-2.0.2.min.js"></script>
    <script src="../js/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>

    <!-- EayPIE -->
    <script src="../js/plugins/easypiechart/jquery.easypiechart.js"></script>

    <!-- Sparkline -->
    <script src="../js/plugins/sparkline/jquery.sparkline.min.js"></script>

    <!-- Sparkline demo data  -->
    <script src="../js/demo/sparkline-demo.js"></script>
        <script type="text/javascript">
    $(document).ready(function () {
        $("#lbViewAlerts").click(function () {
            var userId = '<%= Session["UserID"] %>';
            $.ajax({
                type: "POST",
                url: $(location).attr('pathname')+"\\UpdateNotifications",
                contentType: "application/json; charset=utf-8",
                data: "{'userID':'" + userId + "'}",
                dataType: "json",
                async: true,
                error: function (jqXhr, textStatus, errorThrown) {
                    alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
                },
                success: function (msg) {
                    //                    if (msg.d == true) {

                    $('#<%=lblTotalNotifications.ClientID%>').hide("slow");;
                    return false;  
                }
            });
           
        });
    });
    </script>
    </form>
</body>
</html>
