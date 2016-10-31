<%@ Page Language="C#" AutoEventWireup="true" CodeFile="logout.aspx.cs" Inherits="admin_logout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="js/jquery.min.js"></script>
   <script type="text/javascript">  
jQuery(function()  
{  
//debugger;  
    $("table[id$='GridView1'] [id*=lnkFirstName]").live('click', function (event) {
        
        $("table[id$='GridView1'] [id*=lblLastName]").closest('tr').find("[id *= lblLastName]").html("Value Changed");
        e.preventDefault();
    });
});  
</script>  
    <style type="text/css">
        .hide { display:none;}
    </style>
<script type="text/javascript">
    $(document).ready(function () {
        CheckingSeassion();
    });
    function CheckingSeassion() {
        $.ajax({
            type: "POST",
            url: "logout.aspx/LogoutCheck",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d == 0) {
                    window.location = "http://presspreview.azurewebsites.net/login.aspx";
                }
            },
            failure: function (msg) {
                alert(msg);
            }
        });
    }
 </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
                        </asp:ScriptManager>
    <div>
     </div>  
    </form>
</body>
</html>
