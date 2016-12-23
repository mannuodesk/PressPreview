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
                    <h2>Events</h2>
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                    <ol class="breadcrumb">
                        <li>
                            <a href="../home/">Home</a>
                        </li>
                        <li><a href="Default.aspx">Events</a></li>
                    </ol>
                </div>
                <div class="col-lg-4">
                    <h2>
                        <asp:LinkButton runat="server" ID="btnSave" 
                            class="btn btn-sm btn-primary pull-right m-t-n-xs" style="margin:3px;"  
                            Text="Add New<i class='ace-icon fa fa-plus' style='margin-left:5px;'></i>" 
                             onclick="btnSave_Click"></asp:LinkButton>
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
                                        <asp:SqlDataSource ID="sdsBrands" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                            ProviderName="<%$ ConnectionStrings:dbConnectionPP.ProviderName %>" 
                                            SelectCommand="SELECT EventID, EventTitle, StartDate, StartTime, EndDate,EndTime, EFeaturePic, ECategory,ELocation FROM Tbl_Events Where IsSaved=1 ORDER BY DatePosted DESC"></asp:SqlDataSource>
                                        <asp:Repeater ID="rptEvents" runat="server" DataSourceID="sdsBrands" 
                                            onitemcommand="rptEvents_ItemCommand">
                                            <ItemTemplate>
                                                <div class="col-md-3">
                    <div class="ibox">
                        <div class="ibox-content product-box">

                            <div class="product-imitation">
                                 <asp:Image ID="Image1" runat="server" 
                                                            ImageUrl='<%# Eval("EFeaturePic", "../../eventpics/{0}") %>' Width="200px" />
                            </div>
                            <div class="product-desc">
                                <span class="product-price">
                                    <%# Eval("StartDate", "{0:d}") %> <%# Eval("StartTime")%>
                                </span>
                                <small class="text-muted"><%# Eval("ECategory","{0}") %></small>
                                <a href="#" class="product-name"><%# Eval("EventTitle","{0}") %></a>



                                <div class="small m-t-xs">
                                    Location: <%# Eval("ELocation", "{0}")%>
                                </div>
                                <div class="m-t text-righ">
                                 <asp:LinkButton ID="lbEdit" runat="server" CommandName="1" CommandArgument='<%# Eval("EventID", "{0}") %>' PostBackUrl='<%# Eval("EventID", "edit.aspx?v={0}") %>'
                                                            Text="<i class='ace-icon fa fa-pencil fa-2x'></i>"
                                                            CssClass="btn btn-xs btn-outline btn-primary" ToolTip="Edit Event" Width="40">                                                       
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="return confirm('Are you sure, you want to delete ?')" CommandName="2" CommandArgument='<%# Eval("EventID", "{0}") %>'
                                                            Text="<i class='ace-icon fa fa-trash fa-2x'></i>"
                                                            CssClass="btn btn-xs btn-outline btn-primary" ToolTip="Remove Event" Width="40">                                                       
                                                        </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                                
                                            </ItemTemplate>
                                        </asp:Repeater>
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
