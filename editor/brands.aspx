<%@ Page Language="C#" AutoEventWireup="true"  EnableViewStateMac="false" CodeFile="brands.aspx.cs" Inherits="home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Brands List</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>

<script src="../js/sample.js"></script>
<script type="text/javascript">
    var $ = jQuery.NoConflict();
    jQuery(document).ready(function () {
        jQuery('.fancybox').fancybox();
    });
	</script>   

     
    <style type="text/css">
        .alphbets
        {
            margin:0 auto; padding: 0 10px; cursor: pointer; display: inline; color: #212121;
        }
        .alphbets:active
        {
           font-weight:bold;
        }
            .wrapper-setting {
                margin: 0 auto !IMPORTANT;
    background-color: #ffffff !IMPORTANT;
    width: 85% !important;
    float: none;
    overflow: hidden;
        }
    </style>
</head>

<body>
<form runat="server" id="frmBrands">
      <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
     
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
                      
         <div class="col-md-2"  style="color:white;">   
            <!--#INCLUDE FILE="../includes/messgTopInfluencer.txt" --> 
         </div>   
                       
            <ul class="nav navbar-nav" id="firstbb">
              <li><a href="Default.aspx">Activity</a></li>
              <li><a href="discover.aspx">Discover</a></li>
              <li class="active"><a href="brands.aspx">Brands</a></li>
               <li><a href="events.aspx">Events</a></li>
            </ul>            
             
             <!--#INCLUDE FILE="../includes/influencer_settings.txt" -->  
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>

    </div><!--header bg-->
<!--Headerend-->

<!--Banner-->
     <!--#INCLUDE FILE="../includes/banner.txt" --> 
<!--bannerend-->


