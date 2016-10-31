
using System;
using System.Collections;
using System.IO;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;


    public partial class pr_brand_add_item : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var al = new ArrayList { lblUsername, imgUserIcon };
            Common.UserSettings(al);
            //if (Session["CurrentItemId"] as string == "0")
            //    CreateNewItem();
            if(!IsPostBack)
            {

                chkCategories.DataBind();
                chkDefaultSeasons.DataBind();
                chkDefaultHoliday.DataBind();
                DisplayDefaultCats();
                DisplayDefaultSeasons();
                DisplayDefaultHolidays();
            }

            dvTagToggles.Visible = rptTags.Items.Count > 0;
            dvSeasonToggle.Visible = chkDefaultSeasons.Items.Count >= 4;
       
        }
        protected void CreateNewItem()
        {
            try
            {
                var db=new DatabaseManagement();
                //int sortOrder = db.GetMaxID("SortOrder", "Tbl_ActivityBanners");
                string insertEvent =
                    string.Format(
                        "INSERT INTO Tbl_Items(DatePosted) VALUES({0})",
                        IEUtils.SafeSQLDate(DateTime.Now)
                        );
                db.ExecuteSQL(insertEvent);

                int itemId = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(ItemID) From Tbl_Items"));
               
                Session["CurrentItemId"] = itemId;

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
        public static void RemoveImage(string filename)
        {
            var db = new DatabaseManagement();
            var httpCookie = HttpContext.Current.Request.Cookies["CurrentItemId"];
            if (httpCookie != null)
            {
                string actualName =
                    db.GetExecuteScalar(
                        string.Format("Select ItemImg From Tbl_ItemImages Where TempName={0}  AND ItemID={1}",
                                      IEUtils.SafeSQLString(filename), IEUtils.ToInt(httpCookie.Value)));
                string deleteQuery = string.Format("Delete From Tbl_ItemImages Where TempName={0} AND ItemID={1}",
                                                   IEUtils.SafeSQLString(filename), IEUtils.ToInt(httpCookie.Value));
                db.ExecuteSQL(deleteQuery);
                File.Delete("../photobank/" + actualName);
            }
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();

        }

        [WebMethod, ScriptMethod]
        public static void RemoveFeatureImage(string filename)
        {
            var db = new DatabaseManagement();
            var httpCookie = HttpContext.Current.Request.Cookies["CurrentItemId"];
            if (httpCookie != null)
            {
                string deleteQuery = string.Format("Update Tbl_Items Set FeatureImg=NULL  Where AND ItemID={0}",
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
                string itemKey = Encryption64.Encrypt(HttpContext.Current.Session["CurrentItemId"].ToString()).Replace('+', '=');
                string updateQuery = string.Format("UPDATE Tbl_Items Set ItemKey={0}," +
                                                "Title={1},Description={2},RetailPrice={3}," +
                                                "WholesalePrice={4}," +
                                                "StyleNumber={5},StyleName={6},Color={7}," +
                                                "IsPublished={8}, UserID={9},DatePosted={10} WHERE ItemID={11} ",
                                                IEUtils.SafeSQLString(itemKey),
                                                IEUtils.SafeSQLString(txtItemTitle.Value),
                                                IEUtils.SafeSQLString(Server.HtmlEncode(txtDescription.Value)),
                                                 IEUtils.ToDouble(txtRetail.Value),
                                                 IEUtils.ToDouble(txtWholesale.Value),
                                                 IEUtils.SafeSQLString(txtStyleNumber.Value),
                                                 IEUtils.SafeSQLString(txtStyleName.Value),
                                                 IEUtils.SafeSQLString(lblColor1.Text),
                                                 1,
                                                 IEUtils.ToInt(HttpContext.Current.Session["UserID"]),
                                                 "'" + DateTime.UtcNow + "'",
                                                 IEUtils.ToInt(HttpContext.Current.Session["CurrentItemId"]));

                db.ExecuteSQL(updateQuery);

                foreach (ListItem lstCategory in chkCategories.Items)
                {
                    if (!lstCategory.Selected) continue;
                    string addItemCategory = string.Format("INSERT INTO Tbl_ItemsCategory(CategoryID,ItemID) VALUES({0},{1})", IEUtils.ToInt(lstCategory.Value), IEUtils.ToInt(HttpContext.Current.Session["CurrentItemId"]));
                    db.ExecuteSQL(addItemCategory);
                }

                // Add Seasons

                foreach (ListItem lstSeason in chkDefaultSeasons.Items)
                {
                    if (!lstSeason.Selected) continue;
                    string addItemSeason = string.Format("INSERT INTO Tbl_ItemSeasons(SeasonID,ItemID) VALUES({0},{1})", IEUtils.ToInt(lstSeason.Value), IEUtils.ToInt(HttpContext.Current.Session["CurrentItemId"]));
                    db.ExecuteSQL(addItemSeason);
                }

                // Add Holidays

                foreach (ListItem lstHoliday in chkDefaultHoliday.Items)
                {
                    if (lstHoliday.Selected)
                    {
                        string addItemoreHolidays = string.Format("INSERT INTO Tbl_ItemHolidays(HolidayID,ItemID) VALUES({0},{1})", IEUtils.ToInt(lstHoliday.Value), IEUtils.ToInt(HttpContext.Current.Session["CurrentItemId"]));
                        db.ExecuteSQL(addItemoreHolidays);
                    }
                }
                
                Response.Redirect("../lightbox/brand-item-view.aspx?v=" + HttpContext.Current.Session["CurrentItemId"]);
            }
            catch (Exception ex)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
        }
       
        protected void btnPublish_OnServerClick(object sender, EventArgs e)
        {
            try
            {
                var db=new DatabaseManagement();
                
                string mainimg = db.GetExecuteScalar("SELECT FeatureImg From Tbl_Items Where ItemID=" + IEUtils.ToInt(HttpContext.Current.Session["CurrentItemId"]));
                if (string.IsNullOrEmpty(mainimg))
                {
                    ErrorMessage.ShowErrorAlert(lblStatus, "Please upload item's feature image.", divAlerts);
                }
                else
                {
                    string checkItemImages = db.GetExecuteScalar("SELECT Top 1 ImgID From Tbl_ItemImages Where ItemID=" + IEUtils.ToInt(HttpContext.Current.Session["CurrentItemId"]));
                    if(string.IsNullOrEmpty(checkItemImages))
                    {
                        ErrorMessage.ShowErrorAlert(lblStatus, "Please upload atleast one item image.", divAlerts);
                    }
                    else
                    {
                        var httpCookie = HttpContext.Current.Request.Cookies["CurrentItemId"];
                        if (httpCookie != null)
                        {
                            string itemKey = Encryption64.Encrypt(httpCookie.Value).Replace('+', '=');
                            string updateQuery = string.Format("UPDATE Tbl_Items Set ItemKey={0}," +
                                                               "Title={1},Description={2},RetailPrice={3}," +
                                                               "WholesalePrice={4}," +
                                                               "StyleNumber={5},StyleName={6},Color={7}," +
                                                               "IsPublished={8}, UserID={9},DatePosted={10} WHERE ItemID={11} ",
                                                               IEUtils.SafeSQLString(itemKey),
                                                               IEUtils.SafeSQLString(txtItemTitle.Value),
                                                               IEUtils.SafeSQLString(txtDescription.Value),
                                                               IEUtils.ToDouble(txtRetail.Value),
                                                               IEUtils.ToDouble(txtWholesale.Value),
                                                               IEUtils.SafeSQLString(txtStyleNumber.Value),
                                                               IEUtils.SafeSQLString(txtStyleName.Value),
                                                               IEUtils.SafeSQLString(lblColor1.Text),
                                                               1,
                                                               IEUtils.ToInt(HttpContext.Current.Session["UserID"]),
                                                               "'" + DateTime.UtcNow + "'",
                                                               IEUtils.ToInt(httpCookie.Value));

                            db.ExecuteSQL(updateQuery);
                        }

                        foreach (ListItem lstCategory in chkCategories.Items)
                        {
                            if (!lstCategory.Selected) continue;
                            if (httpCookie != null)
                            {
                                string addItemCategory = string.Format("INSERT INTO Tbl_ItemsCategory(CategoryID,ItemID) VALUES({0},{1})", IEUtils.ToInt(lstCategory.Value), IEUtils.ToInt(httpCookie.Value));
                                db.ExecuteSQL(addItemCategory);
                            }
                        }
                        
                        // Add Seasons
                      
                        foreach (ListItem lstSeason in chkDefaultSeasons.Items)
                        {
                            if (!lstSeason.Selected) continue;
                            string addItemSeason = string.Format("INSERT INTO Tbl_ItemSeasons(SeasonID,ItemID) VALUES({0},{1})", IEUtils.ToInt(lstSeason.Value), IEUtils.ToInt(HttpContext.Current.Session["CurrentItemId"]));
                            db.ExecuteSQL(addItemSeason);
                        }

                        // Add Holidays
                      
                        foreach (ListItem lstHoliday in chkDefaultHoliday.Items)
                        {
                            if (lstHoliday.Selected)
                            {
                                if (httpCookie != null)
                                {
                                    string addItemoreHolidays = string.Format("INSERT INTO Tbl_ItemHolidays(HolidayID,ItemID) VALUES({0},{1})", IEUtils.ToInt(lstHoliday.Value), IEUtils.ToInt(httpCookie.Value));
                                    db.ExecuteSQL(addItemoreHolidays);
                                }
                            }
                        }
                        txtDescription.Value = "";
                       
                       ErrorMessage.ShowSuccessAlert(lblStatus, "Item record saved successfully", divAlerts);
                        Common.EmptyTextBoxes(this);
                        HttpContext.Current.Response.Cookies["CurrentItemId"].Value=string.Empty;
                        HttpContext.Current.Response.Cookies["CurrentItemId"].Expires.AddDays(-1);
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

        protected void btnAddTag_OnServerClick(object sender, EventArgs e)
        {
            try
            {
                var db=new DatabaseManagement();
                int itemId;
                var httpCookie = HttpContext.Current.Request.Cookies["CurrentItemId"];
                if (httpCookie != null && !string.IsNullOrEmpty(httpCookie.Value))
                {
                    itemId = Convert.ToInt32(httpCookie.Value);
                }
                else
                {
                    string insertEvent =
                   string.Format(
                       "INSERT INTO Tbl_Items(DatePosted) VALUES({0})",
                       IEUtils.SafeSQLDate(DateTime.Now)
                       );
                    db.ExecuteSQL(insertEvent);
                    itemId = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(ItemID) From Tbl_Items"));
                    HttpContext.Current.Response.Cookies["CurrentItemId"].Value = itemId.ToString();
                }
                string[] multipletags = txtTag.Value.Split(',');
                foreach (string t in multipletags)
                {
                    string addNewTag = string.Format("INSERT INTO Tbl_ItemTags(ItemID,Title) VALUES({0},{1})",

                                                     itemId,
                                                     IEUtils.SafeSQLString(t));
                    db.ExecuteSQL(addNewTag);
                }
              
                txtTag.Value = "";
                rptTags.DataBind();
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
            for (int i = 8; i > 5; i--)
            {
                if (chkCategories.Items.Count > i) chkCategories.Items[i].Attributes.Add("style", "display:block;");
            }
            btn_ViewMore.Visible = false;
            btn_ViewLess.Visible = true;
        }

        private void DisplayDefaultCats()
        {
            for (int i = 8; i > 5; i--)
            {
                if (chkCategories.Items.Count > i) chkCategories.Items[i].Attributes.Add("style", "display:none;");
            }
            btn_ViewMore.Visible = true;
            btn_ViewLess.Visible = false;
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
        private void DisplayMoreSeasons()
        {
            for (int i = 8; i > 5; i--)
            {
                if (chkDefaultSeasons.Items.Count > i) chkDefaultSeasons.Items[i].Attributes.Add("style", "display:block;");
            }
            btn_MoreSeasons.Visible = false;
            btn_LessSeasons.Visible = true;
        }
        protected void btn_MoreSeasons_Click(object sender, EventArgs e)
        {
            DisplayMoreSeasons();
        }
        private void DisplayDefaultSeasons()
        {
            for (int i = 8; i > 5; i--)
            {
                if (chkDefaultSeasons.Items.Count > i) chkDefaultSeasons.Items[i].Attributes.Add("style", "display:none;");
            }
            btn_MoreSeasons.Visible = true;
            btn_LessSeasons.Visible = false;
        }
        protected void btn_LessSeasons_Click(object sender, EventArgs e)
        {
            DisplayDefaultSeasons();
        }
        private void DisplayMoreHolidays()
        {
            for (int i = 8; i > 5; i--)
            {
                if (chkDefaultHoliday.Items != null)
                    if (chkDefaultHoliday.Items.Count > i) chkDefaultHoliday.Items[i].Attributes.Add("style", "display:block;");
            }
            btn_MoreHolidays.Visible = false;
            btn_LessHolidays.Visible = true;
        }
        protected void btn_MoreHolidays_Click(object sender, EventArgs e)
        {
            DisplayMoreHolidays();
        }

        private void DisplayDefaultHolidays()
        {
            for (int i = 8; i > 5; i--)
            {
                if (chkDefaultHoliday.Items.Count > i) chkDefaultHoliday.Items[i].Attributes.Add("style", "display:none;");
            }
            btn_MoreHolidays.Visible = true;
            btn_LessHolidays.Visible = false;
        }
        protected void btn_LessHolidays_Click(object sender, EventArgs e)
        {
            DisplayDefaultHolidays();
        }
        protected void lbtnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                var httpCookie = HttpContext.Current.Request.Cookies["CurrentItemId"];
                if (httpCookie != null && !string.IsNullOrEmpty(httpCookie.Value))
                {
                    var db = new DatabaseManagement();
                    string deleteItem = String.Format("Delete FROM Tbl_Items Where ItemID={0}",
                                                      IEUtils.ToInt(httpCookie.Value));
                    db.ExecuteSQL(deleteItem);
                    ErrorMessage.ShowSuccessAlert(lblStatus, "Item record deleted.", divAlerts);
                }
                else
                {
                    ErrorMessage.ShowErrorAlert(lblStatus, "No item record found to delete", divAlerts);
                }
            }
            catch (Exception ex)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
        }
}
