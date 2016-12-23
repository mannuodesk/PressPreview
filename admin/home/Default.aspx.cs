using DLS.DatabaseServices;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Web;
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

                List<Label> lstLabels = new List<Label> { lblTotalBrands, lblTotalEditors, lblTotalCategories, lblBrandsCount, lblEditorsCount, lblTotalEvents, lblLookBooks };
                Common.GetAdminSummary(lstLabels);
                
                
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
    [WebMethod]
    public static int LogoutCheck()
    {
        if (HttpContext.Current.Session["UserID"] == null)
        {
            return 0;
        }
        return 1;
    }
    protected void grdLookbooks_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if(e.Row.RowType==DataControlRowType.DataRow)
            {
                // get lookID of the row
                int lookID = Convert.ToInt32(((Label) e.Row.FindControl("lblLookID")).Text);
                Label lblTotal = (Label) e.Row.FindControl("lblTotal");
                var db=new DatabaseManagement();
                lblTotal.Text = db.GetExecuteScalar("Select COUNT(Tbl_LbItems.ItemID) From Tbl_LbItems INNER JOIN Tbl_Items ON Tbl_LbItems.ItemID=Tbl_Items.ItemID Where Tbl_Items.IsPublished=1 AND Tbl_Items.IsDeleted!=1 AND LookID=" + lookID);
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