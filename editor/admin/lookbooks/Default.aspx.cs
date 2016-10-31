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
            var alCommonControls = new ArrayList { lblUsername, imgUserphoto };
            Common.AdminSettings(alCommonControls);
            if (!IsPostBack)
            {
                if (Common.Getunread_Alerts() > 0)
                {
                    lblTotalNotifications.Visible = true;
                    lblTotalNotifications.Text = Common.Getunread_Alerts().ToString();
                }
                
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if(e.CommandName=="2")
            {
                int RecordID = Convert.ToInt32(e.CommandArgument);
                var db = new DatabaseManagement();
                String deleteQuery = string.Format("Update Tbl_Lookbooks Set IsDeleted='1'  Where LookID={0}", RecordID);
                db.ExecuteSQL(deleteQuery);
               GridView1.DataBind();
                ErrorMessage.ShowSuccessAlert(lblStatus, "Lookbook Deleted", divAlerts);
            }
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
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // get lookID of the row
                int lookID = Convert.ToInt32(((Label)e.Row.FindControl("lblLookID")).Text);
                var lblTotal = (Label)e.Row.FindControl("lblTotal");
                var db = new DatabaseManagement();
                lblTotal.Text = db.GetExecuteScalar("Select COUNT(Tbl_LbItems.ItemID) From Tbl_LbItems INNER JOIN Tbl_Items ON Tbl_LbItems.ItemID=Tbl_Items.ItemID Where Tbl_Items.IsPublished=1 AND Tbl_Items.IsDeleted IS NULL AND LookID=" + lookID);
                db._sqlConnection.Close();
                db._sqlConnection.Dispose();
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
}