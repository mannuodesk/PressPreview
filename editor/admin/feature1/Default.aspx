<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="admin_home_Default" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>PP::Feature 1 Items</title>

    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../font-awesome/css/font-awesome.css" rel="stylesheet">

    <link href="../css/animate.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">
    <link href="../../css/ReorderStyles.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            SearchText();
        });

        function SearchText() {
            $("#txtName").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Default.aspx\\GetItemTitle",
                        data: "{'lbName':'" + document.getElementById('txtName').value + "', 'lbUser': '" + document.getElementById('ddbrandName').value + "'}",
                        dataType: "json",
                        success: function (data) {
                            response(data.d);
                        },
                        error: function (result) {
                            alert("No Match");
                        }
                    });
                }
            });
        }  
    </script>
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
                    <h2>Activity Page
                    <asp:scriptmanager runat="server" EnablePageMethods="True"></asp:scriptmanager>
                   
                    </h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="../home/">Home</a>
                        </li>
                        <li><a href="Default.aspx">Feature 1 Items</a></li>
                    </ol>
                </div>
                <div class="col-lg-4 pull-right">
                    <h2>
                        <%--<asp:LinkButton runat="server" ID="btnSave" class="btn btn-sm btn-primary pull-right m-t-n-xs" style="margin:3px;"  Text="Add New<i class='ace-icon fa fa-plus' style='margin-left:5px;'></i>" PostBackUrl="addnew.aspx"></asp:LinkButton>--%>
                         <asp:LinkButton runat="server" ID="btnSort" 
                            class="btn btn-sm btn-primary pull-right m-t-n-xs" style="margin:3px;"  
                            Text="Reorder Feature 1 Items&lt;i class='ace-icon fa fa-sort-amount-asc' style='margin-left:5px;'&gt;&lt;/i&gt;" 
                            PostBackUrl="sort.aspx"></asp:LinkButton>
                    </h2>
                </div>
               
            </div>
            
             <div class="wrapper wrapper-content animated fadeInRight">
               
            <div class="ibox-content m-b-sm border-bottom">
                <div class="row">
                     <div class="col-sm-4">
                        <div class="form-group">
                            <label class="control-label" for="status">Brand</label>
                            <asp:DropDownList runat="server" ID="ddbrandName" CssClass="form-control" 
                                DataSourceID="sdsbrands" DataTextField="Name" DataValueField="UserID" 
                                AppendDataBoundItems="True">
                               
                                <asp:ListItem Value="0">Select Brand</asp:ListItem>
                               
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsbrands" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                SelectCommand="SELECT DISTINCT [Name], [UserID] FROM [Tbl_Brands] WHERE (([UserID] IS NOT NULL) AND ([UserID] &gt; ?)) ORDER BY [Name]">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="0" Name="UserID" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                           
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group">
                            <label class="control-label" for="product_name">Item Name</label>
                            <asp:TextBox  runat="server"  ID="txtName"  placeholder="Item Name"  CssClass="form-control"></asp:TextBox> 
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="form-group">
                            <asp:Button runat="server" ID="btnSearch" Text="Search" 
                                CssClass="form-control btn btn-md btn-primary" style="margin-top:20px;" 
                                onclick="btnSearch_Click"/>
                           
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="form-group">
                             <asp:Button runat="server" ID="btnViewAll" Text="View All" 
                                 CssClass="form-control btn btn-md btn-primary" style="margin-top:20px;" 
                                 onclick="btnViewAll_Click"/>
                        </div>
                    </div>
                   
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <asp:Label runat="server" CssClass="control-label" ID="lblCount"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                        <ProgressTemplate>
                            <div id="dvLoading">Please wait.....</div>
                        </ProgressTemplate>

                    </asp:UpdateProgress>
                <div class="row">
                     <div id="divAlerts" runat="server" class="alert" Visible="False">
                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                             <asp:Label runat="server" ID="lblStatus" for="PageMessage"   
                                 Text="" Visible="True"></asp:Label>
                </div>
                     <div class="col-lg-12">
                        <div class="ibox float-e-margins">
                           <div class="ibox-content">
                                <div class="row">
                                <div class="col-lg-12 CodeMirror-scroll">
                                 <asp:updatepanel runat="server">
                                        <ContentTemplate>
                                            <asp:UpdateProgress runat="server">
                                                <ProgressTemplate></ProgressTemplate>
                                            </asp:UpdateProgress>
                                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                                        AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
                                        BorderStyle="None" BorderWidth="1px" CellPadding="4" CellSpacing="2" 
                                        CssClass="table table-striped table-bordered table-hover" 
                                        DataSourceID="sdsSlider" ForeColor="Black" GridLines="Horizontal" Width="100%" 
                                        OnRowCommand="GridView1_RowCommand" 
                                        onrowdatabound="GridView1_RowDataBound" AllowSorting="True" 
                                        EmptyDataText=" No record found !" ShowHeaderWhenEmpty="True" >
                                        <Columns>
                                            <asp:TemplateField HeaderText="Item Main Image">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("FeatureImg") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <div class="ibox" style="margin-bottom:0px;">
                                                          <div class="ibox-content product-box" style="width:100px;">
                                                                <div class="product-imitation">
                                                                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("FeatureImg", "../../photobank/{0}") %>' style="width:100px;"/>
                                                                </div>
                                                                <%--<div class="product-desc" style="padding:0px;">
                                                                    <span class="product-price" style="float:none; width: 100%;text-align: center;">
                                                                        <%# Eval("Title", "{0:d}") %> 
                                                                    </span>
                                                                </div>--%>
                                                           </div>
                                                      </div>
                                                  
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                                            <asp:BoundField DataField="Name" HeaderText="Brand Name" 
                                                SortExpression="Name" >
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="IsFeatured1" SortExpression="IsFeatured1">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("IsFeatured1") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFeature1" runat="server" Text='<%# Bind("IsFeatured1") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Display Order" SortExpression="SortOrder">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("SortOrder") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSortOrder" runat="server" Text='<%# Bind("SortOrder") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                             <asp:TemplateField>
                                                <ItemTemplate>
                                                 <asp:Button runat="server" ID="btnMF" CommandName="1" CommandArgument='<%# Eval("ItemID", "{0}") %>'  Text="Mark as Feature 1" CssClass="form-control btn btn-md btn-primary" style="width:160px;" />
                                              <%--   <asp:LinkButton ID="lblMark" runat="server"  
                                                        Text="<i class='ace-icon fa fa-star fa-2x'></i>" 
                                                             CssClass="col-xs-4 col-sm-1 btn btn-yellow" ToolTip="Mark as Feature 1 Item" Width="40">
                                                    </asp:LinkButton>--%>
                                                    <%-- <asp:LinkButton ID="lblUnMark" runat="server"  CommandName="2" CommandArgument='<%# Eval("ItemID", "{0}") %>' 
                                                        Text="<i class='ace-icon fa fa-star fa-2x'></i>" 
                                                             CssClass="col-xs-4 col-sm-1 btn btn-sm btn-black" ToolTip="Un Mark as Feature 1 Item" Width="40">
                                                    </asp:LinkButton>--%>
                                                     <asp:Button runat="server" ID="btnUMF" CommandName="2" CommandArgument='<%# Eval("ItemID", "{0}") %>'  Text="UnMark as Feature 1" CssClass="form-control btn btn-md btn-primary" style="width:160px;"/>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <EmptyDataRowStyle Height="100px" HorizontalAlign="Center" 
                                            VerticalAlign="Middle" />
                                        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                        <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                        <PagerSettings FirstPageText="First" LastPageText="Last" 
                                            Mode="NumericFirstLast" />
                                        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" 
                                            CssClass="GridPager" />
                                        <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                        <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                        <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                        <SortedDescendingHeaderStyle BackColor="#242121" />
                                        <sortedascendingcellstyle backcolor="#F7F7F7" />
                                        <sortedascendingheaderstyle backcolor="#4B4B4B" />
                                        <sorteddescendingcellstyle backcolor="#E5E5E5" />
                                        <sorteddescendingheaderstyle backcolor="#242121" />
                                        <sortedascendingcellstyle backcolor="#F7F7F7" />
                                        <sortedascendingheaderstyle backcolor="#4B4B4B" />
                                        <sorteddescendingcellstyle backcolor="#E5E5E5" />
                                        <sorteddescendingheaderstyle backcolor="#242121" />
                                        <sortedascendingcellstyle backcolor="#F7F7F7" />
                                        <sortedascendingheaderstyle backcolor="#4B4B4B" />
                                        <sorteddescendingcellstyle backcolor="#E5E5E5" />
                                        <sorteddescendingheaderstyle backcolor="#242121" />
                                        <sortedascendingcellstyle backcolor="#F7F7F7" />
                                        <sortedascendingheaderstyle backcolor="#4B4B4B" />
                                        <sorteddescendingcellstyle backcolor="#E5E5E5" />
                                        <sorteddescendingheaderstyle backcolor="#242121" />
                                        <sortedascendingcellstyle backcolor="#F7F7F7" />
                                        <sortedascendingheaderstyle backcolor="#4B4B4B" />
                                        <sorteddescendingcellstyle backcolor="#E5E5E5" />
                                        <sorteddescendingheaderstyle backcolor="#242121" />
                                    </asp:GridView>
                                    
                                     </ContentTemplate>
                                    </asp:updatepanel>
                                    <asp:SqlDataSource ID="sdsSlider" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                        ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                        SelectCommand="SELECT Tbl_Items.ItemID, Tbl_Items.Title, Tbl_Items.Description, CASE(IsFeatured1) WHEN 1 THEN 'Yes' ELSE 'No' END as IsFeatured1 , Tbl_Items.SortOrder, Tbl_Brands.Name, Tbl_Items.FeatureImg FROM Tbl_Items 
