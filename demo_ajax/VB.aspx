﻿<%@ Page Language="VB" AutoEventWireup="false" CodeFile="VB.aspx.vb" Inherits="VB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type = "text/css">
        body
        {
            font-family:Arial;
            font-size:10pt;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                Username:
            </td>
            <td>
                <asp:TextBox ID="txtUsername" runat="server" Text="" />
            </td>
        </tr>
        <tr>
            <td>
                Password:
            </td>
            <td>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button ID="btnSave" Text="Save" runat="server" />
            </td>
        </tr>
    </table>
    <hr />
    <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="false" HeaderStyle-BackColor="#3AC0F2"
        HeaderStyle-ForeColor="White" RowStyle-BackColor="#A1DCF2">
        <Columns>
            <asp:BoundField DataField="Username" HeaderText="Username" />
            <asp:BoundField DataField="Password" HeaderText="Password" />
        </Columns>
    </asp:GridView>
    </form>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://cdn.jsdelivr.net/json2/0.1/json2.js"></script>
    <script type="text/javascript">
        $(function () {
            $("[id*=btnSave]").bind("click", function () {
                var user = {};
                user.Username = $("[id*=txtUsername]").val();
                user.Password = $("[id*=txtPassword]").val();
                $.ajax({
                    type: "POST",
                    url: "VB.aspx/SaveUser",
                    data: '{user: ' + JSON.stringify(user) + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        alert("User has been added successfully.");
                        window.location.reload();
                    }
                });
                return false;
            });
        });
    </script>
</body>
</html>
