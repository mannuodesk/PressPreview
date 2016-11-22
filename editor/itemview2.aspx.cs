using System;
using System.Data.SqlClient;
using System.Globalization;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;
using System.Drawing;

public partial class lightbox_item_view : Page
{
    private int itemID;
    private int _receiverID = 0;
    private static string[] _loggedInUser;
    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {
            getSlug();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    public string getSlug()
    {
        string itemid = string.Empty;
        itemid = Request.QueryString["v"];
        Session["ItemID"] = itemid;
        return itemid;
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Label200.Attributes.Add("onchange", "ChangeColor()");
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
            if (!IsPostBack)
            {
                GetLoggedInUserInfo();
                LoadItemData();
                LoadBrandProfileImage();
                SetTotalViews();
                ItemLikes();
                GetCommentsCount();
                //  hidField.Value = itemID.ToString();
            }

            WishlistButtonStatus(IEUtils.ToInt(Request.QueryString["v"]), IEUtils.ToInt(Session["UserID"]));
            rptTags.DataBind();
            dvTagToggles.Visible = rptTags.Items.Count > 20;
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void LoadBrandProfileImage()
    {
        try
        {
            var db = new DatabaseManagement();
            string userDp = string.Format("SELECT U_ProfilePic, UserKey   From Tbl_Users Where UserID=(SELECT UserID From Tbl_Items Where ItemID={0})",
                                          IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(userDp);
            if (dr.HasRows)
            {
                dr.Read();
                imgProfile.ImageUrl = "../brandslogoThumb/" + dr[0];
                
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void LoadItemData()
    {
        try
        {
            var db = new DatabaseManagement();
            string itemRecord =
                string.Format(
                    "SELECT ItemID,Title,Description,RetailPrice,WholesalePrice,StyleNumber,StyleName,Color,Tbl_Items.Views,Tbl_Items.DatePosted,Tbl_Items.UserID,  U_Firstname + ' ' + U_Lastname as Name, Likes  From Tbl_Items INNER JOIN Tbl_Users ON Tbl_Items.UserID=Tbl_Users.UserID  Where ItemID={0} AND IsPublished=1 AND IsDeleted IS NULL",
                    IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(itemRecord);
            if (dr.HasRows)
            {
                dr.Read();
                lblItemID.Text = dr[0].ToString();
                Session["ItemdID"] = dr[0].ToString();
                lblItemTitle.Text = dr[1].ToString();
                lblDescription.Text = dr[2].ToString();
                lblRetailPrice.Text = dr[3].ToString();
                lblWholesalePrice.Text = dr[4].ToString();
                lblStyleNumber.Text = dr[5].ToString();
                lblStyleName.Text = dr[6].ToString();
                lblTotolViews.Text = dr.IsDBNull(8) ? "0" : (Convert.ToInt32(dr[8])).ToString();
                lblUserID.Text = dr[10].ToString();
                _receiverID = Convert.ToInt32(dr[10]);
                rptHoliday.DataBind();
                lblTotalLikes.Text = dr.IsDBNull(12) ? "0" : rptHoliday.Items.Count.ToString();
                //  lblBrandName.Text = dr[11].ToString();

            }

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
                    "SELECT UserKey, U_Firstname + ' ' + U_Lastname as Name, U_ProfilePic from Tbl_Users Where UserID={0}",
                    IEUtils.ToInt(userCookie.Value));
            SqlDataReader dr = db.ExecuteReader(selectQuery);
            if (dr.HasRows)
            {
                dr.Read();
                _loggedInUser[0] = dr[0].ToString();
                _loggedInUser[1] = dr[1].ToString();
                imgProfile2.ImageUrl = "../brandslogoThumb/" + dr[2];
            }
        }
    }
    protected void SetTotalViews()
    {
        try
        {
            var db = new DatabaseManagement();
            string isAlreadyViewd = string.Format("SELECT ID From Tbl_Item_Views Where UserID={0} AND ItemID={1}",
                                                  IEUtils.ToInt(Session["UserID"]),
                                                  IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(isAlreadyViewd);
            if (!dr.HasRows)
            {
                dr.Close();
                dr.Dispose();
                string addview = string.Format("INSERT INTO Tbl_Item_Views(ItemID,UserID,ViewDate) VALUES({0},{1},{2})",
                    IEUtils.ToInt(Request.QueryString["v"]),
                    IEUtils.ToInt(Session["UserID"]),
                    IEUtils.SafeSQLDate(DateTime.UtcNow));
                db.ExecuteSQL(addview);
                int totalViews = Convert.ToInt32(lblTotolViews.Text) + 1;
                string qryViews = string.Format("UPDATE Tbl_Items Set Views={0}  Where ItemID={1}", totalViews, IEUtils.ToInt(Request.QueryString["v"]));
                db.ExecuteSQL(qryViews);

            }

            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void ItemLikes()
    {
        try
        {
            var db = new DatabaseManagement();
            string isAlreadyLiked = string.Format("SELECT ID From Tbl_Item_Likes Where UserID={0} AND ItemID={1}",
                                       IEUtils.ToInt(Session["UserID"]),
                                       IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(isAlreadyLiked);
            if(dr != null && dr.HasRows)
            {
                LikesLabel.ForeColor = System.Drawing.ColorTranslator.FromHtml("#4c92c6");
                round.Style.Add("color", "#4c92c6");
                round.Style.Add("border", "#4c92c6 solid 2px");
                bracket1.ForeColor = System.Drawing.ColorTranslator.FromHtml("#4c92c6");
                bracket2.ForeColor = System.Drawing.ColorTranslator.FromHtml("#4c92c6");
                lblTotalLikes.ForeColor = System.Drawing.ColorTranslator.FromHtml("#4c92c6"); 
                
            }   
            else
            {
                LikesLabel.ForeColor = Color.Black;
                round.Style.Add("color", "#000");
                round.Style.Add("border", "#000 solid 2px");

                bracket1.ForeColor = Color.Black;
                bracket2.ForeColor = Color.Black;
                lblTotalLikes.ForeColor = Color.Black;
            }
            //lbtnLike.Enabled = !dr.HasRows;

            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }

    }

    protected void lbtnLike_Click(object sender, EventArgs e)
    {
        try
        {
            string selectQuery = string.Format("Select * from Tbl_Item_Likes Where ItemID={0} AND UserID={1} AND BrandID={2}", IEUtils.ToInt(Request.QueryString["v"]), IEUtils.ToInt(Session["UserID"]), IEUtils.ToInt(lblUserID.Text));
            var db = new DatabaseManagement();
            SqlDataReader dr = db.ExecuteReader(selectQuery);
            if (dr != null && dr.HasRows)
            {
                Color color = new Color();
                LikesLabel.ForeColor = Color.Black;
                round.Style.Add("color", "#000");
                round.Style.Add("border", "#000 solid 2px");

                bracket1.ForeColor = Color.Black;
                bracket2.ForeColor = Color.Black;
                lblTotalLikes.ForeColor = Color.Black;
                //lbtnLike.Style.Remove("color");
                //lbtnLike.Style.Add("color", "#000");
                //lbtnLike.CssClass = "mnLikes unliked";
                string deleteQuery = string.Format("DELETE from Tbl_Item_Likes Where ItemID={0} AND UserID={1} AND BrandID={2}", IEUtils.ToInt(Request.QueryString["v"]), IEUtils.ToInt(Session["UserID"]), IEUtils.ToInt(lblUserID.Text));
                db._sqlConnection.Close();
                db._sqlConnection.Dispose();
                db = new DatabaseManagement();
                db.ExecuteSQL(deleteQuery);
                if (lblTotalLikes.Text == "")
                    lblTotalLikes.Text = "0";
                else
                    lblTotalLikes.Text = (Convert.ToInt32(lblTotalLikes.Text) - 1).ToString();
                int TotalLikesRemaining = Convert.ToInt32(lblTotalLikes.Text);
                string queryLikes = string.Format("UPDATE Tbl_Items Set Likes={0}  Where ItemID={1}", TotalLikesRemaining, IEUtils.ToInt(Request.QueryString["v"]));
                db._sqlConnection.Close();
                db._sqlConnection.Dispose();
                db = new DatabaseManagement();
                db.ExecuteSQL(queryLikes);
                rptHoliday.DataBind();
                //lbtnLike.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                LikesLabel.ForeColor = System.Drawing.ColorTranslator.FromHtml("#4c92c6"); 
                round.Style.Add("color", "#4c92c6");
                round.Style.Add("border", "#4c92c6 solid 2px");
                bracket1.ForeColor = System.Drawing.ColorTranslator.FromHtml("#4c92c6"); 
                bracket2.ForeColor = System.Drawing.ColorTranslator.FromHtml("#4c92c6"); 
                lblTotalLikes.ForeColor = System.Drawing.ColorTranslator.FromHtml("#4c92c6"); 
                //lbtnLike.Style.Remove("color");
                //lbtnLike.Style.Add("color", "#FFF");
                
                //lbtnLike.CssClass = "mnLikes liked";
                //lbtnLike.ForeColor = color;
                string qryAddLike = string.Format("INSERT INTO Tbl_Item_Likes(ItemID,UserID,BrandID) VALUES({0},{1},{2})", IEUtils.ToInt(Request.QueryString["v"]), IEUtils.ToInt(Session["UserID"]), IEUtils.ToInt(lblUserID.Text));
                db._sqlConnection.Close();
                db._sqlConnection.Dispose();
                db = new DatabaseManagement();
                db.ExecuteSQL(qryAddLike);
                if (lblTotalLikes.Text == "")
                    lblTotalLikes.Text = "0";
                lblTotalLikes.Text = (Convert.ToInt32(lblTotalLikes.Text) + 1).ToString();

                int TotalLikes = Convert.ToInt32(lblTotalLikes.Text);
                db._sqlConnection.Close();
                db._sqlConnection.Dispose();
                db = new DatabaseManagement();
                string qryLikes = string.Format("UPDATE Tbl_Items Set Likes={0}  Where ItemID={1}", TotalLikes, IEUtils.ToInt(Request.QueryString["v"]));
                db.ExecuteSQL(qryLikes);
                rptHoliday.DataBind();
                int notifyID = db.GetMaxID("NotifyID", "Tbl_Notifications");
                string notificationTitle = "<a href='influencer-profile.aspx?v=" + _loggedInUser[0] + "' >" + _loggedInUser[1] +
                                           "</a> likes your item  <a href='itemview1.aspx?v=" + IEUtils.ToInt(lblItemID.Text) + "' class='fancybox'>" + lblItemTitle.Text + "</a>";
                string addNotification =
                         string.Format("INSERT INTO Tbl_Notifications(UserID,Title,DatePosted,ItemID) VALUES({0},{1},{2},{3})",

                                       IEUtils.ToInt(Session["UserID"]),
                                       IEUtils.SafeSQLString(notificationTitle),
                                       IEUtils.SafeSQLDate(DateTime.UtcNow),
                                       IEUtils.ToInt(lblItemID.Text)

                             );
                db._sqlConnection.Close();
                db._sqlConnection.Dispose();
                db = new DatabaseManagement();
                db.ExecuteSQL(addNotification);

                string
                    updateQuery =
                     string.Format("INSERT INTO Tbl_NotifyFor(NotifyID,RecipID) VALUES({0},{1})",
                                  IEUtils.ToInt(notifyID),
                                   IEUtils.ToInt(lblUserID.Text)

                         );
                db._sqlConnection.Close();
                db._sqlConnection.Dispose();
                db = new DatabaseManagement();
                db.ExecuteSQL(updateQuery);
                string
                     updateQuery1 =
                      string.Format("INSERT INTO Tbl_NotifyFor(NotifyID,RecipID) VALUES({0},{1})",
                                   IEUtils.ToInt(notifyID),
                                   1

                          );
                db._sqlConnection.Close();
                db._sqlConnection.Dispose();
                db = new DatabaseManagement();
                db.ExecuteSQL(updateQuery1);
                //lbtnLike.ForeColor = System.Drawing.Color.Black;
            }

            ItemLikes();
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
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
    [WebMethod, ScriptMethod]
    public static void AddToWishList(int v, int userid)
    {
        try
        {
            var db = new DatabaseManagement();
            //if (!WishlistButtonStatus())
            //{
            string addToWishList = string.Format("INSERT INTO Tbl_WishList(ItemID,UserID,DatePosted) VALUES({0},{1},{2})", v, userid, "'" + DateTime.UtcNow + "'");
            db.ExecuteSQL(addToWishList);
            //  ErrorMessage.ShowSuccessAlert(lblStatus, "This item has been added to your wish list.", divAlerts);
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
            //}
            //else
            //{
            //    ErrorMessage.ShowErrorAlert(lblStatus, "This item is already in your wish list.", divAlerts);
            //}

            // WishlistButtonStatus(userid);
        }
        catch (Exception ex)
        {
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void WishlistButtonStatus(int v, int userId)
    {
        try
        {
            var db = new DatabaseManagement();
            // bool IsExist;
            string isAlreadyAdded = "SELECT WishID From Tbl_WishList Where UserID=" + userId + " AND ItemID=" + v;
            SqlDataReader dr = db.ExecuteReader(isAlreadyAdded);
            if (!dr.HasRows)
            {
                dvlbtnWishlist.Visible = true;
                dvlbwishlist.Visible = false;
            }
            else
            {
                dvlbtnWishlist.Visible = false;
                dvlbwishlist.Visible = true;
            }
            //lbtnWishList.Enabled=!dr.HasRows;

            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
            // return IsExist;
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            // return false;
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
                                  IEUtils.ToInt(lblUserID.Text));
                db.ExecuteSQL(addPost);

                int notifyID = db.GetMaxID("NotifyID", "Tbl_Notifications");
                string username = Session["Username"].ToString();
                string itemid = Request.QueryString["v"];
                string notificationTitle = "<a href='influencer-profile.aspx?v=" + _loggedInUser[0] + "' >" + _loggedInUser[1] + "</a> commented on your item <a href='itemview1.aspx?v=" + IEUtils.ToInt(lblItemID.Text) + "' class='fancybox'>" + lblItemTitle.Text + "</a>";
                string addNotification =
                         string.Format("INSERT INTO Tbl_Notifications(UserID,Title,DatePosted,ItemID) VALUES({0},{1},{2},{3})",

                                       IEUtils.ToInt(Session["UserID"]),
                                       IEUtils.SafeSQLString(notificationTitle),
                                       IEUtils.SafeSQLDate(DateTime.UtcNow),
                                       IEUtils.ToInt(lblItemID.Text)

                             );

                db.ExecuteSQL(addNotification);

                string
                    updateQuery =
                     string.Format("INSERT INTO Tbl_NotifyFor(NotifyID,RecipID) VALUES({0},{1})",
                                  IEUtils.ToInt(notifyID),
                                   IEUtils.ToInt(lblUserID.Text)

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
            ItemLikes();
            txtComment.Value = "";
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
                        "SELECT Tbl_Comments.Message, Tbl_Comments.DatePosted, U_Firstname + '  ' + U_Lastname as Username, Tbl_Users.U_ProfilePic, Tbl_Comments.PostId, CommentId, Tbl_Comments.UserID  FROM Tbl_Users INNER JOIN Tbl_Comments ON Tbl_Comments.UserID=Tbl_Users.UserID WHERE (Tbl_Comments.PostId = {0})",
                        postId);
                sdsComments.SelectCommand = getPostComments;
                rptComments.DataSourceID = "";
                rptComments.DataSource = sdsComments;
                rptComments.DataBind();

                var userId = Convert.ToInt32(((Label)e.Item.FindControl("lblUserID")).Text);
                var userCookie = HttpContext.Current.Request.Cookies["FrUserID"];
                var spDelmenuP = (HtmlGenericControl)e.Item.FindControl("spDelmenuP");
                // var spDelmenuC = (HtmlGenericControl)e.Item.FindControl("spDelmenuC");
                if (userCookie != null)
                {
                    spDelmenuP.Visible = userId.ToString() == userCookie.Value;
                    //spDelmenuC.Visible = userId.ToString() == userCookie.Value;
                }

            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
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
                    IEUtils.ToInt(lblUserID.Text));
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
            var userCookie = Request.Cookies["FrUserID"];
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

    protected void lbtnMassenger_Click(object sender, EventArgs e)
    {
        //var usernameCookie = HttpContext.Current.Request.Cookies["Username"];
        //if (usernameCookie != null) Response.Redirect("../editor/compose.aspx?v=" + usernameCookie.Value);
    }

    protected static string[] GetRecipientID(DatabaseManagement db, string username)
    {
        var userinfo = new string[3];
        SqlDataReader dr =
            db.ExecuteReader(string.Format("Select UserID, U_Firstname + ' ' + U_Lastname as Name,U_Username  From Tbl_Users Where U_Username={0}",
                                           IEUtils.SafeSQLString(username)));
        if (dr.HasRows)
        {
            dr.Read();
            userinfo[0] = dr[0].ToString();
            userinfo[1] = dr[1].ToString();
            userinfo[2] = dr[2].ToString();
        }
        dr.Close();
        dr.Dispose();
        return userinfo;
    }
    protected static string[] GetReceiverBrandName(DatabaseManagement db, int v)
    {
        string getBrandName =
            string.Format(
                "SELECT U_Username,U_Firstname + ' ' + U_Lastname as Name  From Tbl_Users Where UserID=(SELECT UserID From Tbl_Items Where ItemID={0})", v);
        var brandname = new string[2];
        SqlDataReader dr = db.ExecuteReader(getBrandName);
        if (dr.HasRows)
        {
            dr.Read();
            brandname[0] = dr[0].ToString();
            brandname[1] = dr[1].ToString();
        }
        dr.Close();
        dr.Dispose();
        return brandname;
    }
    [WebMethod, ScriptMethod]
    public static void PostGiftRequest(string message, int v)
    {
        var userCookie = HttpContext.Current.Request.Cookies["FrUserID"];
        var userNameCookie = HttpContext.Current.Request.Cookies["Username"];
        var db = new DatabaseManagement();
        if (userNameCookie != null)
        {
            string[] userInfo = GetRecipientID(db, GetReceiverBrandName(db, v)[0]);
            if (userCookie != null)
            {
                // Check if the brand already exists in the brand message list or not
                int parentId = 0;
                StringBuilder sb = new StringBuilder();
                sb.AppendFormat("<b>( GIFT Request )</b><br />");
                sb.Append(message);
                string checkBrand = string.Format(
                    "SELECT UserID  From Tbl_Users Where U_Username={0}  AND U_Type='Brand' AND UserID IN (SELECT ReceiverID From Tbl_MailboxMaster Where ReceiverID={1} AND BlockStatus IS NULL)",
                    IEUtils.SafeSQLString(GetReceiverBrandName(db, v)[0]),
                    IEUtils.ToInt(userInfo[0]));
                if (db.RecordExist(checkBrand))  // if Brand already record exist, then brand can send message to that influencer. other wise not
                {

                    int receiverId = Convert.ToInt32(db.GetExecuteScalar(checkBrand));
                    string getParentId =
                        string.Format(
                            "SELECT ParentID FROM Tbl_MailboxMaster Where ReceiverID={0} AND SenderID={1} AND BlockStatus IS NULL",
                            receiverId, IEUtils.ToInt(userCookie.Value));
                    SqlDataReader dr = db.ExecuteReader(getParentId);
                    if (dr.HasRows)
                    {
                        dr.Read();
                        parentId = IEUtils.ToInt(dr[0]);
                    }
                    dr.Close();
                    dr.Dispose();
                    PostMessage(userInfo, parentId, userCookie, db, sb.ToString(), v);
                    //
                    //    ErrorMessage.ShowSuccessAlert(lblStatus, "Message sent successfuly!", divAlerts);
                }
                else
                {
                    // int parentID = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(ParentID) From Tbl_MailboxMaster"));
                    string addMailboxMasterRecord =
                        string.Format(
                            "INSERT INTO Tbl_MailboxMaster(SenderID,ReceiverID,SenderName,ReceiverName) VALUES({0},{1},{2},{3})",
                            IEUtils.ToInt(userCookie.Value),
                            IEUtils.ToInt(userInfo[0]),
                            IEUtils.SafeSQLString(userNameCookie.Value),
                            IEUtils.SafeSQLString(userInfo[1])
                            );
                    db.ExecuteSQL(addMailboxMasterRecord);
                    parentId = Convert.ToInt32(db.GetExecuteScalar("SELECT ISNULL(MAX(ParentID),1) From Tbl_MailboxMaster"));
                    PostMessage(userInfo, parentId, userCookie, db, sb.ToString(), v);


                }

            }
        }
        // txtGift.Value = string.Empty;
        // ErrorMessage.ShowSuccessAlert(lblStatus, "Message sent successfuly!", divAlerts);


    }

    [WebMethod, ScriptMethod]
    public static void PostSampleRequest(string message, int v)
    {
        var userCookie = HttpContext.Current.Request.Cookies["FrUserID"];
        var userNameCookie = HttpContext.Current.Request.Cookies["Username"];
        var db = new DatabaseManagement();
        if (userNameCookie != null)
        {
            string[] userInfo = GetRecipientID(db, GetReceiverBrandName(db, v)[0]);
            if (userCookie != null)
            {
                // Check if the brand already exists in the brand message list or not
                int parentId = 0;
                StringBuilder sb = new StringBuilder();
                sb.AppendFormat("<b>( SAMPLE Request )</b><br />");
                sb.Append(message);
                string checkBrand = string.Format(
                    "SELECT UserID  From Tbl_Users Where U_Username={0}  AND U_Type='Brand' AND UserID IN (SELECT ReceiverID From Tbl_MailboxMaster Where ReceiverID={1} AND BlockStatus IS NULL)",
                    IEUtils.SafeSQLString(GetReceiverBrandName(db, v)[0]),
                    IEUtils.ToInt(userInfo[0]));
                if (db.RecordExist(checkBrand))  // if Brand already record exist, then brand can send message to that influencer. other wise not
                {

                    int receiverId = Convert.ToInt32(db.GetExecuteScalar(checkBrand));
                    string getParentId =
                        string.Format(
                            "SELECT ParentID FROM Tbl_MailboxMaster Where ReceiverID={0} AND SenderID={1} AND BlockStatus IS NULL",
                            receiverId, IEUtils.ToInt(userCookie.Value));
                    SqlDataReader dr = db.ExecuteReader(getParentId);
                    if (dr.HasRows)
                    {
                        dr.Read();
                        parentId = IEUtils.ToInt(dr[0]);
                    }
                    dr.Close();
                    dr.Dispose();
                    PostMessage(userInfo, parentId, userCookie, db, sb.ToString(), v);
                    //
                    //    ErrorMessage.ShowSuccessAlert(lblStatus, "Message sent successfuly!", divAlerts);
                }
                else
                {
                    // int parentID = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(ParentID) From Tbl_MailboxMaster"));
                    string addMailboxMasterRecord =
                        string.Format(
                            "INSERT INTO Tbl_MailboxMaster(SenderID,ReceiverID,SenderName,ReceiverName) VALUES({0},{1},{2},{3})",
                            IEUtils.ToInt(userCookie.Value),
                            IEUtils.ToInt(userInfo[0]),
                            IEUtils.SafeSQLString(userNameCookie.Value),
                            IEUtils.SafeSQLString(userInfo[1])
                            );
                    db.ExecuteSQL(addMailboxMasterRecord);
                    parentId = Convert.ToInt32(db.GetExecuteScalar("SELECT ISNULL(MAX(ParentID),1) From Tbl_MailboxMaster"));
                    PostMessage(userInfo, parentId, userCookie, db, sb.ToString(), v);


                }

            }
        }
        // txtGift.Value = string.Empty;
        // ErrorMessage.ShowSuccessAlert(lblStatus, "Message sent successfuly!", divAlerts);


    }
    //protected void btnGetGift_OnClick(object sender, EventArgs e)
    //{
    //    try
    //    {
    //       // 
    //       // 
    //        var userCookie = Request.Cookies["FrUserID"];
    //        var userNameCookie = Request.Cookies["Username"];
    //        var db = new DatabaseManagement();
    //        if (userNameCookie != null)
    //        {
    //            string[] userInfo = GetRecipientID(db, GetReceiverBrandName(db)[0]);
    //            if (userCookie != null)
    //            {
    //                // Check if the brand already exists in the brand message list or not
    //                int parentId = 0;
    //                StringBuilder sb = new StringBuilder();
    //                sb.AppendFormat("<b>[GIFT Request]</b><br />");
    //                sb.Append(txtGift.Value);
    //                string checkBrand = string.Format(
    //                    "SELECT UserID  From Tbl_Users Where U_Username={0}  AND U_Type='Brand' AND UserID IN (SELECT ReceiverID From Tbl_MailboxMaster Where SenderID={1} AND BlockStatus IS NULL)",
    //                    IEUtils.SafeSQLString(GetReceiverBrandName(db)[0]),
    //                    IEUtils.ToInt(userCookie.Value));
    //                if (db.RecordExist(checkBrand))  // if Brand already record exist, then brand can send message to that influencer. other wise not
    //                {

    //                    int receiverId = Convert.ToInt32(db.GetExecuteScalar(checkBrand));
    //                    string getParentId =
    //                        string.Format(
    //                            "SELECT ParentID FROM Tbl_MailboxMaster Where ReceiverID={0} AND SenderID={1} AND BlockStatus IS NULL",
    //                            receiverId, IEUtils.ToInt(userCookie.Value));
    //                    SqlDataReader dr = db.ExecuteReader(getParentId);
    //                    if (dr.HasRows)
    //                    {
    //                        dr.Read();
    //                        parentId = IEUtils.ToInt(dr[0]);
    //                    }
    //                    dr.Close();
    //                    dr.Dispose();
    //                    PostMessage(userInfo, parentId, userCookie, db, sb.ToString());
    //                    //
    //                    //    ErrorMessage.ShowSuccessAlert(lblStatus, "Message sent successfuly!", divAlerts);
    //                }
    //                else
    //                {
    //                   // int parentID = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(ParentID) From Tbl_MailboxMaster"));
    //                    string addMailboxMasterRecord =
    //                        string.Format(
    //                            "INSERT INTO Tbl_MailboxMaster(SenderID,ReceiverID,SenderName,ReceiverName) VALUES({0},{1},{2},{3})",
    //                            IEUtils.ToInt(userCookie.Value),
    //                            IEUtils.ToInt(userInfo[0]),
    //                            IEUtils.SafeSQLString(userNameCookie.Value),
    //                            IEUtils.SafeSQLString(userInfo[1])
    //                            );
    //                    db.ExecuteSQL(addMailboxMasterRecord);
    //                    parentId = Convert.ToInt32(db.GetExecuteScalar("SELECT ISNULL(MAX(ParentID),1) From Tbl_MailboxMaster"));
    //                    PostMessage(userInfo, parentId, userCookie, db, sb.ToString());


    //                }

    //            }
    //        }
    //        txtGift.Value = string.Empty;
    //        ErrorMessage.ShowSuccessAlert(lblStatus, "Message sent successfuly!", divAlerts);


    //    }
    //    catch (Exception ex)
    //    {
    //        ErrorMessage.ShowErrorAlert(lblStatus, ex.InnerException.Message, divAlerts);
    //    }
    //}
    private static void PostMessage(string[] userInfo, int parentId, HttpCookie userCookie, DatabaseManagement db, string message, int v)
    {
        // int messageID = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(MessageID) From Tbl_Mailbox"));
        string messageKey = "";

        string postMessage =
            string.Format(
                "INSERT INTO Tbl_Mailbox(MKey,Message,DatePosted,ParentID,MessageStatus,UserID,ItemID) VALUES({0},{1},{2},{3},{4},{5},{6})",
                IEUtils.SafeSQLString(messageKey),
                IEUtils.SafeSQLString(message),
                "'" + DateTime.UtcNow + "'",
                parentId,
                IEUtils.SafeSQLString("unread"),
                IEUtils.ToInt(userCookie.Value),
               v
                );
        db.ExecuteSQL(postMessage);
        int messageID = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(MessageID) From Tbl_Mailbox"));
        messageKey = Encryption64.Encrypt(messageID.ToString(CultureInfo.InvariantCulture)).Replace('+', '=');
        string updateMessageKey = string.Format("Update Tbl_Mailbox Set MKey={0} WHERE MessageID={1}",
                                                IEUtils.SafeSQLString(messageKey), messageID);
        db.ExecuteSQL(updateMessageKey);
        // Add Record For Admin
        string addQuery =
            string.Format("INSERT INTO Tbl_MailboxFor(MessageID,ReceiverID) VALUES({0},{1})",
                          messageID,
                          1);

        db.ExecuteSQL(addQuery);
        // Add Record For Recipient Notification
        string addQuery2 =
            string.Format("INSERT INTO Tbl_MailboxFor(MessageID,ReceiverID) VALUES({0},{1})",
                          messageID,
                          userInfo[0]);

        db.ExecuteSQL(addQuery2);



    }

    //protected static void btnRequestSample_OnClick(object sender, EventArgs e)
    //{
    //    //try
    //    //{
    //    //    var userCookie = HttpContext.Current.Request.Cookies["FrUserID"];
    //    //    var userNameCookie = HttpContext.Current.Request.Cookies["Username"];
    //    //    var db = new DatabaseManagement();
    //    //    if (userNameCookie != null)
    //    //    {
    //    //        string[] userInfo = GetRecipientID(db, GetReceiverBrandName(db)[0]);
    //    //        if (userCookie != null)
    //    //        {
    //    //            int parentId = 0;
    //    //            StringBuilder sb = new StringBuilder();
    //    //            sb.AppendFormat("<b>[SAMPLE Request]</b><br />");
    //    //            sb.Append("");
    //    //            // Check if the brand already exists in the brand message list or not
    //    //            string checkBrand = string.Format(
    //    //                "SELECT UserID  From Tbl_Users Where U_Username={0}  AND U_Type='Brand' AND UserID IN (SELECT ReceiverID From Tbl_MailboxMaster Where SenderID={1} AND BlockStatus IS NULL)",
    //    //                IEUtils.SafeSQLString(GetReceiverBrandName(db)[0]),
    //    //                IEUtils.ToInt(userCookie.Value));
    //    //            if (db.RecordExist(checkBrand))  // if Brand already record exist, then brand can send message to that influencer. other wise not
    //    //            {

    //    //                int receiverId = Convert.ToInt32(db.GetExecuteScalar(checkBrand));
    //    //                string getParentId =
    //    //                    string.Format(
    //    //                        "SELECT ParentID FROM Tbl_MailboxMaster Where ReceiverID={0} AND SenderID={1} AND BlockStatus IS NULL",
    //    //                        receiverId, IEUtils.ToInt(userCookie.Value));
    //    //                SqlDataReader dr = db.ExecuteReader(getParentId);
    //    //                if (dr.HasRows)
    //    //                {
    //    //                    dr.Read();
    //    //                    parentId = IEUtils.ToInt(dr[0]);
    //    //                }
    //    //                dr.Close();
    //    //                dr.Dispose();
    //    //                PostMessage(userInfo, parentId, userCookie, db,sb.ToString());
    //    //                //
    //    //                //    ErrorMessage.ShowSuccessAlert(lblStatus, "Message sent successfuly!", divAlerts);
    //    //            }
    //    //            else
    //    //            {
    //    //               // int parentID = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(ParentID) From Tbl_MailboxMaster"));
    //    //                string addMailboxMasterRecord =
    //    //                    string.Format(
    //    //                        "INSERT INTO Tbl_MailboxMaster(SenderID,ReceiverID,SenderName,ReceiverName) VALUES({0},{1},{2},{3})",
    //    //                        IEUtils.ToInt(userCookie.Value),
    //    //                        IEUtils.ToInt(userInfo[0]),
    //    //                        IEUtils.SafeSQLString(userNameCookie.Value),
    //    //                        IEUtils.SafeSQLString(userInfo[1])
    //    //                        );
    //    //                db.ExecuteSQL(addMailboxMasterRecord);
    //    //                parentId = Convert.ToInt32(db.GetExecuteScalar("SELECT ISNULL(MAX(ParentID),1) From Tbl_MailboxMaster"));
    //    //                PostMessage(userInfo, parentId, userCookie, db, sb.ToString());
    //    //            }

    //    //        }
    //    //    }
    //    //    //txtSample.Value = string.Empty;
    //    //    //req1.Visible = false;
    //    //    //ErrorMessage.ShowSuccessAlert(lblStatus, "Message sent successfuly!", divAlerts);

    //    //}
    //    //catch (Exception ex)
    //    //{
    //    //   // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
    //    //}
    //}

    //protected void btnPublish_OnServerClick(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        var userCookie = Request.Cookies["FrUserID"];
    //        var userNameCookie = Request.Cookies["Username"];
    //        var db = new DatabaseManagement();
    //        if (userNameCookie != null)
    //        {
    //            // string[] userInfo = GetRecipientID(db, GetReceiverBrandName(db));
    //            if (userCookie != null)
    //            {
    //                // Check if the brand already exists in the brand message list or not
    //                string checkBrand = string.Format("SELECT ReceiverID From Tbl_MailboxMaster Where SenderID={0} AND BlockStatus IS NULL",
    //                    IEUtils.ToInt(_receiverID));
    //                if (db.RecordExist(checkBrand))  // if Brand already record exist, then brand can send message to that influencer. other wise not
    //                {
    //                    int parentId = 0;
    //                    int receiverId = Convert.ToInt32(db.GetExecuteScalar(checkBrand));
    //                    string getParentId =
    //                        string.Format(
    //                            "SELECT ParentID FROM Tbl_MailboxMaster Where ReceiverID={0} AND SenderID={1} AND BlockStatus IS NULL",
    //                            receiverId, IEUtils.ToInt(userCookie.Value));
    //                    SqlDataReader dr = db.ExecuteReader(getParentId);
    //                    if (dr.HasRows)
    //                    {
    //                        dr.Read();
    //                        parentId = IEUtils.ToInt(dr[0]);
    //                    }
    //                    dr.Close();
    //                    dr.Dispose();
    //                    PostMessage(parentId, userCookie, db, txtMessage.Text);
    //                    //
    //                    //    ErrorMessage.ShowSuccessAlert(lblStatus, "Message sent successfuly!", divAlerts);
    //                }
    //                else
    //                {
    //                    int parentID = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(ParentID) From Tbl_MailboxMaster"));
    //                    string addMailboxMasterRecord =
    //                        string.Format(
    //                            "INSERT INTO Tbl_MailboxMaster(SenderID,ReceiverID,SenderName,ReceiverName) VALUES({0},{1},{2},{3})",
    //                            IEUtils.ToInt(userCookie.Value),
    //                            _receiverID,
    //                            IEUtils.SafeSQLString(userNameCookie.Value),
    //                            IEUtils.SafeSQLString(lblBrandName.Text)
    //                            );
    //                    db.ExecuteSQL(addMailboxMasterRecord);
    //                    PostMessage(parentID, userCookie, db, txtMessage.Text);
    //                }

    //            }
    //        }
    //        ErrorMessage.ShowSuccessAlert(lblStatus, "Message sent..", divAlerts);
    //        ClientScript.RegisterStartupScript(this.GetType(), "alert", "closefancybox();", true);


    //    }
    //    catch (Exception ex)
    //    {
    //        ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
    //    }

    //}

    private void PostMessage(int parentId, HttpCookie userCookie, DatabaseManagement db, string message)
    {
        int messageID = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(MessageID) From Tbl_Mailbox"));
        string messageKey = Encryption64.Encrypt(messageID.ToString(CultureInfo.InvariantCulture)).Replace('+', '=');
        string postMessage =
            string.Format(
                "INSERT INTO Tbl_Mailbox(MKey,Message,DatePosted,ParentID,MessageStatus,UserID) VALUES({0},{1},{2},{3},{4},{5})",
                IEUtils.SafeSQLString(messageKey),
                IEUtils.SafeSQLString(message),
                "'" + DateTime.UtcNow + "'",
                parentId,
                IEUtils.SafeSQLString("unread"),
                IEUtils.ToInt(userCookie.Value)
                );
        db.ExecuteSQL(postMessage);
        // Add Record For Admin
        string addQuery =
            string.Format("INSERT INTO Tbl_MailboxFor(MessageID,ReceiverID) VALUES({0},{1})",
                          messageID,
                          1);

        db.ExecuteSQL(addQuery);
        // Add Record For Recipient Notification
        string addQuery2 =
            string.Format("INSERT INTO Tbl_MailboxFor(MessageID,ReceiverID) VALUES({0},{1})",
                          messageID,
                          _receiverID);

        db.ExecuteSQL(addQuery2);
        //txtMessage.Text = "";


    }


    protected void menuPostDelete_OnClick(object sender, EventArgs e)
    {

    }

    protected void rptComments_OnItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var userId = Convert.ToInt32(((Label)e.Item.FindControl("lblUserID")).Text);
                var userCookie = HttpContext.Current.Request.Cookies["FrUserID"];
                var spDelmenuC = (HtmlGenericControl)e.Item.FindControl("spDelmenuC");
                if (userCookie != null)
                {
                    spDelmenuC.Visible = userId.ToString() == userCookie.Value;

                }
            }
        }
        catch (Exception ex)
        {

            throw;
        }
    }
}