INNER JOIN Tbl_Brands ON Tbl_Items.UserID = Tbl_Brands.UserID 
WHERE (Tbl_Items.IsPublished = 1) AND (Tbl_Items.IsDeleted IS NULL) AND IsFeatured2 IS NULL"></asp:SqlDataSource>
                                        
                                     <asp:SqlDataSource ID="sdsSearchByBoth" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                        ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                        
                                        
                                        
                                        SelectCommand="SELECT Tbl_Items.ItemID, Tbl_Items.Title, Tbl_Items.Description, CASE(IsFeatured1) WHEN 1 THEN 'Yes' ELSE 'No' END as IsFeatured1 , Tbl_Items.SortOrder, Tbl_Brands.Name, Tbl_Items.FeatureImg FROM Tbl_Items INNER JOIN Tbl_Brands ON Tbl_Items.UserID = Tbl_Brands.UserID WHERE (Tbl_Items.IsPublished = 1) AND (Tbl_Items.IsDeleted IS NULL) AND IsFeatured2 IS NULL AND (Tbl_Items.UserID=? AND Tbl_Items.Title LIKE ? +'%')">
                                         <SelectParameters>
                                             <asp:ControlParameter ControlID="ddbrandName" Name="?" 
                                                 PropertyName="SelectedValue" />
                                             <asp:ControlParameter ControlID="txtName" Name="?" PropertyName="Text" />
                                         </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:SqlDataSource ID="sdsSearchBrandOnly" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                        ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                        SelectCommand="SELECT Tbl_Items.ItemID, Tbl_Items.Title, Tbl_Items.Description, CASE(IsFeatured1) WHEN 1 THEN 'Yes' ELSE 'No' END as IsFeatured1 , Tbl_Items.SortOrder, Tbl_Brands.Name, Tbl_Items.FeatureImg FROM Tbl_Items INNER JOIN Tbl_Brands ON Tbl_Items.UserID = Tbl_Brands.UserID WHERE (Tbl_Items.IsPublished = 1) AND (Tbl_Items.IsDeleted IS NULL) AND IsFeatured2 IS NULL AND (Tbl_Items.UserID=? )">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="ddbrandName" Name="?" 
                                                PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:SqlDataSource ID="sdsSearchItemOnly" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                        ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                        SelectCommand="SELECT Tbl_Items.ItemID, Tbl_Items.Title, Tbl_Items.Description, CASE(IsFeatured1) WHEN 1 THEN 'Yes' ELSE 'No' END as IsFeatured1 , Tbl_Items.SortOrder, Tbl_Brands.Name, Tbl_Items.FeatureImg FROM Tbl_Items INNER JOIN Tbl_Brands ON Tbl_Items.UserID = Tbl_Brands.UserID WHERE (Tbl_Items.IsPublished = 1) AND (Tbl_Items.IsDeleted IS NULL) AND IsFeatured2 IS NULL AND  Tbl_Items.Title LIKE ? +'%'">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="txtName" Name="?" PropertyName="Text" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                                
                                </div>
                                </div>

                            </div>
                        </div>
                </div>               
                </ContentTemplate>
            </asp:UpdatePanel>
           </div>
                
            
        <div class="footer">
             <div>
                 <strong>Copyright</strong> Press Preview &copy; <%: DateTime.Now.Year %>-<%: DateTime.Now.Year+1 %>
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
