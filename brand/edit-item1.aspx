<%@ Page Language="C#" ValidateRequest="false"  AutoEventWireup="true"  CodeFile="edit-item1.aspx.cs" Inherits="pr_brand_add_item" %>
<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox, Version=3.3.1.12354, Culture=neutral, PublicKeyToken=5962a4e684a48b87" %>

<!DOCTYPE "html">
<html runat="server">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Press Preview - Edit Item</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../css/checkbox.css"/>
<link href="../css/bootstrap-colorpicker.min.css" rel="stylesheet" />
<link href="../css/bootstrap-colorpicker-plus.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
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
    <script type="text/javascript">
        function HideLabel() {
            setTimeout(function () { $('#divAlerts').fadeOut(); }, 4000);
        };
</script>
  <script language="javascript" type="text/javascript">       $(document).ready(function () {
      $("#btnPreview").click(function () {
               
                 $(".lightboxheadertext").html($("#txtItemTitle").val());
                 $("#dvdescription").html($("#txtDescription").val());
                 $("#dvRetail").html($("#txtRetail").val());
                 $("#dvWholesale").html($("#txtWholesale").val());
                 $("#dvstyleNo").html($("#txtStyleNumber").val());
                 $("#dvstyleName").html($("#txtStyleName").val());
                 $("#modal_imgicon").attr('src', $('#imgUserIcon').attr('src'));
                

                 var imageArray = [];
                 alert(imageArray.length);
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
                 for (var y = 0; y < imageArray.length; y++) {
                     var itemx = "<img id=" + y + " src=" + imageArray[y] + " /><br/>";
                     $("#modal_image").append(itemx);
                 }
                                 <%--data-toggle="modal" data-target="#myModal"--%>
                 //$("#button1").attr("data-toggle", "modal");
                 //$("#button1").attr("data-target", "#myModal");

             });

       });</script>

    <script type="text/javascript">

