using System;
using System.Collections;
using System.Collections.Specialized;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;

public partial class brand_massenger : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        if (!IsPostBack)
        {
            txtMessage.Attributes.Add("onKeyPress",
                   "doClick('" + btnSend.ClientID + "',event)");
            // show select all check box only if there are messages in the list to select
          //  grdMessageList.DataBind();
            chkAll2.Visible = grdMessageList.Rows.Count > 0;
           
        }
    }

    
    protected string[] GetRecipientID(DatabaseManagement db)
    {
        var userinfo = new string[2];
        var httpCookie = HttpContext.Current.Request.Cookies["MessageId"];
        if (httpCookie != null)
        {
            string messageID = httpCookie.Value;
            SqlDataReader dr =
            db.ExecuteReader(string.Format("Select UserID,SenderName  From Tbl_Mailbox Where MessageID={0}",
                                           IEUtils.ToInt(messageID)));
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
                    string postMessage =
                        string.Format(
                            "INSERT INTO Tbl_Mailbox(UserID,ReceiverID,SenderName,Message,DatePosted,ParentID) VALUES({0},{1},{2},{3},{4},{5})",
                            IEUtils.ToInt(userCookie.Value),
                            IEUtils.ToInt(userinfo[0]),
                            IEUtils.SafeSQLString(lblUsername.Text),
                            IEUtils.SafeSQLString(txtMessage.Value),
                            "'" + DateTime.UtcNow + "'",
                            IEUtils.ToInt(parentCookie.Value)
                            );
                    db.ExecuteSQL(postMessage);
                }

                txtMessage.Value = string.Empty;
                rptMessageDetail.DataBind();
                lblBrandName.Text = GetRecipientID(db)[1];
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

                    var chkSelect = (HtmlInputCheckBox)row.FindControl("chkSelect");
                    chkSelect.Checked = true;
                }
            }
            else
            {
                foreach (GridViewRow row in grdMessageList.Rows)
                {
                    HtmlInputCheckBox chkSelect = (HtmlInputCheckBox)row.FindControl("chkSelect");
                    chkSelect.Checked = false;
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
    
    protected void grdMessageList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if(e.Row.RowType==DataControlRowType.DataRow)
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

    protected void btnCompose_OnServerClick(object sender, EventArgs e)
    {
        Response.Redirect("compose.aspx");
    }
    protected void grdMessageList_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if(e.CommandName=="2")
            {
                string[] messageIDs = e.CommandArgument.ToString().Split(',');
                // messageid[0]= Message Parent ID
                // messageid[1]= Message ID
                var parentIDCookie = new HttpCookie("ParentId") { Value = messageIDs[0] };
                HttpContext.Current.Response.Cookies.Add(parentIDCookie);
                var messageIDCookie = new HttpCookie("MessageId") { Value = messageIDs[1] };
                HttpContext.Current.Response.Cookies.Add(messageIDCookie);
                rptMessageDetail.DataBind();
                var db=new DatabaseManagement();
                lblBrandName.Text = GetRecipientID(db)[1];
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

            }


        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
}