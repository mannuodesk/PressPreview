$(document).ready(function () {
    $("#lbViewMessageCount").mouseover(function () {
        var userId = '<%= Request.Cookies["FRUserId"].Value %>';
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
});