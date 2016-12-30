<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="admin_home_Default" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>PP :: Notifications</title>

    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../font-awesome/css/font-awesome.css" rel="stylesheet">

    <link href="../css/animate.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">

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
                <div class="col-lg-10">
                    <h2>Dashboard</h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="../home/">Home</a>
                        </li>
                        <li>
                            <a href="#">Notifications</a>
                        </li>
                        
                    </ol>
                </div>
                <div class="col-lg-2">
                     <h2>
                        <asp:LinkButton runat="server" ID="btnSave" class="btn btn-sm btn-primary pull-right m-t-n-xs" style="margin:3px;"  Text="Add New<i class='ace-icon fa fa-plus' style='margin-left:5px;'></i>" PostBackUrl="addnew.aspx"></asp:LinkButton>
                    </h2>
                </div>
               
            </div>
            <div class="wrapper wrapper-content animated fadeInRight">                
                <div class="row">
                     <div class="col-lg-12">
                          <div id="divAlerts" runat="server" class="alert" Visible="False">
                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                             <asp:Label runat="server" ID="lblStatus" for="PageMessage"   
                                 Text="" Visible="True"></asp:Label>
                </div>
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <h5>Notifications</h5>
                               
                            </div>
                            <div class="ibox-content">
                                <div class="row">
                                <div class="col-lg-12 CodeMirror-scroll">
                       
                         <asp:GridView ID="grdAllNotifications" runat="server" AutoGenerateColumns="False" 
                            DataSourceID="sdsAllNotifications" GridLines="None" 
                            onrowdatabound="grdNotifications_RowDataBound" ShowHeader="False" CellPadding="4" CellSpacing="4" Width="100%" OnRowCommand="grdAllNotifications_RowCommand">
                            <Columns>
                                <asp:TemplateField HeaderText="Fullname" SortExpression="Fullname">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Fullname") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                     
                                            <div class="col-sm-9" style="margin-bottom:30px;" >
                                                <a href="../profile/edit.aspx?v=<%# Eval("UserID")%>" class="pull-left">
                                                    <img alt="image" class="img-circle" style="width:50px; height:50px;" src='<%# Eval("U_ProfilePic","../../profilethumbs/{0}") %>'>
                                                </a>
                                                &nbsp;&nbsp;&nbsp;<div style="margin-left: 80px;" class="col-sm-7">
                                                    <small class="pull-right"><asp:Label runat="server" ID="lblDatePosted" Text='<%# Bind("DatePosted") %>'></asp:Label></small>
                                                  <span><%# Eval("Title") %></span> . <br>
                                                    <small class="text-muted"><asp:Label runat="server" ID="lblDatePosted2" Text='<%# Bind("DatePosted") %>'></asp:Label></small>
                                                </div>
                                            </div>
                                        <div class="col-sm-3 pull-right">
                                            <asp:LinkButton ID = "LinkButton1" runat="server" OnClientClick="return confirm('Are you sure, you want to delete ?')" CommandName="2" CommandArgument='<%# Eval("NotifyID", "{0}") %>'
                                                Text="<i class='ace-icon fa fa-trash fa-2x'></i>"
                                                CssClass="col-xs-4 col-sm-1 btn btn-sm" ToolTip="Remove Notification" Width="40">                                                       
                                            </asp:LinkButton>
                                        </div>
                                                                              
                                        
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsAllNotifications" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                            ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" SelectCommand="SELECT Distinct Tbl_Notifications.NotifyID, Tbl_Users.UserID, Title,U_ProfilePic,Tbl_Notifications.DatePosted From 
Tbl_Users INNER JOIN Tbl_Notifications ON Tbl_Users.UserID=Tbl_Notifications.UserID 
ORDER BY Tbl_Notifications.DatePosted DESC">
                           
                        </asp:SqlDataSource>
						
                   
                                </div>
                                
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
