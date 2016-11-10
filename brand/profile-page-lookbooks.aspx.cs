using System.Data;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;

public partial class home : System.Web.UI.Page
    {
    protected void Page_Load(object sender, EventArgs e)
        {
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        if (!IsPostBack)
            {
            try
                {
                LoadBrandData();
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

        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
        }

    [WebMethod, ScriptMethod]
    public static void UpdateMessageStatus(string userID)
        {
        var db = new DatabaseManagement();
        string insertQuery = string.Format("UPDATE Tbl_MailboxFor Set ReadStatus={0} Where ReceiverID={1}",
                                           1, IEUtils.ToInt(userID));
        db.ExecuteSQL(insertQuery);


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
                lblTotolLikes.Text = result.ToString();
                }
            }
        catch (Exception ex)
            {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }

        }

    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> GetLookbookTitle(string lbName)
        {
        var empResult = new List<string>();
        var db = new DatabaseManagement();
        using (SqlConnection con = new SqlConnection(db.ConnectionString))
            {
            using (SqlCommand cmd = new SqlCommand())
                {
                cmd.CommandText = "SELECT Top 10 Title From Tbl_Lookbooks Where Title LIKE '%" + lbName + "%'";
                cmd.Connection = con;
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                    {
                    empResult.Add(dr["Title"].ToString());
                    }
                con.Close();
                return empResult;
                }
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
            db._sqlConnection.Close();
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
            string followers = string.Format("SELECT COUNT(ID) as TotalLikes From Tbl_LookBook_Likes  Where LookID={0}", lookId);
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
        catch (Exception)
            {
            return 0;
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
    protected void ByCategory(int categryId)
        {
        try
            {
            var db = new DatabaseManagement();
            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
                {
                string qryCategory = string.Format("SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, " +
                                                   " dbo.Tbl_Brands.Logo, dbo.Tbl_Lookbooks.LookID, dbo.Tbl_Lookbooks.Title, " +
                                                   " LookKey, dbo.Tbl_Lookbooks.Description, dbo.Tbl_Lookbooks.MainImg, " +
                                                   " dbo.Tbl_Lookbooks.Views, CAST(dbo.Tbl_Lookbooks.DatePosted AS VARCHAR(12)) as DatePosted," +
                                                   " dbo.Tbl_Lookbooks.DatePosted as [dated] FROM dbo.Tbl_Brands " +
                                                   " INNER JOIN dbo.Tbl_Lookbooks ON dbo.Tbl_Brands.UserID = dbo.Tbl_Lookbooks.UserID " +
                                                   " INNER JOIN dbo.Tbl_LbCategory ON dbo.Tbl_Lookbooks.LookID = dbo.Tbl_LbCategory.LookID " +
                                                   " INNER JOIN dbo.Tbl_Categories ON dbo.Tbl_Categories.CategoryID = dbo.Tbl_LbCategory.CategoryID " +
                                                   "Where dbo.Tbl_Brands.UserID={0} AND Tbl_LbCategory.CategoryID={1} dbo.Tbl_Lookbooks.IsDeleted IS NULL AND dbo.Tbl_Lookbooks.IsPublished=1 " +
                                                   "ORDER BY dbo.Tbl_Lookbooks.DatePosted DESC",
                                                   IEUtils.ToInt(httpCookie.Value), categryId);

                //rptLookbook.DataSourceID = "";
                //rptLookbook.DataSource = db.ExecuteReader(qryCategory);
                }
            //rptLookbook.DataBind();
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
                                                 " dbo.Tbl_Brands.Logo, dbo.Tbl_Lookbooks.LookID, dbo.Tbl_Lookbooks.Title, " +
                                                 " LookKey, dbo.Tbl_Lookbooks.Description, dbo.Tbl_Lookbooks.MainImg, " +
                                                 " dbo.Tbl_Lookbooks.Views, CAST(dbo.Tbl_Lookbooks.DatePosted AS VARCHAR(12)) as DatePosted," +
                                                 " dbo.Tbl_Lookbooks.DatePosted as [dated] FROM dbo.Tbl_Brands " +
                                                 " INNER JOIN dbo.Tbl_Lookbooks ON dbo.Tbl_Brands.UserID = dbo.Tbl_Lookbooks.UserID " +
                                                 " INNER JOIN dbo.Tbl_LbSeasons ON dbo.Tbl_Lookbooks.LookID = dbo.Tbl_LbSeasons.LookID " +
                                                 " INNER JOIN dbo.Tbl_Seasons ON dbo.Tbl_Seasons.SeasonID = dbo.Tbl_LbSeasons.SeasonID " +
                                                 "Where dbo.Tbl_Brands.UserID={0} AND Tbl_LbSeasons.SeasonID={1} dbo.Tbl_Lookbooks.IsDeleted IS NULL AND dbo.Tbl_Lookbooks.IsPublished=1 " +
                                                 "ORDER BY dbo.Tbl_Lookbooks.DatePosted DESC",
                                                 IEUtils.ToInt(httpCookie.Value), seasonId);

                //rptLookbook.DataSourceID = "";
                //rptLookbook.DataSource = db.ExecuteReader(qrySeason);
                }
            //rptLookbook.DataBind();
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
                                                  " dbo.Tbl_Brands.Logo, dbo.Tbl_Lookbooks.ItemID, dbo.Tbl_Lookbooks.Title, " +
                                                  " LookKey, dbo.Tbl_Lookbooks.Description, dbo.Tbl_Lookbooks.MainImg, " +
                                                  " dbo.Tbl_Lookbooks.Views, CAST(dbo.Tbl_Lookbooks.DatePosted AS VARCHAR(12)) as DatePosted," +
                                                  " dbo.Tbl_Lookbooks.DatePosted as [dated] FROM dbo.Tbl_Brands " +
                                                  " INNER JOIN dbo.Tbl_Lookbooks ON dbo.Tbl_Brands.UserID = dbo.Tbl_Lookbooks.UserID " +
                                                  " INNER JOIN dbo.Tbl_LbHolidays ON dbo.Tbl_Lookbooks.LookID = dbo.Tbl_LbHolidays.LookID " +
                                                  " INNER JOIN dbo.Tbl_Holidays ON dbo.Tbl_Holidays.HolidayID = dbo.Tbl_LbHolidays.HolidayID " +
                                                  "Where dbo.Tbl_Brands.UserID={0} AND Tbl_LbHolidays.HolidayID={1} dbo.Tbl_Lookbooks.IsDeleted IS NULL AND dbo.Tbl_Lookbooks.IsPublished=1 " +
                                                  "ORDER BY dbo.Tbl_Lookbooks.DatePosted DESC",
                                                  IEUtils.ToInt(httpCookie.Value), holidayId);

                //rptLookbook.DataSourceID = "";
                //rptLookbook.DataSource = db.ExecuteReader(qryHoliday);
                }
            //rptLookbook.DataBind();
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
    //                string qrySearch = "SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, dbo.Tbl_Brands.Logo, Tbl_Lookbooks.LookID," +
    //                                   " Tbl_Lookbooks.Title, Tbl_Lookbooks.LookKey, Tbl_Lookbooks.Description, Tbl_Lookbooks.MainImg, Tbl_Lookbooks.Views," +
    //                                   " CAST(Tbl_Lookbooks.DatePosted AS VARCHAR(12)) as DatePosted, Tbl_Lookbooks.DatePosted as [dated] FROM dbo.Tbl_Brands " +
    //                                   " INNER JOIN Tbl_Lookbooks ON dbo.Tbl_Brands.UserID = Tbl_Lookbooks.UserID " +
    //                                   " Where dbo.Tbl_Brands.UserID =" + Convert.ToInt32(httpCookie.Value) + " AND Tbl_Lookbooks.Title LIKE '" + txtsearch.Text + "%'  AND Tbl_Lookbooks.IsDeleted IS NULL AND Tbl_Lookbooks.IsPublished = 1 " +
    //                                   " ORDER BY Tbl_Lookbooks.DatePosted DESC";
    //                cmd.CommandText = qrySearch;
    //            }
    //            cmd.Connection = con;
    //            con.Open();

    //            rptLookbook.DataSourceID = "";
    //            rptLookbook.DataSource = cmd.ExecuteReader();
    //            rptLookbook.DataBind();
    //            con.Close();

    //        }
    //    }
    //}

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
                    string qrySearch = "SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, dbo.Tbl_Brands.Logo, Tbl_Lookbooks.LookID," +
                                     " Tbl_Lookbooks.Title, Tbl_Lookbooks.LookKey, Tbl_Lookbooks.Description, Tbl_Lookbooks.MainImg, Tbl_Lookbooks.Views," +
                                     " CAST(Tbl_Lookbooks.DatePosted AS VARCHAR(12)) as DatePosted, Tbl_Lookbooks.DatePosted as [dated] FROM dbo.Tbl_Brands " +
                                     " INNER JOIN Tbl_Lookbooks ON dbo.Tbl_Brands.UserID = Tbl_Lookbooks.UserID " +
                                     " Where dbo.Tbl_Brands.UserID =" + Convert.ToInt32(httpCookie.Value) + " AND Tbl_Lookbooks.Title LIKE '" + txtsearch.Text + "%'  AND Tbl_Lookbooks.IsDeleted IS NULL AND Tbl_Lookbooks.IsPublished = 1 " +
                                     " ORDER BY Tbl_Lookbooks.DatePosted DESC";
                    cmd.CommandText = qrySearch;
                    }
                cmd.Connection = con;
                con.Open();

                //rptLookbook.DataSourceID = "";
                //rptLookbook.DataSource = cmd.ExecuteReader();
                //rptLookbook.DataBind();
                con.Close();

                }
            }
        }
    //protected void rptLookbook_ItemCommand(object source, RepeaterCommandEventArgs e)
    //{
    //    try
    //    {
    //        if(e.CommandName=="1")
    //        {
    //            var db=new DatabaseManagement();
    //            string deleteQuery = string.Format("Update Tbl_Lookbooks set IsDeleted='1'  Where LookID={0}",
    //                                               IEUtils.ToInt(e.CommandArgument));
    //            db.ExecuteSQL(deleteQuery);
    //            rptLookbook.DataBind();
    //            ErrorMessage.ShowSuccessAlert(lblStatus,"Lookbook Deleted !", divAlerts);
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
    //    }
    //}

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


    /******************************************************** Web Methods ********************************************/
    [WebMethod, ScriptMethod]
    public static List<Lookbook> GetData(int pageIndex)
        {
        try
            {
            int pagesize = 10;
            var lookbookList = new List<Lookbook>();
            var db = new DatabaseManagement();
            var httpCookie = HttpContext.Current.Request.Cookies["FrUserID"];
            if (httpCookie != null)
                {
                var cmd = new SqlCommand("GetLookBooksDefault");
                db._sqlConnection.Open();
                cmd.Connection = db._sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
                cmd.Parameters.AddWithValue("@UserId", IEUtils.ToInt(httpCookie.Value));
                cmd.Parameters.AddWithValue("@PageSize", 10);
                cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                int pageCount = Convert.ToInt32(cmd.Parameters["@PageCount"].Value);
                SqlDataReader dr = cmd.ExecuteReader();
                int startItems = ((pageIndex - 1) * pagesize) + 1;
                int endItems = (startItems + pagesize) - 1;
                int tempCount = 1;
                if (dr.HasRows)
                    {
                    while (dr.Read())
                        {
                        DateTime dbDate = Convert.ToDateTime(dr["DatePosted"].ToString());
                        var objLb = new Lookbook
                        {
                            PageCount = pageCount,
                            LookBookKey = dr["LookKey"].ToString(),
                            Name = dr["Name"].ToString(),
                            LookId = Convert.ToInt32(dr["LookID"]),
                            ProfilePic = dr["U_ProfilePic"].ToString(),
                            RowNum = IEUtils.ToInt(dr["row"]),
                            Title = dr["Title"].ToString(),
                            Likes = LbLikes(IEUtils.ToInt(dr["LookID"])),
                            Views = IEUtils.ToInt(dr["Views"]),
                            BrandId = IEUtils.ToInt(dr["BrandID"]),
                            BrandKey = dr["BrandKey"].ToString(),
                            DatePosted = dr["DatePosted"].ToString(),
                            Dated = Common.GetRelativeTime(dbDate),
                            Description = dr["Description"].ToString(),
                            FeatureImg = dr["MainImg"].ToString()
                        };
                        if (tempCount >= startItems && tempCount <= endItems)
                            {
                            lookbookList.Add(objLb);
                            }
                        tempCount++;
                        //lookbookList.Add(objLb);

                        }
                    }

                }

            return lookbookList;


            }
        catch (Exception ex)
            {
            return null;
            }
        }

    [WebMethod, ScriptMethod]
    public static List<Lookbook> GetDataByCategory(int pageIndex, int categoryid)
        {
        try
            {
            int pagesize = 10;
            //StringBuilder getPostsText = new StringBuilder();
            var lookbookList = new List<Lookbook>();
            var db = new DatabaseManagement();

            var httpCookie = HttpContext.Current.Request.Cookies["FrUserID"];
            if (httpCookie != null)
                {
                var cmd = new SqlCommand("GetLookBooksByCategory");
                db._sqlConnection.Open();
                cmd.Connection = db._sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
                cmd.Parameters.AddWithValue("@UserId", IEUtils.ToInt(httpCookie.Value));
                cmd.Parameters.AddWithValue("@CategoryID", categoryid);
                cmd.Parameters.AddWithValue("@PageSize", 10);
                cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                int pageCount = Convert.ToInt32(cmd.Parameters["@PageCount"].Value);
                SqlDataReader dr = cmd.ExecuteReader();
                int startItems = ((pageIndex - 1) * pagesize) + 1;
                int endItems = (startItems + pagesize) - 1;
                int tempCount = 1;
                if (dr.HasRows)
                    {
                    while (dr.Read())
                        {
                        DateTime dbDate = Convert.ToDateTime(dr["DatePosted"].ToString());
                        var objLb = new Lookbook
                        {
                            PageCount = pageCount,
                            LookBookKey = dr["LookKey"].ToString(),
                            Name = dr["Name"].ToString(),
                            LookId = Convert.ToInt32(dr["LookID"]),
                            ProfilePic = dr["U_ProfilePic"].ToString(),
                            RowNum = IEUtils.ToInt(dr["row"]),
                            Title = dr["Title"].ToString(),
                            Likes = LbLikes(IEUtils.ToInt(dr["LookID"])),
                            Views = IEUtils.ToInt(dr["Views"]),
                            BrandId = IEUtils.ToInt(dr["BrandID"]),
                            BrandKey = dr["BrandKey"].ToString(),
                            DatePosted = dr["DatePosted"].ToString(),
                            Dated = Common.GetRelativeTime(dbDate),
                            Description = dr["Description"].ToString(),
                            FeatureImg = dr["MainImg"].ToString()
                        };

                        if (tempCount >= startItems && tempCount <= endItems)
                            {
                            lookbookList.Add(objLb);
                            }
                        tempCount++;
                        //lookbookList.Add(objLb);

                        }
                    }

                }

            return lookbookList;


            }
        catch (Exception ex)
            {
            return null;
            }
        }

    [WebMethod, ScriptMethod]
    public static List<Lookbook> GetDataBySeason(int pageIndex, int seasonid)
        {
        try
            {
            int pagesize = 10;
            //StringBuilder getPostsText = new StringBuilder();
            var lookbookList = new List<Lookbook>();
            var db = new DatabaseManagement();

            var httpCookie = HttpContext.Current.Request.Cookies["FrUserID"];
            if (httpCookie != null)
                {
                var cmd = new SqlCommand("GetLookBooksBySeason");
                db._sqlConnection.Open();
                cmd.Connection = db._sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
                cmd.Parameters.AddWithValue("@UserId", IEUtils.ToInt(httpCookie.Value));
                cmd.Parameters.AddWithValue("@SeasonID", seasonid);
                cmd.Parameters.AddWithValue("@PageSize", 10);
                cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                int pageCount = Convert.ToInt32(cmd.Parameters["@PageCount"].Value);
                SqlDataReader dr = cmd.ExecuteReader();
                int startItems = ((pageIndex - 1) * pagesize) + 1;
                int endItems = (startItems + pagesize) - 1;
                int tempCount = 1;
                if (dr.HasRows)
                    {
                    while (dr.Read())
                        {
                        DateTime dbDate = Convert.ToDateTime(dr["DatePosted"].ToString());

                        var objLb = new Lookbook
                        {
                            PageCount = pageCount,
                            LookBookKey = dr["LookKey"].ToString(),
                            Name = dr["Name"].ToString(),
                            LookId = Convert.ToInt32(dr["LookID"]),
                            ProfilePic = dr["U_ProfilePic"].ToString(),
                            RowNum = IEUtils.ToInt(dr["row"]),
                            Title = dr["Title"].ToString(),
                            Likes = LbLikes(IEUtils.ToInt(dr["LookID"])),
                            Views = IEUtils.ToInt(dr["Views"]),
                            BrandId = IEUtils.ToInt(dr["BrandID"]),
                            BrandKey = dr["BrandKey"].ToString(),
                            DatePosted = dr["DatePosted"].ToString(),
                            Dated = Common.GetRelativeTime(dbDate),
                            Description = dr["Description"].ToString(),
                            FeatureImg = dr["MainImg"].ToString()
                        };

                        if (tempCount >= startItems && tempCount <= endItems)
                            {
                            lookbookList.Add(objLb);
                            }
                        tempCount++;
                        //lookbookList.Add(objLb);

                        }
                    }

                }

            return lookbookList;


            }
        catch (Exception ex)
            {
            return null;
            }

        }

    [WebMethod, ScriptMethod]
    public static List<Lookbook> GetDataByHoliday(int pageIndex, int holidayid)
        {
        try
            {
            int pagesize = 10;
            //StringBuilder getPostsText = new StringBuilder();
            var lookbookList = new List<Lookbook>();
            var db = new DatabaseManagement();

            var httpCookie = HttpContext.Current.Request.Cookies["FrUserID"];
            if (httpCookie != null)
                {
                var cmd = new SqlCommand("GetLookBooksByHoliday");
                db._sqlConnection.Open();
                cmd.Connection = db._sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
                cmd.Parameters.AddWithValue("@UserId", IEUtils.ToInt(httpCookie.Value));
                cmd.Parameters.AddWithValue("@HolidayID", holidayid);
                cmd.Parameters.AddWithValue("@PageSize", 10);
                cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                int pageCount = Convert.ToInt32(cmd.Parameters["@PageCount"].Value);
                SqlDataReader dr = cmd.ExecuteReader();
                int startItems = ((pageIndex - 1) * pagesize) + 1;
                int endItems = (startItems + pagesize) - 1;
                int tempCount = 1;
                if (dr.HasRows)
                    {
                    while (dr.Read())
                        {
                        DateTime dbDate = Convert.ToDateTime(dr["DatePosted"].ToString());

                        var objLb = new Lookbook
                        {
                            PageCount = pageCount,
                            LookBookKey = dr["LookKey"].ToString(),
                            Name = dr["Name"].ToString(),
                            LookId = Convert.ToInt32(dr["LookID"]),
                            ProfilePic = dr["U_ProfilePic"].ToString(),
                            RowNum = IEUtils.ToInt(dr["row"]),
                            Title = dr["Title"].ToString(),
                            Likes = LbLikes(IEUtils.ToInt(dr["LookID"])),
                            Views = IEUtils.ToInt(dr["Views"]),
                            BrandId = IEUtils.ToInt(dr["BrandID"]),
                            BrandKey = dr["BrandKey"].ToString(),
                            DatePosted = dr["DatePosted"].ToString(),
                            Dated = Common.GetRelativeTime(dbDate),
                            Description = dr["Description"].ToString(),
                            FeatureImg = dr["MainImg"].ToString()
                        };

                        if (tempCount >= startItems && tempCount <= endItems)
                            {
                            lookbookList.Add(objLb);
                            }
                        tempCount++;

                        }
                    }

                }

            return lookbookList;


            }
        catch (Exception ex)
            {
            return null;
            }

        return null;
        }


    [WebMethod, ScriptMethod]
    public static void DeleteItem(string id)
        {
        var db = new DatabaseManagement();
        string deleteQuery = string.Format("Delete From Tbl_Lookbooks Where LookID={0}",
                                               IEUtils.ToInt(id));
        db.ExecuteSQL(deleteQuery);
        db._sqlConnection.Close();
        db._sqlConnection.Dispose();

        }

    [WebMethod, ScriptMethod]
    public static List<Lookbook> GetDataByTitle(int pageIndex, string title)
        {
        try
            {
            int pagesize = 10;
            //StringBuilder getPostsText = new StringBuilder();
            var lookbookList = new List<Lookbook>();
            var db = new DatabaseManagement();

            var httpCookie = HttpContext.Current.Request.Cookies["FrUserID"];
            if (httpCookie != null)
                {
                var cmd = new SqlCommand("GetLookBooksByTitle");
                db._sqlConnection.Open();
                cmd.Connection = db._sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
                cmd.Parameters.AddWithValue("@UserId", IEUtils.ToInt(httpCookie.Value));
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@PageSize", 10);
                cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                int pageCount = Convert.ToInt32(cmd.Parameters["@PageCount"].Value);
                SqlDataReader dr = cmd.ExecuteReader();
                int startItems = ((pageIndex - 1) * pagesize) + 1;
                int endItems = (startItems + pagesize) - 1;
                int tempCount = 1;
                if (dr.HasRows)
                    {
                    while (dr.Read())
                        {
                        DateTime dbDate = Convert.ToDateTime(dr["DatePosted"].ToString());

                        var objLb = new Lookbook
                        {
                            PageCount = pageCount,
                            LookBookKey = dr["LookKey"].ToString(),
                            Name = dr["Name"].ToString(),
                            ProfilePic = dr["U_ProfilePic"].ToString(),
                            RowNum = IEUtils.ToInt(dr["row"]),
                            Title = dr["Title"].ToString(),
                            Likes = LbLikes(IEUtils.ToInt(dr["LookID"])),
                            Views = IEUtils.ToInt(dr["Views"]),
                            BrandId = IEUtils.ToInt(dr["BrandID"]),
                            BrandKey = dr["BrandKey"].ToString(),
                            DatePosted = dr["DatePosted"].ToString(),
                            Dated = Common.GetRelativeTime(dbDate),
                            Description = dr["Description"].ToString(),
                            FeatureImg = dr["MainImg"].ToString()
                        };

                        if (tempCount >= startItems && tempCount <= endItems)
                            {
                            lookbookList.Add(objLb);
                            }
                        tempCount++;

                        }
                    }

                }

            return lookbookList;


            }
        catch (Exception ex)
            {
            return null;
            }

        }



    /******************************************************** Web Methods End ***************************************/


    }