<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cropper.aspx.cs" Inherits="editor_cropper" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Image Cropper</title>
      <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="../js/bootstrap.js" type="text/javascript"></script>
    <link href="../css/bootstrapm.css" rel="stylesheet" type="text/css" />
    <link href="../css/jquery-ui.css" rel="stylesheet" type="text/css" />
    
     <link href="https://cdn.rawgit.com/fengyuanchen/cropper/v0.11.1/dist/cropper.min.css" rel="stylesheet">
    <script src="https://cdn.rawgit.com/fengyuanchen/cropper/v0.11.1/dist/cropper.min.js"></script>

    <script src="https://rawgit.com/enyo/dropzone/master/dist/dropzone.js"></script>
    <link rel="stylesheet" href="https://rawgit.com/enyo/dropzone/master/dist/dropzone.css" />
    
    <script>

        $(document).ready(function () {
            Dropzone.autoDiscover = false;
            //Simple Dropzonejs
            $("#dZUpload").dropzone({
                url: "profilepics.ashx",
                addRemoveLinks: true,
                maxFiles: 1,
                maxFilesize: 5,

                //previewsContainer: "#previews",

                dictDefaultMessage: "Drag or click to add profile image",


                success: function (file, response) {
                    var imgName = response;
                    file.previewElement.classList.add("dz-success");
                    console.log('Successfully uploaded :' + imgName);



                    var imgName = response;
                    d = new Date();
                    $("#imgcrop").attr("src", "");

                    $(".photo_to_crop1").attr("src", "../photobank/0eebdefd6c.jpg");



                    $("#img_name").attr("value", imgName);



                    window.intialize();
                },
                error: function (file, response) {
                    file.previewElement.classList.add("dz-error");
                },

                sending: function (file, xhr, formData) {



                    formData.append('name', $("input[name=name]").val());



                },
                complete: function (response) {

                }



            });
        });
    </script>
    
     <script>



         function intialize() {

             var imageURL = $(".photo_to_crop1").attr("src");
             var imageBox = $('.photo_to_crop');


             var options = {
                 aspectRatio: 1,

                 movable: true,
                 zoomable: true,
                 responsive: true,
                 center: true,
                 scalable: true,
                 crop: getcroparea
             };

             if (imageURL != null) {
                 console.log("It's not empty, building dedault box!");
                 var DefaultCropBoxOptionObj = {
                     height: 25,
                     width: 25
                 };
                 console.log(DefaultCropBoxOptionObj);
                 imageBox.cropper(options);
                 imageBox.cropper('setData', DefaultCropBoxOptionObj);
                 imageBox.cropper('replace', imageURL);

             }
         }


         function getcroparea(c) {
             $('#hdnx').val(parseInt(c.x));
             $('#hdny').val(parseInt(c.y));
             $('#hdnw').val(parseInt(c.width));
             $('#hdnh').val(parseInt(c.height));
             $('#hdnr').val(parseInt(c.rotate));
             $('#hdnsx').val(parseInt(c.scaleX));
             $('#hdnsy').val(parseInt(c.scaleY));
         };




    </script>


</head>
<body>
    <form id="form1" runat="server">

        <div id="dZUpload" class="dropzone">
            <div class="dz-default dz-message">

                <p style="font-family: 'Open Sans'">Drop a photo here or click to add profile photo</p>
            </div>
        </div>
        <div>
            <input id="username" type="text" name="name" value="<% =ServerValue %>" style="display: none;" />

            <img id="img1" alt="sample image" src="" class="photo_to_crop1" style="display: none;" />
              <div style="padding-bottom: 5px; padding-top: 5px; width: 300px">

                <img id="imgcropped" runat="server" visible="false" class="img-responsive" />

                <h5>
                    <asp:Label ID="my_ad_err_lbl" runat="server" Text=""></asp:Label></h5>
            </div>
            <div class="container cropcontainer">
                <img id="imgcrop" alt="sample image" src="" class="photo_to_crop" />
                <input type="text" style="display: none" id="img_name" name="img_name" value="user.png" />
            </div>

            <input type="hidden" id="hdnx" runat="server" />
            <input type="hidden" id="hdny" runat="server" />
            <input type="hidden" id="hdnw" runat="server" />
            <input type="hidden" id="hdnh" runat="server" />
            <input type="hidden" id="hdnr" runat="server" />
            <input type="hidden" id="hdnsx" runat="server" />
            <input type="hidden" id="hdnsy" runat="server" />

            <asp:Button ID="btncrop" runat="server" OnClick="btncrop_Click" Text="Crop and Save" CssClass="button3" OnClientClick="reload()" />
            <asp:Button ID="save_original" runat="server" OnClick="btnsave_original_Click" Text="Save original" CssClass="button3" OnClientClick="reload()" Style="display: none;" />
            <asp:Button ID="pic_delete" runat="server" OnClick="btndelete_Click" Text="Delete Photo" OnClientClick="deletepic()" CssClass="button3" />

          




        </div>



    </form>

</body>
</html>
