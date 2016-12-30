<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeFile="view.aspx.cs" Inherits="admin_home_Default" %>
<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox, Version=3.3.1.12354, Culture=neutral, PublicKeyToken=5962a4e684a48b87" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PP :: Brand Approval View </title>
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
                    <h2>Brand View Details</h2>
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                    <ol class="breadcrumb">
                        <li>
                            <a href="../home/">Home</a>
                        </li>
                        <li><a href="Default.aspx">Brands</a></li>
                        <li><a href="view.aspx">Brand Approval</a></li>
                    </ol>
                </div>
                <div class="col-lg-4 pull-right">
                    <h2>
                     <asp:LinkButton runat="server" ID="btnCancel" class="btn btn-lg btn-primary pull-right m-t-n-xs" style="margin:3px;" Text="Cancel" OnClick="btnCancel_Click"></asp:LinkButton>
                     <asp:Button runat="server" ID="btnSave" class="btn btn-lg btn-primary pull-right m-t-n-xs" style="margin:3px;"  Text="Approve" OnClick="btnSave_Click"></asp:Button>
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
                <div class="row">
                     <div class="col-lg-12">
                        <div class="ibox float-e-margins">
                           <div class="ibox-content">
                               <div class="row">
                                   <div class="col-lg-6"></div>
                                   <div class="col-lg-6">
                                      
                                   </div>
                               </div>
                               <div class="row">
                                    <div id="divAlerts" runat="server" class="alert" Visible="False">
                                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                        <asp:Label runat="server" ID="lblStatus" for="PageMessage" Text="" Visible="True"></asp:Label>
                                    </div>
                                    <div class="col-lg-6">              
                                        
                                        <div class="form-group"><label>Brand Name</label>
                                            <input type="text" runat="server" id="txtBrandName" readonly="readonly" placeholder="Brand Name" 
                                                class="form-control" required="required" ></div>
                                        <div class="form-group"><label>Firstname</label>
                                            <input type="text" runat="server" id="txtFirstname" readonly="readonly" placeholder="Firstname" 
                                                class="form-control" required="required" ></div>
                                        <div class="form-group"><label>Lastname</label>
                                            <input type="text" runat="server" id="txtLastname" readonly="readonly" placeholder="Lastname" 
                                                class="form-control" required="required" ></div>
                                        <div class="form-group"><label>Organization</label>
                                            <input type="text" runat="server" id="txtOrg" readonly="readonly" placeholder="Organization" 
                                                class="form-control" required="required" ></div>
                                        <div class="form-group"><label>Designation</label>
                                            <input type="text" runat="server" id="txtDesignation" readonly="readonly" placeholder="Designation" 
                                                class="form-control" required="required" ></div>
                                        <div class="form-group"><label>Brand Profile Pic</label>
                                            <div class="row">
                                                <div class="col-lg-4">
                                                    <asp:Label runat="server" ID="lblImageName" Visible="false"></asp:Label>
                                                    <asp:Image ImageUrl="#" runat="server" ID="imgLogo" CssClass="img-circle img-responsive"  style="margin-bottom:15px;" />
                                                </div>
                                                <%--<div class="col-lg-8">
                                                    <asp:FileUpload ID="fupLogo" runat="server" CssClass="form-control" /> 
                                                </div>--%>
                                            </div>                                          
                                            

                                        </div>
                                           <div class="form-group"><label>Description</label> 
                                  <style>
                                      #txtBio_toolbarArea{
                                          display:none;
                                      }
                                      #txtBio_TabRow{
                                          display:none
                                      }
                                      .txtBio_DesignBox {
                                          background-color: #eeeeee !important;
                                          border: 0 !important;
                                      }
                                  </style>
                                                 <FTB:FreeTextbox  runat="server" ID="txtBio" ButtonSet="OfficeMac" ReadOnly="true"
          Height="150px" 
          ToolbarLayout="JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent; InsertRule|Cut,Copy,Paste;Print" 
          ToolbarStyleConfiguration="Office2000" Width="100%"></FTB:FreeTextbox>
          </div> 
                                         
                                         
                                         
                                         
                                         
                                        
                                        <div class="form-group"><label>Brand History</label> 
                                  <style>
                                      #txtBrandHistory_toolbarArea{
                                          display:none;
                                      }
                                      #txtBrandHistory_TabRow{
                                          display:none
                                      }
                                      .txtBrandHistory_DesignBox {
                                          background-color: #eeeeee !important;
                                          border: 0 !important;
                                      }
                                  </style>
                                                 <FTB:FreeTextbox  runat="server" ID="txtBrandHistory" ButtonSet="OfficeMac" ReadOnly="true"
          Height="150px" 
          ToolbarLayout="JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent; InsertRule|Cut,Copy,Paste;Print" 
          ToolbarStyleConfiguration="Office2000" Width="100%"></FTB:FreeTextbox>
          </div>    
                                                                                                             
                                                
                                        </div>                                  
                                    <div class="col-lg-6">                          
                                    
                                        <div class="form-group"><label>Phone</label> <input type="text" readonly="readonly" runat="server" id="txtPhone" placeholder="Phone" class="form-control" required="required"></div>
                                        <div class="form-group"><label>Email</label> <input type="text" readonly="readonly" runat="server" id="txtEmail" placeholder="Email" class="form-control" required="required"></div>
                                        <div class="form-group"><label>Website URL</label> <input type="text" runat="server" readonly="readonly" id="txtBrandURL" placeholder="Website URL" class="form-control"></div>
                                        <div class="form-group"><label>Country</label>
                                            <input type="text" readonly="readonly" runat="server" id="txtCountry" placeholder="Country" value="USA" class="form-control">
                                        </div>
                                        <div class="form-group"><label>State/Province</label> 
                                            <input type="text" readonly="readonly" runat="server" id="txtState" placeholder="State/Province" class="form-control">

                                        </div>
                                        <div class="form-group"><label>City</label> 
                                            <input type="text" runat="server" readonly="readonly" id="txtCity" placeholder="City" class="form-control" required="required">

                                        </div>
                                         <div class="form-group"><label>Zip/Postal Code</label> 
                                             <input type="text" runat="server" readonly="readonly" id="txtPostalCode" placeholder="Zip/Postal Code" class="form-control">

                                         </div>
                                        <div class="form-group"><label>Address</label> <input type="text" readonly="readonly" runat="server" id="txtAddress" placeholder="Address" class="form-control"></div>
                                        <div class="form-group"><label>Instagram</label> <input type="text" readonly="readonly" runat="server" id="txtInstaURL" placeholder="Instagram Link" class="form-control"></div>
                                        <div class="form-group"><label>Twitter</label> <input type="text" readonly="readonly" runat="server" id="txtTwitterURL" placeholder="Twitter Link" class="form-control"></div>
                                        <div class="form-group"><label>Facebook</label> <input type="text" readonly="readonly" runat="server" id="txtFbURL" placeholder="Facebook Link" class="form-control"></div>
                                         <div class="form-group"><label>Youtube</label> <input type="text" readonly="readonly" runat="server" id="txtYoutube" placeholder="Youtube Link" class="form-control"></div>
                                          <div class="form-group"><label>Pinterest</label> <input type="text" readonly="readonly" runat="server" id="txtPinterest" placeholder="Pinterest Link" class="form-control"></div>
                                        
                                        
                                                                                                     
                                                
                                        </div>
                                  
                                
                                </div>
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
