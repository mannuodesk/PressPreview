<%@ Page Language="C#" AutoEventWireup="true" CodeFile="addnew.aspx.cs" Inherits="admin_home_Default" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>PP :: Add New Brand</title>

    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="../css/animate.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">

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
                    <h2>Brands</h2>
                    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
                        </asp:ScriptManager>
                    <ol class="breadcrumb">
                        <li>
                            <a href="../home/">Home</a>
                        </li>
                        <li><a href="Default.aspx">Brands</a></li>
                        <li><a href="edit.aspx">Add New Brand</a></li>
                    </ol>
                </div>
                <div class="col-lg-4 pull-right">
                    <h2>
                     <asp:LinkButton runat="server" ID="btnCancel" CausesValidation="false" class="btn btn-sm btn-primary pull-right m-t-n-xs" style="margin:3px;" Text="Cancel <i class='ace-icon fa fa-remove' style='margin-left:5px;'></i>" OnClick="btnCancel_Click"></asp:LinkButton>
                     <asp:Button runat="server" ID="btnSave" CausesValidation="true" ValidationGroup="gpMain" class="btn btn-sm btn-primary pull-right m-t-n-xs" style="margin:3px;"  Text="Save" OnClick="btnSave_Click"></asp:Button>
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
                    <script type="text/javascript" language="javascript">
                        function pageLoad() {
                            setTimeout(function () { $('#divAlerts').fadeOut(); }, 4000);
                        }
        </script>
         <%--   <div class="wrapper wrapper-content animated fadeInRight">--%>
                 
                <div class="row">
                    <%-- <div class="col-lg-12" style="height: 100%">--%>
                        <div class="ibox float-e-margins">
                           <div class="ibox-content">
                               <div class="row">
                                   <div class="col-lg-6"><div style="margin:15px;">Fields marked with * are mandatory</div></div>
                                   <div class="col-lg-6">
                                      
                                   </div>
                               </div>
                                <div class="row">
                                    <div id="divAlerts" runat="server" class="alert" Visible="False">
                                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                         <asp:Label runat="server" ID="lblStatus" for="PageMessage"  Text="" Visible="True"></asp:Label>
                                    </div>
                                    <asp:ValidationSummary ID="Vs1" runat="server"  ValidationGroup="gpMain"/>
                                    <div class="col-lg-6" style="height: 100%">                          
                                        
                                        <div class="form-group">
                                           <label>Brand Name</label><span class="text-danger">*</span> 
                                            <input type="text" runat="server" id="txtBrandName" placeholder="Brand Name" class="form-control" required="required" /></div>
                                        <div class="form-group"><label>Brand DP</label><span class="text-danger">*</span>
                                            <div class="row">
                                                <div class="col-lg-4">
                                                    <asp:Label runat="server" ID="lblImageName" Visible="false"></asp:Label>
                                                    <asp:Image ImageUrl="#" runat="server" ID="imgLogo" CssClass="fa-image img-responsive" Width="100%" Height="100" style="margin-bottom:15px;"/>
                                                </div>
                                                <div class="col-lg-8">
                                                    <input type="file" ID="fupLogo" runat="server" CssClass="form-control" required="required"/> 
                                                </div>
                                            </div>                                           
                                            

                                        </div>
                                        <div class="form-group"><label>Brand Biography</label> 
                                            <textarea type="text" runat="server" id="txtBio" style="height:150px;"  placeholder="Brand Biography" class="form-control" />

                                        </div>
                                        <div class="form-group"><label>Country</label><span class="text-danger">*</span>
                                            <asp:DropDownList ID="ddCountry" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                        <div class="form-group"><label>State/Province</label> 
                                            <input type="text" runat="server" id="txtState" placeholder="State/Province" class="form-control">

                                        </div>
                                        <div class="form-group"><label>City</label> <span class="text-danger">*</span>
                                            <input type="text" runat="server" id="txtCity" placeholder="City" class="form-control" required="required">

                                        </div>
                                         <div class="form-group"><label>Zip/Postal Code</label> <span class="text-danger">*</span>
                                             <input type="text" runat="server" id="txtPostalCode" placeholder="Zip/Postal Code" class="form-control" required="required">

                                         </div>
                                        <div class="form-group"><label>Address</label> <input type="text" runat="server" id="txtAddress" placeholder="Address" class="form-control"></div>
                                                                                                             
                                                
                                        </div>                                  
                                    <div class="col-lg-6">                          
                                    
                                        <div class="form-group"><label>Phone</label><span class="text-danger">*</span> <input type="text" runat="server" id="txtPhone" placeholder="Phone" class="form-control" required="required"></div>
                                        <div class="form-group"><label>Email</label><span class="text-danger">*</span> <input type="text" runat="server" id="txtEmail" placeholder="Email" class="form-control" required="required"></div>
                                        <div class="form-group"><label>Brand Online Shop URL</label> <input type="text" runat="server" id="txtBrandURL" placeholder="Brand Online Shop URL" class="form-control"></div>
                                        <div class="form-group"><label>FB Account URL</label> <input type="text" runat="server" id="txtFbURL" placeholder="Facebook Account URL" class="form-control"></div>
                                        <div class="form-group"><label>Twitter Account URL</label> <input type="text" runat="server" id="txtTwitterURL" placeholder="Twitter Account URL" class="form-control"></div>
                                        <div class="form-group"><label>Instagram Account URL</label> <input type="text" runat="server" id="txtInstaURL" placeholder="Instagram Account URL" class="form-control"></div>
                                         <div class="form-group"><label>Brand History</label> <textarea type="text" runat="server" id="txtBrandHistory" style="height: 150px;" placeholder="Brand History" class="form-control" /></div>
                                        <div class="form-group"><label>Brand Story</label> <textarea type="text" runat="server" id="txtBrandStory" style="height:150px;"  placeholder="Brand Story" class="form-control" /></div>
                                                                                                             
                                                
                                        </div>
                                  
                                
                                </div>
                                </div>

                            </div>
                      <%--  </div>--%>
                </div>               
<%--
           </div>--%>
           
           
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
