using System;
using System.Collections;
using System.Collections.Specialized;
using System.Data.SqlClient;
using System.Reflection;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;
using System.Collections.Generic;

public partial class editor_discover_lookbook_details : Page
{
    private string _pageUrl = HttpContext.Current.Request.Url.ToString();

    private string slookkey;
    private string categoryCheck;
    private string seasonCheck;
    private string holidayCheck;

    protected void Page_Load(object sender, EventArgs e)
    {
        NameValueCollection nvc = Request.QueryString;
        if (Session["LookBookDetailSearch"] == null)
        {
            LookBookDetailSearch lookBookDetailSearch = new LookBookDetailSearch();
            Session["LookBookDetailSearch"] = lookBookDetailSearch;
        }

        if (nvc.HasKeys())
        {
            string lookkey = nvc.Get("v");
            if (lookkey != null)
            {
                slookkey = lookkey;
                (Session["LookBookDetailSearch"] as LookBookDetailSearch).slookkey = lookkey;
            }
            else
            {
                slookkey = null;
                (Session["LookBookDetailSearch"] as LookBookDetailSearch).slookkey = lookkey;
            }
        }
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
        if (!IsPostBack)
        {
            LoadLookbook();
            //LoadData();
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
        else
        {

        }
    }
    [WebMethod, ScriptMethod]
    public static List<Items> LoadData(int pageIndex)
    {
        try
        {
            int pagesize = 10;
            string brandid = "1";
            DatabaseManagement db = new DatabaseManagement();
            string fullQuery = string.Empty;
            string fullQuery2 = string.Empty;

            string strCategoryCheck = "";
            string strSeasonsCheck = "";
            string strHolidayCheck = "";

            if (HttpContext.Current.Session["DiscoverPageSearch"] != null)
            {
                strCategoryCheck = (HttpContext.Current.Session["LookBookDetailSearch"] as LookBookDetailSearch).categoryCheck;
                strSeasonsCheck = (HttpContext.Current.Session["LookBookDetailSearch"] as LookBookDetailSearch).seasonsCheck;
                strHolidayCheck = (HttpContext.Current.Session["LookBookDetailSearch"] as LookBookDetailSearch).holidayCheck;
            }

            string @select =
               "SELECT distinct dbo.Tbl_Brands.Name, U_ProfilePic, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, " +
               " dbo.Tbl_Brands.Logo, a.ItemID, a.Title, a.row, a.DatePosted as [dated],a.UserID,IsDeleted,IsPublished," +
               " ItemKey, SUBSTRING(a.Description,0,50) + '...' as Description , a.FeatureImg, " +
               " a.Views, Likes,  CAST(a.DatePosted AS VARCHAR(12)) as DatePosted," +
               " a.DatePosted as [dated] " +
               "FROM ( SELECT ROW_NUMBER() OVER (ORDER BY ItemID ASC) AS row, ItemID, dbo.Tbl_Items.Title," +
               " ItemKey, SUBSTRING(dbo.Tbl_Items.Description,0,50) + '...' as Description, dbo.Tbl_Items.FeatureImg," +
               " dbo.Tbl_Items.Views, CAST(dbo.Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted, " +
               " dbo.Tbl_Items.DatePosted as [dated],UserID,IsDeleted,IsPublished, Likes, RetailPrice FROM Tbl_Items ) AS a " +
               " INNER JOIN Tbl_Brands ON Tbl_Brands.UserID=a.UserID " +
               " INNER JOIN dbo.Tbl_Users ON dbo.Tbl_Users.UserID=Tbl_Brands.UserID " +
               "INNER JOIN dbo.Tbl_LbItems ON a.ItemID=Tbl_LbItems.ItemID";


            //int start = (pageIndex * pagesize) + 1;
            //int end = ((pageIndex * pagesize) + pagesize);
            int startItems = ((pageIndex - 1) * pagesize) + 1;
            int endItems = (startItems + pagesize) - 1;
            int tempCount = 1;

            var itemList = new List<Items>();
            string strSlookKey = "";
            if ((LookBookDetailSearch)HttpContext.Current.Session["LookBookDetailSearch"] != null)
            {
                strSlookKey = (HttpContext.Current.Session["LookBookDetailSearch"] as LookBookDetailSearch).slookkey;
            }

            //string wherecluse = " Where   a.IsDeleted IS NULL AND a.IsPublished=1  AND row BETWEEN  " + start + "  AND " + end + "AND Tbl_LbItems.LookID=(SELECT LOOKID FROM TBL_LOOKBOOKS WHERE LOOKKEY='" + strSlookKey + "')";
            string wherecluse = " Where  a.IsDeleted IS NULL AND a.IsPublished=1  AND Tbl_LbItems.LookID = (SELECT LOOKID FROM TBL_LOOKBOOKS WHERE LOOKKEY = '" + strSlookKey + "')";
            string wherecluse2 = " Where  a.IsDeleted IS NULL AND a.IsPublished=1  AND Tbl_LbItems.LookID = (SELECT LOOKID FROM TBL_LOOKBOOKS WHERE LOOKKEY = '" + strSlookKey + "')";


            if (!string.IsNullOrEmpty(strCategoryCheck))
            {
                const string categoryJoin = " INNER JOIN Tbl_ItemsCategory ON Tbl_ItemsCategory.ItemID=a.ItemID  ";
                select = select + categoryJoin;
                wherecluse = wherecluse + " AND Tbl_ItemsCategory.CategoryID=" + IEUtils.ToInt(strCategoryCheck);
                wherecluse2 = wherecluse2 + " AND Tbl_ItemsCategory.CategoryID=" + IEUtils.ToInt(strCategoryCheck);
            }

            if (!string.IsNullOrEmpty(strSeasonsCheck))
            {
                const string seasonjoin = " INNER JOIN Tbl_ItemSeasons ON Tbl_ItemSeasons.ItemID=a.ItemID  ";
                select = select + seasonjoin;
                wherecluse = wherecluse + " AND Tbl_ItemSeasons.SeasonID=" + IEUtils.ToInt(strSeasonsCheck);
                wherecluse2 = wherecluse2 + " AND Tbl_ItemSeasons.SeasonID=" + IEUtils.ToInt(strSeasonsCheck);
            }

            if (!string.IsNullOrEmpty(strHolidayCheck))
            {
                const string holidayjoin = " INNER JOIN Tbl_ItemHolidays ON Tbl_ItemHolidays.ItemID=a.ItemID  ";
                select = select + holidayjoin;
                wherecluse = wherecluse + " AND Tbl_ItemHolidays.HolidayID=" + IEUtils.ToInt(strHolidayCheck);
                wherecluse2 = wherecluse2 + " AND Tbl_ItemHolidays.HolidayID=" + IEUtils.ToInt(strHolidayCheck);
            }

            //const string orderBy = " ORDER BY a.DatePosted DESC";
            const string orderBy = " ORDER BY a.ItemID DESC";
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



            //List<string> brandlist = new List<string>();

            //if (brandCheck != null)
            //    brandlist = brandCheck.Split(',').ToList();
            ////string[] brandarray = brandid.Split(',');
            //if (!string.IsNullOrEmpty(categoryCheck))
            //{
            //    const string categoryJoin = " INNER JOIN Tbl_ItemsCategory ON Tbl_ItemsCategory.ItemID=a.ItemID  ";
            //    select = select + categoryJoin;
            //    wherecluse = wherecluse + " AND Tbl_ItemsCategory.CategoryID=" + IEUtils.ToInt(categoryCheck);
            //    wherecluse2 = wherecluse2 + " AND Tbl_ItemsCategory.CategoryID=" + IEUtils.ToInt(categoryCheck);
            //}

            //if (!string.IsNullOrEmpty(seasonsCheck))
            //{
            //    const string seasonjoin = " INNER JOIN Tbl_ItemSeasons ON Tbl_ItemSeasons.ItemID=a.ItemID  ";
            //    select = select + seasonjoin;
            //    wherecluse = wherecluse + " AND Tbl_ItemSeasons.SeasonID=" + IEUtils.ToInt(seasonsCheck);
            //    wherecluse2 = wherecluse2 + " AND Tbl_ItemSeasons.SeasonID=" + IEUtils.ToInt(seasonsCheck);
            //}

            //if (!string.IsNullOrEmpty(holidayCheck))
            //{
            //    const string holidayjoin = " INNER JOIN Tbl_ItemHolidays ON Tbl_ItemHolidays.ItemID=a.ItemID  ";
            //    select = select + holidayjoin;
            //    wherecluse = wherecluse + " AND Tbl_ItemHolidays.HolidayID=" + IEUtils.ToInt(holidayCheck);
            //    wherecluse2 = wherecluse2 + " AND Tbl_ItemHolidays.HolidayID=" + IEUtils.ToInt(holidayCheck);
            //}

            //if (!string.IsNullOrEmpty(colorCheck))
            //{
            //    wherecluse = wherecluse + " AND a.Color=" + IEUtils.SafeSQLString(colorCheck);
            //    wherecluse2 = wherecluse2 + " AND a.Color=" + IEUtils.SafeSQLString(colorCheck);
            //}


            //if (!string.IsNullOrEmpty(p1check))
            //{
            //    wherecluse = wherecluse + " AND  (a.RetailPrice>=0 OR a.RetailPrice<=100)  ";
            //    wherecluse2 = wherecluse2 + " AND  (a.RetailPrice>=0 OR a.RetailPrice<=100)  ";
            //}

            //if (!string.IsNullOrEmpty(chkP2_Check))
            //{
            //    wherecluse = wherecluse + " AND  (a.RetailPrice>=100 OR a.RetailPrice<=200)  ";
            //    wherecluse2 = wherecluse2 + " AND  (a.RetailPrice>=100 OR a.RetailPrice<=200)  ";
            //}

            //if (!string.IsNullOrEmpty(chkP3_Check))
            //{
            //    wherecluse = wherecluse + " AND  (a.RetailPrice>=200 OR a.RetailPrice<=300)  ";
            //    wherecluse2 = wherecluse2 + " AND  (a.RetailPrice>=200 OR a.RetailPrice<=300)  ";
            //}

            //if (!string.IsNullOrEmpty(chkP4_Check))
            //{
            //    wherecluse = wherecluse + " AND  (a.RetailPrice>=300 OR a.RetailPrice<=400)  ";
            //    wherecluse2 = wherecluse2 + " AND  (a.RetailPrice>=300 OR a.RetailPrice<=400)  ";
            //}

            //if (!string.IsNullOrEmpty(chkP5_Check))
            //{
            //    wherecluse = wherecluse + " AND  (a.RetailPrice>=400 OR a.RetailPrice<=500)  ";
            //    wherecluse2 = wherecluse2 + " AND  (a.RetailPrice>=400 OR a.RetailPrice<=500)  ";
            //}

            //if (!string.IsNullOrEmpty(chkP6_Check))
            //{
            //    wherecluse = wherecluse + " AND  (a.RetailPrice>=500)  ";
            //    wherecluse2 = wherecluse2 + " AND  (a.RetailPrice>=500)  ";
            //}

            //if (!string.IsNullOrEmpty(brandCheck))
            //{

            //    foreach (var brandId in brandlist)
            //    {
            //        wherecluse = wherecluse + " AND  a.UserID IN(" + brandId + ") ";
            //        wherecluse2 = wherecluse2 + " AND  a.UserID IN(" + brandId + ") ";
            //    }

            //}

            //if (!string.IsNullOrEmpty(brandSearchCheck))
            //{
            //    wherecluse = wherecluse + " AND dbo.Tbl_Brands.Name LIKE '" + brandSearchCheck + "%' ";
            //    wherecluse2 = wherecluse2 + " AND dbo.Tbl_Brands.Name LIKE '" + brandSearchCheck + "%' ";
            //}

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

                    //itemList.Add(objitem);
                    if (tempCount >= startItems && tempCount <= endItems)
                    {
                        itemList.Add(objitem);
                    }
                    tempCount++;

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
            return itemList;
        }
        catch (Exception ex)
        {
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            return null;
        }
    }

    protected void LoadLookbook()
    {
        try
        {
            var db = new DatabaseManagement();
            lblLbTitle.Text =
                db.GetExecuteScalar(string.Format("SELECT Title FROM Tbl_Lookbooks Where LookKey={0}",
                                                  IEUtils.SafeSQLString(Request.QueryString["v"])));
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
        }
        catch (Exception ex)
        {
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
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
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
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
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void ByCategory(string categry)
    {
        try
        {
            // var db = new DatabaseManagement();
            //string qryCategory = string.Format("SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, " +
            //   " dbo.Tbl_Brands.Logo, dbo.Tbl_Items.ItemID, dbo.Tbl_Items.Title, " +
            //   " ItemKey, dbo.Tbl_Items.Description, dbo.Tbl_Items.FeatureImg, " +
            //   " dbo.Tbl_Items.Views, CAST(dbo.Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted," +
            //   " dbo.Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands " +
            //   " INNER JOIN dbo.Tbl_Items ON dbo.Tbl_Brands.UserID = dbo.Tbl_Items.UserID " +
            //   " INNER JOIN dbo.Tbl_ItemsCategory ON dbo.Tbl_Items.ItemID = dbo.Tbl_ItemsCategory.ItemID " +
            //    " INNER JOIN dbo.Tbl_Categories ON dbo.Tbl_Categories.CategoryID = dbo.Tbl_ItemsCategory.CategoryID " +
            //    "Where  Tbl_ItemsCategory.CategoryID={0} dbo.Tbl_Items.IsDeleted IS NULL AND dbo.Tbl_Items.IsPublished=1 " +
            //"ORDER BY dbo.Tbl_Items.DatePosted DESC",
            // categryId);
            NameValueCollection nvc = Request.QueryString;
            if (nvc.HasKeys())
            {
                if (nvc["s"] != null)
                {
                    if (Session["LookBookDetailSearch"] as LookBookDetailSearch != null)
                        (Session["LookBookDetailSearch"] as LookBookDetailSearch).seasonsCheck = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    nvc.Remove("s");
                }
                if (nvc["h"] != null)
                {
                    if (Session["LookBookDetailSearch"] as LookBookDetailSearch != null)
                        (Session["LookBookDetailSearch"] as LookBookDetailSearch).holidayCheck = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    nvc.Remove("h");
                }
            }

            if (QuerystringExist())
                CheckQuerystringKey("c", categry);
            else
                _pageUrl = "discover-lookbook-details.aspx?c=" + categry;
            lbCategory.Text = categry;
            (Session["LookBookDetailSearch"] as LookBookDetailSearch).categoryCheck = categry;
            categoryCheck = categry;
            //Response.Redirect(_pageUrl,false);
            Response.Redirect("discover-lookbook-details.aspx?" + Request.QueryString, false);
        }
        catch (Exception ex)
        {
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
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
                    Response.Redirect("discover-lookbook-details.aspx?" + Request.QueryString, false);
                }
                else
                {
                    nvc.Add(key, value);
                    Response.Redirect("discover-lookbook-details.aspx?" + Request.QueryString, false);
                }
            }
        }
        catch (Exception ex)
        {
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }

    }
    protected bool QuerystringExist()
    {
        NameValueCollection nvc = Request.QueryString;
        return nvc.Count > 0;

    }

    protected void BySeason(string season)
    {
        try
        {
            // var db = new DatabaseManagement();
            // string qrySeason = string.Format("SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, " +
            //   " dbo.Tbl_Brands.Logo, dbo.Tbl_Items.ItemID, dbo.Tbl_Items.Title, " +
            //   " ItemKey, dbo.Tbl_Items.Description, dbo.Tbl_Items.FeatureImg, " +
            //   " dbo.Tbl_Items.Views, CAST(dbo.Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted," +
            //   " dbo.Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands " +
            //   " INNER JOIN dbo.Tbl_Items ON dbo.Tbl_Brands.UserID = dbo.Tbl_Items.UserID " +
            //   " INNER JOIN dbo.Tbl_ItemSeasons ON dbo.Tbl_Items.ItemID = dbo.Tbl_ItemSeasons.ItemID " +
            //    " INNER JOIN dbo.Tbl_Seasons ON dbo.Tbl_Seasons.SeasonID = dbo.Tbl_ItemSeasons.SeasonID " +
            //    "Where dbo.Tbl_Brands.UserID={0} AND Tbl_ItemSeasons.SeasonID={1} dbo.Tbl_Items.IsDeleted IS NULL AND dbo.Tbl_Items.IsPublished=1 " +
            //"ORDER BY dbo.Tbl_Items.DatePosted DESC",
            //IEUtils.ToInt(Request.QueryString["v"]), seasonId);
            // rptLookbook.DataSourceID = "";
            // rptLookbook.DataSource = db.ExecuteReader(qrySeason);
            // rptLookbook.DataBind();
            NameValueCollection nvc = Request.QueryString;
            if (nvc.HasKeys())
            {
                if (nvc["c"] != null)
                {
                    if (Session["LookBookDetailSearch"] as LookBookDetailSearch != null)
                        (Session["LookBookDetailSearch"] as LookBookDetailSearch).seasonsCheck = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    nvc.Remove("c");
                }
                if (nvc["h"] != null)
                {
                    if (Session["LookBookDetailSearch"] as LookBookDetailSearch != null)
                        (Session["LookBookDetailSearch"] as LookBookDetailSearch).holidayCheck = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    nvc.Remove("h");
                }
            }
            if (QuerystringExist())
                CheckQuerystringKey("s", season);
            else
                _pageUrl = "discover-lookbook-details.aspx?s=" + season;
            (Session["LookBookDetailSearch"] as LookBookDetailSearch).seasonsCheck = season;
            this.seasonCheck = season;
            //Response.Redirect(_pageUrl);
            Response.Redirect("discover-lookbook-details.aspx?" + Request.QueryString, false);
        }
        catch (Exception ex)
        {
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void ByHoliday(string holiday)
    {
        try
        {
            // var db = new DatabaseManagement();
            // string qryHoliday = string.Format("SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, " +
            //   " dbo.Tbl_Brands.Logo, dbo.Tbl_Items.ItemID, dbo.Tbl_Items.Title, " +
            //   " ItemKey, dbo.Tbl_Items.Description, dbo.Tbl_Items.FeatureImg, " +
            //   " dbo.Tbl_Items.Views, CAST(dbo.Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted," +
            //   " dbo.Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands " +
            //   " INNER JOIN dbo.Tbl_Items ON dbo.Tbl_Brands.UserID = dbo.Tbl_Items.UserID " +
            //   " INNER JOIN dbo.Tbl_ItemHolidays ON dbo.Tbl_Items.ItemID = dbo.Tbl_ItemHolidays.ItemID " +
            //    " INNER JOIN dbo.Tbl_Holidays ON dbo.Tbl_Holidays.HolidayID = dbo.Tbl_ItemHolidays.HolidayID " +
            //    "Where dbo.Tbl_Brands.UserID={0} AND Tbl_ItemHolidays.HolidayID={1} dbo.Tbl_Items.IsDeleted IS NULL AND dbo.Tbl_Items.IsPublished=1 " +
            //"ORDER BY dbo.Tbl_Items.DatePosted DESC",
            //IEUtils.ToInt(Request.QueryString["v"]), holidayId);

            // rptLookbook.DataSourceID = "";
            // rptLookbook.DataSource = db.ExecuteReader(qryHoliday);
            // rptLookbook.DataBind();
            NameValueCollection nvc = Request.QueryString;
            if (nvc.HasKeys())
            {
                if (nvc["c"] != null)
                {
                    if (Session["LookBookDetailSearch"] as LookBookDetailSearch != null)
                        (Session["LookBookDetailSearch"] as LookBookDetailSearch).seasonsCheck = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    nvc.Remove("c");
                }
                if (nvc["s"] != null)
                {
                    if (Session["LookBookDetailSearch"] as LookBookDetailSearch != null)
                        (Session["LookBookDetailSearch"] as LookBookDetailSearch).holidayCheck = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    nvc.Remove("s");
                }
            }
            if (QuerystringExist())
                CheckQuerystringKey("h", holiday);
            else
            {
                _pageUrl = "discover-lookbook-details.aspx?h=" + holiday;
            }
            (Session["LookBookDetailSearch"] as LookBookDetailSearch).holidayCheck = holiday;
            this.holidayCheck = holiday;
            //Response.Redirect(_pageUrl);
            Response.Redirect("discover-lookbook-details.aspx?" + Request.QueryString, false);
        }
        catch (Exception ex)
        {
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void rptCategories_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "1")
            {
                // txtsearch.Value = string.Empty;
                string category = e.CommandArgument.ToString();
                ByCategory(category);
            }
        }
        catch (Exception ex)
        {
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void rptSeasons_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "1")
            {
                // txtsearch.Value = string.Empty;
                string season = e.CommandArgument.ToString();
                BySeason(season);
            }
        }
        catch (Exception ex)
        {
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void rptHoliday_OnItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "1")
            {
                // txtsearch.Value = string.Empty;
                string holiday = e.CommandArgument.ToString();
                ByHoliday(holiday);
            }
        }
        catch (Exception ex)
        {
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
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
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
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
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
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
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
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