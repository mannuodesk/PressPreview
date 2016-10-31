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

public partial class lookbookDetails : System.Web.UI.Page
{
    private static int LookId;
    protected void Page_Load(object sender, EventArgs e)
    {
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        if (!IsPostBack)
        {
            try
            {
                LoadBrandData();
                LoadLookBook();
              
                SetTotalViews();
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
    protected void LoadLookBook()
    {
        var db = new DatabaseManagement();
        string LbData = string.Format("SELECT LookID, Description, Views From Tbl_Lookbooks Where LookKey={0}",
                                      IEUtils.SafeSQLString(Request.QueryString["k"]));
        SqlDataReader dr = db.ExecuteReader(LbData);
        if (dr.HasRows)
        {
            dr.Read();
            lblDescription.Text = Server.HtmlDecode(dr[1].ToString());
            LookId = IEUtils.ToInt(dr[0]);
            lblTotolViews.Text = dr.IsDBNull(2) ? "0" : dr[2].ToString();


        }
        dr.Close();
        dr.Dispose();
        db._sqlConnection.Close();
    }
    protected void SetTotalViews()
    {
        try
        {
            var db = new DatabaseManagement();
            string isAlreadyViewd = string.Format("SELECT ID From Tbl_Lb_Views Where LookID={0} AND UserID={1}",
                                                 LookId,
                                                   IEUtils.ToInt(Session["UserID"]));
            SqlDataReader dr = db.ExecuteReader(isAlreadyViewd);
            if (!dr.HasRows)
            {
                dr.Close();
                dr.Dispose();
                string addview = string.Format("INSERT INTO Tbl_Lb_Views(LookID,UserID,ViewDate) VALUES({0},{1},{2})",
                    LookId,
                    IEUtils.ToInt(Session["UserID"]),
                    IEUtils.SafeSQLDate(DateTime.UtcNow));
                db.ExecuteSQL(addview);
                int totalViews = Convert.ToInt32(lblTotolViews.Text) + 1;
                string qryViews = string.Format("UPDATE Tbl_Lookbooks Set Views" +
                                                "={0}  Where LookID={1}", totalViews, LookId);
                db.ExecuteSQL(qryViews);
                lblTotolViews.Text = totalViews.ToString();

            }

            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }

    }
    //protected void BrandLikes()
    //{
    //    try
    //    {
    //        var db = new DatabaseManagement();
    //        string followers = string.Format("SELECT COUNT(Id) as TotalLikes From Tbl_BrandsLikes Where UserID=(SELECT UserID From Tbl_Users Where UserKey={0})", IEUtils.SafeSQLString(Request.QueryString["v"]));
    //        SqlDataReader dr = db.ExecuteReader(followers);
    //        int result = 0;
    //        if (dr.HasRows)
    //        {
    //            dr.Read();
    //            if (!dr.IsDBNull(0))
    //                result = Convert.ToInt32(dr[0]);
    //        }
    //        dr.Close();
    //        lblTotolLikes.Text = result.ToString();
    //    }
    //    catch (Exception ex)
    //    {
    //        ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
    //    }

    //}

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
                con.Close();
                db._sqlConnection.Close();
                return empResult;
            }

        }

    }

