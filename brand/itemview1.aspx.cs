using System;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;

public partial class lightbox_item_view : Page
{
    private int itemID;
    private string[] _loggedInUser;
    protected void Page_Load(object sender, EventArgs e)
    {
     
        try
        {
            if(!IsPostBack)
            {
                 itemID = Convert.ToInt32(Request.QueryString["v"]);
                 if (itemID != 0)
                 {
                     GetLoggedInUserInfo();
                     SetTotalViews();
                     LoadItemData();
                     LoadBrandProfileImage();
                     
                     ItemLikes();
                     GetCommentsCount();
                     hidField.Value = itemID.ToString();
                 }
            }
            {
                itemID = Convert.ToInt32(hidField.Value);
            }

            rptTags.DataBind();
            dvTagToggles.Visible = rptTags.Items.Count > 20;
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
        String selectQuery =
            string.Format(
                "SELECT UserKey, U_Firstname + ' ' + U_Lastname as Name from Tbl_Users Where UserID={0}",
                IEUtils.ToInt(Session["UserID"]));
        SqlDataReader dr = db.ExecuteReader(selectQuery);
        if (dr.HasRows)
        {
            dr.Read();
            _loggedInUser[0] = dr[0].ToString();
            _loggedInUser[1] = dr[1].ToString();
        }
    }
    protected void LoadBrandProfileImage()
    {
        try
        {
            var db=new DatabaseManagement();
            string UserDp = string.Format("SELECT U_ProfilePic From Tbl_Users Where UserID={0}",
                                          IEUtils.ToInt(Session["UserID"]));
            SqlDataReader dr = db.ExecuteReader(UserDp);
            if(dr.HasRows)
            {
                dr.Read();
                imgProfile.ImageUrl = "../brandslogoThumb/" + dr[0];
                imgProfile2.ImageUrl = "../brandslogoThumb/" + dr[0];
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
                    "SELECT ItemID,Title,Description,RetailPrice,WholesalePrice,StyleNumber,StyleName,Color,Views,DatePosted,UserID,Likes  From Tbl_Items Where ItemID={0} AND IsPublished=1 AND IsDeleted IS NULL",
                    itemID);
            SqlDataReader dr = db.ExecuteReader(itemRecord);
            if(dr.HasRows)
            {
                dr.Read();
                lblItemTitle.Text = dr[1].ToString();
                lblDescription.Text = dr[2].ToString();
                lblRetailPrice.Text = dr[3].ToString();
                lblWholesalePrice.Text = dr[4].ToString();
                lblStyleNumber.Text = dr[5].ToString();
                lblStyleName.Text = dr[6].ToString();
                lblTotolViews.Text = dr.IsDBNull(8) ? "0" : Convert.ToInt32(dr[8]).ToString();
                lblUserID.Text = dr[10].ToString();
                rptHoliday.DataBind();
                lblTotalLikes.Text = dr.IsDBNull(11) ? "0" : rptHoliday.Items.Count.ToString();
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
            lbtnLike.Enabled = !dr.HasRows;
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
            var db=new DatabaseManagement();
            string qryAddLike = string.Format("INSERT INTO Tbl_Item_Likes(ItemID,UserID,BrandID) VALUES({0},{1},{2})", itemID, IEUtils.ToInt(Session["UserID"]), IEUtils.ToInt(lblUserID.Text));
            db.ExecuteSQL(qryAddLike);
            rptHoliday.DataBind();
            int notifyID = db.GetMaxID("NotifyID", "Tbl_Notifications");
            string notificationTitle = "<a href='profile-page-items.aspx' >" + _loggedInUser[1] +
                                       "</a> likes your item  <a href='itemview1.aspx?v=" + IEUtils.ToInt(Request.QueryString["v"]) + "' class='fancybox'>" + lblItemTitle.Text + "</a>";
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

            if (lblTotalLikes.Text == "")
                lblTotalLikes.Text = "0";
            lblTotalLikes.Text = (Convert.ToInt32(lblTotalLikes.Text) + 1).ToString();
            string qryLikes = string.Format("UPDATE Tbl_Items Set Likes={0}  Where ItemID={1}", IEUtils.ToInt(lblTotalLikes.Text), IEUtils.ToInt(Request.QueryString["v"]));
            db.ExecuteSQL(qryLikes);
            ItemLikes();
            rptHoliday.DataBind();
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

    protected void GetCommentsCount()
    {
        var db=new DatabaseManagement();
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
            var db=new DatabaseManagement();
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
                string notificationTitle = "<a href='profile-page-items.aspx'>" + _loggedInUser[1] + "</a> commented on your item <a href='itemview1.aspx?v=" + IEUtils.ToInt(Request.QueryString["v"]) + "' class='fancybox'>" + lblItemTitle.Text + "</a>";
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
            if(e.Item.ItemType==ListItemType.Item || e.Item.ItemType==ListItemType.AlternatingItem)
            {
                var rptComments = (Repeater) e.Item.FindControl("rptComments");
               
                int postId = Convert.ToInt32(((Label) e.Item.FindControl("lblPostID")).Text);
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

    
    protected void rptPosts_OnItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
            var userCookie = Request.Cookies["FrUserID"];
            int postId = IEUtils.ToInt(e.CommandArgument);
            if(e.CommandName=="1")
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
            else if(e.CommandName=="3")
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
    void Close()
    {
        const string script = "parent.$.fancybox.close();";
        ScriptManager.RegisterStartupScript(this, GetType(), "", "parent.$.fancybox.close();", true);
        
    }

   
}