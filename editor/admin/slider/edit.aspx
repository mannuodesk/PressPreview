﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="edit.aspx.cs" Inherits="admin_home_Default" %>

<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

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
                    <h2>Activity Page Slider</h2>
                     <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                    <ol class="breadcrumb">
                        <li>
                            <a href="../home/">Home</a>
                        </li>
                        <li><a href="Default.aspx">Slider Management</a></li>
                        <li><a href="edit.aspx">Edit</a></li>
                    </ol>
                </div>
                <div class="col-lg-4 pull-right">
                    <h2>
                     <asp:LinkButton runat="server" ID="btnCancel" CausesValidation="False" class="btn btn-sm btn-primary pull-right m-t-n-xs" style="margin:3px;" Text="Discard Changes <i class='ace-icon fa fa-remove' style='margin-left:5px;'></i>" OnClick="btnCancel_Click"></asp:LinkButton>
                     <asp:LinkButton runat="server" ID="btnSave" CausesValidation="True" class="btn btn-sm btn-primary pull-right m-t-n-xs" style="margin:3px;"  Text="Save Changes <i class='ace-icon fa fa-save' style='margin-left:5px;'></i>" OnClick="btnSave_Click"></asp:LinkButton>
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
                     <div class="col-lg-12">
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
                                         <asp:Label runat="server" ID="lblStatus" for="PageMessage"   
                                             Text="" Visible="True"></asp:Label>    
                                    </div>
                                  <div class="col-lg-2"></div>
                                            <div class="col-lg-8">                        
                                                <div class="form-group">
                                                    <label>Select Slider Image:</label> 
                                                    <asp:FileUpload ID="fup1" CssClass="form-control" runat="server" required="required" />
                                                   
                                                </div>
                                                <div class="form-group">
                                                    <label><span class="red">Note:</span></label>
                                                    <label>
                                                        <p>Recommended Slider Size: 1300 x 300 (width x height). Supported Formats: JPEG,JPG,PNG.</p>
                                                    </label>
                                                </div>
                                                <div class="form-group">
                                                   <label>Current Image</label>
                                                   <asp:Image runat="server" ID="imgCurrent"  AlternateText="" CssClass="form-control col-sm-6" style="height:150px;"/>
                                                   <asp:Label runat="server" ID="lblimagename" CssClass="form-control" Visible="False"></asp:Label>
                                                </div>
                                                
                                                <div class="form-group">
                                                    <label>Link:</label> 
                                                    <asp:TextBox runat="server" ID="txtLink" CssClass="form-control" placeholder="Enter URL, where you want the user to be redirected on click this slider"></asp:TextBox>
                                                   
                                                    <asp:RequiredFieldValidator runat="server" ID="rfvBrand" ErrorMessage="Link is required" Display="Static" ControlToValidate="txtLink" ></asp:RequiredFieldValidator>
                                                  
                                                    <asp:RegularExpressionValidator ID="RevLink" runat="server" ControlToValidate="txtLink"
                                                        ErrorMessage="Valid link is required. e.g.  '&lt;b&gt;&quot;http://www.yourdomain.com/pagename.aspx&quot;&lt;/b&gt;'" 
                                                        ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?"></asp:RegularExpressionValidator>
                                                  
                                                </div>
                                              
                                            </div>                                  
                                            <div class="col-lg-2"></div>                      
                                
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