//        var mockFile = { name: "myimage.jpg", size: 12345 };
        //File Upload response from the server
        var itemId = '<%= Request.QueryString["v"] %>';
        Dropzone.options.dzItemPics = {
            
        // Validate the file type. only accept images
            acceptedFiles: 'image/*',
            dictDefaultMessage: "Click or Drag Images here to upload",
            maxFiles: 100,
            url: "EditItempics.ashx?v=" + itemId,
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
//                // Validate the dimensions of the image....
//                this.on('thumbnail', function(file) {
//                    if (file.width < 800 || file.height < 600) {
//                        file.rejectDimensions();
//                    } else {
//                        file.acceptDimensions();
//                    }
//                });

                this.on("addedfile", function(file) {

                   // this.options.thumbnail.call(this, file, file_image);
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
                //this.addFile.call(this, mockFile);

                this.on("removedfile", function(file) {
                    //add in your code to delete the file from the database here 
                    $.ajax({
                        type: "POST",
                        url: 'edit-item.aspx\\RemoveImage',
                        data: "{'filename':'" + file.name + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function(data) {

                        }
                    });
                });

            }
//            accept: function(file, done) {
//                file.acceptDimensions = done;
//                file.rejectDimensions = function() {
//                    done('The image must be at least 800 x 600px');
//                };
//            }
        };

    </script>
    <script type="text/javascript">
        var itemId = '<%= Request.QueryString["v"] %>';
        // Dropzone for featured image
        Dropzone.options.dzItemFeatured = {
        // Validate the file type. only accept images
            acceptedFiles: 'image/*',
            dictDefaultMessage: "Click or Drag Image here to upload",
            maxFiles: 1,
            url: "Editfeatured.ashx?v="+itemId,
            thumbnailWidth: 310,
            thumbnailHeight: 232,
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
                        url: 'edit-item.aspx\\RemoveFeatureImage',
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
               <!--#INCLUDE FILE="../includes/logo2.txt" -->
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
             <input type="text" runat="server" ID="txtItemTitle" class="addin" placeholder=""  tabindex="1"/>
            <asp:RequiredFieldValidator ID="RfvTitle" runat="server" EnableClientScript="True" ErrorMessage="Title" ValidationGroup="gpMain" ControlToValidate="txtItemTitle" Display="none"></asp:RequiredFieldValidator>
         </div>
     
  <!--editor-->
  <div class="editorblock">
     <%-- <textarea name="editor1" class="ckeditor" runat="server" ID="txtDescription" tabindex="2" Height="200px" Width="100%">
       
    </textarea>
   <script type="text/javascript">
       CKEDITOR.replace('editor1');
       CKEDITOR.add();            
   </script>--%>
    <FTB:FreeTextBox runat="server" ID="txtDescription" ButtonSet="OfficeMac" 
          Height="200px" 
          ToolbarLayout="JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent; InsertRule|Cut,Copy,Paste;Print" 
          ToolbarStyleConfiguration="Office2000" Width="100%"></FTB:FreeTextBox>
   
      <asp:RequiredFieldValidator ID="RfvDescription" runat="server" 
          EnableClientScript="True"  ErrorMessage="Item Description" 
          ValidationGroup="gpMain" ControlToValidate="txtDescription" Display="none" 
          Enabled="False"></asp:RequiredFieldValidator>
  </div> 
  
  <div class="blockadd1">
     <div class="textforget">Add Price</div>     
  </div>
  
  <div class="blockaddpr">
     <div class="addpriceb1">Retail<span class="text-danger">*</span></div> 
     <div class="addpriceb">
     <input type="text" runat="server" name="search" ID="txtRetail" placeholder="" tabindex="3" value="" class="sein1" />
     <asp:RequiredFieldValidator ID="RfvRetail" runat="server" EnableClientScript="True"  ErrorMessage="Retail Price" ValidationGroup="gpMain" ControlToValidate="txtRetail" Display="none"></asp:RequiredFieldValidator>
     </div>
     <div class="addpriceb2">Wholesale Price<span class="text-danger">*</span></div> 
     <div class="addpriceb">
         <input type="text" runat="server" name="search" ID="txtWholesale" placeholder="" tabindex="4" value="" class="sein1" />
         <asp:RequiredFieldValidator ID="RfvWholesale" runat="server" EnableClientScript="True"  ErrorMessage="Wholesale Price" ValidationGroup="gpMain" ControlToValidate="txtWholesale" Display="none"></asp:RequiredFieldValidator>
     </div>    
  </div>
  
  
  <div class="blockadd1">
     <div class="textforget">Add Images<span class="text-danger">*</span> <div class="uptext">Upload or drag image</div></div>     
  </div>
    
  <div class="blockadd1">
       <div  class="dropzone" id="dzItemPics" tabindex="5">
           <div class="fallback">
              <input name="file" type="file" multiple="true" runat="server" id="ItemImages"/>
              <input type="submit" value="Upload" />
            </div>  
        </div>
  </div>
  <div class="blockadd1">
      <asp:updatepanel runat="server">
        <ContentTemplate>
       <div class="form-group">
                                            <div class="col-sm-12"><label for="existingImg">Uploaded Images</label></div>
                                            <asp:DataList ID="dlImages" runat="server" DataKeyField="ImgID" 
                                                            DataSourceID="sdsImages" RepeatColumns="2" OnItemCommand="dlImages_ItemCommand" 
                                                            RepeatDirection="Horizontal" Width="100%">
                                                            <ItemTemplate>
                                                                <div ID="imgContainer">
                                                                    <div style=" padding:2px; border:2px solid #fff;">
                                                                        <asp:Image ID="imgCertification" runat="server" 
                                                                            ImageUrl='<%# Eval("ItemImg", "../photobank/{0}") %>' Width="310px"  Height="232px"/>
                                                                    </div>
                                                                    <div style="position: relative; top: -230px; float:right; right:52px;">
                                                                        <asp:Button ID="btnRemove" runat="server" 
                                                                            CommandArgument='<%# Eval("ImgID", "{0}") %>' CommandName="1" 
                                                                            CssClass="btn btn-default btn-xs" 
                                                                            onclientclick="return confirm('Are you sure,you want to delete ?')" Text="X" />
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:DataList>
                                           <asp:SqlDataSource ID="sdsImages" runat="server" 
                                                                        ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                                                         ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>"
                                                                        
                                                            SelectCommand="SELECT [ImgID], [ItemImg] FROM [Tbl_ItemImages] WHERE  [ItemID] =?">
                                                                        <SelectParameters>
                                                                            <asp:QueryStringParameter Name="EventID" QueryStringField="v" 
                                                                                Type="String" />
                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                        </div>
        </ContentTemplate>
      </asp:updatepanel>
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
                                       onclientclick="return confirm('Are you sure, you want to delete ?')" TabIndex="23"></asp:LinkButton></div>
                              <a id="hidden_link" runat="server" style="visible:false"  width="60%" height="60%"></a>
                                <asp:Literal ID="Literal1" runat="server"></asp:Literal>

                                <button type="button"  name="login" id="btnPreview"  data-toggle="modal" data-target="#myModal"
                                      style="width:100px;"  class="hvr-sweep-to-rightup2" 
                                      tabindex="21"   >Preview</button>
                               <button type="button" runat="server" name="login" ID="btnPublish"  ValidationGroup="gpMain"  tabindex="22" 
                                      class="hvr-sweep-to-rightup2" Text="" OnServerClick="btnPublish_OnServerClick" >Publish</button>
                              </div> 
                         </div><!--search-->
                  </div><!--colmd12-->
                  <div class="dissp"></div>
                  
            <!--featured-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading">Featured Image <span class="text-danger">*</span></div>
                             <div class="imgb">
                                 <div  class="dropzone" id="dzItemFeatured" tabindex="6">
                                   <div class="fallback">
                                      <input name="file" type="file" multiple runat="server" ID="fImage" />
                                      <input type="submit" value="Upload" />
                                    </div>  
                                </div> 
                             </div>
                             
                              <div class="serheading" style="padding-bottom: 15px;padding-top: 15;">Current Featured Image</div>
                              <asp:updatepanel runat="server">
                                 <ContentTemplate>
                              <div ID="Div1">
                                  <div style=" padding:2px; border:2px solid #fff;">
                                      <asp:Image ID="imgFeatured" runat="server" Width="310px"  Height="232px"/>
                                  </div>
                                  <div style="position: relative; top: -230px; float:right;">
                                      <asp:Button ID="btnRemove" runat="server" CssClass="btn btn-default btn-xs" 
                                                                            
                                          onclientclick="return confirm('Are you sure,you want to delete ?')" Text="X" 
                                          onclick="btnRemove_Click" />
                                  </div>
                             </div>
                             </ContentTemplate>
                            </asp:updatepanel>
                            <%-- <a href=""><div class="fewer">Remove featured image</div></a>--%>
                         </div><!--search-->
                  </div><!--colmd12-->
                  <div class="dissp"></div> 
                  
                  
            <!--style number-->
                  <div class="col-md-12 discrigblock">
                         <div class="searchb">
                             <div class="serheading">Style Number <span class="text-danger">*</span></div>
                             <div class="searchsm" style="margin-top:20px;">
                                 <div class="searctext" style="width:100%;">
                                     <input type="text" runat="server" name="search" ID="txtStyleNumber" placeholder="" value="" class="sein1" tabindex="7" />
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
                             <div class="serheading">Style Name <span class="text-danger">*</span></div>
                              
                                     <div class="searchsm" style="margin-top:20px;">
                                         <div class="searctext" style="width:100%;">
                                             <input type="text" runat="server" name="search" ID="txtStyleName" placeholder="" value="" class="sein1" tabindex="8"/>
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
                             <div class="serheading" style="margin-bottom:10px;">Color <span class="text-danger">*</span></div> 
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
                             <div class="serheading" style="margin-bottom:10px;">Categories <span class="text-danger">*</span></div> 
                             <asp:Label ID="lblSelectedCat" runat="server" Visible="False"></asp:Label>
                             <asp:updatepanel runat="server" ID="up_Categories" >
                                 <ContentTemplate>
                                      <div id="seedefaultCats" tabindex="10">
                                 <div class="dblock">
                                     <asp:CheckBoxList runat="server" ID="chkCategories" 
                                         DataSourceID="sdsDefaultCats" DataTextField="Title" 
                                         DataValueField="CategoryID" CellPadding="4" CellSpacing="4" 
                                         RepeatColumns="2" Width="100%" >
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
                                     CssClass="bmore2" Text="View More" onclick="btn_ViewMore_Click" TabIndex="11"></asp:LinkButton> 
                                 <asp:LinkButton runat="server" CssClass="bmore2" ID="btn_ViewLess" 
                                     Text="See fewer" Visible="False" onclick="btn_ViewLess_Click" TabIndex="12"></asp:LinkButton></div>
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
                                    <div id="seeDefaultSessions" tabindex="13">
                                 <div class="dblock">
                                     <asp:CheckBoxList runat="server" ID="chkDefaultSeasons" 
                                         DataSourceID="sdsMoreSeasons" DataTextField="Season" 
                                         DataValueField="SeasonID" >
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
                                     CssClass="bmore" Text="View More" onclick="btn_MoreSeasons_Click" TabIndex="14"></asp:LinkButton> 
                                 <asp:LinkButton runat="server" CssClass="bmore" ID="btn_LessSeasons" 
                                     Text="See fewer" Visible="False" onclick="btn_LessSeasons_Click" TabIndex="15"></asp:LinkButton></div>
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
                             <div id="seeDefaultHoliday" tabindex="16">
                                 <div class="dblock">
                                       <asp:CheckBoxList  runat="server" ID="chkDefaultHoliday" 
                                         DataSourceID="sdsMoreHoliday" DataTextField="Title" 
                                         DataValueField="HolidayID"  >
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
                                     CssClass="bmore3" Text="View More" onclick="btn_MoreHolidays_Click"  TabIndex="17"></asp:LinkButton> 
                                 <asp:LinkButton runat="server" CssClass="bmore3" ID="btn_LessHolidays" 
                                     Text="See fewer" Visible="False" onclick="btn_LessHolidays_Click"  TabIndex="18"></asp:LinkButton></div>
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
                            <asp:Panel runat="server" DefaultButton="btnAddTag">
                             <div class="searchsm">
                                 <div class="searctext"><input type="text" runat="server" name="search" ID="txtTag" placeholder="" value="" class="sein1" tabindex="19"/></div>
                                 <div class="searcadd">
                                   <asp:Button  runat="server" name="login" ID="btnAddTag" ValidationGroup="gpTags" OnClick="btnAddTag_OnServerClick" class="hvr-sweep-to-right3" Text="Add" TabIndex="20"></asp:Button></div>
                                    <asp:RequiredFieldValidator ID="RfvTags" runat="server" 
                                     ErrorMessage="This field is required" ControlToValidate="txtTag" 
                                     ValidationGroup="gpTags"></asp:RequiredFieldValidator>
                             </div>
                             </asp:Panel>
                             <div class="smalltext">Separate tags with commas</div>
                             <asp:Repeater runat="server" ID="rptTags" DataSourceID="sdsTags" 
                                      onitemcommand="rptTags_ItemCommand">
                                 <ItemTemplate>
                                     <div class="tagblock"><asp:LinkButton runat="server" ID="lbtnRemoveTag" CommandName="1" CommandArgument='<%# Eval("TagID","{0}")%>'><i runat="server" class="fa fa-times-circle-o" style="padding-right:10px;" ></i><%# Eval("Title") %></asp:LinkButton> </div>
                                 </ItemTemplate>
                             </asp:Repeater>
                                  <asp:SqlDataSource ID="sdsTags" runat="server" 
                                      ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                      ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                      
                                      SelectCommand="SELECT Top 5 [TagID], [Title] FROM [Tbl_ItemTags]  Where ItemID=?  ORDER BY [TagID]">
                                      <SelectParameters>
                                          <asp:QueryStringParameter QueryStringField="v" Name="ItemID" Type="Int32"/>
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                                   <asp:SqlDataSource ID="sdsMoreTags" runat="server" 
                                      ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                      ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                      
                                      SelectCommand="SELECT Top 10 [TagID], [Title] FROM [Tbl_ItemTags] Where ItemID=?  ORDER BY [TagID]">
                                      <SelectParameters>
                                         <asp:QueryStringParameter QueryStringField="v" Name="ItemID" Type="Int32"/>
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
                  <label class="lightb"><i class="fa fa-eye" aria-hidden="true"></i>&nbsp; 500 Views</label>
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
                     <div class="serheading1">Comments - (24)</div> 
                     
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
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
</div><!--wrapper-->

    <script type="application/javascript" src="../js/custom.js"></script>
    <script src="../js/color1.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://cdn.ucb.org.br/Scripts/formValidator/js/languages/jquery.validationEngine-en.js"
    charset="utf-8"></script>
<script type="text/javascript" src="http://cdn.ucb.org.br/Scripts/formValidator/js/jquery.validationEngine.js"
    charset="utf-8"></script>
   <script type="text/javascript">
       $("#colbtn").live("click", (function (e) {
           $(".popupbox").toggle();
       }));
    </script>

<script type="text/javascript">
    $(document).ready(function () {
        $(function () {
            $("#frm1").validationEngine('attach', { promptPosition: "topRight" });
        });
        var userId = '<%= Request.Cookies["FRUserId"].Value %>';
        $("#lbViewMessageCount").mouseover(function () {

            $.ajax({
                type: "POST",
                url: $(location).attr('pathname') + "\\UpdateMessageStatus",
                contentType: "application/json; charset=utf-8",
                data: "{'userID':'" + userId + "'}",
                dataType: "json",
                async: true,
                error: function (jqXhr, textStatus, errorThrown) {
                    alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
                },
                success: function (msg) {
                    //                    if (msg.d == true) {

                    $('#<%=lblTotalMessages.ClientID%>').hide("slow");
                    $('#<%=lblTotalMessages.ClientID%>').val = "";
                    return false;
                }
            });

        });


        $("#lbViewAlerts").mouseover(function () {

            $.ajax({
                type: "POST",
                url: $(location).attr('pathname') + "\\UpdateNotifications",
                contentType: "application/json; charset=utf-8",
                data: "{'userID':'" + userId + "'}",
                dataType: "json",
                async: true,
                error: function (jqXhr, textStatus, errorThrown) {
                    alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
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
    </script>   
   
</form>
</body>
</html>
