<%@ Page Language="C#" ValidateRequest="false"  AutoEventWireup="true"  CodeFile="edit-lookbook.aspx.cs" Inherits="pr_brand_add_item" %>
<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox, Version=3.3.1.12354, Culture=neutral, PublicKeyToken=5962a4e684a48b87" %>

<!DOCTYPE "html">
<html runat="server">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Press Preview - Edit LookBook</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
    #txtDescription_toolbarArea{
        display: none;
    }
    #txtDescription_TabRow{
        display: none
    }
    #txtDescription{
        width:100%;
    }
</style>
<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../css/checkbox.css"/>
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
    <script src="../js/JSession.js" type="text/javascript"></script>
    <link href="../css/colorPicker.css" rel="stylesheet" type="text/css" />
    <style>
 
</style>

   <script type="text/javascript">
    jQuery(document).ready(function () {
        $(document).ready(function () {

            $(".fancybox").fancybox({
                href: $(this).attr('href'),
                fitToView: true,
                frameWidth: '90%',
                frameHeight: '100%',
                width: '87%',
                height: '100%',
                autoSize: false,
                closeBtn: true,
                closeClick: false,
                openEffect: 'fade',
                closeEffect: 'fade',
                type: "iframe",
                opacity: 0.7,
                onStart: function () {
                    $("#fancybox-overlay").css({ "position": "fixed" });
                },
                beforeShow: function () {

                    var url = $(this).attr('href');
                    url = (url == null) ? '' : url.split('?');
                    if (url.length > 1) {
                        url = url[1].split('=');

                        // var id = url.substring(url.lastIndexOf("/") + 1, url.length);
                        var id = url[1];
                        var pageUrl = 'http://presspreview.azurewebsites.net/brand/itemview1?v=' + id;
                        //window.location = pageUrl;
                        window.history.pushState('d', 't', pageUrl);
                    }
                },
                beforeClose: function () {
                    window.history.pushState('d', 't', 'http://presspreview.azurewebsites.net/brand/profile-page-items.aspx');

                }

            });

        });
       

    });
