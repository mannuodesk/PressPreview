<%@ Page Language="C#" ValidateRequest="false"  AutoEventWireup="true"  CodeFile="add-item.aspx.cs" Inherits="pr_brand_add_item" %>
<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox" %>
<!DOCTYPE "html">
<html runat="server">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Press Preview - Add Item</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../css/checkbox.css"/>
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
<link rel="stylesheet" type="text/css" href="../css/styleweb.css"/>
    <link href="../css/ValidationEngine.css" rel="stylesheet" type="text/css" />
<script  type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

    <script src="../js/bootstrap.js" type="text/javascript"></script>
<!--lightbox-->
	
	<link rel="stylesheet" type="text/css" href="../source/jquery.fancybox.css" media="screen" />
 <link href="../DropzoneJs_scripts/basic.css" rel="stylesheet" type="text/css" />
        <link href="../DropzoneJs_scripts/dropzone.css" rel="stylesheet" type="text/css" />
        <script src="../DropzoneJs_scripts/dropzone.js" type="text/javascript"></script>
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="../js/sample.js"></script>
 <link href="../css/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="../js/JSession.js" type="text/javascript"></script>

    <script type="text/javascript" src="../source/jquery.fancybox.js"></script> 
    <style>
        .errorMessage{
            display:none;
            font-size: 14px;
            color: #f92617;
        }
    </style>
     <script>
         $(document).ready(function () {

             var xxx = localStorage.getItem("Result");
             if (xxx == "Done") {
                 $("#lbl_SuccessMessage").text("Record Save Successfully");
                 $("#lbl_SuccessMessage").css("color", "green");
                 $("#lbl_SuccessMessage").css("visibility", "visible");
                 localStorage.removeItem("Result");
                 setTimeout(function () {
                     $("#lbl_SuccessMessage").text("");

                 }, 3000);
             }
             if (xxx == "ErrorMessageAlert") {
                 $("#lbl_SuccessMessage").text("Error Data Saving Please Try Again");
                 //$("#lbl_SuccessMessage").text(xxx);
                 $("#lbl_SuccessMessage").css("color", "red");
                 $("#lbl_SuccessMessage").css("visibility", "visible");
                 localStorage.removeItem("Result");
                 setTimeout(function () {
                     $("#lbl_SuccessMessage").text("");

                 }, 3000);
             }
         });
         function submitValidation() {
             var errorMessage;
             var thumbnailImagecheck;
             var featureImage = [];
             var thumbnailImages = [];
             var CategoriesSelected = [];
             var SeasonsSelected = [];
             var HolidaySelected = [];



             var itemcolor;
             errorFlag = false;
             var CategoriesSelectedlength = $("#chkCategories input:checked").length;
      
             var SeasonsSelectedlength = $("#chkDefaultSeasons input:checked").length;
        
           //  SeasonsSelected=("#chkDefaultSeasons input:checked");
             var HolidaySelectedlength = $("#chkDefaultHoliday input:checked").length;
           
          //   HolidaySelected = $("#chkDefaultHoliday input:checked");



             var itemDetail = $("txtDescription_designEditor").val();
             itemcolor = $('#colbtn').css("background-color");

             $("#dzItemFeatured .dz-image img").each(function () {
                 featureImage.push($(this).attr('src'));
             });

             $("#dzItemPics .dz-image img").each(function () {
                 thumbnailImages.push($(this).attr('src'));
             });
             var TitleText = $("#txtItemTitle").val();
             if ($("#txtItemTitle").val() == "") {
                 $("#errorTitle").remove();
                 errorMessage = "Please enter TITLE";
                 var errorDiv = "<p class='errorMessage' id='errorTitle'>" + errorMessage + "</p>"
                 $("#title_add").append(errorDiv);
                 errorFlag=true;
             }
             else {
                 $("#errorTitle").remove();
             }


             var RetailText = $("#txtRetail").val();
             if ($("#txtRetail").val() == "") {
                 $("#errorRetail").remove();
                 errorMessage = "Please enter Retail";
                 var errorDiv = "<p class='errorMessage' id='errorRetail'>" + errorMessage + "</p>"
                 $("#retail_add").append(errorDiv);
                 errorFlag = true;
             }
             else {
                 $("#errorRetail").remove();
             }


             var WholesaleText = $("#txtWholesale").val();
             if ($("#txtWholesale").val() == "") {
                 $("#errorWholesale").remove();
                 errorMessage = "Please enter Wholesale Price";
                 var errorDiv = "<p class='errorMessage' id='errorWholesale'>" + errorMessage + "</p>"
                 $("#wholesale_add").append(errorDiv);
                 errorFlag = true;
             }
             else {
                 $("#errorWholesale").remove();
             }
             var StyleNumberText = $("#txtStyleNumber").val();
             if ($("#txtStyleNumber").val() == "") {
                 $("#errorStyle").remove();
                 errorMessage = "Please enter Style Number";
                 var errorDiv = "<p class='errorMessage' id='errorStyle' >" + errorMessage + "</p>"
                 $("#styleNumber_add").append(errorDiv);
                 errorFlag = true;
             }
             else {
                 $("#errorStyle").remove();
             }

             var StyleNameText = $("#txtStyleName").val();
             if ($("#txtStyleName").val() == "") {
                 $("#errorStyleName").remove();
                 errorMessage = "Please enter Style Name";
                 var errorDiv = "<p class='errorMessage' id='errorStyleName'>" + errorMessage + "</p>"
                 $("#stylename_add").append(errorDiv);
                 errorFlag = true;
             }
             else {
                 $("#errorStyleName").remove();
             }
             if (CategoriesSelectedlength < 1) {
                 $("#errorCategory").remove();
                 errorMessage = "Please Select Category";
                 var errorDiv = "<p class='errorMessage' id='errorCategory'>" + errorMessage + "</p>"
                 $("#categories_add").append(errorDiv);
                 errorFlag = true;
             }
             else {
                 $("#errorCategory").remove();
             }



             if (itemcolor == "#F4F4F4") {
                 $("#errorItemColor").remove();
                 errorMessage = "Please Select Color";
                 var errorDiv = "<p class='errorMessage' id='errorItemColor'>" + errorMessage + "</p>"
                 $("#color_add").append(errorDiv);
                 errorFlag = true;
             }
             else {
                 $("#errorItemColor").remove();
             }
             if (SeasonsSelectedlength < 1) {
                 $("#errorSeason").remove();
                 errorMessage = "Please Select Season";
                 var errorDiv = "<p class='errorMessage' id='errorSeason'>" + errorMessage + "</p>"
                 $("#seasons_add").append(errorDiv);
                 errorFlag = true;
             }
             else {
                 $("#errorSeason").remove();
             }
             if (HolidaySelectedlength < 1) {
                 $("#errorHoliday").remove();
                 errorMessage = "Please Select Holiday";
                 var errorDiv = "<p class='errorMessage' id='errorHoliday'>" + errorMessage + "</p>"
                 $("#holiday_add").append(errorDiv);
                 errorFlag = true;
             }
             else {
                 $("#errorHoliday").remove();
             }
             if (thumbnailImages.length < 1) {
                 $("#errorthumbnail").remove();
                 errorMessage = "Please add thumbnail Image";
                 var errorDiv = "<p class='errorMessage' id='errorthumbnail'>" + errorMessage + "</p>"
                 $("#thumbnail_add").append(errorDiv);
                 errorFlag = true;
             }
             else {
                 $("#errorthumbnail").remove();
             }
             if (featureImage.length < 1) {
                 $("#errorfeature").remove();
                 errorMessage = "Please add feature Image";
                 var errorDiv = "<p class='errorMessage' id='errorfeature'>" + errorMessage + "</p>"
                 $("#feature_add").append(errorDiv);
                 errorFlag = true;
             }
             else {
                 $("#errorfeature").remove();
             }

             if (errorFlag == true) {
                 $(".errorMessage").css("display", "block");
             }
             else {
                 $.ajax({
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "add-item.aspx\\SaveItem",
                     data: '{TitleText: "' + TitleText + '",RetailText: "' + RetailText + '",WholesaleText: "' + WholesaleText + '",StyleNumberText: "' + StyleNumberText + '",StyleNameText: "' + StyleNameText + '"}',
                     //data: { "TitleText": TitleText, "RetailText": RetailText, "WholesaleText": WholesaleText, "StyleNumberText": StyleNumberText, "StyleNameText": StyleNameText },
                     dataType: "json",
                     success: function (data) {
                         
                         localStorage.setItem("Result", "Done");
                         window.location.reload();
                     },
                     error: function (result) {
                         localStorage.setItem("Result", "ErrorMessageAlert");
                         //alert("No Match"); 
                       //  response("No Match Found");
                     }
                 });
             }
         }
         $(document).ready(function () {
             //option A
            $("#frm1").submit(function(e){
               // alert('submit intercepted');
                e.preventDefault(e);
            });
             //$("#btnPublish").on('click',(function(event) {
             //    event.preventDefault();
             //    event.stopPropagation();
             //   var cnt = $("#chkCategories input:checked").length;
             //    if(cnt==0) {
             //        alert('Please select category !');
             //        event.preventDefault();
                    
             //    }
                     
             //    var imageArray1 = [];
             //    $("#dzItemFeatured .dz-image img").each(function(){
             //        imageArray1.push($(this).attr('src'));
             //    });
             //    if(imageArray1.length<=0) {
             //        {
             //            $('#lblStatus').html("Feature Image is required.");
             //        $('#divAlerts').show();
             //        alert("Feature image is required");
             //           event.preventDefault();
             //        event.stopPropagation();
             //        }
                     
             //    }
             //}));
            
             $("#btnPreview").click(function () {
               
                 $(".lightboxheadertext").html($("#txtItemTitle").val());
                 $("#dvdescription").html($("#txtDescription").val());
                 $("#dvRetail").html($("#txtRetail").val());
                 $("#dvWholesale").html($("#txtWholesale").val());
                 $("#dvstyleNo").html($("#txtStyleNumber").val());
                 $("#dvstyleName").html($("#txtStyleName").val());
                 $("#modal_imgicon").attr('src', $('#imgUserIcon').attr('src'));
                
//                var checkboxList = [];
//                $("[id*=CheckBoxList1] input:checked").each(function () {
//                    checkboxList.push($(this).val());
//                });
//                if (checkboxList.length > 0) {
//                    alert("Selected Value(s): " + checkboxList);
//                } else {
//                    alert("No item has been selected.");
//                }

                 var imageArray = [];
                 
//                    $(".dz-image img").each(function(){
//                            imageArray.push($(this).attr('src'));
//                    });
                 $("#dzItemFeatured .dz-image img").each(function(){
                     imageArray.push($(this).attr('src'));
                 });
                
                 $("#dzItemPics .dz-image img").each(function(){
                     imageArray.push($(this).attr('src'));
                 });
               
//                for (var x = 0; x < checkboxList.length; x++) {
//                    var item = "<label>" + checkboxList[x] + "</label><br/>";
//                    $("#modal_checkboxlist").append(item);
//                }
                 //$("#modal_image").remove();
                 $('#modal_image img').remove();
                 $('#modal_image br').remove();
                 for (var y = 0; y < imageArray.length; y++) {
                     var itemx = "<img id=" + y + " src=" + imageArray[y] + " /><br/>";
                     $("#modal_image").append(itemx);
                 }
                                 <%--data-toggle="modal" data-target="#myModal"--%>
                 //$("#button1").attr("data-toggle", "modal");
                 //$("#button1").attr("data-target", "#myModal");

             });
         });
     </script>
    <script type="text/javascript">

        var itemId = '<%= Session["CurrentItemId"] %>';
        Dropzone.options.dzItemPics = {

        // Validate the file type. only accept images
            acceptedFiles: 'image/*',
            dictDefaultMessage: "Click or Drag Images here to upload",
            maxFiles: 100,
            url: "itempics.ashx?v=" + itemId,
            thumbnailWidth: null,
            thumbnailHeight: null,
            init: function () {

                this.on("maxfilesexceeded", function (data) {
                    var res = eval('(' + data.xhr.responseText + ')');
                });

                this.on('success', function (file, resp) {

                    var imgName = resp;
                    file.previewElement.classList.add("dz-success");
                    console.log("Successfully uploaded :" + imgName);
                    console.log(file);
                    console.log(resp);

                });
                // Validate the dimensions of the image....
//                this.on('thumbnail', function(file) {
//                    if (file.width < 800 || file.height < 800) {
//                        file.rejectDimensions();
//                    } else {
//                        file.acceptDimensions();
//                    }
//                });

                this.on("addedfile", function (file) {

                    // this.options.thumbnail.call(this, file, file_image);
                    // Create the remove button
                    var removeButton = Dropzone.createElement("<button style='position:absolute; margin-top: -75%; margin-left: 93%; z-index: 100; background:#ccc; border:0; color:#fff;'>X</button>");
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
                //this.addFile.call(this, mockFile);

                this.on("removedfile", function (file) {
                    //add in your code to delete the file from the database here 
                    $.ajax({
                        type: "POST",
                        url: 'add-item.aspx\\RemoveImage',
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
//            accept: function(file, done) {
//                file.acceptDimensions = done;
//                file.rejectDimensions = function() {
//                    done('The image must be at least 800 x 800px');
//                };
//            }
        };

    </script>
    <script type="text/javascript">
        var itemId = '<%= Session["CurrentItemId"] %>';
        
        // Dropzone for featured image
        Dropzone.options.dzItemFeatured = {
            // Validate the file type. only accept images
            acceptedFiles: 'image/*',
            dictDefaultMessage: "Click or Drag Image here to upload",
            maxFiles: 1,
            url: "featured.ashx?v=" + itemId,
            thumbnailWidth: 340,
            thumbnailHeight: 300,
            init: function () {

                this.on("maxfilesexceeded", function (data) {
                    var res = eval('(' + data.xhr.responseText + ')');
                });


                // Get response on Success
                this.on('success', function (file, resp) {

                    var imgName = resp;
                    file.previewElement.classList.add("dz-success");
                    console.log("Successfully uploaded :" + imgName);
                    console.log(file);
                    console.log(resp);
                });
                // Validate the dimensions of the image....
                this.on('thumbnail', function (file) {
                    if (file.width < 800 || file.height < 800) {
                        file.rejectDimensions();
                    }
                    else {
                        file.acceptDimensions();
                    }
                });

                this.on("addedfile", function (file) {

                    // Create the remove button

                    var removeButton = Dropzone.createElement("<button style='position:absolute; margin-top: -88%; margin-left: 93%; z-index: 100; background:#ccc; border:0; color:#fff;'>X</button>");
                    // Capture the Dropzone instance as closure.
                    var _this = this;
                    //$("#dzItemFeatured").attr("disabled", true);
                    //$(".dz-hidden-input").attr("disabled", true);
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
                        url: 'add-item.aspx\\RemoveFeatureImage',
                        data: "{'filename':'" + file.name + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function (data) {
                            $('.dz-input').show();
                        }
                    });
                });

            },
            accept: function (file, done) {
                file.acceptDimensions = done;
                file.rejectDimensions = function () {
                     done('The image must be at least 800 x 800px');
//                    $("#divAlerts").show();
//                    $('#divAlerts').html('The image must be at least 800 x 800px');
                };
            }
        };
    </script>
    
    <style type="text/css">
        .fancybox-inner {
            height: 100% !important;
        }
    </style>
     
           
    <script type="text/javascript">
        function HideLabel() {
            setTimeout(function () { $('#divAlerts').fadeOut(); }, 4000);
            setTimeout(function() { $('.alert').fadeOut(); }, 4000);
            setTimeout(function () { $('#<%=vs1.ClientID%>').fadeOut(); }, 4000);
        };
    </script>
   </head>
<body>
<form runat="server" ID="frm1">

<asp:scriptmanager runat="server" EnablePageMethods="True" EnablePartialRendering="True">
    </asp:scriptmanager>
    
<div class="wrapper">
<!--Header-->
    <div class="headerbgm">
           <nav class="navbar navbar-default">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <div style="margin-top:15px;">
               <!--#INCLUDE FILE="../includes/logo.txt" -->
            </div>  
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <div class="col-md-3">   
            <!--#INCLUDE FILE="../includes/messgTop.txt" --> 
            </div> 
            <ul class="nav navbar-nav" id="firstbb">
              <li><div class="gab1"></div></li>
              <li class="dropdown">
                <a href="events.aspx">Events</a>
              </li>
              
              <li class="dropdown">
                     <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Create</a>
                 <ul class="dropdown-menu">
                  <li><a href="add-item.aspx"><img src="" /><span class="sp"> Item</span></a></li>
                  <li><a href="create-lookbook.aspx"><img src="" /><span class="sp"> Lookbook</span></a></li>
                </ul>
              </li>
            </ul>
            
              <!--#INCLUDE FILE="../includes/settings.txt" --> 
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>

    </div><!--header bg-->
<!--Headerend-->


<!--text-->

<div class="wrapperadditem" >
       
   <div class="discovewrap">
     <div class="whitewrap blockadd">
      <div id="dialog" style="display: none;"></div>
      <div class="row">
       <div class="col-lg-12">
           <label for="message" >Fields marked with <span class="text-danger">*</span> are required</label>
       </div>
       <div id="divAlerts" runat="server" class="alert" style="margin-top:35px;" Visible="False">
         <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
         <asp:Label runat="server" ID="lblStatus" for="PageMessage"  Text="" Visible="True"></asp:Label>
       </div>
          <div>
         <label id="lbl_SuccessMessage" style="color:green;visibility:hidden"></label>
          </div>
          <asp:validationsummary ID="vs1" runat="server" ValidationGroup="gpMain" HeaderText="The following fields are missing or invalid !"  style="    color: #fff;
                                                                                                                                                                                                                                                                                                                                                                                                                        padding: 20px;
                                                                                                                                                                                                                                                                                                                                                                                                                        background: darkred;
                                                                                                                                                                                                                                                                                                                                                                                                                        border-radius: 7px;
                                                                                                                                                                                                                                                                                                                                                                                                                        margin-top: 30;">
          </asp:validationsummary>
   </div> 
         <div class="textforget">Item Details</div>
         <div class="textadd" id="title_add">TITLE<span class="text-danger">*</span></div>
         <div class="textadd">
             <input type="text" runat="server" ID="txtItemTitle" class="addin" 
                 placeholder=""  tabindex="1" CssClass="validate[required]"/>
             
            <asp:RequiredFieldValidator ID="RfvTitle" runat="server" EnableClientScript="True" ErrorMessage="Title" ValidationGroup="gpMain" ControlToValidate="txtItemTitle" Display="none"></asp:RequiredFieldValidator>
         </div>
     
  <!--editor-->
  <div class="editorblock">
      <%-- <textarea name="editor1" class="ckeditor" runat="server" ID="txtDescription" 
          tabindex="2" Height="200px" Width="100%">
       
    </textarea>
   <script type="text/javascript">
       CKEDITOR.replace('editor1');
       CKEDITOR.add();            
   </script>--%>
   <FTB:FreeTextbox runat="server" ID="txtDescription" ButtonSet="OfficeMac"  OnTextChanged="txtDescription_TextChanged"
          Height="200px" 
          ToolbarLayout="JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent; InsertRule|Cut,Copy,Paste;Print" 
          ToolbarStyleConfiguration="Office2000" Width="100%"></FTB:FreeTextbox>
      <asp:RequiredFieldValidator ID="RfvDescription" runat="server" 
          EnableClientScript="True"  ErrorMessage="Item Description" 
          ValidationGroup="gpMain" ControlToValidate="txtDescription" Display="none" 
          Enabled="False"></asp:RequiredFieldValidator>
  </div> 
  
  <div class="blockadd1">
     <div class="textforget">Add Price</div>     
  </div>
  
  <div class="blockaddpr">
     <div class="addpriceb1" id="retail_add">Retail<span class="text-danger">*</span></div> 
     <div class="addpriceb">
     <input type="text" runat="server" name="search" ID="txtRetail" placeholder="" 
             tabindex="3" value="" class="sein1" />
     <asp:RequiredFieldValidator ID="RfvRetail" runat="server" EnableClientScript="True"  ErrorMessage="Retail Price" ValidationGroup="gpMain" ControlToValidate="txtRetail" Display="none"></asp:RequiredFieldValidator>
     </div>
     <div class="addpriceb2" id="wholesale_add">Wholesale Price<span class="text-danger">*</span></div> 
     <div class="addpriceb">
         <input type="text" runat="server" name="search" ID="txtWholesale" 
             placeholder="" tabindex="4" value="" class="sein1" />
         <asp:RequiredFieldValidator ID="RfvWholesale" runat="server" EnableClientScript="True"  ErrorMessage="Wholesale Price" ValidationGroup="gpMain" ControlToValidate="txtWholesale" Display="none"></asp:RequiredFieldValidator>
     </div>    
  </div>
  
  
  <div class="blockadd1">
     <div class="textforget" id="thumbnail_add">Add Images<span class="text-danger">*</span> <div class="uptext">Upload or drag image</div></div>     
  </div>
    
  <div class="blockadd1">
       <div  class="dropzone" id="dzItemPics" tabindex="4">
           <div class="fallback">
              <input name="file" type="file" multiple="true" runat="server" id="ItemImages" />
              <input type="submit" value="Upload" />
            </div>  
        </div>
  </div>
  <%--<div class="blockadd2n">  
    <button type="submit" onclick="addmoreim()" name="addmore" id="addmore" class="hvr-sweep-to-righta1"><span style="position:relative; top:2px; font-size:22px; font-weight:bold;">+</span> Add More Images</button>
  </div>--%><!--block-->
  
  
  <div class="blockadd1"> 
      <span style="color:#FFF">.... </span>
  </div><!--block--> 
  </div><!--whitewrap-->
   </div><!--discovewrap--> 
   
  <div class="discovewraps" id="addspace">
              
              <!--publish-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading">Publish</div>
                              <div class="pubbutt">
                               <div class="del"><asp:LinkButton runat="server" ID="lbtnDelete" Text="Delete" 
                                       onclick="lbtnDelete_Click" 
                                       onclientclick="return confirm('Are you sure, you want to delete ?')" 
                                       TabIndex="22" ></asp:LinkButton></div>
                              <a id="hidden_link" runat="server" style="visible:false"  width="60%" height="60%"></a>
                                <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                                
                               <button type="button"  name="login" id="btnPreview"  data-toggle="modal" data-target="#myModal"
                                      style="width:100px;"  class="hvr-sweep-to-rightup2" 
                                      tabindex="20"   >Preview</button>
<%--                               <button type="button" runat="server" name="login" ID="btnPublish" 
                                      style="width:100px;"  ValidationGroup="gpMain" 
                                      class="hvr-sweep-to-rightup2" Text="" 
                                      OnServerClick="btnPublish_OnServerClick"  tabindex="21" >Publish</button>--%>
                                      
                                      <button type="button" runat="server" name="login" ID="btnPublish" 
                                      style="width:100px;"  ValidationGroup="gpMain" 
                                      class="hvr-sweep-to-rightup2" Text="" 
                                      onclick="submitValidation()"  tabindex="21" >Publish</button>
                              </div> 
                         </div><!--search-->
                  </div><!--colmd12-->
                  <div class="dissp"></div>
                  
            <!--featured-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading" id="feature_add">Featured Image <span class="text-danger">*</span></div>
                             <div class="imgb">
                                 <div  class="dropzone" id="dzItemFeatured" tabindex="6" >
                                   <div class="fallback">
                                      <%--<input name="file" type="file" multiple="false" runat="server" ID="fImage" />--%>
                                      <asp:FileUpload ID="fImage" runat="server"/>
                                      <input type="submit" value="Upload" />
                                    </div>  
                                </div> 
                             </div>
                             <%--<asp:RequiredFieldValidator ID="rfvFeatureImg" runat="server" ErrorMessage="Feature Image is required" ValidationGroup="gpMain" Display="None" ControlToValidate="fImage">*</asp:RequiredFieldValidator>--%>
                             <%-- <a href=""><div class="fewer">Remove featured image</div></a>--%>
                         </div><!--search-->
                  </div><!--colmd12-->
                  <div class="dissp"></div> 
                  
                  
            <!--style number-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading" id="styleNumber_add">Style Number <span class="text-danger">*</span></div>
                             <div class="searchsm" style="margin-top:20px;">
                                 <div class="searctext" style="width:100%;">
                                     <input type="text" runat="server" name="search" ID="txtStyleNumber" 
                                         placeholder="" value="" class="sein1" tabindex="7"  />
                                     <asp:RequiredFieldValidator ID="RfvStyleNumber" runat="server" EnableClientScript="True"  ErrorMessage="Style Number" ValidationGroup="gpMain" ControlToValidate="txtStyleNumber" Display="None"></asp:RequiredFieldValidator>
                                 </div>
                                 <div class="searcadd">
                                   <button type="submit" name="login" id="login" style="display:none;"  class="hvr-sweep-to-right3">Add</button></div>
                             </div>
                         </div><!--search-->
                  </div><!--colmd12-->
                  <div class="dissp"></div>  
                  
            <!--style name-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading" id="stylename_add">Style Name <span class="text-danger">*</span></div>
                              
                                     <div class="searchsm" style="margin-top:20px;">
                                         <div class="searctext" style="width:100%;">
                                             <input type="text" runat="server" name="search" ID="txtStyleName" 
                                                 placeholder="" value="" class="sein1" tabindex="8" />
                                             <asp:RequiredFieldValidator ID="RfvStyleName" runat="server" EnableClientScript="True"  ErrorMessage="Style Name" ValidationGroup="gpMain" ControlToValidate="txtStyleName" Display="None"></asp:RequiredFieldValidator>
                                         </div>
                                         <div class="searcadd">
                                           <button type="submit" runat="server" name="login" ID="btnStyleName" style="display:none;" class="hvr-sweep-to-right3">Add</button></div>
                                     </div>
                             
                         </div><!--search-->
                  </div><!--colmd12-->
                  <div class="dissp"></div>                   
                  
             <!--colors-->
                  <div class="col-md-12 discrigblock">
                      <asp:updatepanel runat="server" ID="up_Color"  UpdateMode="Conditional">
                                 <ContentTemplate>
                      <div class="searchb">
                             <div class="serheading" style="margin-bottom:10px;" id="color_add">Color <span class="text-danger">*</span></div> 
                               <div id="trigger" style="width:100%;">
                                   <input type="text" runat="server"  name="search" id="colbtn" placeholder="Select Color" 
                                        value="" class="sein1" 
                                       style="cursor:pointer; background: #F4F4F4;" tabindex="9" >
                                        <%--<i class='ace-icon fa fa-pencil' style='position: relative;right: 26px; top: 13px;'></i>--%>
                                         <img src="../images/color.png"  alt="" style='position: relative; right: 16px; top: -26px; float: right;' />
                                   </input> 
                                
                               </div>
                               
                         </div><!--search-->
                       <div class="popupbox" id="popuprel" style="top: -90; right: 325;">
                        <div class="block" id="block1"> 
                            <asp:Repeater runat="server" ID="rptColorlist" DataSourceID="sdsColorlist" OnItemCommand="rptColorlist_OnItemCommand">
                           <ItemTemplate>
                                 <div class="colum1">
                                     <div>
                                      <asp:LinkButton runat="server" ID="lbtnColor" CommandName="1" CommandArgument='<%# Eval("Colorid") %>'>
                                              <div class='color<%# Eval("status") %>'  style='background:#<%# Eval("Colorid") %>;'></div>
                                        </asp:LinkButton>
                                      </div> 
                                    
  
                              
                          </div><!--column--> 
                           </ItemTemplate>
                           </asp:Repeater>
                          <asp:SqlDataSource runat="server" ID="sdsColorlist" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                       SelectCommand="select ID,Colorid,status from Tbl_Colorlist"></asp:SqlDataSource>
                          </div> <!--block-->
                          <img src="../images/img.png" style="margin-top: -155px; float: right; margin-right: -14px;"/> 
                        </div> <!--popurel-->  
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger  ControlID="rptColorlist" EventName="ItemCommand" runat="server"/>
                        </Triggers>
                     </asp:updatepanel>  
                         
                  </div><!--colmd12-->
                  <div class="dissp"></div>                     
                  
              
                  
                  <!--categories-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading" style="margin-bottom:10px;" id="categories_add">Categories <span class="text-danger">*</span></div>   
                             <asp:updatepanel runat="server" ID="upcats"  UpdateMode="Conditional">
                                 <ContentTemplate>                                 
                             <div id="seedefaultCats" tabindex="10">
                                 <div class="dblock">
                                     <asp:CheckBoxList runat="server" ID="chkCategories" OnSelectedIndexChanged="chkCategories_SelectedIndexChanged"
                                         DataSourceID="sdsDefaultCats" DataTextField="Title"
                                         DataValueField="CategoryID" CellPadding="4" CellSpacing="4" 
                                         RepeatColumns="2" Width="100%" AutoPostBack="True" >
                                     </asp:CheckBoxList>
                                     <asp:SqlDataSource ID="sdsDefaultCats" runat="server" 
                                         ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                         ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                         SelectCommand="SELECT TOP (10) CategoryID, Title FROM dbo.Tbl_Categories ORDER BY Title">
                                     </asp:SqlDataSource>
                                      <asp:SqlDataSource ID="sdsMoreCats" runat="server" 
                                         ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                         ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                         SelectCommand="SELECT  CategoryID, Title FROM dbo.Tbl_Categories ORDER BY Title">
                                     </asp:SqlDataSource>
                                 </div>
                            </div>
                             <div class="bmore2"><asp:LinkButton runat="server" ID="btn_ViewMore" 
                                     CssClass="bmore2" Text="View More" onclick="btn_ViewMore_Click" 
                                     TabIndex="11"></asp:LinkButton> 
                                 <asp:LinkButton runat="server" CssClass="bmore2" ID="btn_ViewLess" 
                                     Text="See fewer" Visible="False" onclick="btn_ViewLess_Click" 
                                     TabIndex="11"></asp:LinkButton></div>
                                 </ContentTemplate>
                                 <Triggers>
                                     <asp:AsyncPostBackTrigger ControlID="chkcategories" EventName="SelectedIndexChanged" />
                                 </Triggers>
                             </asp:updatepanel>
                            
                         </div><!--search-->
                  </div><!--colmd12-->
                  <div class="dissp"></div>
                  
                  <!--Season-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading" style="margin-bottom:10px;" id="seasons_add">Seasons <span class="text-danger">*</span></div> 
                           <asp:updatepanel runat="server" ID="up_Seasons" >
                                 <ContentTemplate>
                                    <div id="seeDefaultSessions" tabindex="12">
                                 <div class="dblock">
                                     <asp:CheckBoxList runat="server" ID="chkDefaultSeasons" OnSelectedIndexChanged="chkDefaultSeasons_SelectedIndexChanged"
                                         DataSourceID="sdsMoreSeasons" DataTextField="Season" 
                                         DataValueField="SeasonID" AutoPostBack="True" >
                                     </asp:CheckBoxList>
                                     <asp:SqlDataSource ID="sdsDefaultSeasons" runat="server" 
                                         ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                         ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                         SelectCommand="SELECT TOP (6) SeasonID, Season FROM Tbl_Seasons ORDER BY Season">
                                     </asp:SqlDataSource>
                                      <asp:SqlDataSource ID="sdsMoreSeasons" runat="server" 
                                         ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                         ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                         SelectCommand="SELECT TOP (9) SeasonID, Season FROM Tbl_Seasons ORDER BY Season">
                                     </asp:SqlDataSource>
                                 </div>
                            
                             </div>
                                    <div class="bmore" runat="server" ID="dvSeasonToggle">
                                        <asp:LinkButton runat="server" ID="btn_MoreSeasons" 
                                     CssClass="bmore" Text="View More" onclick="btn_MoreSeasons_Click" TabIndex="13" ></asp:LinkButton> 
                                 <asp:LinkButton runat="server" CssClass="bmore" ID="btn_LessSeasons" 
                                     Text="See fewer" Visible="False" onclick="btn_LessSeasons_Click" TabIndex="13" ></asp:LinkButton></div>
                              </ContentTemplate>
                                     <Triggers>
                                     <asp:AsyncPostBackTrigger ControlID="chkDefaultSeasons" EventName="SelectedIndexChanged" />
                                 </Triggers>
                             </asp:updatepanel>
                           
                        
                         </div><!--search-->
                         
                  </div><!--colmd12-->
                  <div class="dissp"></div> 
                  
                  
            
            <!--Holidays-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading" style="margin-bottom:10px;" id="holiday_add">Holiday <span class="text-danger">*</span></div> 
                
                          <asp:updatepanel runat="server" ID="up_Holidays" >
                                 <ContentTemplate>
                             <div id="seeDefaultHoliday" tabindex="14">
                                 <div class="dblock">
                                     <asp:CheckBoxList  runat="server" ID="chkDefaultHoliday" OnSelectedIndexChanged="chkDefaultHoliday_SelectedIndexChanged"
                                         DataSourceID="sdsMoreHoliday" DataTextField="Title" 
                                         DataValueField="HolidayID" AutoPostBack="True"  >
                                     </asp:CheckBoxList>
                                    
                                      <asp:SqlDataSource ID="sdsMoreHoliday" runat="server" 
                                         ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                         ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                         SelectCommand="SELECT TOP (9) HolidayID, Title FROM Tbl_Holidays ORDER BY Title">
                                     </asp:SqlDataSource>
                                 </div>
                            
                             </div>
                             <div class="bmore3">
                                        <asp:LinkButton runat="server" ID="btn_MoreHolidays" 
                                     CssClass="bmore3" Text="View More" onclick="btn_MoreHolidays_Click" 
                                            TabIndex="15"  ></asp:LinkButton> 
                                 <asp:LinkButton runat="server" CssClass="bmore3" ID="btn_LessHolidays" 
                                     Text="See fewer" Visible="False" onclick="btn_LessHolidays_Click" TabIndex="16"  ></asp:LinkButton></div>
                           </ContentTemplate>
                                <Triggers>
                                     <asp:AsyncPostBackTrigger ControlID="chkDefaultHoliday" EventName="SelectedIndexChanged" />
                                 </Triggers>
                             </asp:updatepanel>
                         
                         </div><!--search-->
                         
                  </div><!--colmd12-->
                  <div class="dissp"></div>       
                  
                  
          <!--tags-->
                  <div class="col-md-12 discrigblock">
                      <asp:updatepanel runat="server" ID="up_Tags">
                          <ContentTemplate>
                              <div class="searchb">
                             <div class="serheading" style="margin-bottom:20px;">Related Tags</div> 
                            <asp:Panel runat="server" DefaultButton="btnAddTag">
                             <div class="searchsm">
                                 <div class="searctext">
                                     <input type="text" runat="server" name="search" ID="txtTag" placeholder="" value="" class="sein1" tabindex="17"  /></div>
                                 <div class="searcadd">
                                   <asp:Button  runat="server" name="login" ID="btnAddTag" 
                                         OnClick="btnAddTag_OnServerClick" class="hvr-sweep-to-right3" Text="Add" 
                                         tabindex="18" ValidationGroup="gpTags"></asp:Button></div>
                                 <asp:RequiredFieldValidator ID="RfvTags" runat="server" 
                                     ErrorMessage="This field is required" ControlToValidate="txtTag" 
                                     ValidationGroup="gpTags"></asp:RequiredFieldValidator>
                             </div>
                             </asp:Panel>
                             <div class="smalltext">Separate tags with commas</div>
                             <asp:Repeater runat="server" ID="rptTags" DataSourceID="sdsTags" 
                                      onitemcommand="rptTags_ItemCommand">
                                 <ItemTemplate>
                                     <div class="tagblock"><asp:LinkButton runat="server" ID="lbtnRemoveTag" CommandName="1" CommandArgument='<%# Eval("TagID","{0}")%>'><i id="I1" runat="server" class="fa fa-times-circle-o" style="padding-right:10px;" ></i><%# Eval("Title") %></asp:LinkButton> </div>
                                 </ItemTemplate>
                             </asp:Repeater>
                                  <asp:SqlDataSource ID="sdsTags" runat="server" 
                                      ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                      ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                      
                                      SelectCommand="SELECT Top 5 [TagID], [Title] FROM [Tbl_ItemTags]  Where ItemID=?  ORDER BY [TagID]">
                                      <SelectParameters>
                                          <asp:CookieParameter CookieName="CurrentItemId" Name="ItemID" Type="Int32" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                                   <asp:SqlDataSource ID="sdsMoreTags" runat="server" 
                                      ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                      ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                      
                                      SelectCommand="SELECT Top 10 [TagID], [Title] FROM [Tbl_ItemTags] Where ItemID=?  ORDER BY [TagID]">
                                      <SelectParameters>
                                          <asp:CookieParameter CookieName="CurrentItemId" Name="ItemID" Type="Int32" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                         </div>
                          <div class="fewer" runat="server" ID="dvTagToggles">
                              <asp:LinkButton runat="server" ID="btn_MoreTags" 
                                     CssClass="fewer" Text="View More" onclick="btn_MoreTags_Click" 
                                  TabIndex="19" ></asp:LinkButton> 
                                 <asp:LinkButton runat="server" CssClass="fewer" ID="btn_LessTags" 
                                     Text="See fewer" Visible="False" onclick="btn_LessTags_Click" 
                                  TabIndex="19" ></asp:LinkButton></div>
                          </ContentTemplate>
                      </asp:updatepanel>
                         <!--search-->
                         
                  </div><!--colmd12-->
                  <div class="dissp"></div>                                 

     </div><!--discoverwraps-->
     
</div><!--col-md-12-->

<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog" style="margin-top: 110px; width:1150px;">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header" style="display:none;">
        
        </div>
      <div class="modal-body">
          <button type="button" class="close" data-dismiss="modal" style="    font-size: 30px;
    line-height: 0;
    background: #000 !important;
    border-radius: 50%;
    width: 30px;
    height: 30px;
    color: #fff;
    margin-top: -35px;
    margin-right: -35px;
    opacity: 0.7;
    border: 2px solid #fff;">&times;</button>
          <div id="inline1" style="max-width:1150px; width:100%;">

      <div class="lightboxheaderblock">
        <div class="lightboxblockmain">
          <div class="lightboxheaderimg"><img id="modal_imgicon" class="img-responsive img-circle" src="../images/follo.png" /></div><!--lightboxheaderimg-->
          <div class="lightboxheadertext">Itme Name Goes Here</div><!--lightboxtext-->
          <div class="lightboxheadertext1">
                  <label class="lightb"><i class="fa fa-eye" aria-hidden="true"></i>&nbsp; 0 Views</label>
                  <span><i class="fa fa-heart" aria-hidden="true"></i> &nbsp; Message</span>
                  <label class="lightb1"><i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp; Wishlist</label>
                 
          </div><!--lightboxtext1-->
        </div><!--lightboxblockmain--> 
      </div>  
    
    
    <div class="lightboxmaintext" >
         <div id="modal_image" class="col-md-7 col-xs-12 prolightimg" >
            <%-- <img src="../images/proimg1.png" width="100%" /><br />
            <img src="../images/proimg1.png" width="100%" /><br />
            <img src="../images/proimg1.png" width="100%" /><br />--%>
         </div><!--col-md-7-->
         
         <div class="col-md-5 col-xs-12" >
         
         
                  <div class="discrigblock">
                    <div class="searchb">
                     <div class="serheading1">Like this Item</div> 
                     
                       <div class="biglike">
                           <a href="#"><i class="fa fa-heart" aria-hidden="true" id="round"></i>  Likes (0)</a>
                       </div>
                       
                    </div> 
                  </div> 
                  
                  <div class="dissp1"></div>
                  
                  
             <!--basic ino-->     
                <div class="discrigblock">
                  <div class="searchb"><div class="serheading1">Basic Info</div> </div>
                  <div id="dvdescription" class="lightboxpicdata" style="clear:left;"> 
                      Little Mistress Heavily Embellished<br />
                      Gold and Black Bandeau Maxi Dress<br /><br />
                      code: AW15-AAD053-24<br /><br />
                      Item: 39970281<br /><br />
                      A maxi bandeau dress with heavily<br />
                      embellished art deco black sequins. <br />
                      Model wears a size 10.<br />
                      REF: L673D1A<br />
                      Product Care<br />
                      Material: Outer: 100% polyester<br />
                      Hand wash only /do not tumble dry/<br />
                      iron on reverse side/ do not dry clean<br />
               </div></div>
           <div class="dissp1"></div>  
           
           
           
           <!--stylenumber-->     
                <div class="discrigblock">
                 
                 <div class="rpri">
                     <div class="searchb"><div class="serheading1">Retail Price</div> 
                        <div id="dvRetail" class="lightbtext">$350.00</div>
                     </div>
                 </div>    
                     
                 <div class="rpri1">
                     <div class="searchb"><div class="serheading1">Wholesale Price</div> 
                        <div id="dvWholesale" class="lightbtext">$200.00</div>
                     </div>
                 </div>   
                     
                </div>
           <div class="dissp1"></div>      
           
           
           <!--stylenumber-->     
                <div class="discrigblock">
                     <div class="searchb"><div class="serheading1">Style Number</div> 
                        <div id="dvstyleNo" class="lightbtext">#40127391</div>
                     </div>
                     

                </div>
           <div class="dissp1"></div>    
           
           
            <!--stylename-->     
                <div class="discrigblock">
                     <div class="searchb"><div class="serheading1">Style Name</div> 
                      <div id="dvstyleName" class="lightbtext">Silk/Green/Olive</div>
                     </div>
                </div>
           <div class="dissp1"></div>    
           
           
            <!--tags-->     
                <div class="discrigblock">
                         <div class="searchb">
                             <div class="serheading1">Related Tags</div> 
                             
                             <div id="rlTags" class="serheading1">
                             <asp:Repeater runat="server" ID="rptModTags" DataSourceID="sdsModTags" >
                                 <ItemTemplate>
                                     <div class="tagblock"><%# Eval("Title") %> </div>
                                 </ItemTemplate>
                             </asp:Repeater>
                                  <asp:SqlDataSource ID="sdsModTags" runat="server" 
                                      ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                      ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                      
                                      SelectCommand="SELECT  [TagID], [Title] FROM [Tbl_ItemTags]  Where ItemID=?  ORDER BY [TagID]">
                                      <SelectParameters>
                                          <asp:CookieParameter CookieName="CurrentItemId" Name="ItemID" Type="Int32" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                            </div>  
                             
                         </div><!--search-->
                         
                         
                       <div class="serheading1">
                         <div class="fewer" onclick="showtags11()">See fewer tags</div>
                         <div class="fewerf" onclick="showtagsf11()" style="display:none;">See full tags</div>
                       </div>  
                </div>
               <div class="dissp1"></div>  
               
               
               <!--comments-->
                <div class="discrigblock">
                    <div class="searchb">
                     <div class="serheading1">Comments - (0)</div> 
                     
                 <div class="col-md-12" style="margin-top:20px;">
                    <div class="col-md-2"><img src="../images/follo.png" /></div>
                    <div class="col-md-10">
                        <textarea placeholder="Leave A Comments" class="textanew" name="texta" id="texta"></textarea>
                    </div> 
                    <div class="lightboxblockmain2">
                        <div class="lightboxeditbutton"><a href="">Post a Comment</a></div><!--lightboxeditbutton-->
                    </div><!--lightboxblockmain-->    
                </div><!--col-md-12-->
                
                <div class="col-md-12" style="margin:30px 0 30px 0; float:left; width:100%; border-bottom:#dadbdd solid 3px;"></div>   
          
              
                       
                    </div> 
                  </div> 
                  
                  <div class="dissp1"></div>  

         </div><!--col-md-5-->
    </div><!--lightboxmaintext--> 
</div>
      </div>
      <div class="modal-footer">
       <%-- <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>--%>
      </div>
    </div>

  </div>
</div>
           

<!--footer-->
  <div class="footerbg">
     <div class="starter-template">
        <div class="col-md-12">©2016 Press Preview</div>
     </div>    
  </div><!--footer-->
<!--footer-->
<!--#INCLUDE FILE="../includes/backtotop.txt" -->
<script src="../js/backtotop.js" type="text/javascript"></script>
        <script type="text/javascript" src="../js/custom.js"></script>
    <script src="../js/color1.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://cdn.ucb.org.br/Scripts/formValidator/js/languages/jquery.validationEngine-en.js"
    charset="utf-8"></script>
<script type="text/javascript" src="http://cdn.ucb.org.br/Scripts/formValidator/js/jquery.validationEngine.js"
    charset="utf-8"></script>
    <script type="text/javascript">
        $("#colbtn").live("click",(function (e) {
            $(".popupbox").toggle();
        }));
    </script>
  
   <script type="text/javascript">
       $(function () {
           $("#frm1").validationEngine('attach', { promptPosition: "topRight" });
       });
       $(document).ready(function () {
           var userId = '<%= Request.Cookies["FRUserId"].Value %>';
           $("#lbViewMessageCount").click(function () {

               $.ajax({
                   type: "POST",
                   url: $(location).attr('pathname') + "\\UpdateMessageStatus",
                   contentType: "application/json; charset=utf-8",
                   data: "{'userID':'" + userId + "'}",
                   dataType: "json",
                   async: true,
                   error: function (jqXhr, textStatus, errorThrown) {
//                       alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
                   },
                   success: function (msg) {
                       //                    if (msg.d == true) {

                       $('#<%=lblTotalMessages.ClientID%>').hide("slow");
                       $('#<%=lblTotalMessages.ClientID%>').val = "";
                       return false;
                   }
               });

           });


           $("#lbViewAlerts").click(function () {

               $.ajax({
                   type: "POST",
                   url: $(location).attr('pathname') + "\\UpdateNotifications",
                   contentType: "application/json; charset=utf-8",
                   data: "{'userID':'" + userId + "'}",
                   dataType: "json",
                   async: true,
                   error: function (jqXhr, textStatus, errorThrown) {
//                       alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
                   },
                   success: function (msg) {
                       //                    if (msg.d == true) {

                       $('#<%=lblTotalNotifications.ClientID%>').hide("slow");
                       $('#<%=lblTotalNotifications.ClientID%>').val = "";
                       return false;
                   }
               });

           });

       });
   </script></div>  
    
</form>
</body>
</html>
