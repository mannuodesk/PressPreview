<%@ Page Language="C#" AutoEventWireup="true" CodeFile="view-items.aspx.cs" Inherits="admin_home_Default" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>PP :: Dashboard</title>

    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../font-awesome/css/font-awesome.css" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
    <link href="../css/animate.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">
   <!-- Fency box Resources -->
    <link href="../../fencybox/source/jquery.fancybox.css" rel="stylesheet" type="text/css" />
    <link href="../../fencybox/source/helpers/jquery.fancybox-buttons.css" rel="stylesheet"
        type="text/css" />
    <link href="../../fencybox/source/helpers/jquery.fancybox-thumbs.css" rel="stylesheet"
        type="text/css" />
     <script src="../../fencybox/lib/jquery.mousewheel-3.0.6.pack.js" type="text/javascript"></script>
     <script src="../../fencybox/source/jquery.fancybox.js" type="text/javascript"></script>
    <script src="../../fencybox/source/jquery.fancybox.pack.js" type="text/javascript"></script>
    <%--<script type="text/javascript">

        $(document).ready(function () {
            $(".fancybox").fancybox({
                type: 'iframe',
                transitionIn: 'elastic',
                transitionOut: 'elastic',
                speedIn: 600,
                speedOut: 200,
                overlayShow: true,
                'frameWidth': 1100, // set the width
                'frameHeight': 800,
                'width': 1100,
                'height': 800
            });
        });
    </script>--%>
    
   

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
                    <h2>Brands</h2>
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                    <ol class="breadcrumb">
                        <li>
                            <a href="../home/">Home</a>
                        </li>
                        <li><a href="Default.aspx">Brands</a></li>
                         <li><a href="#" runat="server" ID="lbtnBrandName">Brand's Items</a></li>
                    </ol>
                </div>
                <div class="col-lg-4">
                    <h2>
                        <asp:LinkButton runat="server" ID="btnSave" 
                            class="btn btn-sm btn-primary pull-right m-t-n-xs" style="margin:3px;"  
                            Text="Add New<i class='ace-icon fa fa-plus' style='margin-left:5px;'></i>" 
                            PostBackUrl="addnew.aspx" Visible="False"></asp:LinkButton>
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
                                       <asp:Repeater runat="server" ID="rptLookbook"  DataSourceID="sdsLookbooks" 
                    OnItemDataBound="rptLookbook_ItemDataBound" onitemcommand="rptLookbook_ItemCommand" >
                    <ItemTemplate>
                        <div class="col-md-3">
                    <div class="ibox">
                        <div class="ibox-content product-box">

                            <div class="product-imitation">
                               <img class="img-responsive" src="../../photobank/<%# Eval("FeatureImg") %>" alt="<%# Eval("Title","{0}") %>" />
                            </div>
                            <div class="product-desc">
                                <span class="product-price">
                                    <a href="">
                                    <img src='../../brandslogoThumb/<%# Eval("logo") %>' class="img-circle img-responsive" style="width:36px; height:36px;"/></a>
                                </span>
                                <small class="text-muted"><%# Eval("Category")%></small>
                                <a href="#" class="product-name">  <a href="../../lightbox/brand-item-view?v=<%# Eval("ItemID") %>" class="fancybox"><%# Eval("Title","{0}") %></a></a>
                                <small class="text-muted">By <asp:Label runat="server" ID="lblBrandName" Text='<%# Eval("Name") %>'></asp:Label></small>
                                <div class="small m-t-xs">
                                    <%# Eval("Description","{0}") %>
                                </div>
                                
                                <div class="m-t text-righ">
                                   <%-- <span>
                                         <asp:Label runat="server" ID="lblDate2"><%# Eval("DatePosted") %></asp:Label></div>
                                    </span>--%>
                                    <asp:LinkButton ID="btnRemove" CommandName="1" CommandArgument='<%# Eval("ItemID") %>' OnClientClick="return confirm('Are you sure, you want to delete ?')" class="btn btn-xs btn-outline btn-primary" runat="server"> <i class="fa fa-remove"></i> </asp:LinkButton>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                    

                    </ItemTemplate>
                    <FooterTemplate>
                         <asp:Label ID="lblEmptyData" style="margin-left: 40%;" runat="server" Visible='<%# ((Repeater)Container.NamingContainer).Items.Count == 0 %>' Text="No items found" />
                     </FooterTemplate>
                </asp:Repeater>
                <asp:SqlDataSource runat="server" ID="sdsLookbooks" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                SelectCommand="SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, 
                dbo.Tbl_Brands.Logo, dbo.Tbl_Items.ItemID, dbo.Tbl_Items.Title, 
                ItemKey, dbo.Tbl_Items.Description, dbo.Tbl_Items.FeatureImg, dbo.Tbl_Items.Category,
                dbo.Tbl_Items.Views, CAST(dbo.Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted, 
                dbo.Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands 
                INNER JOIN dbo.Tbl_Items ON dbo.Tbl_Brands.UserID = dbo.Tbl_Items.UserID
Where dbo.Tbl_Brands.UserID=? AND dbo.Tbl_Items.IsDeleted IS NULL AND dbo.Tbl_Items.IsPublished=1
ORDER BY dbo.Tbl_Items.DatePosted DESC">
                    <SelectParameters>
                          <asp:QueryStringParameter QueryStringField="v" Name="?" ></asp:QueryStringParameter>
                      </SelectParameters>
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
   <%-- <script src="../js/jquery-2.1.1.js"></script>--%>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="../js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
                 
    <!-- Custom and plugin javascript -->
    <script src="../js/inspinia.js"></script>
    <script src="../js/plugins/pace/pace.min.js"></script>

    <!-- jQuery UI -->
    <script src="../js/plugins/jquery-ui/jquery-ui.min.js"></script>

   

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

                  //  $('#<%=lblTotalNotifications.ClientID%>').hide("slow");
                    return false;  
                }
            });
           
        });
    });
    </script>
     <script type="text/javascript">
         $(document).ready(function () {
             $(".fancybox").fancybox();
         });
  </script>
    </form>
</body>
</html>
