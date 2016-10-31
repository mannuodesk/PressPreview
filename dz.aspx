<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dz.aspx.cs" Inherits="dz" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link href="DropzoneJs_scripts/basic.css" rel="stylesheet" type="text/css" />
        <link href="DropzoneJs_scripts/dropzone.css" rel="stylesheet" type="text/css" />
        <script src="DropzoneJs_scripts/dropzone.js" type="text/javascript"></script>
        <script type="text/javascript">
            var file_image = "http://someserver.com/myimage.jpg";

            var mockFile = { name: "myimage.jpg", size: 12345 };

            $("#dropzone").dropzone({

                url: 'false',
                maxFiles: 1,
                maxFilesize: 10, //mb
                acceptedFiles: 'image/*',
                init: function () {
                    this.on("addedfile", function (file) {
                        this.options.thumbnail.call(this, file, file_image);
                    });
                    this.addFile.call(this, mockFile);
                }
            });
        </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
