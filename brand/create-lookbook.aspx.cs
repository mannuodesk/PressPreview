
using System;
using System.Collections;
using System.IO;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;
using System.Collections.Generic;


public partial class pr_brand_add_item : System.Web.UI.Page
{
    public string description;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["IsLookbookAdded"] != null)
        {
            if ((bool)Session["IsLookbookAdded"] == true)
            {
                Session["IsLookbookAdded"] = false;
                Response.Redirect("profile-page-lookbooks.aspx", false);
            }
        }
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        txtItemTitle.Focus();
        if (!IsPostBack)
        {

            chkCategories.DataBind();
            chkDefaultSeasons.DataBind();
            chkDefaultHoliday.DataBind();
            #region To check for View More and less Buttons
            //if (Session["AddNewLookbook"] == null)
            //{
                AddNewLookbook addNewLookbook = new AddNewLookbook();
                Session["AddNewLookbook"] = addNewLookbook;
            //}
            DisplayMoreCats();
            DisplayMoreHolidays();
            DisplayMoreSeasons();
            if (chkCategories.Items.Count < 10)
            {
                btn_ViewLess.Visible = btn_ViewMore.Visible = false;
                (Session["AddNewLookbook"] as AddNewLookbook).Category_MoreThanTenCounter = false;
            }
            else
            {
                (Session["AddNewLookbook"] as AddNewLookbook).Category_MoreThanTenCounter = true;
            }
            if (chkDefaultSeasons.Items.Count < 10)
            {
                btn_LessSeasons.Visible = btn_MoreSeasons.Visible = false;
                (Session["AddNewLookbook"] as AddNewLookbook).Season_MoreThanTenCounter = false;
            }
            else
            {
                (Session["AddNewLookbook"] as AddNewLookbook).Season_MoreThanTenCounter = true;
            }
            if (chkDefaultHoliday.Items.Count < 10)
            {
                btn_LessHolidays.Visible = btn_MoreHolidays.Visible = false;
                (Session["AddNewLookbook"] as AddNewLookbook).Holiday_MoreThanTenCounter = false;
            }
            else
            {
                (Session["AddNewLookbook"] as AddNewLookbook).Holiday_MoreThanTenCounter = true;
            }
            #endregion
            DisplayDefaultCats();
            DisplayDefaultSeasons();
            DisplayDefaultHolidays();

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
                Session["AddNewLookbook"] = null;
                Session["IsLookbookAdded"] = false;
        if (Session["AddNewLookbook"] != null)
        
        {
            if((Session["AddNewLookbook"] as AddNewLookbook).SelectedCategories!=null)
            {
                if((Session["AddNewLookbook"] as AddNewLookbook).SelectedCategories.Count>0)
                {
                    CategorySelected.Value = "true";
                }
            }
            if ((Session["AddNewLookbook"] as AddNewLookbook).SelectedSeasons != null)
            {
                if ((Session["AddNewLookbook"] as AddNewLookbook).SelectedSeasons.Count > 0)
                {
                    SeasonSelected.Value = "true";
                }
            }
        }
        //  dvTagToggles.Visible = rptTags.Items.Count > 0;
        dvSeasonToggle.Visible = chkDefaultSeasons.Items.Count >= 4;
        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);

    }
    protected void spelcheck_OnLoad(object sender, EventArgs e)
    {
        // spelcheck.Visible = false;
    }

    [WebMethod, ScriptMethod]
    public static void RemoveFeatureImage(string filename)
    {
        var db = new DatabaseManagement();
        var httpCookie = HttpContext.Current.Request.Cookies["CurrentLookId"];
        if (httpCookie != null)
        {
            string deleteQuery = string.Format("Update Tbl_Lookbooks Set MainImg=NULL  Where  LookID={0}",
                                               IEUtils.ToInt(httpCookie.Value));
            db.ExecuteSQL(deleteQuery);
        }

        db._sqlConnection.Close();
        db._sqlConnection.Dispose();

    }


    protected void btnPreview_OnServerClick(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
            var httpCookie = HttpContext.Current.Request.Cookies["CurrentLookId"];
            if (httpCookie != null)
            {
                var userCookie = Request.Cookies["FrUserID"];
                string lookKey = Encryption64.Encrypt(httpCookie.Value).Replace('+', '=');
                if (userCookie != null)
                {
                    string updateQuery = string.Format("UPDATE Tbl_Lookbooks Set LookKey={0}," +
                                                       "Title={1},Description={2}," +
                                                       " UserID={3},DatePosted={4} " +
                        //"Category={5}," +
                        //"Season={6}," +
                        //"Holiday={7} " +
                                                       " WHERE LookID={5} ",
                                                       IEUtils.SafeSQLString(lookKey),
                                                       IEUtils.SafeSQLString(txtItemTitle.Value),
                                                       IEUtils.SafeSQLString(Server.HtmlEncode(txtDescription.Text)),
                                                       IEUtils.ToInt(userCookie.Value),
                                                       "'" + DateTime.UtcNow + "'",
                        //IEUtils.SafeSQLString(chkCategories.SelectedItem.Text),
                        //        IEUtils.SafeSQLString(chkDefaultSeasons.SelectedItem.Text),
                        //        IEUtils.SafeSQLString(chkDefaultHoliday.SelectedItem.Text),
                                                       IEUtils.ToInt(httpCookie.Value));

                    db.ExecuteSQL(updateQuery);
                }
                foreach (RepeaterItem repItem in rptLookbook.Items)
                {
                    var chkItemID = (CheckBox)repItem.FindControl("chkItemID");

                    if (chkItemID.Checked)
                    {
                        var lblSelectedItem = (Label)repItem.FindControl("SelectedItem");
                        string addLookbookItems = string.Format("INSERT INTO Tbl_LbItems(ItemID,LookID) VALUES({0},{1})", IEUtils.ToInt(lblSelectedItem.Text), IEUtils.ToInt(httpCookie.Value));
                        db.ExecuteSQL(addLookbookItems);
                    }
                }
            }

            foreach (ListItem lstCategory in chkCategories.Items)
            {
                if (!lstCategory.Selected) continue;
                if (httpCookie != null)
                {
                    string addLbCategory = string.Format("INSERT INTO Tbl_LbCategory(CategoryID,LookID) VALUES({0},{1})", IEUtils.ToInt(lstCategory.Value), IEUtils.ToInt(httpCookie.Value));
                    db.ExecuteSQL(addLbCategory);
                }
            }

            // Add Seasons

            foreach (ListItem lstSeason in chkDefaultSeasons.Items)
            {
                if (!lstSeason.Selected) continue;
                if (httpCookie != null)
                {
                    string addLbSeason = string.Format("INSERT INTO Tbl_LbSeasons(SeasonID,LookID) VALUES({0},{1})", IEUtils.ToInt(lstSeason.Value), IEUtils.ToInt(httpCookie.Value));
                    db.ExecuteSQL(addLbSeason);
                }
            }

            // Add Holidays

            foreach (ListItem lstHoliday in chkDefaultHoliday.Items)
            {
                if (lstHoliday.Selected)
                {
                    if (httpCookie != null)
                    {
                        string addLbHolidays = string.Format("INSERT INTO Tbl_LbHolidays(HolidayID,LookID) VALUES({0},{1})", IEUtils.ToInt(lstHoliday.Value), IEUtils.ToInt(httpCookie.Value));
                        db.ExecuteSQL(addLbHolidays);
                    }
                }
            }

            if (httpCookie != null)
            {
                string url = "../lightbox/brand-item-view?v=" + httpCookie.Value;
                string s = "window.open('" + url + "', 'popup_window', 'width=1150,height=700,left=100,resizable=no,toolbar=no,scrollbars=yes,menubar=no,location=no,');";
                ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
            }

            // if (httpCookie != null) Response.Redirect("../lightbox/brand-item-view?v=" + httpCookie.Value);
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    [WebMethod, ScriptMethod]
    public static void SaveItem(string TitleText, string DescriptionTextDetails)
    {
        try
        {
            var db = new DatabaseManagement();
            var httpCookie = HttpContext.Current.Request.Cookies["CurrentLookId"];
            if (httpCookie != null)
            {
                string mainimg = db.GetExecuteScalar("SELECT MainImg From Tbl_Lookbooks Where LookID=" + IEUtils.ToInt(httpCookie.Value));
                if (string.IsNullOrEmpty(mainimg))
                {
                    //ErrorMessage.ShowErrorAlert(lblStatus, "Please upload Lookbook's feature image.", divAlerts);
                }
                else
                {
                    var userCookie = HttpContext.Current.Request.Cookies["FrUserID"];
                    if (userCookie != null)
                    {
                        string lookKey = Encryption64.Encrypt(httpCookie.Value).Replace('+', '=');
                        string updateQuery = string.Format("UPDATE Tbl_Lookbooks Set LookKey={0}," +
                                                                "Title={1},Description={2}," +
                                                                "IsPublished={3}, UserID={4},DatePosted={5} " +
                            //"Category={6}," +
                            //"Season={7}," +
                            //"Holiday={8} " +
                                                           "WHERE LookID={6} ",
                                                                IEUtils.SafeSQLString(lookKey),
                                                                IEUtils.SafeSQLString(TitleText),
                                                                IEUtils.SafeSQLString(DescriptionTextDetails),
                                                                1,
                                                                IEUtils.ToInt(userCookie.Value),
                                                                "'" + DateTime.UtcNow + "'",
                            //IEUtils.SafeSQLString(chkCategories.SelectedItem.Text),
                            //IEUtils.SafeSQLString(chkDefaultSeasons.SelectedItem.Text),
                            //IEUtils.SafeSQLString(chkDefaultHoliday.SelectedItem.Text),
                                                                IEUtils.ToInt(httpCookie.Value));

                        db.ExecuteSQL(updateQuery);

                        if (HttpContext.Current.Session["AddNewLookbook"] != null)
                        {
                            if ((HttpContext.Current.Session["AddNewLookbook"] as AddNewLookbook).ItemIds != null)
                            {
                                foreach (int itemID in (HttpContext.Current.Session["AddNewLookbook"] as AddNewLookbook).ItemIds)
                                {
                                    string addLookbookItems = string.Format("INSERT INTO Tbl_LbItems(ItemID,LookID) VALUES({0},{1})", IEUtils.ToInt(itemID), IEUtils.ToInt(httpCookie.Value));
                                    db.ExecuteSQL(addLookbookItems);
                                }
                            }
                        }

                        if (HttpContext.Current.Session["AddNewLookbook"] != null)
                        {
                            if ((HttpContext.Current.Session["AddNewLookbook"] as AddNewLookbook).SelectedCategories != null)
                            {
                                foreach (int categoryID in (HttpContext.Current.Session["AddNewLookbook"] as AddNewLookbook).SelectedCategories)
                                {
                                    string addItemCategory = string.Format("INSERT INTO Tbl_LbCategory(CategoryID,LookID) VALUES({0},{1})", IEUtils.ToInt(categoryID), IEUtils.ToInt(httpCookie.Value));
                                    db.ExecuteSQL(addItemCategory);
                                }
                            }
                        }

                        // Add Seasons

                        if (HttpContext.Current.Session["AddNewLookbook"] != null)
                        {
                            if ((HttpContext.Current.Session["AddNewLookbook"] as AddNewLookbook).SelectedSeasons != null)
                            {
                                foreach (int seasonID in (HttpContext.Current.Session["AddNewLookbook"] as AddNewLookbook).SelectedSeasons)
                                {
                                    string addItemSeason = string.Format("INSERT INTO Tbl_LbSeasons(SeasonID,LookID) VALUES({0},{1})", IEUtils.ToInt(seasonID), IEUtils.ToInt(httpCookie.Value));
                                    db.ExecuteSQL(addItemSeason);
                                }
                            }
                        }

                        // Add Holidays

                        if (HttpContext.Current.Session["AddNewLookbook"] != null)
                        {
                            if ((HttpContext.Current.Session["AddNewLookbook"] as AddNewLookbook).SelectedHolidays != null)
                            {
                                foreach (int holidayID in (HttpContext.Current.Session["AddNewLookbook"] as AddNewLookbook).SelectedHolidays)
                                {
                                    string addItemoreHolidays = string.Format("INSERT INTO Tbl_LbHolidays(HolidayID,LookID) VALUES({0},{1})", IEUtils.ToInt(holidayID), IEUtils.ToInt(httpCookie.Value));
                                    db.ExecuteSQL(addItemoreHolidays);
                                }
                            }
                        }

                        const string cookieName = "CurrentLookId";
                        if (HttpContext.Current.Request.Cookies[cookieName] != null)
                        {
                            var myCookie = new HttpCookie(cookieName) { Expires = DateTime.Now.AddDays(-1d) };
                            HttpContext.Current.Response.Cookies.Add(myCookie);
                        }
                        //  rptTags.DataBind();
                        HttpContext.Current.Session["AddNewLookbook"] = null;
                        HttpContext.Current.Session["IsLookbookAdded"] = true;
                        db.CloseConnection();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    
    protected void btnPublish_OnServerClick(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
            var httpCookie = HttpContext.Current.Request.Cookies["CurrentLookId"];
            if (httpCookie != null)
            {
                string mainimg = db.GetExecuteScalar("SELECT MainImg From Tbl_Lookbooks Where LookID=" + IEUtils.ToInt(httpCookie.Value));
                if (string.IsNullOrEmpty(mainimg))
                {
                    ErrorMessage.ShowErrorAlert(lblStatus, "Please upload Lookbook's feature image.", divAlerts);
                }
                else
                {
                    var userCookie = HttpContext.Current.Request.Cookies["FrUserID"];
                    if (userCookie != null)
                    {
                        {
                            string lookKey = Encryption64.Encrypt(httpCookie.Value).Replace('+', '=');
                            string updateQuery = string.Format("UPDATE Tbl_Lookbooks Set LookKey={0}," +
                                                                    "Title={1},Description={2}," +
                                                                    "IsPublished={3}, UserID={4},DatePosted={5} " +
                                //"Category={6}," +
                                //"Season={7}," +
                                //"Holiday={8} " +
                                                               "WHERE LookID={6} ",
                                                                    IEUtils.SafeSQLString(lookKey),
                                                                    IEUtils.SafeSQLString(txtItemTitle.Value),
                                                                    IEUtils.SafeSQLString(Server.HtmlEncode(txtDescription.Text)),
                                                                    1,
                                                                    IEUtils.ToInt(userCookie.Value),
                                                                    "'" + DateTime.UtcNow + "'",
                                //IEUtils.SafeSQLString(chkCategories.SelectedItem.Text),
                                //IEUtils.SafeSQLString(chkDefaultSeasons.SelectedItem.Text),
                                //IEUtils.SafeSQLString(chkDefaultHoliday.SelectedItem.Text),
                                                                    IEUtils.ToInt(httpCookie.Value));

                            db.ExecuteSQL(updateQuery);
                            foreach (RepeaterItem repItem in rptLookbook.Items)
                            {
                                var chkItemID = (CheckBox)repItem.FindControl("chkItemID");

                                if (chkItemID.Checked)
                                {
                                    var lblSelectedItem = (Label)repItem.FindControl("SelectedItem");
                                    string addLookbookItems = string.Format("INSERT INTO Tbl_LbItems(ItemID,LookID) VALUES({0},{1})", IEUtils.ToInt(lblSelectedItem.Text), IEUtils.ToInt(httpCookie.Value));
                                    db.ExecuteSQL(addLookbookItems);
                                }
                            }
                        }

                        foreach (ListItem lstCategory in chkCategories.Items)
                        {
                            if (!lstCategory.Selected) continue;
                            {
                                string addItemCategory = string.Format("INSERT INTO Tbl_LbCategory(CategoryID,LookID) VALUES({0},{1})", IEUtils.ToInt(lstCategory.Value), IEUtils.ToInt(httpCookie.Value));
                                db.ExecuteSQL(addItemCategory);
                            }
                        }

                        // Add Seasons

                        foreach (ListItem lstSeason in chkDefaultSeasons.Items)
                        {
                            if (!lstSeason.Selected) continue;
                            string addItemSeason = string.Format("INSERT INTO Tbl_LbSeasons(SeasonID,LookID) VALUES({0},{1})", IEUtils.ToInt(lstSeason.Value), IEUtils.ToInt(httpCookie.Value));
                            db.ExecuteSQL(addItemSeason);
                        }

                        // Add Holidays

                        foreach (ListItem lstHoliday in chkDefaultHoliday.Items)
                        {
                            if (lstHoliday.Selected)
                            {
                                {
                                    string addItemoreHolidays = string.Format("INSERT INTO Tbl_LbHolidays(HolidayID,LookID) VALUES({0},{1})", IEUtils.ToInt(lstHoliday.Value), IEUtils.ToInt(httpCookie.Value));
                                    db.ExecuteSQL(addItemoreHolidays);
                                }
                            }
                        }
                        txtDescription.Text = "";
                        ClearCategories();
                        ClearHolidays();
                        ClearSeasons();
                        ErrorMessage.ShowSuccessAlert(lblStatus, "Lookbook created successfully", divAlerts);
                        Common.EmptyTextBoxes(this);
                        const string cookieName = "CurrentLookId";
                        if (Request.Cookies[cookieName] != null)
                        {
                            var myCookie = new HttpCookie(cookieName) { Expires = DateTime.Now.AddDays(-1d) };
                            Response.Cookies.Add(myCookie);
                        }
                        //  rptTags.DataBind();
                        Session["AddNewLookbook"] = null;
                        rptLookbook.DataBind();
                        db._sqlConnection.Close();
                        db._sqlConnection.Dispose();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void ClearCategories()
    {
        foreach (ListItem lst in chkCategories.Items)
        {
            lst.Selected = false;
        }
    }
    protected void ClearSeasons()
    {
        foreach (ListItem lst in chkDefaultSeasons.Items)
        {
            lst.Selected = false;
        }
    }

    protected void ClearHolidays()
    {
        foreach (ListItem lst in chkDefaultHoliday.Items)
        {
            lst.Selected = false;
        }
    }
    //protected void btnAddTag_OnServerClick(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        var db=new DatabaseManagement();
    //        int lookID;
    //        var httpCookie = HttpContext.Current.Request.Cookies["CurrentLookId"];
    //        if (httpCookie != null && !string.IsNullOrEmpty(httpCookie.Value))
    //        {
    //            lookID = Convert.ToInt32(httpCookie.Value);
    //        }
    //        else
    //        {
    //            string insertEvent =
    //           string.Format(
    //               "INSERT INTO Tbl_Lookbooks(DatePosted) VALUES({0})",
    //               IEUtils.SafeSQLDate(DateTime.Now)
    //               );
    //            db.ExecuteSQL(insertEvent);
    //            lookID = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(LookID) From Tbl_Lookbooks"));
    //            var currItem = new HttpCookie("CurrentLookId") { Value = lookID.ToString() };
    //            Response.Cookies.Add(currItem);
    //           // HttpContext.Current.Response.Cookies["CurrentItemId"].Value = itemId.ToString();
    //        }
    //        string[] multipletags = txtTag.Value.Split(',');
    //        foreach (string t in multipletags)
    //        {
    //            string addNewTag = string.Format("INSERT INTO Tbl_LbTags(LookID,Title) VALUES({0},{1})",
    //                                             lookID,
    //                                             IEUtils.SafeSQLString(t));
    //            db.ExecuteSQL(addNewTag);
    //        }

    //        txtTag.Value = "";
    //        rptTags.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
    //    }
    //}


    protected void btn_ViewMore_Click(object sender, EventArgs e)
    {
        try
        {
            DisplayMoreCats();
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
            DisplayDefaultCats();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }

    }

    private void DisplayMoreCats()
    {
        /*for (int i = 40; i > 19; i--)
        {
            if (chkCategories.Items.Count > i) chkCategories.Items[i].Attributes.Add("style", "display:block;");
        }*/
        chkCategories.DataSourceID = "";
        chkCategories.DataSource = sdsMoreCats;
        chkCategories.DataBind();
        LoadSelectedCategories();
        btn_ViewMore.Visible = false;
        btn_ViewLess.Visible = true;
    }

    private void DisplayDefaultCats()
    {
        /*for (int i = 40; i > 19; i--)
        {
            if (chkCategories.Items.Count > i) chkCategories.Items[i].Attributes.Add("style", "display:none;");
        }*/
        chkCategories.DataSourceID = "";
        chkCategories.DataSource = sdsDefaultCats;
        chkCategories.DataBind();
        LoadSelectedCategories();
        if ((Session["AddNewLookbook"] as AddNewLookbook).Category_MoreThanTenCounter)
        {
            btn_ViewMore.Visible = true;
            btn_ViewLess.Visible = false;
        }
    }


    //protected void btn_MoreTags_Click(object sender, EventArgs e)
    //{
    //    rptTags.DataSourceID = "";
    //    rptTags.DataSource = sdsMoreTags;
    //    rptTags.DataBind();
    //    btn_MoreTags.Visible = false;
    //    btn_LessTags.Visible = true;
    //}
    //protected void btn_LessTags_Click(object sender, EventArgs e)
    //{
    //    rptTags.DataSourceID = "";
    //    rptTags.DataSource = sdsTags;
    //    rptTags.DataBind();
    //    btn_MoreTags.Visible = true;
    //    btn_LessTags.Visible = false;
    //}
    private void DisplayMoreSeasons()
    {
        /*for (int i = 8; i > 5; i--)
        {
            if (chkDefaultSeasons.Items.Count > i) chkDefaultSeasons.Items[i].Attributes.Add("style", "display:block;");
        }*/
        chkDefaultSeasons.DataSourceID = "";
        chkDefaultSeasons.DataSource = sdsMoreSeasons;
        chkDefaultSeasons.DataBind();
        LoadSelectedSeasons();
        btn_MoreSeasons.Visible = false;
        btn_LessSeasons.Visible = true;
    }
    protected void btn_MoreSeasons_Click(object sender, EventArgs e)
    {
        DisplayMoreSeasons();
    }
    private void DisplayDefaultSeasons()
    {
        /*for (int i = 8; i > 5; i--)
        {
            if (chkDefaultSeasons.Items.Count > i) chkDefaultSeasons.Items[i].Attributes.Add("style", "display:none;");
        }*/
        chkDefaultSeasons.DataSourceID = "";
        chkDefaultSeasons.DataSource = sdsDefaultSeasons;
        chkDefaultSeasons.DataBind();
        LoadSelectedSeasons();
        if ((Session["AddNewLookbook"] != null))
        {
            if ((Session["AddNewLookbook"] as AddNewLookbook).Season_MoreThanTenCounter)
            {
                btn_MoreSeasons.Visible = true;
                btn_LessSeasons.Visible = false;
            }
        }
    }
    protected void btn_LessSeasons_Click(object sender, EventArgs e)
    {
        DisplayDefaultSeasons();
    }
    private void DisplayMoreHolidays()
    {
        /*for (int i = 8; i > 5; i--)
        {
            if (chkDefaultHoliday.Items != null)
                if (chkDefaultHoliday.Items.Count > i) chkDefaultHoliday.Items[i].Attributes.Add("style", "display:block;");
        }*/
        chkDefaultHoliday.DataSourceID = "";
        chkDefaultHoliday.DataSource = sdsMoreHoliday;
        chkDefaultHoliday.DataBind();
        LoadSelectedHolidays();
        btn_MoreHolidays.Visible = false;
        btn_LessHolidays.Visible = true;
    }
    protected void btn_MoreHolidays_Click(object sender, EventArgs e)
    {
        DisplayMoreHolidays();
    }

    private void DisplayDefaultHolidays()
    {
        /*for (int i = 8; i > 5; i--)
        {
            if (chkDefaultHoliday.Items.Count > i) chkDefaultHoliday.Items[i].Attributes.Add("style", "display:none;");
        }*/
        chkDefaultHoliday.DataSourceID = "";
        chkDefaultHoliday.DataSource = sdsDefaultHoliday;
        chkDefaultHoliday.DataBind();
        LoadSelectedHolidays();
        if ((Session["AddNewLookbook"] != null))
        {
            if ((Session["AddNewLookbook"] as AddNewLookbook).Holiday_MoreThanTenCounter)
            {
                btn_LessHolidays.Visible = false;
                btn_MoreHolidays.Visible = true;
            }
        }
    }
    protected void btn_LessHolidays_Click(object sender, EventArgs e)
    {
        DisplayDefaultHolidays();
    }
    protected void lbtnDelete_Click(object sender, EventArgs e)
    {
        try
        {

            var httpCookie = HttpContext.Current.Request.Cookies["CurrentLookId"];
            if (httpCookie != null && !string.IsNullOrEmpty(httpCookie.Value))
            {
                var db = new DatabaseManagement();
                string deleteItem = String.Format("Delete FROM Tbl_Lookbooks Where LookID={0}",
                                                  IEUtils.ToInt(httpCookie.Value));
                db.ExecuteSQL(deleteItem);
                ErrorMessage.ShowSuccessAlert(lblStatus, "Lookbook record deleted.", divAlerts);
            }
            else
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "No Lookbook record found to delete", divAlerts);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }


    protected void rptLookbook_ItemDataBound(object sender, RepeaterItemEventArgs e)
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

    private void LoadSelectedCategories()
    {
        foreach (ListItem itm in chkCategories.Items)
        {
            //if (catlst.Contains(IEUtils.ToInt(itm.Value)))
            if (Session["AddNewLookbook"] != null)
            {
                if ((Session["AddNewLookbook"] as AddNewLookbook).SelectedCategories != null)
                {
                    if ((Session["AddNewLookbook"] as AddNewLookbook).SelectedCategories.Contains(int.Parse(itm.Value)))
                    {
                        itm.Selected = true;
                    }
                }
            }
        }
    }

    private void LoadSelectedSeasons()
    {
        foreach (ListItem itm in chkDefaultSeasons.Items)
        {
            //if (catlst.Contains(IEUtils.ToInt(itm.Value)))
            if (Session["AddNewLookbook"] != null)
            {
                if ((Session["AddNewLookbook"] as AddNewLookbook).SelectedSeasons != null)
                {
                    if ((Session["AddNewLookbook"] as AddNewLookbook).SelectedSeasons.Contains(int.Parse(itm.Value)))
                    {
                        itm.Selected = true;
                    }
                }
            }
        }
    }

    private void LoadSelectedHolidays()
    {
        foreach (ListItem itm in chkDefaultHoliday.Items)
        {
            //if (catlst.Contains(IEUtils.ToInt(itm.Value)))
            if (Session["AddNewLookbook"] != null)
            {
                if ((Session["AddNewLookbook"] as AddNewLookbook).SelectedHolidays != null)
                {
                    if ((Session["AddNewLookbook"] as AddNewLookbook).SelectedHolidays.Contains(int.Parse(itm.Value)))
                    {
                        itm.Selected = true;
                    }
                }
            }
        }
    }



    protected void chkCategories_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Session["AddNewLookbook"] == null)
        {
            AddNewLookbook addNewLookbook = new AddNewLookbook();
            Session["AddNewLookbook"] = addNewLookbook;
        }

        (Session["AddNewLookbook"] as AddNewLookbook).SelectedCategories = new List<int>();
        //selectedCategories = new List<int>();
        for (int i = 0; i < chkCategories.Items.Count; i++)
        {
            if (chkCategories.Items[i].Selected)
            {
                //selectedCategories.Add(Convert.ToInt32(chkCategories.Items[i].Value));
                (Session["AddNewLookbook"] as AddNewLookbook).SelectedCategories.Add(Convert.ToInt32(chkCategories.Items[i].Value));
            }

        }
        if((Session["AddNewLookbook"] as AddNewLookbook).SelectedCategories.Count>0)
        {
            CategorySelected.Value = "true";
        }
    }

    protected void chkDefaultSeasons_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Session["AddNewLookbook"] == null)
        {
            AddNewLookbook addNewLookbook = new AddNewLookbook();
            Session["AddNewLookbook"] = addNewLookbook;
        }

        (Session["AddNewLookbook"] as AddNewLookbook).SelectedSeasons = new List<int>();
        //selectedCategories = new List<int>();
        for (int i = 0; i < chkDefaultSeasons.Items.Count; i++)
        {
            if (chkDefaultSeasons.Items[i].Selected)
            {
                //selectedCategories.Add(Convert.ToInt32(chkCategories.Items[i].Value));
                (Session["AddNewLookbook"] as AddNewLookbook).SelectedSeasons.Add(Convert.ToInt32(chkDefaultSeasons.Items[i].Value));
            }

        }
        if ((Session["AddNewLookbook"] as AddNewLookbook).SelectedSeasons.Count > 0)
        {
            SeasonSelected.Value = "true";
        }
    }
    protected void chkDefaultHoliday_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Session["AddNewLookbook"] == null)
        {
            AddNewLookbook addNewLookbook = new AddNewLookbook();
            Session["AddNewLookbook"] = addNewLookbook;
        }

        (Session["AddNewLookbook"] as AddNewLookbook).SelectedHolidays = new List<int>();
        //selectedCategories = new List<int>();
        for (int i = 0; i < chkDefaultHoliday.Items.Count; i++)
        {
            if (chkDefaultHoliday.Items[i].Selected)
            {
                //selectedCategories.Add(Convert.ToInt32(chkCategories.Items[i].Value));
                (Session["AddNewLookbook"] as AddNewLookbook).SelectedHolidays.Add(Convert.ToInt32(chkDefaultHoliday.Items[i].Value));
            }

        }
    }


    protected void chkItemID_CheckedChanged(object sender, EventArgs e)
    {
        if (Session["AddNewLookbook"] != null)
        {
            (Session["AddNewLookbook"] as AddNewLookbook).ItemIds = new List<int>();
            foreach (RepeaterItem repItem in rptLookbook.Items)
            {
                var chkItemID = (CheckBox)repItem.FindControl("chkItemID");
                var lblSelectedItem = (Label)repItem.FindControl("SelectedItem");
                if (chkItemID.Checked)
                {
                    if (!(Session["AddNewLookbook"] as AddNewLookbook).ItemIds.Contains(int.Parse(lblSelectedItem.Text)))
                    {
                        (Session["AddNewLookbook"] as AddNewLookbook).ItemIds.Add(int.Parse(lblSelectedItem.Text));
                    }
                }
            }
        }
    }
}
