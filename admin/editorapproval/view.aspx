﻿<%@ Page Language="C#" ValidateRequest="false" EnableEventValidation="false" AutoEventWireup="true" CodeFile="view.aspx.cs" Inherits="admin_home_Default" %>
<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox, Version=3.3.1.12354, Culture=neutral, PublicKeyToken=5962a4e684a48b87" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PP :: View Editor Approval</title>
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
                    <h2>Editor View Details</h2>
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                    <ol class="breadcrumb">
                        <li>
                            <a href="../home/">Home</a>
                        </li>
                        <li><a href="Default.aspx">Influencers</a></li>
                        <li><a href="view.aspx">Influencer Approval</a></li>
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
                             <asp:Label runat="server" ID="lblStatus" for="PageMessage"   
                                 Text="" Visible="True"></asp:Label>
                </div>
                                    <div class="col-lg-6">                          
                                         <div class="form-group"><label>Influencer Profile Pic</label>
                                            <div class="row">
                                                <div class="col-lg-4">
                                                    <asp:Label runat="server" ID="lblImageName" Visible="false"></asp:Label>
                                                    <asp:Image ImageUrl="#" runat="server" ID="imgLogo" CssClass="img-circle img-responsive"  style="margin-bottom:15px;" />
                                                </div>
                                               
                                            </div>                                          
                                            

                                        </div>
                                        <div class="form-group"><label>First Name:</label>  <input type="text" readonly="readonly" runat="server" id="txtFirstName" placeholder="First Name" class="form-control" ></div>
                                        <div class="form-group"><label>Last Name</label><input type="text"  readonly="readonly" runat="server" id="txtLastname" placeholder="Last Name" class="form-control" ></div>
                                       
                                        <div class="form-group"><label>Org.</label>
                                           <input type="text" runat="server"  readonly="readonly" id="txtOrg" placeholder="Organization" class="form-control" >

                                        </div>
                                        <div class="form-group"><label>Designation</label>  <input type="text"  readonly="readonly" runat="server" id="txtDesignation" placeholder="Designation" class="form-control" ></div>
                                        <div class="form-group"><label>Country</label>
                                            <input type="text" runat="server"  readonly="readonly" id="txtCountry" placeholder="State/Province" class="form-control" >
                                        </div>
                                        <div class="form-group"><label>State/Province</label> 
                                            <input type="text" runat="server"  readonly="readonly" id="txtState" placeholder="State/Province" class="form-control" >

                                        </div>
                                        <div class="form-group"><label>City</label>  
                                            <input type="text"  readonly="readonly" runat="server" id="txtCity" placeholder="City" class="form-control" >

                                        </div>
                                         <div class="form-group"><label>Zip/Postal Code</label>  
                                             <input type="text"  readonly="readonly" runat="server" id="txtPostalCode" placeholder="Zip/Postal Code" class="form-control" >

                                         </div>
                                        <div class="form-group"><label>Address</label> <input type="text" readonly="readonly" runat="server" id="txtAddress" placeholder="Address" class="form-control"></div>
                                       <div class="form-group"><label>Editorial Calender</label> <%--<textarea type="text" readonly="readonly" runat="server" id="txtEcalender" style="height: 150px;" placeholder="Editorial Calender" class="form-control" />--%>   
                                  <style>
                                      #txtEcalender_toolbarArea{
                                          display:none;
                                      }
                                      #txtEcalender_TabRow{
                                          display:none
                                      }
                                      .txtEcalender_DesignBox {
                                          background-color: #eeeeee !important;
                                          border: 0 !important;
                                      }
                                  </style>
                                                 <FTB:FreeTextbox  runat="server" ID="txtEcalender" ButtonSet="OfficeMac" ReadOnly="true"
          Height="150px" 
          ToolbarLayout="JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent; InsertRule|Cut,Copy,Paste;Print" 
          ToolbarStyleConfiguration="Office2000" Width="100%"></FTB:FreeTextbox></div>                                 
                                                
                                        </div>                                  
                                    <div class="col-lg-6">                          
                                    
                                        <div class="form-group"></div>
                                        <div class="form-group"></div>
                                        <div class="form-group"><label>Phone</label>  <input type="text" readonly="readonly" runat="server" id="txtHPhone" placeholder="Phone" class="form-control" ></div>
                                       
                                       
                                        <div class="form-group"><label>Email</label> <input type="text" readonly="readonly" runat="server" id="txtEmail" placeholder="Email" class="form-control" ></div>
                                        <div class="form-group"><label>Website URL</label> <input type="text" readonly="readonly" runat="server" id="txtEditorURL" placeholder="Website URL" class="form-control"></div>
                                        <div class="form-group"><label>Instagram</label> <input type="text" readonly="readonly" runat="server" id="txtInstaURL" placeholder="Instagram Link" class="form-control"></div>
                                        <div class="form-group"><label>Twitter</label> <input type="text" readonly="readonly" runat="server" id="txtTwitterURL" placeholder="Twitter Link" class="form-control"></div>
                                        <div class="form-group"><label>Facebook</label> <input type="text" readonly="readonly" runat="server" id="txtFbURL" placeholder="Facebook Link" class="form-control"></div>
                                        <div class="form-group"><label>Youtube</label> <input type="text" readonly="readonly" runat="server" id="txtYoutube" placeholder="Youtube Link" class="form-control"></div>
                                        <div class="form-group"><label>Pinterest</label> <input type="text" readonly="readonly" runat="server" id="txtPinterest" placeholder="Pinterest Link" class="form-control"></div>
                                           <%-- <div class="form-group"><label>Description</label> <textarea type="text" readonly="readonly" runat="server" id="txtDescription" style="height: 150px;" placeholder="Breif Description" class="form-control" /></div>--%>
                                          <div class="form-group"><label>Description</label> 
                                  <style>
                                      #txtDescription_toolbarArea{
                                          display:none;
                                      }
                                      #txtDescription_TabRow{
                                          display:none
                                      }
                                      .txtDescription_DesignBox {
                                          background-color: #eeeeee !important;
                                          border: 0 !important;
                                      }
                                  </style>
                                                 <FTB:FreeTextbox  runat="server" ID="txtDescription" ButtonSet="OfficeMac" ReadOnly="true"
          Height="150px" 
          ToolbarLayout="JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent; InsertRule|Cut,Copy,Paste;Print" 
          ToolbarStyleConfiguration="Office2000" Width="100%"></FTB:FreeTextbox>
          </div>    
                                        
                                        
                                        
                                        <%-- <div class="form-group"><label>Timeline of Projects</label> <textarea type="text" readonly="readonly" runat="server" id="txtTop" style="height: 150px;" placeholder="Projects Timeline" class="form-control" /></div>--%>
                                          <div class="form-group"><label>Timeline of Projects</label> 
                                  <style>
                                      #txtTop_toolbarArea{
                                          display:none;
                                      }
                                      #txtTop_TabRow{
                                          display:none
                                      }
                                      .txtTop_DesignBox {
                                          background-color: #eeeeee !important;
                                          border: 0 !important;
                                      }
                                  </style>
                                                 <FTB:FreeTextbox  runat="server" ID="txtTop" ButtonSet="OfficeMac" ReadOnly="true"
          Height="150px" 
          ToolbarLayout="JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent; InsertRule|Cut,Copy,Paste;Print" 
          ToolbarStyleConfiguration="Office2000" Width="100%"></FTB:FreeTextbox></div> 

                                                                                                             
                                                
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
