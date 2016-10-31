using System;
using System.Collections;
using System.Collections.Specialized;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;

public partial class brand_massenger : System.Web.UI.Page
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
      
        if (!Page.IsPostBack)
        {
            PageLoad();
        }
     }

    private void PageLoad()
    {
        //txtMessage.Attributes.Add("onKeyPress",
        //                          "doClick('" + btnSend.ClientID + "',event)");
        imgrply.Src = imgUserIcon.ImageUrl;
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
        ToggleLayout();
        if (Session["selectedFolder"] as string != "")
        {
            ToggleActionBars(Session["selectedFolder"].ToString());
            SetMpActionList(Session["selectedFolder"].ToString());
        }
        else
        {
            ToggleActionBars("1");
            SetMpActionList("1");
        }
    }

    private void ToggleLayout()
    {
        // dvActionBar.Visible = grdMessageList.Rows.Count > 0;
        if(rptMessageDetail.Items.Count>0)
        {
            dvMessageDetailBox.Visible = true;
            dvMessageDetailBoxEmpty.Visible = false;
        }
        else
        {
            dvMessageDetailBox.Visible = false;
            dvMessageDetailBoxEmpty.Visible = true;
        }
        
    }


    protected string[] GetRecipientID(DatabaseManagement db)
    {
        var userinfo = new string[2];
        var httpCookie = Request.Cookies["ParentId"];
        if (httpCookie != null)
        {
            string parentID = httpCookie.Value;
            SqlDataReader dr =
             db.ExecuteReader(string.Format("Select SenderID, U_Firstname + ' ' + U_Lastname As [SenderName]  From Tbl_MailboxMaster INNER JOIN Tbl_Users ON Tbl_Users.UserID=Tbl_MailboxMaster.SenderID  Where ParentID={0}",
                                           IEUtils.ToInt(parentID)));
            if (dr.HasRows)
            {
                dr.Read();
                userinfo[0] = dr[0].ToString();
                userinfo[1] = dr[1].ToString();
                
            }
            dr.Close();
            dr.Dispose();
            return userinfo;
        }
        return null;
    }
    protected string[] GetRecipientID(DatabaseManagement db, string username)
    {
        var userinfo = new string[3];
        SqlDataReader dr =
            db.ExecuteReader(string.Format("Select UserID, U_Firstname + ' ' + U_Lastname as Name,U_Username From Tbl_Users Where U_Username={0}",
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
    protected void btnSend_OnServerClick(object sender, EventArgs e)
    {
        try
        {
            var userCookie = Request.Cookies["FrUserID"];
            var parentCookie = Request.Cookies["ParentId"];
            
            var db = new DatabaseManagement();
            string[] userinfo = GetRecipientID(db);
            if (userCookie != null)
            {
                if (parentCookie != null)
                {
                    int messageID = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(MessageID) From Tbl_Mailbox"));
                    string messageKey = Encryption64.Encrypt(messageID.ToString(CultureInfo.InvariantCulture)).Replace('+', '=');
                    string postMessage =
                        string.Format(
                            "INSERT INTO Tbl_Mailbox(MKey,Message,DatePosted,ParentID,MessageStatus,UserID) VALUES({0},{1},{2},{3},{4},{5})",
                           IEUtils.SafeSQLString(messageKey),
                            IEUtils.SafeSQLString(txtMessage.Value),
                            "'" + DateTime.UtcNow + "'",
                            IEUtils.ToInt(parentCookie.Value),
                            IEUtils.SafeSQLString("unread"),
                            IEUtils.ToInt(userCookie.Value)
                            );
                    db.ExecuteSQL(postMessage);
                
                
                    string addQuery =
                        string.Format("INSERT INTO Tbl_MailboxFor(MessageID,ReceiverID) VALUES({0},{1})",
                                      IEUtils.ToInt(messageID),
                                      1);

                    db.ExecuteSQL(addQuery);

                    // Add Record For Recipient Notification
                    string addQuery2 =
                      string.Format("INSERT INTO Tbl_MailboxFor(MessageID,ReceiverID) VALUES({0},{1})",
                                   IEUtils.ToInt(messageID),
                                   userinfo[0]);

                    db.ExecuteSQL(addQuery2);
                }

                txtMessage.Value = string.Empty;
                rptMessageDetail.DataBind();
                ToggleLayout();
                lblBrandName.Text = userinfo[1];
                db._sqlConnection.Close();
                db._sqlConnection.Dispose();
                //ErrorMessage.ShowSuccessAlert(lblStatus, "Message sent successfuly!", divAlerts);
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
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        var chkSelect = (row.Cells[0].FindControl("chkCtrl") as CheckBox);
                        if (chkSelect != null) chkSelect.Checked = true;
                    }
                }
            }
            else
            {
                foreach (GridViewRow row in grdMessageList.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        var chkSelect = (row.Cells[0].FindControl("chkCtrl") as CheckBox);
                        if (chkSelect != null) chkSelect.Checked = false;
                    }
                    
                }
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void rptMessageList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var lblDatePosted = (Label)e.Item.FindControl("lblDate");
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
           if(e.CommandName=="2")
            {
                string[] messageIDs = e.CommandArgument.ToString().Split(',');
                var httpCookie = Request.Cookies["ParentId"];
                if (httpCookie != null) httpCookie.Value = messageIDs[0];
                else
                {
                    var parentIDCookie = new HttpCookie("ParentId") { Value = messageIDs[0] };
                    HttpContext.Current.Response.Cookies.Add(parentIDCookie);
                    var messageIDCookie = new HttpCookie("MessageId") { Value = messageIDs[1] };
                    HttpContext.Current.Response.Cookies.Add(messageIDCookie);
                }
                rptMessageDetail.DataSourceID = "";
                rptMessageDetail.DataSource = sdsMessageDetails;
                rptMessageDetail.DataBind();
                var db = new DatabaseManagement();
                lblBrandName.Text = GetRecipientID(db)[1];
               txtMessage.Focus();
                txtMessage.Attributes.Add("placeholder", "Reply to " + lblBrandName.Text);
                //txtComposeMessage.Attributes.Add("placeholder", "Reply to" + lblBrandName.Text);
                ToggleLayout();
                rptMessageDetail.DataBind();
                //HideCompseScreen();
                // update the status of the message to read
                db.ExecuteSQL(string.Format("Update Tbl_Mailbox Set MessageStatus={0} Where ParentID={1}",
                                            IEUtils.SafeSQLString("read"), IEUtils.ToInt(messageIDs[1])));
                
               grdMessageList.DataBind();
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
            if(e.Row.RowType==DataControlRowType.DataRow)
            {
                var lblDatePosted = (Label)e.Row.FindControl("lblDate2");
                DateTime dbDate = Convert.ToDateTime(lblDatePosted.Text);
                lblDatePosted.Text = Common.GetRelativeTime(dbDate);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

   
    protected void grdMessageList_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            string[] messageIDs = e.CommandArgument.ToString().Split(',');
           
            var httpCookie = Request.Cookies["ParentId"];
            if (httpCookie != null) httpCookie.Value = messageIDs[0];
            else
            {
                var parentIDCookie = new HttpCookie("ParentId") { Value = messageIDs[0] };
                HttpContext.Current.Response.Cookies.Add(parentIDCookie);
                var messageIDCookie = new HttpCookie("MessageId") { Value = messageIDs[1] };
                HttpContext.Current.Response.Cookies.Add(messageIDCookie);
            }

            rptMessageDetail.DataSourceID = "";
            rptMessageDetail.DataSource = sdsMessageDetails;
            rptMessageDetail.DataBind();
           // rptMessageDetail.DataBind();
            var db = new DatabaseManagement();
            lblBrandName.Text = GetRecipientID(db)[1];
            txtMessage.Focus();
            txtMessage.Attributes.Add("placeholder", "Reply to " + lblBrandName.Text);
           // txtComposeMessage.Attributes.Add("placeholder", "Reply to " + lblBrandName.Text);
            ToggleLayout();

           // HideCompseScreen();
            // update the status of the message to read
            db.ExecuteSQL(string.Format("Update Tbl_Mailbox Set MessageStatus={0} Where ParentID={1}",
                                        IEUtils.SafeSQLString("read"), IEUtils.ToInt(messageIDs[0])));
            //grdMessageList.DataSourceID = "";
            //grdMessageList.DataSource = sdsMessageList;
           // grdMessageList.DataBind();
            if(e.CommandName=="1")
            {
                txtMessage.Focus();
            }
           
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void rptMessageDetail_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblDatePosted = (Label)e.Item.FindControl("lblDate");
                // Label lblDate2 = (Label)e.Item.FindControl("lblDate2");
                DateTime dbDate = Convert.ToDateTime(lblDatePosted.Text);
                lblDatePosted.Text = Common.GetRelativeTime(dbDate);

                var itemID = (Label)e.Item.FindControl("lblItemID");
                // if item id exist
                if(!string.IsNullOrEmpty(itemID.Text))
                {
                    var rptChild = (Repeater)e.Item.FindControl("rptChild");
                    string query = "SELECT dbo.Tbl_Brands.Name, " +
                                   " dbo.Tbl_Items.ItemID, dbo.Tbl_Items.Title, ItemKey, dbo.Tbl_Items.Description, dbo.Tbl_Items.FeatureImg  " +
                                   " FROM dbo.Tbl_Brands INNER JOIN dbo.Tbl_Items ON dbo.Tbl_Brands.UserID = dbo.Tbl_Items.UserID " +
                                   "Where  dbo.Tbl_Items.IsDeleted IS NULL AND dbo.Tbl_Items.IsPublished=1 AND ItemID=" +
                                   IEUtils.ToInt(itemID.Text);
                    sdsItem.SelectCommand = query;
                    rptChild.DataSourceID = "";
                    rptChild.DataSource = sdsItem;
                    rptChild.DataBind();

                }
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
    protected void DoAction(StringCollection idsCollection,string commandName)
    {
        try
        {
            string ids = idsCollection.Cast<string>().Aggregate(string.Empty, (current, id) => current + (id + ","));
            ids = ids.Substring(0, ids.LastIndexOf(","));
            var db=new DatabaseManagement();
            string query = string.Empty;
            string blockUserQry = string.Empty;
            switch (commandName)
            {
                case "A":
                    query = string.Format("Update Tbl_Mailbox Set MessageType='A' WHERE ParentID IN (" + ids + ")");
                    break;
                case "S":
                    blockUserQry =string.Format("Update Tbl_MailboxMaster Set BlockStatus='Yes' WHERE ParentID IN (" + ids + ")");
                    query = string.Format("Update Tbl_Mailbox Set MessageType='S' WHERE ParentID IN (" + ids + ")");
                    
                    break;
                case "D":
                    query = string.Format("Delete From  Tbl_Mailbox  WHERE ParentID IN (" + ids + ")");
                    
                    break;
                case "I":
                    query = string.Format("Update Tbl_Mailbox Set MessageType=NULL WHERE ParentID IN (" + ids + ")");
                    
                    break;
                case "R":
                    query = string.Format("Update Tbl_Mailbox Set MessageStatus='read' WHERE ParentID IN (" + ids + ")");
                   break;
            }

            db.ExecuteSQL(query);
            if(!string.IsNullOrEmpty(blockUserQry))
             db.ExecuteSQL(blockUserQry);
            grdMessageList.DataSourceID = "";
            if (Session["query1"].ToString() != "")
            {
                sdsMessageList.SelectCommand = Session["query1"].ToString();
            }
            grdMessageList.DataSource = sdsMessageList;
            //grdMessageList.DataBind();
            rptMessageDetail.DataBind();
            ToggleLayout();
            ToggleActionBars(commandName);
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
        }
        catch (ArgumentOutOfRangeException ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, "No record is selected. You must select atleast one record. ", divAlerts);
        }
    }

    /* *******************************   Inbox Action bar Events **************************** */
    protected void lbtnArchive_OnClick(object sender, EventArgs e)
    {
        try
        {
            var idCollection = GetSelectedIDs();
            DoAction(idCollection,"A");
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
            if(row.RowType==DataControlRowType.DataRow)
            {
                var chkSelect = (row.Cells[0].FindControl("chkCtrl") as CheckBox);
                if (chkSelect != null && chkSelect.Checked)
                {
                    var lbtnMessage = (LinkButton)row.FindControl("lbtnMessage");
                    string[] messageIDs = lbtnMessage.CommandArgument.Split(',');
                    idCollection.Add(messageIDs[0]);
                }
            }
           // var chkSelect = (HtmlInputCheckBox)row.FindControl("test1");
            
        }
        return idCollection;
    }
    protected void ToggleActionBars(string commandName)
    {
        dvActionbar.Visible = grdMessageList.Rows.Count > 0;
        switch (commandName)
        {
            case "1":
                    dvInboxActions.Visible = true;
                    dvArchiveActions.Visible = false;
                    dvSpamActions.Visible = false;
                break;
            case "2":
                
                    dvInboxActions.Visible = false;
                    dvArchiveActions.Visible = true;
                    dvSpamActions.Visible = false;
               
                break;
            case "3":
                
                    dvInboxActions.Visible = false;
                    dvArchiveActions.Visible = false;
                    dvSpamActions.Visible = true;
                
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
                    "SELECT Tbl_Mailbox.ParentID, U_Email,U_ProfilePic,SenderID,ReceiverID,SenderName,MessageID,Message,DatePosted, MessageStatus  " +
                    "FROM Tbl_Mailbox INNER JOIN Tbl_MailboxMaster ON Tbl_MailboxMaster.ParentID=Tbl_Mailbox.ParentID " +
                    "INNER JOIN Tbl_Users ON Tbl_MailboxMaster.SenderID=Tbl_Users.UserID " +
                    "WHERE MessageID IN (SELECT MAX(MessageID) From Tbl_Mailbox Group By ParentID) AND ReceiverID="+ IEUtils.ToInt(userCookie.Value) + "AND MessageType IS NULL AND  BlockStatus IS NULL";
                SetFolder(query, "Inbox", "1", "../images/msg.png");
                Session["query1"] = query;
                Session["selectedFolder"] = "1";
                SetMpActionList(Session["selectedFolder"].ToString());
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
        
        
    }

    private void SetFolder(string query,string foldername,string foldervalue,string folderimg)
    {
        
        chkAll2.SelectedIndex = -1;
        lblFoldername.Text = foldername;
        
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
            var messageIDCookie = new HttpCookie("MessageId") {Expires = DateTime.Now.AddDays(-1)};
            HttpContext.Current.Response.Cookies.Add(messageIDCookie);
            rptMessageDetail.DataSourceID = "";
            rptMessageDetail.DataSource = sdsMessageDetails;
            rptMessageDetail.DataBind();
            ToggleActionBars(foldervalue);
            //grdMessageList.DataBind();
            ToggleLayout();
            
        
    }


    protected void menuItemArchive_OnClick(object sender, EventArgs e)
    {
        try
        {
            var userCookie = Request.Cookies["FrUserID"];
            if (userCookie != null)
            {
                string query =
                    "SELECT Tbl_Mailbox.ParentID, U_Email,U_ProfilePic,SenderID,ReceiverID,SenderName,MessageID,Message,DatePosted, MessageStatus  " +
                    "FROM Tbl_Mailbox INNER JOIN Tbl_MailboxMaster ON Tbl_MailboxMaster.ParentID=Tbl_Mailbox.ParentID " +
                    "INNER JOIN Tbl_Users ON Tbl_MailboxMaster.SenderID=Tbl_Users.UserID " +
                    "WHERE MessageID IN (SELECT MAX(MessageID) From Tbl_Mailbox Group By ParentID) AND ReceiverID=" + IEUtils.ToInt(userCookie.Value) + "AND MessageType='A' AND  BlockStatus IS NULL";
                SetFolder(query, "Archive", "2", "../images/archm.png");
                Session["query1"] = query;
                Session["selectedFolder"] = "1";
                SetMpActionList(Session["selectedFolder"].ToString());
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
                   "SELECT Tbl_Mailbox.ParentID, U_Email,U_ProfilePic,SenderID,ReceiverID,SenderName,MessageID,Message,DatePosted,  MessageStatus " +
                    "FROM Tbl_Mailbox INNER JOIN Tbl_MailboxMaster ON Tbl_MailboxMaster.ParentID=Tbl_Mailbox.ParentID " +
                    "INNER JOIN Tbl_Users ON Tbl_MailboxMaster.SenderID=Tbl_Users.UserID " +
                    "WHERE MessageID IN (SELECT MAX(MessageID) From Tbl_Mailbox Group By ParentID) AND ReceiverID=" + IEUtils.ToInt(userCookie.Value) + "AND MessageType='S' AND  BlockStatus IS NOT NULL";
                SetFolder(query, "Spam", "3", "../images/markm.png");
                Session["query1"] = query;
                Session["selectedFolder"] = "1";
                SetMpActionList(Session["selectedFolder"].ToString());
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


    protected void btnPostMessage_OnServerClick(object sender, EventArgs e)
    {
        try
        {
            var userCookie = Request.Cookies["FrUserID"];
            var db = new DatabaseManagement();
            string[] userInfo = GetRecipientID(db, txtUsername.Text);

            if (userCookie != null)
            {
                // Check if the Brand exists in the influencer message list or not
                string checkBrand = string.Format(
                    "SELECT UserID  From Tbl_Users Where U_Username={0}  AND U_Type='Brand' AND UserID IN (SELECT SenderID From Tbl_MailboxMaster Where ReceiverID={1} AND BlockStatus IS NULL)",
                    IEUtils.SafeSQLString(txtUsername.Text),
                    IEUtils.ToInt(userCookie.Value));
                if(db.RecordExist(checkBrand))  // if influencer record exist, then brand can send message to that influencer. other wise not
                {
                    int parentId = 0;
                    int senderId = Convert.ToInt32(db.GetExecuteScalar(checkBrand));
                    string getParentId =
                        string.Format(
                            "SELECT ParentID FROM Tbl_MailboxMaster Where ReceiverID={0} AND SenderID={1} AND BlockStatus IS NULL",
                            IEUtils.ToInt(userCookie.Value), senderId);
                    SqlDataReader dr = db.ExecuteReader(getParentId);
                    if(dr.HasRows)
                    {
                        dr.Read();
                        parentId = IEUtils.ToInt(dr[0]);
                    }
                    dr.Close();
                    dr.Dispose();
                    // if no message thread exist, create new message thread
                    if (parentId <= 0)
                    {
                        parentId = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(ParentID) From Tbl_MailboxMaster"));
                        string addMessageThread =
                            string.Format(
                                "INSERT INTO Tbl_MailboxMaster(SenderID,ReceiverID,SenderName,ReceiverName) VALUES({0},{1},{2},{3})",
                                IEUtils.ToInt(userCookie.Value),
                                senderId,
                                IEUtils.SafeSQLString(lblUsername.Text),
                                 IEUtils.SafeSQLString(userInfo[1])
                                );
                        db.ExecuteSQL(addMessageThread);
                    }
                    
                    int messageID = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(MessageID) From Tbl_Mailbox"));
                    string messageKey = Encryption64.Encrypt(messageID.ToString(CultureInfo.InvariantCulture)).Replace('+', '=');
                    string postMessage =
                        string.Format(
                            "INSERT INTO Tbl_Mailbox(MKey,Message,DatePosted,ParentID,MessageStatus,UserID) VALUES({0},{1},{2},{3},{4},{5})",
                            IEUtils.SafeSQLString(messageKey),
                            IEUtils.SafeSQLString(txtComposeMessage.Value),
                            "'" + DateTime.UtcNow + "'",
                            parentId,
                            IEUtils.SafeSQLString("unread"),
                            IEUtils.ToInt(userCookie.Value));
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
                    ToggleLayout();
                    var httpCookie = Request.Cookies["ParentId"];
                    if (httpCookie != null) httpCookie.Value = parentId.ToString();
                    else
                    {
                        var parentIDCookie = new HttpCookie("ParentId") { Value = parentId.ToString() };
                        HttpContext.Current.Response.Cookies.Add(parentIDCookie);
                        var messageIDCookie = new HttpCookie("MessageId") { Value = messageID.ToString() };
                        HttpContext.Current.Response.Cookies.Add(messageIDCookie);
                    }
                    
                    rptMessageDetail.DataSourceID = "";
                    rptMessageDetail.DataSource = sdsMessageDetails;
                    rptMessageDetail.DataBind();
                    lblBrandName.Text = GetRecipientID(db)[1];
                    txtMessage.Attributes.Add("placeholder", "Reply to " + lblBrandName.Text);
                    grdMessageList.DataBind();
                    ToggleLayout();
                    //pnlMessage.Visible = true;
                    //pnlCompose.Visible = false;
                    txtUsername.Text = string.Empty;
                    txtMessage.Value = string.Empty;
                    txtComposeMessage.Value = string.Empty;
                   //
                     ErrorMessage.ShowSuccessAlert(lblStatus, "Message sent successfuly!", divAlerts);
                }
                else
                {
                    ErrorMessage.ShowErrorAlert(lblStatus, "You can not sent message to this Brand.", divAlerts);
                }
                
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void rptMessages_OnItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var lblDatePosted = (Label)e.Item.FindControl("lblDate2");
                DateTime dbDate = Convert.ToDateTime(lblDatePosted.Text);
                lblDatePosted.Text = Common.GetRelativeTime(dbDate);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void rptMessages_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string[] messageIDs = e.CommandArgument.ToString().Split(',');
        var httpCookie = Request.Cookies["ParentId"];
        if (httpCookie != null) httpCookie.Value = messageIDs[0];
        else
        {
            var parentIDCookie = new HttpCookie("ParentId") { Value = messageIDs[0] };
            HttpContext.Current.Response.Cookies.Add(parentIDCookie);
            var messageIDCookie = new HttpCookie("MessageId") { Value = messageIDs[1] };
            HttpContext.Current.Response.Cookies.Add(messageIDCookie);
        }
        rptMessageDetail.DataSourceID = "";
        rptMessageDetail.DataSource = sdsMessageDetails;
        rptMessageDetail.DataBind();
        
        var db = new DatabaseManagement();
        lblBrandName.Text = GetRecipientID(db)[1];
        txtMessage.Attributes.Add("placeholder", "Reply to " + lblBrandName.Text);
        ToggleLayout();
        // update the status of the message to read
        db.ExecuteSQL(string.Format("Update Tbl_Mailbox Set MessageStatus={0} Where ParentID={1}",
                                    IEUtils.SafeSQLString("read"), IEUtils.ToInt(messageIDs[0])));
      //  grdMessageList.DataSource = sdsMessageList;

        if (e.CommandName == "1")
        {
            txtMessage.Focus();
        }
        if (e.CommandName == "2")
        {
            // messageid[0]= Message Parent ID
            // messageid[1]= Message ID
        }
    }
    
    protected void chkCtrl_OnCheckedChanged(object sender, EventArgs e)
    {

    }

    /* ************************************* Message Panel Actions ******************************* */

    protected void SetMpActionList(string foldervalue)
    {
        switch (foldervalue)
        {
            case "1":
                    lbtnmpInbox.Visible = false;
                    lbtnmpArchive.Visible = true;
                    
                break;
            case "2":
                
                    lbtnmpInbox.Visible = true;
                    lbtnmpArchive.Visible = false;
               
                break;
            case "3":
                
                    lbtnmpInbox.Visible = true;
                    lbtnmpArchive.Visible = true;
                lbtnmpSpam.Visible = false;
                
                break;
        }
    }
   protected void lbtnmpInbox_OnClick(object sender, EventArgs e)
    {
       try
       {
           ChangeMpStatus("I");
       }
       catch (Exception ex)
       {
           ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
       }
    }

    private void ChangeMpStatus(string commandName)
    {
        var httpCookie = Request.Cookies["ParentId"];
        var db = new DatabaseManagement();
        if (httpCookie != null)
        {
            string query = string.Empty;
            string blockUserQry;
            switch (commandName)
            {
                case "A":
                    query = string.Format("Update Tbl_Mailbox Set MessageType='A' WHERE ParentID={0}",httpCookie.Value);
                    db.ExecuteSQL(query);
                    break;
                case "S":
                    blockUserQry = string.Format("Update Tbl_MailboxMaster Set BlockStatus='Yes' WHERE ParentID={0}", httpCookie.Value);
                    query = string.Format("Update Tbl_Mailbox Set MessageType='S' WHERE ParentID={0}", httpCookie.Value);
                    db.ExecuteSQL(query);
                    db.ExecuteSQL(blockUserQry);
                    break;
                case "D":
                    query = string.Format("Delete From  Tbl_Mailbox  WHERE ParentID={0}", httpCookie.Value);
                    db.ExecuteSQL(query);
                    break;
                case "I":
                    query = string.Format("Update Tbl_Mailbox Set MessageType=NULL WHERE ParentID={0}", httpCookie.Value);
                    db.ExecuteSQL(query);
                    break;
                case "R":
                    query = string.Format("Update Tbl_Mailbox Set MessageStatus='read' WHERE ParentID={0}", httpCookie.Value);
                    db.ExecuteSQL(query);
                    break;
            }
            
            
            grdMessageList.DataBind();
            //grdMessageList.DataBind();
            rptMessageDetail.DataBind();
            ToggleLayout();
            ToggleActionBars(commandName);
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
        }
    }

    protected void lbtnmpArchive_OnClick(object sender, EventArgs e)
    {
        try
        {
            ChangeMpStatus("A");
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void lbtnmpRead_OnClick(object sender, EventArgs e)
    {
        try
        {
            ChangeMpStatus("R");
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void lbtnmpSpam_OnClick(object sender, EventArgs e)
    {
        try
        {
            ChangeMpStatus("S");
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void lbtnmpDelete_OnClick(object sender, EventArgs e)
    {
        try
        {
            ChangeMpStatus("D");
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    /* ************************************* Message Panel Actions End *************************** */
    
}