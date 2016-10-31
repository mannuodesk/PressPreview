using System.Collections.Specialized;
using System.Linq;
using System.Web.UI.HtmlControls;
using DLS.DatabaseServices;
using System;
using System.Collections;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;


public partial class admin_home_Default : System.Web.UI.Page
{
  
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                if (Common.Getunread_Alerts() > 0)
                {
                    lblTotalNotifications.Visible = true;
                    lblTotalNotifications.Text = Common.Getunread_Alerts().ToString();
                }
                var alCommonControls = new ArrayList { lblUsername, imgUserphoto };
             //   Common.AdminSettings(alCommonControls);
               
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Default.aspx");
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void grdNotifications_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var lblDatePosted = (Label)e.Row.FindControl("lblDatePosted");
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
    protected void grdInbox_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblDatePosted = (Label)e.Row.FindControl("lblDate");
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
    protected void grdInbox_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if(e.CommandName=="2")
            {
                int messageId = Convert.ToInt32(e.CommandArgument);
                var db=new DatabaseManagement();
                string deleteQuery = string.Format("Delete From Tbl_Mailbox Where MessageID={0}", messageId);
                db.ExecuteSQL(deleteQuery);
                grdInbox.DataBind();
                db._sqlConnection.Close();
                db._sqlConnection.Dispose();
                ErrorMessage.ShowSuccessAlert(lblStatus,"Message deleted",divAlerts);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void chkAll2_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (chkAllInbox.SelectedValue == "0")
            {
                foreach (GridViewRow row in grdInbox.Rows)
                {
                    CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                    chkSelect.Checked = true;
                }
            }
            else
            {
                foreach (GridViewRow row in grdInbox.Rows)
                {
                    CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                    chkSelect.Checked = false;
                }
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void DoAction(StringCollection idsCollection, string commandName,GridView grdview)
    {
        try
        {
            string ids = idsCollection.Cast<string>().Aggregate(string.Empty, (current, id) => current + (id + ","));
            ids = ids.Substring(0, ids.LastIndexOf(","));
            var db = new DatabaseManagement();
            string query = string.Empty;
            switch (commandName)
            {
                case "A":
                    query = string.Format("Update Tbl_Mailbox Set MessageType='A' WHERE MessageID IN (" + ids + ")");
                    break;
                case "S":
                    query = string.Format("Update Tbl_Mailbox Set MessageType='S' WHERE MessageID IN (" + ids + ")");
                    break;
                case "D":
                    query = string.Format("Delete From  Tbl_Mailbox  WHERE MessageID IN (" + ids + ")");
                    break;
                case "I":
                    query = string.Format("Update Tbl_Mailbox Set MessageType=NULL WHERE MessageID IN (" + ids + ")");
                    break;
            }
            db.ExecuteSQL(query);
            grdview.DataBind();
          db._sqlConnection.Close();
            db._sqlConnection.Dispose();
        }
        catch (ArgumentOutOfRangeException ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, "No record is selected. You must select atleast one record. ", divAlerts);
        }
    }
    private StringCollection GetSelectedIDs(GridView grdview)
    {
        var idCollection = new StringCollection();
        foreach (GridViewRow row in grdview.Rows)
        {
            var chkSelect = (HtmlInputCheckBox)row.FindControl("chkSelect");
            if (chkSelect.Checked)
            {
                var lbtnMessage = (LinkButton)row.FindControl("lbtnMessage");
                string[] messageIDs = lbtnMessage.CommandArgument.Split(',');
                idCollection.Add(messageIDs[1]);
            }
        }
        return idCollection;
    }
    protected void btnDeleteAll_OnClick(object sender, EventArgs e)
    {
        var idCollection = GetSelectedIDs(grdInbox);
        DoAction(idCollection, "D",grdInbox);
    }

    protected void chkAllOutbox_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (chkAllOutbox.SelectedValue == "0")
            {
                foreach (GridViewRow row in grdOutbox.Rows)
                {
                    CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                    chkSelect.Checked = true;
                }
            }
            else
            {
                foreach (GridViewRow row in grdOutbox.Rows)
                {
                    CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                    chkSelect.Checked = false;
                }
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void btnDeleteAllOutbox_OnClick(object sender, EventArgs e)
    {
        var idCollection = GetSelectedIDs(grdOutbox);
        DoAction(idCollection, "D", grdOutbox);
    }
    protected void grdOutbox_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblDatePosted = (Label)e.Row.FindControl("lblDate");
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

    protected void grdOutbox_OnRowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "2")
            {
                int messageId = Convert.ToInt32(e.CommandArgument);
                var db = new DatabaseManagement();
                string deleteQuery = string.Format("Delete From Tbl_Mailbox Where MessageID={0}", messageId);
                db.ExecuteSQL(deleteQuery);
                grdOutbox.DataBind();
                db._sqlConnection.Close();
                db._sqlConnection.Dispose();
                ErrorMessage.ShowSuccessAlert(lblStatus, "Message deleted", divAlerts);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void chkAllArchive_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (chkAllArchive.SelectedValue == "0")
            {
                foreach (GridViewRow row in grdArchive.Rows)
                {
                    CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                    chkSelect.Checked = true;
                }
            }
            else
            {
                foreach (GridViewRow row in grdArchive.Rows)
                {
                    CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                    chkSelect.Checked = false;
                }
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void btnDeleteAllArchive_OnClick(object sender, EventArgs e)
    {
        var idCollection = GetSelectedIDs(grdOutbox);
        DoAction(idCollection, "D", grdArchive);
    }


    protected void grdArchive_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblDatePosted = (Label)e.Row.FindControl("lblDate");
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

    protected void grdArchive_OnRowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "2")
            {
                int messageId = Convert.ToInt32(e.CommandArgument);
                var db = new DatabaseManagement();
                string deleteQuery = string.Format("Delete From Tbl_Mailbox Where MessageID={0}", messageId);
                db.ExecuteSQL(deleteQuery);
                grdArchive.DataBind();
                db._sqlConnection.Close();
                db._sqlConnection.Dispose();
                ErrorMessage.ShowSuccessAlert(lblStatus, "Message deleted", divAlerts);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void chkAllSpam_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (chkAllArchive.SelectedValue == "0")
            {
                foreach (GridViewRow row in grdSpam.Rows)
                {
                    CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                    chkSelect.Checked = true;
                }
            }
            else
            {
                foreach (GridViewRow row in grdSpam.Rows)
                {
                    CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                    chkSelect.Checked = false;
                }
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void btnDeleteAllSpam_OnClick(object sender, EventArgs e)
    {
        var idCollection = GetSelectedIDs(grdOutbox);
        DoAction(idCollection, "D", grdSpam);
    }

    protected void grdSpam_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblDatePosted = (Label)e.Row.FindControl("lblDate");
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

    protected void grdSpam_OnRowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "2")
            {
                int messageId = Convert.ToInt32(e.CommandArgument);
                var db = new DatabaseManagement();
                string deleteQuery = string.Format("Delete From Tbl_Mailbox Where MessageID={0}", messageId);
                db.ExecuteSQL(deleteQuery);
                grdSpam.DataBind();
                db._sqlConnection.Close();
                db._sqlConnection.Dispose();
                ErrorMessage.ShowSuccessAlert(lblStatus, "Message deleted", divAlerts);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
}