<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="admin_home_Default" %>

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
    <script type="text/javascript">
        $(document).ready(function () {
            CheckingSeassion();
        });
        function CheckingSeassion() {
            $.ajax({
                type: "POST",
                url: "Default.aspx/LogoutCheck",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == 0) {
                        window.location = "http://presspreview.azurewebsites.net/admin/login.aspx";
                    }
                },
                failure: function (msg) {
                    alert(msg);
                }
            });
        }
 </script>
</head>

<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <div id="wrapper">
    <!--#INCLUDE FILE="../includes/leftmenu.txt" -->
        
        <div id="page-wrapper" class="gray-bg">
        <div class="row border-bottom">
         <!--#INCLUDE FILE="../includes/header.txt" -->
        </div>
            <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-lg-4">
                    <h2>Dashboard</h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="../home/">Home</a>
                        </li>
                        
                    </ol>
                </div>
                <div class="col-lg-8">
                    <div class="col-lg-4 pull-right">
                    <h2>
                     <asp:LinkButton runat="server" ID="btnBrandApproval" CausesValidation="false" 
                            class="btn btn-lg btn-primary pull-right m-t-n-xs" style="margin:3px;" 
                            Text="Brands Pending" PostBackUrl="../brandapproval/Default.aspx">
                         <asp:Label runat="server" ID="lblBrandsCount" Text=" (10)"></asp:Label>
                     </asp:LinkButton>
                    
                    </h2>
                </div>
                <div class="col-lg-4 pull-right">
                    <h2>
                     <asp:LinkButton runat="server" ID="btnEditorApproval" CausesValidation="False"  class="btn btn-lg btn-primary pull-right m-t-n-xs" style="margin:3px;"  Text="Influencers Pending" PostBackUrl="../editorapproval/">
                         <asp:Label runat="server" ID="lblEditorsCount" Text=" (10)"></asp:Label>
                     </asp:LinkButton>
                    </h2>
                </div>
                </div>
                <div id="divAlerts" runat="server" class="alert" Visible="False">
                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                             <asp:Label runat="server" ID="lblStatus" for="PageMessage"   
                                 Text="" Visible="True"></asp:Label>
                </div>
            </div>
            <div class="wrapper wrapper-content animated fadeInRight">
                 <div class="row">
                    <div class="col-lg-2" style="width:20%;">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-success pull-right">Total</span>
                                <h5>Brands</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins"><asp:Label runat="server" ID="lblTotalBrands"></asp:Label></h1>
                                <small>Brands</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2" style="width:20%;">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-info pull-right">Total</span>
                                <h5>Influencers</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins"><asp:Label runat="server" ID="lblTotalEditors"></asp:Label></h1>
                                <small>Influencers</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2" style="width:20%;">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-primary pull-right">Total</span>
                                <h5>Categories</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins"><asp:Label runat="server" ID="lblTotalCategories"></asp:Label></h1>
                                <small>Categories</small>
                            </div>
                        </div>
                    </div>
                     <div class="col-lg-2" style="width:20%;">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-primary pull-right">Total</span>
                                <h5>Events</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins"><asp:Label runat="server" ID="lblTotalEvents"></asp:Label></h1>
                                <small>Events</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2" style="width:20%;">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-danger pull-right">Total</span>
                                <h5>Look Books</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins"><asp:Label runat="server" ID="lblLookBooks" Text="10"></asp:Label></h1>
                                <small>Look Books</small>
                            </div>
                        </div>
            </div>
                 </div>
                <div class="row">
                     <div class="col-lg-12">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <h5>Brands</h5>
                               
                            </div>
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
                                            DataSourceID="sdsBrands" ForeColor="Black" GridLines="Horizontal" 
                                            Width="100%" AllowSorting="True" PageSize="10">
                                            <Columns>
                                                <asp:BoundField DataField="Name" HeaderText="Brand Name" SortExpression="Name">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="U_Username" HeaderText="User Name" 
                                                    SortExpression="U_Username" />
                                                <asp:BoundField DataField="U_Email" HeaderText="Email" 
                                                    SortExpression="U_Email" />
                                                <asp:BoundField DataField="U_Password" HeaderText="Password" 
                                                    SortExpression="U_Password" />
                                                <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="City" HeaderText="City" SortExpression="City">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="PostalCode" HeaderText="PostalCode" 
                                                    SortExpression="PostalCode"></asp:BoundField>
                                            </Columns>
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

