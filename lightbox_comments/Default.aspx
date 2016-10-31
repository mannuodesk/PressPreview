<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeFile="Default.aspx.cs" Inherits="home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Look Book Comments</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
   
 <!-- Fency box Resources -->
    <link href="../fencybox/source/jquery.fancybox.css" rel="stylesheet" type="text/css" />
    <link href="../fencybox/source/helpers/jquery.fancybox-buttons.css" rel="stylesheet"
        type="text/css" />
    <link href="../fencybox/source/helpers/jquery.fancybox-thumbs.css" rel="stylesheet"
        type="text/css" />
     <script src="../fencybox/lib/jquery.mousewheel-3.0.6.pack.js" type="text/javascript"></script>
     <script src="../fencybox/source/jquery.fancybox.js" type="text/javascript"></script>
    <script src="../fencybox/source/jquery.fancybox.pack.js" type="text/javascript"></script>
    <script type="text/javascript">
        
        $(document).ready(function () {
            $(".fancybox").fancybox({
                type: 'iframe',
                transitionIn:    'elastic',
                transitionOut:    'elastic',
                speedIn:600,
                speedOut:200,
                overlayShow: false,
                'frameWidth': 1100, // set the width
                'frameHeight': 600,
            'width': 1100,
            'height': 600,
                });
            });
    </script>

<!--custom scroller-->
    <link rel="stylesheet" type="text/css" href="customscroller/jquery.mCustomScrollbar.css" media="screen" />
	<script>window.jQuery || document.write('<script src="customscroller/jquery-1.11.0.min.js"><\/script>')</script>
	<script src="customscroller/jquery.mCustomScrollbar.concat.min.js"></script>
	
<!--load data-->
      <script type="text/javascript">  
        $(document).ready(function() {  
            SearchText();  
        });
         
    </script>  
     
    
</head>

<body>
<form runat="server" id="frmBrands" >
      <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
                        </asp:ScriptManager>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server" >
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <div class="dvLoading"></div>
                </ProgressTemplate>

            </asp:UpdateProgress>
            <div id="inline1" style="max-width: 1100px; width: 100%;">
                <div id="demo">
                    <section id="examples">
                        <div class="content mCustomScrollbar">
                            <div id="divAlerts" runat="server" class="alert" visible="False">
                                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                                    Text="" Visible="True"></asp:Label>
                            </div>
                            <div class="col-md-12">
                                <div class="lightboxmaintext" style="float:unset;">
                                    <div class="col-md-5">
                                        <asp:Repeater runat="server" ID="rptLbItems">
                                            <ItemTemplate>
                                                <img src="../photobank/<%# Eval("Image") %>" width="100%" />
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                    <!--5-->

                                </div>
                                <!--5-->
                                <div class="col-md-7">
                                    <div class="col-md-12 commheading">Comments - (<asp:Label runat="server" ID="lblTotalComments"></asp:Label>)</div>
                                    <div class="col-md-12">
                                         <asp:TextBox runat="server" id="txtComments" placeholder="Leave A Comments" class="texta" name="texta"  TextMode="MultiLine"  ></asp:TextBox> 
                                        <asp:CustomValidator ID="cvComments" ValidationGroup="gpComments" runat="server" SetFocusOnError="true" Display="Dynamic"
                                            ValidateEmptyText="true" ControlToValidate="txtComments" ClientValidationFunction="changeColor" align="left" CssClass="validationSummary"></asp:CustomValidator>
                                       
                                        <div class="lightboxblockmain2">
                                            <div class="lightboxeditbutton">
                                                <asp:LinkButton runat="server" type="submit" ID="btnPostComment" OnClick="btnAddComment_Click" ValidationGroup="gpComments">Post a Comment</asp:LinkButton></div>
                                            <!--lightboxeditbutton-->
                                        </div>
                                    </div>
                                    <!--col-md-12-->

                                    <div class="col-md-12" style="margin: 0 0 20px 0; float: left; width: 100%; border-bottom: #a8a8a8 solid 1px;"></div>
                                    <asp:GridView ID="grdComments" runat="server" AutoGenerateColumns="False" DataSourceID="sdsComments" Width="100%" GridLines="None" ShowHeader="False" OnRowDataBound="grdComments_RowDataBound" OnRowCommand="grdComments_RowCommand">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Title" SortExpression="Title">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Title") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <div class="col-md-12">
                                                        <div class="col-md-2" id="comimg">
                                                            <a href="#">
                                                                <img class="img-circle" src='<%# Eval("U_ProfilePic","../profilethumbs/{0}") %>' alt="image" style="margin-top: 6px;" /></a>
                                                        </div>
                                                        <div class="col-md-10">
                                                            <span class="commh" style="margin-right: 20px;"><a href="#"><%# Eval("U_Firstname") %> </a>
                                                                <br />
                                                            </span>
                                                            <span class="commtext"><%# Eval("Title","{0}") %></span>
                                                            <div class="col-md-12 reply">
                                                                <asp:ImageButton runat="server" ID="imgbtnReply"  ImageUrl="../images/reply.png" CommandName="1" CommandArgument='<%# Eval("CommID") %>' ></asp:ImageButton>
                                                               
                                                            </div>
                                                            <div class="col-md-12">
                                                                <asp:Panel runat="server" ID="pnlReply" Visible="false" DefaultButton="btnReply" CommandName="2">
                                                                    <asp:TextBox runat="server" ID="txtReply" Width="100%"></asp:TextBox>
                                                                    <asp:Button runat="server" ID="btnReply" style="display:none;" CommandName="2" CommandArgument='<%# Eval("CommID") %>'/>
                                                                </asp:Panel>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <asp:GridView ID="grdReply" runat="server" AutoGenerateColumns="False" Width="100%" GridLines="None" ShowHeader="False">
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <div class="col-md-11" style="margin-left: 40px;">
                                                                        <div class="col-md-2" id="comimg">
                                                                            <a href="">
                                                                                <img class="img-circle" src='<%# Eval("U_ProfilePic","../profilethumbs/{0}") %>' alt="image" style="margin-top: 6px;" /></a>
                                                                        </div>
                                                                        <div class="col-md-10">
                                                                            <span class="commh" style="margin-right: 20px;"><a href=""><%# Eval("U_Firstname") %></a>
                                                                                <br />
                                                                            </span>
                                                                            <span class="commtext"><%# Eval("Title","{0}") %> </span>
                                                                            <div class="col-md-12 reply">
                                                                                 <asp:ImageButton runat="server" ID="imgbtnReply" ImageUrl="../images/reply.png" CommandName="1" CommandArgument='<%# Eval("CommID") %>'></asp:ImageButton>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <asp:SqlDataSource ID="sdsComments" runat="server" ConnectionString="<%$ ConnectionStrings:GvConnection %>" ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" SelectCommand="SELECT dbo.Tbl_LbComments.CommID, dbo.Tbl_LbComments.Title, dbo.Tbl_LbComments.DatePosted, dbo.Tbl_LbComments.LookID, U_Firstname + ' ' +U_Lastname as [U_Firstname], dbo.Tbl_Users.U_ProfilePic FROM dbo.Tbl_Users INNER JOIN dbo.Tbl_LbComments ON dbo.Tbl_Users.UserID = dbo.Tbl_LbComments.UserID
