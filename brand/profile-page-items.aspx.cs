using System.Collections.Specialized;
using System.Data;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using DLS.DatabaseServices;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using HtmlAgilityPack;

public partial class home : System.Web.UI.Page
    {
    protected void Page_Load(object sender, EventArgs e)
        {
 Session["IsItemSaved"] = false;
        NameValueCollection n = Request.QueryString;
        if (n.HasKeys())
            {
            LoadUserDataFromKey();
            }
        else
            {
            LoadUserData();
            }
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        if (!IsPostBack)
            {
            //txtsearch.Attributes.Add("onKeyPress",
            //       "doClick('" + btnSearch.ClientID + "',event)");
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
        //rptLookbook.DataBind();
        LoadBrandData();
        // SetTotalViews();
        BrandLikes();
        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
        }
    protected void LoadUserDataFromKey()
        {
        try
            {
            var db = new DatabaseManagement();
            string getUserData = string.Format("SELECT UserID, U_Email,U_Firstname,U_CoverPic,U_ProfilePic From Tbl_Users Where UserKey={0}",
                                               IEUtils.SafeSQLString(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(getUserData);
            if (dr.HasRows)
                {
                dr.Read();
                var aCookie = new HttpCookie("FrUserID") { Value = dr["UserID"].ToString() };
                HttpContext.Current.Response.Cookies.Add(aCookie);
                var UsernameCookie = new HttpCookie("Username") { Value = dr["U_FirstName"].ToString() };
                HttpContext.Current.Response.Cookies.Add(UsernameCookie);
                var emailCookie = new HttpCookie("UserEmail") { Value = dr["U_Email"].ToString() };
                HttpContext.Current.Response.Cookies.Add(emailCookie);

                Session["UserID"] = dr["UserID"].ToString();
                Session["Username"] = dr["U_FirstName"].ToString();
                Session["UserEmail"] = dr["U_Email"].ToString();
                imgCover.ImageUrl = "../profileimages/" + dr[3].ToString();
                imgProfile.ImageUrl = "../brandslogoThumb/" + dr[4].ToString();
                }
                dr.Close();
                db.CloseConnection();
            }
        catch (Exception ex)
            {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
        }
    protected void LoadUserData()
        {
        try
            {
            var httpCookie = Request.Cookies["FrUserID"];

            var db = new DatabaseManagement();
            if (httpCookie != null)
                {
                string getUserData = string.Format("SELECT UserID, U_Email,U_Firstname,U_CoverPic,U_ProfilePic From Tbl_Users Where UserID={0}",
                                                   IEUtils.ToInt(httpCookie.Value));
                SqlDataReader dr = db.ExecuteReader(getUserData);
                if (dr.HasRows)
                    {
                    dr.Read();
                    imgCover.ImageUrl = "../profileimages/" + dr[3];
                    imgProfile.ImageUrl = "../brandslogoThumb/" + dr[4];
                    }
                    dr.Close();
                }
                db.CloseConnection();
            }
        catch (Exception ex)
            {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
        }

    [WebMethod]
    public static int LogoutCheck()
        {
        if (HttpContext.Current.Session["user"] == null)
            {
            return 0;
            }
        return 1;
        }


    protected void BrandLikes()
        {
        try
            {
            DatabaseManagement db = new DatabaseManagement();
            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
                {
                string followers = string.Format("SELECT COUNT(Id) as TotalLikes From Tbl_BrandsLikes Where UserID={0}", IEUtils.ToInt(httpCookie.Value));
                SqlDataReader dr = db.ExecuteReader(followers);
                int result = 0;
                if (dr.HasRows)
                    {
                    dr.Read();
                    if (!dr.IsDBNull(0))
                        result = Convert.ToInt32(dr[0]);
                    }
                dr.Close();
                db.CloseConnection();
                lblTotolLikes.Text = result.ToString();
                }
            }
        catch (Exception ex)
            {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }

        }
    protected void BrandFollowers()
        {
        try
            {
            var db = new DatabaseManagement();
            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
                {
                string followers = string.Format("SELECT COUNT(Id) as TotalLikes From Tbl_UserFollowers Where UserID={0}", IEUtils.ToInt(httpCookie.Value));
                SqlDataReader dr = db.ExecuteReader(followers);
                int result = 0;
                if (dr.HasRows)
                    {
                    dr.Read();
                    if (!dr.IsDBNull(0))
                        result = Convert.ToInt32(dr[0]);
                    }
                dr.Close();
                db.CloseConnection();
                }
            //  lblTotalFollowers.Text = result.ToString();
            }
        catch (Exception ex)
            {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }

        }

    [System.Web.Script.Services.ScriptMethod()]
    [WebMethod]
    public static List<string> GetItemTitle(string lbName)
        {
        var empResult = new List<string>();
        var db = new DatabaseManagement();
        using (var con = new SqlConnection(db.ConnectionString))
            {
            using (var cmd = new SqlCommand())
                {
                cmd.CommandText = "SELECT Top 10 Title From Tbl_Items Where Title LIKE  '%" + lbName + "%'";
                cmd.Connection = con;
                con.Open();
                //  cmd.Parameters.AddWithValue("@SearchName", lbName);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                    {
                    empResult.Add(dr["Title"].ToString());
                    }
                dr.Close();
                db.CloseConnection();
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
            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
                {
                string qryViews = string.Format("UPDATE Tbl_Brands Set TotalViews={0}  Where UserID={1}", TotalViews, IEUtils.ToInt(httpCookie.Value));
                db.ExecuteSQL(qryViews);
                }
                db.CloseConnection();
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
            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
                {
                string BrandData = string.Format("Select Name,Url,City,Country, Bio,TotalViews, U_ProfilePic,U_CoverPic,Url,History From Tbl_Brands INNER JOIN Tbl_Users ON Tbl_Brands.UserID=Tbl_Users.UserID Where Tbl_Brands.UserID={0}", IEUtils.ToInt(httpCookie.Value));
                SqlDataReader dr = db.ExecuteReader(BrandData);
                if (dr.HasRows)
                    {
                    dr.Read();
                    lbBrandName.InnerText = dr[0].ToString();
                    lbWebURL.HRef = dr[1].ToString();
                    imgProfile.ImageUrl = "../brandslogoThumb/" + dr[6];
                    imgCover.ImageUrl = "../profileimages/" + dr[7];
                    lblCity.Text = dr[2].ToString();
                    lblCountry.Text = dr[3].ToString();
                    lblAbout.Text = Server.HtmlDecode(dr[4].ToString());
                    if (dr.IsDBNull(5))
                        lblTotolViews.Text = "0";
                    else
                        lblTotolViews.Text = dr[5].ToString();
                    lbWebURL.InnerText = dr[8].ToString();
                    lbWebURL.HRef = "http://" + dr[8].ToString();
                    lblHistory.Text = Server.HtmlDecode(dr[9].ToString());
                    }
                dr.Close();
                
                }
            db.CloseConnection();
            }
        catch (Exception ex)
            {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
        }
    protected static int LbLikes(int lookId)
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
            db.CloseConnection();
            return result;
            }
        catch (Exception ex)
            {
            return 0;
            // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
        return 0;
        }
    ////protected void rptLookbook_ItemDataBound(object sender, RepeaterItemEventArgs e)
    ////{
    ////    try
    ////    {
    ////        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
    ////        {
    ////            Label lblDatePosted = (Label)e.Item.FindControl("lblDate");
    ////            Label lblDate2 = (Label)e.Item.FindControl("lblDate2");
    ////            DateTime dbDate = Convert.ToDateTime(lblDatePosted.Text);
    ////            lblDate2.Text = Common.GetRelativeTime(dbDate);
    ////            var lblLikes = (Label)e.Item.FindControl("lblLikes");
    ////            lblLikes.Text = LbLikes(Convert.ToInt32(lblLikes.Text)).ToString();

    ////        }


    ////    }
    ////    catch (Exception ex)
    ////    {
    ////        ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
    ////    }
    ////}
    protected void ByCategory(int categryId)
        {
        try
            {
            var db = new DatabaseManagement();
            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
                {
                string qryCategory = string.Format("SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, " +
                                                   " dbo.Tbl_Brands.Logo, dbo.Tbl_Items.ItemID, dbo.Tbl_Items.Title, " +
                                                   " ItemKey, dbo.Tbl_Items.Description, dbo.Tbl_Items.FeatureImg, " +
                                                   " dbo.Tbl_Items.Views, CAST(dbo.Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted," +
                                                   " dbo.Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands " +
                                                   " INNER JOIN dbo.Tbl_Items ON dbo.Tbl_Brands.UserID = dbo.Tbl_Items.UserID " +
                                                   " INNER JOIN dbo.Tbl_ItemsCategory ON dbo.Tbl_Items.ItemID = dbo.Tbl_ItemsCategory.ItemID " +
                                                   " INNER JOIN dbo.Tbl_Categories ON dbo.Tbl_Categories.CategoryID = dbo.Tbl_ItemsCategory.CategoryID " +
                                                   "Where dbo.Tbl_Brands.UserID={0} AND Tbl_ItemsCategory.CategoryID={1} dbo.Tbl_Items.IsDeleted IS NULL AND dbo.Tbl_Items.IsPublished=1 " +
                                                   "ORDER BY dbo.Tbl_Items.DatePosted DESC",
                                                   IEUtils.ToInt(httpCookie.Value), categryId);

                //rptLookbook.DataSourceID = "";
                //rptLookbook.DataSource = db.ExecuteReader(qryCategory);
                }
            // rptLookbook.DataBind();
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
            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
                {
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
                                                 IEUtils.ToInt(httpCookie.Value), seasonId);
                //string qrySeason = string.Format("SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, dbo.Tbl_Brands.Logo, dbo.Tbl_Lookbooks.LookID," +
                //                " dbo.Tbl_Lookbooks.Title, dbo.Tbl_Lookbooks.LookKey, dbo.Tbl_Lookbooks.Description, dbo.Tbl_Lookbooks.MainImg, dbo.Tbl_Lookbooks.Views," +
                //                " CAST(Tbl_Lookbooks.DatePosted AS VARCHAR(12)) as DatePosted, Tbl_Lookbooks.DatePosted as [dated] FROM dbo.Tbl_Brands " +
                //                " INNER JOIN dbo.Tbl_Lookbooks ON dbo.Tbl_Brands.BrandID = dbo.Tbl_Lookbooks.BrandID " +
                //                " Where dbo.Tbl_Brands.BrandID ={0} AND seasonID={1} AND dbo.Tbl_Lookbooks.IsDeleted IS NULL AND dbo.Tbl_Lookbooks.IsPublished = 1 " +
                //                " ORDER BY dbo.Tbl_Lookbooks.DatePosted DESC", IEUtils.ToInt(Request.QueryString["v"]), seasonId);
                ////rptLookbook.DataSourceID = "";
                ////rptLookbook.DataSource = db.ExecuteReader(qrySeason);
                }
            /////  rptLookbook.DataBind();
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
            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
                {
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
                                                  IEUtils.ToInt(httpCookie.Value), holidayId);

                ////rptLookbook.DataSourceID = "";
                ////rptLookbook.DataSource = db.ExecuteReader(qryHoliday);
                }
            //// rptLookbook.DataBind();
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
            if (e.CommandName == "1")
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

    //protected void txtsearch_TextChanged(object sender, EventArgs e)
    //{
    //    var db = new DatabaseManagement();
    //    using (var con = new SqlConnection(db.ConnectionString))
    //    {
    //        using (var cmd = new SqlCommand())
    //        {
    //            var httpCookie = Request.Cookies["FrUserID"];
    //            if (httpCookie != null)
    //            {
    //                string qrySearch = "SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, dbo.Tbl_Brands.Logo, Tbl_Items.ItemID," +
    //                                   " Tbl_Items.Title, Tbl_Items.ItemKey, Tbl_Items.Description, Tbl_Items.FeatureImg, Tbl_Items.Views, U_ProfilePic, " +
    //                                   " CAST(Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted, Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands " +
    //                                   "INNER JOIN Tbl_Users ON Tbl_Users.UserID=Tbl_Brands.UserID " +
    //                                   " INNER JOIN Tbl_Items ON dbo.Tbl_Brands.UserID = Tbl_Items.UserID " +
    //                                   " Where dbo.Tbl_Brands.UserID =" + Convert.ToInt32(httpCookie.Value) + " AND Tbl_Items.Title LIKE '%" + txtsearch.Text + "%'  AND Tbl_Items.IsDeleted IS NULL AND Tbl_Items.IsPublished = 1 " +
    //                                   " ORDER BY Tbl_Items.DatePosted DESC";
    //                cmd.CommandText = qrySearch;
    //            }
    //            cmd.Connection = con;
    //            con.Open();

    //            ////rptLookbook.DataSourceID = "";
    //            ////rptLookbook.DataSource = cmd.ExecuteReader();
    //            ////rptLookbook.DataBind();
    //            con.Close();

    //        }
    //    }
    // }

    protected void btnEditProfile_OnServerClick(object sender, EventArgs e)
        {
        Response.Redirect("edit-profile.aspx");
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
                                       " Tbl_Items.Title, Tbl_Items.ItemKey, Tbl_Items.Description, Tbl_Items.FeatureImg, Tbl_Items.Views, U_ProfilePic," +
                                       " CAST(Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted, Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands " +
                                       "INNER JOIN Tbl_Users ON Tbl_Users.UserID=Tbl_Brands.UserID " +
                                       " INNER JOIN Tbl_Items ON dbo.Tbl_Brands.UserID = Tbl_Items.UserID " +
                                       " Where dbo.Tbl_Brands.UserID =" + Convert.ToInt32(httpCookie.Value) + " AND Tbl_Items.Title LIKE '%" + txtsearch.Text + "%'  AND Tbl_Items.IsDeleted IS NULL AND Tbl_Items.IsPublished = 1 " +
                                       " ORDER BY Tbl_Items.DatePosted DESC";
                    cmd.CommandText = qrySearch;
                    }
                cmd.Connection = con;
                con.Open();

                ////rptLookbook.DataSourceID = "";
                ////rptLookbook.DataSource = cmd.ExecuteReader();
                ////rptLookbook.DataBind();
                con.Close();
                db.CloseConnection();
                }
            }
        }


    protected void lbtnRemove_OnClick(object sender, EventArgs e)
        {
        try
            {
            LinkButton b = sender as LinkButton;
            if (b != null)
                {
                int itemID = Convert.ToInt32(b.CommandArgument);
                var db = new DatabaseManagement();
                db.ExecuteSQL("Update Tbl_Items Set IsDeleted=1 Where ItemID=" + itemID);
                ErrorMessage.ShowSuccessAlert(lblStatus, "Item deleted....", divAlerts);
                //  rptLookbook.DataBind();
                db.CloseConnection();
                }
            }
        catch (Exception ex)
            {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
        }
    ////protected void rptLookbook_ItemCommand(object source, RepeaterCommandEventArgs e)
    ////{
    ////    try
    ////    {
    ////        if (e.CommandName == "1")
    ////        {
    ////            int itemID = Convert.ToInt32(e.CommandArgument);
    ////            var db = new DatabaseManagement();
    ////            db.ExecuteSQL("Update Tbl_Items Set IsDeleted=1 Where ItemID=" + itemID);
    ////            ErrorMessage.ShowSuccessAlert(lblStatus, "Item deleted....", divAlerts);
    ////            rptLookbook.DataBind();
    ////            db._sqlConnection.Close();
    ////            db._sqlConnection.Dispose();
    ////        }
    ////    }
    ////    catch (Exception ex)
    ////    {
    ////        ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
    ////    }
    ////}

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
                db.CloseConnection();
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
        db.CloseConnection();

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
        db.CloseConnection();
        }

    [WebMethod, ScriptMethod]
    public static List<Items> GetData(int pageIndex)
        {
        try
            {
            int pagesize = 10;
            //StringBuilder getPostsText = new StringBuilder();
            var itemList = new List<Items>();
            var db = new DatabaseManagement();

            var httpCookie = HttpContext.Current.Request.Cookies["FrUserID"];
            if (httpCookie != null)
                {
                var cmd = new SqlCommand("GetItemPageWise");
                db._sqlConnection.Open();
                cmd.Connection = db._sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
                cmd.Parameters.AddWithValue("@UserId", IEUtils.ToInt(httpCookie.Value));
                cmd.Parameters.AddWithValue("@PageSize", 1);
                cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                int pageCount = Convert.ToInt32(cmd.Parameters["@PageCount"].Value);
                SqlDataReader dr = cmd.ExecuteReader();
                var desc = "";
                //   int startItems = ((pageIndex - 1) * pagesize) + 1;
                //int endItems = (startItems + pagesize) - 1;
                //int tempCount = 1;
                if (dr.HasRows)
                    {
                    while (dr.Read())
                        {
                  
                        //DateTime dbDate = Convert.ToDateTime(dr["DatePosted"].ToString());
                        DateTime dbDate = Convert.ToDateTime(dr["Dated"].ToString());

                        var objitem = new Items
                        {
                            PageCount = pageCount,
                            ItemId = IEUtils.ToInt(dr["ItemID"]),
                            ItemKey = dr["ItemKey"].ToString(),
                            Name = dr["Name"].ToString(),
                            ProfilePic = dr["U_ProfilePic"].ToString(),
                            RowNum = IEUtils.ToInt(dr["row"]),
                            Title = dr["Title"].ToString(),
                            Likes = LbLikes(IEUtils.ToInt(dr["ItemID"])),
                            Views = IEUtils.ToInt(dr["Views"]),
                            BrandId = IEUtils.ToInt(dr["BrandID"]),
                            BrandKey = dr["BrandKey"].ToString(),
                            DatePosted = dr["DatePosted"].ToString(),
                            Dated = Common.GetRelativeTime(dbDate),
                            Description = dr["Description"].ToString(),
                            FeatureImg = dr["FeatureImg"].ToString()
                        };
                        var pageDoc = new HtmlDocument();
                        pageDoc.LoadHtml(objitem.Description);
                        desc = pageDoc.DocumentNode.InnerText;
                        objitem.Description = desc;
                        string selectDBTime = string.Format("Select DatePosted from Tbl_Items Where ItemID={0}", objitem.ItemId);
                        DatabaseManagement db1 = new DatabaseManagement();
                        SqlDataReader dr1 = db1.ExecuteReader(selectDBTime);
                        if (dr1.HasRows)
                        {
                            dr1.Read();
                            dbDate = Convert.ToDateTime(dr1[0]);
                            objitem.Dated = Common.GetRelativeTime(dbDate);
                        }
                        dr1.Close();
                        db1.CloseConnection();
                       // if (tempCount >= startItems && tempCount <= endItems)
                         // {
                        itemList.Add(objitem);
                         // }
                        //tempCount++;

                        }
                    }
                    dr.Close();
                }
                db.CloseConnection();
            return itemList;


            }

        catch (Exception ex)
            {
            // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }

        return null;
        }

    [WebMethod, ScriptMethod]
    public static List<Items> GetDataByCategory(int pageIndex, int categoryid)
        {
        try
            {
            int pagesize = 10;
            //StringBuilder getPostsText = new StringBuilder();
            var itemList = new List<Items>();
            var db = new DatabaseManagement();

            var httpCookie = HttpContext.Current.Request.Cookies["FrUserID"];
            if (httpCookie != null)
                {
                var cmd = new SqlCommand("GetItemsByCategory");
                db._sqlConnection.Open();
                cmd.Connection = db._sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", 1);
                cmd.Parameters.AddWithValue("@UserId", IEUtils.ToInt(httpCookie.Value));
                cmd.Parameters.AddWithValue("@CategoryID", categoryid);
                cmd.Parameters.AddWithValue("@PageSize", 10000);
                cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                int pageCount = Convert.ToInt32(cmd.Parameters["@PageCount"].Value);
                SqlDataReader dr = cmd.ExecuteReader();
                var desc = "";
                int startItems = ((pageIndex - 1) * pagesize) + 1;
                int endItems = (startItems + pagesize) - 1;
                int tempCount = 1;
                if (dr.HasRows)
                    {
                    while (dr.Read())
                        {
                        DateTime dbDate = Convert.ToDateTime(dr["DatePosted"].ToString());

                        var objitem = new Items
                        {
                            PageCount = pageCount,
                            ItemId = IEUtils.ToInt(dr["ItemID"]),
                            ItemKey = dr["ItemKey"].ToString(),
                            Name = dr["Name"].ToString(),
                            ProfilePic = dr["U_ProfilePic"].ToString(),
                            RowNum = IEUtils.ToInt(dr["row"]),
                            Title = dr["Title"].ToString(),
                            Likes = LbLikes(IEUtils.ToInt(dr["ItemID"])),
                            Views = IEUtils.ToInt(dr["Views"]),
                            BrandId = IEUtils.ToInt(dr["BrandID"]),
                            BrandKey = dr["BrandKey"].ToString(),
                            DatePosted = dr["DatePosted"].ToString(),
                            Dated = Common.GetRelativeTime(dbDate),
                            Description = dr["Description"].ToString(),
                            FeatureImg = dr["FeatureImg"].ToString()
                        };
                        var pageDoc = new HtmlDocument();
                        pageDoc.LoadHtml(objitem.Description);
                        desc = pageDoc.DocumentNode.InnerText;
                        objitem.Description = desc;
                        if (tempCount >= startItems && tempCount <= endItems)
                            {
                            itemList.Add(objitem);
                            }
                        tempCount++;

                        }
                    }
                    dr.Close();
                }
                db.CloseConnection();
            return itemList;


            }
        catch (Exception ex)
            {
            // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }

        return null;
        }

    [WebMethod, ScriptMethod]
    public static List<Items> GetDataBySeason(int pageIndex, int seasonid)
        {
        try
            {
            int pagesize = 10;
            //StringBuilder getPostsText = new StringBuilder();
            var itemList = new List<Items>();
            var db = new DatabaseManagement();

            var httpCookie = HttpContext.Current.Request.Cookies["FrUserID"];
            if (httpCookie != null)
                {
                var cmd = new SqlCommand("GetItemsBySeason");
                db._sqlConnection.Open();
                cmd.Connection = db._sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", 1);
                cmd.Parameters.AddWithValue("@UserId", IEUtils.ToInt(httpCookie.Value));
                cmd.Parameters.AddWithValue("@SeasonID", seasonid);
                cmd.Parameters.AddWithValue("@PageSize", 10000);
                cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                int pageCount = Convert.ToInt32(cmd.Parameters["@PageCount"].Value);
                SqlDataReader dr = cmd.ExecuteReader();
                var desc = "";
                int startItems = ((pageIndex - 1) * pagesize) + 1;
                int endItems = (startItems + pagesize) - 1;
                int tempCount = 1;
                if (dr.HasRows)
                    {
                    while (dr.Read())
                        {
                        DateTime dbDate = Convert.ToDateTime(dr["DatePosted"].ToString());

                        var objitem = new Items
                        {
                            PageCount = pageCount,
                            ItemId = IEUtils.ToInt(dr["ItemID"]),
                            ItemKey = dr["ItemKey"].ToString(),
                            Name = dr["Name"].ToString(),
                            ProfilePic = dr["U_ProfilePic"].ToString(),
                            RowNum = IEUtils.ToInt(dr["row"]),
                            Title = dr["Title"].ToString(),
                            Likes = LbLikes(IEUtils.ToInt(dr["ItemID"])),
                            Views = IEUtils.ToInt(dr["Views"]),
                            BrandId = IEUtils.ToInt(dr["BrandID"]),
                            BrandKey = dr["BrandKey"].ToString(),
                            DatePosted = dr["DatePosted"].ToString(),
                            Dated = Common.GetRelativeTime(dbDate),
                            Description = dr["Description"].ToString(),
                            FeatureImg = dr["FeatureImg"].ToString()
                        };
                        var pageDoc = new HtmlDocument();
                        pageDoc.LoadHtml(objitem.Description);
                        desc = pageDoc.DocumentNode.InnerText;
                        objitem.Description = desc;
                        if (tempCount >= startItems && tempCount <= endItems)
                            {
                            itemList.Add(objitem);
                            }
                        tempCount++;

                        }
                    }
                    dr.Close();
                }
                db.CloseConnection();
            return itemList;


            }
        catch (Exception ex)
            {
            // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }

        return null;
        }

    [WebMethod, ScriptMethod]
    public static List<Items> GetDataByHoliday(int pageIndex, int holidayid)
        {
        try
            {
            int pagesize = 10;
            //StringBuilder getPostsText = new StringBuilder();
            var itemList = new List<Items>();
            var db = new DatabaseManagement();

            var httpCookie = HttpContext.Current.Request.Cookies["FrUserID"];
            if (httpCookie != null)
                {
                var cmd = new SqlCommand("GetItemsByHoliday");
                db._sqlConnection.Open();
                cmd.Connection = db._sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", 1);
                cmd.Parameters.AddWithValue("@UserId", IEUtils.ToInt(httpCookie.Value));
                cmd.Parameters.AddWithValue("@HolidayID", holidayid);
                cmd.Parameters.AddWithValue("@PageSize", 10000);
                cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                int pageCount = Convert.ToInt32(cmd.Parameters["@PageCount"].Value);
                SqlDataReader dr = cmd.ExecuteReader();
                var desc = "";
                int startItems = ((pageIndex - 1) * pagesize) + 1;
                int endItems = (startItems + pagesize) - 1;
                int tempCount = 1;
                if (dr.HasRows)
                    {
                    while (dr.Read())
                        {
                        DateTime dbDate = Convert.ToDateTime(dr["DatePosted"].ToString());

                        var objitem = new Items
                        {
                            PageCount = pageCount,
                            ItemId = IEUtils.ToInt(dr["ItemID"]),
                            ItemKey = dr["ItemKey"].ToString(),
                            Name = dr["Name"].ToString(),
                            ProfilePic = dr["U_ProfilePic"].ToString(),
                            RowNum = IEUtils.ToInt(dr["row"]),
                            Title = dr["Title"].ToString(),
                            Likes = LbLikes(IEUtils.ToInt(dr["ItemID"])),
                            Views = IEUtils.ToInt(dr["Views"]),
                            BrandId = IEUtils.ToInt(dr["BrandID"]),
                            BrandKey = dr["BrandKey"].ToString(),
                            DatePosted = dr["DatePosted"].ToString(),
                            Dated = Common.GetRelativeTime(dbDate),
                            Description = dr["Description"].ToString(),
                            FeatureImg = dr["FeatureImg"].ToString()
                        };
                        var pageDoc = new HtmlDocument();
                        pageDoc.LoadHtml(objitem.Description);
                        desc = pageDoc.DocumentNode.InnerText;
                        objitem.Description = desc;
                        if (tempCount >= startItems && tempCount <= endItems)
                            {
                            itemList.Add(objitem);
                            }
                        tempCount++;

                        }
                    }
                    dr.Close();
                }
            db.CloseConnection();
            return itemList;


            }
        catch (Exception ex)
            {
            // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }

        return null;
        }

    [WebMethod, ScriptMethod]
    public static List<Items> GetDataByTitle(int pageIndex, string title)
        {
        try
            {
            int pagesize = 10;
            //StringBuilder getPostsText = new StringBuilder();
            var itemList = new List<Items>();
            var db = new DatabaseManagement();

            var httpCookie = HttpContext.Current.Request.Cookies["FrUserID"];
            if (httpCookie != null)
                {
                var cmd = new SqlCommand("GetItemsByTitle");
                db._sqlConnection.Open();
                cmd.Connection = db._sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", 1);
                cmd.Parameters.AddWithValue("@UserId", IEUtils.ToInt(httpCookie.Value));
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@PageSize", 10000);
                cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                int pageCount = Convert.ToInt32(cmd.Parameters["@PageCount"].Value);
                SqlDataReader dr = cmd.ExecuteReader();
                var desc = "";
                int startItems = ((pageIndex - 1) * pagesize) + 1;
                int endItems = (startItems + pagesize) - 1;
                int tempCount = 1;
                if (dr.HasRows)
                    {
                    while (dr.Read())
                        {
                        DateTime dbDate = Convert.ToDateTime(dr["DatePosted"].ToString());

                        var objitem = new Items
                        {
                            PageCount = pageCount,
                            ItemId = IEUtils.ToInt(dr["ItemID"]),
                            ItemKey = dr["ItemKey"].ToString(),
                            Name = dr["Name"].ToString(),
                            ProfilePic = dr["U_ProfilePic"].ToString(),
                            RowNum = IEUtils.ToInt(dr["row"]),
                            Title = dr["Title"].ToString(),
                            Likes = LbLikes(IEUtils.ToInt(dr["ItemID"])),
                            Views = IEUtils.ToInt(dr["Views"]),
                            BrandId = IEUtils.ToInt(dr["BrandID"]),
                            BrandKey = dr["BrandKey"].ToString(),
                            DatePosted = dr["DatePosted"].ToString(),
                            Dated = Common.GetRelativeTime(dbDate),
                            Description = dr["Description"].ToString(),
                            FeatureImg = dr["FeatureImg"].ToString()
                        };

                        var pageDoc = new HtmlDocument();
                        pageDoc.LoadHtml(objitem.Description);
                        desc = pageDoc.DocumentNode.InnerText;
                        objitem.Description = desc;
                        if (tempCount >= startItems && tempCount <= endItems)
                            {
                            itemList.Add(objitem);
                            }
                        tempCount++;

                        }
                    }
                    dr.Close();
                }
                db.CloseConnection();
            return itemList;


            }
        catch (Exception ex)
            {
            // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }

        return null;
        }
    [WebMethod, ScriptMethod]
    public static void DeleteItem(string id)
        {
        var db = new DatabaseManagement();
        string deleteQuery = string.Format("Delete From Tbl_Items Where ItemID={0}",
                                               IEUtils.ToInt(id));
        string deleteTagQuery = string.Format("Delete from Tbl_ItemTagsMapping where ItemId={0}",
                                               IEUtils.ToInt(id));
        db.ExecuteSQL(deleteTagQuery);
        db.ExecuteSQL(deleteQuery);
        db.CloseConnection();

        }



    }