<SortedAscendingCellStyle BackColor="#F7F7F7"></SortedAscendingCellStyle>

<SortedAscendingHeaderStyle BackColor="#4B4B4B"></SortedAscendingHeaderStyle>

<SortedDescendingCellStyle BackColor="#E5E5E5"></SortedDescendingCellStyle>

<SortedDescendingHeaderStyle BackColor="#242121"></SortedDescendingHeaderStyle>
                                        </asp:GridView>
                                        </ContentTemplate>
                                    </asp:updatepanel>
                                     <asp:SqlDataSource ID="sdsBrands" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                            ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                            
                                            SelectCommand="SELECT Tbl_Users.UserID, Tbl_Users.U_Username, Tbl_Users.U_Email, Tbl_Users.U_Password, Tbl_Brands.Name, Tbl_Brands.City, Tbl_Brands.PostalCode, Tbl_Brands.Phone FROM Tbl_Users INNER JOIN Tbl_Brands ON Tbl_Users.UserID = Tbl_Brands.UserID 
WHERE (Tbl_Users.U_Type = 'Brand') AND (Tbl_Users.IsApproved=1) ORDER BY Tbl_Users.UserID DESC"></asp:SqlDataSource>
                                </div>
                                
                                       
                                
                                </div>
                                </div>

                            </div>
                        </div>
                </div>

                <div class="row">
                     <div class="col-lg-12">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <h5>Influencers</h5>
                               
                            </div>
                            <div class="ibox-content">
                                <div class="row">
                                <div class="col-lg-12 CodeMirror-scroll">
                                     <asp:updatepanel runat="server" >
                                        <ContentTemplate>
                                            <asp:UpdateProgress runat="server">
                                                <ProgressTemplate></ProgressTemplate>
                                            </asp:UpdateProgress>
                                        <asp:GridView ID="GridView2" runat="server" AllowPaging="True" 
                                            AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
                                            BorderStyle="None" BorderWidth="1px" CellPadding="4" CellSpacing="2" 
                                            CssClass="table table-striped table-bordered table-hover" 
                                            DataSourceID="sdsEditors" ForeColor="Black" GridLines="Horizontal" 
                                        Width="100%" AllowSorting="True" PageSize="10">
                                            <Columns>
                                                <asp:BoundField DataField="Name" HeaderText="Influencer Name" 
                                                    SortExpression="Name"></asp:BoundField>
                                                <asp:BoundField DataField="U_Username" HeaderText="User Name" 
                                                    SortExpression="U_Username" />
                                                <asp:BoundField DataField="U_Email" HeaderText="Email" 
                                                    SortExpression="U_Email" />
                                                <asp:BoundField DataField="U_Password" HeaderText="Password" 
                                                    SortExpression="U_Password" />
                                                <asp:BoundField DataField="HPhone" HeaderText="Phone" SortExpression="HPhone">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="City" HeaderText="City" SortExpression="City">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="PostalCode" HeaderText="Postal Code" 
                                                    SortExpression="PostalCode"></asp:BoundField>
                                            </Columns>
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

<SortedAscendingCellStyle BackColor="#F7F7F7"></SortedAscendingCellStyle>

<SortedAscendingHeaderStyle BackColor="#4B4B4B"></SortedAscendingHeaderStyle>

<SortedDescendingCellStyle BackColor="#E5E5E5"></SortedDescendingCellStyle>

