<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="home_Default" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>::TCO Karachi::</title>
    <link href="../styles/common.css" rel="stylesheet" type="text/css" />
     <link href="../nivoResources/nivo-slider.css" rel="stylesheet" type="text/css" />  
    <link href="source/jquery.fancybox.css" rel="stylesheet" type="text/css" />
    <link href="source/helpers/jquery.fancybox-buttons.css" rel="stylesheet"
        type="text/css" />
    <link href="source/helpers/jquery.fancybox-thumbs.css" rel="stylesheet"
        type="text/css" />
    <script src="source/helpers/jquery.fancybox-media.js" type="text/javascript"></script>
    <script src="source/helpers/jquery.fancybox-buttons.js" type="text/javascript"></script>
    <script src="source/helpers/jquery.fancybox-thumbs.js" type="text/javascript"></script>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
   
</head>
<body>
    
    <form id="form1" runat="server">
    <div id="menubar">
         <div class="menu">
                    <ul>
                        <li><a href="../home/" ><span>Home</span></a></li>
                        <li><a href="../about/"><span>About Us</span></a></li>
                        <li><a href="../projects/"><span>Projects</span></a></li>
                        <li><a href="../downloads/" ><span>Downloads</span></a></li>
                        <li><a href="../publications/"><span>Publications</span></a></li>
                        <li><a href="../notifications/"><span>Notifications</span></a></li>
                        <li><a href="../contact/"><span>Contact Us</span></a></li>
                        <li><a href="../gallary/" class="current"><span>Gallery</span></a></li>
                    </ul>
                </div>
    </div>
    <div id="menubar2">
        <div class="submenu">
            <img src="../images/gop1.png" style="width:70px; height:70px; float:left; position:relative; left:-4px " alt="gop"/>
             <div class="ThreeDLogo">Textile Commissioner's Organization</div> 
             <div class=ThreeDText> Government of Pakistan</div>
             
        </div>
    </div>
    <div id="wrapper">
        <div id="header">
           <!--#INCLUDE FILE="../includes/slider.txt" -->
        </div>
        <div id="newsbar">
            <span style="position:relative; top:5px; left:10px;">You are here : 
            <asp:Label ID="lblsyndicate" runat="server" CssClass="current" Text="Downloads" 
                Font-Bold="True" ForeColor="#66CC33"></asp:Label></span>
           
           <!--#INCLUDE FILE="../includes/marqhor.txt" --> 
        </div>
        <div style="height:8px;"></div>
        <div id="content">
            <div id="leftcolumn">
                <div class="smalltab">
                    <div class="tabheader"> <h4><span style="position:relative; top:-10px; left:8px;">News & Events </span></h4> </div>
                    <div class="tabbody">
                        <!--#INCLUDE FILE="../includes/marq.txt" -->
                    </div>
                </div>
                <div class="space"></div>
                  <div class="smalltab">
                    <div class="tabheader"> <h4><span style="position:relative; top:-10px; left:8px;">Visitor's Count </span></h4> </div>
                    <div class="tabbody">
                        <!--#INCLUDE FILE="../includes/Counter.txt" -->
                    </div>
                </div>
            </div>
            <div id="centercolumn">
                 <div class="largetab">
                    <div class="tabheader"> <h4><span style="position:relative; top:-10px; left:8px;">
                        <asp:Label ID="lblMessageHeading" runat="server" Text="GALLERY"></asp:Label> </span></h4> </div>
                    <div class="tabbody">
                        <br />
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                            BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
                            CellPadding="4" DataKeyNames="GallaryID" DataSourceID="sdsgallary" 
                            EnableModelValidation="True" ForeColor="Black" GridLines="Horizontal" 
                            onrowdatabound="GridView1_RowDataBound" ShowHeader="False" Width="100%">
                            <Columns>
                                <asp:TemplateField HeaderText="G_Title" SortExpression="G_Title">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("G_Title") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <table cellpadding="1" class="style1" cellspacing="1">
                                            <tr>
                                                <td align="left" valign="middle" width="70%">
                                                    <asp:Label ID="lblGid" runat="server" Text='<%# Eval("GallaryID", "{0}") %>' 
                                                        Visible="False"></asp:Label>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("G_Title") %>'></asp:Label>
                                                </td>
                                                <td align="center" valign="middle" width="30%">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="2" style="width: 100%" valign="middle" width="70%">
                                                    <hr />
                                                    <asp:DataList ID="dtlstImageGallery" runat="server" repeatcolumns="4" 
                                                        Width="100%">
                                                        <ItemTemplate>
                                                            <table cellpadding="2" width="104px">
                                                                <tr>
                                                                    <td width="100%">
                                                                        <a class="fancybox" href='<%# Eval("ImageName","{0}") %>' rel="group">
                                                                        <img src="<%# Eval("ImageThumbnail","{0}") %>" alt="" style="width: 100px;"/>
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <EmptyDataTemplate>
                                <br />
                                <br />
                                <span class="errorText">No photogallary image found.<br />
                                <br />
                                </span>
                                <br />
                            </EmptyDataTemplate>
                            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsgallary" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:CsGridview %>" 
                            ProviderName="<%$ ConnectionStrings:CsGridview.ProviderName %>" 
                            SelectCommand="SELECT [GallaryID], [G_Title], [DatePosted] FROM [Tbl_Photogallary] ORDER BY [GallaryID] DESC">
                        </asp:SqlDataSource>
                                                    <asp:SqlDataSource ID="sdsimages" runat="server" 
                                                        ConnectionString="<%$ ConnectionStrings:CsGridview %>" 
                                                        ProviderName="<%$ ConnectionStrings:CsGridview.ProviderName %>" 
                                                        
                                                        
                            
                            SelectCommand="SELECT [ImgID], [ImageName], [ImageThumbnail] FROM [Tbl_Gallaryimages] ">
                                                    </asp:SqlDataSource>
                        <br />