Where LookID=? AND ParentID=0
ORDER BY Tbl_LbComments.DatePosted DESC">
                                                        <SelectParameters>
                                                            <asp:QueryStringParameter Name="?" QueryStringField="v" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="sdsComments" runat="server" ConnectionString="<%$ ConnectionStrings:GvConnection %>" ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" SelectCommand="SELECT dbo.Tbl_LbComments.CommID, dbo.Tbl_LbComments.Title, dbo.Tbl_LbComments.DatePosted, dbo.Tbl_LbComments.LookID, U_Firstname + ' ' +U_Lastname as [U_Firstname], dbo.Tbl_Users.U_ProfilePic FROM dbo.Tbl_Users INNER JOIN dbo.Tbl_LbComments ON dbo.Tbl_Users.UserID = dbo.Tbl_LbComments.UserID
Where LookID=?
ORDER BY Tbl_LbComments.DatePosted DESC">
                                        <SelectParameters>
                                            <asp:QueryStringParameter Name="?" QueryStringField="v" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    
                                    <!--col-md-12-->

                                    
                                    <!--col-md-12-->
                                </div>
                                <!--7-->
                            </div>
                            <!--12-->

                        </div>
                </div>
            </div></div><!--inline-->
            <!--inline-->
           
        </ContentTemplate>
    </asp:UpdatePanel>  
   
<!--footer-->
    <div class="footerbg">
        <div class="row">
            <div class="col-md-11 col-xs-10">©<%: DateTime.Now.Year %> Press Preview</div>
            <div class="col-md-pull-1 col-xs-pull-1">
                <div class="f1"><a id="loaddata">
                    <img src="../images/footerarrow.png" /></a></div>
                <div class="f2">
                    <a id="loaddatan">Expand</a></div>
                </div>
            </div>
        </div>
    </div><!--footer-->
<!--footer-->

<!--wrapper-->

<script src="../js/bootstrap.js"></script>
    <script type="text/javascript">
        function ShowText(txtID) {
            document.getElementById(TxtID).style.display =
        (document.getElementById(TxtID).style.display == 'none') ? 'block' : 'none';

        }
        function changeColor(source, args) {
            var txtComments = document.getElementById('txtComments');
            var strimg = new Array();
            strimg = [txtComments];
            if (args.Value == "") {
                args.IsValid = false;
                document.getElementById(source.id.replace('cv', 'txt')).style.border = '1px solid red';
            }
            else {
                args.IsValid = true;
                document.getElementById(source.id.replace('cv', 'txt')).style.border = '1px solid #7d7d7d';
            }
        }
    </script>
</form>

</body>
</html>
