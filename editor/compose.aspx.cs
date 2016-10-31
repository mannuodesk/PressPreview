using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;

public partial class brand_compose : System.Web.UI.Page
{
    string foldername = "Inbox";
    protected void Page_Load(object sender, EventArgs e)
    {
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        if (!IsPostBack)
        {
            txtMessage.Attributes.Add("onKeyPress",
                   "doClick('" + btnSend.ClientID + "',event)");
            ToggleLayout();
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
            ToggleActionBars("1");
        }
    }

    private void ToggleLayout()
    {
// show select all check box only if there are messages in the list to select
        dvActionBar.Visible = grdMessageList.Rows.Count > 0;
    }

    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> GetUsernames(string lbName)
    {
        var empResult = new List<string>();
        var db = new DatabaseManagement();
        using (var con = new SqlConnection(db.ConnectionString))
        {
            using (var cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT Top 10 U_Username  From Tbl_Users Where U_Username LIKE '" + lbName + "%'  AND U_Type='Editor'";
                cmd.Connection = con;
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    empResult.Add(dr["U_Username"].ToString());
                }
                con.Close();
                return empResult;
            }
        }

    }
    
    protected string[] GetRecipientID(DatabaseManagement db, string username)
    {
       var userinfo=new string[2];
        SqlDataReader dr =
            db.ExecuteReader(string.Format("Select UserID, U_Firstname + ' ' + U_Lastname as Name From Tbl_Users Where U_Firstname + ' ' + U_Lastname={0}",
                                           IEUtils.SafeSQLString(username)));
        if(dr.HasRows)
        {
            dr.Read();
            userinfo[0] = dr[0].ToString();
            userinfo[1] = dr[1].ToString();
        }
        dr.Close();
        dr.Dispose();
        return userinfo;
    }
    protected void btnSend_OnServerClick(object sender, EventArgs e)
    {
        try
        {
            var userCookie = Request.Cookies["FrUserID"];
            var db=new DatabaseManagement();
            string[] userInfo = GetRecipientID(db, txtUsername.Text);
            
            if (userCookie != null)
            {
                int parentId = db.GetMaxID("MessageID", "Tbl_Mailbox");
                string postMessage =
                    string.Format(
                        "INSERT INTO Tbl_Mailbox(UserID,ReceiverID,SenderName,Message,DatePosted,ParentID,MessageStatus) VALUES({0},{1},{2},{3},{4},{5},{6})", 
                        IEUtils.ToInt(userCookie.Value),
                        IEUtils.ToInt(userInfo[0]),
                        IEUtils.SafeSQLString(lblUsername.Text),
                        IEUtils.SafeSQLString(txtMessage.Value),
                        "'" + DateTime.UtcNow + "'",
                        parentId,
                        IEUtils.SafeSQLString("unread"));
                db.ExecuteSQL(postMessage);
                // Add Record For Admin
               string addQuery =
                  string.Format("INSERT INTO Tbl_MailboxFor(MessageID,ReceiverID) VALUES({0},{1})",
                               IEUtils.ToInt(parentId),
                               1);

                db.ExecuteSQL(addQuery);
                // Add Record For Recipient Notification
                string addQuery2 =
                  string.Format("INSERT INTO Tbl_MailboxFor(MessageID,ReceiverID) VALUES({0},{1})",
                               IEUtils.ToInt(parentId),
                               userInfo[0]);

                db.ExecuteSQL(addQuery2);

                // Add notification
                int notifyID = db.GetMaxID("NotifyID", "Tbl_Notifications");
                string username = Session["Username"].ToString();
                
                string notificationTitle = "New message from <a href='#'>" + username + "</a>";
                string addNotification =
                         string.Format("INSERT INTO Tbl_Notifications(UserID,Title,DatePosted,MessageID) VALUES({0},{1},{2},{3})",

                                       IEUtils.ToInt(userCookie.Value),
                                       IEUtils.SafeSQLString(notificationTitle),
                                       IEUtils.SafeSQLDate(DateTime.UtcNow),
                                       IEUtils.ToInt(parentId)

                             );

                db.ExecuteSQL(addNotification);

                string
                    updateQuery =
                     string.Format("INSERT INTO Tbl_NotifyFor(NotifyID,RecipID) VALUES({0},{1})",
                                  IEUtils.ToInt(notifyID),
                                   IEUtils.ToInt(userInfo[0])

                         );

                db.ExecuteSQL(updateQuery);
                string
                     updateQuery1 =
                      string.Format("INSERT INTO Tbl_NotifyFor(NotifyID,RecipID) VALUES({0},{1})",
                                   IEUtils.ToInt(notifyID),
                                   1

                          );

                db.ExecuteSQL(updateQuery1);
                ToggleLayout();
                txtUsername.Text = string.Empty;
                txtMessage.Value = string.Empty;
                ErrorMessage.ShowSuccessAlert(lblStatus, "Message sent successfuly!", divAlerts);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void btnCancel_OnServerClick(object sender, EventArgs e)
    {
        Response.Redirect("massenger.aspx");
    }
    protected void chkAll2_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (chkAll2.SelectedValue == "0")
            {
                foreach (GridViewRow row in grdMessageList.Rows)
                {
                    CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                    chkSelect.Checked = true;
                }
            }
            else
            {
                foreach (GridViewRow row in grdMessageList.Rows)
                {
                    CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                    chkSelect.Checked = false;
                }
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
    protected void grdMessageList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblDatePosted = (Label)e.Row.FindControl("lblDate2");
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

    [WebMethod, ScriptMethod]
    public static void UpdateMessageStatus(string userID)
    {
        var db = new DatabaseManagement();
        string insertQuery = string.Format("UPDATE Tbl_MailboxFor Set ReadStatus={0} Where ReceiverID={1}",
                                           1, IEUtils.ToInt(userID));
        db.ExecuteSQL(insertQuery);


    }

    protected void DoAction(StringCollection idsCollection, string commandName)
    {
        try
        {
            string ids = idsCollection.Cast<string>().Aggregate(string.Empty, (current, id) => current + (id + ","));
            ids = ids.Substring(0, ids.LastIndexOf(","));
            var db = new DatabaseManagement();
            string query = string.Empty;
            switch (commandName)
            {
                case "A":
                    query = string.Format("Update Tbl_Mailbox Set MessageType='A' WHERE MessageID IN (" + ids + ")");
                    break;
                case "S":
                    query = string.Format("Update Tbl_Mailbox Set MessageType='S' WHERE MessageID IN (" + ids + ")");
                    break;
                case "D":
                    query = string.Format("Delete From  Tbl_Mailbox  WHERE MessageID IN (" + ids + ")");
                    break;
                case "I":
                    query = string.Format("Update Tbl_Mailbox Set MessageType=NULL WHERE MessageID IN (" + ids + ")");
                    break;
                case "R":
                    query = string.Format("Update Tbl_Mailbox Set MessageStatus='read' WHERE MessageID IN (" + ids + ")");
                    break;
            }
            db.ExecuteSQL(query);
            grdMessageList.DataBind();
            grdMessageList.DataBind();
            ToggleActionBars(commandName);
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
        }
        catch (ArgumentOutOfRangeException ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, "No record is selected.You must select atleast one record. ", divAlerts);
        }
    }

    /* *******************************   Inbox Action bar Events **************************** */
    protected void lbtnArchive_OnClick(object sender, EventArgs e)
    {
        try
        {
            var idCollection = GetSelectedIDs();
            DoAction(idCollection, "A");
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void lbtnSpam_OnClick(object sender, EventArgs e)
    {
        try
        {
            var idCollection = GetSelectedIDs();
            DoAction(idCollection, "S");
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void lbtnDelete_OnClick(object sender, EventArgs e)
    {
        try
        {
            var idCollection = GetSelectedIDs();
            DoAction(idCollection, "D");
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    private StringCollection GetSelectedIDs()
    {
        var idCollection = new StringCollection();
        foreach (GridViewRow row in grdMessageList.Rows)
        {
            var chkSelect = (HtmlInputCheckBox)row.FindControl("chkSelect");
            if (chkSelect.Checked)
            {
                var lbtnMessage = (LinkButton)row.FindControl("lbtnMessage");
                string[] messageIDs = lbtnMessage.CommandArgument.Split(',');
                idCollection.Add(messageIDs[1]);
            }
        }
        return idCollection;
    }
    protected void ToggleActionBars(string commandName)
    {
        switch (commandName)
        {
            case "1":
                dvInboxActions.Visible = grdMessageList.Rows.Count > 0;
                dvArchiveActions.Visible = false;
                dvSpamActions.Visible = false;
                break;
            case "2":
                dvInboxActions.Visible = false;
                dvArchiveActions.Visible = grdMessageList.Rows.Count > 0;
                dvSpamActions.Visible = false;
                break;
            case "3":
                dvInboxActions.Visible = false;
                dvArchiveActions.Visible = false;
                dvSpamActions.Visible = grdMessageList.Rows.Count > 0;
                break;
        }
    }

    /* *******************************   Archive Action bar Events **************************** */
    protected void lbtnInbox_OnClick(object sender, EventArgs e)
    {
        try
        {
            var idCollection = GetSelectedIDs();
            DoAction(idCollection, "I");
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void lbtnSpamArchive_OnClick(object sender, EventArgs e)
    {
        try
        {
            var idCollection = GetSelectedIDs();
            DoAction(idCollection, "S");
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void lbtnDeleteArchive_OnClick(object sender, EventArgs e)
    {
        try
        {
            var idCollection = GetSelectedIDs();
            DoAction(idCollection, "D");
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    /* *******************************   Spam Action bar Events **************************** */

    protected void lbtnSpam2Inbox_OnClick(object sender, EventArgs e)
    {
        try
        {
            var idCollection = GetSelectedIDs();
            DoAction(idCollection, "I");
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void lbtnSpam2Archive_OnClick(object sender, EventArgs e)
    {
        try
        {
            var idCollection = GetSelectedIDs();
            DoAction(idCollection, "A");
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void lbtnDeleteSpam_OnClick(object sender, EventArgs e)
    {
        try
        {
            var idCollection = GetSelectedIDs();
            DoAction(idCollection, "D");
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void menuItemInbox_OnClick(object sender, EventArgs e)
    {
        try
        {
            var userCookie = Request.Cookies["FrUserID"];
            if (userCookie != null)
            {
                string query =
                    "SELECT U_Username, U_Email, m.MessageID, m.Message, m.SenderName, U_ProfilePic,m.ParentID, m.DatePosted,m.MessageStatus  FROM Tbl_Users" +
                    " INNER JOIN Tbl_Mailbox m ON Tbl_Users.UserID = m.UserID WHERE MessageID in (SELECT max(MessageID) FROM Tbl_Mailbox GROUP BY ParentID,ReceiverID ) AND ReceiverID=" +
                    IEUtils.ToInt(userCookie.Value) + " AND MessageType IS NULL   order by MessageID desc";
                SetFolder(query, "Inbox", "1", "../images/msg.png");
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }


    }

    private void SetFolder(string query, string foldername, string foldervalue, string folderimg)
    {

        chkAll2.SelectedIndex = -1;
        lblFoldername.Text = foldername;
        ToggleActionBars(foldervalue);
        imgFolders.ImageUrl = folderimg;

        sdsMessageList.SelectCommand = query;
        grdMessageList.DataSourceID = "";
        grdMessageList.DataSource = sdsMessageList;

        grdMessageList.DataBind();
        var parentIDCookie = Request.Cookies["ParentId"];
        if (parentIDCookie != null)
        {
            parentIDCookie.Value = "0";
            HttpContext.Current.Response.Cookies.Add(parentIDCookie);
        }
        var messageIDCookie = new HttpCookie("MessageId") { Expires = DateTime.Now.AddDays(-1) };
        HttpContext.Current.Response.Cookies.Add(messageIDCookie);
        
        ToggleLayout();
        // rptMessageDetail.DataBind();

    }


    protected void menuItemArchive_OnClick(object sender, EventArgs e)
    {
        try
        {
            var userCookie = Request.Cookies["FrUserID"];
            if (userCookie != null)
            {
                string query =
                    "SELECT U_Username, U_Email, m.MessageID, m.Message, m.SenderName, U_ProfilePic,m.ParentID, m.DatePosted,m.MessageStatus  FROM Tbl_Users" +
                    " INNER JOIN Tbl_Mailbox m ON Tbl_Users.UserID = m.UserID WHERE MessageID in (SELECT max(MessageID) FROM Tbl_Mailbox GROUP BY ParentID,ReceiverID ) AND ReceiverID=" +
                    IEUtils.ToInt(userCookie.Value) + " AND MessageType='A'  order by MessageID desc";
                SetFolder(query, "Archive", "2", "../images/archm.png");
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }

    }

    protected void menuItemSpam_OnClick(object sender, EventArgs e)
    {
        try
        {
            var userCookie = Request.Cookies["FrUserID"];
            if (userCookie != null)
            {
                string query =
                    "SELECT U_Username, U_Email, m.MessageID, m.Message, m.SenderName, U_ProfilePic,m.ParentID, m.DatePosted,m.MessageStatus  FROM Tbl_Users" +
                    " INNER JOIN Tbl_Mailbox m ON Tbl_Users.UserID = m.UserID WHERE MessageID in (SELECT max(MessageID) FROM Tbl_Mailbox GROUP BY ParentID,ReceiverID ) AND ReceiverID=" +
                    IEUtils.ToInt(userCookie.Value) + " AND MessageType='S'  order by MessageID desc";
                SetFolder(query, "Spam", "3", "../images/markm.png");
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }

    }

    protected void lbtnReadArchive_OnClick(object sender, EventArgs e)
    {
        var idCollection = GetSelectedIDs();
        DoAction(idCollection, "R");
    }

    protected void lbtnRead_OnClick(object sender, EventArgs e)
    {
        var idCollection = GetSelectedIDs();
        DoAction(idCollection, "R");
    }

    protected void lbtnReadSpam_OnClick(object sender, EventArgs e)
    {
        var idCollection = GetSelectedIDs();
        DoAction(idCollection, "R");
    }

    protected void grdMessageList_OnRowCommand(object sender, GridViewCommandEventArgs e)
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