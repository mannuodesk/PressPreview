using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;

public partial class editor_wishlist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
        if (!IsPostBack)
        {
            txtsearch.Attributes.Add("onKeyPress",
                   "doClick('" + btnSearch.ClientID + "',event)");
            try
            {
               LoadEditorData();
               // SetTotalViews();
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
    protected void SetTotalViews()
    {
        try
        {
            var db = new DatabaseManagement();
            int totalViews = Convert.ToInt32(lblTotolViews.Text);
            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
            {
                string qryViews = string.Format("UPDATE Tbl_Editors Set TotalViews={0}  Where UserID={1}", totalViews, IEUtils.ToInt(httpCookie.Value));
                db.ExecuteSQL(qryViews);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void LoadEditorData()
    {
        try
        {
            var db = new DatabaseManagement();
            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
            {
                string BrandData = string.Format("Select Firstname + ' ' + Lastname as Name, City," +
                                                 "Country, Description,ToProject,ECalendar, TotalViews,WebURL,U_ProfilePic,U_CoverPic From Tbl_Editors INNER JOIN Tbl_Users ON Tbl_Editors.UserID=Tbl_Users.UserID  Where Tbl_Editors.UserID={0}", IEUtils.ToInt(httpCookie.Value));
                SqlDataReader dr = db.ExecuteReader(BrandData);
                if (dr.HasRows)
                {
                    dr.Read();
                    lblEditorName.InnerText = dr[0].ToString();

                    lblCity.Text = dr[1].ToString();
                    lblCountry.Text = dr[2].ToString();
                    lblTotolViews.Text = dr.IsDBNull(6) ? "0" : dr[6].ToString();
                    lbWebURL.InnerText = dr[7].ToString();
                    lbWebURL.HRef = "http://" + dr[7];
                    imgCover.ImageUrl = "../profileimages/" + dr[9];
                    imgProfile.ImageUrl = "../brandslogoThumb/" + dr[8];
                }
                dr.Close();
            }
            db._sqlConnection.Close();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
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
    protected void btnEditProfile_OnServerClick(object sender, EventArgs e)
    {
        Response.Redirect("edit-profile.aspx");
    }


    protected void rptLookbook_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if(e.CommandName=="1") // Delete Command
            {
                var db=new DatabaseManagement();
                Int32 selectedItemID = Convert.ToInt32(e.CommandArgument);
                var httpCookie = Request.Cookies["FrUserID"];
                if (httpCookie != null)
                {
                    string removeFromWishlist = string.Format("Delete From Tbl_Wishlist Where ItemID={0} AND UserID={1}",
                                                              selectedItemID, Convert.ToInt32( httpCookie.Value));
                    db.ExecuteSQL(removeFromWishlist);
                }
                rptLookbook.DataBind();
                ErrorMessage.ShowSuccessAlert(lblStatus, "Item removed from your wish list.", divAlerts);
            }
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

    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        var db = new DatabaseManagement();
        using (var con = new SqlConnection(db.ConnectionString))
        {
            using (var cmd = new SqlCommand())
            {
                var httpCookie = Request.Cookies["FrUserID"];
                if (httpCookie != null)
                {
                    string qrySearch = "SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, dbo.Tbl_Brands.Logo, Tbl_Items.ItemID," +
                                       " Tbl_Items.Title, Tbl_Items.ItemKey, Tbl_Items.Description, Tbl_Items.FeatureImg, Tbl_Items.Views," +
                                       " CAST(Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted, Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands " +
                                       " INNER JOIN Tbl_Items ON dbo.Tbl_Brands.UserID = Tbl_Items.UserID " +
                                       " Where dbo.Tbl_Brands.UserID =" + Convert.ToInt32(httpCookie.Value) + " AND Tbl_Items.Title LIKE '" + txtsearch.Text + "%'  AND Tbl_Items.IsDeleted IS NULL AND Tbl_Items.IsPublished = 1 " +
                                       " ORDER BY Tbl_Items.DatePosted DESC";
                    cmd.CommandText = qrySearch;
                }
                cmd.Connection = con;
                con.Open();

                rptLookbook.DataSourceID = "";
                rptLookbook.DataSource = cmd.ExecuteReader();
                rptLookbook.DataBind();
                con.Close();

            }
        }
    }
    protected void Repeater2_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
       
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