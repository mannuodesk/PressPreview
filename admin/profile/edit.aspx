<%@ Page Language="C#" AutoEventWireup="true" CodeFile="edit.aspx.cs" Inherits="admin_home_Default" %>

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
    <form id="form1" runat="server" role="form" class="form-horizontal">
    <div id="wrapper">
    <!--#INCLUDE FILE="../includes/leftmenu.txt" -->

        <div id="page-wrapper" class="gray-bg">
        <div class="row border-bottom">
         <!--#INCLUDE FILE="../includes/header.txt" -->
        </div>
            <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-lg-8">
                    <h2>Profile Settings</h2>
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                    <ol class="breadcrumb">
                        <li>
                            <a href="../home/">Home</a>
                        </li>
                        <li><a href="Default.aspx">Profile</a></li>
                        <li><a href="edit.aspx">Edit</a></li>
                    </ol>
                </div>
                <div class="col-lg-4 pull-right">
                    
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
                                                    <li class="active"><a data-toggle="tab" runat="server" id="tab1" href="#edit-basic"><i class="green ace-icon fa fa-pencil-square-o bigger-125"></i>Basic Info </a></li>
                                                    <li><a data-toggle="tab" runat="server" id="tab2" href="#edit-password"><i class="blue ace-icon fa fa-key bigger-125"></i>Password </a></li>
                                                </ul>
                                                <div class="tab-content profile-edit-tab-content">
                                                    <div id="edit-basic" class="tab-pane in active" style="margin-top:30px;">
                                                        <div>
                                                            <asp:ValidationSummary ID="vs1" runat="server" ForeColor="red" HeaderText="The following field(s) are missing or invalid" ValidationGroup="gpBasic" />
                                                        </div>
                                                        <%--<h4 class="header blue bolder smaller">General</h4>--%>
                                                        <div class="row">
                                                            <div class="col-sm-2"></div>
                                                            <div class="col-xs-12 col-sm-2">
                                                                <div style="margin-bottom:15px;">
                                                                    <asp:Image ID="imgProfile" runat="server" ImageUrl="#" Width="180" CssClass="img-circle"  />
                                                                    <asp:Label ID="imgPath" runat="server" Visible="False"></asp:Label>
                                                                </div>
                                                                <asp:FileUpload ID="fupProfile" runat="server" />
                                                            </div>
                                                            <div class="vspace-12-sm">
                                                            </div>
                                                            <div class="col-xs-12 col-sm-8">
                                                                <div class="form-group">
                                                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUsername" Display="None" ErrorMessage="First Name" Text="*" ValidationGroup="gpBasic"></asp:RequiredFieldValidator>
                                                                    <label class="col-sm-4 control-label no-padding-right" for="form-field-username">
                                                                    Username:<span class="red">*</span></label>
                                                                    <asp:TextBox ID="txtUsername" runat="server" class="col-xs-12 col-sm-4"  ValidationGroup="gpBasic" placeholder="Username" style="padding:5px;"/>
                                                                   
                                                                </div>
                                                                <div class="space-4">
                                                                </div>
                                                                <div class="form-group">
                                                                    <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstname" Display="None" ErrorMessage="First Name" Text="*" ValidationGroup="gpBasic"></asp:RequiredFieldValidator>
                                                                    <label class="col-sm-4 control-label no-padding-right" for="form-field-first">
                                                                    First Name:<span class="red">*</span></label>
                                                                    <asp:TextBox ID="txtFirstname" runat="server" class="col-sm-4" placeholder="First Name" ValidationGroup="gpBasic"  style="padding:5px;"/>
                                                                      
                                                                </div>
                                                                 <div class="form-group">
                                                                    <label class="col-sm-4 control-label no-padding-right" for="form-field-first">
                                                                   Last Name:</label>
                                                                    <asp:TextBox ID="txtLastname" runat="server" class="col-sm-4" placeholder="Last Name" style="padding:5px;"/>
                                                                </div>
                                                                <div class="form-group">
                                                                    <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtEmail" Display="None" ErrorMessage="Email" Text="*" ValidationGroup="gpBasic"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Enter a valid email !" Display="None" Text="*" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                                    <label class="col-sm-4 control-label no-padding-right" for="form-field-username">
                                                                    Email: <span class="red">*</span></label>                                                                   
                                                                    <asp:TextBox ID="txtEmail" runat="server" class="col-xs-12 col-sm-4" placeholder="Email" ValidationGroup="gpBasic" style="padding:5px;"/>
                                                                    
                                                                </div>
                                                                <div class="space-4">
                                                                </div>
                                                                
                                                            </div>
                                                        </div>
                                                        <div style="clear:both; height:10px;">
                                                        </div>
                                                        <div class="col-md-offset-3 col-md-4 pull-right">
                                                            <asp:Button ID="lbtnUpdate" runat="server" class="btn btn-sm btn-primary" CausesValidation="true"  ValidationGroup="gpBasic" Text='Update' OnClick="btnSave_Click"> </asp:Button>
                                                        </div>
                                                        <div style="clear:both; height:10px;">
                                                        </div>
                                                    </div>
                                                    <div id="edit-password" class="tab-pane" style="margin-top:30px;">
                                                        <div>
                                                            <asp:ValidationSummary ID="vs2" runat="server" ForeColor="red" HeaderText="The following field(s) are missing or invalid" ValidationGroup="gpPassword" />
                                                        </div>
                                                        <div class="space-10">
                                                        </div>
                                                        <div class="form-group">
                                                            <asp:RequiredFieldValidator ID="rfvnewpassword" runat="server" ControlToValidate="txtnewpassword" Display="None" ErrorMessage="New Password" Text="*" ValidationGroup="gpPassword"></asp:RequiredFieldValidator>
                                                            <label class="col-sm-3 control-label no-padding-right" for="form-field-pass1">
                                                            New Password</label>
                                                             <asp:TextBox ID="txtnewpassword" runat="server" TextMode="Password" CssClass="col-xs-12 col-sm-4" ValidationGroup="gpPassword"  style="padding:5px;"/>
                                                           
                                                        </div>
                                                        <div class="space-4">
                                                        </div>
                                                        <div class="form-group">
                                                            <asp:CompareValidator ID="cvConfirmpassword" runat="server" ControlToCompare="txtnewpassword" ControlToValidate="txtConfirmPassword" Display="None" ErrorMessage="Confirm Password does not match with New Password" Text="*" ValidationGroup="gpPassword"></asp:CompareValidator>
                                                            <label class="col-sm-3 control-label no-padding-right" for="form-field-pass2">
                                                            Confirm Password</label>                                                          
                                                                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="col-xs-12 col-sm-4" ValidationGroup="gpPassword" style="padding:5px;"/>
                                                            
                                                        </div>
                                                        <div style="clear:both; height:10px;">
                                                        </div>
                                                        <div class="col-md-offset-3 col-md-9">
                                                            <asp:Button ID="btnChangePassword" runat="server" class="btn btn-sm btn-primary" CausesValidation="true"  ValidationGroup="gpPassword" OnClick="btnChangePassword_Click" Text='Update'>
															            
														            </asp:Button>
                                                        </div>
                                                        <div style="clear:both; height:10px;">
                                                        </div>
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
           
         <%--</ContentTemplate>
            </asp:UpdatePanel>--%>
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
            var userId = '<%= Request.Cookies["UserID"].Value %>';
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
