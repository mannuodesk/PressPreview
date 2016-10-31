﻿using System;
using System.Collections;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;
using System.Collections.Generic;

public partial class pr_brand_add_item : System.Web.UI.Page
    {

    private string[] _loggedInUser;

    protected void Page_Load(object sender, EventArgs e)
        {
            var al = new ArrayList { lblUsername, imgUserIcon };
            Common.UserSettings(al);
            //txtItemTitle.Focus();
            if(!IsPostBack)
            {
                
                chkCategories.DataBind();
                chkDefaultSeasons.DataBind();
                chkDefaultHoliday.DataBind();
                DisplayDefaultCats();
                DisplayDefaultSeasons();
                DisplayDefaultHolidays();
                LoadItem();
                GetCommentsCount();
                ItemLikes();
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

    protected void LoadItem()
    {
        try
        {
            var db = new DatabaseManagement();
            string selectRec =
                string.Format(
                    "SELECT ItemID,ItemKey,Title,Description,RetailPrice,WholesalePrice,FeatureImg,StyleNumber,StyleName,Color, Category,Season,Holiday,Views,Likes From Tbl_Items Where ItemID={0}",
                    IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(selectRec);
            if (dr.HasRows)
            {
                dr.Read();
                txtItemTitle.Value = dr[2].ToString();
                txtDescription.Text = dr[3].ToString();
                txtRetail.Value = dr[4].ToString();
                txtWholesale.Value = dr[5].ToString();
                imgFeatured.ImageUrl = "../photobank/" + dr[6];
                imgFeatured2.ImageUrl = "../photobank/" + dr[6];
                txtStyleNumber.Value = dr[7].ToString();
                txtStyleName.Value = dr[8].ToString();
                colbtn.Style.Add("background", dr[9].ToString());
                lblViews.Text = dr[13].ToString();
                lblTotalLikes.Text = dr.IsDBNull(14) ? "0" : rptHoliday.Items.Count.ToString();
                //chkCategories.Items.FindByText(dr[10].ToString()).Selected = true;
                //chkDefaultSeasons.Items.FindByText(dr[11].ToString()).Selected = true;
                //chkDefaultHoliday.Items.FindByText(dr[12].ToString()).Selected = true;

            }
            dr.Close();
            dr.Dispose();

            LoadCategories(db);
            LoadSeason(db);
            LoadHolidays(db);
            Repeater2.DataBind();


            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    private void LoadCategories(DatabaseManagement db)
    {
        string getcategories = string.Format("SELECT CategoryID From Tbl_ItemsCategory Where ItemID={0}",
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
                itm.Selected = true;
        }
    }

    private void LoadSeason(DatabaseManagement db)
    {
        string get = string.Format("SELECT SeasonID From Tbl_ItemSeasons Where ItemID={0}",
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
                itm.Selected = true;
        }
    }

    private void LoadHolidays(DatabaseManagement db)
    {
        string get = string.Format("SELECT HolidayID From Tbl_ItemHolidays Where ItemID={0}",
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
                itm.Selected = true;
        }
    }

    protected void CreateNewItem()
        {
            try
            {
                var db=new DatabaseManagement();
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
        public static void SetSession(string value)
        {
            var currItem = new HttpCookie("ColorVal") { Value = value };
            HttpContext.Current.Response.Cookies.Add(currItem);
          // HttpContext.Current.Session["ColorVal"] = value;

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

        protected static void DeleteCSH(DatabaseManagement db, int v)
        {
            string deleteCat = string.Format("Delete FROM Tbl_ItemsCategory Where ItemID={0}", v);
            db.ExecuteSQL(deleteCat);

            string deleteSeasons = string.Format("Delete FROM Tbl_ItemSeasons Where ItemID={0}", v);
            db.ExecuteSQL(deleteSeasons);

            string deleteHolidays = string.Format("Delete FROM Tbl_ItemHolidays Where ItemID={0}", v);
            db.ExecuteSQL(deleteHolidays);
        }

        [WebMethod,ScriptMethod]
        public static void SaveItem(string TitleText, string RetailText, string WholesaleText, string StyleNumberText, string StyleNameText,string v)
        {
        
            try
            {
            int x = Convert.ToInt32(v);
                var db=new DatabaseManagement();
                DeleteCSH(db, x);

                 //   string mainimg = db.GetExecuteScalar("SELECT FeatureImg From Tbl_Items Where ItemID=" + IEUtils.ToInt(httpCookie.Value));
                    //if (string.IsNullOrEmpty(mainimg))
                    //{
                    //    ErrorMessage.ShowErrorAlert(lblStatus, "Please upload item's feature image.", divAlerts);
                    //}
                  
                       // string checkItemImages = db.GetExecuteScalar("SELECT Top 1 ImgID From Tbl_ItemImages Where ItemID=" + IEUtils.ToInt(httpCookie.Value));
                        //if(string.IsNullOrEmpty(checkItemImages))
                        //{
                        //    ErrorMessage.ShowErrorAlert(lblStatus, "Please upload atleast one item image.", divAlerts);
                        //}
                   
                            var Colorcookie = HttpContext.Current.Request.Cookies["ColorVal"];
                            var userCookie = HttpContext.Current.Request.Cookies["FrUserID"];
                    if (userCookie != null)
                    {
                        {
                           // string itemKey = Encryption64.Encrypt(httpCookie.Value).Replace('+', '=');
                            if (Colorcookie != null)
                            {
                                string updateQuery = string.Format("UPDATE Tbl_Items Set  " +
                                                                   "Title={0},Description={1},RetailPrice={2}," +
                                                                   "WholesalePrice={3}," +
                                                                   "StyleNumber={4},StyleName={5},Color={6}," +
                                                                   "IsPublished={7}, UserID={8},DatePosted={9}  WHERE ItemID={10} ",
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
                                                                   
                                                                   x);

                                db.ExecuteSQL(updateQuery);
                            }
                        }
                    }

                    foreach (int lstCategory in selectedCategories)
                    {
                            string addItemCategory = string.Format("INSERT INTO Tbl_ItemsCategory(CategoryID,ItemID) VALUES({0},{1})", IEUtils.ToInt(lstCategory), x);
                            db.ExecuteSQL(addItemCategory);
                    }

                // Add Seasons

                foreach (int lstSeason in selectedSeasons)
                {
                   
                    string addItemSeason = string.Format("INSERT INTO Tbl_ItemSeasons(SeasonID,ItemID) VALUES({0},{1})", IEUtils.ToInt(lstSeason), x);
                    db.ExecuteSQL(addItemSeason);
                }

                // Add Holidays

                foreach (int lstholiday in selectedHolidays)
                {
 
                            string additemoreholidays = string.Format("insert into tbl_itemholidays(holidayid,itemid) values({0},{1})", IEUtils.ToInt(lstholiday), x);
                            db.ExecuteSQL(additemoreholidays);
                        
                    
                }
                //txtDescription.Text = "";


                HttpContext.Current.Session["ColorVal"] = "";
                    //         const string cookieName = "CurrentItemId";
                    //        if (HttpContext.Current.Request.Cookies[cookieName] != null)
                    //        {
                    //            var myCookie = new HttpCookie(cookieName) {Expires = DateTime.Now.AddDays(-1d)};
                    //HttpContext.Current.Response.Cookies.Add(myCookie);
                    //        }
                            db._sqlConnection.Close();
                            db._sqlConnection.Dispose();

                            HttpContext.Current.Response.Redirect("profile-page-items.aspx");
                
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
                int itemId = IEUtils.ToInt(Request.QueryString["v"]);
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
            for (int i = 40; i > 19; i--)
            {
                if (chkCategories.Items.Count > i) chkCategories.Items[i].Attributes.Add("style", "display:block;");
               
            }
            
            btn_ViewMore.Visible = false;
            btn_ViewLess.Visible = true;
        }

        private void DisplayDefaultCats()
        {
            for (int i = 40; i > 19; i--)
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
        protected void rptTags_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "1")
                {
                    var db = new DatabaseManagement();
                    db.ExecuteSQL("Delete from Tbl_ItemTags Where TagID=" + IEUtils.ToInt(e.CommandArgument));
                    rptTags.DataBind();
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

        /// <summary>
        /// Remove Item images
        /// </summary>
        /// <param name="source"></param>
        /// <param name="e"></param>
        protected void dlImages_ItemCommand(object source, DataListCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "1")
                {
                    int recordId = Convert.ToInt32(e.CommandArgument);
                    var db = new DatabaseManagement();
                    string deleteQuery = "Delete from Tbl_ItemImages Where ImgID=" + recordId;
                    db.ExecuteSQL(deleteQuery);
                    dlImages.DataBind();
                }

            }
            catch (Exception ex)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {
            try
            {
                DatabaseManagement db = new DatabaseManagement();
                string RemoveFeatureImg = string.Format("Update Tbl_Items Set FeatureImg=NULL Where ItemID={0}",
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
        for(int i = 0; i < chkCategories.Items.Count; i++)
        {
            if(chkCategories.Items[i].Selected)
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

    /*********************************************** Comment Section *****************************************/
    protected void ItemLikes()
    {
        try
        {
            var db = new DatabaseManagement();
            string isAlreadyLiked = string.Format("SELECT ID From Tbl_Item_Likes Where UserID={0} AND ItemID={1}",
                                       IEUtils.ToInt(Session["UserID"]),
                                       IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(isAlreadyLiked);
            lbtnLike.Enabled = !dr.HasRows;
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }

    }
    protected void GetLoggedInUserInfo()
    {
        var db = new DatabaseManagement();
        _loggedInUser = new string[2];
        var userCookie = Request.Cookies["FrUserID"];
        if (userCookie != null)
        {
            String selectQuery =
                string.Format(
                    "SELECT UserKey, U_Firstname + ' ' + U_Lastname as Name from Tbl_Users Where UserID={0}",
                    IEUtils.ToInt(userCookie.Value));
            SqlDataReader dr = db.ExecuteReader(selectQuery);
            if (dr.HasRows)
            {
                dr.Read();
                _loggedInUser[0] = dr[0].ToString();
                _loggedInUser[1] = dr[1].ToString();
            }
        }
    }
    protected void btnAddPost_OnServerClick(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
            var userCookie = Request.Cookies["FrUserID"];
            if (userCookie != null)
            {
                string addPost =
                    string.Format("INSERT INTO Tbl_Posts(Message,UserID,DatePosted,ItemID,BrandID) VALUES({0},{1},{2},{3},{4})",
                                  IEUtils.SafeSQLString(txtComment.Value),
                                  IEUtils.ToInt(userCookie.Value),
                                  "'" + DateTime.UtcNow + "'",
                                  IEUtils.ToInt(Request.QueryString["v"]),
                                  IEUtils.ToInt(userCookie.Value));
                db.ExecuteSQL(addPost);

                int notifyID = db.GetMaxID("NotifyID", "Tbl_Notifications");
                string username = Session["Username"].ToString();
                string itemid = Request.QueryString["v"];
                string notificationTitle = "<a href='profile-page-items.aspx'>" + _loggedInUser[1] + "</a> commented on your item <a href='itemview1.aspx?v=" + IEUtils.ToInt(Request.QueryString["v"]) + "' class='fancybox'>" + txtItemTitle.Value + "</a>";
                string addNotification =
                         string.Format("INSERT INTO Tbl_Notifications(UserID,Title,DatePosted,ItemID) VALUES({0},{1},{2},{3})",

                                       IEUtils.ToInt(Session["UserID"]),
                                       IEUtils.SafeSQLString(notificationTitle),
                                       IEUtils.SafeSQLDate(DateTime.UtcNow),
                                       IEUtils.ToInt(Request.QueryString["v"])

                             );

                db.ExecuteSQL(addNotification);

                string
                    updateQuery =
                     string.Format("INSERT INTO Tbl_NotifyFor(NotifyID,RecipID) VALUES({0},{1})",
                                  IEUtils.ToInt(notifyID),
                                   IEUtils.ToInt(IEUtils.ToInt(userCookie.Value))

                         );

                db.ExecuteSQL(updateQuery);
                string
                     updateQuery1 =
                      string.Format("INSERT INTO Tbl_NotifyFor(NotifyID,RecipID) VALUES({0},{1})",
                                   IEUtils.ToInt(notifyID),
                                   1

                          );

                db.ExecuteSQL(updateQuery1);
            }

            GetCommentsCount();
            txtComment.Value = "";
            rptPosts.DataSource = sdsPosts;
            rptPosts.DataBind();
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void rptPosts_OnItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var rptComments = (Repeater)e.Item.FindControl("rptComments");

                int postId = Convert.ToInt32(((Label)e.Item.FindControl("lblPostID")).Text);
                string getPostComments =
                    string.Format(
                        "SELECT Tbl_Comments.Message, Tbl_Comments.DatePosted, U_Firstname + '  ' + U_Lastname as Username, Tbl_Users.U_ProfilePic, Tbl_Comments.PostId,CommentId  FROM Tbl_Users INNER JOIN Tbl_Comments ON Tbl_Comments.UserID=Tbl_Users.UserID WHERE (Tbl_Comments.PostId = {0})",
                        postId);
                sdsComments.SelectCommand = getPostComments;
                rptComments.DataSourceID = "";
                rptComments.DataSource = sdsComments;
                rptComments.DataBind();
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void GetCommentsCount()
    {
        var db = new DatabaseManagement();
        lblPostCount.Text =
               db.GetExecuteScalar(string.Format("Select COUNT(PostId) From Tbl_Posts Where ItemID={0}",
                                               IEUtils.ToInt(Request.QueryString["v"])));
        db._sqlConnection.Close();
        db._sqlConnection.Dispose();
    }
    protected void rptPosts_OnItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
            var userCookie = Request.Cookies["FrUserID"];
            int postId = IEUtils.ToInt(e.CommandArgument);
            if (e.CommandName == "1")
            {

                var txtReply = (TextBox)e.Item.FindControl("txtReply");
                if (userCookie != null)
                {
                    string addComment = string.Format("INSERT INTO Tbl_Comments(PostId,Message,UserID,DatePosted,BrandID) Values({0},{1},{2},{3},{4})",
                                                      postId,
                                                      IEUtils.SafeSQLString(txtReply.Text),
                                                      IEUtils.ToInt(userCookie.Value),
                    "'" + DateTime.UtcNow + "'",
                    IEUtils.ToInt(_loggedInUser[0]));
                    db.ExecuteSQL(addComment);
                }
                rptPosts.DataBind();
                txtReply.Text = "";
            }
            else if (e.CommandName == "3")
            {
                string deleteComment = string.Format("Delete From Tbl_Posts Where PostId={0}", postId);
                db.ExecuteSQL(deleteComment);
                rptPosts.DataBind();
                GetCommentsCount();
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void rptComments_OnItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
            int commentId = IEUtils.ToInt(e.CommandArgument);
            if (e.CommandName == "4")
            {
                string deleteComment = string.Format("Delete From Tbl_Comments Where CommentId={0}", commentId);
                db.ExecuteSQL(deleteComment);
                rptPosts.DataBind();

            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    /*********************************************** End Comment Section ************************************/
}
