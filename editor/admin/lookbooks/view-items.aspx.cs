using System.Data.SqlClient;
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
                GetLookbook();
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void GetLookbook()
    {
        try
        {
            var db=new DatabaseManagement();
            string selectQuery = string.Format("SELECT Title,Description From Tbl_Lookbooks Where LookID={0}",
                                               IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(selectQuery);
            if(dr.HasRows)
            {
                dr.Read();
                lbtnlookbook.InnerText = dr[0].ToString();
                lblDescription.Text = HtmlRemoval.StripTagsRegex(dr[1].ToString());
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected int LbLikes(int lookId)
    {
        try
        {
            var db = new DatabaseManagement();
            string followers = string.Format("SELECT COUNT(Id) as TotalLikes From Tbl_Item_Likes  Where ItemID={0}", lookId);
            SqlDataReader dr = db.ExecuteReader(followers);
            int result = 0;
            if (dr.HasRows)
            {
                dr.Read();
                if (!dr.IsDBNull(0))
                    result = Convert.ToInt32(dr[0]);
            }
            dr.Close();
            return result;
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
        return 0;
    }
    protected void rptLookbook_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                //Label lblDatePosted = (Label)e.Item.FindControl("lblDate");
                //Label lblDate2 = (Label)e.Item.FindControl("lblDate2");
                //DateTime dbDate = Convert.ToDateTime(lblDatePosted.Text);
                //lblDate2.Text = Common.GetRelativeTime(dbDate);
                //var lblLikes = (Label)e.Item.FindControl("lblLikes");
                //lblLikes.Text = LbLikes(Convert.ToInt32(lblLikes.Text)).ToString();

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
    protected void rptLookbook_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "1")
            {
                int itemID = Convert.ToInt32(e.CommandArgument);
                var db = new DatabaseManagement();
                db.ExecuteSQL("Update Tbl_Items Set IsDeleted=1 Where ItemID=" + itemID);
                db.ExecuteSQL("Delete from Tbl_LbItems Where LookID="+ IEUtils.ToInt(Request.QueryString["v"]) +" AND  ItemID=" + itemID);
                ErrorMessage.ShowSuccessAlert(lblStatus, "Item deleted....", divAlerts);
                rptLookbook.DataBind();
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