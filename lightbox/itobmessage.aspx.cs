﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;

public partial class lightbox_message : System.Web.UI.Page
{
    private int _receiverID = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadBrandData();
        
    }
    protected void LoadBrandData()
    {
        try
        {
            var db = new DatabaseManagement();
            string BrandData = string.Format("Select UserID, U_Firstname + ' ' + U_Lastname as Name From Tbl_Users Where UserKey={0}", IEUtils.SafeSQLString(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(BrandData);
            if (dr.HasRows)
            {
                dr.Read();
                lblBrandName.Text = dr[1].ToString();
                _receiverID = Convert.ToInt32(dr[0]);
            }
            dr.Close();
            db._sqlConnection.Close();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    
    protected void btnPublish_OnServerClick(object sender, EventArgs e)
    {
        try
        {
            var userCookie = Request.Cookies["FrUserID"];
            var userNameCookie = Request.Cookies["Username"];
            var db = new DatabaseManagement();
            if (userNameCookie != null)
            {
               // string[] userInfo = GetRecipientID(db, GetReceiverBrandName(db));
                if (userCookie != null)
                {
                    // Check if the brand already exists in the brand message list or not
                    string checkBrand = string.Format("SELECT ReceiverID From Tbl_MailboxMaster Where SenderID={0} AND BlockStatus IS NULL",
                        IEUtils.ToInt(_receiverID));
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
                        PostMessage(parentId, userCookie, db, txtMessage.Text);
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
                                _receiverID,
                                IEUtils.SafeSQLString(userNameCookie.Value),
                                IEUtils.SafeSQLString(lblBrandName.Text)
                                );
                        db.ExecuteSQL(addMailboxMasterRecord);
                        PostMessage(parentID, userCookie, db, txtMessage.Text);
                    }

                }
            }
            ErrorMessage.ShowSuccessAlert(lblStatus, "Message sent..", divAlerts);
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "closefancybox();", true);


        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
        
    }

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
        txtMessage.Text = "";


    }
}