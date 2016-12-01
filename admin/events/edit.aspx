<%@ Page Language="C#" ValidateRequest="false" AutoEventWireup="true" CodeFile="edit.aspx.cs" Inherits="admin_home_Default" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox, Version=3.3.1.12354, Culture=neutral, PublicKeyToken=5962a4e684a48b87" %>

<!DOCTYPE html>
<html>

<head runat="server">

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>PP :: Dashboard</title>
<style>
        #txtPara1_toolbarArea,#txtPara2_toolbarArea{
        display: none
    }
    #txtPara1_TabRow,#txtPara2_TabRow{
        display: none
    }
</style>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="../css/animate.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">
     <link href="../../DropzoneJs_scripts/basic.css" rel="stylesheet" type="text/css" />
        <link href="../../DropzoneJs_scripts/dropzone.css" rel="stylesheet" type="text/css" />
        <script src="../../DropzoneJs_scripts/dropzone.js" type="text/javascript"></script>
    <link href="../css/ajaxtabs.css" rel="stylesheet" type="text/css" />
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBDqfn0oWwSMR8xsTXBKQR61WPC454_0Hw&callback=initMap"
  type="text/javascript"></script>
<script language="javascript" type="text/javascript">

    var map;
    var geocoder;
    function InitializeMap() {

        var latlng = new google.maps.LatLng(-34.397, 150.644);
        var myOptions =
        {
            zoom: 15,
            center: latlng,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            disableDefaultUI: true
        };
        map = new google.maps.Map(document.getElementById("map"), myOptions);
    }

    function FindLocaiton() {
        geocoder = new google.maps.Geocoder();
        InitializeMap();


        var txtAddress = document.getElementById("txtLocation");
        var address = txtAddress.value;
        geocoder.geocode({ 'address': address }, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                map.setCenter(results[0].geometry.location);
                var marker = new google.maps.Marker({
                    map: map,
                    position: results[0].geometry.location
                });

            }
            else {
                //alert("Geocode was not successful for the following reason: " + status);
            }
        });

    }

    function showAddress() {
        geocoder = new google.maps.Geocoder();
        initialize()
        var txtAddress = document.getElementById("txtLocation");
        var address = txtAddress.value;

        geocoder.getLatLng(
                address,
                function (point) {
                    if (!point) {
                        alert(address + " not found");
                    }
                    else {
                        map.setCenter(point, 15);
                        var marker = new GMarker(point);
                        map.addOverlay(marker);
                        marker.openInfoWindow(address);
                    }
                }
            );
    }

    //function Button1_onclick() {
    //   FindLocaiton();
    //}

    window.onload = InitializeMap;

