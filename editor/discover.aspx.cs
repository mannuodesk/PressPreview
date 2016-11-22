using System.Collections.Specialized;
using System.Data;
using System.Linq;
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
using System.Text.RegularExpressions;
using HtmlAgilityPack;

public partial class home : System.Web.UI.Page
{
    private string _pageUrl = HttpContext.Current.Request.Url.ToString();
    private string _pagename = "discover.aspx";
    private ArrayList _alSelectedPrice;

    private string categoryCheck;
    private string brandCheck;
    private string holidayCheck;
    private string colorCheck;
    private string seasonsCheck;
    private string brandSearchCheck;
    private string p1check = null;
    private string chkP2_Check = null;
    private string chkP3_Check = null;
    private string chkP4_Check = null;
    private string chkP5_Check = null;
    private string chkP6_Check = null;


    protected void Page_Load(object sender, EventArgs e)
    {

        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
        txtsearch.Attributes.Add("onKeyPress",
                 "doClick('" + btnSearch.ClientID + "',event)");
        if (!IsPostBack)
        {
            eliminateColor.Visible = false;
            categoryCheck = null;
            brandCheck = null;
            holidayCheck = null;
            p1check = null;
            chkP2_Check = null;
            chkP2_Check = null;
            chkP2_Check = null;
            chkP2_Check = null;
            chkP2_Check = null;
            brandSearchCheck = null;
            colorCheck = null;
            seasonsCheck = null;
            DiscoverPageSearch discoverPageSearch = new DiscoverPageSearch();
            Session["DiscoverPageSearch"] = discoverPageSearch;
            try
            {
                DisplayDefaultBrands();
            }
            catch (Exception ex)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
            //LoadData(1);
            GetSelectedBrands();
            GetSelectedPriceRangeFromURL();
            GetSelectedColorFromURL();
            GetSelectedTags();

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
            DiscoverPageSearch discoverPageSearch = (DiscoverPageSearch)Session["DiscoverPageSearch"];
            if (discoverPageSearch != null)
            {
                categoryCheck = discoverPageSearch.categoryCheck;
                brandCheck = discoverPageSearch.brandCheck;
                holidayCheck = discoverPageSearch.holidayCheck;
                p1check = discoverPageSearch.p1check;
                brandSearchCheck = discoverPageSearch.brandSearchCheck;
                colorCheck = discoverPageSearch.colorCheck;
                seasonsCheck = discoverPageSearch.seasonsCheck;
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
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).brandCheck = brandid;
                    brandCheck = brandid;
                }
                else
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).brandCheck = null;
                    brandCheck = null;
                }
                string category = nvc.Get("c");
                if (category != null)
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).categoryCheck = category;
                    categoryCheck = category;
                    
                      var CategoryText="";
                    var db = new DatabaseManagement();
  using (var con = new SqlConnection(db.ConnectionString))
                        {
                        using (SqlCommand cmd = new SqlCommand())
                            {
                            cmd.CommandText = "select Title from Tbl_Categories where CategoryID="+category;
                            cmd.Connection = con;
                            con.Open();
                            SqlDataReader dr = cmd.ExecuteReader();
                            while (dr.Read())
                                {
                            CategoryText=dr["Title"].ToString();
                                }
                            con.Close();

                            }
                        }
               lbCategory.Text = CategoryText +" <i class='fa fa-caret-down' aria-hidden='true' style='font-size:14px; margin-left:6px; margin-top:-5px;'></i>";
                }
                else
                {
                     lbCategory.Text = "Categories" +" <i class='fa fa-caret-down' aria-hidden='true' style='font-size:14px; margin-left:6px; margin-top:-5px;'></i>";
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).categoryCheck = null;
                    categoryCheck = null;
                }
                string season = nvc.Get("s");
                if (season != null)
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).seasonsCheck = season;
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
                    btnSeason.Text = "Seasons" +" <i class='fa fa-caret-down' aria-hidden='true' style='font-size:14px; margin-left:6px; margin-top:-5px;'></i>";
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).seasonsCheck = null;
                    seasonsCheck = null;
                }
                string holiday = nvc.Get("h");
                if (holiday != null)
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).holidayCheck = holiday;
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
                     btnHoiday.Text = "Holidays" +" <i class='fa fa-caret-down' aria-hidden='true' style='font-size:14px; margin-left:6px; margin-top:-5px;'></i>";
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).holidayCheck = null;
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
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
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
                    if ((Session["DiscoverPageSearch"] as DiscoverPageSearch).selectedTagsIds == null)
                    {
                        (Session["DiscoverPageSearch"] as DiscoverPageSearch).selectedTagsIds = new List<int>();
                    }
                    foreach (string tagId in tagidsList)
                    {
                        if (tagId != "")
                        {
                            (Session["DiscoverPageSearch"] as DiscoverPageSearch).selectedTagsIds.Add(int.Parse(tagId));
                        }
                    }
                }
                else
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).selectedTagsIds = null;
                    brandCheck = null;
                }

            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }


    protected void GetSelectedPriceRangeFromURL()
    {
        try
        {
            NameValueCollection nvc = Request.QueryString;
            if (nvc.HasKeys())
            {
                string price1 = nvc.Get("p1");
                if (price1 != null)
                {
                    p1check = price1;
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).p1check = price1; ;
                }
                else
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).p1check = null;
                    p1check = null;
                }
                string price2 = nvc.Get("p2");
                if (price2 != null)
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).chkP2_Check = price2;
                    chkP2_Check = price2;
                }
                else
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).chkP2_Check = null;
                    chkP2_Check = null;
                }
                string price3 = nvc.Get("p3");
                if (price3 != null)
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).chkP3_Check = price3;
                    chkP3_Check = price3;
                }
                else
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).chkP3_Check = null;
                    chkP3_Check = null;
                }
                string price4 = nvc.Get("p4");
                if (price4 != null)
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).chkP4_Check = price4;
                    chkP4_Check = price4;
                }
                else
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).chkP4_Check = null;
                    chkP4_Check = null;
                }
                string price5 = nvc.Get("p5");
                if (price5 != null)
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).chkP5_Check = price5;
                    chkP5_Check = price2;
                }
                else
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).chkP5_Check = null;
                    chkP5_Check = null;
                }
                string price6 = nvc.Get("p6");
                if (price6 != null)
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).chkP6_Check = price6;
                    chkP2_Check = price6;
                }
                else
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).chkP6_Check = null;
                    chkP6_Check = null;
                }
                chkP1.Checked = !string.IsNullOrEmpty(price1);
                chkP2.Checked = !string.IsNullOrEmpty(price2);
                chkP3.Checked = !string.IsNullOrEmpty(price3);
                chkP4.Checked = !string.IsNullOrEmpty(price4);
                chkP5.Checked = !string.IsNullOrEmpty(price5);
                chkP6.Checked = !string.IsNullOrEmpty(price6);

            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void GetSelectedColorFromURL()
    {
        try
        {
            NameValueCollection nvc = Request.QueryString;
            if (nvc.HasKeys())
            {
                string col123 = nvc.Get("cl");
                string brandname = nvc.Get("br");
                if (brandname != null)
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).brandSearchCheck = brandname;
                    brandSearchCheck = brandname;
                }
                else
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).brandSearchCheck = null;
                    brandSearchCheck = null;
                }
                if (col123 != null)
                {
                    eliminateColor.Visible = true;
                    string color = "#" + nvc.Get("cl");
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).colorCheck = nvc.Get("cl");
                    colorCheck = nvc.Get("cl");
                    string stylevalue = "background:" + color;
                    colbtn.Attributes.Add("style", stylevalue);
                }
                else
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).colorCheck = null;
                    colorCheck = null;
                }



            }


        }
        catch (Exception ex)
        {

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

        //  string qry = "SELECT Top 10 Name From Tbl_Brands Where Name LIKE '%" + empName + "%'";

        using (var con = new SqlConnection(db.ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT Top 10 Name From Tbl_Brands Where Name LIKE '%" + empName + "%'";
                cmd.Connection = con;
                con.Open();
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
    //protected void rptLookbook_ItemDataBound(object sender, RepeaterItemEventArgs e)
    //{
    //    try
    //    {
    //        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
    //        {
    //            Label lblDatePosted = (Label)e.Item.FindControl("lblDate");
    //            Label lblDate2 = (Label)e.Item.FindControl("lblDate2");
    //            DateTime dbDate = Convert.ToDateTime(lblDatePosted.Text);
    //            lblDate2.Text = Common.GetRelativeTime(dbDate);
    //            //var lblLikes = (Label)e.Item.FindControl("lblLikes");
    //            //lblLikes.Text = (Convert.ToInt32(lblLikes.Text)).ToString();

    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
    //    }
    //}

    protected void GetPriceCheckSelected()
    {
        _alSelectedPrice = Session["PriceList"] as ArrayList;
        if (_alSelectedPrice != null)
            foreach (int a in _alSelectedPrice)
            {
                switch (a)
                {
                    case 1:
                        chkP1.Checked = true;
                        break;
                    case 2:
                        chkP2.Checked = true;
                        break;
                    case 3:
                        chkP3.Checked = true;
                        break;
                    case 4:
                        chkP4.Checked = true;
                        break;
                    case 5:
                        chkP5.Checked = true;
                        break;

                    case 6:
                        chkP6.Checked = true;
                        break;
                }
            }
    }

    [WebMethod(EnableSession = true), ScriptMethod]

    public static List<Items> LoadData(int pageIndex)
    {
        try
        {
            int pagesize = 10;
            DatabaseManagement db = new DatabaseManagement();
            string fullQuery = string.Empty;
            string fullQuery2 = string.Empty;
            string @select =
               "SELECT distinct dbo.Tbl_Brands.Name, U_ProfilePic, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, " +
               " dbo.Tbl_Brands.Logo, a.ItemID,a.RetailPrice, a.Title, a.row, a.DatePosted as [dated],a.UserID,IsDeleted,IsPublished," +
               " ItemKey, SUBSTRING(a.Description,0,50) + '...' as Description , a.FeatureImg, " +
               " a.Views, Likes,  CAST(a.DatePosted AS VARCHAR(12)) as DatePosted," +
               " a.DatePosted as [dated] " +
               "FROM ( SELECT ROW_NUMBER() OVER (ORDER BY ItemID ASC) AS row, ItemID, dbo.Tbl_Items.Title, dbo.Tbl_Items.Color," +
               " ItemKey, SUBSTRING(dbo.Tbl_Items.Description,0,50) + '...' as Description, dbo.Tbl_Items.FeatureImg," +
               " dbo.Tbl_Items.Views, CAST(dbo.Tbl_Items.DatePosted AS VARCHAR(12)) as DatePosted, " +
               " dbo.Tbl_Items.DatePosted as [dated],UserID,IsDeleted,IsPublished, Likes, RetailPrice FROM Tbl_Items ) AS a " +
               " INNER JOIN Tbl_Brands ON Tbl_Brands.UserID=a.UserID " +
               " INNER JOIN dbo.Tbl_Users ON dbo.Tbl_Users.UserID=Tbl_Brands.UserID ";


            int startItems = ((pageIndex - 1) * pagesize) + 1;
            int endItems = (startItems + pagesize) - 1;
            int tempCount = 1;
            var itemList = new List<Items>();
            //string wherecluse = " Where   a.IsDeleted IS NULL AND a.IsPublished=1  AND row BETWEEN  " + start + "  AND " + end;
            string wherecluse = " Where   a.IsDeleted IS NULL AND a.IsPublished=1";
            string wherecluse2 = " Where   a.IsDeleted IS NULL AND a.IsPublished=1";
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
            string strBrandCheck = "";
            string strCategoryCheck = "";
            string strSeasonsCheck = "";
            string strHolidayCheck = "";
            string strColorCheck = "";
            string strBrandSearchCheck = "";
            string strP1check = "";
            string strChkP2_Check = "";
            string strChkP3_Check = "";
            string strChkP4_Check = "";
            string strChkP5_Check = "";
            string strChkP6_Check = "";
            string strTagIds = "";
            if (HttpContext.Current.Session["DiscoverPageSearch"] != null)
            {
                strBrandCheck = (HttpContext.Current.Session["DiscoverPageSearch"] as DiscoverPageSearch).brandCheck;
                strCategoryCheck = (HttpContext.Current.Session["DiscoverPageSearch"] as DiscoverPageSearch).categoryCheck;
                strSeasonsCheck = (HttpContext.Current.Session["DiscoverPageSearch"] as DiscoverPageSearch).seasonsCheck;
                strHolidayCheck = (HttpContext.Current.Session["DiscoverPageSearch"] as DiscoverPageSearch).holidayCheck;
                strColorCheck = (HttpContext.Current.Session["DiscoverPageSearch"] as DiscoverPageSearch).colorCheck;
                strBrandSearchCheck = (HttpContext.Current.Session["DiscoverPageSearch"] as DiscoverPageSearch).brandSearchCheck;
                strP1check = (HttpContext.Current.Session["DiscoverPageSearch"] as DiscoverPageSearch).p1check;
                strChkP2_Check = (HttpContext.Current.Session["DiscoverPageSearch"] as DiscoverPageSearch).chkP2_Check;
                strChkP3_Check = (HttpContext.Current.Session["DiscoverPageSearch"] as DiscoverPageSearch).chkP3_Check;
                strChkP4_Check = (HttpContext.Current.Session["DiscoverPageSearch"] as DiscoverPageSearch).chkP4_Check;
                strChkP5_Check = (HttpContext.Current.Session["DiscoverPageSearch"] as DiscoverPageSearch).chkP5_Check;
                strChkP6_Check = (HttpContext.Current.Session["DiscoverPageSearch"] as DiscoverPageSearch).chkP6_Check;
                if ((HttpContext.Current.Session["DiscoverPageSearch"] as DiscoverPageSearch).selectedTagsIds != null)
                {
                    foreach (int tagId in (HttpContext.Current.Session["DiscoverPageSearch"] as DiscoverPageSearch).selectedTagsIds)
                    {
                        strTagIds = strTagIds + tagId.ToString() + ",";
                    }
                }
            }

            List<string> brandlist = new List<string>();

            if (strBrandCheck != null)
            {
                //brandlist = strBrandCheck.Split(',').ToList();
                strBrandCheck.TrimEnd(',');
            }
            //string[] brandarray = brandid.Split(',');
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

            if (!string.IsNullOrEmpty(strTagIds))
            {
                if (strTagIds.EndsWith(","))
                    strTagIds = strTagIds.Substring(0, strTagIds.Length - 1);
                /*const string tagjoin = " INNER JOIN TBl_ItemTags ON TBl_ItemTags.ItemID=a.ItemID  ";
                select = select + tagjoin;
                wherecluse = wherecluse + " AND TBl_ItemTags.TagID IN(" + strTagIds + ") ";
                wherecluse2 = wherecluse2 + " AND TBl_ItemTags.TagID IN(" + strTagIds + ") ";*/
                const string tagjoin = " INNER JOIN Tbl_ItemTagsMapping ON Tbl_ItemTagsMapping.ItemID=a.ItemID  ";
                select = select + tagjoin;
                wherecluse = wherecluse + " AND Tbl_ItemTagsMapping.TagID IN(" + strTagIds + ") ";
                wherecluse2 = wherecluse2 + " AND Tbl_ItemTagsMapping.TagID IN(" + strTagIds + ") ";
            }

            if (!string.IsNullOrEmpty(strHolidayCheck))
            {
                const string holidayjoin = " INNER JOIN Tbl_ItemHolidays ON Tbl_ItemHolidays.ItemID=a.ItemID  ";
                select = select + holidayjoin;
                wherecluse = wherecluse + " AND Tbl_ItemHolidays.HolidayID=" + IEUtils.ToInt(strHolidayCheck);
                wherecluse2 = wherecluse2 + " AND Tbl_ItemHolidays.HolidayID=" + IEUtils.ToInt(strHolidayCheck);
            }

            if (!string.IsNullOrEmpty(strColorCheck))
            {
                wherecluse = wherecluse + " AND a.Color=" + IEUtils.SafeSQLString(strColorCheck);
                wherecluse2 = wherecluse2 + " AND a.Color=" + IEUtils.SafeSQLString(strColorCheck);
            }

            bool bPriceCheck = false;

            if (!string.IsNullOrEmpty(strP1check))
            {
                wherecluse = wherecluse + " AND  ((a.RetailPrice>=0 AND a.RetailPrice<=100)  ";
                wherecluse2 = wherecluse2 + " AND  ((a.RetailPrice>=0 AND a.RetailPrice<=100)  ";
                bPriceCheck = true;
            }

            if (!string.IsNullOrEmpty(strChkP2_Check))
            {
                if (bPriceCheck == false)
                {
                    wherecluse = wherecluse + " AND  ((a.RetailPrice>=100 AND a.RetailPrice<=200)  ";
                    wherecluse2 = wherecluse2 + " AND  ((a.RetailPrice>=100 AND a.RetailPrice<=200)  ";
                }
                else
                {
                    wherecluse = wherecluse + " OR  (a.RetailPrice>=100 AND a.RetailPrice<=200)  ";
                    wherecluse2 = wherecluse2 + " OR  (a.RetailPrice>=100 AND a.RetailPrice<=200)  ";
                }
                bPriceCheck = true;
            }

            if (!string.IsNullOrEmpty(strChkP3_Check))
            {
                if (bPriceCheck == false)
                {
                    wherecluse = wherecluse + " AND  ((a.RetailPrice>=200 AND a.RetailPrice<=300)  ";
                    wherecluse2 = wherecluse2 + " AND  ((a.RetailPrice>=200 AND a.RetailPrice<=300)  ";
                }
                else
                {
                    wherecluse = wherecluse + " OR  (a.RetailPrice>=200 AND a.RetailPrice<=300)  ";
                    wherecluse2 = wherecluse2 + " OR  (a.RetailPrice>=200 AND a.RetailPrice<=300)  ";
                }
                bPriceCheck = true;
            }

            if (!string.IsNullOrEmpty(strChkP4_Check))
            {
                if (bPriceCheck == false)
                {
                    wherecluse = wherecluse + " AND  ((a.RetailPrice>=300 AND a.RetailPrice<=400)  ";
                    wherecluse2 = wherecluse2 + " AND  ((a.RetailPrice>=300 AND a.RetailPrice<=400)  ";
                }
                else
                {
                    wherecluse = wherecluse + " OR  (a.RetailPrice>=300 AND a.RetailPrice<=400)  ";
                    wherecluse2 = wherecluse2 + " OR  (a.RetailPrice>=300 AND a.RetailPrice<=400)  ";
                }
                bPriceCheck = true;
            }

            if (!string.IsNullOrEmpty(strChkP5_Check))
            {
                if (bPriceCheck == false)
                {
                    wherecluse = wherecluse + " AND  ((a.RetailPrice>=400 AND a.RetailPrice<=500)  ";
                    wherecluse2 = wherecluse2 + " AND  ((a.RetailPrice>=400 AND a.RetailPrice<=500)  ";
                }
                else
                {
                    wherecluse = wherecluse + " OR  (a.RetailPrice>=400 AND a.RetailPrice<=500)  ";
                    wherecluse2 = wherecluse2 + " OR  (a.RetailPrice>=400 AND a.RetailPrice<=500)  ";
                }
                bPriceCheck = true;
            }

            if (!string.IsNullOrEmpty(strChkP6_Check))
            {
                if (bPriceCheck == false)
                {
                    wherecluse = wherecluse + " AND  ((a.RetailPrice>=500)  ";
                    wherecluse2 = wherecluse2 + " AND  ((a.RetailPrice>=500)  ";
                }
                else
                {
                    wherecluse = wherecluse + " OR  (a.RetailPrice>=500)  ";
                    wherecluse2 = wherecluse2 + " OR  (a.RetailPrice>=500)  ";
                }
                bPriceCheck = true;
            }
            
            if (bPriceCheck)
            {
                wherecluse = wherecluse + ")";
                wherecluse2 = wherecluse2 + ")";
            }

            if (!string.IsNullOrEmpty(strBrandCheck))
            {

                /*foreach (var brandId in brandlist)
                {
                    if (!string.IsNullOrEmpty(brandId))
                    {
                        wherecluse = wherecluse + " AND  a.UserID IN(" + brandId + ") ";
                        wherecluse2 = wherecluse2 + " AND  a.UserID IN(" + brandId + ") ";
                    }

                }*/
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
var desc="";
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


    protected void ByCategory(string categry)
    {
        try
        {
            (Session["DiscoverPageSearch"] as DiscoverPageSearch).categoryCheck = categry;
            categoryCheck = categry;
            NameValueCollection nvc = Request.QueryString;
            if (nvc.HasKeys())
            {
                if (nvc["s"] != null)
                {
                    if (Session["DiscoverPageSearch"] as DiscoverPageSearch != null)
                        (Session["DiscoverPageSearch"] as DiscoverPageSearch).seasonsCheck = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    nvc.Remove("s");
                }
                if (nvc["h"] != null)
                {
                    if (Session["DiscoverPageSearch"] as DiscoverPageSearch != null)
                        (Session["DiscoverPageSearch"] as DiscoverPageSearch).holidayCheck = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    nvc.Remove("h");
                }
            }

            if (QuerystringExist())
                CheckQuerystringKey("c", categry);
            else
                _pageUrl = _pagename + "?c=" + categry;

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
                    Response.Redirect(_pagename + "?" + Request.QueryString);
                }
                else
                {
                    nvc.Add(key, value);
                    Response.Redirect(_pagename + "?" + Request.QueryString);
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
            seasonsCheck = season;
            NameValueCollection nvc = Request.QueryString;
            if (nvc.HasKeys())
            {
                if (nvc["c"] != null)
                {
                    if (Session["DiscoverPageSearch"] as DiscoverPageSearch != null)
                        (Session["DiscoverPageSearch"] as DiscoverPageSearch).categoryCheck = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    nvc.Remove("c");
                }
                if (nvc["h"] != null)
                {
                    if (Session["DiscoverPageSearch"] as DiscoverPageSearch != null)
                        (Session["DiscoverPageSearch"] as DiscoverPageSearch).holidayCheck = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    nvc.Remove("h");
                }
            }
            (Session["DiscoverPageSearch"] as DiscoverPageSearch).seasonsCheck = season;
            if (QuerystringExist())
                CheckQuerystringKey("s", season);
            else
                _pageUrl = _pagename + "?s=" + season;

            Response.Redirect(_pageUrl);

        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void Bycolor(string color)
    {
        try
        {
            (Session["DiscoverPageSearch"] as DiscoverPageSearch).colorCheck = color;
            colorCheck = color;
            if (QuerystringExist())
            {
                CheckQuerystringKey("cl", color);

            }

            else
            {
                _pageUrl = _pagename + "?cl=" + color;
            }

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
            NameValueCollection nvc = Request.QueryString;
            if (nvc.HasKeys())
            {
                if (nvc["s"] != null)
                {
                    if (Session["DiscoverPageSearch"] as DiscoverPageSearch != null)
                        (Session["DiscoverPageSearch"] as DiscoverPageSearch).seasonsCheck = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    nvc.Remove("s");
                }
                if (nvc["c"] != null)
                {
                    if (Session["DiscoverPageSearch"] as DiscoverPageSearch != null)
                        (Session["DiscoverPageSearch"] as DiscoverPageSearch).categoryCheck = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    nvc.Remove("c");
                }
            }
            holidayCheck = holiday;
            (Session["DiscoverPageSearch"] as DiscoverPageSearch).holidayCheck = holiday;
            if (QuerystringExist())
                CheckQuerystringKey("h", holiday);
            else
            {
                _pageUrl = _pagename + "?h=" + holiday;
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

    protected void chkP1_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            if (chkP1.Checked)
            {
                p1check = "0-100";
                if (QuerystringExist())
                    CheckQuerystringKey("p1", "0-100");
                else
                {
                    _pageUrl = _pagename + "?p1=0-100";
                }

                Response.Redirect(_pageUrl);

            }
            else
            {
                p1check = null;
                PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                // make collection editable
                isreadonly.SetValue(this.Request.QueryString, false, null);
                NameValueCollection nvc = Request.QueryString;
                nvc.Remove("p1");
                if (nvc.Count > 0)
                    Response.Redirect(_pagename + "?" + Request.QueryString);
                else
                {
                    Response.Redirect(_pagename);
                }
            }
        }
        catch (Exception ex)
        {
            ex.ToString();
        }

    }

    protected void chkP2_OnCheckedChanged(object sender, EventArgs e)
    {
        try
        {
            if (chkP2.Checked)
            {
                chkP2_Check = "100-200";
                if (QuerystringExist())
                    CheckQuerystringKey("p2", "100-200");
                else
                {
                    _pageUrl = _pagename + "?p2=100-200";
                }

                Response.Redirect(_pageUrl);
            }
            else
            {
                chkP2_Check = null;
                PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                // make collection editable
                isreadonly.SetValue(this.Request.QueryString, false, null);
                NameValueCollection nvc = Request.QueryString;
                nvc.Remove("p2");
                if (nvc.Count > 0)
                    Response.Redirect(_pagename + "?" + Request.QueryString);
                else
                {
                    Response.Redirect(_pagename);
                }
            }
        }
        catch (Exception ex) { }
    }

    protected void chkP3_OnCheckedChanged(object sender, EventArgs e)
    {
        if (chkP3.Checked)
        {
            chkP3_Check = "200-300";
            if (QuerystringExist())
                CheckQuerystringKey("p3", "200-300");
            else
            {
                _pageUrl = _pagename + "?p3=200-300";
            }

            Response.Redirect(_pageUrl);
        }
        else
        {
            chkP3_Check = null;
            PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
            // make collection editable
            isreadonly.SetValue(this.Request.QueryString, false, null);
            NameValueCollection nvc = Request.QueryString;
            nvc.Remove("p3");
            if (nvc.Count > 0)
                Response.Redirect(_pagename + "?" + Request.QueryString);
            else
            {
                Response.Redirect(_pagename);
            }
        }
    }

    protected void chkP4_OnCheckedChanged(object sender, EventArgs e)
    {
        if (chkP4.Checked)
        {
            chkP4_Check = "300-400";
            if (QuerystringExist())
                CheckQuerystringKey("p4", "300-400");
            else
            {
                _pageUrl = _pagename + "?p4=300-400";
            }
            _alSelectedPrice.Add(4);

            Response.Redirect(_pageUrl);
        }
        else
        {
            chkP4_Check = null;
            PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
            // make collection editable
            isreadonly.SetValue(this.Request.QueryString, false, null);
            NameValueCollection nvc = Request.QueryString;
            nvc.Remove("p4");
            if (nvc.Count > 0)
                Response.Redirect(_pagename + "?" + Request.QueryString);
            else
            {
                Response.Redirect(_pagename);
            }
        }
    }


    protected void chkP5_OnCheckedChanged(object sender, EventArgs e)
    {
        if (chkP5.Checked)
        {
            chkP5_Check = "400-500";
            if (QuerystringExist())
                CheckQuerystringKey("p5", "400-500");
            else
            {
                _pageUrl = _pagename + "?p5=400-500";
            }
            _alSelectedPrice.Add(5);

            Response.Redirect(_pageUrl);
        }
        else
        {
            chkP5_Check = null;
            PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
            // make collection editable
            isreadonly.SetValue(this.Request.QueryString, false, null);
            NameValueCollection nvc = Request.QueryString;
            nvc.Remove("p5");
            if (nvc.Count > 0)
                Response.Redirect(_pagename + "?" + Request.QueryString);
            else
            {
                Response.Redirect(_pagename);
            }
        }
    }

    protected void chkP6_OnCheckedChanged(object sender, EventArgs e)
    {
        if (chkP6.Checked)
        {
            chkP6_Check = "500";
            if (QuerystringExist())
                CheckQuerystringKey("p6", "500");
            else
            {
                _pageUrl = _pagename + "?p6=500";
            }

            Response.Redirect(_pageUrl);
        }
        else
        {
            chkP6_Check = null;
            PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
            // make collection editable
            isreadonly.SetValue(this.Request.QueryString, false, null);
            NameValueCollection nvc = Request.QueryString;
            nvc.Remove("p6");
            if (nvc.Count > 0)
                Response.Redirect(_pagename + "?" + Request.QueryString);
            else
            {
                Response.Redirect(_pagename);
            }
        }
    }

    protected void chkBrands_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            string brandlist = chkBrands.Items.Cast<ListItem>().Where(itm => itm.Selected).Aggregate(string.Empty, (current, itm) => current + itm.Value + ",");
            brandCheck = brandlist;
            (Session["DiscoverPageSearch"] as DiscoverPageSearch).brandCheck = brandlist;
            if (!string.IsNullOrEmpty(brandlist))
            {
                if (QuerystringExist())
                    CheckQuerystringKey("b", brandlist);
                else
                    _pageUrl = _pagename + "?b=" + brandlist;

                Response.Redirect(_pageUrl);

            }
            else
            {
                brandCheck = null;
                (Session["DiscoverPageSearch"] as DiscoverPageSearch).brandCheck = null;
                PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                // make collection editable
                isreadonly.SetValue(this.Request.QueryString, false, null);
                NameValueCollection nvc = Request.QueryString;
                nvc.Remove("b");
                if (nvc.Count > 0)
                    Response.Redirect(_pagename + "?" + Request.QueryString, false);
                else
                {
                    Response.Redirect(_pagename, false);
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
            brandSearchCheck = txtsearch.Text;
            (Session["DiscoverPageSearch"] as DiscoverPageSearch).brandSearchCheck = txtsearch.Text;
            PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
            // make collection editable
            isreadonly.SetValue(this.Request.QueryString, false, null);
            Request.QueryString.Clear();
            Response.Redirect(_pagename + "?br=" + txtsearch.Text);
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

    protected void rptColorlist_OnItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "1")
            {
                //  txtsearch.Text = string.Empty;
                string color = e.CommandArgument.ToString();
                Bycolor(color);
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
    protected void rptTags_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "1")
            {
                NameValueCollection nvc1 = Request.QueryString;
            if (nvc1.HasKeys())
            {
                if (nvc1["t"] != null)
                {
                    if (Session["DiscoverPageSearch"] as DiscoverPageSearch != null)
                        (Session["DiscoverPageSearch"] as DiscoverPageSearch).seasonsCheck = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    nvc1.Remove("t");
                }
            }
                //if ((Session["DiscoverPageSearch"] as DiscoverPageSearch).selectedTagsIds == null)
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).selectedTagsIds = new List<int>();
                }
                if ((Session["DiscoverPageSearch"] as DiscoverPageSearch).selectedTagsIds.Contains(int.Parse(e.CommandArgument.ToString())))
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).selectedTagsIds.Remove(int.Parse(e.CommandArgument.ToString()));
                }
                else
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).selectedTagsIds.Add(int.Parse(e.CommandArgument.ToString()));
                }

                string tagsList = "";
                foreach (int tagId in (Session["DiscoverPageSearch"] as DiscoverPageSearch).selectedTagsIds)
                {
                    tagsList = tagsList + tagId + ",";
                }
                if (!string.IsNullOrEmpty(tagsList))
                {
                    if (QuerystringExist())
                        CheckQuerystringKey("t", tagsList);
                    else
                        _pageUrl = _pagename + "?t=" + tagsList;

                    Response.Redirect(_pageUrl, false);

                }
                else
                {
                    (Session["DiscoverPageSearch"] as DiscoverPageSearch).selectedTagsIds = null;
                    PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                    // make collection editable
                    isreadonly.SetValue(this.Request.QueryString, false, null);
                    NameValueCollection nvc = Request.QueryString;
                    nvc.Remove("t");
                    if (nvc.Count > 0)
                        Response.Redirect(_pagename + "?" + Request.QueryString, false);
                    else
                    {
                        Response.Redirect(_pagename, false);
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
            return 0;
            // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
        return 0;
    }
    protected void eliminateColor_Click(object sender, EventArgs e)
    {
        eliminateColor.Visible = false;
        NameValueCollection nvc = Request.QueryString;
        if (nvc["cl"] != null)
        {
            if (Session["DiscoverPageSearch"] as DiscoverPageSearch != null)
                (Session["DiscoverPageSearch"] as DiscoverPageSearch).colorCheck = null;
            PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
            // make collection editable
            isreadonly.SetValue(this.Request.QueryString, false, null);
            nvc.Remove("cl");
        }
        _pageUrl = _pagename + Request.QueryString;

        Response.Redirect(_pageUrl);
    }
}