using System.Collections.Specialized;
using System.Data;
using System.Text;
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
    protected void Page_Load(object sender, EventArgs e)
    {

        NameValueCollection n = Request.QueryString;
        if (n.HasKeys())
        {
            LoadUserDataFromKey();
        }
        else
        {
            LoadUserData();
        }
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        if (!IsPostBack)
        {
            
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
        
        LoadBrandData();
       // SetTotalViews();
        BrandLikes();
        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
    }
    protected void LoadUserDataFromKey()
    {
        try
        {
            var db = new DatabaseManagement();
            string getUserData = string.Format("SELECT UserID, U_Email,U_Firstname,U_CoverPic,U_ProfilePic From Tbl_Users Where UserKey={0}",
                                               IEUtils.SafeSQLString(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(getUserData);
            if (dr.HasRows)
            {
                dr.Read();
                var aCookie = new HttpCookie("FrUserID") { Value = dr["UserID"].ToString() };
                HttpContext.Current.Response.Cookies.Add(aCookie);
                var UsernameCookie = new HttpCookie("Username") { Value = dr["U_FirstName"].ToString() };
                HttpContext.Current.Response.Cookies.Add(UsernameCookie);
                var emailCookie = new HttpCookie("UserEmail") { Value = dr["U_Email"].ToString() };
                HttpContext.Current.Response.Cookies.Add(emailCookie);
                
                Session["UserID"] = dr["UserID"].ToString();
                Session["Username"] = dr["U_FirstName"].ToString();
                Session["UserEmail"] = dr["U_Email"].ToString();
                imgCover.ImageUrl = "../profileimages/" + dr[3].ToString();
                imgProfile.ImageUrl = "../brandslogoThumb/" + dr[4].ToString();
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void LoadUserData()
    {
        try
        {
            var httpCookie = Request.Cookies["FrUserID"];

            var db = new DatabaseManagement();
            if (httpCookie != null)
            {
                string getUserData = string.Format("SELECT UserID, U_Email,U_Firstname,U_CoverPic,U_ProfilePic From Tbl_Users Where UserID={0}",
                                                   IEUtils.ToInt(httpCookie.Value));
                SqlDataReader dr = db.ExecuteReader(getUserData);
                if (dr.HasRows)
                {
                    dr.Read();
                    imgCover.ImageUrl = "../profileimages/" + dr[3];
                    imgProfile.ImageUrl = "../brandslogoThumb/" + dr[4];
                }
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    [WebMethod]
    public static int LogoutCheck()
    {
        if (HttpContext.Current.Session["user"] == null)
        {
            return 0;
        }
        return 1;
    }
  

    protected void BrandLikes()
    {
        try
        {
            DatabaseManagement db = new DatabaseManagement();
            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
            {
                string followers = string.Format("SELECT COUNT(Id) as TotalLikes From Tbl_BrandsLikes Where UserID={0}", IEUtils.ToInt(httpCookie.Value));
                SqlDataReader dr = db.ExecuteReader(followers);
                int result = 0;
                if(dr.HasRows)
                {
                    dr.Read();
                    if (!dr.IsDBNull(0))
                        result = Convert.ToInt32(dr[0]);
                }
                dr.Close();
                lblTotolLikes.Text= result.ToString();
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
       
    }
    protected void BrandFollowers()
    {
        try
        {
            var db = new DatabaseManagement();
            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
            {
                string followers = string.Format("SELECT COUNT(Id) as TotalLikes From Tbl_UserFollowers Where UserID={0}", IEUtils.ToInt(httpCookie.Value));
                SqlDataReader dr = db.ExecuteReader(followers);
                int result = 0;
                if (dr.HasRows)
                {
                    dr.Read();
                    if (!dr.IsDBNull(0))
                        result = Convert.ToInt32(dr[0]);
                }
                dr.Close();
            }
            //  lblTotalFollowers.Text = result.ToString();
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
            DatabaseManagement db = new DatabaseManagement();
            int TotalViews = Convert.ToInt32(lblTotolViews.Text);
            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
            {
                string qryViews = string.Format("UPDATE Tbl_Brands Set TotalViews={0}  Where UserID={1}", TotalViews, IEUtils.ToInt(httpCookie.Value));
                db.ExecuteSQL(qryViews);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void LoadBrandData()
    {
        try
        {
            var db = new DatabaseManagement();
            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
            {
                string BrandData = string.Format("Select Name,Url,City,Country, Bio,TotalViews, U_ProfilePic,U_CoverPic,Url,History From Tbl_Brands INNER JOIN Tbl_Users ON Tbl_Brands.UserID=Tbl_Users.UserID Where Tbl_Brands.UserID={0}", IEUtils.ToInt(httpCookie.Value));
                SqlDataReader dr = db.ExecuteReader(BrandData);
                if(dr.HasRows)
                {
                    dr.Read();
                    lbBrandName.InnerText = dr[0].ToString();
                    lbWebURL.HRef = dr[1].ToString();
                    imgProfile.ImageUrl = "../brandslogoThumb/" + dr[6];
                    imgCover.ImageUrl = "../profileimages/" + dr[7];
                    lblCity.Text = dr[2].ToString();
                    lblCountry.Text = dr[3].ToString();
                    lblAbout.Text= Server.HtmlDecode(dr[4].ToString());
                    if (dr.IsDBNull(5))
                        lblTotolViews.Text = "0";
                    else
                        lblTotolViews.Text = dr[5].ToString();
                    lbWebURL.InnerText = dr[8].ToString();
                    lbWebURL.HRef = "http://" + dr[8].ToString();
                    lblHistory.Text = Server.HtmlDecode(dr[9].ToString());
                }
                dr.Close();
            }
            db._sqlConnection.Close();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected int LbLikes(int lookId)
    {
        try
        {
            DatabaseManagement db = new DatabaseManagement();
            string followers = string.Format("SELECT COUNT(Id) as TotalLikes From Tbl_Item_Likes  Where ItemID={0}", lookId);
            SqlDataReader dr = db.ExecuteReader(followers);
            int result = 0;
            if (dr.HasRows)
            {
                dr.Read();
                if (!dr.IsDBNull(0))
                    result = Convert.ToInt32(dr[0]);
            }
            dr.Close();
            return result;
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
        return 0;
    }
    protected void rptLookbook_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblDatePosted = (Label)e.Item.FindControl("lblDate");
                Label lblDate2 = (Label)e.Item.FindControl("lblDate2");
                DateTime dbDate = Convert.ToDateTime(lblDatePosted.Text);
                lblDate2.Text = Common.GetRelativeTime(dbDate);
                var lblLikes = (Label)e.Item.FindControl("lblLikes");
                lblLikes.Text = LbLikes(Convert.ToInt32(lblLikes.Text)).ToString();

            }

            
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    

    protected void btnEditProfile_OnServerClick(object sender, EventArgs e)
    {
        Response.Redirect("edit-profile.aspx");
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
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType==ListItemType.AlternatingItem)
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


    protected void grdNotifications11_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var lblDatePosted = (Label)e.Row.FindControl("lblDatePosted");
                DateTime dbDate = Convert.ToDateTime(lblDatePosted.Text);
                lblDatePosted.Text = Common.GetRelativeTime(dbDate);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void grdNotifications11_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "2")
            {
               var db = new DatabaseManagement();
                int recordId = Convert.ToInt32(e.CommandArgument);
                // update the status of the message to read
               db.ExecuteSQL(string.Format("Delete FROM Tbl_Notifications Where NotifyID={0}",recordId));
               grdNotifications11.DataBind(); 
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
}