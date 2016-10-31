using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;

namespace editor
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var al = new ArrayList {lblUsername, imgUserIcon};
            Common.UserSettings(al);
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
            if (!IsPostBack)
            {
                try
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
                catch(Exception ex)
                {
                    ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
                }
            
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
            catch(Exception ex)
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
        public static List<Items> GetData(int pageIndex)
        {
            try
            {
                
                var db = new DatabaseManagement();
                var itemList = new List<Items>();
                    var cmd = new SqlCommand("GetFeatured2Items");
                    db._sqlConnection.Open();
                    cmd.Connection = db._sqlConnection;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
                    cmd.Parameters.AddWithValue("@PageSize", 10);
                    cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;

                    int pageCount = Convert.ToInt32(cmd.Parameters["@PageCount"].Value);
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                           var objitem = new Items
                            {
                                PageCount = pageCount,
                                ItemId = IEUtils.ToInt(dr["ItemID"]),
                                ItemKey = dr["ItemKey"].ToString(),
                                Name = dr["Name"].ToString(),
                               
                                RowNum = IEUtils.ToInt(dr["row"]),
                                Title = dr["Title"].ToString(),
                                
                                BrandId = IEUtils.ToInt(dr["BrandID"]),
                              
                                DatePosted = dr["dated"].ToString(),
                              
                                
                                FeatureImg = dr["FeatureImg"].ToString()
                            };

                            itemList.Add(objitem);

                        }
                    }


                    return itemList;



            }
            catch (Exception ex)
            {
                // ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }

            return null;
        }

        [WebMethod, ScriptMethod]
        public static void DeleteItem(string id)
        {
            var db = new DatabaseManagement();
            string deleteQuery = string.Format("Delete From Tbl_Items Where ItemID={0}",
                                                   IEUtils.ToInt(id));
            db.ExecuteSQL(deleteQuery);
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();

        }


    }

 
}