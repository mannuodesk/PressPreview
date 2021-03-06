﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="brands.aspx.cs" Inherits="admin_home_Default" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>PP ::Add Brand Message</title>

    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../font-awesome/css/font-awesome.css" rel="stylesheet">

    <link href="../css/animate.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">

</head>

<body>
    <form id="form1" runat="server">
    <div id="wrapper">
    <!--#INCLUDE FILE="../includes/leftmenu.txt" -->

        <div id="page-wrapper" class="gray-bg">
        <div class="row border-bottom">
         <!--#INCLUDE FILE="../includes/header.txt" -->
        </div>
            <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-lg-8">
                    <h2>Brands Messages</h2>
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                    <ol class="breadcrumb">
                        <li>
                            <a href="../home/">Home</a>
                        </li>
                        <li><a href="Default.aspx">Brands</a> List</li>
                    </ol>
                </div>
                <div class="col-lg-4">
                    <h2>
                        <asp:LinkButton runat="server" ID="btnSave" 
                            class="btn btn-sm btn-primary pull-right m-t-n-xs" style="margin:3px;"  
                            Text="Add New<i class='ace-icon fa fa-plus' style='margin-left:5px;'></i>" 
                            PostBackUrl="addnew.aspx" Visible="False"></asp:LinkButton>
                    </h2>
                </div>
              
            </div>
             <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                        <ProgressTemplate>
                            <div id="dvLoading">Please wait.....</div>
                        </ProgressTemplate>

                    </asp:UpdateProgress>
            <div class="wrapper wrapper-content animated fadeInRight">

                <div class="row">
                    <div id="divAlerts" runat="server" class="alert" visible="False">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                            Text="" Visible="True"></asp:Label>
                    </div>
                    <div class="col-lg-12">
                        <div class="ibox float-e-margins">
                            <div class="ibox-content">
                                <div class="row">
                                    <div class="col-lg-12 CodeMirror-scroll">
                                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" CellSpacing="2" CssClass="table table-striped table-bordered table-hover" DataSourceID="sdsBrands" ForeColor="Black" GridLines="Horizontal" Width="100%">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Dp" SortExpression="Logo">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Logo") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("Logo", "../../brandslogoThumb/{0}") %>' Width="50px" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                                <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                                                <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                                                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbEdit" runat="server" CommandName="1" CommandArgument='<%# Eval("UserID", "{0}") %>' PostBackUrl='<%# Eval("UserID", "mailbox.aspx?v={0}") %>'
                                                            Text="<i class='ace-icon fa fa-eye fa-2x'></i>"
                                                            CssClass="col-xs-4 col-sm-1 btn btn-sm" ToolTip="View Brands Messages" Width="40">                                                       
                                                        </asp:LinkButton>
                                                       
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="120px" />
                                                    <ItemStyle Width="120px" />
                                                </asp:TemplateField>
                                            </Columns>
                                            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                                            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                            <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                            <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                            <SortedDescendingHeaderStyle BackColor="#242121" />
                                            <sortedascendingcellstyle backcolor="#F7F7F7" />
                                            <sortedascendingheaderstyle backcolor="#4B4B4B" />
                                            <sorteddescendingcellstyle backcolor="#E5E5E5" />
                                            <sorteddescendingheaderstyle backcolor="#242121" />
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="sdsBrands" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                            ProviderName="<%$ ConnectionStrings:dbConnectionPP.ProviderName %>" SelectCommand="SELECT BrandID, UserID, Tbl_Brands.Name, Tbl_Brands.Logo, Tbl_Brands.Address, Tbl_Brands.Phone, Tbl_Brands.Email

FROM    Tbl_Brands 
ORDER BY Name"></asp:SqlDataSource>
                                    </div>

                                </div>
                            </div>

                        </div>
                    </div>
                </div>

            </div>
                    </ContentTemplate>
            </asp:UpdatePanel>
        <div class="footer">
             <div>
                <strong>Copyrightt</strong> Press Preview &copy; <%: DateTime.Now.Year %>-<%: DateTime.Now.Year+1 %>
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
                url: $(location).attr('pathname')+"\\Default.aspx\\UpdateNotifications",
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
