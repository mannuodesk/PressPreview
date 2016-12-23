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
using HtmlAgilityPack;

public partial class editor_wishlist : System.Web.UI.Page
{
    public static HttpCookie httpCookie2;
    protected void Page_Load(object sender, EventArgs e)
    {
        httpCookie2 = Request.Cookies["FrUserID"];
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
                //   ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
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
            db.CloseConnection();
        }
        catch (Exception ex)
        {
            // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
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
                                                 "Country, ToProject,ECalendar, TotalViews,WebURL,U_ProfilePic,U_CoverPic From Tbl_Editors INNER JOIN Tbl_Users ON Tbl_Editors.UserID=Tbl_Users.UserID  Where Tbl_Editors.UserID={0}", IEUtils.ToInt(httpCookie.Value));
                SqlDataReader dr = db.ExecuteReader(BrandData);
                if (dr.HasRows)
                {
                    dr.Read();
                    lblEditorName.InnerText = dr[0].ToString();

                    lblCity.Text = dr[1].ToString();
                    lblCountry.Text = dr[2].ToString();
                    lblTotolViews.Text = dr.IsDBNull(5) ? "0" : dr[5].ToString();
                    lbWebURL.InnerText = dr[6].ToString();
                    lbWebURL.HRef = "http://" + dr[6];
                    imgCover.ImageUrl = "../profileimages/" + dr[8];
                    imgProfile.ImageUrl = "../brandslogoThumb/" + dr[7];
                    
                }
                dr.Close();
            }
            db.CloseConnection();
        }
        catch (Exception ex)
        {
            // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    //protected void rptLookbook_ItemDataBound(object sender, RepeaterItemEventArgs e)
    //    {
    //    try
    //        {
    //        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
    //            {
    //            Label lblDatePosted = (Label)e.Item.FindControl("lblDate");
    //            Label lblDate2 = (Label)e.Item.FindControl("lblDate2");
    //            DateTime dbDate = Convert.ToDateTime(lblDatePosted.Text);
    //            lblDate2.Text = Common.GetRelativeTime(dbDate);
    //            var lblLikes = (Label)e.Item.FindControl("lblLikes");
    //            lblLikes.Text = LbLikes(Convert.ToInt32(lblLikes.Text)).ToString();

    //            }
    //        }
    //    catch (Exception ex)
    //        {
    //        ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
    //        }
    //    }

    //protected int LbLikes(int lookId)
    //    {
    //    try
    //        {
    //        var db = new DatabaseManagement();
    //        string followers = string.Format("SELECT COUNT(Id) as TotalLikes From Tbl_Item_Likes  Where ItemID={0}", lookId);
    //        SqlDataReader dr = db.ExecuteReader(followers);
    //        int result = 0;
    //        if (dr.HasRows)
    //            {
    //            dr.Read();
    //            if (!dr.IsDBNull(0))
    //                result = Convert.ToInt32(dr[0]);
    //            }
    //        dr.Close();
    //        return result;
    //        }
    //    catch (Exception ex)
    //        {
    //     //   ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
    //        }
    //    return 0;
    //    }
    protected void btnEditProfile_OnServerClick(object sender, EventArgs e)
    {
        Response.Redirect("edit-profile.aspx");
    }
  protected void lbtnMassenger_Click(object sender, EventArgs e)
    {
        Response.Redirect("massenger.aspx");
    }


    protected void rptLookbook_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "1") // Delete Command
            {
                var db = new DatabaseManagement();
                Int32 selectedItemID = Convert.ToInt32(e.CommandArgument);
                var httpCookie = Request.Cookies["FrUserID"];
                if (httpCookie != null)
                {
                    string removeFromWishlist = string.Format("Delete From Tbl_Wishlist Where ItemID={0} AND UserID={1}",
                                                              selectedItemID, Convert.ToInt32(httpCookie.Value));
                    db.ExecuteSQL(removeFromWishlist);
                }
                db.CloseConnection();
                //   rptLookbook.DataBind();
                //   ErrorMessage.ShowSuccessAlert(lblStatus, "Item removed from your wish list.", divAlerts);
            }
        }
        catch (Exception ex)
        {
            //  ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    [WebMethod, ScriptMethod]
    public static void DeleteItemFromWishList(string id)
    {
        var db = new DatabaseManagement();

        if (httpCookie2 != null)
        {
            string deleteQuery = string.Format("Delete From Tbl_Wishlist Where ItemID={0} AND UserID={1}",
                                                                  Convert.ToInt32(id), Convert.ToInt32(httpCookie2.Value));
            db.ExecuteSQL(deleteQuery);
        }
        db.CloseConnection();
    }
    [WebMethod, ScriptMethod]
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
                db.CloseConnection();
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

                // rptLookbook.DataSourceID = "";
                // rptLookbook.DataSource = cmd.ExecuteReader();
                //  rptLookbook.DataBind();
                con.Close();
                db.CloseConnection();
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
            // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
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
                db.CloseConnection();
            }
        }
        catch (Exception ex)
        {
            // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
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
            //  ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
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
    public static List<Items> GetData(int pageIndex, string v)
    {
        try
        {
            int pageSize=15;
            int offSet = pageSize * (pageIndex - 1);
            int fetchNext = offSet + pageSize;
            DatabaseManagement db = new DatabaseManagement();
            string fullQuery = string.Empty;
            string fullQuery2 = string.Empty;
            string @select = "SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey,dbo.Tbl_Users.U_ProfilePic," +
  " dbo.Tbl_Brands.Logo, dbo.Tbl_Items.ItemID, dbo.Tbl_Items.Title," +
  " ItemKey, dbo.Tbl_Items.Description, dbo.Tbl_Items.FeatureImg," +
  " dbo.Tbl_Items.Views, CAST(dbo.Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted," +
  " dbo.Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands" +
  " INNER JOIN dbo.Tbl_Items ON dbo.Tbl_Brands.UserID = dbo.Tbl_Items.UserID" +
  " INNER JOIN dbo.Tbl_Users ON dbo.Tbl_Brands.UserID = dbo.Tbl_Users.UserID" +
  " INNER JOIN dbo.Tbl_WishList ON Tbl_WishList.ItemID = Tbl_Items.ItemID" +
  " Where dbo.Tbl_WishList.UserID = '" + v + "' AND  dbo.Tbl_Items.IsDeleted IS NULL AND dbo.Tbl_Items.IsPublished = 1" +
  " ORDER BY dbo.Tbl_Items.DatePosted DESC OFFSET " + offSet + " ROWS FETCH NEXT " + pageSize + " ROWS ONLY";
            //int startItems = ((pageIndex - 1) * pagesize) + 1;
            //int endItems = (startItems + pagesize) - 1;
            //int tempCount = 1;
            var itemList = new List<Items>();
            fullQuery = fullQuery + select;
            fullQuery2 = fullQuery2 + select;
            SqlDataReader dr2 = db.ExecuteReader(fullQuery2);
            int recordCount = 0;
            if (dr2.HasRows)
            {
                while (dr2.Read())
                {
                    recordCount += 1;
                }
            }
            int pageCount = (int)Math.Ceiling(Convert.ToDecimal(recordCount / pageSize));
            dr2.Close();

            SqlDataReader dr = db.ExecuteReader(fullQuery);
            var desc = "";
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
                        //ProfilePic = dr["Logo"].ToString(),
                        //RowNum = IEUtils.ToInt(dr["row"]),
                        Title = dr["Title"].ToString(),
                        //Likes = LbLikes(IEUtils.ToInt(dr["ItemID"])),
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
                    if(objitem.Description.Length > 50)
                    {
                        objitem.Description = objitem.Description.Substring(0, 50);
                        objitem.Description = objitem.Description + "...";
                    }
                    //if (tempCount >= startItems && tempCount <= endItems)
                    //{
                        itemList.Add(objitem);
                    //}

                    //tempCount++;


                }
                dr.Close();
            }
            db.CloseConnection();
            return itemList;
        }
        catch (Exception ex)
        {
            return null;
        }
    }



    [WebMethod, ScriptMethod]
    public static List<Items> GetDataByTitle(int pageIndex, string title, string v)
    {
        try
        {
            int pagesize = 10;
            DatabaseManagement db = new DatabaseManagement();
            string fullQuery = string.Empty;
            string fullQuery2 = string.Empty;
            string @select =
                " SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey,dbo.Tbl_Brands.Logo, dbo.Tbl_Items.ItemID, dbo.Tbl_Items.Title,Tbl_Users.U_ProfilePic, " +
"ItemKey, " +
"dbo.Tbl_Items.Description, dbo.Tbl_Items.FeatureImg, " +
"dbo.Tbl_Items.Views, CAST(dbo.Tbl_Items.DatePosted AS VARCHAR(12)) as " +
"DatePosted,dbo.Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands INNER JOIN " +
"dbo.Tbl_Items ON dbo.Tbl_Brands.UserID = dbo.Tbl_Items.UserID INNER JOIN dbo.Tbl_WishList " +
"ON Tbl_WishList.ItemID=Tbl_Items.ItemID INNER JOIN dbo.Tbl_Users ON dbo.Tbl_Brands.UserID = dbo.Tbl_Users.UserID Where Tbl_WishList.UserID='" + v + "' AND  dbo.Tbl_Items.IsDeleted IS NULL AND dbo.Tbl_Items.IsPublished=1 AND Title LIKE '%" + title + "%' ORDER BY dbo.Tbl_Items.DatePosted DESC";


            //            "SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey," +
            //                "dbo.Tbl_Brands.Logo, dbo.Tbl_Items.ItemID, dbo.Tbl_Items.Title, " +
            //                "ItemKey, dbo.Tbl_Items.Description, dbo.Tbl_Items.FeatureImg, " +
            //                "dbo.Tbl_Items.Views, CAST(dbo.Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted," +
            //                "dbo.Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands " +
            //                "INNER JOIN dbo.Tbl_Items ON dbo.Tbl_Brands.UserID = dbo.Tbl_Items.UserID " +
            //                "INNER JOIN dbo.Tbl_WishList ON Tbl_WishList.ItemID=Tbl_Items.ItemID" +
            //" Where Tbl_WishList.UserID='" + v + "' AND  dbo.Tbl_Items.IsDeleted IS NULL AND dbo.Tbl_Items.IsPublished=1" +
            //"ORDER BY dbo.Tbl_Items.DatePosted DESC ";
            int startItems = ((pageIndex - 1) * pagesize) + 1;
            int endItems = (startItems + pagesize) - 1;
            int tempCount = 1;
            var itemList = new List<Items>();
            fullQuery = fullQuery + select;
            fullQuery2 = fullQuery2 + select;
            SqlDataReader dr2 = db.ExecuteReader(fullQuery2);
            int recordCount = 0;
            if (dr2.HasRows)
            {
                while (dr2.Read())
                {
                    recordCount += 1;
                }
            }
            int pageCount = (int)Math.Ceiling(Convert.ToDecimal(recordCount / pagesize));
            dr2.Close();

            SqlDataReader dr = db.ExecuteReader(fullQuery);
            var desc = "";
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
                        // ProfilePic = dr["Logo"].ToString(),
                        //RowNum = IEUtils.ToInt(dr["row"]),
                        Title = dr["Title"].ToString(),
                        //Likes = LbLikes(IEUtils.ToInt(dr["ItemID"])),
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
                    if (objitem.Description.Length > 50)
                    {
                        objitem.Description = objitem.Description.Substring(0, 50);
                    }
                    if (tempCount >= startItems && tempCount <= endItems)
                    {
                        itemList.Add(objitem);
                    }
                    tempCount++;


                }
                dr.Close();
            }
            db.CloseConnection();
            return itemList;
        }
        catch (Exception ex)
        {
            return null;
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
            //  ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            return 0;
        }

    }
}


