<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sort.aspx.cs" Inherits="admin_home_Default" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>PP::Slider Management</title>

    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../font-awesome/css/font-awesome.css" rel="stylesheet">

    <link href="../css/animate.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">
    <link href="../../css/ReorderStyles.css" rel="stylesheet" type="text/css" />
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
                    <h2>Activity Page Slider<asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                    </h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="../home/">Home</a>
                        </li>
                        <li><a href="Default.aspx">Slider Management</a></li>
                    </ol>
                </div>
                <div class="col-lg-4 pull-right">
                    <h2>
                        <asp:LinkButton runat="server" ID="btnback" class="btn btn-sm btn-primary pull-right m-t-n-xs" style="margin:3px;"  Text="Back" PostBackUrl="Default.aspx"></asp:LinkButton>
                    </h2>
                </div>
               
            </div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                        <ProgressTemplate>
                            <div id="dvLoading" style="color:#fff">Please wait. Slider list is being reorderd.</div>
                        </ProgressTemplate>

                    </asp:UpdateProgress>
                    <div class="wrapper wrapper-content animated fadeInRight">
                 
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
                                    <div style="margin-left: 50px;"><h4>Click and drag the green handle to the left of image to reorder the list</h4></div>
                                <div class="col-lg-12 CodeMirror-scroll">
                                    
                                    <asp:ReorderList ID="ReorderList1" runat="server" AllowReorder="True" 
                     DataKeyField="BannerID" DataSourceID="SqlDataSource1" PostBackOnReorder="True" 
                     SortOrderField="SortOrder" Width="100%" 
                     onitemreorder="ReorderList1_ItemReorder" CallbackCssStyle="callbackStyle">
                     <ItemTemplate>
                          <div class="itemArea">
                           <table >
                                  <tr id="rowReorderItem">
                                      <td>
                                          <asp:Image ID="imgbanner" runat="server" 
                                                            ImageUrl='<%# Eval("BannerImg", "../../imgSmall/{0}") %>' 
                                                            CssClass="img-responsive;" Width="800px" />
                                      </td>
                                  </tr>
                              </table>
                                
                         </div>
                     </ItemTemplate>
                     <ReorderTemplate>
                         <asp:Panel ID="pnlReorder" runat="server" CssClass="reorderCue" />
                     </ReorderTemplate>
                      <DragHandleTemplate>
                <div class="dragHandle" title="Click and drag to reorder">
                    
                   <%-- <asp:Image ID="imgReorder" runat="server" AlternateText="move" ToolTip="Click and drag to reorder"
                        ImageUrl="../../images/reorder2.gif" />--%>
                </div>
            </DragHandleTemplate>
                 </asp:ReorderList>
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                        ConflictDetection="CompareAllValues" 
                                        ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                        DeleteCommand="DELETE FROM [Tbl_ActivityBanners] WHERE [BannerID] = ? AND (([BannerImg] = ?) OR ([BannerImg] IS NULL AND ? IS NULL)) AND (([SortOrder] = ?) OR ([SortOrder] IS NULL AND ? IS NULL))" 
                                        InsertCommand="INSERT INTO [Tbl_ActivityBanners] ([BannerID], [BannerImg], [SortOrder]) VALUES (?, ?, ?)" 
                                        OldValuesParameterFormatString="original_{0}" 
                                        ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                        SelectCommand="SELECT [BannerID], [BannerImg], [SortOrder] FROM [Tbl_ActivityBanners] ORDER BY [SortOrder]" 
                                        UpdateCommand="UPDATE [Tbl_ActivityBanners] SET [BannerImg] = ?, [SortOrder] = ? WHERE [BannerID] = ? AND (([BannerImg] = ?) OR ([BannerImg] IS NULL AND ? IS NULL)) AND (([SortOrder] = ?) OR ([SortOrder] IS NULL AND ? IS NULL))">
                                        <DeleteParameters>
                                            <asp:Parameter Name="original_BannerID" Type="Int32" />
                                            <asp:Parameter Name="original_BannerImg" Type="String" />
                                            <asp:Parameter Name="original_BannerImg" Type="String" />
                                            <asp:Parameter Name="original_SortOrder" Type="Int32" />
                                            <asp:Parameter Name="original_SortOrder" Type="Int32" />
                                        </DeleteParameters>
                                        <InsertParameters>
                                            <asp:Parameter Name="BannerID" Type="Int32" />
                                            <asp:Parameter Name="BannerImg" Type="String" />
                                            <asp:Parameter Name="SortOrder" Type="Int32" />
                                        </InsertParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="BannerImg" Type="String" />
                                            <asp:Parameter Name="SortOrder" Type="Int32" />
                                            <asp:Parameter Name="original_BannerID" Type="Int32" />
                                            <asp:Parameter Name="original_BannerImg" Type="String" />
                                            <asp:Parameter Name="original_BannerImg" Type="String" />
                                            <asp:Parameter Name="original_SortOrder" Type="Int32" />
                                            <asp:Parameter Name="original_SortOrder" Type="Int32" />
                                        </UpdateParameters>
                                    </asp:SqlDataSource>
                                    
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
