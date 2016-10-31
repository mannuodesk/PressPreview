using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;

public partial class events_eventdetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        LoadEventData();
        //txtLocation.Text = "10 Down Street, London";
        txtLocation.Attributes.Add("onchange", "javascript:FindLocaiton()");

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

    protected void LoadEventData()
    {
        try
        {
            var db =new DatabaseManagement();
            string getEventData = string.Format("SELECT * From Tbl_Events Where EventID={0}",
                                                IEUtils.ToInt(Request.QueryString["e"]));
            SqlDataReader dr = db.ExecuteReader(getEventData);
            if(dr.HasRows)
            {
                dr.Read();
                lblEventTitle.Text = dr[1].ToString();
                lblEventDateTime.Text = Convert.ToDateTime(dr[2]).ToString("r").Replace("00:00:00 GMT"," at") + " " + dr[4] + " GMT";
                lblStartDate2.Text = dr[2].ToString();
                lblStartTime2.Text = dr[4].ToString();
                lblEndDateTime.Text = Convert.ToDateTime(dr[3]).ToString("r").Replace("00:00:00 GMT", " at") + " " + dr[5] + " GMT";
                lblEndDate2.Text = dr[3].ToString();
                lblEndTime2.Text = dr[5].ToString();
              //  lblCity.Text = dr[15].ToString();
                lblEventDateTime1.Text = Convert.ToDateTime(dr[2]).ToString("r").Replace("00:00:00 GMT", " at") + " " + dr[4] + " GMT";
                lblEndDateTime1.Text = Convert.ToDateTime(dr[3]).ToString("r").Replace("00:00:00 GMT", " at") + " " + dr[5] + " GMT";
                lblPara1.Text = dr[6].ToString();
                lblPara2.Text = dr[7].ToString();
                imgFeature.ImageUrl = "../eventpics/" + dr[8];
                lblMediaType.Text = dr[9].ToString();
                if (lblMediaType.Text == "image")
                {
                    imgCenter.Visible = true;
                    imgCenter.ImageUrl = "../eventpics/" + dr[10];
                    grdVideo.Visible = false;
                    Session["videoLink"] = "";
                }
                else
                {
                    imgCenter.Visible = false;
                    grdVideo.Visible = true;
                    
                    lblVideoLink.Text = dr[10].ToString();

                }
                lblLocation.Text = dr[13].ToString();
                lblLocation1.Text = dr[13].ToString();
                txtLocation.Text = dr[13].ToString();
                //txtLocation.Focus();
                lblRSVPType.Text = dr[18].ToString();
                if(lblRSVPType.Text=="External Link")
                {
                    btnRSVPLink.Visible = true;
                    btnRSVPLink.HRef = dr[17].ToString();
                    btnMailTo.Visible = false;
                }
                else
                {
                    btnRSVPLink.Visible = false;
                    btnMailTo.Visible = true;
                    btnMailTo.HRef = "mailto:" + dr[17];
                }

            }
        }
        catch (Exception ex)
        {
            
            throw;
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
           // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
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
          //  ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
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
          //  ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
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