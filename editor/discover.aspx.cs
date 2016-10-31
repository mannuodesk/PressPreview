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

public partial class home : System.Web.UI.Page
{
    private string _pageUrl = HttpContext.Current.Request.Url.ToString();
    private string _pagename = "discover.aspx";
    private ArrayList _alSelectedPrice;
    protected void Page_Load(object sender, EventArgs e)
    {
        var al = new ArrayList {lblUsername, imgUserIcon};
        Common.UserSettings(al);
        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
        txtsearch.Attributes.Add("onKeyPress",
                 "doClick('" + btnSearch.ClientID + "',event)");
        if (!IsPostBack)
        {
            categoryCheck = null;
            brandCheck = null;
            holidayCheck = null;
            p1check = null;
            chkP2 = null;
            chkP3 = null;
            chkP4 = null;
            chkP5 = null;
            chkP6 = null;
            brandCheck = null;
            brandSearchCheck=null ;
            colorCheck = null;
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
        }
        
    }

    
    protected void GetSelectedBrands()
    {
        try
        {
            NameValueCollection nvc = Request.QueryString;
            chkBrands.DataBind();
            if(nvc.HasKeys())
            {
                string brandid = nvc.Get("b");
                if(brandid != null){brandCheck = brandid;}else{brandCheck = brandid;}
                string category = nvc.Get("c");
                if (category != null) { categoryCheck = category; } else { categoryCheck = null; }
                string season = nvc.Get("s");
                if (season != null) { seasonsCheck= season; } else { seasonsCheck = null; }
                string holiday = nvc.Get("h");
                if (holiday != null) { holidayCheck = holiday; } else { holidayCheck = null; }
                if (brandid != null)
                {
                    brandid = brandid.TrimEnd(',');
                    string[] ids = brandid.Split(',');
                    foreach(ListItem itm in chkBrands.Items)
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
    protected void GetSelectedPriceRangeFromURL()
    {
        try
        {
            NameValueCollection nvc = Request.QueryString;
            if(nvc.HasKeys())
            {
                string price1 = nvc.Get("p1");
                if (price1 != null){p1check = price1;}else{p1check = price1;}
                string price2 = nvc.Get("p2");
                if (price2 != null) { chkP2_Check = price2; } else { chkP2_Check = null; }
                string price3 = nvc.Get("p3");
                if (price3 != null) { chkP3_Check = price3; } else { chkP3_Check = null; }
                string price4 = nvc.Get("p4");
                if (price4 != null) { chkP4_Check = price2; } else { chkP4_Check = null; }
                string price5 = nvc.Get("p5");
                if (price5 != null) { chkP5_Check = price2; } else { chkP5_Check = null; }
                string price6 = nvc.Get("p6");
                if (price6 != null) { chkP2_Check = price6; } else { chkP6_Check = null; }
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
            if(nvc.HasKeys())
            {
                string col123 = nvc.Get("cl");
                string brandname = nvc.Get("br");
                if (brandname != null)
                {
                    brandSearchCheck = brandname;
                }
                else
                {
                    brandSearchCheck = null;
                }
                if (col123 != null)
                    {
                    
                        string color = "#" + nvc.Get("cl");
                    colorCheck = color;
                        string stylevalue = "background:" + color;
                        colbtn.Attributes.Add("style", stylevalue);
                    }
                else
                {
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
                cmd.CommandText = "SELECT Top "+ rowNum + " BrandID,BrandKey,Name From Tbl_Brands ORDER BY TotalViews DESC";
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
            foreach(int a in _alSelectedPrice)
            {
                switch(a)
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
    [WebMethod,ScriptMethod]
    public static  List<Items> LoadData(int pageIndex)


    {
       try
       {
            int pagesize = 4;
            DatabaseManagement db = new DatabaseManagement();
           string fullQuery = string.Empty;
            string fullQuery2 = string.Empty;
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
               " INNER JOIN dbo.Tbl_Users ON dbo.Tbl_Users.UserID=Tbl_Brands.UserID ";
           
           
           int start = (pageIndex*pagesize)+1;
           int end = ((pageIndex*pagesize) + pagesize);
            var itemList = new List<Items>();
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
               /*string price1 = nvc.Get("p1")*/;
            //string price2 = nvc.Get("p2");
            //string price3 = nvc.Get("p3");
            //string price4 = nvc.Get("p4");
            //string price5 = nvc.Get("p5");
            //string price6 = nvc.Get("p6");
            //string brandid = nvc.Get("b");
            //string brandname = nvc.Get("br");
            List<string> brandlist =new List<string>();

               if (brandCheck != null)
                brandlist = brandCheck.Split(',').ToList();
               //string[] brandarray = brandid.Split(',');
               if (!string.IsNullOrEmpty(categoryCheck))
               {
                   const string categoryJoin = " INNER JOIN Tbl_ItemsCategory ON Tbl_ItemsCategory.ItemID=a.ItemID  ";
                   select = select + categoryJoin;
                   wherecluse = wherecluse + " AND Tbl_ItemsCategory.CategoryID=" + IEUtils.ToInt(categoryCheck);
                wherecluse2 = wherecluse2 + " AND Tbl_ItemsCategory.CategoryID=" + IEUtils.ToInt(categoryCheck);
            }
                   
               if (!string.IsNullOrEmpty(seasonsCheck))
               {
                   const string seasonjoin = " INNER JOIN Tbl_ItemSeasons ON Tbl_ItemSeasons.ItemID=a.ItemID  ";
                   select = select + seasonjoin;
                   wherecluse = wherecluse + " AND Tbl_ItemSeasons.SeasonID=" + IEUtils.ToInt(seasonsCheck);
                wherecluse2 = wherecluse2 + " AND Tbl_ItemSeasons.SeasonID=" + IEUtils.ToInt(seasonsCheck);
            }
                   
               if(!string.IsNullOrEmpty(holidayCheck))
               {
                   const string holidayjoin = " INNER JOIN Tbl_ItemHolidays ON Tbl_ItemHolidays.ItemID=a.ItemID  ";
                   select = select + holidayjoin;
                   wherecluse = wherecluse + " AND Tbl_ItemHolidays.HolidayID=" + IEUtils.ToInt(holidayCheck);
                wherecluse2 = wherecluse2 + " AND Tbl_ItemHolidays.HolidayID=" + IEUtils.ToInt(holidayCheck);
            }

            if (!string.IsNullOrEmpty(colorCheck))
            {
                wherecluse = wherecluse + " AND a.Color=" + IEUtils.SafeSQLString(colorCheck);
                wherecluse2 = wherecluse2 + " AND a.Color=" + IEUtils.SafeSQLString(colorCheck);
            }


            if (!string.IsNullOrEmpty(p1check))
            {
                wherecluse = wherecluse + " AND  (a.RetailPrice>=0 OR a.RetailPrice<=100)  ";
                wherecluse2 = wherecluse2 + " AND  (a.RetailPrice>=0 OR a.RetailPrice<=100)  ";
            }
                 
               if (!string.IsNullOrEmpty(chkP2_Check))
            {
                wherecluse = wherecluse + " AND  (a.RetailPrice>=100 OR a.RetailPrice<=200)  ";
                wherecluse2 = wherecluse2 + " AND  (a.RetailPrice>=100 OR a.RetailPrice<=200)  ";
            }
                   
               if (!string.IsNullOrEmpty(chkP3_Check))
            {
                wherecluse = wherecluse + " AND  (a.RetailPrice>=200 OR a.RetailPrice<=300)  ";
                wherecluse2 = wherecluse2 + " AND  (a.RetailPrice>=200 OR a.RetailPrice<=300)  ";
            }
                  
               if (!string.IsNullOrEmpty(chkP4_Check))
            {
                wherecluse = wherecluse + " AND  (a.RetailPrice>=300 OR a.RetailPrice<=400)  ";
                wherecluse2 = wherecluse2 + " AND  (a.RetailPrice>=300 OR a.RetailPrice<=400)  ";
            }
                  
               if (!string.IsNullOrEmpty(chkP5_Check))
            {
                wherecluse = wherecluse + " AND  (a.RetailPrice>=400 OR a.RetailPrice<=500)  ";
                wherecluse2 = wherecluse2 + " AND  (a.RetailPrice>=400 OR a.RetailPrice<=500)  ";
            }
               
               if (!string.IsNullOrEmpty(chkP6_Check))
            {
                wherecluse = wherecluse + " AND  (a.RetailPrice>=500)  ";
                wherecluse2 = wherecluse2 + " AND  (a.RetailPrice>=500)  ";
            }
      
               if (!string.IsNullOrEmpty(brandCheck))
            {
               
                foreach(var brandId in brandlist)
                {
                    if (!string.IsNullOrEmpty(brandId))
                    {
                        wherecluse = wherecluse + " AND  a.UserID IN(" + brandId + ") ";
                        wherecluse2 = wherecluse2 + " AND  a.UserID IN(" + brandId + ") ";
                    
                    }

                }
             
            }
                   
               if (!string.IsNullOrEmpty(brandSearchCheck))
            {
                wherecluse = wherecluse + " AND dbo.Tbl_Brands.Name LIKE '" + brandSearchCheck + "%' ";
                wherecluse2 = wherecluse2 + " AND dbo.Tbl_Brands.Name LIKE '" + brandSearchCheck + "%' ";
            }
                  
               fullQuery = fullQuery + select + wherecluse + orderBy;
            fullQuery2 = fullQuery2 + select + wherecluse2 + orderBy;
            SqlDataReader dr2 = db.ExecuteReader(fullQuery2);
            int recordCount=0;
            if (dr2.HasRows)
            {
                while(dr2.Read())
                {
                    recordCount += 1;
                }
            }
                
            int pageCount =(int) Math.Ceiling(Convert.ToDecimal(recordCount/pagesize));
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
                       // Likes = LbLikes(IEUtils.ToInt(dr["ItemID"])),
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



    static string categoryCheck = null;
    protected void ByCategory(string categry)
    {
        try
        {
            categoryCheck = categry;
            if (QuerystringExist())
                CheckQuerystringKey("c", categry);
            else
                _pageUrl = _pagename+ "?c=" + categry;
           
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
                    Response.Redirect(_pagename+"?" + Request.QueryString);
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

    static string seasonsCheck = null;
    protected void BySeason(string season)
    {
        try
        {
            seasonsCheck = season;
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
                _pageUrl = _pagename + "?cl=" + color;
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
            holidayCheck = holiday;
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
    static string p1check = null;
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
                if(nvc.Count>0)
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

    static string chkP2_Check = null;
    protected void chkP2_OnCheckedChanged(object sender, EventArgs e)
    {
        try { 
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
        catch(Exception ex) { }
    }
    static string chkP3_Check = null;
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

    static string chkP4_Check = null;
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

    static string chkP5_Check = null;
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
    static string chkP6_Check = null;
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

    static string brandCheck = null;
    protected void chkBrands_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            string brandlist = chkBrands.Items.Cast<ListItem>().Where(itm => itm.Selected).Aggregate(string.Empty, (current, itm) => current + itm.Value + ",");
            brandCheck = brandlist;
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
                PropertyInfo isreadonly = typeof(NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                // make collection editable
                isreadonly.SetValue(this.Request.QueryString, false, null);
                NameValueCollection nvc = Request.QueryString;
                nvc.Remove("b");
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
                string color =e.CommandArgument.ToString();
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