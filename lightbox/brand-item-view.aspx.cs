using System;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;

public partial class lightbox_item_view : Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if(!IsPostBack)
            {
                LoadItemData();
                LoadBrandProfileImage();
                SetTotalViews();
                ItemLikes();
                GetCommentsCount();
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
                    "SELECT ItemID,Title,Description,RetailPrice,WholesalePrice,StyleNumber,StyleName,Color,Views,DatePosted,UserID  From Tbl_Items Where ItemID={0} AND IsPublished=1 AND IsDeleted IS NULL",
                    IEUtils.ToInt(Request.QueryString["v"]));
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
                lblTotolViews.Text = dr.IsDBNull(8) ? "0" : (Convert.ToInt32(dr[8]) + 1).ToString();
                lblUserID.Text = dr[10].ToString();
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
            string qryViews = string.Format("UPDATE Tbl_Items Set Views={0}  Where ItemID={1}", totalViews, IEUtils.ToInt(Request.QueryString["v"]));
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
            string likes = string.Format("SELECT COUNT(ID) as TotalLikes From Tbl_Item_Likes Where ItemID={0}", IEUtils.ToInt(Request.QueryString["v"]));
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
                                                  IEUtils.ToInt(Request.QueryString["v"]));
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
            string qryAddLike = string.Format("INSERT INTO Tbl_Item_Likes(ItemID,UserID) VALUES({0},{1})", IEUtils.ToInt(Request.QueryString["v"]), IEUtils.ToInt(Session["UserID"]));
            db.ExecuteSQL(qryAddLike);
            int notifyID = db.GetMaxID("NotifyID", "Tbl_Notifications");
            string notificationTitle = "<a href='#' >" + Session["Username"] +
                                       "</a> likes your item  <a href='" + Settings.DomainName + "/lightbox/brand-item-view.aspx?v='" +
                                       Request.QueryString['v'] + ">" + lblItemTitle.Text + "</a>";
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

    protected void GetCommentsCount()
    {
        var db=new DatabaseManagement();
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
            var db=new DatabaseManagement();
            var userCookie = Request.Cookies["FrUserID"];
            if (userCookie != null)
            {
                string addPost =
                    string.Format("INSERT INTO Tbl_Posts(Message,UserID,DatePosted,ItemID) VALUES({0},{1},{2},{3})",
                                  IEUtils.SafeSQLString(txtComment.Value),
                                  IEUtils.ToInt(userCookie.Value),
                                  "'" + DateTime.UtcNow + "'",
                                  IEUtils.ToInt(Request.QueryString["v"]));
                db.ExecuteSQL(addPost);

                int notifyID = db.GetMaxID("NotifyID", "Tbl_Notifications");
                string username = Session["Username"].ToString();
                string itemid = Request.QueryString["v"];
                string notificationTitle = "<a href='#'>" + username + "</a> commented on your item  <a href='"+ Settings.DomainName+"/lightbox/brand-item-view.aspx?v='" +
                                           itemid + ">" + lblItemTitle.Text + "</a>";
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
            if(e.Item.ItemType==ListItemType.Item || e.Item.ItemType==ListItemType.AlternatingItem)
            {
                var rptComments = (Repeater) e.Item.FindControl("rptComments");
               
                int postId = Convert.ToInt32(((Label) e.Item.FindControl("lblPostID")).Text);
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
            if(e.CommandName=="1")
            {
                
                var txtReply = (TextBox)e.Item.FindControl("txtReply");
                if (userCookie != null)
                {
                    string addComment = string.Format("INSERT INTO Tbl_Comments(PostId,Message,UserID,DatePosted) Values({0},{1},{2},{3})",
                                                      postId,
                                                      IEUtils.SafeSQLString(txtReply.Text),
                                                      IEUtils.ToInt(userCookie.Value),
                    "'" + DateTime.UtcNow + "'");
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
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
}