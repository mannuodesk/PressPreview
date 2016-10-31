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
                Common.AdminSettings(alCommonControls);
                
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
                String deleteQuery = string.Format("Delete From Tbl_Holidays  Where HolidayID={0}", RecordID);
                db.ExecuteSQL(deleteQuery);
                GridView1.DataBind();
                ErrorMessage.ShowSuccessAlert(lblStatus, "Holiday Record Deleted", divAlerts);
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
}