</script>
        <style type="text/css">
            .ribbon-wrapper {
   /* width: 85px; */
    /* height: 88px; */
    overflow: hidden;
    position: absolute;
    /* top: -3px; */
    /* right: -3px; */
    z-index: 10000;
}
.ui-datepicker { font-size:8pt !important}
div.ribbon {
       color: #fff;
    text-align: center;
    text-shadow: rgba(0,0,0,0.5) 0px 1px 0px;
    /* -webkit-transform: rotate(45deg); */
    -moz-transform: rotate(45deg);
    -ms-transform: rotate(45deg);
    -o-transform: rotate(45deg);
    position: relative;
    /* padding: 7px 0; */
    /* top: 15px; */
    /* width: 40px; */
    background-color: #b02939;
    background-image: -webkit-gradient(linear, left top, left bottom, from(#c00), to(#b02939));
    background-image: -webkit-linear-gradient(top, #c00, #b02939);
    background-image: -moz-linear-gradient(top, #c00, #b02939);
    background-image: -ms-linear-gradient(top, #c00, #b02939);
    background-image: -o-linear-gradient(top, #c00, #b02939);
    -webkit-box-shadow: 0px 0px 3px rgba(0,0,0,0.3);
    -moz-box-shadow: 0px 0px 3px rgba(0,0,0,0.3);
    box-shadow: 0px 0px 3px rgba(0,0,0,0.3);
    font-size: 0.8em;
    font-weight: bold;
    font-family: sans-serif;
}

.ribbon:before {
    left: 0;
}
.ribbon:before, .ribbon:after {
    content: "";
    border-top: 3px solid #600;
    border-left: 3px solid;
    border-right: 3px solid;
    position: absolute;
    bottom: -3px;
}
        </style>
        
        <script type="text/javascript">
            function GetParameterValues(param) {
                var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                for (var i = 0; i < url.length; i++) {
                    var urlparam = url[i].split('=');
                    if (urlparam[0] == param) {
                        return urlparam[1];
                    }
                }

            }
            var eventId = GetParameterValues('v');
            //File Upload response from the server
            Dropzone.options.dropzoneForm = {
            // Validate the file type. only accept images
                acceptedFiles: 'image/*',
                maxFiles: 10,
                dictDefaultMessage: "Click here to upload more event pics (Optional)",
                url: "eventimges.ashx?v="+eventId,
                thumbnailWidth: 150,
                thumbnailHeight: 150,

                init: function () {
                    this.on("maxfilesexceeded", function (data) {
                        var res = eval('(' + data.xhr.responseText + ')');
                    });

                    // Get response on Success
                    this.on('success', function (file, resp) {
                        console.log(file);
                        console.log(resp);
                    });
//                    // Validate the dimensions of the image....
//                    this.on('thumbnail', function (file) {
//                        if (file.width < 800 || file.height < 600) {
//                            file.rejectDimensions();
//                        }
//                        else {
//                            file.acceptDimensions();
//                        }
//                    });

                    this.on("addedfile", function (file) {

                        // Create the remove button
                        var removeButton = Dropzone.createElement("<button style='position:absolute; margin-top: -150px; margin-left: 130px; z-index: 100; background:red; border:0; color:#fff;'>X</button>");
                        // Capture the Dropzone instance as closure.
                        var _this = this;
                        // Listen to the click event
                        removeButton.addEventListener("click", function (e) {
                            // Make sure the button click doesn't submit the form:
                            e.preventDefault();
                            e.stopPropagation();
                            // Remove the file preview.
                            _this.removeFile(file);
                            // If you want to the delete the file on the server as well,
                            // you can do the AJAX request here.
                        });

                        // Add the button to the file preview element.
                        file.previewElement.appendChild(removeButton);
                    });

                    this.on("removedfile", function (file) {
                        //add in your code to delete the file from the database here 
                        $.ajax({
                            type: "POST",
                            url: 'addnew.aspx\\RemoveImage',
                            data: "{'filename':'" + file.name + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: true,
                            cache: false,
                            success: function (data) {

                            }
                        });
                    });

                }
//                accept: function (file, done) {
//                    file.acceptDimensions = done;
//                    file.rejectDimensions = function () {
//                        done('The image must be at least 800x600px');
//                    };
//                }
            };   
   
        </script>
    <script type="text/javascript">
        //File Upload response from the server
        
        var eventId = GetParameterValues('v');
        Dropzone.options.dzFeatured = {
        // Validate the file type. only accept images
            acceptedFiles: 'image/*',
            dictDefaultMessage: "Click here to upload event feature image (required)",
            maxFiles: 1,
            url: "featured.ashx?v="+eventId,
            thumbnailWidth: 150,
            thumbnailHeight: 150,
            init: function () {
                var thisDropzone = this;
                // To retrieve the existing feature image
                //Call the action method to load the images from the server
                $.getJSON("edit.aspx/GetFeatureImage").done(function (data) {
                    if (data.Data != '') {

                        $.each(data.Data, function (index, item) {
                            //// Create the mock file:
                            var mockFile = {
                                name: item.AttachmentID,
                                size: 12345
                            };

                            // Call the default addedfile event handler
                            thisDropzone.emit("addedfile", mockFile);

                            // And optionally show the thumbnail of the file:
                            thisDropzone.emit("thumbnail", mockFile, item.Path);

                            // If you use the maxFiles option, make sure you adjust it to the
                            // correct amount:
                            //var existingFileCount = 1; // The number of files already uploaded
                            //myDropzone.options.maxFiles = myDropzone.options.maxFiles - existingFileCount;
                        });
                    }
                });
                this.on("maxfilesexceeded", function (data) {
                    var res = eval('(' + data.xhr.responseText + ')');
                });

                // Get response on Success
                this.on('success', function (file, resp) {
                    console.log(file);
                    console.log(resp);
                });
//                // Validate the dimensions of the image....
//                this.on('thumbnail', function (file) {
//                    if (file.width < 336 || file.height < 170) {
//                        file.rejectDimensions();
//                    }
//                    else {
//                        file.acceptDimensions();
//                    }
//                });

                this.on("addedfile", function (file) {

                    // Create the remove button
                    var removeButton = Dropzone.createElement("<button style='position:absolute; margin-top: -150px; margin-left: 130px; z-index: 100; background:red; border:0; color:#fff;'>X</button>");
                    // Capture the Dropzone instance as closure.
                    var _this = this;
                    // Listen to the click event
                    removeButton.addEventListener("click", function (e) {
                        // Make sure the button click doesn't submit the form:
                        e.preventDefault();
                        e.stopPropagation();
                        // Remove the file preview.
                        _this.removeFile(file);
                        // If you want to the delete the file on the server as well,
                        // you can do the AJAX request here.
                    });

                    // Add the button to the file preview element.
                    file.previewElement.appendChild(removeButton);
                });

                this.on("removedfile", function (file) {
                    //add in your code to delete the file from the database here 
                    $.ajax({
                        type: "POST",
                        url: 'edit.aspx\\RemoveImage',
                        data: "{'filename':'" + file.name + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function (data) {

                        }
                    });
                });

            }
//            accept: function (file, done) {
//                file.acceptDimensions = done;
//                file.rejectDimensions = function () {
//                    done('The image must be at least 336 x 171px');
//                };
//            }
        };
   
   
    </script>
    <script type="text/javascript">
        //File Upload response from the server
        var eventId = GetParameterValues('v');
        Dropzone.options.dzCenter = {
        // Validate the file type. only accept images
            acceptedFiles: 'image/*',
            dictDefaultMessage: "Click here to upload event content image (required)",
            maxFiles: 1,
            url: "centerImg.ashx?v="+eventId,
            thumbnailWidth: 150,
            thumbnailHeight: 150,
            init: function () {
                this.on("maxfilesexceeded", function (data) {
                    var res = eval('(' + data.xhr.responseText + ')');
                });

                // Get response on Success
                this.on('success', function (file, resp) {
                    console.log(file);
                    console.log(resp);
                });
//                // Validate the dimensions of the image....
//                this.on('thumbnail', function (file) {
//                    if (file.width < 800 || file.height < 600) {
//                        file.rejectDimensions();
//                    }
//                    else {
//                        file.acceptDimensions();
//                    }
//                });

                this.on("addedfile", function (file) {

                    // Create the remove button
                    var removeButton = Dropzone.createElement("<button style='position:absolute; margin-top: -150px; margin-left: 130px; z-index: 100; background:red; border:0; color:#fff;'>X</button>");
                    // Capture the Dropzone instance as closure.
                    var _this = this;
                    // Listen to the click event
                    removeButton.addEventListener("click", function (e) {
                        // Make sure the button click doesn't submit the form:
                        e.preventDefault();
                        e.stopPropagation();
                        // Remove the file preview.
                        _this.removeFile(file);
                        // If you want to the delete the file on the server as well,
                        // you can do the AJAX request here.
                    });

                    // Add the button to the file preview element.
                    file.previewElement.appendChild(removeButton);
                });

                this.on("removedfile", function (file) {
                    //add in your code to delete the file from the database here 
                    $.ajax({
                        type: "POST",
                        url: 'addnew.aspx\\RemoveImage',
                        data: "{'filename':'" + file.name + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function (data) {

                        }
                    });
                });

            }
//            accept: function (file, done) {
//                file.acceptDimensions = done;
//                file.rejectDimensions = function () {
//                    done('The image must be at least 800 x 600px');
//                };
//            }
        };
   
   
    </script>
      
</head>

<body onload="FindLocaiton()">
    <form id="form1" runat="server" role="form">
    <div id="wrapper">
    <!--#INCLUDE FILE="../includes/leftmenu.txt" -->

        <div id="page-wrapper" class="gray-bg">
        <div class="row border-bottom">
         <!--#INCLUDE FILE="../includes/header.txt" -->
        </div>
            <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-lg-8">
                    <h2>Events</h2>
                    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
                        </asp:ScriptManager>
                    <ol class="breadcrumb">
                        <li>
                            <a href="../home/">Home</a>
                        </li>
                        <li><a href="Default.aspx">Events</a></li>
                        <li><a href="edit.aspx">Edit Event</a></li>
                    </ol>
                </div>
                <div class="col-lg-4 pull-right">
                    <h2>
                     <asp:LinkButton runat="server" ID="btnCancel" CausesValidation="false" class="btn btn-sm btn-primary pull-right m-t-n-xs" style="margin:3px;" Text="Cancel <i class='ace-icon fa fa-remove' style='margin-left:5px;'></i>" OnClick="btnCancel_Click"></asp:LinkButton>
                     <asp:Button runat="server" ID="btnSave" CausesValidation="true" ValidationGroup="gpMain" class="btn btn-sm btn-primary pull-right m-t-n-xs" style="margin:3px;"  Text="Save" OnClick="btnSave_Click"></asp:Button>
                    </h2>
                </div>
                
            </div>
            <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
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
                                         <asp:Label runat="server" ID="lblStatus" for="PageMessage"  Text="" Visible="True"></asp:Label>
                                    </div>
                                    <asp:ValidationSummary ID="Vs1" runat="server"  ValidationGroup="gpMain" 
                                        HeaderText="The following fields are missing or invalid" style="color: red; margin-left: 50px; padding: 15px;"/>
                                    <div class="col-lg-2"></div>
                                    <div class="col-lg-8">                          
                                        
                                        <div class="form-group">
                                           <label>Event Title</label><span class="text-danger">*</span> 
                                            <input type="text" runat="server" id="txtEventTitle" placeholder="Give it a short distinct name" class="form-control" />
                                            <asp:RequiredFieldValidator ID="RfvTitle" runat="server" ErrorMessage="Event Title" ValidationGroup="gpMain" ControlToValidate="txtEventTitle" Display="None"></asp:RequiredFieldValidator>
                                         </div>

                                        
                                        <div class="form-group">
                                           <div class="col-sm-6" style="padding-left:0px; padding-bottom: 15px;">
                                                <label>Starts</label><span class="text-danger">*</span> 
                                           <asp:TextBox ID="txtStartDate" runat="server"  placeholder="Event Start Date" class="form-control" ></asp:TextBox>
                                            
                                            <asp:CalendarExtender ID="txtEventDate_CalendarExtender" runat="server" 
                                                Enabled="True" TargetControlID="txtStartDate">
                                            </asp:CalendarExtender>
                                            <asp:RequiredFieldValidator ID="RFVDate" runat="server" ErrorMessage="Event Start Date" ValidationGroup="gpMain" ControlToValidate="txtStartDate" Display="None"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="col-sm-6" style="padding-left:0px; padding-right:0px; padding-bottom: 15px;">
                                              <label>&nbsp;</label>     
                                           <asp:TextBox ID="txtStartTime" runat="server" placeholder="Event Start Time" class="form-control"></asp:TextBox>
                                                 <asp:MaskedEditExtender ID="txtTime_MaskedEditExtender" runat="server" 
                                                     CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" 
                                                     CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                     CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" 
                                                     Mask="99:99" MaskType="Time" TargetControlID="txtStartTime" AcceptAMPM="True"></asp:MaskedEditExtender>
                                                <asp:RequiredFieldValidator ID="RFVTime" runat="server" ErrorMessage="Event Start Time" ValidationGroup="gpMain" ControlToValidate="txtStartTime" Display="None"></asp:RequiredFieldValidator>
                                            </div>
                                           
                                         </div>
                                          <div class="form-group">
                                           <div class="col-sm-6" style="padding-left:0px;  padding-bottom: 15px;">
                                                <label>Ends</label><span class="text-danger">*</span> 
                                           <asp:TextBox ID="txtEndDate" runat="server"  placeholder="Event End Date" class="form-control" ></asp:TextBox>
                                            
                                            <asp:CalendarExtender ID="CalendarExtender1" runat="server" 
                                                Enabled="True" TargetControlID="txtEndDate">
                                            </asp:CalendarExtender>
                                            <asp:RequiredFieldValidator ID="RFVEndDate" runat="server" ErrorMessage="Event End Date" ValidationGroup="gpMain" ControlToValidate="txtEndDate" Display="None"></asp:RequiredFieldValidator>
                                            </div>
                                           <div class="col-sm-6" style="padding-left:0px; padding-right:0px; padding-bottom: 15px;">
                                            <label>&nbsp;</label>         
                                           <asp:TextBox ID="txtEndTime" runat="server" placeholder="Event End Time" class="form-control"></asp:TextBox>
                                                 <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" 
                                                     CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" 
                                                     CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                     CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" 
                                                     Mask="99:99" MaskType="Time" TargetControlID="txtEndTime" AcceptAMPM="True"></asp:MaskedEditExtender>
                                                <asp:RequiredFieldValidator ID="RFVEndTime" runat="server" ErrorMessage="Event End Time" ValidationGroup="gpMain" ControlToValidate="txtEndTime" Display="None"></asp:RequiredFieldValidator>
                                            </div>
                                           
                                         </div>    
                                          <div class="form-group">
                                          <div class="col-sm-6" style="padding-left: 0px;">
                                          <label>Featured Image</label><span class="text-danger">*</span>
                                              <div  class="dropzone" id="dzFeatured">
                                                  <div class="dz-message" data-dz-message>
                                                      <h2>UPDATE EVENT IMAGE</h2>
                                                      <p>Choose an image that captures your event.</p>
                                                  </div>
                                                <div class="fallback">
                                                    <input name="file" type="file" multiple />
                                                    <input type="submit" value="Upload" />
                                                </div>  
                                              </div>
                                            </div>
                                            <div class="col-sm-6" style="padding-left: 0px;">
                                                 <label>Current Featured Image</label>
                                                <asp:Image ID="imgEventFeature" runat="server" style="width:300px; margin-bottom:20px;"/>
                                            </div>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label>Description 1</label> 
                                            <%--<textarea type="text" runat="server" id="txtPara1" style="height:150px;"  placeholder="Event first description (required)" class="form-control" />--%>
                                             <FTB:FreeTextBox runat="server" ID="txtPara1" ButtonSet="OfficeMac" 
          Height="200px" 
          ToolbarLayout="JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent; InsertRule|Cut,Copy,Paste;Print" 
          ToolbarStyleConfiguration="Office2000" Width="100%"></FTB:FreeTextBox>
                                            <asp:RequiredFieldValidator ID="RfvDetails1" runat="server" ErrorMessage="Event Details 1" ValidationGroup="gpMain" ControlToValidate="txtPara1" Display="None"></asp:RequiredFieldValidator>

                                        </div>
                                       <div class="form-group">
                                            <div class="col-sm-6" style="padding-left:0px; padding-bottom: 15px;">
                                                 <label>Location</label> <span class="text-danger">*</span>
                                                <input type="text" ID="txtLocation" runat="server"   placeholder="Event Location"  onchange="return FindLocaiton()" onblur="return FindLocaiton()" class="form-control">
                                                <asp:RequiredFieldValidator ID="RfvLocation" runat="server" ErrorMessage="Event Location" ValidationGroup="gpMain" ControlToValidate="txtLocation" Display="None"></asp:RequiredFieldValidator>
                                                <label>City</label> <span class="text-danger">*</span>
                                                <input type="text" runat="server" id="txtCity" placeholder="City" class="form-control">
                                             <asp:RequiredFieldValidator ID="RFVCity" runat="server" ErrorMessage="City" ValidationGroup="gpMain" ControlToValidate="txtCity" Display="None"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="col-sm-6" style="padding-left:0px; padding-bottom: 15px;">
                                                <div id="map" style="width: 340px; height: 200px"></div>
                                            </div>
                                           
                                        </div>
                                        <div class="form-group" style="clear:both;">
                                        <asp:TabContainer runat="server"  ID="tbCenterMedia" ActiveTabIndex="0"  OnClientActiveTabChanged="ActiveTabChanged"
                                            CssClass="MyTabStyle" Visible="True" >
                                            <asp:TabPanel ID="tbImage" runat="server" HeaderText="Image">
                                                <ContentTemplate>
                                                     <div class="form-group">
                                                         <div class="col-sm-6" style="padding-left: 0px;">
                                                      <label>Center Image</label><span class="text-danger">*</span>
                                                          <div  class="dropzone" id="dzCenter">
                                                            <div class="fallback">
                                                                <input name="file" type="file" multiple />
                                                                <input type="submit" value="Upload" />
                                                            </div>  
                                                        </div> 
                                                        </div>
                                                        <div class="col-sm-6" style="padding-left: 0px;">
                                                            <label>Current Center Image</label>
                                                <asp:Image ID="imgCenterFeature" runat="server" style="width:300px; margin-bottom:20px;"/>
                                                        </div> 
                                                    </div>
                                                </ContentTemplate>
                                            </asp:TabPanel>
                                            <asp:TabPanel ID="tbVideo" runat="server" HeaderText=" Embed Video" Height="80">
                                                <ContentTemplate>
                                                     
                                                     <div class="form-group" style="height:80px;">
                                                         <div class="col-sm-3">
                                                              <label>Video Source</label><span class="text-danger">*</span> 
                                                              <asp:DropDownList ID="ddVideoSource" CssClass="form-control " runat="server">
                                                                <asp:ListItem Value="1">YouTube</asp:ListItem>
                                                                <asp:ListItem Value="2">Vimeo</asp:ListItem>
                                                            </asp:DropDownList>
                                                         </div>
                                                         <div class="col-sm-9">
                                                             <label>Video ID</label><span class="text-danger">*</span> 
                                                              <input type="text" runat="server" id="txtEmbedVideo" placeholder="Enter Video Script" class="form-control" >
                                                              <asp:RequiredFieldValidator ID="RfvEmbedVideo" runat="server" ErrorMessage="Video ID" ValidationGroup="gpMain" ControlToValidate="txtEmbedVideo" Display="None" Enabled="False"></asp:RequiredFieldValidator>
                                                         </div>
                                                    
                                                      </div>
                                                </ContentTemplate>
                                            </asp:TabPanel></asp:TabContainer>
                                 
                                       </div>
                                        
                                        
                                        <div class="form-group" style="clear: both; padding-top: 20px;">
                                            <label>Event Description 2</label> 
                                          <%--  <textarea type="text" runat="server" id="txtPara2" style="height:150px;"  placeholder="Event Description second paragraph (optional) " class="form-control" />
--%> <FTB:FreeTextbox runat="server" ID="txtPara2" ButtonSet="OfficeMac" 
          Height="200px" 
          ToolbarLayout="JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent; InsertRule|Cut,Copy,Paste;Print" 
          ToolbarStyleConfiguration="Office2000" Width="100%"></FTB:FreeTextbox>
                                        </div>
                                         <div class="form-group"><label>Category</label>
                                            <asp:DropDownList ID="ddCategory" runat="server" CssClass="form-control" 
                                                 DataSourceID="SqlDataSource1" DataTextField="ECategory" 
                                                 DataValueField="ECategoryID">
                                            </asp:DropDownList>
                                             <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                                 ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                                 ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                                 SelectCommand="SELECT [ECategoryID], [ECategory] FROM [Tbl_EventCategory] ORDER BY [ECategoryID]">
                                             </asp:SqlDataSource>
                                        </div>
                                        
                                         <div class="form-group"><label>RSVP</label> <span class="text-danger">*</span>
                                            
                                            <div class="row">
                                                <div class="col-sm-4">
                                                     <asp:DropDownList ID="ddRsvpType" runat="server" onchange="RsvpValidator()" CssClass="col-sm-2 form-control">
                                                        <asp:ListItem Value="0">External Link</asp:ListItem>
                                                        <asp:ListItem Value="1">Mail To</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-sm-8">
                                                     <input type="text" runat="server" id="txtRSVP" placeholder="" class="col-sm-10 form-control" >
                                                </div>
                                            </div>
                                             <asp:RequiredFieldValidator ID="RFVRsvp" runat="server" ErrorMessage="RSVP" ValidationGroup="gpMain" ControlToValidate="txtRSVP" Display="None"></asp:RequiredFieldValidator>
                                             <asp:RegularExpressionValidator ID="RevExternalLink" runat="server" 
                                                 ControlToValidate="txtRSVP" Display="None" 
                                                 ErrorMessage="Enter valid url for RSVP" 
                                                 ValidationGroup="gpMain"
                                                 ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?"></asp:RegularExpressionValidator>
                                             <asp:RegularExpressionValidator ID="RevMailTo" runat="server" 
                                                 ControlToValidate="txtRSVP" Display="None" 
                                                 ValidationGroup="gpMain"
                                                 ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                 ErrorMessage="Enter valid email address for RSVP" Enabled="False"></asp:RegularExpressionValidator>

                                         </div>
                                         
                                          <div class="form-group">
                                              <div  class="dropzone" id="dropzoneForm">
                                                <div class="fallback">
                                                    <input name="file" type="file" multiple />
                                                    <input type="submit" value="Upload" />
                                                </div>  
                                            </div>

                                        </div>
                                        
                                        <div class="form-group">
                                            <div class="col-sm-12"><label for="existingImg">Uploaded Images</label></div>
                                            <asp:DataList ID="dlImages" runat="server" DataKeyField="EImgID" 
                                                            DataSourceID="sdsImages" onitemcommand="dlImages_ItemCommand" RepeatColumns="2" 
                                                            RepeatDirection="Horizontal" Width="100%">
                                                            <ItemTemplate>
                                                                <div ID="imgContainer">
                                                                    <div style="width:110px; padding:2px; border:2px solid #fff;">
                                                                        <asp:Image ID="imgCertification" runat="server" 
                                                                            ImageUrl='<%# Eval("EImg", "../../eventpics/{0}") %>' Width="300px"  Height="150px"/>
                                                                    </div>
                                                                    <div style="position: relative; top: -155px;">
                                                                        <asp:Button ID="btnRemove" runat="server" 
                                                                            CommandArgument='<%# Eval("EImgID", "{0}") %>' CommandName="1" 
                                                                            CssClass="btn btn-danger btn-xs" 
                                                                            onclientclick="return confirm('Are you sure,you want to delete ?')" Text="X" />
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:DataList>
                                           <asp:SqlDataSource ID="sdsImages" runat="server" 
                                                                        ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                                                         ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>"
                                                                        
                                                            SelectCommand="SELECT [EImgID], [EImg] FROM [Tbl_EventImages] WHERE  [EventID] =?">
                                                                        <SelectParameters>
                                                                            <asp:QueryStringParameter Name="EventID" QueryStringField="v" 
                                                                                Type="String" />
                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                        </div>

                                      </div>          
                                                                       
                                    <div class="col-lg-2">
                                        
                                        
                                    </div>
                                    
                                </div>
                                </div>

                            </div>
                        </div>
                </div>            

                    </div>
         <%--  </ContentTemplate>
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
    <script type="text/javascript">
        function ActiveTabChanged(sender, e) {

            var headerText = sender.get_activeTab().get_headerText();

            if (headerText == "Image") {
             ValidatorEnable(document.getElementById("<%=RfvEmbedVideo.ClientID %>"), false);
            } else {
             ValidatorEnable(document.getElementById("<%=RfvEmbedVideo.ClientID %>"), false);
            }
        }

        function ActiveVideoTabChanged(sender, e) {

            var headerText = sender.get_activeTab().get_headerText();
            if (headerText == "Link") {
               
                ValidatorEnable(document.getElementById("<%=RfvEmbedVideo.ClientID %>"), false);
            } else {
               
                ValidatorEnable(document.getElementById("<%=RfvEmbedVideo.ClientID %>"), true);
            }
        }

        function RsvpValidator() {

            var ddlst = document.getElementById("<%=ddRsvpType.ClientID%>");
            var text = ddlst.options[ddlst.selectedIndex].text;

            if (text == 'External Link') {
                ValidatorEnable(document.getElementById("<%=RevExternalLink.ClientID %>"), true);
                ValidatorEnable(document.getElementById("<%=RevMailTo.ClientID %>"), false);

            }
            else {
                ValidatorEnable(document.getElementById("<%=RevExternalLink.ClientID %>"), false);
                ValidatorEnable(document.getElementById("<%=RevMailTo.ClientID %>"), true);

            }

        }
        </script>
    </form>
</body>
</html>
