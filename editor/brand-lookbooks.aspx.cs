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
using HtmlAgilityPack;

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
        }

    protected void BrandLikes()
        {
        try
            {
            var db = new DatabaseManagement();
            string followers = string.Format("SELECT COUNT(Id) as TotalLikes From Tbl_BrandsLikes Where UserID=(SELECT UserID From Tbl_Users Where UserKey={0})", IEUtils.SafeSQLString(Request.QueryString["v"]));
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
                db.CloseConnection();
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
                lblAbout.Text = dr[4].ToString();
                if (dr.IsDBNull(5))
                    lblTotolViews.Text = "0";
                else
                    lblTotolViews.Text = dr[5].ToString();
                lbWebURL.InnerText = dr[8].ToString();
                lbWebURL.HRef = "http://" + dr[8].ToString();
                lblHistory.Text = dr[9].ToString();
                }
            dr.Close();

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
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
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

    protected static int GetUserID(string v)
        {
        var db = new DatabaseManagement();
        try
            {
            string selectQuery = string.Format("SELECT UserID From Tbl_Users Where UserKey={0}", IEUtils.SafeSQLString(v));
            int userID = 0;
            userID = Convert.ToInt32(db.GetExecuteScalar(selectQuery));
            db.CloseConnection();
            return userID;
            }
        catch (Exception exc)
            {
            return 0;
            }
        }
    /******************************************************** Web Methods ********************************************/
    [WebMethod, ScriptMethod]
    public static List<Lookbook> GetData(int pageIndex, string v)
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
                cmd.Parameters.AddWithValue("@UserId", GetUserID(v));
                cmd.Parameters.AddWithValue("@PageSize", 10);
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
                                            DateTime dbDate = Convert.ToDateTime(dr["Dated"].ToString());
                        var objLb = new Lookbook
                        {
                            PageCount = pageCount,
                            LookId = Convert.ToInt32(dr["LookID"]),
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
                              string selectDBTime = string.Format("Select DatePosted from Tbl_Lookbooks Where LookId={0}", objLb.LookId);
                        DatabaseManagement db1 = new DatabaseManagement();
                        SqlDataReader dr1 = db1.ExecuteReader(selectDBTime);
                        if (dr1.HasRows)
                            {
                            dr1.Read();
                            dbDate = Convert.ToDateTime(dr1[0]);
                            objLb.Dated = Common.GetRelativeTime(dbDate);
                            }
                        var pageDoc = new HtmlDocument();
                        pageDoc.LoadHtml(objLb.Description);
                        desc = pageDoc.DocumentNode.InnerText;
                        objLb.Description = desc;
                        if (tempCount >= startItems && tempCount <= endItems)
                            {
                            lookbookList.Add(objLb);
                            }
                        tempCount++;
                        //lookbookList.Add(objLb);

                        }
                    }
                    dr.Close();
                }
                db.CloseConnection();
            return lookbookList;


            }
        catch (Exception ex)
            {
            return null;
            }
        }

    [WebMethod, ScriptMethod]
    public static List<Lookbook> GetDataByCategory(int pageIndex, int categoryid, string v)
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
                cmd.Parameters.AddWithValue("@UserId", GetUserID(v));
                cmd.Parameters.AddWithValue("@CategoryID", categoryid);
                cmd.Parameters.AddWithValue("@PageSize", 10);
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
                        var objLb = new Lookbook
                        {
                            PageCount = pageCount,
                            Name = dr["Name"].ToString(),
                            LookBookKey = dr["LookKey"].ToString(),
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
                        var pageDoc = new HtmlDocument();
                        pageDoc.LoadHtml(objLb.Description);
                        desc = pageDoc.DocumentNode.InnerText;
                        objLb.Description = desc;
                        if (tempCount >= startItems && tempCount <= endItems)
                            {
                            lookbookList.Add(objLb);
                            }
                        tempCount++;
                        //lookbookList.Add(objLb);

                        }
                    }
                    dr.Close();
                }
                db.CloseConnection();
            return lookbookList;


            }
        catch (Exception ex)
            {
            return null;
            }
        }

    [WebMethod, ScriptMethod]
    public static List<Lookbook> GetDataBySeason(int pageIndex, int seasonid, string v)
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
                cmd.Parameters.AddWithValue("@UserId", GetUserID(v));
                cmd.Parameters.AddWithValue("@SeasonID", seasonid);
                cmd.Parameters.AddWithValue("@PageSize", 10);
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

                        var objLb = new Lookbook
                        {
                            PageCount = pageCount,
                            Name = dr["Name"].ToString(),
                            LookBookKey = dr["LookKey"].ToString(),
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
                        var pageDoc = new HtmlDocument();
                        pageDoc.LoadHtml(objLb.Description);
                        desc = pageDoc.DocumentNode.InnerText;
                        objLb.Description = desc;
                        if (tempCount >= startItems && tempCount <= endItems)
                            {
                            lookbookList.Add(objLb);
                            }
                        tempCount++;
                        //lookbookList.Add(objLb);

                        }
                    }
                    dr.Close();
                }
                db.CloseConnection();
            return lookbookList;


            }
        catch (Exception ex)
            {
            return null;
            }

        }

    [WebMethod, ScriptMethod]
    public static List<Lookbook> GetDataByHoliday(int pageIndex, int holidayid, string v)
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
                cmd.Parameters.AddWithValue("@UserId", GetUserID(v));
                cmd.Parameters.AddWithValue("@HolidayID", holidayid);
                cmd.Parameters.AddWithValue("@PageSize", 10);
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

                        var objLb = new Lookbook
                        {
                            PageCount = pageCount,
                            Name = dr["Name"].ToString(),
                            LookBookKey = dr["LookKey"].ToString(),
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
                        var pageDoc = new HtmlDocument();
                        pageDoc.LoadHtml(objLb.Description);
                        desc = pageDoc.DocumentNode.InnerText;
                        objLb.Description = desc;
                        if (tempCount >= startItems && tempCount <= endItems)
                            {
                            lookbookList.Add(objLb);
                            }
                        tempCount++;
                        //lookbookList.Add(objLb);

                        }
                    }
                    dr.Close();
                }
                db.CloseConnection();
            return lookbookList;


            }
        catch (Exception ex)
            {
            return null;
            }

        return null;
        }

    [WebMethod, ScriptMethod]
    public static List<Lookbook> GetDataByTitle(int pageIndex, string title, string v)
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
                cmd.Parameters.AddWithValue("@UserId", GetUserID(v));
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@PageSize", 10);
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

                        var objLb = new Lookbook
                        {
                            PageCount = pageCount,
                            Name = dr["Name"].ToString(),
                            LookBookKey = dr["LookKey"].ToString(),
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
                        var pageDoc = new HtmlDocument();
                        pageDoc.LoadHtml(objLb.Description);
                        desc = pageDoc.DocumentNode.InnerText;
                        objLb.Description = desc;
                        if (tempCount >= startItems && tempCount <= endItems)
                            {
                            lookbookList.Add(objLb);
                            }
                        tempCount++;
                        //lookbookList.Add(objLb);

                        }
                    }
                    dr.Close();
                }
                db.CloseConnection();
            return lookbookList;


            }
        catch (Exception ex)
            {
            return null;
            }

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


    /******************************************************** Web Methods End ***************************************/


    }