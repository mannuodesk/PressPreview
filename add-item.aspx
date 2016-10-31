<%@ Page Language="C#" ValidateRequest="false" AutoEventWireup="true"  CodeFile="add-item.aspx.cs" Inherits="pr_brand_add_item" %>

<!DOCTYPE "html">
<html runat="server">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Press Preview - Add Item</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../css/checkbox.css"/>
<link href="../css/bootstrap-colorpicker.min.css" rel="stylesheet" />
<link href="../css/bootstrap-colorpicker-plus.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
<script  type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<!--lightbox-->
	<script type="text/javascript" src="../source/jquery.fancybox.js?v=2.1.5"></script>
	<link rel="stylesheet" type="text/css" href="../source/jquery.fancybox.css?v=2.1.5" media="screen" />
 <link href="../DropzoneJs_scripts/basic.css" rel="stylesheet" type="text/css" />
        <link href="../DropzoneJs_scripts/dropzone.css" rel="stylesheet" type="text/css" />
        <script src="../DropzoneJs_scripts/dropzone.js" type="text/javascript"></script>
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="../js/sample.js"></script>
 <link href="../css/jquery-ui.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
    jQuery(document).ready(function () {
        jQuery('.fancybox').fancybox();
        jQuery('.fancybox-buttons').fancybox({
            openEffect: 'none',
            closeEffect: 'none',

            prevEffect: 'none',
            nextEffect: 'none',

            closeBtn: false,

            helpers: {
                title: {
                    type: 'inside'
                },
                buttons: {}
            },

            afterLoad: function () {
                this.title = 'Image ' + (this.index + 1) + ' of ' + this.group.length + (this.title ? ' - ' + this.title : '');
            }
        });

    });
