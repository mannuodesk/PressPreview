using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;
using System;
using System.Collections;
using System.Data.SqlClient;

public partial class frmlogin : System.Web.UI.Page
{
    static readonly string MailSenderAddress = System.Configuration.ConfigurationManager.AppSettings["SenderEmail"];
    protected void Page_Load(object sender, EventArgs e)
    {
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        txtOldPassword.Focus();
        if (Common.Getunread_Messages() > 0)
        {
            lblTotalMessages.Visible = true;
            lblTotalMessages.Text = Common.Getunread_Messages().ToString();
        }

        if (Common.Getunread_Alerts() > 0)
        {
            lblTotalNotifications.Visible = true;
            lblTotalNotifications.Text = Common.Getunread_Alerts().ToString();
        }
       
        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
    }

    protected void btnSignUp_ServerClick(object sender, EventArgs e)
    {

    }
    private bool isPasswordCorrect(string password)
    {
        var httpCookie = Request.Cookies["FrUserID"];

        var db = new DatabaseManagement();
        if (httpCookie != null)
        {
            string getUserPassword = string.Format("SELECT U_Password From Tbl_Users Where UserID={0}",
                                               IEUtils.ToInt(httpCookie.Value));
            SqlDataReader dr = db.ExecuteReader(getUserPassword);
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    string passwordFromDB = dr["U_Password"].ToString();
                    if (passwordFromDB == password)
                    {
                        return true;
                    }
                    return false;
                }
            }
        }
        return false;
    }
    protected void btnChangePass_OnServerClick(object sender, EventArgs e)
    {
        try
        {
            if (isPasswordCorrect(txtOldPassword.Value))
            {
                var httpCookie = Request.Cookies["FrUserID"];
                var db = new DatabaseManagement();
                if (httpCookie != null)
                {
                    string updateUserPassword = string.Format("Update Tbl_Users set U_Password={0} Where UserID={1}",
                                                       IEUtils.SafeSQLString(txtSignUpPassword.Value), IEUtils.ToInt(httpCookie.Value));
                    db.ExecuteSQL(updateUserPassword);
                }
                Response.Redirect("profile-page-items.aspx");
            }
            else
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "Old Password Not Correct", divAlerts);
            }
        }
        catch (Exception exc)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, exc.Message, divAlerts);
        }
        
    }

    // Top menu message list binding
    protected void rptMessageList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblDatePosted = (Label)e.Item.FindControl("lblDate");
                // Label lblDate2 = (Label)e.Item.FindControl("lblDate2");
                DateTime dbDate = Convert.ToDateTime(lblDatePosted.Text);
                lblDatePosted.Text = Common.GetRelativeTime(dbDate);

            }


        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void rptMessageList_ItemCommand(object sender, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "2")
            {
                string[] messageIDs = e.CommandArgument.ToString().Split(',');
                var parentIDCookie = new HttpCookie("ParentId") { Value = messageIDs[0] };
                HttpContext.Current.Response.Cookies.Add(parentIDCookie);
                var messageIDCookie = new HttpCookie("MessageId") { Value = messageIDs[1] };
                HttpContext.Current.Response.Cookies.Add(messageIDCookie);

                var db = new DatabaseManagement();

                // update the status of the message to read
                db.ExecuteSQL(string.Format("Update Tbl_Mailbox Set MessageStatus={0} Where ParentID={1}",
                                            IEUtils.SafeSQLString("read"), IEUtils.ToInt(messageIDs[1])));
                Response.Redirect("massenger.aspx");
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    [WebMethod, ScriptMethod]
    public static void UpdateMessageStatus(string userID)
    {
        var db = new DatabaseManagement();
        string insertQuery = string.Format("UPDATE Tbl_MailboxFor Set ReadStatus={0} Where ReceiverID={1}",
                                           1, IEUtils.ToInt(userID));
        db.ExecuteSQL(insertQuery);


    }

    protected void rptNotifications_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var lblDatePosted = (Label)e.Item.FindControl("lblDatePosted");
                DateTime dbDate = Convert.ToDateTime(lblDatePosted.Text);
                lblDatePosted.Text = Common.GetRelativeTime(dbDate);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    [WebMethod, ScriptMethod]
    public static void UpdateNotifications(string userID)
    {
        var db = new DatabaseManagement();
        string insertQuery = string.Format("UPDATE Tbl_NotifyFor Set ReadStatus={0} Where RecipID={1}",
                                           1, IEUtils.ToInt(userID));
        db.ExecuteSQL(insertQuery);

    }


}