&nbsp;</div>
                </div>
                <div class="space"></div>
                
                
            </div>
            <div id="rightcolumn">
                <!--#INCLUDE FILE="../includes/registration.txt" -->
                 <div class="space"></div>
                <div class="smalltab">
                    <div class="tabheader"> <h4><span style="position:relative; top:-10px; left:8px;">Related Links </span></h4> </div>
                    <div class="tabbody">
                         <table cellpadding="2" class="tableStyle2">
                            <tr>
                                <td align="left" valign="middle" width="100%">
                            <asp:DataList ID="DataList4" runat="server" DataKeyField="Link_Title" 
                            DataSourceID="SdRelatedLinks" Width="100%" RepeatColumns="1">
                            <ItemTemplate>
                               <div class="vrmenu">
                                   <ul>
                                    <li><asp:HyperLink ID="HyperLink1" runat="server" 
                                        NavigateUrl='<%# Eval("Link_URL", "{0}") %>' Target="_blank" 
                                        Text='<%# Eval("Link_Title", "{0}") %>'></asp:HyperLink></li>
                                    </ul> 
                               </div>
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="SdRelatedLinks" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:CsGridview %>" 
                            ProviderName="<%$ ConnectionStrings:CsGridview.ProviderName %>" 
                            SelectCommand="SELECT [Link_Title], [Link_URL], [Link_Id] FROM [Tbl_Related_Links] ORDER BY [Link_PostDate]">
                        </asp:SqlDataSource>
                    
                                 </td>
                            </tr>
                          </table>
                    </div>
                </div>
                 
            </div>
        </div>
        
        <div style="height: 10px; clear:both;">&nbsp;</div>
    </div>
    
    <div id="footer">Copyright © 2012. All rights reserved.</div>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="lib/jquery.mousewheel-3.0.6.pack.js" type="text/javascript"></script>
  <script type="text/javascript" src="../nivoResources/jquery.nivo.slider.js"></script>
    <script src="source/jquery.fancybox.js" type="text/javascript"></script>
    <script src="source/jquery.fancybox.pack.js" type="text/javascript"></script>
  <script type="text/javascript">
      $(window).load(function () {
          $('#slider').nivoSlider();
      });

      $(document).ready(function () {
          $(".fancybox").fancybox();
      });
  </script>
    </form>
</body>
</html>
