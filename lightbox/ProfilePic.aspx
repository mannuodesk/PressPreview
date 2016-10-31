<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeFile="ProfilePic.aspx.cs" Inherits="home" %>
<%@ Register TagPrefix="cc1" Namespace="CS.WebControls" Assembly="CS.WebControls.WebCropImage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Upload Profile Picture</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <link href="../css/jquery.jcrop.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery.Jcrop.min.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        function previewFile() {
            var preview = document.querySelector('#<%=imgMain.ClientID %>');
            var file = document.querySelector('#<%=fupCover.ClientID %>').files[0];
            var reader = new window.FileReader();

            reader.onloadend = function () {
                preview.src = reader.result;
            };
            if (file) {
                reader.readAsDataURL(file);
            } else {
                preview.src = "";
            }
        }
    </script>
    
</head>

<body>
<form runat="server" id="frmBrands">
      <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
                        </asp:ScriptManager>

   <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server" >
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <div id="dvLoading"></div>
                </ProgressTemplate>

            </asp:UpdateProgress>--%>
            <div id="inline1" style="max-width: 1100px; width: 100%;">

                <div id="divAlerts" runat="server" class="alert" visible="False">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                        Text="" Visible="True"></asp:Label>
                </div>
                <div class="lightboxsecondblock">
                    <div class="col-md-12" style="margin-top: 30px; background: #FFF;">
                        <div class="col-md-12 commheading">Upload Cover Photo (Required image size is 100 x 100 )</div>
                        <div class="col-md-12" style="margin-top: 20px;">
                            <div class="col-md-2">
                                Select File :
                            </div>
                            <div class="col-md-6">
                                <asp:FileUpload ID="fupCover"  runat="server" onchange="previewFile()"  CssClass="form-control"></asp:FileUpload>
                            </div>
                            <div class="col-md-4">
                                <div class="lightboxblockmain2">
                                <div class="lightboxeditbutton">
                                    <asp:LinkButton runat="server" ID="btnUpload" OnClick="btnUpload_OnClick">Upload</asp:LinkButton>
                                    <asp:LinkButton runat="server" ID="btnSave" OnClick="btnSave_OnClick">Crop & Save</asp:LinkButton>
                                </div>
                                <!--lightboxeditbutton-->
                            </div>
                            </div>
                            
                        </div>
                        <!--col-md-12-->

                        <div class="col-md-12" style="margin: 0 0 20px 0; float: left; width: 100%; border-bottom: #a8a8a8 solid 1px;">
                            <asp:Image runat="server" ID="imgMain" ImageUrl=""/>
                            <cc1:WebCropImage ID="WebCropImage2" runat="server" CropButtonID="btnSave" CropImage="imgMain"
                                                        CssClass="jquery.jcrop.css" H="150" IncludeJQuery="true" MaxSize="1300,300" MinSize="1300,300"
                                                        ScriptPath="~/js/" Style="position: relative" ToolTip="Resize the image"
                                                        W="1300" />
                           
                        </div>
                        
                        <!--col-md-12-->
                    </div>
                    <!--7-->
                    
                    <!--3-->
                </div>
                <!--lightboxsecondblock-->

                <div id="demo">
                    <section id="examples">
                        <div class="content mCustomScrollbar">
                        </div>
                    </section>
                </div>
            </div><!--inline-->
           
       <%-- </ContentTemplate>
    </asp:UpdatePanel> --%>  
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
 
</form>

</body>
</html>