<SortedDescendingHeaderStyle BackColor="#242121"></SortedDescendingHeaderStyle>
                                        </asp:GridView>
                                         </ContentTemplate>
                                        
                                    </asp:updatepanel>
                                    
                                </div>
                               
                                        <asp:SqlDataSource ID="sdsEditors" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                            ProviderName="<%$ ConnectionStrings:dbConnectionPP.ProviderName %>" 
                                            
                                            
                                        SelectCommand="SELECT Tbl_Users.UserID, Tbl_Users.U_Username, Tbl_Users.U_Email, Tbl_Users.U_Password, Tbl_Editors.Firstname + ' ' + Tbl_Editors.Lastname as Name, Tbl_Editors.City, Tbl_Editors.PostalCode, Tbl_Editors.HPhone FROM Tbl_Users INNER JOIN Tbl_Editors ON Tbl_Users.UserID = Tbl_Editors.UserID WHERE (Tbl_Users.U_Type = 'Editor') AND (Tbl_Users.IsApproved=1) ORDER BY Tbl_Users.UserID DESC"></asp:SqlDataSource>
                               
                                </div>
                                </div>

                            </div>
                        </div>
                </div>

                <div class="row">
                     <div class="col-lg-12">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <h5>Lookbooks</h5>
                               
                            </div>
                            <div class="ibox-content">
                                <div class="row">
                                <div class="col-lg-12 CodeMirror-scroll">
                                     <asp:updatepanel runat="server" >
                                        <ContentTemplate>
                                            <asp:UpdateProgress runat="server">
                                                <ProgressTemplate></ProgressTemplate>
                                            </asp:UpdateProgress>
                                        <asp:GridView ID="grdLookbooks" runat="server" AllowPaging="True" 
                                            AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
                                            BorderStyle="None" BorderWidth="1px" CellPadding="4" CellSpacing="2" 
                                            CssClass="table table-striped table-bordered table-hover" 
                                            DataSourceID="sdslookbooks" ForeColor="Black" GridLines="Horizontal" 
                                        Width="100%" AllowSorting="True" PageSize="10" 
                                                onrowdatabound="grdLookbooks_RowDataBound">
                                            <Columns>
                                                <asp:BoundField DataField="Title" HeaderText="Lookbook Title" 
                                                    SortExpression="Title"></asp:BoundField>
                                                <asp:BoundField DataField="Brand Name" HeaderText="Brand Name" 
                                                    SortExpression="Brand Name" />
                                                <asp:BoundField DataField="Category" HeaderText="Category" 
                                                    SortExpression="Category"></asp:BoundField>
                                                <asp:TemplateField HeaderText="Lookbook Items">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblLookID" runat="server" Text='<%# Eval("LookID", "{0}") %>' 
                                                            Visible="False"></asp:Label>
                                                        <asp:Label ID="lblTotal" runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
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

<SortedAscendingCellStyle BackColor="#F7F7F7"></SortedAscendingCellStyle>

<SortedAscendingHeaderStyle BackColor="#4B4B4B"></SortedAscendingHeaderStyle>

<SortedDescendingCellStyle BackColor="#E5E5E5"></SortedDescendingCellStyle>

<SortedDescendingHeaderStyle BackColor="#242121"></SortedDescendingHeaderStyle>
                                        </asp:GridView>
                                         </ContentTemplate>
                                        
                                    </asp:updatepanel>
                                    
                                </div>
                               
                                        <asp:SqlDataSource ID="sdslookbooks" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                            ProviderName="<%$ ConnectionStrings:dbConnectionPP.ProviderName %>" 
                                            
                                            
                                        
                                        SelectCommand="SELECT Tbl_Lookbooks.LookID, Tbl_Lookbooks.LookKey, Tbl_Lookbooks.Title, Tbl_Lookbooks.MainImg, Tbl_Brands.Name AS [Brand Name], Tbl_Lookbooks.Category FROM Tbl_Lookbooks INNER JOIN Tbl_Brands ON Tbl_Lookbooks.UserID = Tbl_Brands.UserID WHERE (Tbl_Lookbooks.IsPublished = 1) AND (Tbl_Lookbooks.IsDeleted IS NULL) ORDER BY Tbl_Lookbooks.LookID DESC"></asp:SqlDataSource>
                               
                                </div>
                                </div>

                            </div>
                        </div>
                </div>

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
