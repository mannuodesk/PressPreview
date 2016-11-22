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
using System.Text.RegularExpressions;
using HtmlAgilityPack;

public partial class home : System.Web.UI.Page
{
    private int _brandID;
    protected void Page_Load(object sender, EventArgs e)
    {
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
        if (!IsPostBack)
        {
            try
            {
                
                LoadBrandData();
                SetTotalViews();
                LikesColor();
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
            lblTotolLikes.Text = result.ToString();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }

    }


    protected void LikesColor()
    {
        try
        {
            DatabaseManagement db = new DatabaseManagement();
             var httpCookie = HttpContext.Current.Request.Cookies["FrUserID"];
            string followers = string.Format("SELECT * From Tbl_BrandsLikes Where UserID=(SELECT UserID From Tbl_Users Where UserKey={0}) AND LikeID={1}", IEUtils.SafeSQLString(Request.QueryString["v"]),IEUtils.ToInt(httpCookie.Value));
            SqlDataReader dr = db.ExecuteReader(followers);
            int result = 0;
            if (dr.HasRows)
            {
                LikeItem.ForeColor = System.Drawing.ColorTranslator.FromHtml("#4c92c6");
                LikeIcon.Style.Add("color", "#4c92c6");
            }
            dr.Close();
            lblTotolLikes.Text = result.ToString();
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
    protected void SetTotalViews()
    {
        try
        {
            var db = new DatabaseManagement();
            string isAlreadyViewd = string.Format("SELECT ID From Tbl_Brand_Views Where BrandID={0} AND UserID={1}",
                                                 _brandID,
                                                   IEUtils.ToInt(Session["UserID"]));
            SqlDataReader dr = db.ExecuteReader(isAlreadyViewd);
            if (!dr.HasRows)
            {
                dr.Close();
                dr.Dispose();
                string addview = string.Format("INSERT INTO Tbl_Brand_Views(BrandID,UserID,ViewDate) VALUES({0},{1},{2})",
                    _brandID,
                    IEUtils.ToInt(Session["UserID"]),
                    IEUtils.SafeSQLDate(DateTime.UtcNow));
                db.ExecuteSQL(addview);
                int totalViews = Convert.ToInt32(lblTotolViews.Text) + 1;
                string qryViews = string.Format("UPDATE Tbl_Brands Set TotalViews" +
                                                "={0}  Where BrandID={1}", totalViews, _brandID);
                db.ExecuteSQL(qryViews);

            }
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
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
            string BrandData = string.Format("Select Name,Url,City,Country, Bio,TotalViews, U_ProfilePic,U_CoverPic,Url,History From Tbl_Brands INNER JOIN Tbl_Users ON Tbl_Brands.UserID=Tbl_Users.UserID Where Tbl_Brands.UserID=(SELECT UserID From Tbl_Users Where UserKey={0})", IEUtils.SafeSQLString(Request.QueryString["v"]));
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
                lblAbout.Text = dr[4].ToString();
                if (dr.IsDBNull(5))
                    lblTotolViews.Text = "0";
                else
                    lblTotolViews.Text = (Convert.ToInt32(dr[5]) + 1).ToString();
                lbWebURL.InnerText = dr[8].ToString();
                lbWebURL.HRef = "http://" + dr[8].ToString().Replace("http://", "");
                lblHistory.Text = dr[9].ToString();
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
            //  ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            return 0;
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
    private static List<Items> sortListBySortOrder(List<Items> itemsList)
    {

        for (int iCounter = 0; iCounter < itemsList.Count; iCounter++)
        {
            for (int jCounter = 0; jCounter < itemsList.Count; jCounter++)
            {
                if (itemsList[iCounter].ItemId > itemsList[jCounter].ItemId)
                {
                    Items temp = new Items();
                    temp = itemsList[iCounter];
                    itemsList[iCounter] = itemsList[jCounter];
                    itemsList[jCounter] = temp;
                }
            }
        }
        return itemsList;
    }
    [WebMethod, ScriptMethod]
    public static List<Items> GetData(int pageIndex, string v)
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
                var cmd = new SqlCommand("GetBrandItemsPageWise");
                db._sqlConnection.Open();
                cmd.Connection = db._sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", 1);
                cmd.Parameters.AddWithValue("@UserKey", v);
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
                        string selectDBTime = string.Format("Select DatePosted from Tbl_Items Where ItemID={0}", objitem.ItemId);
                        DatabaseManagement db1 = new DatabaseManagement();
                        SqlDataReader dr1 = db1.ExecuteReader(selectDBTime);
                        if (dr1.HasRows)
                        {
                            dr1.Read();
                            dbDate = Convert.ToDateTime(dr1[0]);
                            objitem.Dated = Common.GetRelativeTime(dbDate);
                        }
                        var pageDoc = new HtmlDocument();
                        pageDoc.LoadHtml(objitem.Description);
                        desc = pageDoc.DocumentNode.InnerText;
                        objitem.Description = desc;
                        if (tempCount >= startItems && tempCount <= endItems)
                        {

                            itemList.Add(objitem);
                        }
                        tempCount++;
                        //itemList.Add(objitem);

                    }
                }

            }
            sortListBySortOrder(itemList);
            return itemList;


        }
        catch (Exception ex)
        {
            // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }

        return null;
    }

    [WebMethod, ScriptMethod]
    public static List<Items> GetDataByCategory(int pageIndex, int categoryid, string v)
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
                var cmd = new SqlCommand("GetBrandItems_ByCategory");
                db._sqlConnection.Open();
                cmd.Connection = db._sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", 1);
                cmd.Parameters.AddWithValue("@UserKey", v);
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

            }
            sortListBySortOrder(itemList);
            return itemList;


        }
        catch (Exception ex)
        {
            // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }

        return null;
    }
    [WebMethod, ScriptMethod]
    public static List<Items> GetDataBySeason(int pageIndex, int seasonid, string v)
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
                var cmd = new SqlCommand("GetBrandItems_BySeason");
                db._sqlConnection.Open();
                cmd.Connection = db._sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", 1);
                cmd.Parameters.AddWithValue("@UserKey", v);
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

            }
            sortListBySortOrder(itemList);
            return itemList;


        }
        catch (Exception ex)
        {
            // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }

        return null;
    }


    [WebMethod, ScriptMethod]
    public static List<Items> GetDataByHoliday(int pageIndex, int holidayid, string v)
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
                var cmd = new SqlCommand("GetBrandItems_ByHoliday");
                db._sqlConnection.Open();
                cmd.Connection = db._sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", 1);
                cmd.Parameters.AddWithValue("@UserKey", v);
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

            }
            sortListBySortOrder(itemList);
            return itemList;


        }
        catch (Exception ex)
        {
            // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }

        return null;
    }

    [WebMethod, ScriptMethod]
    public static List<Items> GetDataByTitle(int pageIndex, string title, string v)
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
                var cmd = new SqlCommand("GetBrandItems_ByTitle");
                db._sqlConnection.Open();
                cmd.Connection = db._sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", 1);
                cmd.Parameters.AddWithValue("@UserKey", v);
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

            }
            sortListBySortOrder(itemList);
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

    protected void LikeItem_Click(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
            var httpCookie = HttpContext.Current.Request.Cookies["FrUserID"];
            string selectQuery = string.Format("Select * from Tbl_BrandsLikes where LikeID={0} AND UserId=(SELECT UserID From Tbl_Users Where UserKey={1})",
                                                   IEUtils.ToInt(httpCookie.Value),
                                                   IEUtils.SafeSQLString(Request.QueryString["v"])
                                                   );
            SqlDataReader dr = db.ExecuteReader(selectQuery);
            if (dr != null && dr.HasRows)
            {
                string deleteQuery = string.Format("DELETE FROM  Tbl_BrandsLikes WHERE LikeID={0} AND UserID=(SELECT UserID From Tbl_Users Where UserKey={1})",
                                                   IEUtils.ToInt(httpCookie.Value),
                                                   IEUtils.SafeSQLString(Request.QueryString["v"])
                                                   );
                db._sqlConnection.Close();
                db._sqlConnection.Dispose();
                db = new DatabaseManagement();
                db.ExecuteSQL(deleteQuery);
            }
            else
            {

                string insertQuery = string.Format("INSERT INTO  Tbl_BrandsLikes(LikeID,UserID) Values({0},(SELECT UserID From Tbl_Users Where UserKey={1}))",
                                                   IEUtils.ToInt(httpCookie.Value),
                                                   IEUtils.SafeSQLString(Request.QueryString["v"])
                                                   );
                db._sqlConnection.Close();
                db._sqlConnection.Dispose();
                db = new DatabaseManagement();
                db.ExecuteSQL(insertQuery);
            }
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
            Response.Redirect("brand-items.aspx?v=" + Request.QueryString["v"]);
        }
        catch (Exception exc)
        {
            string str = exc.ToString();
        }
        //After receiving Theme counter Form dm please set it on that label
    }
}