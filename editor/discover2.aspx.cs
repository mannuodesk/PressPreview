using System.Collections.Specialized;
using System.Reflection;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using DLS.DatabaseServices;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class home : System.Web.UI.Page
{
    private string _pageUrl = HttpContext.Current.Request.Url.ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        if (!IsPostBack)
        {
            try
            {
                DisplayDefaultBrands();
            }
            catch (Exception ex)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
            LoadData();
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
    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
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
                cmd.Parameters.AddWithValue("@SearchEmpName", empName);
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
        // HttpContext.Current.Session["ColorVal"] = value;

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

    protected void LoadData()
    {
        try
        {
            string fullQuery = string.Empty;
            const string @select = "SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, " +
                                   " dbo.Tbl_Brands.Logo, dbo.Tbl_Items.ItemID, dbo.Tbl_Items.Title, " +
                                   " ItemKey, dbo.Tbl_Items.Description, dbo.Tbl_Items.FeatureImg, " +
                                   " dbo.Tbl_Items.Views, CAST(dbo.Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted," +
                                   " dbo.Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands " +
                                   " INNER JOIN dbo.Tbl_Items ON dbo.Tbl_Brands.UserID = dbo.Tbl_Items.UserID ";

            string wherecluse = " Where   dbo.Tbl_Items.IsDeleted IS NULL AND dbo.Tbl_Items.IsPublished=1 ";
            const string orderBy = " ORDER BY dbo.Tbl_Items.DatePosted DESC";
            NameValueCollection nvc = Request.QueryString;
            if (nvc.HasKeys())  // check for the query string parameter. if the URL has query string keys, get those values 
            {
                string category = nvc.Get("c");
                string season = nvc.Get("s");
                string holiday = nvc.Get("h");
                string color = nvc.Get("cl");
                string price1 = nvc.Get("p1");
                string price2 = nvc.Get("p2");
                string price3 = nvc.Get("p3");
                string price4 = nvc.Get("p4");
                string price5 = nvc.Get("p5");
                string price6 = nvc.Get("p6");
                if (!string.IsNullOrEmpty(category))
                    wherecluse = wherecluse + " AND Category=" + IEUtils.SafeSQLString(category);
                if (!string.IsNullOrEmpty(season))
                    wherecluse = wherecluse + " AND Season=" + IEUtils.SafeSQLString(season);
                if (!string.IsNullOrEmpty(holiday))
                    wherecluse = wherecluse + " AND Holiday=" + IEUtils.SafeSQLString(holiday);
                if (!string.IsNullOrEmpty(color))
                    wherecluse = wherecluse + " AND Color=" + IEUtils.SafeSQLString(color);
                if (!string.IsNullOrEmpty(price1))
                    wherecluse = wherecluse + " OR  (RetailPrice>=0 OR RetailPrice<=100)  ";
                if (!string.IsNullOrEmpty(price2))
                    wherecluse = wherecluse + " OR  (RetailPrice>=100 OR RetailPrice<=200)  ";
                if (!string.IsNullOrEmpty(price3))
                    wherecluse = wherecluse + " OR  (RetailPrice>=200 OR RetailPrice<=300)  ";
                if (!string.IsNullOrEmpty(price4))
                    wherecluse = wherecluse + " OR  (RetailPrice>=300 OR RetailPrice<=400)  ";
                if (!string.IsNullOrEmpty(price5))
                    wherecluse = wherecluse + " OR  (RetailPrice>=400 OR RetailPrice<=500)  ";
                if (!string.IsNullOrEmpty(price6))
                    wherecluse = wherecluse + " OR  (RetailPrice>=500)  ";
                fullQuery = fullQuery + select + wherecluse + orderBy;

            }
            else
            {
                // if no query string key exist, execute the default query
                fullQuery = fullQuery + select + wherecluse + orderBy;
            }

            sdsLookbooks.SelectCommand = fullQuery;
            rptLookbook.DataSourceID = "";
            rptLookbook.DataSource = sdsLookbooks;
            rptLookbook.DataBind();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
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

            if (QuerystringExist())
                CheckQuerystringKey("c", categry);
            else
                _pageUrl = "discover.aspx?c=" + categry;
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
                    Response.Redirect("discover.aspx?" + Request.QueryString);
                }
                else
                {
                    nvc.Add(key, value);
                    Response.Redirect("discover.aspx?" + Request.QueryString);
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

            if (QuerystringExist())
                CheckQuerystringKey("s", season);
            else
                _pageUrl = "discover.aspx?s=" + season;
            Response.Redirect(_pageUrl);
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
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

            if (QuerystringExist())
                CheckQuerystringKey("h", holiday);
            else
            {
                _pageUrl = "discover.aspx?h=" + holiday;
            }
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
                txtsearch.Value = string.Empty;
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
                txtsearch.Value = string.Empty;
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
                txtsearch.Value = string.Empty;
                string holiday = e.CommandArgument.ToString();
                ByHoliday(holiday);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void txtsearch_OnServerChange(object sender, EventArgs e)
    {
        var db = new DatabaseManagement();
        using (var con = new SqlConnection(db.ConnectionString))
        {
            using (var cmd = new SqlCommand())
            {
                const string qrySearch = "SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, dbo.Tbl_Brands.Logo, Tbl_Items.ItemID," +
                                         " Tbl_Items.Title, Tbl_Items.ItemKey, Tbl_Items.Description, Tbl_Items.FeatureImg, Tbl_Items.Views," +
                                         " CAST(Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted, Tbl_Items.DatePosted as [dated] FROM dbo.Tbl_Brands " +
                                         " INNER JOIN Tbl_Items ON dbo.Tbl_Brands.UserID = Tbl_Items.UserID " +
                                         " Where dbo.Tbl_Brands.UserID =@BrandID AND Tbl_Items.Title LIKE ''+@SearchName+'%'  AND Tbl_Items.IsDeleted IS NULL AND Tbl_Items.IsPublished = 1 " +
                                         " ORDER BY Tbl_Items.DatePosted DESC";
                cmd.CommandText = qrySearch;
                cmd.Connection = con;
                con.Open();
                cmd.Parameters.AddWithValue("@BrandID", IEUtils.ToInt(Request.QueryString["v"]));
                cmd.Parameters.AddWithValue("@SearchName", txtsearch.Value);

                // SqlDataReader dr = cmd.ExecuteReader();
                rptLookbook.DataSourceID = "";
                rptLookbook.DataSource = cmd.ExecuteReader();
                rptLookbook.DataBind();
                con.Close();

            }
        }
    }
    protected void chkP1_CheckedChanged(object sender, EventArgs e)
    {
        if (chkP1.Checked)
        {
            if (QuerystringExist())
                CheckQuerystringKey("p1", chkP1.Text);
            else
            {
                _pageUrl = "discover.aspx?p1=" + chkP1.Text;
            }
            Response.Redirect(_pageUrl);
        }
        else
        {
            NameValueCollection nvc = Request.QueryString;
            nvc.Remove("p1");
            Response.Redirect("discover.aspx?" + Request.QueryString);
        }
    }

    protected void chkP2_OnCheckedChanged(object sender, EventArgs e)
    {
        if (chkP2.Checked)
        {
            if (QuerystringExist())
                CheckQuerystringKey("p2", chkP2.Text);
            else
            {
                _pageUrl = "discover.aspx?p2=" + chkP2.Text;
            }
            Response.Redirect(_pageUrl);
        }
        else
        {
            NameValueCollection nvc = Request.QueryString;
            nvc.Remove("p2");
            Response.Redirect("discover.aspx?" + Request.QueryString);
        };
    }

    protected void chkP3_OnCheckedChanged(object sender, EventArgs e)
    {
        if (chkP3.Checked)
        {
            if (QuerystringExist())
                CheckQuerystringKey("p3", chkP3.Text);
            else
            {
                _pageUrl = "discover.aspx?p3=" + chkP3.Text;
            }
            Response.Redirect(_pageUrl);
        }
        else
        {
            NameValueCollection nvc = Request.QueryString;
            nvc.Remove("p3");
            Response.Redirect("discover.aspx?" + Request.QueryString);
        }
    }

    protected void chkP4_OnCheckedChanged(object sender, EventArgs e)
    {
        if (chkP4.Checked)
        {
            if (QuerystringExist())
                CheckQuerystringKey("p4", chkP4.Text);
            else
            {
                _pageUrl = "discover.aspx?p4=" + chkP4.Text;
            }
            Response.Redirect(_pageUrl);
        }
        else
        {
            NameValueCollection nvc = Request.QueryString;
            nvc.Remove("p4");
            Response.Redirect("discover.aspx?" + Request.QueryString);
        }
    }

    protected void chkP5_OnCheckedChanged(object sender, EventArgs e)
    {
        if (chkP5.Checked)
        {
            if (QuerystringExist())
                CheckQuerystringKey("p5", chkP5.Text);
            else
            {
                _pageUrl = "discover.aspx?p5=" + chkP5.Text;
            }
            Response.Redirect(_pageUrl);
        }
        else
        {
            NameValueCollection nvc = Request.QueryString;
            nvc.Remove("p5");
            Response.Redirect("discover.aspx?" + Request.QueryString);
        }
    }

    protected void chkP6_OnCheckedChanged(object sender, EventArgs e)
    {
        if (chkP6.Checked)
        {
            if (QuerystringExist())
                CheckQuerystringKey("p6", chkP6.Text);
            else
            {
                _pageUrl = "discover.aspx?p6=" + chkP1.Text;
            }
            Response.Redirect(_pageUrl);
        }
        else
        {
            NameValueCollection nvc = Request.QueryString;
            nvc.Remove("p6");
            Response.Redirect("discover.aspx?" + Request.QueryString);
        }
    }
}