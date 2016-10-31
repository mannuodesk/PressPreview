using DLS.DatabaseServices;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class signup_editor : System.Web.UI.Page
{
    static readonly string MailSenderAddress = System.Configuration.ConfigurationManager.AppSettings["SenderEmail"];
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
           
        }
    }

    protected void signup_ServerClick(object sender, EventArgs e)
    {
        try
        {
            if (txtfname.Value == string.Empty)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "First name field is required", divAlerts);
            }
            else if (txtemail.Value == string.Empty)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "Email is required", divAlerts);
            }
            else if (txtOrg.Value == string.Empty)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "Organization is required", divAlerts);
            }
            else if (txtaddr.Value == string.Empty)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "Address is required", divAlerts);
            }
            else if (txtoff.Value == string.Empty)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "Office Phone is required", divAlerts);
            }
            else if (txtci.Value == string.Empty)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "City is required", divAlerts);
            }
            else
            {
                DatabaseManagement db = new DatabaseManagement();
                string UserInfo = string.Format("SELECT UserID, U_Username,U_Password,U_Email From Tbl_Users Where UserKey={0}", IEUtils.SafeSQLString(Request.QueryString["k"]));
                SqlDataReader dr = db.ExecuteReader(UserInfo);
                string[] userdetails = new string[4];
                string uname = string.Empty;
                string upass = string.Empty;
                int userId = 0;
                if (dr.HasRows)
                {
                    dr.Read();
                    userdetails[0] = dr[0].ToString();
                    userdetails[1] = dr[1].ToString();
                    userdetails[2] = dr[2].ToString();
                    userdetails[3] = dr[3].ToString();

                }
                dr.Close();
                db._sqlConnection.Close();
                string insertQuery = string.Format("INSERT INTO Tbl_Editors(Firstname,Lastname,Org,Designation,Country,Province,City,PostalCode,Address1,Address2,HPhone,OPhone,Mobile,Email,WebURL,FbURL,TwitterURL,InstagramURL,Description,UserID,DatePosted) VALUES({0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13},{14},{15},{16},{17},{18},{19},{20})",
                   IEUtils.SafeSQLString(txtfname.Value),
                   IEUtils.SafeSQLString(lname.Value),
                   IEUtils.SafeSQLString(txtOrg.Value),
                   IEUtils.SafeSQLString(txtde.Value),
                   IEUtils.SafeSQLString("USA"),
                   IEUtils.SafeSQLString(ddState.SelectedItem.Text),
                   IEUtils.SafeSQLString(txtci.Value),
                   IEUtils.SafeSQLString(txtzip.Value),
                   IEUtils.SafeSQLString(txtaddr.Value),
                   IEUtils.SafeSQLString(addo.Value),
                   IEUtils.SafeSQLString(txtoff.Value),
                   IEUtils.SafeSQLString(ph.Value),
                   IEUtils.SafeSQLString(cell.Value),
                   IEUtils.SafeSQLString(txtemail.Value),
                   IEUtils.SafeSQLString(web.Value),
                   IEUtils.SafeSQLString(fb.Value),
                   IEUtils.SafeSQLString(tw.Value),
                   IEUtils.SafeSQLString(ins.Value),
                   IEUtils.SafeSQLString(des.Value),
                   IEUtils.ToInt(userdetails[0]),
                   "'" + DateTime.UtcNow + "'"
                   );
                db.ExecuteSQL(insertQuery);
                int editorId = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(EditorID) From Tbl_Editors"));
                string editorkey = Encryption64.Encrypt(editorId.ToString(CultureInfo.InvariantCulture)).Replace('+', '=');
                string updateEditor = String.Format("Update Tbl_Editors Set EditorKey={0} Where EditorID={1}", IEUtils.SafeSQLString(editorkey), editorId);
                db.ExecuteSQL(updateEditor);
                /////// Post New account notification to admin
                List<int> lstAdmins = new List<int>();
                lstAdmins = GetAdminList();
                int NotifyID = db.GetMaxID("NotifyID", "Tbl_Notifications");
                StringBuilder sb = new StringBuilder();
                sb.Append("<a href='../editors/edit.aspx?v=" + editorId + "'<b>" + txtfname.Value + " " + lname.Value + "</b></a> created new editor account.");
                string AddNotification =
                         string.Format("INSERT INTO Tbl_Notifications(UserID,Title,DatePosted) VALUES({0},{1},{2})",
                                       IEUtils.ToInt(userdetails[0]),
                                       IEUtils.SafeSQLString(sb.ToString()),
                                       IEUtils.SafeSQLDate(DateTime.UtcNow)

                             );

                db.ExecuteSQL(AddNotification);
                string NotifyList = string.Empty;
                foreach (int UserID in lstAdmins)
                {
                    NotifyList =
                       string.Format("INSERT INTO Tbl_NotifyFor(NotifyID,RecipID) VALUES({0},{1})",
                                    IEUtils.ToInt(NotifyID),
                                     IEUtils.ToInt(UserID)
                           );
                    db.ExecuteSQL(NotifyList);
                }
                ////// Send Email notifications...
                SendConfirmationEmail(Request.QueryString["k"], userdetails);
                SendActivationEmail(userdetails);
                Response.Redirect("created.aspx");
            }
            
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected List<int> GetAdminList()
    {
        DatabaseManagement db = new DatabaseManagement();
        List<int> lstAdmins = new List<int>();
        string selectAdmin = string.Format("SELECT UserID From Tbl_Users Where U_Type={0}", IEUtils.SafeSQLString("Admin"));
        SqlDataReader dr = db.ExecuteReader(selectAdmin);
        if (dr.HasRows)
        {
            while (dr.Read())
                lstAdmins.Add(IEUtils.ToInt(dr[0]));
        }
        dr.Close();
        return lstAdmins;
    }


    private void SendConfirmationEmail(string userkey, string[] userdetails)
    {
        const string subject = "Confirm your registration";
        string message = @"<div id='wrapper' style='width:700px;background-color: #E4E6E9; margin:0 auto; padding:30px 50px; border-top:1px solid #ddd; border-bottom:1px solid #ddd;'> " +
                            " <div id='logo' style='margin-bottom:20px;'>                                                                                                               " +
                           "     <h1>Press Preview</h1>                                                                                 " +
                            " </div>                                                                                                                                                    " +
                            " <div id='whitebox' style='background-color:#fff; padding:30px; margin-bottom:50px; border-radius: 7px;border: 1px solid #ccc;'>                                                                      " +
                            "     <h1>Welcome to Press Preview.</h1>                                                                                                                      " +
                            "       <p style='line-height:22px; text-align:justify;'>                                                                                                   " +
                            "                   Hello " + txtfname.Value + " ! , <br/> <br />                                                                                                " +
                            "                   You are receiving this mail because you created an online account on our website. One more step of activation is required                                             " +
                            "                   before you get your own panel and customize every thing according to your need. Please click the link to confirm                                       " +
                           "                   <a href='http://www.temp-dev.com/confirm.aspx?ck=" + userkey + "&v=" + userdetails[3] + "' target='_blank'>http://www.temp-dev.com/confirm.aspx?ck=" + userkey + "&v=" + userdetails[3] + "</a>" +
                            "                   <br/> <br />                                                                                                                                  " +
                            "                   Please find your account details below: <br/><br/>                                                                                      " +
                            "                   <b>Username: </b> " + userdetails[1] + " <br/>                                                                                          " +
                            "                   <b>Password: </b> " + userdetails[2] + " <br/><br/>                                                                             " +
                            "                                                                                                                                                           " +
                            "                   Best wishes                                                                                                                                   " +
                            "               </p>                                                                                                                                        " +
                            " </div>                                                                                                                                                    " +
                            " <div id='footer' style='text-align:center'>                                                                                                               " +
                             "      <strong>Copyright</strong> Press Preview &copy; " + DateTime.Now.Year + "                                                                                                                          " +
                            " </div>                                                                                                                                                    " +
                         "</div>";
        Auto_Mail.SendAlertEmail(MailSenderAddress, userdetails[3], subject, message);
    }
    private void SendActivationEmail(string[] userdetails)
    {
        string subject = "New Editor Account Created";
        string message = @"<div id='wrapper' style='width:700px;background-color: #E4E6E9; margin:0 auto; padding:30px 50px; border-top:1px solid #ddd; border-bottom:1px solid #ddd;'> " +
                            " <div id='logo' style='margin-bottom:20px;'>                                                                                                               " +
                          "     <h1>Press Preview</h1>                                                                                 " +
                            " </div>                                                                                                                                                    " +
                            " <div id='whitebox' style='background-color:#fff; padding:30px; margin-bottom:50px; border-radius: 7px;border: 1px solid #ccc;'>                                                                      " +
                            "     <h1>New Editor Account Created</h1>                                                                                                                      " +
                            "       <p style='line-height:22px; text-align:justify;'>                                                                                                   " +
                            "                   <span style='color:red;'>ATTENTION</span> Administrator, <br/> <br />                                                                                                " +
                            "                   This is to let you know that a new editor account has been created on your website . <br /> <br />                                           " +


                            "                   Please find customer details below: <br/><br/>                                                                                      " +
                            "                                                                                                           " +
                            "                   <b>Username: </b> " + userdetails[1] + " <br/>                                                                                          " +
                            "                   <b>Password: </b> " + userdetails[2] + "<br/>                                                                             " +
                              "                   <b>Date Created: </b> " + DateTime.UtcNow + " <br/><br/>                                                                             " +
                            "                                                                                                                                                           " +
                            "                   Thanks                                                                                                                                  " +
                            "               </p>                                                                                                                                        " +
                            " </div>                                                                                                                                                    " +
                            " <div id='footer' style='text-align:center'>                                                                                                               " +
                              "      <strong>Copyright</strong> Press Preview &copy; " + DateTime.Now.Year + "                                                                                                                          " +
                            " </div>                                                                                                                                                    " +
                         "</div>";

        Auto_Mail.SendAlertEmail(MailSenderAddress, MailSenderAddress, subject, message);
    }
}