using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using DLS.DatabaseServices;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        var al = new ArrayList {lblUsername, imgUserIcon};
        Common.UserSettings(al);
        if (!IsPostBack)
        {
            try
            {
                txtsearch.Attributes.Add("onKeyPress",
                  "doClick('" + btnSearch.ClientID + "',event)");
               
                LoadBrandData();
                SetTotalViews();
               
                BrandLikes();
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
            }
            catch (Exception ex)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
            
        }
    }

    protected void BrandLikes()
    {
        try
        {
            DatabaseManagement db = new DatabaseManagement();
            string followers = string.Format("SELECT COUNT(Id) as TotalLikes From Tbl_BrandsLikes Where UserID={0}", IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(followers);
            int result = 0;
            if(dr.HasRows)
            {
                dr.Read();
                if (!dr.IsDBNull(0))
                    result = Convert.ToInt32(dr[0]);
            }
            dr.Close();
            lblTotolLikes.Text= result.ToString();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
       
    }
    
    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> GetItemTitle(string lbName)
    {
        var empResult = new List<string>();
        var db = new DatabaseManagement();
        using (var con = new SqlConnection(db.ConnectionString))
        {
            using (var cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT Top 10 Title From Tbl_Items Where Title LIKE  '" + lbName + "%'";
                cmd.Connection = con;
                con.Open();
              //  cmd.Parameters.AddWithValue("@SearchName", lbName);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    empResult.Add(dr["Title"].ToString());
                }
                con.Close();
                db._sqlConnection.Close();
                return empResult;
            }
           
        }
      
   }
    protected void SetTotalViews()
    {
        try
        {
            DatabaseManagement db = new DatabaseManagement();
            int TotalViews = Convert.ToInt32(lblTotolViews.Text);
            string qryViews = string.Format("UPDATE Tbl_Brands Set TotalViews={0}  Where UserID={1}", TotalViews, IEUtils.ToInt(Request.QueryString["v"]));
            db.ExecuteSQL(qryViews);
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void LoadBrandData()
    {
        try
        {
            var db = new DatabaseManagement();
            string BrandData = string.Format("Select Name,Url,City,Country, Bio,TotalViews, U_ProfilePic,U_CoverPic,Url,History From Tbl_Brands INNER JOIN Tbl_Users ON Tbl_Brands.UserID=Tbl_Users.UserID Where Tbl_Brands.UserID={0}", IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(BrandData);
            if (dr.HasRows)
            {
                dr.Read();
                lbBrandName.InnerText = dr[0].ToString();
                lbWebURL.HRef = dr[1].ToString();
                imgLogo.Src = "../brandslogoThumb/" + dr[6];
                imgCover.ImageUrl = "../profileimages/" + dr[7];
                lblCity.Text = dr[2].ToString();
                lblCountry.Text = dr[3].ToString();
                dvAbout.InnerText = dr[4].ToString();
                if (dr.IsDBNull(5))
                    lblTotolViews.Text = "0";
                else
                    lblTotolViews.Text = (Convert.ToInt32(dr[5]) + 1).ToString();
                lbWebURL.InnerText = dr[8].ToString();
                lbWebURL.HRef = "http://" + dr[8].ToString().Replace("http://", "");
                dvHistory.InnerText = dr[9].ToString();
            }
            dr.Close();
            db._sqlConnection.Close();
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
                Label lblDatePosted = (Label)e.Item.FindControl("lblDate");
                Label lblDate2 = (Label)e.Item.FindControl("lblDate2");
                DateTime dbDate = Convert.ToDateTime(lblDatePosted.Text);
                lblDate2.Text = Common.GetRelativeTime(dbDate);
                var lblLikes = (Label)e.Item.FindControl("lblLikes");
                lblLikes.Text = LbLikes(Convert.ToInt32(lblLikes.Text)).ToString();

            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void ByCategory(int categryId)
    {
        try
        {
            var db = new DatabaseManagement();
            string qryCategory = string.Format("SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, " +
               " dbo.Tbl_Brands.Logo, dbo.Tbl_Items.ItemID, dbo.Tbl_Items.Title, "+
               " ItemKey, dbo.Tbl_Items.Description, dbo.Tbl_Items.FeatureImg, " +
               " dbo.Tbl_Items.Views, CAST(dbo.Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted," + 
               " dbo.Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands " +
               " INNER JOIN dbo.Tbl_Items ON dbo.Tbl_Brands.UserID = dbo.Tbl_Items.UserID " +
               " INNER JOIN dbo.Tbl_ItemsCategory ON dbo.Tbl_Items.ItemID = dbo.Tbl_ItemsCategory.ItemID " +
                " INNER JOIN dbo.Tbl_Categories ON dbo.Tbl_Categories.CategoryID = dbo.Tbl_ItemsCategory.CategoryID " +
                "Where dbo.Tbl_Brands.UserID={0} AND Tbl_ItemsCategory.CategoryID={1} dbo.Tbl_Items.IsDeleted IS NULL AND dbo.Tbl_Items.IsPublished=1 " +
            "ORDER BY dbo.Tbl_Items.DatePosted DESC",
            IEUtils.ToInt(Request.QueryString["v"]), categryId);
           
            rptLookbook.DataSourceID = "";
            rptLookbook.DataSource = db.ExecuteReader(qryCategory);
            rptLookbook.DataBind();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void BySeason(int seasonId)
    {
        try
        {
            var db = new DatabaseManagement();
            string qrySeason = string.Format("SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, " +
              " dbo.Tbl_Brands.Logo, dbo.Tbl_Items.ItemID, dbo.Tbl_Items.Title, " +
              " ItemKey, dbo.Tbl_Items.Description, dbo.Tbl_Items.FeatureImg, " +
              " dbo.Tbl_Items.Views, CAST(dbo.Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted," +
              " dbo.Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands " +
              " INNER JOIN dbo.Tbl_Items ON dbo.Tbl_Brands.UserID = dbo.Tbl_Items.UserID " +
              " INNER JOIN dbo.Tbl_ItemSeasons ON dbo.Tbl_Items.ItemID = dbo.Tbl_ItemSeasons.ItemID " +
               " INNER JOIN dbo.Tbl_Seasons ON dbo.Tbl_Seasons.SeasonID = dbo.Tbl_ItemSeasons.SeasonID " +
               "Where dbo.Tbl_Brands.UserID={0} AND Tbl_ItemSeasons.SeasonID={1} dbo.Tbl_Items.IsDeleted IS NULL AND dbo.Tbl_Items.IsPublished=1 " +
           "ORDER BY dbo.Tbl_Items.DatePosted DESC",
           IEUtils.ToInt(Request.QueryString["v"]), seasonId);
            
            rptLookbook.DataSourceID = "";
            rptLookbook.DataSource = db.ExecuteReader(qrySeason);
            rptLookbook.DataBind();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void ByHoliday(int holidayId)
    {
        try
        {
            var db = new DatabaseManagement();
            string qryHoliday = string.Format("SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, " +
              " dbo.Tbl_Brands.Logo, dbo.Tbl_Items.ItemID, dbo.Tbl_Items.Title, " +
              " ItemKey, dbo.Tbl_Items.Description, dbo.Tbl_Items.FeatureImg, " +
              " dbo.Tbl_Items.Views, CAST(dbo.Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted," +
              " dbo.Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands " +
              " INNER JOIN dbo.Tbl_Items ON dbo.Tbl_Brands.UserID = dbo.Tbl_Items.UserID " +
              " INNER JOIN dbo.Tbl_ItemHolidays ON dbo.Tbl_Items.ItemID = dbo.Tbl_ItemHolidays.ItemID " +
               " INNER JOIN dbo.Tbl_Holidays ON dbo.Tbl_Holidays.HolidayID = dbo.Tbl_ItemHolidays.HolidayID " +
               "Where dbo.Tbl_Brands.UserID={0} AND Tbl_ItemHolidays.HolidayID={1} dbo.Tbl_Items.IsDeleted IS NULL AND dbo.Tbl_Items.IsPublished=1 " +
           "ORDER BY dbo.Tbl_Items.DatePosted DESC",
           IEUtils.ToInt(Request.QueryString["v"]), holidayId);
           
            rptLookbook.DataSourceID = "";
            rptLookbook.DataSource = db.ExecuteReader(qryHoliday);
            rptLookbook.DataBind();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void rptbrdCategories_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if(e.CommandName=="1")
            {
                txtsearch.Text = string.Empty;
                int categoryID = Convert.ToInt32(e.CommandArgument);
                ByCategory(categoryID);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void rptSeason_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "1")
            {
                txtsearch.Text = string.Empty;
                int seasonID = Convert.ToInt32(e.CommandArgument);
                BySeason(seasonID);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void rptHoliday_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "1")
            {
                txtsearch.Text = string.Empty;
                int holidayID = Convert.ToInt32(e.CommandArgument);
                ByHoliday(holidayID);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void txtsearch_TextChanged(object sender, EventArgs e)
    {
        var db = new DatabaseManagement();
        using (var con = new SqlConnection(db.ConnectionString))
        {
            using (var cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT Top 10 Title From Tbl_Items Where Title LIKE  '" + txtsearch.Text + "%'";

               // SqlDataReader dr = cmd.ExecuteReader();
                rptLookbook.DataSourceID = "";
                rptLookbook.DataSource = cmd.ExecuteReader();
                rptLookbook.DataBind();
                con.Close();
                
            }
        }
    }

    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        var db = new DatabaseManagement();
        using (var con = new SqlConnection(db.ConnectionString))
        {
            using (var cmd = new SqlCommand())
            {
                string qrySearch = "SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, dbo.Tbl_Brands.Logo, Tbl_Items.ItemID," +
                           " Tbl_Items.Title, Tbl_Items.ItemKey, Tbl_Items.Description, Tbl_Items.FeatureImg, Tbl_Items.Views," +
                           " CAST(Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted, Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands " +
                           " INNER JOIN Tbl_Items ON dbo.Tbl_Brands.UserID = Tbl_Items.UserID " +
                           " Where dbo.Tbl_Brands.UserID ='" + Convert.ToInt32(Request.QueryString["v"]) + "' AND Tbl_Items.Title LIKE '%" + txtsearch.Text + "%'  AND Tbl_Items.IsDeleted IS NULL AND Tbl_Items.IsPublished = 1 " +
                           " ORDER BY Tbl_Items.DatePosted DESC";
                cmd.CommandText = qrySearch;
                cmd.Connection = con;
                con.Open();

                rptLookbook.DataSourceID = "";
                rptLookbook.DataSource = cmd.ExecuteReader();
                rptLookbook.DataBind();
                con.Close();

            }
        }
    }


    protected void lbtnMassenger_Click(object sender, EventArgs e)
    {
        Response.Redirect("compose.aspx?v="+lblUsername.Text);
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