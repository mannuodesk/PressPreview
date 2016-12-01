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
using HtmlAgilityPack;
using System.Data;

public partial class editor_discover_lookbook : System.Web.UI.Page
{
    private string _pageUrl = HttpContext.Current.Request.Url.ToString();
    private const string Pagename = "discover-lookbook.aspx";

    private string categoryCheck;
    private string brandCheck;
    private string holidayCheck;
    private string seasonsCheck;
    private string brandSearchCheck;

    protected void Page_Load(object sender, EventArgs e)
    {
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
        txtsearch2.Attributes.Add("onKeyPress",
              "doClick('" + btnSearch.ClientID + "',event)");
        if (!IsPostBack)
        {
            try
            {
                DiscoverLookbookPageSearch discoverLookbookPageSearch = (DiscoverLookbookPageSearch)Session["DiscoverLookbookPageSearch"];
                if (discoverLookbookPageSearch == null)
                {
                    discoverLookbookPageSearch = new DiscoverLookbookPageSearch();
                    Session["DiscoverLookbookPageSearch"] = discoverLookbookPageSearch;
                }
                
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
            GetSelectedTags();
            rptTags.DataBind();
            dvTagToggles.Visible = rptTags.Items.Count > 0;
            NameValueCollection nvc = Request.QueryString;
            if (nvc.HasKeys())
            {
                string brandid = nvc.Get("b");
                if (brandid != null)
                {
                    brandid = brandid.TrimEnd(',');
                    string[] ids = brandid.Split(',');
                    for (int i = 0; i < chkBrands.Items.Count; i++ )
                    {
                        if (ids.Contains(chkBrands.Items[i].Value))
                            chkBrands.Items[i].Selected = true;
                    }
                }
            }
        }

        else
        {
            DiscoverLookbookPageSearch discoverLookbookPageSearch = (DiscoverLookbookPageSearch)Session["DiscoverLookbookPageSearch"];
            if (discoverLookbookPageSearch != null)
            {
                categoryCheck = discoverLookbookPageSearch.categoryCheck;
                holidayCheck = discoverLookbookPageSearch.holidayCheck;
                brandSearchCheck = discoverLookbookPageSearch.brandSearchCheck;
                seasonsCheck = discoverLookbookPageSearch.seasonsCheck;
                brandCheck = discoverLookbookPageSearch.brandCheck;
            }
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
                    (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).brandCheck = brandid;
                    brandCheck = brandid;
                }
                else
                {
                    (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).brandCheck = null;
                    brandCheck = null;
                }
                string category = nvc.Get("c");
                if (category != null)
                {
                    (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).categoryCheck = category;
                    categoryCheck = category;

                    var CategoryText = "";
                    var db = new DatabaseManagement();
                    using (var con = new SqlConnection(db.ConnectionString))
                    {
                        using (SqlCommand cmd = new SqlCommand())
                        {
                            cmd.CommandText = "select Title from Tbl_Categories where CategoryID=" + category;
                            cmd.Connection = con;
                            con.Open();
                            SqlDataReader dr = cmd.ExecuteReader();
                            while (dr.Read())
                            {
                                CategoryText = dr["Title"].ToString();
                            }
                            con.Close();

                        }
                    }
                    lbCategory.Text = CategoryText + " <i class='fa fa-caret-down' aria-hidden='true' style='font-size:14px; margin-left:6px; margin-top:-5px;'></i>";
                }
                else
                {
                    lbCategory.Text = "Categories" + " <i class='fa fa-caret-down' aria-hidden='true' style='font-size:14px; margin-left:6px; margin-top:-5px;'></i>";
                    (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).categoryCheck = null;
                    categoryCheck = null;
                }
                string season = nvc.Get("s");
                if (season != null)
                {
                    (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).seasonsCheck = season;
                    seasonsCheck = season;


                    var SeasonText = "";
                    var db = new DatabaseManagement();
                    using (var con = new SqlConnection(db.ConnectionString))
                    {
                        using (SqlCommand cmd = new SqlCommand())
                        {
                            cmd.CommandText = "select Season from Tbl_Seasons where SeasonID=" + season;
                            cmd.Connection = con;
                            con.Open();
                            SqlDataReader dr = cmd.ExecuteReader();
                            while (dr.Read())
                            {
                                SeasonText = dr["Season"].ToString();
                            }
                            con.Close();

                        }
                    }
                    btnSeason.Text = SeasonText + " <i class='fa fa-caret-down' aria-hidden='true' style='font-size:14px; margin-left:6px; margin-top:-5px;'></i>";


                }
                else
                {
                    btnSeason.Text = "Seasons" + " <i class='fa fa-caret-down' aria-hidden='true' style='font-size:14px; margin-left:6px; margin-top:-5px;'></i>";
                    (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).seasonsCheck = null;
                    seasonsCheck = null;
                }
                string holiday = nvc.Get("h");
                if (holiday != null)
                {
                    (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).holidayCheck = holiday;
                    holidayCheck = holiday;



                    var HolidayText = "";
                    var db = new DatabaseManagement();
                    using (var con = new SqlConnection(db.ConnectionString))
                    {
                        using (SqlCommand cmd = new SqlCommand())
                        {
                            cmd.CommandText = "select Title from Tbl_Holidays where HolidayID=" + holiday;
                            cmd.Connection = con;
                            con.Open();
                            SqlDataReader dr = cmd.ExecuteReader();
                            while (dr.Read())
                            {
                                HolidayText = dr["Title"].ToString();
                            }
                            con.Close();

                        }
                    }
                    btnHoiday.Text = HolidayText + " <i class='fa fa-caret-down' aria-hidden='true' style='font-size:14px; margin-left:6px; margin-top:-5px;'></i>";

                }
                else
                {
                    btnHoiday.Text = "Holidays" + " <i class='fa fa-caret-down' aria-hidden='true' style='font-size:14px; margin-left:6px; margin-top:-5px;'></i>";
                    (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).holidayCheck = null;
                    holidayCheck = null;
                }
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
                //chkBrands.Items[1].Text = "Hania";
                
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
        chkBrands.DataSourceID = "sdsMoreBrands";
        chkBrands.DataBind();
        NameValueCollection nvc = Request.QueryString;
            if (nvc.HasKeys())
            {
                string brandid = nvc.Get("b");
                if (brandid != null)
                {
                    brandid = brandid.TrimEnd(',');
                    string[] ids = brandid.Split(',');
                    for (int i = 0; i < chkBrands.Items.Count; i++ )
                    {
                        if (ids.Contains(chkBrands.Items[i].Value))
                            chkBrands.Items[i].Selected = true;
                    }
                }
            }
        btn_ViewMore.Visible = false;
        btn_ViewLess.Visible = true;
    }

    private void DisplayDefaultBrands()
    {
        chkBrands.DataSourceID = "sdsbrandsSearch";
        chkBrands.DataBind();
        NameValueCollection nvc = Request.QueryString;
            if (nvc.HasKeys())
            {
                string brandid = nvc.Get("b");
                if (brandid != null)
                {
                    brandid = brandid.TrimEnd(',');
                    string[] ids = brandid.Split(',');
                    for (int i = 0; i < chkBrands.Items.Count; i++ )
                    {
                        if (ids.Contains(chkBrands.Items[i].Value))
                            chkBrands.Items[i].Selected = true;
                    }
                }
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
            int pagesize = 10;
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


            //int start = (pageIndex * pagesize) + 1;
            //int end = ((pageIndex * pagesize) + pagesize);

            int startItems = ((pageIndex - 1) * pagesize) + 1;
            int endItems = (startItems + pagesize) - 1;
            int tempCount = 1;

            var lookbookList = new List<Lookbook>();
            //string wherecluse = " Where   a.IsDeleted IS NULL AND a.IsPublished=1  AND row BETWEEN  " + start + "  AND " + end;
            string wherecluse = " Where   a.IsDeleted IS NULL AND a.IsPublished=1";
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

            string strBrandCheck = "";
            string strCategoryCheck = "";
            string strSeasonsCheck = "";
            string strHolidayCheck = "";
            string strBrandSearchCheck = "";
            string strTagIds = "";

            if (HttpContext.Current.Session["DiscoverLookbookPageSearch"] != null)
            {
                strBrandCheck = (HttpContext.Current.Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).brandCheck;
                strCategoryCheck = (HttpContext.Current.Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).categoryCheck;
                strSeasonsCheck = (HttpContext.Current.Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).seasonsCheck;
                strHolidayCheck = (HttpContext.Current.Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).holidayCheck;
                strBrandSearchCheck = (HttpContext.Current.Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).brandSearchCheck;
                if ((HttpContext.Current.Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).selectedTagsIds != null)
                {
                    foreach (int tagId in (HttpContext.Current.Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).selectedTagsIds)
                    {
                        strTagIds = strTagIds + tagId.ToString() + ",";
                    }
                }
            }

            if (strBrandCheck != null)
                strBrandCheck = strBrandCheck.TrimEnd(',');
            //string[] brandarray = brandid.Split(',');
            if (!string.IsNullOrEmpty(strCategoryCheck))
            {
                const string categoryJoin = " INNER JOIN Tbl_LbCategory ON Tbl_LbCategory.LookID=a.LookID  ";
                select = select + categoryJoin;
                wherecluse = wherecluse + " AND Tbl_LbCategory.CategoryID=" + IEUtils.ToInt(strCategoryCheck);
                wherecluse2 = wherecluse2 + " AND Tbl_LbCategory.CategoryID=" + IEUtils.ToInt(strCategoryCheck);
            }

            if (!string.IsNullOrEmpty(strSeasonsCheck))
            {
                const string seasonjoin = " INNER JOIN Tbl_LbSeasons ON Tbl_LbSeasons.LookID=a.LookID  ";
                select = select + seasonjoin;
                wherecluse = wherecluse + " AND Tbl_LbSeasons.SeasonID=" + IEUtils.ToInt(strSeasonsCheck);
                wherecluse2 = wherecluse2 + " AND Tbl_LbSeasons.SeasonID=" + IEUtils.ToInt(strSeasonsCheck);
            }

            if (!string.IsNullOrEmpty(strTagIds))
            {
                if (strTagIds.EndsWith(","))
                    strTagIds = strTagIds.Substring(0, strTagIds.Length - 1);
                const string tagjoin = " INNER JOIN Tbl_LBTags ON Tbl_LBTags.LookID=a.LookID  ";
                select = select + tagjoin;
                wherecluse = wherecluse + " AND Tbl_LBTags.TagID IN(" + strTagIds + ") ";
                wherecluse2 = wherecluse2 + " AND Tbl_LBTags.TagID IN(" + strTagIds + ") ";
            }

            if (!string.IsNullOrEmpty(strHolidayCheck))
            {
                const string holidayjoin = " INNER JOIN Tbl_LbHolidays ON Tbl_LbHolidays.LookID=a.LookID  ";
                select = select + holidayjoin;
                wherecluse = wherecluse + " AND Tbl_LbHolidays.HolidayID=" + IEUtils.ToInt(strHolidayCheck);
                wherecluse2 = wherecluse2 + " AND Tbl_LbHolidays.HolidayID=" + IEUtils.ToInt(strHolidayCheck);
            }


            if (!string.IsNullOrEmpty(strBrandCheck))
            {
                if (strBrandCheck.EndsWith(","))
                    strBrandCheck = strBrandCheck.Substring(0, strBrandCheck.Length - 1);
                wherecluse = wherecluse + " AND  a.UserID IN(" + strBrandCheck + ") ";
                wherecluse2 = wherecluse2 + " AND  a.UserID IN(" + strBrandCheck + ") ";
            }

            if (!string.IsNullOrEmpty(strBrandSearchCheck))
            {
                wherecluse = wherecluse + " AND a.Title LIKE '%" + strBrandSearchCheck + "%' ";
                wherecluse2 = wherecluse2 + " AND a.Title LIKE '%" + strBrandSearchCheck + "%' ";
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
            var desc = "";
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
                    var pageDoc = new HtmlDocument();
                    pageDoc.LoadHtml(objLb.Description);
                    desc = pageDoc.DocumentNode.InnerText;
                    objLb.Description = desc;
                    //lookbookList.Add(objLb);
                    if (tempCount >= startItems && tempCount <= endItems)
                    {
                        lookbookList.Add(objLb);
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
            return lookbookList;
        }
        catch (Exception ex)
        {
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            return null;
        }
    }

    [WebMethod, ScriptMethod]
    public static List<Lookbook> GetDataByTitle(int pageIndex, string title)
    {
        try
        {
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
                                                
                            lookbookList.Add(objLb);

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
    protected void ByCategory(string categry)
    {
        try
        {
            NameValueCollection nvc = Request.QueryString;
            /*if (nvc.HasKeys())
            {
                if (nvc["s"] != null)
                {
                    if (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch != null)
                        (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).seasonsCheck = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    nvc.Remove("s");
                }
                if (nvc["h"] != null)
                {
                    if (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch != null)
                        (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).holidayCheck = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    nvc.Remove("h");
                }
            }*/
            if (QuerystringExist())
                CheckQuerystringKey("c", categry);
            else
                _pageUrl = Pagename + "?c=" + categry;
            (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).categoryCheck = categry;
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
                }
                else
                {
                    nvc.Add(key, value);
                }
            }
            Response.Redirect(Pagename + "?" + Request.QueryString);
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

    protected void BySeason(string season)
    {
        try
        {
            NameValueCollection nvc = Request.QueryString;
            /*if (nvc.HasKeys())
            {
                if (nvc["c"] != null)
                {
                    if (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch != null)
                        (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).seasonsCheck = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    nvc.Remove("c");
                }
                if (nvc["h"] != null)
                {
                    if (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch != null)
                        (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).holidayCheck = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    nvc.Remove("h");
                }
            }*/
            if (QuerystringExist())
                CheckQuerystringKey("s", season);
            else
                _pageUrl = Pagename + "?s=" + season;
            Response.Redirect(_pageUrl);
            (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).seasonsCheck = season;
            seasonsCheck = season;
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    /*protected void Bycolor(string color)
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
    }*/

    protected void ByHoliday(string holiday)
    {
        try
        {
            NameValueCollection nvc = Request.QueryString;
            /*if (nvc.HasKeys())
            {
                if (nvc["c"] != null)
                {
                    if (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch != null)
                        (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).seasonsCheck = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    nvc.Remove("c");
                }
                if (nvc["s"] != null)
                {
                    if (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch != null)
                        (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).holidayCheck = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    nvc.Remove("s");
                }
            }*/
            if (QuerystringExist())
                CheckQuerystringKey("h", holiday);
            else
            {
                _pageUrl = Pagename + "?h=" + holiday;
            }
            (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).holidayCheck = holiday;
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
                txtsearch2.Text = string.Empty;
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
                txtsearch2.Text = string.Empty;
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
                txtsearch2.Text = string.Empty;
                string holiday = e.CommandArgument.ToString();
                ByHoliday(holiday);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }


    protected void chkBrands_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            string brandlist = chkBrands.Items.Cast<ListItem>().Where(itm => itm.Selected).Aggregate(string.Empty, (current, itm) => current + itm.Value + ",");

            if (!string.IsNullOrEmpty(brandlist))
            {
                (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).brandCheck = brandlist;
                brandCheck = brandlist;
                if (QuerystringExist())
                    CheckQuerystringKey("b", brandlist);
                else
                    _pageUrl = Pagename + "?b=" + brandlist;
               
                Response.Redirect(_pageUrl);

            }
            else
            {
                (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).brandCheck = null;
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

    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        try
        {
            brandSearchCheck = txtsearch2.Text;
            (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).brandSearchCheck = txtsearch2.Text;
            PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
            // make collection editable
            isreadonly.SetValue(this.Request.QueryString, false, null);
            Request.QueryString.Clear();
            Response.Redirect(Pagename + "?br=" + txtsearch2.Text,false);
            
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

    protected void btn_MoreTags_Click(object sender, EventArgs e)
    {
        rptTags.DataSourceID = "";
        rptTags.DataSource = sdsMoreTags;
        rptTags.DataBind();
        btn_MoreTags.Visible = false;
        btn_LessTags.Visible = true;
    }
    protected void btn_LessTags_Click(object sender, EventArgs e)
    {
        rptTags.DataSourceID = "";
        rptTags.DataSource = sdsTags;
        rptTags.DataBind();
        btn_MoreTags.Visible = true;
        btn_LessTags.Visible = false;
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

    protected void GetSelectedTags()
    {
        try
        {
            NameValueCollection nvc = Request.QueryString;
            chkBrands.DataBind();
            if (nvc.HasKeys())
            {
                string tagsIds = nvc.Get("t");
                if (tagsIds != null)
                {
                    List<string> tagidsList = tagsIds.Split(',').ToList();
                    if ((Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).selectedTagsIds == null)
                    {
                        (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).selectedTagsIds = new List<int>();
                    }
                    foreach (string tagId in tagidsList)
                    {
                        if (tagId != "")
                        {
                            (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).selectedTagsIds.Add(int.Parse(tagId));
                        }
                    }
                }
                else
                {
                    (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).selectedTagsIds = null;
                    brandCheck = null;
                }

            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void rptTags_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "1")
            {
                if ((Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).selectedTagsIds == null)
                {
                    (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).selectedTagsIds = new List<int>();
                }
                if ((Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).selectedTagsIds.Contains(int.Parse(e.CommandArgument.ToString())))
                {
                    (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).selectedTagsIds.Remove(int.Parse(e.CommandArgument.ToString()));
                }
                else
                {
                    (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).selectedTagsIds.Add(int.Parse(e.CommandArgument.ToString()));
                }

                string tagsList = "";
                foreach (int tagId in (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).selectedTagsIds)
                {
                    tagsList = tagsList + tagId + ",";
                }
                if (!string.IsNullOrEmpty(tagsList))
                {
                    if (QuerystringExist())
                        CheckQuerystringKey("t", tagsList);
                    else
                        _pageUrl = Pagename + "?t=" + tagsList;

                    Response.Redirect(_pageUrl, false);

                }
                else
                {
                    (Session["DiscoverLookbookPageSearch"] as DiscoverLookbookPageSearch).selectedTagsIds = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    NameValueCollection nvc = Request.QueryString;
                    nvc.Remove("t");
                    if (nvc.Count > 0)
                        Response.Redirect(Pagename + "?" + Request.QueryString, false);
                    else
                    {
                        Response.Redirect(Pagename, false);
                    }
                }
                //var db = new DatabaseManagement();
                //db.ExecuteSQL("Delete from Tbl_ItemTags Where TagID=" + IEUtils.ToInt(e.CommandArgument));
                //rptTags.DataBind();
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }


}