</script>
   <script language="javascript" type="text/javascript">       $(document).ready(function () {



           $("#hidden_link").fancybox({

               'title': 'Test Document',

               'titleShow': true,

               'titlePosition': 'over',

               'titleFormat': 'formatTitle',

               'type': 'iframe',

               'width': '98%',

               'height': '98%',

               'hideOnOverlayClick': false,

               'hideOnContentClick': false,

               'overlayOpacity': 0.7,

               'enableEscapeButton': false

           });

       });</script>

    <script type="text/javascript">
        
        //File Upload response from the server
        var itemId = '<%= Session["CurrentItemId"] %>';
        Dropzone.options.dzItemPics = {
            
        // Validate the file type. only accept images
            acceptedFiles: 'image/*',
            dictDefaultMessage: "Click or Drag Images here to upload",
            maxFiles: 100,
            url: "itempics.ashx?v=" + itemId,
            thumbnailWidth: 310,
            thumbnailHeight: 232,
            init: function() {

                this.on("maxfilesexceeded", function(data) {
                    var res = eval('(' + data.xhr.responseText + ')');
                });

                this.on('success', function(file, resp) {

                    var imgName = resp;
                    file.previewElement.classList.add("dz-success");
                    console.log("Successfully uploaded :" + imgName);
                    console.log(file);
                    console.log(resp);
                });
                // Validate the dimensions of the image....
                this.on('thumbnail', function(file) {
                    if (file.width < 800 || file.height < 600) {
                        file.rejectDimensions();
                    } else {
                        file.acceptDimensions();
                    }
                });

                this.on("addedfile", function(file) {

                    // Create the remove button
                    var removeButton = Dropzone.createElement("<button style='position:absolute; margin-top: -75%; margin-left: 93%; z-index: 100; background:#ccc; border:0; color:#fff;'>X</button>");
                    // Capture the Dropzone instance as closure.
                    var _this = this;
                    // Listen to the click event
                    removeButton.addEventListener("click", function(e) {
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

                this.on("removedfile", function(file) {
                    //add in your code to delete the file from the database here 
                    $.ajax({
                        type: "POST",
                        url: 'addnew.aspx\\RemoveImage',
                        data: "{'filename':'" + file.name + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function(data) {

                        }
                    });
                });

            },
            accept: function(file, done) {
                file.acceptDimensions = done;
                file.rejectDimensions = function() {
                    done('The image must be at least 800 x 600px');
                };
            }
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
            url: "featured.ashx?v="+itemId,
            thumbnailWidth: 310,
            thumbnailHeight: 232,
            init: function () {

                this.on("maxfilesexceeded", function (data) {
                    var res = eval('(' + data.xhr.responseText + ')');
                });

                //                submitButton.addEventListener("click", function () {
                //                    this.processQueue();
                //                    // autoProcessQueue= true; // Tell Dropzone to process all queued files.
                //                });
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
                    if (file.width < 800 || file.height < 600) {
                        file.rejectDimensions();
                    }
                    else {
                        file.acceptDimensions();
                    }
                });

                this.on("addedfile", function (file) {

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

                this.on("removedfile", function (file) {
                    //add in your code to delete the file from the database here 
                    $.ajax({
                        type: "POST",
                        url: 'addnew.aspx\\RemoveFeatureImage',
                        data: "{'filename':'" + file.name + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function (data) {

                        }
                    });
                });

            },
            accept: function (file, done) {
                file.acceptDimensions = done;
                file.rejectDimensions = function () {
                    done('The image must be at least 800 x 600px');
                };
            }
        };
    </script>
    <script type = "text/javascript">
        function SetTarget() {
            document.forms[0].target = "_blank";
        }
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
              <div class="logob"><a href="../Default.aspx">Press Preview</a></div>
              <div class="logos"><a href="../Default.aspx">Logo Branding</a></div>
            </div>  
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <div class="col-md-4">   
            <!--#INCLUDE FILE="../includes/messgTop.txt" --> 
            </div> 
            <ul class="nav navbar-nav" id="firstbb">
              <li><div class="gab1"></div></li>
              <li class="dropdown">
                <a href="event.aspx">Event</a>
              </li>
              
              <li class="dropdown">
                     <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Create</a>
                 <ul class="dropdown-menu">
                  <li><a href="add-item.aspx"><img src="" /><span class="sp"> Item</span></a></li>
                  <li><a href="#"><img src="" /><span class="sp"> Lookbook</span></a></li>
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

          <asp:validationsummary runat="server" ValidationGroup="gpMain" HeaderText="The following fields are missing or invalid !"  style="    color: #fff;
    padding: 20px;
    background: darkred;
    border-radius: 7px;
    margin-top: 30;">
          </asp:validationsummary>
   </div> 
         <div class="textforget">Item Details</div>
         <div class="textadd">TITLE<span class="text-danger">*</span></div>
         <div class="textadd">
             <input type="text" runat="server" ID="txtItemTitle" class="addin" placeholder="" />
            <asp:RequiredFieldValidator ID="RfvTitle" runat="server" EnableClientScript="True" ErrorMessage="Title" ValidationGroup="gpMain" ControlToValidate="txtItemTitle" Display="none"></asp:RequiredFieldValidator>
         </div>
     
  <!--editor-->
  <div class="editorblock">
      <textarea name="editor1" class="ckeditor" runat="server" ID="txtDescription" Height="200px" Width="100%">
       Description. Write some details about you Kickz and add some #Hashtags to make it easier for other to find it
    </textarea>
   <script type="text/javascript">
       CKEDITOR.replace('editor1');
       CKEDITOR.add            
   </script>
     <%-- <obout:Editor runat="server" ID="txtDescription" Height="200px" Width="100%" >
                 <EditPanel AutoFocus="true" ActiveMode="design" IndentInDesignMode="20" />
                 <BottomToolBar ShowDesignButton="true" ShowHtmlTextButton="true" ShowPreviewButton="true" >
                 </BottomToolBar>
               </obout:Editor>  --%>   
      <asp:RequiredFieldValidator ID="RfvDescription" runat="server" EnableClientScript="True"  ErrorMessage="Item Description" ValidationGroup="gpMain" ControlToValidate="txtDescription" Display="none"></asp:RequiredFieldValidator>
  </div> 
  
  <div class="blockadd1">
     <div class="textforget">Add Price</div>     
  </div>
  
  <div class="blockaddpr">
     <div class="addpriceb1">Retail<span class="text-danger">*</span></div> 
     <div class="addpriceb">
     <input type="text" runat="server" name="search" ID="txtRetail" placeholder="" value="" class="sein1" />
     <asp:RequiredFieldValidator ID="RfvRetail" runat="server" EnableClientScript="True"  ErrorMessage="Retail Price" ValidationGroup="gpMain" ControlToValidate="txtRetail" Display="none"></asp:RequiredFieldValidator>
     </div>
     <div class="addpriceb2">Wholesale Price<span class="text-danger">*</span></div> 
     <div class="addpriceb">
         <input type="text" runat="server" name="search" ID="txtWholesale" placeholder="" value="" class="sein1" />
         <asp:RequiredFieldValidator ID="RfvWholesale" runat="server" EnableClientScript="True"  ErrorMessage="Wholesale Price" ValidationGroup="gpMain" ControlToValidate="txtWholesale" Display="none"></asp:RequiredFieldValidator>
     </div>    
  </div>
  
  
  <div class="blockadd1">
     <div class="textforget">Add Images<span class="text-danger">*</span> <div class="uptext">Upload or drag image</div></div>     
  </div>
    
  <div class="blockadd1">
       <div  class="dropzone" id="dzItemPics">
           <div class="fallback">
              <input name="file" type="file" multiple="true" runat="server" id="ItemImages"/>
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
                                       onclientclick="return confirm('Are you sure, you want to delete ?')"></asp:LinkButton></div>
                              <a href="#" id="hidden_link" style="display:none;"></a>

                               <asp:Button  runat="server"  name="login" ID="btnPreview"  class="hvr-sweep-to-rightup2" OnClick="btnPreview_OnServerClick" OnClientClick="SetTarget();" Text="Preview"  ></asp:Button>
                               <button type="submit" runat="server" name="login" ID="btnPublish"  ValidationGroup="gpMain" 
                                      class="hvr-sweep-to-rightup2" Text="" OnServerClick="btnPublish_OnServerClick">Publish</button>
                              </div> 
                         </div><!--search-->
                  </div><!--colmd12-->
                  <div class="dissp"></div>
                  
            <!--featured-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading">Featured Image <span class="text-danger">*</span></div>
                             <div class="imgb">
                                 <div  class="dropzone" id="dzItemFeatured">
                                   <div class="fallback">
                                      <input name="file" type="file" multiple runat="server" ID="fImage" />
                                      <input type="submit" value="Upload" />
                                    </div>  
                                </div> 
                             </div>
                            <%-- <a href=""><div class="fewer">Remove featured image</div></a>--%>
                         </div><!--search-->
                  </div><!--colmd12-->
                  <div class="dissp"></div> 
                  
                  
            <!--style number-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading">Style Number <span class="text-danger">*</span></div>
                             <div class="searchsm" style="margin-top:20px;">
                                 <div class="searctext">
                                     <input type="text" runat="server" name="search" ID="txtStyleNumber" placeholder="" value="" class="sein1" />
                                     <asp:RequiredFieldValidator ID="RfvStyleNumber" runat="server" EnableClientScript="True"  ErrorMessage="Style Number" ValidationGroup="gpMain" ControlToValidate="txtStyleNumber" Display="None"></asp:RequiredFieldValidator>
                                 </div>
                                 <div class="searcadd">
                                   <button type="submit" name="login" id="login" style="display:none;" class="hvr-sweep-to-right3">Add</button></div>
                             </div>
                         </div><!--search-->
                  </div><!--colmd12-->
                  <div class="dissp"></div>  
                  
            <!--style name-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading">Style Name <span class="text-danger">*</span></div>
                             <div class="searchsm" style="margin-top:20px;">
                                 <div class="searctext">
                                     <input type="text" runat="server" name="search" ID="txtStyleName" placeholder="" value="" class="sein1" />
                                     <asp:RequiredFieldValidator ID="RfvStyleName" runat="server" EnableClientScript="True"  ErrorMessage="Style Name" ValidationGroup="gpMain" ControlToValidate="txtStyleName" Display="None"></asp:RequiredFieldValidator>
                                 </div>
                                 <div class="searcadd">
                                   <button type="submit" name="login" id="login" style="display:none;" class="hvr-sweep-to-right3">Add</button></div>
                             </div>
                         </div><!--search-->
                  </div><!--colmd12-->
                  <div class="dissp"></div>                   
                  
            <!--colors-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading" style="margin-bottom:10px;">Color <span class="text-danger">*</span></div> 
                             <asp:Label runat="server" ID="lblColor1" Visible="False"  Text=""/>
                            
                             
                           <div class="color"><div class="color1">  <input type="text" value="" id="demo1" style="background:#fff;" class="color1" />            </div></div>
                           <div class="color"><div class="color1">  <input type="text" value="" id="demo2" style="background:#ccc;" class="color1" />        </div></div>
                           <div class="color"><div class="color1">  <input type="text" value="" id="demo3" style="background:#666;" class="color1" />     </div></div>
                           <div class="color"><div class="color1">  <input type="text" value="" id="demo4" style="background:#000;" class="color1" />        </div></div>
                           <div class="color"><div class="color1">  <input type="text" value="" id="demo5" style="background:#663333;" class="color1" />     </div></div>
                           <div class="color"><div class="color1">  <input type="text" value="" id="demo6" style="background:#003333;" class="color1" />     </div></div>
                           <div class="color"><div class="color1">  <input type="text" value="" id="demo7" style="background:#3366CC;" class="color1" />     </div></div>
                           <div class="color"><div class="color1">  <input type="text" value="" id="demo8" style="background:#339933;" class="color1" />     </div></div>
                           <div class="color"><div class="color1">  <input type="text" value="" id="demo9" style="background:#CC9966;" class="color1" />     </div></div>
                           <div class="color"><div class="color1">  <input type="text" value="" id="demo10" style="background:#FF6633;" class="color1" />    </div></div>
                           <div class="color"><div class="color1">  <input type="text" value="" id="demo11" style="background:#FF3300;" class="color1" />    </div></div>
                           <div class="color"><div class="color1">  <input type="text" value="" id="demo12" style="background:#CC66CC;" class="color1" />    </div></div>
                                       
                           <div>
                                <div class="serheading" style="margin-bottom:10px;">Selected Color</div>
                                <div><input type="text" value="" id="txtSelectedColor" style="background:#fff; height: 40px; border: 1px solid #ccc; width: 280;"  /></div>
                           </div>
                         </div><!--search-->
                         
                         
                  </div><!--colmd12-->
                  <div class="dissp"></div>      
                  
                  <!--categories-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading" style="margin-bottom:10px;">Categories <span class="text-danger">*</span></div> 
                             <asp:Label ID="lblSelectedCat" runat="server" Visible="False"></asp:Label>
                             <asp:updatepanel runat="server" ID="up_Categories" >
                                 <ContentTemplate>
                                      <div id="seedefaultCats">
                                 <div class="dblock">
                                     <asp:checkboxlist runat="server" ID="chkCategories" 
                                         DataSourceID="sdsMoreCats" DataTextField="Title" DataValueField="CategoryID">
                                     </asp:checkboxlist>
                                     <asp:SqlDataSource ID="sdsDefaultCats" runat="server" 
                                         ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                         ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                         SelectCommand="SELECT TOP (6) CategoryID, Title FROM dbo.Tbl_Categories ORDER BY Title">
                                     </asp:SqlDataSource>
                                      <asp:SqlDataSource ID="sdsMoreCats" runat="server" 
                                         ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                         ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                         SelectCommand="SELECT TOP (9) CategoryID, Title FROM dbo.Tbl_Categories ORDER BY Title">
                                     </asp:SqlDataSource>
                                 </div>
                            
                             </div>
                             <div class="bmore2"><asp:LinkButton runat="server" ID="btn_ViewMore" 
                                     CssClass="bmore2" Text="View More" onclick="btn_ViewMore_Click"></asp:LinkButton> 
                                 <asp:LinkButton runat="server" CssClass="bmore2" ID="btn_ViewLess" 
                                     Text="See fewer" Visible="False" onclick="btn_ViewLess_Click"></asp:LinkButton></div>
                                 </ContentTemplate>
                             </asp:updatepanel>
                            
                            
                       
                         
                         <div class="bfewer2" style="display:none;"></div> 
                         </div><!--search-->
                  </div><!--colmd12-->
                  <div class="dissp"></div>
                  
                  <!--Season-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading" style="margin-bottom:10px;">Seasons <span class="text-danger">*</span></div> 
                           <asp:updatepanel runat="server" ID="up_Seasons" >
                                 <ContentTemplate>
                                    <div id="seeDefaultSessions">
                                 <div class="dblock">
                                     <asp:checkboxlist runat="server" ID="chkDefaultSeasons" 
                                         DataSourceID="sdsMoreSeasons" DataTextField="Season" DataValueField="SeasonID">
                                     </asp:checkboxlist>
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
                                     CssClass="bmore" Text="View More" onclick="btn_MoreSeasons_Click" ></asp:LinkButton> 
                                 <asp:LinkButton runat="server" CssClass="bmore" ID="btn_LessSeasons" 
                                     Text="See fewer" Visible="False" onclick="btn_LessSeasons_Click" ></asp:LinkButton></div>
                              </ContentTemplate>
                             </asp:updatepanel>
                           
                        
                         </div><!--search-->
                         
                  </div><!--colmd12-->
                  <div class="dissp"></div> 
                  
                  
            
            <!--Holidays-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading" style="margin-bottom:10px;">Holiday <span class="text-danger">*</span></div> 
                          <asp:updatepanel runat="server" ID="up_Holidays" >
                                 <ContentTemplate>
                             <div id="seeDefaultHoliday">
                                 <div class="dblock">
                                     <asp:checkboxlist runat="server" ID="chkDefaultHoliday" 
                                         DataSourceID="sdsMoreHoliday" DataTextField="Title" DataValueField="HolidayID">
                                     </asp:checkboxlist>
                                    
                                      <asp:SqlDataSource ID="sdsMoreHoliday" runat="server" 
                                         ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                         ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                         SelectCommand="SELECT TOP (9) HolidayID, Title FROM Tbl_Holidays ORDER BY Title">
                                     </asp:SqlDataSource>
                                 </div>
                            
                             </div>
                             <div class="bmore3">
                                        <asp:LinkButton runat="server" ID="btn_MoreHolidays" 
                                     CssClass="bmore3" Text="View More" onclick="btn_MoreHolidays_Click"  ></asp:LinkButton> 
                                 <asp:LinkButton runat="server" CssClass="bmore3" ID="btn_LessHolidays" 
                                     Text="See fewer" Visible="False" onclick="btn_LessHolidays_Click"  ></asp:LinkButton></div>
                           </ContentTemplate>
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
                             
                             <div class="searchsm">
                                 <div class="searctext"><input type="text" runat="server" name="search" ID="txtTag" placeholder="" value="" class="sein1" /></div>
                                 <div class="searcadd">
                                   <button type="button" runat="server" name="login" ID="btnAddTag" OnServerClick="btnAddTag_OnServerClick" class="hvr-sweep-to-right3">Add</button></div>
                             </div>
                             <div class="smalltext">Separate tags with commas</div>
                             <asp:Repeater runat="server" ID="rptTags" DataSourceID="sdsTags">
                                 <ItemTemplate>
                                     <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> <%# Eval("Title") %></a></div>
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
                                     CssClass="fewer" Text="View More" onclick="btn_MoreTags_Click" ></asp:LinkButton> 
                                 <asp:LinkButton runat="server" CssClass="fewer" ID="btn_LessTags" 
                                     Text="See fewer" Visible="False" onclick="btn_LessTags_Click" ></asp:LinkButton></div>
                          </ContentTemplate>
                      </asp:updatepanel>
                         <!--search-->
                         
                  </div><!--colmd12-->
                  <div class="dissp"></div>                                 

     </div><!--discoverwraps-->
     
</div><!--col-md-12-->

           

<!--footer-->
  <div class="footerbg">
     <div class="starter-template">
        <div class="col-md-12">©2016 Press Preview</div>
     </div>    
  </div><!--footer-->
<!--footer-->

</div><!--wrapper-->

    <script type="application/javascript" src="../js/custom.js"></script>
     <script src="../js/bootstrap-colorpicker.min.js"></script>
    <script src="../js/bootstrap-colorpicker-plus.js"></script>
  <script type="text/javascript">
      $(function () {
          var demo1 = $('#demo1');
          demo1.colorpickerplus();
          demo1.on('changeColor', function (e, color) {
              if (color == null)
                  $(this).val('transparent').css('background-color', '#fff'); //tranparent
              else {
                  $('#lblColor1').text(color);
                //  $(this).css('background-color', color);
                  $('#txtSelectedColor').css('background-color', color);
              }

          });

          var demo2 = $('#demo2');
          demo2.colorpickerplus();
          demo2.on('changeColor', function (e, color) {
              if (color == null)
                  $(this).val('transparent').css('background-color', '#fff'); //tranparent
              else {
                  $('#lblColor1').text(color);
                  // $(this).css('background-color', color);
                  $('#txtSelectedColor').css('background-color', color);
              }

          });

          var demo3 = $('#demo3');
          demo3.colorpickerplus();
          demo3.on('changeColor', function (e, color) {
              if (color == null)
                  $(this).val('transparent').css('background-color', '#fff'); //tranparent
              else {
                  $('#lblColor1').text(color);
                  // $(this).css('background-color', color);
                  $('#txtSelectedColor').css('background-color', color);
              }

          });

          var demo4 = $('#demo4');
          demo4.colorpickerplus();
          demo4.on('changeColor', function (e, color) {
              if (color == null)
                  $(this).val('transparent').css('background-color', '#fff'); //tranparent
              else {
                  $('#lblColor1').text(color);
                  // $(this).css('background-color', color);
                  $('#txtSelectedColor').css('background-color', color);
              }

          });

          var demo5 = $('#demo5');
          demo5.colorpickerplus();
          demo5.on('changeColor', function (e, color) {
              if (color == null)
                  $(this).val('transparent').css('background-color', '#fff'); //tranparent
              else {
                  $('#lblColor1').text(color);
                  // $(this).css('background-color', color);
                  $('#txtSelectedColor').css('background-color', color);
              }

          });

          var demo6 = $('#demo6');
          demo6.colorpickerplus();
          demo6.on('changeColor', function (e, color) {
              if (color == null)
                  $(this).val('transparent').css('background-color', '#fff'); //tranparent
              else {
                  $('#lblColor1').text(color);
                  // $(this).css('background-color', color);
                  $('#txtSelectedColor').css('background-color', color);
              }

          });

          var demo7 = $('#demo7');
          demo7.colorpickerplus();
          demo7.on('changeColor', function (e, color) {
              if (color == null)
                  $(this).val('transparent').css('background-color', '#fff'); //tranparent
              else {
                  $('#lblColor1').text(color);
                  //  $(this).css('background-color', color);
                  $('#txtSelectedColor').css('background-color', color);
              }

          });

          var demo8 = $('#demo8');
          demo8.colorpickerplus();
          demo8.on('changeColor', function (e, color) {
              if (color == null)
                  $(this).val('transparent').css('background-color', '#fff'); //tranparent
              else {
                  $('#lblColor1').text(color);
                  //  $(this).css('background-color', color);
                  $('#txtSelectedColor').css('background-color', color);
              }

          });

          var demo9 = $('#demo9');
          demo9.colorpickerplus();
          demo9.on('changeColor', function (e, color) {
              if (color == null)
                  $(this).val('transparent').css('background-color', '#fff'); //tranparent
              else {
                  $('#lblColor1').text(color);
                  //   $(this).css('background-color', color);
                  $('#txtSelectedColor').css('background-color', color);
              }

          });

          var demo10 = $('#demo10');
          demo10.colorpickerplus();
          demo10.on('changeColor', function (e, color) {
              if (color == null)
                  $(this).val('transparent').css('background-color', '#fff'); //tranparent
              else {
                  $('#lblColor1').text(color);
                  // $(this).css('background-color', color);
                  $('#txtSelectedColor').css('background-color', color);
              }

          });

          var demo11 = $('#demo11');
          demo11.colorpickerplus();
          demo11.on('changeColor', function (e, color) {
              if (color == null)
                  $(this).val('transparent').css('background-color', '#fff'); //tranparent
              else {
                  $('#lblColor1').text(color);
                  //$(this).css('background-color', color);
                  $('#txtSelectedColor').css('background-color', color);
              }

          });

          var demo12 = $('#demo12');
          demo12.colorpickerplus();
          demo12.on('changeColor', function (e, color) {
              if (color == null)
                  $(this).val('transparent').css('background-color', '#fff'); //tranparent
              else {
                  $('#lblColor1').text(color);
                  // $(this).css('background-color', color);
                  $('#txtSelectedColor').css('background-color', color);
              }

          });
      });
  </script>
 <%-- <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>--%>
   
</form>
</body>
</html>
