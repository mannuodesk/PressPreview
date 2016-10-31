using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;

public partial class editor_discover_lookbook : System.Web.UI.Page
{
    private string _pageUrl = HttpContext.Current.Request.Url.ToString();
    private const string Pagename = "discover-lookbook.aspx";

    protected void Page_Load(object sender, EventArgs e)
    {
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
        txtsearch.Attributes.Add("onKeyPress",
               "doClick('" + btnSearch.ClientID + "',event)");
        if (!IsPostBack)
        {
            try
            {
                DisplayDefaultBrands();
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
            //LoadData();
           GetSelectedBrands();
        }
    }

    protected void GetSelectedBrands()
    {
        try
        {
            NameValueCollection nvc = Request.QueryString;
            chkBrands.DataBind();
            if (nvc.HasKeys())
            {
                string brandid = nvc.Get("b");
                if (brandid != null)
                {
                    brandid = brandid.TrimEnd(',');
                    string[] ids = brandid.Split(',');
                    foreach (ListItem itm in chkBrands.Items)
                    {
                        if (ids.Contains(itm.Value))
                            itm.Selected = true;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void btn_ViewMore_Click(object sender, EventArgs e)
    {
        try
        {
            DisplayMoreBrands();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }


    }
    protected void btn_ViewLess_Click(object sender, EventArgs e)
    {
        try
        {
            DisplayDefaultBrands();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }

    }

    private void DisplayMoreBrands()
    {
        for (int i = 9; i > 5; i--)
        {
            if (chkBrands.Items.Count > i) chkBrands.Items[i].Attributes.Add("style", "display:block;");
        }
        btn_ViewMore.Visible = false;
        btn_ViewLess.Visible = true;
    }

    private void DisplayDefaultBrands()
    {
        for (int i = 9; i > 5; i--)
        {
            if (chkBrands.Items.Count > i) chkBrands.Items[i].Attributes.Add("style", "display:none;");
        }
        btn_ViewMore.Visible = true;
        btn_ViewLess.Visible = false;
    }
    [ScriptMethod()]
    [WebMethod]
    public static List<string> GetBrandName(string empName)
    {
        var empResult = new List<string>();
        var db = new DatabaseManagement();
        using (var con = new SqlConnection(db.ConnectionString))
        {
            using (var cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT Top 10 Name From Tbl_Brands Where Name LIKE '" + empName + "%'";
                cmd.Connection = con;
                con.Open();
              //  cmd.Parameters.AddWithValue("@SearchEmpName", empName);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    empResult.Add(dr["Name"].ToString());
                }
                con.Close();
                return empResult;
            }
        }

    }
    [ScriptMethod()]
    [WebMethod]
    public static SqlDataReader GetBrandList(string rowNum)
    {
        List<string> empResult = new List<string>();
        var db = new DatabaseManagement();
        using (var con = new SqlConnection(db.ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT Top " + rowNum + " BrandID,BrandKey,Name From Tbl_Brands ORDER BY TotalViews DESC";
                cmd.Connection = con;
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                return dr;

            }
        }

    }
    [WebMethod, ScriptMethod]
    public static void SetSession(string value)
    {
        var currItem = new HttpCookie("ColorVal") { Value = value };
        HttpContext.Current.Response.Cookies.Add(currItem);

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
                lblLikes.Text = (Convert.ToInt32(lblLikes.Text)).ToString();

            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    [WebMethod, ScriptMethod]
    public static List<Lookbook> LoadData(int pageIndex)
    {
        try
        {
            int pagesize = 4;
            DatabaseManagement db = new DatabaseManagement();
            string fullQuery = string.Empty;
            string fullQuery2 = string.Empty;
            string @select = "SELECT distinct dbo.Tbl_Brands.Name, U_ProfilePic, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, " +
              " dbo.Tbl_Brands.Logo, a.LookID, a.Title, a.row, a.DatePosted as [dated],a.UserID,IsDeleted,IsPublished," +
              " a.LookKey, SUBSTRING(a.Description,0,50) + '...' as Description , a.MainImg, " +
              " a.Views, Likes,  CAST(a.DatePosted AS VARCHAR(12)) as DatePosted," +
              " a.DatePosted as [dated] " +
              "FROM ( SELECT ROW_NUMBER() OVER (ORDER BY LookID ASC) AS row, LookID, dbo.Tbl_Lookbooks.Title," +
              " LookKey, SUBSTRING(dbo.Tbl_Lookbooks.Description,0,50) + '...' as Description, dbo.Tbl_Lookbooks.MainImg," +
              " dbo.Tbl_Lookbooks.Views, CAST(dbo.Tbl_Lookbooks.DatePosted AS VARCHAR(12)) as DatePosted, " +
              " dbo.Tbl_Lookbooks.DatePosted as [dated],UserID,IsDeleted,IsPublished, Likes FROM Tbl_Lookbooks ) AS a " +
              " INNER JOIN Tbl_Brands ON Tbl_Brands.UserID=a.UserID " +
              " INNER JOIN dbo.Tbl_Users ON dbo.Tbl_Users.UserID=Tbl_Brands.UserID ";


            int start = (pageIndex * pagesize) + 1;
            int end = ((pageIndex * pagesize) + pagesize);
            var lookbookList = new List<Lookbook>();
            string wherecluse = " Where   a.IsDeleted IS NULL AND a.IsPublished=1  AND row BETWEEN  " + start + "  AND " + end;
            string wherecluse2 = " Where   a.IsDeleted IS NULL AND a.IsPublished=1  ";
            const string orderBy = " ORDER BY a.DatePosted DESC";
            //NameValueCollection nvc = Request.QueryString;
            //if(nvc.HasKeys())  // check for the query string parameter. if the URL has query string keys, get those values 
            //{
            //string category = nvc.Get("c");
            //string season = nvc.Get("s");
            //string holiday = nvc.Get("h");
            //string color = nvc.Get("cl");
            /*string price1 = nvc.Get("p1")*/
            ;
            //string price2 = nvc.Get("p2");
            //string price3 = nvc.Get("p3");
            //string price4 = nvc.Get("p4");
            //string price5 = nvc.Get("p5");
            //string price6 = nvc.Get("p6");
            //string brandid = nvc.Get("b");
            //string brandname = nvc.Get("br");
            if (brandCheck != null)
                brandCheck = brandCheck.TrimEnd(',');
            //string[] brandarray = brandid.Split(',');
            if (!string.IsNullOrEmpty(categoryCheck))
            {
                const string categoryJoin = " INNER JOIN Tbl_LbCategory ON Tbl_LbCategory.LookID=a.LookID  ";
                select = select + categoryJoin;
                wherecluse = wherecluse + " AND Tbl_LbCategory.CategoryID=" + IEUtils.ToInt(categoryCheck);
                wherecluse2 = wherecluse2 + " AND Tbl_LbCategory.CategoryID=" + IEUtils.ToInt(categoryCheck);
            }

            if (!string.IsNullOrEmpty(seasonsCheck))
            {
                const string seasonjoin = " INNER JOIN Tbl_LbSeasons ON Tbl_LbSeasons.LookID=a.LookID  ";
                select = select + seasonjoin;
                wherecluse = wherecluse + " AND Tbl_LbSeasons.SeasonID=" + IEUtils.ToInt(seasonsCheck);
                wherecluse2 = wherecluse2 + " AND Tbl_LbSeasons.SeasonID=" + IEUtils.ToInt(seasonsCheck);
            }

            if (!string.IsNullOrEmpty(holidayCheck))
            {
                const string holidayjoin = " INNER JOIN Tbl_LbHolidays ON Tbl_LbHolidays.LookID=a.LookID  ";
                select = select + holidayjoin;
                wherecluse = wherecluse + " AND Tbl_LbHolidays.HolidayID=" + IEUtils.ToInt(holidayCheck);
                wherecluse2 = wherecluse2 + " AND Tbl_LbHolidays.HolidayID=" + IEUtils.ToInt(holidayCheck);
            }

           
            if (!string.IsNullOrEmpty(brandCheck))
            {
                wherecluse = wherecluse + " AND  a.UserID IN(" + brandCheck + ") ";
                wherecluse2 = wherecluse2 + " AND  a.UserID IN(" + brandCheck + ") ";
            }

            if (!string.IsNullOrEmpty(brandSearchCheck))
            {
                wherecluse = wherecluse + " AND dbo.Tbl_Brands.Name LIKE '" + brandSearchCheck + "%' ";
                wherecluse2 = wherecluse2 + " AND dbo.Tbl_Brands.Name LIKE '" + brandSearchCheck + "%' ";
            }

            fullQuery = fullQuery + select + wherecluse + orderBy;
            fullQuery2 = fullQuery2 + select + wherecluse2 + orderBy;
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
                        //Likes = LbLikes(IEUtils.ToInt(dr["LookID"])),
                        Views = IEUtils.ToInt(dr["Views"]),
                        BrandId = IEUtils.ToInt(dr["BrandID"]),
                        BrandKey = dr["BrandKey"].ToString(),
                        //DatePosted = dr["DatePosted"].ToString(),
                        Dated = Common.GetRelativeTime(dbDate),
                        Description = dr["Description"].ToString(),
                        FeatureImg = dr["MainImg"].ToString()
                    };

                    lookbookList.Add(objLb);

                }
            }

            //} else  
            //{
            //    // if no query string key exist, execute the default query
            //    fullQuery = fullQuery + select+ wherecluse + orderBy;
            //}

            //sdsLookbooks.SelectCommand = fullQuery;
            //rptLookbook.DataSourceID = "";
            //rptLookbook.DataSource = sdsLookbooks;
            //rptLookbook.DataBind();
            return lookbookList;
        }
        catch (Exception ex)
        {
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            return null;
        }
    }
    
    static string categoryCheck = null;
    protected void ByCategory(string categry)
    {
        try
        {
            if (QuerystringExist())
                CheckQuerystringKey("c", categry);
            else
                _pageUrl = Pagename + "?c=" + categry;
            categoryCheck = categry;
            Response.Redirect(_pageUrl);

        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void CheckQuerystringKey(string key, string value)
    {
        try
        {
            PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
            // make collection editable
            isreadonly.SetValue(this.Request.QueryString, false, null);
            NameValueCollection nvc = Request.QueryString;
            if (nvc.HasKeys())
            {
                if (Request.QueryString[key] != null)
                {
                    Request.QueryString[key] = value;
                    Response.Redirect(Pagename + "?" + Request.QueryString);
                }
                else
                {
                    nvc.Add(key, value);
                    Response.Redirect(Pagename + "?" + Request.QueryString);
                }
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }

    }
    protected bool QuerystringExist()
    {
        NameValueCollection nvc = Request.QueryString;
        return nvc.Count > 0;

    }

    static string seasonsCheck = null;
    protected void BySeason(string season)
    {
        try
        {
            if (QuerystringExist())
                CheckQuerystringKey("s", season);
            else
                _pageUrl = Pagename + "?s=" + season;
            Response.Redirect(_pageUrl);
            seasonsCheck = season;
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    static string colorCheck = null;
    protected void Bycolor(string color)
    {
        try
        {
            colorCheck = color;
            if (QuerystringExist())
            {
                CheckQuerystringKey("cl", color);

            }

            else
            {
                _pageUrl = Pagename + "?cl=" + color;
            }

            Response.Redirect(_pageUrl);
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    static string holidayCheck = null;
    protected void ByHoliday(string holiday)
    {
        try
        {
            if (QuerystringExist())
                CheckQuerystringKey("h", holiday);
            else
            {
                _pageUrl = Pagename + "?h=" + holiday;
            }
            holidayCheck = holiday;
            Response.Redirect(_pageUrl);
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void rptCategories_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "1")
            {
                txtsearch.Text = string.Empty;
                string category = e.CommandArgument.ToString();
                ByCategory(category);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void rptSeasons_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "1")
            {
                txtsearch.Text = string.Empty;
                string season = e.CommandArgument.ToString();
                BySeason(season);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void rptHoliday_OnItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "1")
            {
                txtsearch.Text = string.Empty;
                string holiday = e.CommandArgument.ToString();
                ByHoliday(holiday);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    static string brandCheck = null;
    protected void chkBrands_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            string brandlist = chkBrands.Items.Cast<ListItem>().Where(itm => itm.Selected).Aggregate(string.Empty, (current, itm) => current + itm.Value + ",");

            if (!string.IsNullOrEmpty(brandlist))
            {
                if (QuerystringExist())
                    CheckQuerystringKey("b", brandlist);
                else
                    _pageUrl = Pagename + "?b=" + brandlist;
                brandCheck = brandlist;
                Response.Redirect(_pageUrl);

            }
            else
            {
                brandCheck = null;
                PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                // make collection editable
                isreadonly.SetValue(this.Request.QueryString, false, null);
                NameValueCollection nvc = Request.QueryString;
                nvc.Remove("b");
                if (nvc.Count > 0)
                    Response.Redirect(Pagename + "?" + Request.QueryString);
                else
                {
                    Response.Redirect(Pagename);
                }
            }

        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    static string brandSearchCheck = null;
    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        try
        {
            brandSearchCheck = txtsearch.Text;
            PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
            // make collection editable
            isreadonly.SetValue(this.Request.QueryString, false, null);
            Request.QueryString.Clear();
            Response.Redirect(Pagename + "?br=" + txtsearch.Text);
            var db = new DatabaseManagement();
            using (var con = new SqlConnection(db.ConnectionString))
            {
                using (var cmd = new SqlCommand())
                {
                    string qrySearch = "SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, dbo.Tbl_Brands.Logo, Tbl_Items.ItemID," +
                                            " Tbl_Items.Title, Tbl_Items.ItemKey, Tbl_Items.Description, Tbl_Items.FeatureImg, Tbl_Items.Views," +
                                            " CAST(Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted, Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands " +
                                            " INNER JOIN Tbl_Items ON dbo.Tbl_Brands.UserID = Tbl_Items.UserID " +
                                            " Where  (Tbl_Brands.Name LIKE '" + txtsearch.Text + "%')  AND Tbl_Items.IsDeleted IS NULL AND Tbl_Items.IsPublished = 1 " +
                                            " ORDER BY Tbl_Items.DatePosted DESC";
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