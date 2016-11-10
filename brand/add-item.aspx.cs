using System;
using System.Collections;
using System.IO;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;
using System.Collections.Generic;
using System.Data.SqlClient;

public partial class pr_brand_add_item : System.Web.UI.Page
{



    protected void Page_Load(object sender, EventArgs e)
    {
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        //txtItemTitle.Focus();
        if (!IsPostBack)
        {
            Session["FeatureImage"] = new FeatureImage();
            Session["ThumbnailImageList"] = null;
            Session["itemTags"] = null;
            chkCategories.DataBind();
            chkDefaultSeasons.DataBind();
            chkDefaultHoliday.DataBind();
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

        dvTagToggles.Visible = rptTags.Items.Count > 0;
        dvSeasonToggle.Visible = chkDefaultSeasons.Items.Count >= 4;
        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
        // GetSelectedColor();
    }
    //protected void CreateNewItem()
    //{
    //    try
    //    {
    //        var db=new DatabaseManagement();
    //           string insertEvent =
    //            string.Format(
    //                "INSERT INTO Tbl_Items(DatePosted) VALUES({0})",
    //                IEUtils.SafeSQLDate(DateTime.Now)
    //                );
    //        db.ExecuteSQL(insertEvent);

    //        int itemId = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(ItemID) From Tbl_Items"));

    //        Session["CurrentItemId"] = itemId;

    //    }
    //    catch (Exception ex)
    //    {
    //        ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
    //    }
    //}
    protected void spelcheck_OnLoad(object sender, EventArgs e)
    {
        // spelcheck.Visible = false;
    }

    [WebMethod, ScriptMethod]
    public static void SetSession(string value)
    {
        var currItem = new HttpCookie("ColorVal") { Value = value };
        HttpContext.Current.Response.Cookies.Add(currItem);
        // HttpContext.Current.Session["ColorVal"] = value;

    }
    [WebMethod, ScriptMethod]
    public static void RemoveImage(string filename)
    {
        List<FeatureImage> ThumbImageList = (List<FeatureImage>)HttpContext.Current.Session["ThumbnailImageList"];

        var itemToRemove = ThumbImageList.FindIndex(x => x.FeatureImageTempname == filename);
        ThumbImageList.RemoveAt(itemToRemove);
        HttpContext.Current.Session["ThumbnailImageList"] = ThumbImageList;
        //var db = new DatabaseManagement();
        //var httpCookie = HttpContext.Current.Request.Cookies["CurrentItemId"];
        //if (httpCookie != null)
        //{
        //    string actualName =
        //        db.GetExecuteScalar(
        //            string.Format("Select ItemImg From Tbl_ItemImages Where TempName={0}  AND ItemID={1}",
        //                          IEUtils.SafeSQLString(filename), IEUtils.ToInt(httpCookie.Value)));
        //    string deleteQuery = string.Format("Delete From Tbl_ItemImages Where TempName={0} AND ItemID={1}",
        //                                       IEUtils.SafeSQLString(filename), IEUtils.ToInt(httpCookie.Value));
        //    db.ExecuteSQL(deleteQuery);
        //    File.Delete("../photobank/" + actualName);
        //}
        //db._sqlConnection.Close();
        //db._sqlConnection.Dispose();

    }

    [WebMethod, ScriptMethod]
    public static void RemoveFeatureImage(string filename)
    {

        ((FeatureImage)HttpContext.Current.Session["FeatureImage"]).FeatureImageName = null;
        ((FeatureImage)HttpContext.Current.Session["FeatureImage"]).FeatureImageTempname = null;

        //var db = new DatabaseManagement();
        //var httpCookie = HttpContext.Current.Request.Cookies["CurrentItemId"];
        //if (httpCookie != null)
        //{
        //    string deleteQuery = string.Format("Update Tbl_Items Set FeatureImg=NULL  Where AND ItemID={0}",
        //                                       IEUtils.ToInt(httpCookie.Value));
        //    db.ExecuteSQL(deleteQuery);
        //}

        //db._sqlConnection.Close();
        //db._sqlConnection.Dispose();

    }

    //protected void btnPreview_OnServerClick(object sender, EventArgs e)
    //{
    //    try
    //    {

    //        var db = new DatabaseManagement();
    //        var httpCookie = HttpContext.Current.Request.Cookies["CurrentItemId"];
    //        if (httpCookie != null)
    //        {
    //            string itemKey = Encryption64.Encrypt(httpCookie.Value).Replace('+', '=');
    //            var Colorcookie = Request.Cookies["ColorVal"];
    //            var userCookie = Request.Cookies["FrUserID"];
    //            if (Colorcookie != null && userCookie !=null)
    //            {
    //                string updateQuery = string.Format("UPDATE Tbl_Items Set ItemKey={0}," +
    //                                                   "Title={1},Description={2},RetailPrice={3}," +
    //                                                   "WholesalePrice={4}," +
    //                                                   "StyleNumber={5},StyleName={6},Color={7}," +
    //                                                   "IsPublished={8}, UserID={9},DatePosted={10} WHERE ItemID={11} ",
    //                                                   IEUtils.SafeSQLString(itemKey),
    //                                                   IEUtils.SafeSQLString(txtItemTitle.Value),
    //                                                   IEUtils.SafeSQLString(Server.HtmlEncode(txtDescription.Text)),
    //                                                   IEUtils.ToDouble(txtRetail.Value),
    //                                                   IEUtils.ToDouble(txtWholesale.Value),
    //                                                   IEUtils.SafeSQLString(txtStyleNumber.Value),
    //                                                   IEUtils.SafeSQLString(txtStyleName.Value),
    //                                                   IEUtils.SafeSQLString(Colorcookie.Value),
    //                                                   1,
    //                                                   IEUtils.ToInt(userCookie.Value),
    //                                                   "'" + DateTime.UtcNow + "'",
    //                                                   //IEUtils.SafeSQLString(chkCategories.SelectedItem.Text),
    //                                                   //IEUtils.SafeSQLString(chkDefaultSeasons.SelectedItem.Text),
    //                                                   //IEUtils.SafeSQLString(chkDefaultHoliday.SelectedItem.Text),
    //                                                   IEUtils.ToInt(httpCookie.Value));

    //                db.ExecuteSQL(updateQuery);
    //            }
    //        }


    //        foreach (ListItem lstCategory in chkCategories.Items)
    //        {
    //            if (!lstCategory.Selected) continue;
    //            if (httpCookie != null)
    //            {
    //                string addItemCategory = string.Format("INSERT INTO Tbl_ItemsCategory(CategoryID,ItemID) VALUES({0},{1})", IEUtils.ToInt(lstCategory.Value), IEUtils.ToInt(httpCookie.Value));
    //                db.ExecuteSQL(addItemCategory);
    //            }
    //        }

    //        // Add Seasons

    //        foreach (ListItem lstSeason in chkDefaultSeasons.Items)
    //        {
    //            if (!lstSeason.Selected) continue;
    //            if (httpCookie != null)
    //            {
    //                string addItemSeason = string.Format("INSERT INTO Tbl_ItemSeasons(SeasonID,ItemID) VALUES({0},{1})", IEUtils.ToInt(lstSeason.Value), IEUtils.ToInt(httpCookie.Value));
    //                db.ExecuteSQL(addItemSeason);
    //            }
    //        }

    //        // Add Holidays

    //        foreach (ListItem lstHoliday in chkDefaultHoliday.Items)
    //        {
    //            if (lstHoliday.Selected)
    //            {
    //                if (httpCookie != null)
    //                {
    //                    string addItemoreHolidays = string.Format("INSERT INTO Tbl_ItemHolidays(HolidayID,ItemID) VALUES({0},{1})", IEUtils.ToInt(lstHoliday.Value), IEUtils.ToInt(httpCookie.Value));
    //                    db.ExecuteSQL(addItemoreHolidays);
    //                }
    //            }
    //        }

    //        if (httpCookie != null)
    //        {
    //            hidden_link.Attributes["href"] = "../lightbox/brand-item-view?v=" + httpCookie.Value; 
    //            Literal1.Text = "<script>jQuery(document).ready(function() {$(\"#hidden_link\").trigger('click');});</script>";
    //        }

    //        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
    //    }
    //    catch (Exception ex)
    //    {
    //        ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
    //    }
    //}

    [WebMethod, ScriptMethod]
    public static void SaveItem(string TitleText, string RetailText, string WholesaleText, string StyleNumberText, string StyleNameText)
    {

        try
        {
            var xxx = selectedCategories;
            var db = new DatabaseManagement();
            var FeatureImageName = ((FeatureImage)HttpContext.Current.Session["FeatureImage"]).FeatureImageName;
            var FeatureImageTempName = ((FeatureImage)HttpContext.Current.Session["FeatureImage"]).FeatureImageTempname;


            string insertEvent =
string.Format(
  "INSERT INTO Tbl_Items(FeatureImg,DatePosted) VALUES({0},{1})",
  IEUtils.SafeSQLString(FeatureImageName),
  IEUtils.SafeSQLDate(DateTime.Now)
  );
            db.ExecuteSQL(insertEvent);

            var itemId = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(ItemID) From Tbl_Items"));
            var currItem = new HttpCookie("CurrentItemId") { Value = itemId.ToString() };
            HttpContext.Current.Response.Cookies.Add(currItem);
            var httpCookie = HttpContext.Current.Request.Cookies["CurrentItemId"];
            if (httpCookie != null)
            {



                //string mainimg = db.GetExecuteScalar("SELECT FeatureImg From Tbl_Items Where ItemID=" + IEUtils.ToInt(httpCookie.Value));
                //if (string.IsNullOrEmpty(mainimg))
                //{
                //    ErrorMessage.ShowErrorAlert(lblStatus, "Please upload item's feature image.", divAlerts);
                //}

                //  string checkItemImages = db.GetExecuteScalar("SELECT Top 1 ImgID From Tbl_ItemImages Where ItemID=" + IEUtils.ToInt(httpCookie.Value));
                //if(string.IsNullOrEmpty(checkItemImages))
                //{
                //    ErrorMessage.ShowErrorAlert(lblStatus, "Please upload atleast one item image.", divAlerts);
                //}

                var Colorcookie = HttpContext.Current.Request.Cookies["ColorVal"];
                var userCookie = HttpContext.Current.Request.Cookies["FrUserID"];

                if (userCookie != null)
                {
                    {
                        string itemKey = Encryption64.Encrypt(httpCookie.Value).Replace('+', '=');
                        //if (Colorcookie != null)
                        //{


                        string insertQuery =
                                      string.Format(
                                          "INSERT INTO Tbl_ItemImages(ItemImg,ItemID,TempName) VALUES({0},{1},{2})",
                                          IEUtils.SafeSQLString(FeatureImageName),
                                          itemId,
                                          IEUtils.SafeSQLString(FeatureImageTempName)
                                          );
                        db.ExecuteSQL(insertQuery);




                        string updateQuery = string.Format("UPDATE Tbl_Items Set ItemKey={0}," +
                                                           "Title={1},Description={2},RetailPrice={3}," +
                                                           "WholesalePrice={4}," +
                                                           "StyleNumber={5},StyleName={6},Color={7}," +
                                                           "IsPublished={8}, UserID={9},DatePosted={10},FeatureImg={11}  WHERE ItemID={12} ",
                                                           IEUtils.SafeSQLString(itemKey),
                                                           IEUtils.SafeSQLString(TitleText),
                                                             IEUtils.SafeSQLString(itemDescription),
                                                           IEUtils.ToDouble(RetailText),
                                                           IEUtils.ToDouble(WholesaleText),
                                                           IEUtils.SafeSQLString(StyleNumberText),
                                                           IEUtils.SafeSQLString(StyleNameText),
                                                           IEUtils.SafeSQLString(Colorcookie.Value),
                                                           1,
                                                           IEUtils.ToInt(userCookie.Value),
                                                           "'" + DateTime.UtcNow + "'",
                                                           IEUtils.SafeSQLString(FeatureImageName),
                            //IEUtils.SafeSQLString(chkCategories.SelectedItem.Text),
                            //IEUtils.SafeSQLString(chkDefaultSeasons.SelectedItem.Text),
                            // IEUtils.SafeSQLString(chkDefaultHoliday.SelectedItem.Text),
                                                           IEUtils.ToInt(httpCookie.Value));

                        db.ExecuteSQL(updateQuery);

                        List<itemTags> itemtagList = (List<itemTags>)HttpContext.Current.Session["itemTags"];
                        if (itemtagList != null)
                        {
                            foreach (var item in itemtagList)
                            {
                                string selectTagQuery = string.Format("Select TagID from Tbl_Tags where TagName={0}", IEUtils.SafeSQLString(item.tagName.ToLower()));
                                db._sqlConnection.Close();
                                db._sqlConnection.Dispose();
                                db = new DatabaseManagement();
                                SqlDataReader dr = db.ExecuteReader(selectTagQuery);
                                int tagID = 0;
                                while (dr.Read())
                                {
                                    if (dr != null && dr.HasRows)
                                    {
                                        tagID = int.Parse(dr["TagID"].ToString());
                                    }
                                }

                                if (tagID == 0)
                                {
                                    string insertTagQuery = string.Format("INSERT INTO Tbl_Tags(TagName) VALUES({0})", IEUtils.SafeSQLString(item.tagName.ToLower()));
                                    db._sqlConnection.Close();
                                    db._sqlConnection.Dispose();
                                    db = new DatabaseManagement();
                                    db.ExecuteSQL(insertTagQuery);
                                    string getTagIDQuery = string.Format("Select TagID from Tbl_Tags where TagName={0}", IEUtils.SafeSQLString(item.tagName.ToLower()));
                                    db._sqlConnection.Close();
                                    db._sqlConnection.Dispose();
                                    db = new DatabaseManagement();
                                    SqlDataReader drId = db.ExecuteReader(getTagIDQuery);
                                    while (drId.Read())
                                    {
                                        if (drId != null && drId.HasRows)
                                        {
                                            tagID = int.Parse(drId["TagID"].ToString());
                                        }
                                    }
                                }
                                string insertItemTagQuery = string.Format("INSERT INTO Tbl_ItemTagsMapping(ItemID,TagID) VALUES({0},{1})", itemId, tagID);
                                db._sqlConnection.Close();
                                db._sqlConnection.Dispose();
                                db = new DatabaseManagement();
                                db.ExecuteSQL(insertItemTagQuery);
                            }
                        }


                        List<FeatureImage> ThumbImageList = (List<FeatureImage>)HttpContext.Current.Session["ThumbnailImageList"];
                        foreach (var items in ThumbImageList)
                        {
                            string ThumbImage =
                                                string.Format(
                                                    "INSERT INTO Tbl_ItemImages(ItemImg,ItemID,TempName) VALUES({0},{1},{2})",
                                                    IEUtils.SafeSQLString(items.FeatureImageName),
                                                    itemId,
                                                    IEUtils.SafeSQLString(items.FeatureImageTempname)
                                                    );
                            db.ExecuteSQL(ThumbImage);
                        }


                        //}
                    }
                }

                foreach (int lstCategory in selectedCategories)
                {
                    string addItemCategory = string.Format("INSERT INTO Tbl_ItemsCategory(CategoryID,ItemID) VALUES({0},{1})", IEUtils.ToInt(lstCategory), IEUtils.ToInt(httpCookie.Value));
                    db.ExecuteSQL(addItemCategory);
                }

                // Add Seasons

                foreach (int lstSeason in selectedSeasons)
                {

                    string addItemSeason = string.Format("INSERT INTO Tbl_ItemSeasons(SeasonID,ItemID) VALUES({0},{1})", IEUtils.ToInt(lstSeason), IEUtils.ToInt(httpCookie.Value));
                    db.ExecuteSQL(addItemSeason);
                }

                // Add Holidays

                foreach (int lstholiday in selectedHolidays)
                {

                    string additemoreholidays = string.Format("insert into tbl_itemholidays(holidayid,itemid) values({0},{1})", IEUtils.ToInt(lstholiday), IEUtils.ToInt(httpCookie.Value));
                    db.ExecuteSQL(additemoreholidays);


                }
                //txtDescription.Text = "";


                HttpContext.Current.Session["ColorVal"] = "";
                const string cookieName = "CurrentItemId";
                if (HttpContext.Current.Request.Cookies[cookieName] != null)
                {
                    var myCookie = new HttpCookie(cookieName) { Expires = DateTime.Now.AddDays(-1d) };
                    HttpContext.Current.Response.Cookies.Add(myCookie);
                }
                db._sqlConnection.Close();
                db._sqlConnection.Dispose();


            }
        }
        catch (Exception ex)
        {
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
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
    protected void btnAddTag_OnServerClick(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
            int itemId;
            var httpCookie = HttpContext.Current.Request.Cookies["CurrentItemId"];
            if (httpCookie != null && !string.IsNullOrEmpty(httpCookie.Value))
            {
                //itemId = Convert.ToInt32(httpCookie.Value);
            }
            else
            {
                // string insertEvent =
                //string.Format(
                //    "INSERT INTO Tbl_Items(DatePosted) VALUES({0})",
                //    IEUtils.SafeSQLDate(DateTime.Now)
                //    );
                //db.ExecuteSQL(insertEvent);
                //itemId = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(ItemID) From Tbl_Items"));
                //var currItem = new HttpCookie("CurrentItemId") {Value = itemId.ToString()};
                //Response.Cookies.Add(currItem);
                // HttpContext.Current.Response.Cookies["CurrentItemId"].Value = itemId.ToString();
            }
            string[] multipletags = txtTag.Value.Split(',');
            foreach (string t in multipletags)
            {

                if (HttpContext.Current.Session["itemTags"] == null)
                {
                    itemTags tag = new itemTags();
                    tag.tagName = t;
                    List<itemTags> itemtaglist = new List<itemTags>();
                    itemtaglist.Add(tag);
                    HttpContext.Current.Session["itemTags"] = itemtaglist;
                }
                else
                {
                    List<itemTags> itemtaglist = (List<itemTags>)HttpContext.Current.Session["itemTags"];
                    itemTags tag = new itemTags();
                    tag.tagName = t;
                    itemtaglist.Add(tag);
                    HttpContext.Current.Session["itemTags"] = itemtaglist;
                }


                //string addNewTag = string.Format("INSERT INTO Tbl_ItemTags(ItemID,Title) VALUES({0},{1})",

                //                                 itemId,
                //                                 IEUtils.SafeSQLString(t));
                //db.ExecuteSQL(addNewTag);


            }

            txtTag.Value = "";
            rptTags.DataSourceID = "";
            rptModTags.DataSourceID = "";
            rptTags.DataSource = (List<itemTags>)HttpContext.Current.Session["itemTags"];
            rptModTags.DataSource = (List<itemTags>)HttpContext.Current.Session["itemTags"];
            rptTags.DataBind();
            rptModTags.DataBind();
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
        chkCategories.DataSourceID = "";
        chkCategories.DataSource = sdsMoreCats;
        chkCategories.DataBind();
        /*for (int i = 40; i > 19; i--)
        {
            if (chkCategories.Items.Count > i) chkCategories.Items[i].Attributes.Add("style", "display:block;");

        }*/

        btn_ViewMore.Visible = false;
        btn_ViewLess.Visible = true;
    }

    private void DisplayDefaultCats()
    {
        chkCategories.DataSourceID = "";
        chkCategories.DataSource = sdsDefaultCats;
        chkCategories.DataBind();
        /*for (int i = 40; i > 19; i--)
        {
            if (chkCategories.Items.Count > i) chkCategories.Items[i].Attributes.Add("style", "display:none;");
        }*/

        btn_ViewMore.Visible = true;
        btn_ViewLess.Visible = false;
    }

    protected void btn_MoreTags_Click(object sender, EventArgs e)
    {
        rptTags.DataSourceID = "";
        //rptTags.DataSource = sdsMoreTags;
        rptTags.DataBind();
        btn_MoreTags.Visible = false;
        btn_LessTags.Visible = true;
    }
    protected void btn_LessTags_Click(object sender, EventArgs e)
    {
        rptTags.DataSourceID = "";
        //rptTags.DataSource = sdsTags;
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
    protected void rptTags_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "1")
            {
                List<itemTags> itemtagList = (List<itemTags>)HttpContext.Current.Session["itemTags"];
                string itemName = e.CommandArgument.ToString();
                var itemToRemove = itemtagList.FindIndex(x => x.tagName == e.CommandArgument.ToString());
                itemtagList.RemoveAt(itemToRemove);
                HttpContext.Current.Session["itemTags"] = itemtagList;
                //var db = new DatabaseManagement();
                //db.ExecuteSQL("Delete from Tbl_ItemTags Where TagID=" + IEUtils.ToInt(e.CommandArgument));
                //rptTags.DataBind();
                txtTag.Value = "";
                rptTags.DataSourceID = "";
                rptModTags.DataSourceID = "";
                rptTags.DataSource = (List<itemTags>)HttpContext.Current.Session["itemTags"];
                rptModTags.DataSource = (List<itemTags>)HttpContext.Current.Session["itemTags"];
                rptTags.DataBind();
                rptModTags.DataBind();
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
                string color = e.CommandArgument.ToString();
                var currItem = new HttpCookie("ColorVal") { Value = color };
                HttpContext.Current.Response.Cookies.Add(currItem);
                string stylevalue = "background:#" + color;
                colbtn.Attributes.Add("style", stylevalue);
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




    static List<int> selectedCategories;
    protected void chkCategories_SelectedIndexChanged(object sender, EventArgs e)
    {
        selectedCategories = new List<int>();
        for (int i = 0; i < chkCategories.Items.Count; i++)
        {
            if (chkCategories.Items[i].Selected)
            {
                selectedCategories.Add(Convert.ToInt32(chkCategories.Items[i].Value));
            }

        }

    }
    static string itemDescription;
    protected void txtDescription_TextChanged(object sender, EventArgs e)
    {
        itemDescription = txtDescription.Text;
    }


    static List<int> selectedSeasons;
    protected void chkDefaultSeasons_SelectedIndexChanged(object sender, EventArgs e)
    {
        selectedSeasons = new List<int>();
        for (int i = 0; i < chkDefaultSeasons.Items.Count; i++)
        {
            if (chkDefaultSeasons.Items[i].Selected)
            {
                selectedSeasons.Add(Convert.ToInt32(chkDefaultSeasons.Items[i].Value));
            }

        }
    }


    static List<int> selectedHolidays;
    protected void chkDefaultHoliday_SelectedIndexChanged(object sender, EventArgs e)
    {
        selectedHolidays = new List<int>();
        for (int i = 0; i < chkDefaultHoliday.Items.Count; i++)
        {
            if (chkDefaultHoliday.Items[i].Selected)
            {
                selectedHolidays.Add(Convert.ToInt32(chkDefaultHoliday.Items[i].Value));
            }

        }
    }

}
