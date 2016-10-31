using System;
using System.Collections;
using System.Collections.Specialized;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;

public partial class editor_editor_profile : System.Web.UI.Page
{
    private int _editorID;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
        if (!IsPostBack)
        {
            LoadUserDataFromKey();
            LoadEditorData();
            SetTotalViews();
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
                 imgCover.ImageUrl = "../profileimages/" + dr[3];
                imgProfile.ImageUrl = "../brandslogoThumb/" + dr[4];
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    
    //protected void SetTotalViews()
    //{
    //    try
    //    {
    //        var db = new DatabaseManagement();
    //        int totalViews = Convert.ToInt32(lblTotolViews.Text);
    //        string qryViews = string.Format("UPDATE Tbl_Editors Set TotalViews={0}  Where UserID=(SELECT UserID From Tbl_Users Where UserKey={1})", totalViews, IEUtils.SafeSQLString(Request.QueryString["v"]));
    //            db.ExecuteSQL(qryViews);
            
    //    }
    //    catch (Exception ex)
    //    {
    //        ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
    //    }
    //}
    protected void SetTotalViews()
    {
        try
        {
            var db = new DatabaseManagement();
            string isAlreadyViewd = string.Format("SELECT ID From Tbl_Editor_Views Where EditorID={0} AND UserID={1}",
                                                 _editorID,
                                                   IEUtils.ToInt(Session["UserID"]));
            SqlDataReader dr = db.ExecuteReader(isAlreadyViewd);
            if (!dr.HasRows)
            {
                dr.Close();
                dr.Dispose();
                string addview = string.Format("INSERT INTO Tbl_Editor_Views(EditorID,UserID,ViewDate) VALUES({0},{1},{2})",
                    _editorID,
                    IEUtils.ToInt(Session["UserID"]),
                    IEUtils.SafeSQLDate(DateTime.UtcNow));
                db.ExecuteSQL(addview);
                int totalViews = Convert.ToInt32(lblTotolViews.Text) + 1;
                string qryViews = string.Format("UPDATE Tbl_Editors Set TotalViews={0}  Where EditorID={1}", totalViews, _editorID);
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
    protected void LoadEditorData()
    {
        try
        {
            var db = new DatabaseManagement();
           
                string brandData = string.Format("Select Firstname + ' ' + Lastname as Name, City," +
                                                 "Country, Description,ToProject,ECalendar, TotalViews,WebURL, EditorID  From Tbl_Editors Where UserID=(SELECT UserID From Tbl_Users Where UserKey={0})", IEUtils.SafeSQLString(Request.QueryString["v"]));
                SqlDataReader dr = db.ExecuteReader(brandData);
                if (dr.HasRows)
                {
                    dr.Read();
                    lblEditorName.InnerText = dr[0].ToString();
                
                    //lblCity.Text = dr[1].ToString();
                    //lblCountry.Text = dr[2].ToString();
                    lblCity.Text = dr.IsDBNull(1) ? "City not specified" : dr[1].ToString();
                    lblCountry.Text = dr.IsDBNull(2) ? "Country not specified" : dr[2].ToString();
                    lblAbout.Text = dr.IsDBNull(3) ? "No information provided" : dr[3].ToString();
                    lblTimeLine.Text = dr.IsDBNull(4) ? "No information provided" : dr[4].ToString();
                    lblEditorialCalender.Text = dr.IsDBNull(5) ? "No information provided" : dr[5].ToString();
                    //lblTimeLine.Text = dr[4].ToString();
                    //lblEditorialCalender.Text = dr[5].ToString();
                    lblTotolViews.Text = dr.IsDBNull(6) ? "0" : (Convert.ToInt32(dr[6]) + 1).ToString();
                    lblWebURL.InnerText = dr[7].ToString();
                    lblWebURL.HRef = "http://" + dr[7];
                    _editorID = IEUtils.ToInt(dr[8]);
                }
                dr.Close();
           
            db._sqlConnection.Close();
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
}