</script>

     <style>
           .dropzone .dz-preview.dz-image-preview {
        display: block;
        }
    </style>
    <script type="text/javascript">
        var lookId = '<%= Request.QueryString["v"] %>';
        // Dropzone for featured image
        Dropzone.options.dzItemFeatured = {
            // Validate the file type. only accept images
            acceptedFiles: 'image/*',
            dictDefaultMessage: "Click or Drag Image here to upload",
            maxFiles: 1,
            url: "Editlookbook.ashx?v=" + lookId,
            thumbnailWidth: null,
            thumbnailHeight: null,
            init: function () {

                this.on("maxfilesexceeded", function (data) {
                    var res = eval('(' + data.xhr.responseText + ')');
                });


                // Get response on Success
                this.on('success', function (file, resp) {

                    var crossHeight = 0;
                    var imgName = resp;
                    file.previewElement.classList.add("dz-success");
                    console.log("Successfully uploaded :" + imgName);
                    $("#dzItemFeatured .dz-image img").each(function () {
                        console.log("FH : " + $(this).height());
                        console.log("fW : " + $(this).width());
                        var imgHeight = $(this).height();
                        var imgWidth = $(this).width();
                        if (imgHeight > 300) {
                            var aspectRatio = 318 / imgHeight;
                            var ratioHeight = $(this).height() * aspectRatio;
                            var ratioWidth = $(this).width() * aspectRatio;
                            $(this).height(ratioHeight);
                            $(this).width(ratioWidth);
                            $(this).css("margin", "0 auto");
                            console.log("New FH : " + ratioHeight);
                            console.log("New fW : " + ratioWidth);
                            crossTop = ratioHeight;
                        }
                        else if (imgWidth > 315) {
                            var aspectRatio = 318 / imgWidth;
                            var ratioHeight = $(this).height() * aspectRatio;
                            var ratioWidth = $(this).width() * aspectRatio;
                            $(this).height(ratioHeight);
                            $(this).width(ratioWidth);
                            $(this).css("margin", "0 auto");
                            console.log("New FH : " + ratioHeight);
                            console.log("New fW : " + ratioWidth);
                            crossTop = ratioHeight;
                        }
                        else {
                            var ratioHeight = $(this).height();
                            var ratioWidth = $(this).width();
                            $(this).height(ratioHeight);
                            $(this).width(ratioWidth);
                            $(this).css("margin", "0 auto");
                            console.log("New FH : " + ratioHeight);
                            console.log("New fW : " + ratioWidth);
                            crossTop = ratioHeight;

                        }
                    });
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
                    var removeButton = Dropzone.createElement("<button style='position:absolute; top: 0; margin-left: 0; z-index: 100; background:#ccc; border:0; color:#fff;'>X</button>");
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
                        url: 'edit-lookbook.aspx\\RemoveFeatureImage',
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
     <script type="text/javascript">
         function HideLabel() {
             setTimeout(function () { $('#divAlerts').fadeOut(); }, 4000);
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
         <div class="textforget">Lookbook Details</div>
         <div class="textadd">TITLE<span class="text-danger">*</span></div>
         <div class="textadd">
             <input type="text" runat="server" ID="txtItemTitle" class="addin" placeholder=""  tabindex="1"/>
            <asp:RequiredFieldValidator ID="RfvTitle" runat="server" EnableClientScript="True" ErrorMessage="Title" ValidationGroup="gpMain" ControlToValidate="txtItemTitle" Display="none"></asp:RequiredFieldValidator>
         </div>
     
  <!--editor-->
  <div class="editorblock">
    <%--  <textarea name="editor1" class="ckeditor" runat="server" ID="txtDescription" tabindex="2" Height="200px" Width="100%">
       
    </textarea>
   <script type="text/javascript">
       CKEDITOR.replace('editor1');
       CKEDITOR.add            
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
     <div class="textforget">Add Items To Lookbook</div>     
  </div>
  <div class="createlookblock">
      <div id="contentbox">
           <asp:Repeater runat="server" ID="rptLookbook"  DataSourceID="sdsLookbooks" OnItemDataBound="rptLookbook_ItemDataBound"  >
                    <ItemTemplate>
                       <div class="box1">
                   <div class="loobblock">
                      <div class="dbllook"><a href="itemview1?v=<%# Eval("ItemID") %>" class="fancybox">
                                              <div>
                                        <div class="hover ehover13">
                                            <img class="img-responsive" src="../photobank/<%# Eval("FeatureImg") %>" alt="<%# Eval("Title","{0}") %>" /><div class="overlay">
                                                <h2 class="titlet"><%# Eval("Title","{0}") %></h2>
                                                <h2 class="linenew"></h2>
                                                <h2><asp:Label runat="server" ID="lblDate" Text='<%# Eval("DatePosted") %>'></asp:Label></h2>
                                            </div>
                                            <!--overlay-->
                                        </div>
                                        <!--hover ehover13-->
                                    </div>
                                           </a></div>
                      <div class="smalcress">
                          <asp:CheckBox runat="server" CssClass="booktick chkmeslook" Text="&nbsp" ID="chkItemID"  ></asp:CheckBox>
                          <asp:Label runat="server" Text='<%# Eval("ItemID") %>' ID="SelectedItem" Visible="false"></asp:Label>
                          <%-- <input type="checkbox" id="test30" class="booktick"/><label for="test30" class="chkmeslook"></label> --%>
                      </div>
                      
                     <div class="lookbooktext">
                              <div class="mtextb wrapParagraph" style="width:75%; margin-left:15px;">
                                            <div class="m1">
                                                <div class="muserd"> <a href="itemview1?v=<%# Eval("ItemID") %>" class="fancybox"><%# Eval("Title","{0}") %></div>
                                                <div class="muserdb">By <%# Eval("Name","{0}") %></div>
                                            </div>
                                            <div class="m1" style="word-wrap: break-word;">
                                                <div class="mtextd" id="<%# Eval("ItemID","{0}") %>" ><%# Eval("Description","{0}") %></div>
                                            </div>
                                           
                                        </div>
                     </div><!--lookbooktext--> 
                       <script>
                           var elements = document.getElementsByClassName('mtextd');
                           for (var i = 0; i < elements.length ; i++) {
                               if (elements[i].innerText.length > 50) {
                                   var desc = "";
                                   desc = elements[i].innerText;
                                   desc = desc.substring(0, 50);
                                   document.getElementById(elements[i].id).innerText = desc + " ...";
                               }
                           }
                      </script>
                   </div><!--lookblock-->
                    
                   <div class="lineclook"></div>
               </div>
                      
                        <!--box-->

                    </ItemTemplate>
                    <FooterTemplate>
                         <asp:Label ID="lblEmptyData" style="margin-left: 40%;" runat="server" Visible='<%# ((Repeater)Container.NamingContainer).Items.Count == 0 %>' Text="No items found" />
                     </FooterTemplate>
                </asp:Repeater>
                <asp:SqlDataSource runat="server" ID="sdsLookbooks" ConnectionString='<%$ ConnectionStrings:GvConnection %>' ProviderName='<%$ ConnectionStrings:GvConnection.ProviderName %>' 
                SelectCommand="SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, 
                dbo.Tbl_Brands.Logo, dbo.Tbl_Items.ItemID, dbo.Tbl_Items.Title, 
                ItemKey, dbo.Tbl_Items.Description, dbo.Tbl_Items.FeatureImg, 
                dbo.Tbl_Items.Views, CAST(dbo.Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted, 
                dbo.Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands 
                INNER JOIN dbo.Tbl_Items ON dbo.Tbl_Brands.UserID = dbo.Tbl_Items.UserID
Where dbo.Tbl_Brands.UserID=? AND dbo.Tbl_Items.IsDeleted IS NULL AND dbo.Tbl_Items.IsPublished=1
ORDER BY dbo.Tbl_Items.DatePosted DESC">
                    <SelectParameters>
                          <asp:SessionParameter SessionField="UserID" Name="?"></asp:SessionParameter>
                      </SelectParameters>
                </asp:SqlDataSource>
      </div>
  </div>
  
  
  
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
                                       <div class="del"> <asp:LinkButton runat="server" ID="lbtnDelete" Text="Delete" 
                                       onclick="lbtnDelete_Click" 
                                       onclientclick="redirectToLookbooks()" 
                                       TabIndex="22" ></asp:LinkButton></div>
                               <script>
                                   function redirectToLookbooks() {
                                       location.href = '../brand/profile-page-lookbooks.aspx';
                                   }
                                  </script>
                              <a href="#" id="hidden_link" style="display:none;"></a>

                             <%--  <button type="button" runat="server"  name="login" ID="btnPreview"  class="hvr-sweep-to-rightup2" OnServerClick="btnPreview_OnServerClick"   tabindex="19">Preview</button>--%>
                               <button type="button" runat="server" name="login" ID="btnPublish"  ValidationGroup="gpMain" tabindex="20"
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
                                 <div  class="dropzone" id="dzItemFeatured" tabindex="3">
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
                                      <asp:Image ID="imgFeatured" runat="server" Width="310px"  Height="232px" TabIndex="4"/>
                                  </div>
                                  <div style="position: relative; top: -230px; float:right;">
                                      <asp:Button ID="btnRemove" runat="server" CssClass="btn btn-default btn-xs" 
                                                                            
                                          onclientclick="return confirm('Are you sure,you want to delete ?')" Text="X" 
                                          onclick="btnRemove_Click" TabIndex="5"/>
                                  </div>
                             </div>
                             </ContentTemplate>
                            </asp:updatepanel>
                            <%-- <a href=""><div class="fewer">Remove featured image</div></a>--%>
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
                                      <div id="seedefaultCats" tabindex="6">
                                 <div class="dblock">
                                     <asp:CheckBoxList runat="server" ID="chkCategories" tabindex="21" OnSelectedIndexChanged="chkCategories_SelectedIndexChanged"
                                         DataSourceID="sdsDefaultCats" DataTextField="Title" 
                                         DataValueField="CategoryID" CellPadding="4" CellSpacing="4" 
                                         RepeatColumns="2" Width="100%">
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
                                     CssClass="bmore2" Text="View More" onclick="btn_ViewMore_Click" TabIndex="7"></asp:LinkButton> 
                                 <asp:LinkButton runat="server" CssClass="bmore2" ID="btn_ViewLess" 
                                     Text="See fewer" Visible="False" onclick="btn_ViewLess_Click" TabIndex="8"></asp:LinkButton></div>
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
                                    <div id="seeDefaultSessions" tabindex="9">
                                 <div class="dblock">
                                     <asp:CheckBoxList runat="server" ID="chkDefaultSeasons" OnSelectedIndexChanged="chkDefaultSeasons_SelectedIndexChanged"
                                         DataSourceID="sdsDefaultSeasons" DataTextField="Season" DataValueField="SeasonID">
                                     </asp:CheckBoxList>
                                     <asp:SqlDataSource ID="sdsDefaultSeasons" runat="server"   
                                         ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                         ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                         SelectCommand="SELECT TOP (10) SeasonID, Season FROM Tbl_Seasons ORDER BY Season">
                                     </asp:SqlDataSource>
                                      <asp:SqlDataSource ID="sdsMoreSeasons" runat="server" 
                                         ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                         ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                         SelectCommand="SELECT SeasonID, Season FROM Tbl_Seasons ORDER BY Season">
                                     </asp:SqlDataSource>
                                 </div>
                            
                             </div>
                                    <div class="bmore" runat="server" ID="dvSeasonToggle">
                                        <asp:LinkButton runat="server" ID="btn_MoreSeasons" 
                                     CssClass="bmore" Text="View More" onclick="btn_MoreSeasons_Click"  TabIndex="10"></asp:LinkButton> 
                                 <asp:LinkButton runat="server" CssClass="bmore" ID="btn_LessSeasons" 
                                     Text="See fewer" Visible="False" onclick="btn_LessSeasons_Click" TabIndex="11"></asp:LinkButton></div>
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
                             <div id="seeDefaultHoliday" tabindex="12">
                                 <div class="dblock">
                                     <asp:CheckBoxList runat="server" ID="chkDefaultHoliday" OnSelectedIndexChanged="chkDefaultHoliday_SelectedIndexChanged" 
                                         DataSourceID="sdsDefaultHoliday" DataTextField="Title" DataValueField="HolidayID">
                                     </asp:CheckBoxList>
                                     
                                     <asp:SqlDataSource ID="sdsDefaultHoliday" runat="server" 
                                         ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                         ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                         SelectCommand="SELECT TOP (10) HolidayID, Title FROM Tbl_Holidays ORDER BY Title">
                                     </asp:SqlDataSource>
                                    
                                      <asp:SqlDataSource ID="sdsMoreHoliday" runat="server" 
                                         ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                         ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                         SelectCommand="SELECT HolidayID, Title FROM Tbl_Holidays ORDER BY Title">
                                     </asp:SqlDataSource>
                                 </div>
                            
                             </div>
                             <div class="bmore3">
                                        <asp:LinkButton runat="server" ID="btn_MoreHolidays" 
                                     CssClass="bmore3" Text="View More" onclick="btn_MoreHolidays_Click"  TabIndex="13"></asp:LinkButton> 
                                 <asp:LinkButton runat="server" CssClass="bmore3" ID="btn_LessHolidays" 
                                     Text="See fewer" Visible="False" onclick="btn_LessHolidays_Click"  TabIndex="14"></asp:LinkButton></div>
                           </ContentTemplate>
                             </asp:updatepanel>
                         
                         </div><!--search-->
                         
                  </div><!--colmd12-->
                  <div class="dissp"></div>       
                  
                  
          <!--tags-->
                 <%-- <div class="col-md-12 discrigblock">
                      <asp:updatepanel runat="server" ID="up_Tags">
                          <ContentTemplate>
                              <div class="searchb">
                             <div class="serheading" style="margin-bottom:20px;">Related Tags</div> 
                            <asp:Panel runat="server" DefaultButton="btnAddTag">
                             <div class="searchsm">
                                 <div class="searctext"><input type="text" runat="server" name="search" ID="txtTag" placeholder="" value="" class="sein1" tabindex="15" /></div>
                                 <div class="searcadd">
                                   <asp:Button  runat="server" name="login" ID="btnAddTag" ValidationGroup="gpTags" OnClick="btnAddTag_OnServerClick" class="hvr-sweep-to-right3" Text="Add" TabIndex="16"></asp:Button></div>
                                    <asp:RequiredFieldValidator ID="RfvTags" runat="server" 
                                     ErrorMessage="This field is required" ControlToValidate="txtTag" 
                                     ValidationGroup="gpTags"></asp:RequiredFieldValidator>
                             </div>
                             </asp:Panel>
                             <div class="smalltext">Separate tags with commas</div>
                             <asp:Repeater runat="server" ID="rptTags" DataSourceID="sdsTags">
                                 <ItemTemplate>
                                     <div class="tagblock"><a href=""><i class="fa fa-times-circle-o"></i> <%# Eval("Title") %></a></div>
                                 </ItemTemplate>
                             </asp:Repeater>
                                  <asp:SqlDataSource ID="sdsTags" runat="server" 
                                      ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                      ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                      
                                      SelectCommand="SELECT Top 5 [TagID], [Title] FROM [Tbl_LbTags]  Where LookID=?  ORDER BY [TagID]">
                                      <SelectParameters>
                                          <asp:QueryStringParameter QueryStringField="v" Name="LookID" Type="Int32"/>
                                      </SelectParameters>

                                  </asp:SqlDataSource>
                                   <asp:SqlDataSource ID="sdsMoreTags" runat="server" 
                                      ConnectionString="<%$ ConnectionStrings:GvConnection %>" 
                                      ProviderName="<%$ ConnectionStrings:GvConnection.ProviderName %>" 
                                      
                                      SelectCommand="SELECT Top 10 [TagID], [Title] FROM [Tbl_LbTags] Where LookID=?  ORDER BY [TagID]">
                                      <SelectParameters>
                                          <asp:QueryStringParameter QueryStringField="v" Name="LookID" Type="Int32"/>
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                         </div>
                          <div class="fewer" runat="server" ID="dvTagToggles">
                              <asp:LinkButton runat="server" ID="btn_MoreTags" 
                                     CssClass="fewer" Text="View More" onclick="btn_MoreTags_Click" TabIndex="17"></asp:LinkButton> 
                                 <asp:LinkButton runat="server" CssClass="fewer" ID="btn_LessTags" 
                                     Text="See fewer" Visible="False" onclick="btn_LessTags_Click" TabIndex="18"></asp:LinkButton></div>
                          </ContentTemplate>
                      </asp:updatepanel>
                         <!--search-->
                         
                  </div><!--colmd12-->--%>
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
<!--#INCLUDE FILE="../includes/backtotop.txt" -->
<script src="../js/backtotop.js" type="text/javascript"></script>
</div><!--wrapper-->

    <script type="application/javascript" src="../js/custom.js"></script>
     <script src="../js/bootstrap-colorpicker.min.js"></script>
    <script src="../js/bootstrap-colorpicker-plus.js"></script>
   <script src="../js/colorPicker.min.js" type="text/javascript"></script>
<script type="text/javascript">
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
                    //                    alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
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
                    //                    alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXhr.status + " jqXHR Response Text:" + jqXhr.responseText);
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
