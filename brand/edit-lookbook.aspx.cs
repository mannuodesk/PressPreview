﻿
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;


public partial class pr_brand_add_item : System.Web.UI.Page
{
    List<int> itemslst = new List<int>();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["IsLookbookSaved"] != null)
        {
            if ((bool)Session["IsLookbookSaved"] == true)
            {
                Session["IsLookbookSaved"] = false;
                Response.Redirect("profile-page-lookbooks.aspx", false);
            }
        }
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        if (!IsPostBack)
        {

            chkCategories.DataBind();
            chkDefaultSeasons.DataBind();
            chkDefaultHoliday.DataBind();
            #region To check for View More and less Buttons
            //if (Session["EditLookbookDetailsData"] == null)
            //{
                EditLookbookDetailsData editLookbookDetailsData = new EditLookbookDetailsData();
                Session["EditLookbookDetailsData"] = editLookbookDetailsData;
            //}
            DisplayMoreCats();
            DisplayMoreHolidays();
            DisplayMoreSeasons();
            if (chkCategories.Items.Count < 10)
            {
                btn_ViewLess.Visible = btn_ViewMore.Visible = false;
                (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).Category_MoreThanTenCounter = false;
            }
            else
            {
                (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).Category_MoreThanTenCounter = true;
            }
            if (chkDefaultSeasons.Items.Count < 10)
            {
                btn_LessSeasons.Visible = btn_MoreSeasons.Visible = false;
                (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).Season_MoreThanTenCounter = false;
            }
            else
            {
                (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).Season_MoreThanTenCounter = true;
            }
            if (chkDefaultHoliday.Items.Count < 10)
            {
                btn_LessHolidays.Visible = btn_MoreHolidays.Visible = false;
                (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).Holiday_MoreThanTenCounter = false;
            }
            else
            {
                (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).Holiday_MoreThanTenCounter = true;
            }
            #endregion
            DisplayDefaultCats();
            DisplayDefaultSeasons();
            DisplayDefaultHolidays();
            LoadLookbook();
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
                    Session["EditLookbookDetailsData"] = null;
                    Session["IsLookbookSaved"] = false;
        if (Session["EditLookbookDetailsData"] != null)
        {
            if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedCategories != null)
            {
                if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedCategories.Count > 0)
                {
                    CategorySelected.Value = "true";
                }
            }
            if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedSeasons != null)
            {
                if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedSeasons.Count > 0)
                {
                    SeasonSelected.Value = "true";
                }
            }
        }
        //dvTagToggles.Visible = rptTags.Items.Count > 0;
        dvSeasonToggle.Visible = chkDefaultSeasons.Items.Count >= 4;
        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);

    }
    protected void LoadLookbook()
    {
        try
        {
            var db = new DatabaseManagement();
            string selectRec =
                string.Format(
                    "SELECT LookKey,Title,Description,MainImg, Category,Season,Holiday From Tbl_Lookbooks Where LookID={0}",
                    IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(selectRec);
            if (dr.HasRows)
            {
                dr.Read();
                txtItemTitle.Value = dr[1].ToString();
                txtDescription.Text = dr[2].ToString();
                imgFeatured.ImageUrl = "../photobank/" + dr[3];
                //chkCategories.Items.FindByText(dr[4].ToString()).Selected = true;
                //chkDefaultSeasons.Items.FindByText(dr[5].ToString()).Selected = true;
                //chkDefaultHoliday.Items.FindByText(dr[6].ToString()).Selected = true;

            }
            dr.Close();

            string getLookbookItems =
                string.Format(
                    "SELECT Tbl_LbItems.ItemID From Tbl_LbItems INNER JOIN Tbl_Items ON Tbl_LbItems.ItemID=Tbl_Items.ItemID Where IsDeleted IS NULL AND IsPublished=1 AND Tbl_LbItems.LookID={0}",
                    IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr2 = db.ExecuteReader(getLookbookItems);
            if (dr2.HasRows)
            {
                while (dr2.Read())
                {
                    itemslst.Add(IEUtils.ToInt(dr2[0]));
                }
            }

            if (Session["EditLookbookDetailsData"] == null)
            {
                EditLookbookDetailsData editLookbookDetailsData = new EditLookbookDetailsData();
                Session["EditLookbookDetailsData"] = editLookbookDetailsData;
            }
            if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedItems == null)
            {
                (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedItems = new List<int>();
            }
            foreach (int itemID in itemslst)
            {
                if (!(Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedItems.Contains(itemID))
                {
                    (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedItems.Add(itemID);
                }
            }

            dr2.Close();
            //foreach (RepeaterItem repItem in rptLookbook.Items)
            //{
            //    var chkItemID = (CheckBox)repItem.FindControl("chkItemID");
            //    int itemId =IEUtils.ToInt(((Label)repItem.FindControl("SelectedItem")).Text);
            //    if (itemslst.Contains(itemId))
            //        chkItemID.Checked = true;
            //}

            LoadCategories(db);
            LoadSeason(db);
            LoadHolidays(db);

            dr.Close();
            dr.Dispose();
            db.CloseConnection();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    private void LoadCategories(DatabaseManagement db)
    {
        string getcategories = string.Format("SELECT CategoryID From Tbl_LbCategory Where LookID={0}",
                                             IEUtils.ToInt(Request.QueryString["v"]));
        List<int> catlst = new List<int>();
        SqlDataReader dr2 = db.ExecuteReader(getcategories);
        if (dr2.HasRows)
        {
            while (dr2.Read())
            {
                catlst.Add(IEUtils.ToInt(dr2[0]));
            }
        }
        dr2.Close();
        dr2.Dispose();

        foreach (ListItem itm in chkCategories.Items)
        {
            if (catlst.Contains(IEUtils.ToInt(itm.Value)))
            {
                if (Session["EditLookbookDetailsData"] == null)
                {
                    EditLookbookDetailsData editLookbookDetailsData = new EditLookbookDetailsData();
                    Session["EditLookbookDetailsData"] = editLookbookDetailsData;
                }
                if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedCategories == null)
                {
                    (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedCategories = new List<int>();
                }
                if (!(Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedCategories.Contains(int.Parse(itm.Value)))
                {
                    (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedCategories.Add(int.Parse(itm.Value));
                }
                itm.Selected = true;
            }
        }
    }

    private void LoadSeason(DatabaseManagement db)
    {
        string get = string.Format("SELECT SeasonID From Tbl_LbSeasons Where LookID={0}",
                                             IEUtils.ToInt(Request.QueryString["v"]));
        List<int> lst = new List<int>();
        SqlDataReader dr2 = db.ExecuteReader(get);
        if (dr2.HasRows)
        {
            while (dr2.Read())
            {
                lst.Add(IEUtils.ToInt(dr2[0]));
            }
        }
        dr2.Close();
        dr2.Dispose();

        foreach (ListItem itm in chkDefaultSeasons.Items)
        {
            if (lst.Contains(IEUtils.ToInt(itm.Value)))
            {
                if (Session["EditLookbookDetailsData"] == null)
                {
                    EditLookbookDetailsData editLookbookDetailsData = new EditLookbookDetailsData();
                    Session["EditLookbookDetailsData"] = editLookbookDetailsData;
                }
                if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedSeasons == null)
                {
                    (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedSeasons = new List<int>();
                }
                if (!(Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedSeasons.Contains(int.Parse(itm.Value)))
                {
                    (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedSeasons.Add(int.Parse(itm.Value));
                }
                if (lst.Contains(IEUtils.ToInt(itm.Value)))
                {
                    itm.Selected = true;
                }
            }
        }
    }

    private void LoadHolidays(DatabaseManagement db)
    {
        string get = string.Format("SELECT HolidayID From Tbl_LbHolidays Where LookID={0}",
                                             IEUtils.ToInt(Request.QueryString["v"]));
        List<int> lst = new List<int>();
        SqlDataReader dr2 = db.ExecuteReader(get);
        if (dr2.HasRows)
        {
            while (dr2.Read())
            {
                lst.Add(IEUtils.ToInt(dr2[0]));
            }
        }
        dr2.Close();
        dr2.Dispose();

        foreach (ListItem itm in chkDefaultHoliday.Items)
        {
            if (lst.Contains(IEUtils.ToInt(itm.Value)))
            {
                if (Session["EditLookbookDetailsData"] == null)
                {
                    EditLookbookDetailsData editLookbookDetailsData = new EditLookbookDetailsData();
                    Session["EditLookbookDetailsData"] = editLookbookDetailsData;
                }
                if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedHolidays == null)
                {
                    (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedHolidays = new List<int>();
                }
                if (!(Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedHolidays.Contains(int.Parse(itm.Value)))
                {
                    (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedHolidays.Add(int.Parse(itm.Value));
                }
                if (lst.Contains(IEUtils.ToInt(itm.Value)))
                {
                    itm.Selected = true;
                }
            }
        }
    }

    protected void btnRemove_Click(object sender, EventArgs e)
    {
        try
        {
            DatabaseManagement db = new DatabaseManagement();
            string RemoveFeatureImg = string.Format("Update Tbl_Lookbooks Set MainImg=NULL Where LookID={0}",
                                                    IEUtils.ToInt(Request.QueryString["v"]));
            db.ExecuteSQL(RemoveFeatureImg);
            imgFeatured.ImageUrl = string.Empty;
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void spelcheck_OnLoad(object sender, EventArgs e)
    {
        // spelcheck.Visible = false;
    }

    [WebMethod, ScriptMethod]
    public static void RemoveFeatureImage(string filename)
    {
        var db = new DatabaseManagement();

        string deleteQuery = string.Format("Update Tbl_Lookbooks Set MainImg=NULL  Where  LookID={0}",
                                           IEUtils.ToInt(HttpContext.Current.Request.QueryString["v"]));
        db.ExecuteSQL(deleteQuery);

        db._sqlConnection.Close();
        db._sqlConnection.Dispose();

    }

    //protected void btnPreview_OnServerClick(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        var db = new DatabaseManagement();

    //            var userCookie = Request.Cookies["FrUserID"];

    //            if (userCookie != null)
    //            {
    //                string updateQuery = string.Format("UPDATE Tbl_Lookbooks Set  " +
    //                                                   "Title={0},Description={1}," +
    //                                                   " UserID={2},DatePosted={3},Category={4},Season={5},Holiday={6} WHERE LookID={7} ",

    //                                                   IEUtils.SafeSQLString(txtItemTitle.Value),
    //                                                   IEUtils.SafeSQLString(Server.HtmlEncode(txtDescription.Value)),
    //                                                   IEUtils.ToInt(userCookie.Value),
    //                                                   "'" + DateTime.UtcNow + "'",
    //                                                   IEUtils.SafeSQLString(chkCategories.SelectedItem.Text),
    //                                                           IEUtils.SafeSQLString(chkDefaultSeasons.SelectedItem.Text),
    //                                                           IEUtils.SafeSQLString(chkDefaultHoliday.SelectedItem.Text),
    //                                                   IEUtils.ToInt(Request.QueryString["v"]));

    //                db.ExecuteSQL(updateQuery);

    //            // Clear the previously selected items for this lookbook from database
    //                string removeLookbookItemsFromDB = string.Format("Delete From Tbl_LbItems Where LookID={0}",
    //                                                                 IEUtils.ToInt(Request.QueryString["v"]));
    //                db.ExecuteSQL(removeLookbookItemsFromDB);

    //            // Add the newly selected items to the database
    //            foreach (RepeaterItem repItem in rptLookbook.Items)
    //            {
    //                var chkItemID = (CheckBox)repItem.FindControl("chkItemID");

    //                if (chkItemID.Checked)
    //                {
    //                    var lblSelectedItem = (Label)repItem.FindControl("SelectedItem");
    //                    string addLookbookItems = string.Format("INSERT INTO Tbl_LbItems(ItemID,LookID) VALUES({0},{1})", IEUtils.ToInt(lblSelectedItem.Text), IEUtils.ToInt(Request.QueryString["v"]));
    //                    db.ExecuteSQL(addLookbookItems);
    //                }
    //            }
    //        }

    //        //foreach (ListItem lstCategory in chkCategories.Items)
    //        //{
    //        //    if (!lstCategory.Selected) continue;
    //        //    if (httpCookie != null)
    //        //    {
    //        //        string addLbCategory = string.Format("INSERT INTO Tbl_LbCategory(CategoryID,LookID) VALUES({0},{1})", IEUtils.ToInt(lstCategory.Value), IEUtils.ToInt(httpCookie.Value));
    //        //        db.ExecuteSQL(addLbCategory);
    //        //    }
    //        //}

    //        // Add Seasons

    //        //foreach (ListItem lstSeason in chkDefaultSeasons.Items)
    //        //{
    //        //    if (!lstSeason.Selected) continue;
    //        //    if (httpCookie != null)
    //        //    {
    //        //        string addLbSeason = string.Format("INSERT INTO Tbl_LbSeasons(SeasonID,LookID) VALUES({0},{1})", IEUtils.ToInt(lstSeason.Value), IEUtils.ToInt(httpCookie.Value));
    //        //        db.ExecuteSQL(addLbSeason);
    //        //    }
    //        //}

    //        // Add Holidays

    //        //foreach (ListItem lstHoliday in chkDefaultHoliday.Items)
    //        //{
    //        //    if (lstHoliday.Selected)
    //        //    {
    //        //        if (httpCookie != null)
    //        //        {
    //        //            string addLbHolidays = string.Format("INSERT INTO Tbl_LbHolidays(HolidayID,LookID) VALUES({0},{1})", IEUtils.ToInt(lstHoliday.Value), IEUtils.ToInt(httpCookie.Value));
    //        //            db.ExecuteSQL(addLbHolidays);
    //        //        }
    //        //    }
    //        //}

    //        //if (httpCookie != null)
    //        //{
    //        //    string url = "../lightbox/brand-item-view?v=" + httpCookie.Value;
    //        //    string s = "window.open('" + url + "', 'popup_window', 'width=1150,height=700,left=100,resizable=no,toolbar=no,scrollbars=yes,menubar=no,location=no,');";
    //        //    ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
    //        //}

    //       // if (httpCookie != null) Response.Redirect("../lightbox/brand-item-view?v=" + httpCookie.Value);
    //    }
    //    catch (Exception ex)
    //    {
    //        ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
    //    }
    //}

    protected void btnPublish_OnServerClick(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();

            string mainimg = db.GetExecuteScalar("SELECT MainImg From Tbl_Lookbooks Where LookID=" + IEUtils.ToInt(Request.QueryString["v"]));
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

                        string updateQuery = string.Format("UPDATE Tbl_Lookbooks Set  " +
                                                                "Title={0},Description={1}," +
                                                                "IsPublished={2}, UserID={3},DatePosted={4} WHERE LookID={5} ",

                                                                IEUtils.SafeSQLString(txtItemTitle.Value),
                                                                IEUtils.SafeSQLString(Server.HtmlEncode(txtDescription.Text)),
                                                                1,
                                                                IEUtils.ToInt(userCookie.Value),
                                                                "'" + DateTime.UtcNow + "'",
                                                                IEUtils.ToInt(Request.QueryString["v"]));

                        db.ExecuteSQL(updateQuery);

                        if (Session["EditLookbookDetailsData"] != null)
                        {
                            if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).LookBookFeaturedImage != null
                                && (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).LookBookFeaturedImage != "")
                            {
                                string dbQuery = string.Format("UPDATE Tbl_Lookbooks Set MainImg={0} WHERE LookID={1} ",
                                                    IEUtils.SafeSQLString((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).LookBookFeaturedImage),
                                                    IEUtils.ToInt(Request.QueryString["v"]));
                                db.ExecuteSQL(dbQuery);
                            }
                        }

                        // Clear the previously selected items for this lookbook from database
                        string removeLookbookItemsFromDB = string.Format("Delete From Tbl_LbItems Where LookID={0}",
                                                                         IEUtils.ToInt(Request.QueryString["v"]));
                        db.ExecuteSQL(removeLookbookItemsFromDB);
                        // Add the newly selected items to the database
                        foreach (RepeaterItem repItem in rptLookbook.Items)
                        {
                            var chkItemID = (CheckBox)repItem.FindControl("chkItemID");

                            if (chkItemID.Checked)
                            {
                                var lblSelectedItem = (Label)repItem.FindControl("SelectedItem");
                                string addLookbookItems = string.Format("INSERT INTO Tbl_LbItems(ItemID,LookID) VALUES({0},{1})", IEUtils.ToInt(lblSelectedItem.Text), IEUtils.ToInt(Request.QueryString["v"]));
                                db.ExecuteSQL(addLookbookItems);
                            }
                        }
                    }

                    // Add Caregory
                    if (Session["EditLookbookDetailsData"] != null)
                    {
                        if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedCategories != null)
                        {
                            DeleteCSH(db, int.Parse(Request.QueryString["v"]), 0);
                            foreach (ListItem lstCategory in chkCategories.Items)
                            {
                                if (lstCategory.Selected)
                                {
                                    string addItemCategory = string.Format("INSERT INTO Tbl_LbCategory(CategoryID,LookID) VALUES({0},{1})", IEUtils.ToInt(lstCategory.Value), IEUtils.ToInt(Request.QueryString["v"]));
                                    db.ExecuteSQL(addItemCategory);
                                }
                            }
                        }
                    }

                    // Add Seasons
                    if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedSeasons != null)
                    {
                        DeleteCSH(db, int.Parse(Request.QueryString["v"]), 2);
                        foreach (ListItem lstSeason in chkDefaultSeasons.Items)
                        {
                            if (lstSeason.Selected)
                            {
                                string addItemSeason = string.Format("INSERT INTO Tbl_LbSeasons(SeasonID,LookID) VALUES({0},{1})", IEUtils.ToInt(lstSeason.Value), IEUtils.ToInt(Request.QueryString["v"]));
                                db.ExecuteSQL(addItemSeason);
                            }
                        }
                    }

                    // Add Holidays
                    if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedHolidays != null)
                    {
                        DeleteCSH(db, int.Parse(Request.QueryString["v"]), 1);
                        foreach (ListItem lstHoliday in chkDefaultHoliday.Items)
                        {
                            if (lstHoliday.Selected)
                            {
                                string addItemoreHolidays = string.Format("INSERT INTO Tbl_LbHolidays(HolidayID,LookID) VALUES({0},{1})", IEUtils.ToInt(lstHoliday.Value), IEUtils.ToInt(Request.QueryString["v"]));
                                db.ExecuteSQL(addItemoreHolidays);
                            }
                        }
                    }


                    //foreach (ListItem lstCategory in chkCategories.Items)
                    //{
                    //    if (!lstCategory.Selected) continue;
                    //    {
                    //        string addItemCategory = string.Format("INSERT INTO Tbl_LbCategory(CategoryID,LookID) VALUES({0},{1})", IEUtils.ToInt(lstCategory.Value), IEUtils.ToInt(httpCookie.Value));
                    //        db.ExecuteSQL(addItemCategory);
                    //    }
                    //}

                    // Add Seasons

                    //foreach (ListItem lstSeason in chkDefaultSeasons.Items)
                    //{
                    //    if (!lstSeason.Selected) continue;
                    //    string addItemSeason = string.Format("INSERT INTO Tbl_LbSeasons(SeasonID,LookID) VALUES({0},{1})", IEUtils.ToInt(lstSeason.Value), IEUtils.ToInt(httpCookie.Value));
                    //    db.ExecuteSQL(addItemSeason);
                    //}

                    // Add Holidays

                    //foreach (ListItem lstHoliday in chkDefaultHoliday.Items)
                    //{
                    //    if (lstHoliday.Selected)
                    //    {
                    //        {
                    //            string addItemoreHolidays = string.Format("INSERT INTO Tbl_LbHolidays(HolidayID,LookID) VALUES({0},{1})", IEUtils.ToInt(lstHoliday.Value), IEUtils.ToInt(httpCookie.Value));
                    //            db.ExecuteSQL(addItemoreHolidays);
                    //        }
                    //    }
                    //}
                    //txtDescription.Text = "";
                    //ClearCategories();
                    //ClearHolidays();
                    //ClearSeasons();
                    ErrorMessage.ShowSuccessAlert(lblStatus, "Changes to lookbook saved", divAlerts);
                    Response.Redirect("profile-page-lookbooks.aspx", false);
                    //Common.EmptyTextBoxes(this);
                    //const string cookieName = "CurrentLookId";
                    //if (Request.Cookies[cookieName] != null)
                    //{
                    //    var myCookie = new HttpCookie(cookieName) {Expires = DateTime.Now.AddDays(-1d)};
                    //    Response.Cookies.Add(myCookie);
                    //}
                    // rptTags.DataBind();
                    rptLookbook.DataBind();
                    db._sqlConnection.Close();
                    db._sqlConnection.Dispose();
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
        Session["EditLookbookDetailsData"] = null;
        foreach (ListItem lst in chkCategories.Items)
        {
            lst.Selected = false;
        }
    }
    protected void ClearSeasons()
    {
        Session["EditLookbookDetailsData"] = null;
        foreach (ListItem lst in chkDefaultSeasons.Items)
        {
            lst.Selected = false;
        }
    }

    protected void ClearHolidays()
    {
        Session["EditLookbookDetailsData"] = null;
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
    //        int lookID=IEUtils.ToInt(Request.QueryString["v"]);
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
        //for (int i = 40; i > 19; i--)
        //{
        //    if (chkCategories.Items.Count > i) chkCategories.Items[i].Attributes.Add("style", "display:none;");
        //}
        chkCategories.DataSourceID = "";
        chkCategories.DataSource = sdsDefaultCats;
        chkCategories.DataBind();
        LoadSelectedCategories();
        if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).Category_MoreThanTenCounter)
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
        if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).Season_MoreThanTenCounter)
        {
            btn_MoreSeasons.Visible = true;
            btn_LessSeasons.Visible = false;
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
        if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).Holiday_MoreThanTenCounter)
        {
            btn_MoreHolidays.Visible = true;
            btn_LessHolidays.Visible = false;
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
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var chkItemID = (CheckBox)e.Item.FindControl("chkItemID");
                int itemId = IEUtils.ToInt(((Label)e.Item.FindControl("SelectedItem")).Text);
                if (itemslst.Contains(itemId))
                    chkItemID.Checked = true;
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

    private void LoadSelectedCategories()
    {
        foreach (ListItem itm in chkCategories.Items)
        {
            //if (catlst.Contains(IEUtils.ToInt(itm.Value)))
            if (Session["EditLookbookDetailsData"] != null)
            {
                if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedCategories != null)
                {
                    if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedCategories.Contains(int.Parse(itm.Value)))
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
            if (Session["EditLookbookDetailsData"] != null)
            {
                if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedSeasons != null)
                {
                    if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedSeasons.Contains(int.Parse(itm.Value)))
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
            if (Session["EditLookbookDetailsData"] != null)
            {
                if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedHolidays != null)
                {
                    if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedHolidays.Contains(int.Parse(itm.Value)))
                    {
                        itm.Selected = true;
                    }
                }
            }
        }
    }


    protected void chkCategories_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Session["EditLookbookDetailsData"] == null)
        {
            EditLookbookDetailsData editLookbookDetailsData = new EditLookbookDetailsData();
            Session["EditLookbookDetailsData"] = editLookbookDetailsData;
        }

        (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedCategories = new List<int>();
        //selectedCategories = new List<int>();
        for (int i = 0; i < chkCategories.Items.Count; i++)
        {
            if (chkCategories.Items[i].Selected)
            {
                //selectedCategories.Add(Convert.ToInt32(chkCategories.Items[i].Value));
                if (!(Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedCategories.Contains(Convert.ToInt32(chkCategories.Items[i].Value)))
                {
                    (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedCategories.Add(Convert.ToInt32(chkCategories.Items[i].Value));
                }
            }

        }
        if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedCategories.Count > 0)
        {
            CategorySelected.Value = "true";
        }
    }
    protected void chkDefaultSeasons_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Session["EditLookbookDetailsData"] == null)
        {
            EditLookbookDetailsData editLookbookDetailsData = new EditLookbookDetailsData();
            Session["EditLookbookDetailsData"] = editLookbookDetailsData;
        }

        (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedSeasons = new List<int>();
        //selectedCategories = new List<int>();
        for (int i = 0; i < chkDefaultSeasons.Items.Count; i++)
        {
            if (chkDefaultSeasons.Items[i].Selected)
            {
                //selectedCategories.Add(Convert.ToInt32(chkCategories.Items[i].Value));
                if (!(Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedSeasons.Contains(int.Parse(chkDefaultSeasons.Items[i].Value)))
                {
                    (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedSeasons.Add(Convert.ToInt32(chkDefaultSeasons.Items[i].Value));
                }
            }
        }
        if ((Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedSeasons.Count > 0)
        {
            SeasonSelected.Value = "true";
        }
    }
    protected void chkDefaultHoliday_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Session["EditLookbookDetailsData"] == null)
        {
            EditLookbookDetailsData editLookbookDetailsData = new EditLookbookDetailsData();
            Session["EditLookbookDetailsData"] = editLookbookDetailsData;
        }

        (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedHolidays = new List<int>();
        //selectedCategories = new List<int>();
        for (int i = 0; i < chkDefaultHoliday.Items.Count; i++)
        {
            if (chkDefaultHoliday.Items[i].Selected)
            {
                //selectedCategories.Add(Convert.ToInt32(chkCategories.Items[i].Value));
                if (!(Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedHolidays.Contains(int.Parse(chkDefaultHoliday.Items[i].Value)))
                    (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedHolidays.Add(Convert.ToInt32(chkDefaultHoliday.Items[i].Value));
            }
        }
    }

    protected static void DeleteCSH(DatabaseManagement db, int v, int temp)
    {
        if (temp == 0)
        {
            string deleteCat = string.Format("Delete FROM Tbl_LbCategory Where LookID={0}", v);
            db.ExecuteSQL(deleteCat);
        }
        if (temp == 1)
        {
            string deleteHolidays = string.Format("Delete FROM Tbl_LbHolidays Where LookID={0}", v);
            db.ExecuteSQL(deleteHolidays);
        }
        if (temp == 2)
        {
            string deleteSeasons = string.Format("Delete FROM Tbl_LbSeasons Where LookID={0}", v);
            db.ExecuteSQL(deleteSeasons);
        }
    }

    [WebMethod, ScriptMethod]
    public static void SaveItem(string TitleText, string DescriptionTextDetails, string v)
    {
        try
        {
            var db = new DatabaseManagement();
            int x = Convert.ToInt32(v);
            string mainimg = db.GetExecuteScalar("SELECT MainImg From Tbl_Lookbooks Where LookID=" + IEUtils.ToInt(x));
            if (string.IsNullOrEmpty(mainimg))
            {
                //ErrorMessage.ShowErrorAlert(lblStatus, "Please upload Lookbook's feature image.", divAlerts);
            }
            else
            {
                var userCookie = HttpContext.Current.Request.Cookies["FrUserID"];
                if (userCookie != null)
                {

                    string updateQuery = string.Format("UPDATE Tbl_Lookbooks Set  " +
                                                            "Title={0},Description={1}," +
                                                            "IsPublished={2}, UserID={3},DatePosted={4} WHERE LookID={5} ",

                                                            IEUtils.SafeSQLString(TitleText),
                                                            IEUtils.SafeSQLString(DescriptionTextDetails),
                                                            1,
                                                            IEUtils.ToInt(userCookie.Value),
                                                            "'" + DateTime.UtcNow + "'",
                                                            IEUtils.ToInt(x));

                    db.ExecuteSQL(updateQuery);

                    if (HttpContext.Current.Session["EditLookbookDetailsData"] != null)
                    {
                        if ((HttpContext.Current.Session["EditLookbookDetailsData"] as EditLookbookDetailsData).LookBookFeaturedImage != null
                            && (HttpContext.Current.Session["EditLookbookDetailsData"] as EditLookbookDetailsData).LookBookFeaturedImage != "")
                        {
                            string dbQuery = string.Format("UPDATE Tbl_Lookbooks Set MainImg={0} WHERE LookID={1} ",
                                                IEUtils.SafeSQLString((HttpContext.Current.Session["EditLookbookDetailsData"] as EditLookbookDetailsData).LookBookFeaturedImage),
                                                IEUtils.ToInt(x));
                            db.ExecuteSQL(dbQuery);
                        }
                    }

                    // Clear the previously selected items for this lookbook from database
                    //string removeLookbookItemsFromDB = string.Format("Delete From Tbl_LbItems Where LookID={0}",
                      //                                               IEUtils.ToInt(x));
                   // db.ExecuteSQL(removeLookbookItemsFromDB);
                    // Add the newly selected items to the database
                    if (HttpContext.Current.Session["EditLookbookDetailsData"] != null)
                    {
                        if ((HttpContext.Current.Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedItems != null)
                        {
                            string removeLookbookItemsFromDB = string.Format("Delete From Tbl_LbItems Where LookID={0}",
                                                                     IEUtils.ToInt(x));
                            db.ExecuteSQL(removeLookbookItemsFromDB);
                            //foreach (RepeaterItem repItem in rptLookbook.Items)
                            foreach (int itemId in (HttpContext.Current.Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedItems)
                            {
                                string addLookbookItems = string.Format("INSERT INTO Tbl_LbItems(ItemID,LookID) VALUES({0},{1})", IEUtils.ToInt(itemId), IEUtils.ToInt(x));
                                db.ExecuteSQL(addLookbookItems);
                            }
                        }
                    }

                    // Add Caregory
                    if (HttpContext.Current.Session["EditLookbookDetailsData"] != null)
                    {
                        if ((HttpContext.Current.Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedCategories != null)
                        {
                            DeleteCSH(db, x, 0);
                            foreach (int categoryID in (HttpContext.Current.Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedCategories)
                            {
                                string addItemCategory = string.Format("INSERT INTO Tbl_LbCategory(CategoryID,LookID) VALUES({0},{1})", IEUtils.ToInt(categoryID), IEUtils.ToInt(x));
                                db.ExecuteSQL(addItemCategory);
                            }
                        }
                    }

                    // Add Seasons
                    if ((HttpContext.Current.Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedSeasons != null)
                    {
                        DeleteCSH(db, x, 2);
                        foreach (int seasonId in (HttpContext.Current.Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedSeasons)
                        {
                            string addItemSeason = string.Format("INSERT INTO Tbl_LbSeasons(SeasonID,LookID) VALUES({0},{1})", IEUtils.ToInt(seasonId), IEUtils.ToInt(x));
                            db.ExecuteSQL(addItemSeason);
                        }
                    }

                    // Add Holidays
                    if ((HttpContext.Current.Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedHolidays != null)
                    {
                        DeleteCSH(db, x, 1);
                        foreach (int holidayId in (HttpContext.Current.Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedHolidays)
                        {
                            string addItemoreHolidays = string.Format("INSERT INTO Tbl_LbHolidays(HolidayID,LookID) VALUES({0},{1})", IEUtils.ToInt(holidayId), IEUtils.ToInt(x));
                            db.ExecuteSQL(addItemoreHolidays);
                        }
                    }


                    //foreach (ListItem lstCategory in chkCategories.Items)
                    //{
                    //    if (!lstCategory.Selected) continue;
                    //    {
                    //        string addItemCategory = string.Format("INSERT INTO Tbl_LbCategory(CategoryID,LookID) VALUES({0},{1})", IEUtils.ToInt(lstCategory.Value), IEUtils.ToInt(httpCookie.Value));
                    //        db.ExecuteSQL(addItemCategory);
                    //    }
                    //}

                    // Add Seasons

                    //foreach (ListItem lstSeason in chkDefaultSeasons.Items)
                    //{
                    //    if (!lstSeason.Selected) continue;
                    //    string addItemSeason = string.Format("INSERT INTO Tbl_LbSeasons(SeasonID,LookID) VALUES({0},{1})", IEUtils.ToInt(lstSeason.Value), IEUtils.ToInt(httpCookie.Value));
                    //    db.ExecuteSQL(addItemSeason);
                    //}

                    // Add Holidays

                    //foreach (ListItem lstHoliday in chkDefaultHoliday.Items)
                    //{
                    //    if (lstHoliday.Selected)
                    //    {
                    //        {
                    //            string addItemoreHolidays = string.Format("INSERT INTO Tbl_LbHolidays(HolidayID,LookID) VALUES({0},{1})", IEUtils.ToInt(lstHoliday.Value), IEUtils.ToInt(httpCookie.Value));
                    //            db.ExecuteSQL(addItemoreHolidays);
                    //        }
                    //    }
                    //}
                    //txtDescription.Text = "";
                    //ClearCategories();
                    //ClearHolidays();
                    //ClearSeasons();
                    //ErrorMessage.ShowSuccessAlert(lblStatus, "Changes to lookbook saved", divAlerts);
                    //Common.EmptyTextBoxes(this);
                    //const string cookieName = "CurrentLookId";
                    //if (Request.Cookies[cookieName] != null)
                    //{
                    //    var myCookie = new HttpCookie(cookieName) {Expires = DateTime.Now.AddDays(-1d)};
                    //    Response.Cookies.Add(myCookie);
                    //}
                    // rptTags.DataBind();
                    //rptLookbook.DataBind();
                    db.CloseConnection();
                    HttpContext.Current.Session["EditLookbookDetailsData"] = null;
                    HttpContext.Current.Session["IsLookbookSaved"] = true;
                    HttpContext.Current.Response.Redirect("profile-page-lookbooks.aspx", false);
                }
            }

        }

        catch (Exception ex)
        {
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void chkItemID_CheckedChanged(object sender, EventArgs e)
    {
        if (Session["EditLookbookDetailsData"] != null)
        {
            (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedItems = new List<int>();
            foreach (RepeaterItem repItem in rptLookbook.Items)
            {
                var chkItemID = (CheckBox)repItem.FindControl("chkItemID");
                var lblSelectedItem = (Label)repItem.FindControl("SelectedItem");
                if (chkItemID.Checked)
                {
                    if (!(Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedItems.Contains(int.Parse(lblSelectedItem.Text)))
                    {
                        (Session["EditLookbookDetailsData"] as EditLookbookDetailsData).SelectedItems.Add(int.Parse(lblSelectedItem.Text));
                    }
                }
            }
        }
    }
}