<!--text-->
<div class="wrapper wrapper-setting">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <div id="dvLoading"></div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <script type="text/javascript" language="javascript">
                function pageLoad() {
                    setTimeout(function () { $('#divAlerts').fadeOut(); }, 4000);
                }
        </script>
            <div class="col-md-12">
                <div id="divAlerts" runat="server" class="alert" visible="False">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                        Text="" Visible="True"></asp:Label>
                </div>
                <div class="starter-template">
                    <h6>BRAND</h6>
                    <h1>The List</h1>
                    <div class="sline">
                        <img src="../images/line.png" /></div>
                </div>
            </div>
            <div class="col-md-12 col-xs-12">
           <div style="width: 100%; text-align: center;">
                    
               <a onclick="Alphabet_Click('ALL');" id="alpha_ALL" style="text-decoration:underline;pointer-events:none" class="alphbets">ALL</a>
               <a onclick="Alphabet_Click('A');" id="alpha_A"  class="alphbets">A</a>
               <a onclick="Alphabet_Click('B');" id="alpha_B"  class="alphbets">B</a>
               <a onclick="Alphabet_Click('C');" id="alpha_C"  class="alphbets">C</a>
               <a onclick="Alphabet_Click('D');" id="alpha_D"  class="alphbets">D</a>
               <a onclick="Alphabet_Click('E');" id="alpha_E"  class="alphbets">E</a>
               <a onclick="Alphabet_Click('F');" id="alpha_F"  class="alphbets">F</a>
               <a onclick="Alphabet_Click('G');" id="alpha_G"  class="alphbets">G</a>
               <a onclick="Alphabet_Click('H');" id="alpha_H"  class="alphbets">H</a>
               <a onclick="Alphabet_Click('I');" id="alpha_I"  class="alphbets">I</a>
               <a onclick="Alphabet_Click('J');" id="alpha_J"  class="alphbets">J</a>
               <a onclick="Alphabet_Click('K');" id="alpha_K"  class="alphbets">K</a>
               <a onclick="Alphabet_Click('L');" id="alpha_L"  class="alphbets">L</a>
               <a onclick="Alphabet_Click('M');" id="alpha_M"  class="alphbets">M</a>
               <a onclick="Alphabet_Click('N');" id="alpha_N"  class="alphbets">N</a>
               <a onclick="Alphabet_Click('O');" id="alpha_O"  class="alphbets">O</a>
               <a onclick="Alphabet_Click('P');" id="alpha_P"  class="alphbets">P</a>
               <a onclick="Alphabet_Click('Q');" id="alpha_Q"  class="alphbets">Q</a>
               <a onclick="Alphabet_Click('R');" id="alpha_R"  class="alphbets">R</a>
               <a onclick="Alphabet_Click('S');" id="alpha_S"  class="alphbets">S</a>
               <a onclick="Alphabet_Click('T');" id="alpha_T"  class="alphbets">T</a>
               <a onclick="Alphabet_Click('U');" id="alpha_U"  class="alphbets">U</a>
               <a onclick="Alphabet_Click('V');" id="alpha_V"  class="alphbets">V</a>
               <a onclick="Alphabet_Click('W');" id="alpha_W"  class="alphbets">W</a>
               <a onclick="Alphabet_Click('X');" id="alpha_X"  class="alphbets">X</a>
               <a onclick="Alphabet_Click('Y');" id="alpha_Y"  class="alphbets">Y</a>
               <a onclick="Alphabet_Click('Z');" id="alpha_Z"  class="alphbets">Z</a>
                </div>
               
            </div>
            <!--col-md-12-->

            <!--text-->
            <!-- START THE BRANDS LIST -->
            <div class="col-md-12" id="letter2">
                <script>
                    var pageIndex = 0;
                    var tempcount = 0;
                    var selectedAlphabet;
                    function Alphabet_Click(alphabet) {
                        pageIndex = 0;
                       tempcount = 0;
                        selectedAlphabet = alphabet;
                        $("#dlBrands").html("");
                        $(".alphbets").css("pointer-events", "all");
                        $(".alphbets").css("text-decoration", "none");
                        $("#alpha_" + alphabet).css("pointer-events", "none");
                        $("#alpha_" + alphabet).css("text-decoration", "underline");
                        GetRecords(alphabet);
                       
                    }
                 
                    $(window).load(function () {
                        selectedAlphabet = "ALL";
                        GetRecords("ALL");
                    });

                    function GetRecords(alphabet) {
                        pageIndex++;
                        if (alphabet == "ALL") {
                            $("#lblView").html("All Brands.");
                        }
                        else {
                            $("#lblView").html("Brands whose name starts with " + alphabet);
                        }
                        //send a query to server side to present new content
                        $.ajax({
                            type: "POST",
                            url: "brands.aspx\\GetData",
                            //data: '{pageIndex: ' + pageIndex + '}',
                            data: '{pageIndex: ' + pageIndex + ', alphabet:"' + alphabet + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnSuccess
                        });


                    }

                    function OnSuccess(data, cb) {
                        console.log(data);
                        var items = data.d;
                        var fragment = "";
                        if (items.length != 0) {
                          
                            $.each(items, function (index, val) {
                                fragment = "<div class='col-md-4' style='margin-bottom: 10px;'><a class='fancybox stylingAhref' href='brand-items.aspx?v=" + val.userKey + "'>" + val.name + "</a></div>";

                                $("#dlBrands").append(fragment);

                            });
                        }

                    }
                    $(window).scroll(function () {
                        if ($(window).scrollTop() == $(document).height() - $(window).height()) {
                            GetRecords(selectedAlphabet);
                        }
                    });
                    //$(".alphbets").click(function () {
                    //    //window.location.reload();
                    //});
                </script>
                <div style="width: 80%; margin: 0 auto;">
                     <div class="starter-template">
                    <h6><asp:Label ID="lblView" runat="server" Text=""></asp:Label></h6>
                   <div class="sline">
                        <img src="../images/line.png" /></div>
                </div>
                    <style>
                     .stylingAhref{
                            line-height: 30px;
    color: #000;
    font-size: 16px;
    letter-spacing: 2px;
             font-family: Raleway-Bold;
             text-transform: capitalize;
                        }
                     .stylingAhref:hover{
                             font-family: Raleway-Medium;
    text-decoration: none;
    color: #000;
}

                    </style>

                    <div id="dlBrands" class="col-md-12" style="margin-bottom: 50px;text-align: center;">
                    </div>

                    <%--<table id="dlBrands" class="brandlist" cellspacing="0" border="0" style="width:100%;border-collapse:collapse;">
		<tbody>
	</tbody></table>--%>






                  
         <%--           <asp:DataList ID="dlBrands" runat="server" CssClass="brandlist" RepeatColumns="3" Width="100%">
                        <ItemTemplate>
                            <ul>
                                <li><a class="fancybox" href="brand-items.aspx?v=<%# Eval("UserKey") %>"><%# Eval("Name","{0}") %></a></li>
                            </ul>
                        </ItemTemplate>
                    </asp:DataList>--%>
                </div>
                <!--col-md-6-->
                <!--col-md-6-->

            </div>
            <!--col-md-12-->
            <!-- /END THE BRANDS LIST -->
        </ContentTemplate>
    </asp:UpdatePanel>   
</div><!--wrapperblock-->
<!--footer-->
  <div class="footerbg">
     <div class="row">
       <div class="col-md-11 col-xs-10">©<%: DateTime.Now.Year %> Press Preview</div>
        <div class="col-md-pull-1 col-xs-pull-1">
           <div class="f1"><a id="loaddata"></a></div>
           <div class="f2"></div>
        </div>
      </div>    
  </div><!--footer-->
<!--footer-->
<!--#INCLUDE FILE="../includes/backtotop.txt" -->
<script src="../js/backtotop.js" type="text/javascript"></script>
</div><!--wrapper-->

<script src="../js/bootstrap.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        var userId = '<%= Request.Cookies["FRUserId"].Value %>';
        $("#lbViewMessageCount").mouseover(function () {

            $.ajax({
                type: "POST",
                url: "brands.aspx\\UpdateMessageStatus",
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
