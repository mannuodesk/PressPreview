using System;
using System.Collections;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;
using System.Collections.Generic;
using System.Data.SqlClient;

public partial class event_Default : System.Web.UI.Page
{
    public static string[] monthNames = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" };
    protected void Page_Load(object sender, EventArgs e)
    {
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
        ClientScript.RegisterStartupScript(this.GetType(), "alert", "GetInitialData();", true);
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

    protected void btnSearch_OnServerClick(object sender, EventArgs e)
    {
        try
        {
            string searchQuery = string.Empty;

            if (txtEventTitle.Value == "" && ddCity.SelectedValue == "0" && ddCategory.SelectedValue == "0")
            {
                searchQuery =
                            string.Format(

                       "SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events]");
            }
            else
            {
                if (txtEventTitle.Value != "")
                {
                    if (ddCity.SelectedValue != "0")
                    {
                        if (ddCategory.SelectedValue != "0")
                        {
                            searchQuery =
                            string.Format(
                                //"SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where EventTitle LIKE  '%' + {0} + '%'  OR ECity={1} OR ECategoryID={2}",
                       "SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where EventTitle LIKE  '%' + {0} + '%'  OR ECity={1} AND ECategoryID={2}",
                       IEUtils.SafeSQLString(txtEventTitle.Value),
                       IEUtils.SafeSQLString(ddCity.SelectedValue),
                       IEUtils.ToInt(ddCategory.SelectedValue));
                        }
                        else
                        {
                            searchQuery =
                           string.Format(
                      "SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where EventTitle LIKE  '%' + {0} + '%'  OR ECity={1}",
                      IEUtils.SafeSQLString(txtEventTitle.Value),
                      IEUtils.SafeSQLString(ddCity.SelectedValue));
                        }
                    }
                    else
                    {
                        searchQuery =
                           string.Format(
                      "SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where EventTitle LIKE '%' + {0} + '%'",
                      IEUtils.SafeSQLString(txtEventTitle.Value));
                    }
                }
                else
                {
                    if (ddCity.SelectedValue != "0")
                    {
                        if (ddCategory.SelectedValue != "0")
                        {
                            searchQuery =
                           string.Format(
                                //"SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where  ECity={0} OR ECategoryID={1}",
                      "SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where  ECity={0} AND ECategoryID={1}",

                      IEUtils.SafeSQLString(ddCity.SelectedValue),
                      IEUtils.ToInt(ddCategory.SelectedValue));
                        }
                        else
                        {
                            searchQuery =
                           string.Format(
                      "SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where  ECity={0}",

                      IEUtils.SafeSQLString(ddCity.SelectedValue));
                        }
                    }
                }
                if (txtEventTitle.Value != "" && ddCity.SelectedValue != "0" && ddCategory.SelectedValue != "0")
                {

                }
                else if (txtEventTitle.Value == "" && ddCity.SelectedValue == "0")
                {
                    searchQuery =
                    string.Format(
                        //"SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where  ECategoryID={0}",
                        "SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where  ECategoryID={0}",
                        IEUtils.ToInt(ddCategory.SelectedValue));
                }
            }


            //sdsEvent.SelectCommand = searchQuery;
            //dlEvents.DataSourceID = "";
            //dlEvents.DataSource = sdsEvent;
            //dlEvents.DataBind();
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
    [WebMethod, ScriptMethod]
    public static List<Events> GetEvents()
    {
        List<Events> EventList = new List<Events>();
        Events events = new Events();
        var db = new DatabaseManagement();
        using (var con = new SqlConnection(db.ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where EventTitle IS NOT NULL  ORDER BY EventID DESC";
                cmd.Connection = con;
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if(dr.HasRows)
                {
                    while(dr.Read())
                    {
                        events = new Events();
                        events.EventID = dr["EventID"].ToString();
                        events.EventTitle = dr["EventTitle"].ToString();
                        DateTime date = Convert.ToDateTime((dr["StartDate"].ToString()));
                        events.StartDate = monthNames[date.Month] + " " + date.Day + ", ";
                        events.StartTime = dr["StartTime"].ToString();
                        events.EFeaturePic = dr["EFeaturePic"].ToString();
                        events.EventLocation = dr["ELocation"].ToString();
                        if(events.EventLocation.Length > 50)
                        {
                            events.EventLocation = events.EventLocation.Substring(0, 20) + " ...";
                        }
                        EventList.Add(events);
                    }
                }
            }
        }

        return EventList;
    }
    [WebMethod, ScriptMethod]
    public static List<Events> GetEventsSearching(string title, string city, string category)
    {
        List<Events> EventList = new List<Events>();
        Events events = new Events();
        try
        {
            string searchQuery = string.Empty;

            if (title == "" && city == "0" && category == "0")
            {
                searchQuery =
                            string.Format(

                       "SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events]");
            }
            else
            {
                if (title != "")
                {
                    if (city != "0")
                    {
                        if (category != "0")
                        {
                            searchQuery =
                            string.Format(
                                //"SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where EventTitle LIKE  '%' + {0} + '%'  OR ECity={1} OR ECategoryID={2}",
                       "SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where EventTitle LIKE  '%' + {0} + '%'  OR ECity={1} AND ECategoryID={2}",
                       IEUtils.SafeSQLString(title),
                       IEUtils.SafeSQLString(city),
                       IEUtils.ToInt(category));
                        }
                        else
                        {
                            searchQuery =
                           string.Format(
                      "SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where EventTitle LIKE  '%' + {0} + '%'  OR ECity={1}",
                      IEUtils.SafeSQLString(title),
                      IEUtils.SafeSQLString(city));
                        }
                    }
                    else
                    {
                        searchQuery =
                           string.Format(
                      "SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where EventTitle LIKE '%' + {0} + '%'",
                      IEUtils.SafeSQLString(title));
                    }
                }
                else
                {
                    if (city != "0")
                    {
                        if (category != "0")
                        {
                            searchQuery =
                           string.Format(
                                //"SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where  ECity={0} OR ECategoryID={1}",
                      "SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where  ECity={0} AND ECategoryID={1}",

                      IEUtils.SafeSQLString(city),
                      IEUtils.ToInt(category));
                        }
                        else
                        {
                            searchQuery =
                           string.Format(
                      "SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where  ECity={0}",

                      IEUtils.SafeSQLString(city));
                        }
                    }
                }
                if (title != "" && city != "0" && category != "0")
                {

                }
                else if (title == "" && city == "0")
                {
                    searchQuery =
                    string.Format(
                        //"SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where  ECategoryID={0}",
                        "SELECT [EventID], [EventTitle], [StartDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where  ECategoryID={0}",
                        IEUtils.ToInt(category
                        ));
                }
            }

            
            var db = new DatabaseManagement();
            using (var con = new SqlConnection(db.ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = searchQuery;
                    cmd.Connection = con;
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            events = new Events();
                            events.EventID = dr["EventID"].ToString();
                            events.EventTitle = dr["EventTitle"].ToString();
                            DateTime date = Convert.ToDateTime((dr["StartDate"].ToString()));
                            events.StartDate = monthNames[date.Month] + " " + date.Day + ", ";
                            events.StartTime = dr["StartTime"].ToString();
                            events.EFeaturePic = dr["EFeaturePic"].ToString();
                            events.EventLocation = dr["ELocation"].ToString();
                            EventList.Add(events);
                        }
                    }
                }
            }
            //sdsEvent.SelectCommand = searchQuery;
            //dlEvents.DataSourceID = "";
            //dlEvents.DataSource = sdsEvent;
            //dlEvents.DataBind();
        }
        catch (Exception ex)
        {
            //ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
        

        return EventList;
    }
}