    protected void LoadBrandData()
    {
        try
        {
            var db = new DatabaseManagement();
           
                string BrandData = string.Format("Select Name,Url,City,Country, Bio,TotalViews, U_ProfilePic,U_CoverPic,Url,History From Tbl_Brands INNER JOIN Tbl_Users ON Tbl_Brands.UserID=Tbl_Users.UserID Where Tbl_Brands.UserID=(SELECT UserID From Tbl_Users Where UserKey={0})", IEUtils.SafeSQLString(Request.QueryString["v"]));
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
                   // lblAbout.Text = dr[4].ToString();
                    if (dr.IsDBNull(5))
                        lblTotolViews.Text = "0";
                    else
                        lblTotolViews.Text = dr[5].ToString();
                    lbWebURL.InnerText = dr[8].ToString();
                    lbWebURL.HRef = "http://" + dr[8].ToString();
                   // lblHistory.Text = dr[9].ToString();
                }
                dr.Close();
            
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
            DatabaseManagement db = new DatabaseManagement();
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
        catch (Exception ex)
        {
          //  ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
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
    

    protected void txtsearch_TextChanged(object sender, EventArgs e)
    {
        var db = new DatabaseManagement();
        using (var con = new SqlConnection(db.ConnectionString))
        {
            using (var cmd = new SqlCommand())
            {
                
                    string qrySearch = "SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, dbo.Tbl_Brands.Logo, Tbl_Lookbooks.LookID," +
                                       " Tbl_Lookbooks.Title, Tbl_Lookbooks.LookKey, Tbl_Lookbooks.Description, Tbl_Lookbooks.MainImg, Tbl_Lookbooks.Views," +
                                       " CAST(Tbl_Lookbooks.DatePosted AS VARCHAR(12)) as DatePosted, Tbl_Lookbooks.DatePosted as [dated] FROM dbo.Tbl_Brands " +
                                       " INNER JOIN Tbl_Lookbooks ON dbo.Tbl_Brands.UserID = Tbl_Lookbooks.UserID " +
                                       " Where dbo.Tbl_Brands.UserID =(SELECT UserID From Tbl_Users Where UserKey=" + IEUtils.SafeSQLString(Request.QueryString["v"]) + ") AND Tbl_Lookbooks.Title LIKE '" + txtsearch.Text + "%'  AND Tbl_Lookbooks.IsDeleted IS NULL AND Tbl_Lookbooks.IsPublished = 1  " +
                                       " ORDER BY Tbl_Lookbooks.DatePosted DESC";
                    cmd.CommandText = qrySearch;
                
                cmd.Connection = con;
                con.Open();

                //rptLookbook.DataSourceID = "";
                //rptLookbook.DataSource = cmd.ExecuteReader();
                //rptLookbook.DataBind();
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
                
                    string qrySearch = "SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, dbo.Tbl_Brands.Logo, Tbl_Lookbooks.LookID," +
                                     " Tbl_Lookbooks.Title, Tbl_Lookbooks.LookKey, Tbl_Lookbooks.Description, Tbl_Lookbooks.MainImg, Tbl_Lookbooks.Views," +
                                     " CAST(Tbl_Lookbooks.DatePosted AS VARCHAR(12)) as DatePosted, Tbl_Lookbooks.DatePosted as [dated] FROM dbo.Tbl_Brands " +
                                     " INNER JOIN Tbl_Lookbooks ON dbo.Tbl_Brands.UserID = Tbl_Lookbooks.UserID " +
                                     " Where dbo.Tbl_Brands.UserID =(SELECT UserID From Tbl_Users Where UserKey=" + IEUtils.SafeSQLString(Request.QueryString["v"]) + ") AND Tbl_Lookbooks.Title LIKE '" + txtsearch.Text + "%'  AND Tbl_Lookbooks.IsDeleted IS NULL AND Tbl_Lookbooks.IsPublished = 1 " +
                                     " ORDER BY Tbl_Lookbooks.DatePosted DESC";
                    cmd.CommandText = qrySearch;
                
                cmd.Connection = con;
                con.Open();

                //rptLookbook.DataSourceID = "";
                //rptLookbook.DataSource = cmd.ExecuteReader();
                //rptLookbook.DataBind();
                con.Close();

            }
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

    protected static int GetUserID(string v)
    {
        var db = new DatabaseManagement();
        return
            Convert.ToInt32(
                db.GetExecuteScalar(string.Format("SELECT UserID From Tbl_Users Where UserKey={0}",v)));

    }
    [WebMethod, ScriptMethod]
    public static List<Items> GetData(int pageIndex, string lookId,string v)
    {
        try
        {
            //StringBuilder getPostsText = new StringBuilder();
            var itemList = new List<Items>();
            var db = new DatabaseManagement();

            var httpCookie = HttpContext.Current.Request.Cookies["FrUserID"];
            if (httpCookie != null)
            {
                var cmd = new SqlCommand("GetLookBookItems_PageWise");
                db._sqlConnection.Open();
                cmd.Connection = db._sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
                cmd.Parameters.AddWithValue("@UserId", GetUserID(v));
                cmd.Parameters.AddWithValue("@LookKey", lookId);
                cmd.Parameters.AddWithValue("@PageSize", 10);
                cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                int pageCount = Convert.ToInt32(cmd.Parameters["@PageCount"].Value);
                SqlDataReader dr = cmd.ExecuteReader();

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

                        itemList.Add(objitem);

                    }
                }

            }

            return itemList;


        }
        catch (Exception ex)
        {
            // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }

        return null;
    }

    [WebMethod, ScriptMethod]
    public static List<Items> GetDataByCategory(int pageIndex, int categoryid, string lookId,string v)
    {
        try
        {
            //StringBuilder getPostsText = new StringBuilder();
            var itemList = new List<Items>();
            var db = new DatabaseManagement();

            var httpCookie = HttpContext.Current.Request.Cookies["FrUserID"];
            if (httpCookie != null)
            {
                var cmd = new SqlCommand("GetLookBookItems_ByCategory");
                db._sqlConnection.Open();
                cmd.Connection = db._sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
                cmd.Parameters.AddWithValue("@UserId", GetUserID(v));
                cmd.Parameters.AddWithValue("@LookKey", lookId);
                cmd.Parameters.AddWithValue("@CategoryID", categoryid);
                cmd.Parameters.AddWithValue("@PageSize", 10);
                cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                int pageCount = Convert.ToInt32(cmd.Parameters["@PageCount"].Value);
                SqlDataReader dr = cmd.ExecuteReader();

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

                        itemList.Add(objitem);

                    }
                }

            }

            return itemList;


        }
        catch (Exception ex)
        {
            // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }

        return null;
    }

    [WebMethod, ScriptMethod]
    public static List<Items> GetDataBySeason(int pageIndex, int seasonid, string lookId,string v)
    {
        try
        {
            //StringBuilder getPostsText = new StringBuilder();
            var itemList = new List<Items>();
            var db = new DatabaseManagement();

            var httpCookie = HttpContext.Current.Request.Cookies["FrUserID"];
            if (httpCookie != null)
            {
                var cmd = new SqlCommand("GetLookBookItems_BySeason");
                db._sqlConnection.Open();
                cmd.Connection = db._sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
                cmd.Parameters.AddWithValue("@UserId", GetUserID(v));
                cmd.Parameters.AddWithValue("@LookKey", lookId);
                cmd.Parameters.AddWithValue("@SeasonID", seasonid);
                cmd.Parameters.AddWithValue("@PageSize", 10);
                cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                int pageCount = Convert.ToInt32(cmd.Parameters["@PageCount"].Value);
                SqlDataReader dr = cmd.ExecuteReader();

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

                        itemList.Add(objitem);

                    }
                }

            }

            return itemList;


        }
        catch (Exception ex)
        {
            // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }

        return null;
    }

    [WebMethod, ScriptMethod]
    public static List<Items> GetDataByHoliday(int pageIndex, int holidayid, string lookId,string v)
    {
        try
        {
            //StringBuilder getPostsText = new StringBuilder();
            var itemList = new List<Items>();
            var db = new DatabaseManagement();

            var httpCookie = HttpContext.Current.Request.Cookies["FrUserID"];
            if (httpCookie != null)
            {
                var cmd = new SqlCommand("GetLookBookItems_ByHoliday");
                db._sqlConnection.Open();
                cmd.Connection = db._sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
                cmd.Parameters.AddWithValue("@UserId", GetUserID(v));
                cmd.Parameters.AddWithValue("@LookKey", lookId);
                cmd.Parameters.AddWithValue("@HolidayID", holidayid);
                cmd.Parameters.AddWithValue("@PageSize", 10);
                cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                int pageCount = Convert.ToInt32(cmd.Parameters["@PageCount"].Value);
                SqlDataReader dr = cmd.ExecuteReader();

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

                        itemList.Add(objitem);

                    }
                }

            }

            return itemList;


        }
        catch (Exception ex)
        {
            // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }

        return null;
    }

    [WebMethod, ScriptMethod]
    public static List<Items> GetDataByTitle(int pageIndex, string title, string lookId, string v)
    {
        try
        {
            //StringBuilder getPostsText = new StringBuilder();
            var itemList = new List<Items>();
            var db = new DatabaseManagement();

            var httpCookie = HttpContext.Current.Request.Cookies["FrUserID"];
            if (httpCookie != null)
            {
                var cmd = new SqlCommand("GetLookBookItems_ByTitle");
                db._sqlConnection.Open();
                cmd.Connection = db._sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
                cmd.Parameters.AddWithValue("@UserId", GetUserID(v));
                cmd.Parameters.AddWithValue("@LookKey", lookId);
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@PageSize", 10);
                cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                int pageCount = Convert.ToInt32(cmd.Parameters["@PageCount"].Value);
                SqlDataReader dr = cmd.ExecuteReader();

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

                        itemList.Add(objitem);

                    }
                }

            }

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
        db.ExecuteSQL(deleteQuery);
        db._sqlConnection.Close();
        db._sqlConnection.Dispose();

    }

    
}