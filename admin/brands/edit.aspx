﻿<%@ Page Language="C#" ValidateRequest="false" AutoEventWireup="true" CodeFile="edit.aspx.cs" Inherits="admin_home_Default" %>
<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox, Version=3.3.1.12354, Culture=neutral, PublicKeyToken=5962a4e684a48b87" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PP :: Edit Brand</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="../css/animate.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">
<style>
        #txtBrandHistory_toolbarArea{
        display: none;
    }
    #txtBrandHistory_TabRow{
        display: none
    }
            #txtBio_toolbarArea{
            display: none
        }
        #txtBio_TabRow{
            display: none
        }
</style>
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
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                    <ol class="breadcrumb">
                        <li>
                            <a href="../home/">Home</a>
                        </li>
                        <li><a href="Default.aspx">Brands</a></li>
                        <li><a href="edit.aspx">Edit Brand</a></li>
                    </ol>
                </div>
                <div class="col-lg-4 pull-right">
                    <h2>
                     <asp:LinkButton runat="server" ID="btnCancel" class="btn btn-sm btn-primary pull-right m-t-n-xs" style="margin:3px;" Text="Discard Changes <i class='ace-icon fa fa-remove' style='margin-left:5px;'></i>" OnClick="btnCancel_Click"></asp:LinkButton>
                     <asp:Button runat="server" ID="btnSave" class="btn btn-sm btn-primary pull-right m-t-n-xs" style="margin:3px;"  Text="Save Changes" OnClick="btnSave_Click"></asp:Button>
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
                                   <div class="col-lg-6"><div style="margin:15px;">Fields marked with * are mandatory</div></div>
                                   <div class="col-lg-6">
                                      
                                   </div>
                               </div>
                               <div class="row">
                                    <div id="divAlerts" runat="server" class="alert" Visible="False">
                                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                        <asp:Label runat="server" ID="lblStatus" for="PageMessage" Text="" Visible="True"></asp:Label>
                                    </div>
                                    <div class="col-lg-6">              
                                        <div class="form-group"><label>First Name</label><span class="text-danger">*</span> <input type="text" runat="server" id="txtBrandfName" placeholder="First Name" class="form-control" required="required"></div>
                                         <div class="form-group"><label>Last Name</label><span class="text-danger">*</span> <input type="text" runat="server" id="txtBrandLName" placeholder="Lastname" class="form-control" required="required"></div> 
                                        <div class="form-group"><label>Brand Name</label><span class="text-danger">*</span> <input type="text" runat="server" id="txtBrandName" placeholder="Brand Name" class="form-control" required="required"></div>
                                        <div class="form-group"><label>Brand DP</label>
                                            <div class="row">
                                                <div class="col-lg-4">
                                                    <asp:Label runat="server" ID="lblImageName" Visible="false"></asp:Label>
                                                    <asp:Image ImageUrl="#" runat="server" ID="imgLogo" CssClass="img-circle img-responsive"  style="margin-bottom:15px; width: 100px; height: 100px;" />
                                                </div>
                                                <div class="col-lg-8">
                                                    <asp:FileUpload ID="fupLogo" runat="server" CssClass="form-control" /> 
                                                </div>
                                            </div>                                          
                                            

                                        </div>
                                        <div class="form-group"><label>About</label> 
                     
                                                                   <FTB:FreeTextBox runat="server" ID="txtBio" ButtonSet="OfficeMac" 
          Height="150px" 
          ToolbarLayout="JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent; InsertRule|Cut,Copy,Paste;Print" 
          ToolbarStyleConfiguration="Office2000" Width="100%"></FTB:FreeTextBox>
                                            </div>
                                   
                                       
                                        <div class="form-group"><label>Country</label><span class="text-danger">*</span>
                                             <input type="text" runat="server" id="txtCountry" placeholder="State/Province" class="form-control">
                                        </div>
                                        <div class="form-group"><label>State/Province</label> 
                                            <input type="text" runat="server" id="txtState" placeholder="State/Province" class="form-control">

                                        </div>
                                        <div class="form-group"><label>City</label> <span class="text-danger">*</span>
                                            <input type="text" runat="server" id="txtCity" placeholder="City" class="form-control" required="required">

                                        </div>
                                         <div class="form-group"><label>Zip/Postal Code</label> 
                                             <input type="text" runat="server" id="txtPostalCode" placeholder="Zip/Postal Code" class="form-control">

                                         </div>
                                        <div class="form-group"><label>Address</label> <input type="text" runat="server" id="txtAddress" placeholder="Address" class="form-control"></div>
                                                                                                             
                                                
                                        </div>                                  
                                    <div class="col-lg-6">                          
                                    
                                        <div class="form-group"><label>Phone</label><span class="text-danger">*</span> <input type="text" runat="server" id="txtPhone" placeholder="Phone" class="form-control" required="required"></div>
                                        <div class="form-group"><label>Email</label><span class="text-danger">*</span> <input type="text" runat="server" id="txtEmail" placeholder="Email" class="form-control" required="required"></div>
                                        <div class="form-group"><label>Brand Online Shop URL</label> <input type="text" runat="server" id="txtBrandURL" placeholder="Brand Online Shop URL" class="form-control"></div>
                                        <div class="form-group"><label>Facebook</label> <input type="text" runat="server" id="txtFbURL" placeholder="Facebook Account URL" class="form-control"></div>
                                        <div class="form-group"><label>Twitter</label> <input type="text" runat="server" id="txtTwitterURL" placeholder="Twitter Account URL" class="form-control"></div>
                                        <div class="form-group"><label>Instagram</label> <input type="text" runat="server" id="txtInstaURL" placeholder="Instagram Account URL" class="form-control"></div>
                                        <div class="form-group"><label>Youtube</label> <input type="text"  runat="server" id="txtYoutube" placeholder="Youtube Link" class="form-control"></div>
                                          <div class="form-group"><label>Pinterest</label> <input type="text"  runat="server" id="txtPinterest" placeholder="Pinterest Link" class="form-control"></div>
                                        <div class="form-group"><label>Account Status</label>
                                            <asp:DropDownList ID="ddAccountStatus" runat="server" CssClass="form-control">
                                                <asp:ListItem Value="0">Block</asp:ListItem>
                                                <asp:ListItem Value="1">Active</asp:ListItem>
                                            </asp:DropDownList></div>
                                        <%--<div class="form-group"><label>Email Status</label>
                                            <asp:DropDownList ID="ddEmailStatus" runat="server" CssClass="form-control">
                                                <asp:ListItem Value="0">Not Confirmed</asp:ListItem>
                                                <asp:ListItem Value="1">Confirmed</asp:ListItem>
                                            </asp:DropDownList></div>--%>
                                         <div class="form-group"><label>Brand History</label> 
                                             <%-- <textarea type="text" runat="server" id="txtBrandHistory" style="height: 150px;" placeholder="Brand History" class="form-control" />--%>
                                              <FTB:FreeTextBox runat="server" ID="txtBrandHistory" ButtonSet="OfficeMac" 
          Height="200px" 
          ToolbarLayout="JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent; InsertRule|Cut,Copy,Paste;Print" 
          ToolbarStyleConfiguration="Office2000" Width="100%"></FTB:FreeTextBox>
                                         </div>
                                        
                                        </div>
                                  
                                
                                </div>
                            </div>
                         </div>
                     </div>
                </div>               
            </div>
            
            <div class="wrapper wrapper-content animated fadeInRight" style="display:block; ">                 
                <div class="row">
                     <div class="col-lg-12" style="display:none">
                        <div class="ibox float-e-margins">
                           <div class="ibox-content">
                               <div class="row">
                                   <div class="col-lg-6"><div style="margin:15px;"><h2>Likes</h2></div></div>
                                   <div class="col-lg-6">
                                      
                                   </div>
                               </div>
                                <div class="row">                              
                                    <div class="col-lg-12">                        
                                        <!-- Follower Filter Starts -->
				                        <div class="product-filter">
					<div class="row">
						
                        <div class="col-md-4"></div>
						<div class="col-md-2 text-right">
							<label class="control-label">Sort</label>
						</div>
						<div class="col-md-3 text-right">
						    <asp:DropDownList runat="server" class="form-control" ID="ddLikeSort" 
                                AutoPostBack="True" onselectedindexchanged="ddLikeSort_SelectedIndexChanged">
                                <asp:ListItem Value="UserID">Default</asp:ListItem>
                                <asp:ListItem Value="U_Firstname">Name (A - Z)</asp:ListItem>
                               
						    </asp:DropDownList>
							
						</div>
						<div class="col-md-1 text-right">
							<label class="control-label" for="input-limit">Show</label>
						</div>
						<div class="col-md-2 text-right">
							<asp:DropDownList runat="server" class="form-control" ID="ddLikePageSize" 
                                AutoPostBack="True" onselectedindexchanged="ddLikePageSize_SelectedIndexChanged">
                                <asp:ListItem Value="8">8</asp:ListItem>
                                <asp:ListItem Value="16">16</asp:ListItem>
                                <asp:ListItem>24</asp:ListItem>
                                <asp:ListItem>32</asp:ListItem>
						    </asp:DropDownList>
						</div>
					</div>						 
				</div>
			                            <!-- Follower Filter Ends -->
			                            <!-- Follower Grid Display Starts -->
				                        <div class="row">
				<!-- Product #1 Starts -->
					<asp:DataList ID="dlLikes" runat="server" 
                        RepeatColumns="4" RepeatDirection="Horizontal"  OnItemCommand="dlLikes_ItemCommand"
                       >
                                <ItemTemplate>
                                     <div class="pthumb">
                                            <a href='<%# Eval("UserID","{0}") %>' class="block">
                                                <img src='<%# Eval("U_ProfilePic","../../profilethumbs/{0}")%>'/>
                                                <span><%# Eval("FullName")%></span>
                                            </a>                                           
                                           <div  id="divContactForPrice" runat="server" style="text-align:center;" >
												<asp:LinkButton runat="server" ID="lblUnfollow" Text="UNLIKE" CommandArgument='<%# Eval("UserID","{0}") %>' CommandName="1" CssClass="btn btn-block btn-info"></asp:LinkButton></div> 
                                           
                                        </div>
								
                                </ItemTemplate>
                            </asp:DataList>
				<!-- Product #6 Ends -->
				</div>
			                            <!-- Follower Grid Display Ends -->
			                            <!-- Pagination & Results Starts -->
				                        <div class="row">
				<!-- Pagination Starts -->
					<div class="col-sm-6 pagination-block">
						<ul class="pagination">
						  <li><asp:LinkButton ID="lbLikePrev" runat="server" ToolTip="Previous" Text="&laquo;" 
                                  onclick="lbLikePrev_Click"></asp:LinkButton></li>
						  <li>
                             <asp:DataList ID="dlPaging2" runat="server" RepeatDirection="Horizontal" 
                                  onitemcommand="dlPaging2_ItemCommand" onitemdatabound="dlPaging2_ItemDataBound">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="lnkbtnPage" runat="server" CommandArgument='<%# Eval("PageIndex") %>'
                                                                            CommandName="Paging" Style="position: relative" Text='<%# Eval("PageText") %>'></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </asp:DataList>
                          </li>
						  <li> <asp:LinkButton ID="lbLikeNext" runat="server" ToolTip="Next" 
                                  onclick="lbLikeNext_Click">&raquo;</asp:LinkButton></li>
						</ul>
					</div>
				<!-- Pagination Ends -->
				<!-- Results Starts -->
					<div class="col-sm-6 results">
					    <asp:Label runat="server" ID="lblLikesPageInfo"></asp:Label>
						<%--Showing 1 to 3 of 12 (4 Pages)--%>
					</div>
				<!-- Results Ends -->
				</div>                                                                                                                                                                   
                                                
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
