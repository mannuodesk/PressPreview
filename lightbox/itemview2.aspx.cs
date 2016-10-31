using System;
using System.Data.SqlClient;
using System.Globalization;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;

public partial class lightbox_item_view : Page
{
    private  int itemID;
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
            if (!IsPostBack)
            {
                itemID = Convert.ToInt32(Request.QueryString["v"]);
                if (itemID != 0)
                {
                    LoadItemData();
                    LoadBrandProfileImage();
                    SetTotalViews();
                    ItemLikes();
                    WishlistButtonStatus();
                    GetCommentsCount();
                    hidField.Value=itemID.ToString();
                }
            }
            else
            {
                string[] arr = hidField.Value.Split(',');
                hidField.Value = string.Empty;
                hidField.Value = arr[0];
                itemID = Convert.ToInt32(hidField.Value);
            }
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
            var db=new DatabaseManagement();
            string userDp = string.Format("SELECT U_ProfilePic  From Tbl_Users Where UserID={0}",
                                          itemID);
            SqlDataReader dr = db.ExecuteReader(userDp);
            if(dr.HasRows)
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
            var db=new DatabaseManagement();
            string itemRecord =
                string.Format(
                    "SELECT ItemID,Title,Description,RetailPrice,WholesalePrice,StyleNumber,StyleName,Color,Tbl_Items.Views,Tbl_Items.DatePosted,Tbl_Items.UserID,  U_Firstname + ' ' + U_Lastname as Name  From Tbl_Items INNER JOIN Tbl_Users ON Tbl_Items.UserID=Tbl_Users.UserID  Where ItemID={0} AND IsPublished=1 AND IsDeleted IS NULL",
                    itemID);
            SqlDataReader dr = db.ExecuteReader(itemRecord);
            if(dr.HasRows)
            {
                dr.Read();
                Session["ItemdID"]  = dr[0].ToString();
                lblItemTitle.Text = dr[1].ToString();
                lblDescription.Text = dr[2].ToString();
                lblRetailPrice.Text = dr[3].ToString();
                lblWholesalePrice.Text = dr[4].ToString();
                lblStyleNumber.Text = dr[5].ToString();
                lblStyleName.Text = dr[6].ToString();
                lblTotolViews.Text = dr.IsDBNull(8) ? "0" : (Convert.ToInt32(dr[8]) + 1).ToString();
                lblUserID.Text = dr[10].ToString();
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
    protected void SetTotalViews()
    {
        try
        {
            var db = new DatabaseManagement();
            int totalViews = Convert.ToInt32(lblTotolViews.Text);
            string qryViews = string.Format("UPDATE Tbl_Items Set Views={0}  Where ItemID={1}", totalViews, itemID);
            db.ExecuteSQL(qryViews);
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
            string likes = string.Format("SELECT COUNT(ID) as TotalLikes From Tbl_Item_Likes Where ItemID={0}", itemID);
            SqlDataReader dr = db.ExecuteReader(likes);
            int result = 0;
            if (dr.HasRows)
            {
                dr.Read();
                if (!dr.IsDBNull(0))
                    result = Convert.ToInt32(dr[0]);
            }
            dr.Close();
            string isAlreadyLiked = string.Format("SELECT ID From Tbl_Item_Likes Where UserID={0} AND ItemID={1}",
                                                  IEUtils.ToInt(Session["UserID"]),
                                                  itemID);
            dr = db.ExecuteReader(isAlreadyLiked);
            lbtnLike.Enabled = !dr.HasRows;
            
            lblTotalLikes.Text = result.ToString(CultureInfo.InvariantCulture);
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
            var db = new DatabaseManagement();
            string qryAddLike = string.Format("INSERT INTO Tbl_Item_Likes(ItemID,UserID,BrandID) VALUES({0},{1},{2})", itemID, IEUtils.ToInt(Session["UserID"]), IEUtils.ToInt(lblUserID.Text));
            db.ExecuteSQL(qryAddLike);
            if (lblTotalLikes.Text == "")
                lblTotalLikes.Text = "0";
            lblTotalLikes.Text = (Convert.ToInt32(lblTotalLikes.Text) + 1).ToString();
            int notifyID = db.GetMaxID("NotifyID", "Tbl_Notifications");
            string notificationTitle = "<a href='#' >" + Session["Username"] +
                                       "</a> likes your item  <a href='../lightbox/itemview1.aspx?v='" +
                                       itemID + " class='fancybox'>" + lblItemTitle.Text + "</a>";
            string addNotification =
                     string.Format("INSERT INTO Tbl_Notifications(UserID,Title,DatePosted,ItemID) VALUES({0},{1},{2},{3})",

                                   IEUtils.ToInt(Session["UserID"]),
                                   IEUtils.SafeSQLString(notificationTitle),
                                   IEUtils.SafeSQLDate(DateTime.UtcNow),
                                   itemID

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

    protected void lbtnWishList_OnClick(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
            if (!WishlistButtonStatus())
            {
                string addToWishList = string.Format("INSERT INTO Tbl_WishList(ItemID,UserID,DatePosted) VALUES({0},{1},{2})", itemID, IEUtils.ToInt(Session["UserID"]), "'" + DateTime.UtcNow + "'");
                db.ExecuteSQL(addToWishList);
                ErrorMessage.ShowSuccessAlert(lblStatus, "This item has been added to your wish list.", divAlerts);
                db._sqlConnection.Close();
                db._sqlConnection.Dispose();
            }
            else
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "This item is already in your wish list.", divAlerts);
            }
           
           // WishlistButtonStatus();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected bool WishlistButtonStatus()
    {
        try
        {
            var db = new DatabaseManagement();
            bool IsExist;
            string isAlreadyAdded = "SELECT WishID From Tbl_WishList Where UserID=" + IEUtils.ToInt(Session["UserID"]) + " AND ItemID=" + itemID;
            SqlDataReader dr = db.ExecuteReader(isAlreadyAdded);
            IsExist=dr.HasRows;
            
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
            return IsExist;
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            return false;
        }
        
    }

    protected void GetCommentsCount()
    {
        var db = new DatabaseManagement();
        lblPostCount.Text =
               db.GetExecuteScalar(string.Format("Select COUNT(PostId) From Tbl_Posts Where ItemID={0}",
                                               itemID));
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
                                  itemID,
                                  IEUtils.ToInt(lblUserID.Text));
                db.ExecuteSQL(addPost);

                int notifyID = db.GetMaxID("NotifyID", "Tbl_Notifications");
                string username = Session["Username"].ToString();
                string itemid = Request.QueryString["v"];
                string notificationTitle = "<a href='#'>" + username + "</a> commented on your item  <a href='../lightbox/itemview1.aspx?v='" +
                                           itemid + ">" + lblItemTitle.Text + "</a>";
                string addNotification =
                         string.Format("INSERT INTO Tbl_Notifications(UserID,Title,DatePosted,ItemID) VALUES({0},{1},{2},{3})",

                                       IEUtils.ToInt(Session["UserID"]),
                                       IEUtils.SafeSQLString(notificationTitle),
                                       IEUtils.SafeSQLDate(DateTime.UtcNow),
                                       itemID

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
                        "SELECT Tbl_Comments.Message, Tbl_Comments.DatePosted, U_Firstname + '  ' + U_Lastname as Username, Tbl_Users.U_ProfilePic, Tbl_Comments.PostId FROM Tbl_Users INNER JOIN Tbl_Comments ON Tbl_Comments.UserID=Tbl_Users.UserID WHERE (Tbl_Comments.PostId = {0})",
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
                //string deleteComment = string.Format("Delete From Tbl_Posts Where PostId={0}", postId);
                //db.ExecuteSQL(deleteComment);
                //rptPosts.DataBind();
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

    protected string[] GetRecipientID(DatabaseManagement db, string username)
    {
        var userinfo = new string[3];
        SqlDataReader dr =
            db.ExecuteReader(string.Format("Select UserID, U_Firstname + ' ' + U_Lastname as Name,U_Username  From Tbl_Users Where U_Firstname + ' ' + U_Lastname={0}",
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
    protected string[] GetReceiverBrandName(DatabaseManagement db)
    {
        string getBrandName =
            string.Format(
                "SELECT U_Username,U_Firstname + ' ' + U_Lastname as Name  From Tbl_Users Where UserID=(SELECT UserID From Tbl_Items Where ItemID={0})",
                itemID);
        string[] brandname = new string[2];
        SqlDataReader dr = db.ExecuteReader(getBrandName);
        if(dr.HasRows)
        {
            dr.Read();
            brandname[0] = dr[0].ToString();
            brandname[1] = dr[1].ToString();
        }
        dr.Close();
        dr.Dispose();
        return brandname;
    }
    protected void btnGetGift_OnClick(object sender, EventArgs e)
    {
        try
        {
            var userCookie = Request.Cookies["FrUserID"];
            var userNameCookie = Request.Cookies["Username"];
            var db = new DatabaseManagement();
            if (userNameCookie != null)
            {
                string[] userInfo = GetRecipientID(db, GetReceiverBrandName(db)[0]);
                if (userCookie != null)
                {
                    // Check if the brand already exists in the brand message list or not
                    string checkBrand = string.Format(
                        "SELECT UserID  From Tbl_Users Where U_Username={0}  AND U_Type='Brand' AND UserID IN (SELECT ReceiverID From Tbl_MailboxMaster Where SenderID={1} AND BlockStatus IS NULL)",
                        IEUtils.SafeSQLString(GetReceiverBrandName(db)[0]),
                        IEUtils.ToInt(userCookie.Value));
                    if (db.RecordExist(checkBrand))  // if Brand already record exist, then brand can send message to that influencer. other wise not
                    {
                        int parentId = 0;
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
                        PostMessage(userInfo, parentId, userCookie, db,txtGift.Value);
                        //
                        //    ErrorMessage.ShowSuccessAlert(lblStatus, "Message sent successfuly!", divAlerts);
                    }
                    else
                    {
                        int parentID = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(ParentID) From Tbl_MailboxMaster"));
                        string addMailboxMasterRecord =
                            string.Format(
                                "INSERT INTO Tbl_MailboxMaster(SenderID,ReceiverID,SenderName,ReceiverName) VALUES({0},{1},{2},{3})",
                                IEUtils.ToInt(userCookie.Value),
                                IEUtils.ToInt(userInfo[0]),
                                IEUtils.SafeSQLString(userNameCookie.Value),
                                IEUtils.SafeSQLString(userInfo[1])
                                );
                        db.ExecuteSQL(addMailboxMasterRecord);
                        PostMessage(userInfo, parentID, userCookie, db,txtGift.Value);
                    }

                }
            }
            ErrorMessage.ShowSuccessAlert(lblStatus, "Message sent successfuly!", divAlerts);
           
           
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    private void PostMessage(string[] userInfo, int parentId, HttpCookie userCookie, DatabaseManagement db,string message)
    {
        int messageID = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(MessageID) From Tbl_Mailbox"));
        string messageKey = Encryption64.Encrypt(messageID.ToString(CultureInfo.InvariantCulture)).Replace('+', '=');
        string postMessage =
            string.Format(
                "INSERT INTO Tbl_Mailbox(MKey,Message,DatePosted,ParentID,MessageStatus,UserID,ItemID) VALUES({0},{1},{2},{3},{4},{5},{6})",
                IEUtils.SafeSQLString(messageKey),
                IEUtils.SafeSQLString(message),
                "'" + DateTime.UtcNow + "'",
                parentId,
                IEUtils.SafeSQLString("unread"),
                IEUtils.ToInt(userCookie.Value),
                itemID
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
                          userInfo[0]);

        db.ExecuteSQL(addQuery2);
        txtGift.Value = string.Empty;
        txtSample.Value = string.Empty;


    }

    protected void btnRequestSample_OnClick(object sender, EventArgs e)
    {
        try
        {
            var userCookie = Request.Cookies["FrUserID"];
            var userNameCookie = Request.Cookies["Username"];
            var db = new DatabaseManagement();
            if (userNameCookie != null)
            {
                string[] userInfo = GetRecipientID(db, GetReceiverBrandName(db)[0]);
                if (userCookie != null)
                {
                    // Check if the brand already exists in the brand message list or not
                    string checkBrand = string.Format(
                        "SELECT UserID  From Tbl_Users Where U_Username={0}  AND U_Type='Brand' AND UserID IN (SELECT ReceiverID From Tbl_MailboxMaster Where SenderID={1} AND BlockStatus IS NULL)",
                        IEUtils.SafeSQLString(GetReceiverBrandName(db)[0]),
                        IEUtils.ToInt(userCookie.Value));
                    if (db.RecordExist(checkBrand))  // if Brand already record exist, then brand can send message to that influencer. other wise not
                    {
                        int parentId = 0;
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
                        PostMessage(userInfo, parentId, userCookie, db,txtSample.Value);
                        //
                        //    ErrorMessage.ShowSuccessAlert(lblStatus, "Message sent successfuly!", divAlerts);
                    }
                    else
                    {
                        int parentID = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(ParentID) From Tbl_MailboxMaster"));
                        string addMailboxMasterRecord =
                            string.Format(
                                "INSERT INTO Tbl_MailboxMaster(SenderID,ReceiverID,SenderName,ReceiverName) VALUES({0},{1},{2},{3})",
                                IEUtils.ToInt(userCookie.Value),
                                IEUtils.ToInt(userInfo[0]),
                                IEUtils.SafeSQLString(userNameCookie.Value),
                                IEUtils.SafeSQLString(userInfo[1])
                                );
                        db.ExecuteSQL(addMailboxMasterRecord);
                        PostMessage(userInfo, parentID, userCookie, db,txtSample.Value);
                    }

                }
            }

            ErrorMessage.ShowSuccessAlert(lblStatus, "Message sent successfuly!", divAlerts);

        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
       
    
    
}