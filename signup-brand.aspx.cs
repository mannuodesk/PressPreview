using System.Net;
using System.Net.Mail;
using DLS.DatabaseServices;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Text;

public partial class signup_brand : System.Web.UI.Page
{
    static readonly string MailSenderAddress = System.Configuration.ConfigurationManager.AppSettings["SenderEmail"];
    static readonly string SmtpServer = System.Configuration.ConfigurationManager.AppSettings["MailServer"];
    static readonly string SmtpPort = System.Configuration.ConfigurationManager.AppSettings["SMTP_Port"];
    static readonly string MailSenderPassword = System.Configuration.ConfigurationManager.AppSettings["SenderPassword"];
    protected void Page_Load(object sender, EventArgs e)
    {
         string[] userdetails = new string[4];
        userdetails[0] = "abc123";
        userdetails[1] = "123abc";
        SendConfirmationEmail("asadabd", userdetails);

        using (MailMessage message = new MailMessage())
        {
            message.From = new MailAddress(MailSenderAddress);
            message.To.Add(new MailAddress("ibjpk25@gmail.com"));
            message.CC.Add(new MailAddress("mushtaqbunir@gmail.com"));
            message.Subject = "Message via My Site from  presspreview.azurewebsites.net";
            message.Body = "<div id='wrapper' style='width:700px;background-color: #E4E6E9; margin:0 auto; padding:30px 50px; border-top:1px solid #ddd; border-bottom:1px solid #ddd;'> This is test body </div>" ;
            var smtp = new SmtpClient
            {
                Host = SmtpServer,
                Port = Convert.ToInt32(SmtpPort),
                Credentials = new NetworkCredential(MailSenderAddress, MailSenderPassword),
                EnableSsl = true

            };
            SmtpClient client = new SmtpClient();
           // client.Host = "127.0.0.1";
            smtp.Send(message);
        }
    }

    protected void signup_ServerClick(object sender, EventArgs e)
    {
        try
        {
            if(txtfname.Value==string.Empty)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "First name field is required", divAlerts);
            }
            else if (txtemail.Value == string.Empty)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "Email is required", divAlerts);
            }
            else if(txtBio.Value == string.Empty)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "Brand Bio field is required", divAlerts);
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
            } else
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
                string insertQuery = string.Format("INSERT INTO Tbl_Brands(Name,Logo,Bio,Country,Province,City,PostalCode,Address,Phone,Email,Url,FbURL,TwitterURL,InstagramURL,UserID,History,DatePosted) VALUES({0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13},{14},{15},{16})",
                     IEUtils.SafeSQLString(txtfname.Value),
                     IEUtils.SafeSQLString("blank.png"),
                     IEUtils.SafeSQLString(txtBio.Value),
                     IEUtils.SafeSQLString("USA"),
                     IEUtils.SafeSQLString(ddState.SelectedItem.Text),
                     IEUtils.SafeSQLString(txtci.Value),
                     IEUtils.SafeSQLString(txtzip.Value),
                     IEUtils.SafeSQLString(txtaddr.Value),
                     IEUtils.SafeSQLString(txtoff.Value),
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
                int brandId = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(BrandID) From Tbl_Brands"));
                string brandkey = Encryption64.Encrypt(brandId.ToString(CultureInfo.InvariantCulture)).Replace('+', '=');
                string updateBrand = String.Format("Update Tbl_Brands Set BrandKey={0} Where BrandID={1}", IEUtils.SafeSQLString(brandkey), brandId);
                db.ExecuteSQL(updateBrand);
                /////// Post New account notification to admin
                List<int> lstAdmins = new List<int>();
                lstAdmins = GetAdminList();
                int notifyID = db.GetMaxID("NotifyID", "Tbl_Notifications");
                StringBuilder sb = new StringBuilder();
                sb.Append("<a href='../brands/edit.aspx?v=" + brandId + "'<b>" + txtfname.Value + "</b></a> created new brand account.");
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
                                    IEUtils.ToInt(notifyID),
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
        StringBuilder sb=new StringBuilder();
        sb.Append(
            "<div id='wrapper' style='width:700px;background-color: #E4E6E9; margin:0 auto; padding:30px 50px; border-top:1px solid #ddd; border-bottom:1px solid #ddd;'> " +
            " <div id='logo' style='margin-bottom:20px;'>                                                                                                               " +
            "     <h1>Press Preview</h1>                                                                                 " +
            " </div>                                                                                                                                                    " +
            " <div id='whitebox' style='background-color:#fff; padding:30px; margin-bottom:50px; border-radius: 7px;border: 1px solid #ccc;'>                                                                      " +
            "     <h1>Welcome to Press Preview.</h1>                                                                                                                      " +
            "       <p style='line-height:22px; text-align:justify;'>                                                                                                   " +
            "                   Hello " + txtfname.Value +
            " ! , <br/> <br />                                                                                                " +
            "                   You are receiving this mail because you created an online account on our website. One more step of activation is required by                                             " +
            "                   you before you get your own panel and customize every thing according to your need. Please click the link to confirm                                       " +
            "                   <a href='http://www.temp-dev.com/confirm.aspx?ck=" + userkey + "&v=" + userdetails[3] +
            "' target='_blank'>http://www.temp-dev.com/confirm.aspx?ck=" + userkey + "&v=" + userdetails[3] + "</a>" +
            "                   <br/> <br />                                                                                                                                  " +
            "                   Please find your account details below: <br/><br/>                                                                                      " +
            "                   <b>Username: </b> " + userdetails[1] +
            " <br/>                                                                                          " +
            "                   <b>Password: </b> " + userdetails[2] +
            " <br/><br/>                                                                             " +
            "                                                                                                                                                           " +
            "                   Best wishes                                                                                                                                   " +
            "               </p>                                                                                                                                        " +
            " </div>                                                                                                                                                    " +
            " <div id='footer' style='text-align:center'>                                                                                                               " +
            "      <strong>Copyright</strong> Press Preview &copy; " + DateTime.Now.Year +
            "                                                                                                                          " +
            " </div>                                                                                                                                                    " +
            "</div>");
        //string message = @"<div id='wrapper' style='width:700px;background-color: #E4E6E9; margin:0 auto; padding:30px 50px; border-top:1px solid #ddd; border-bottom:1px solid #ddd;'> " +
        //                    " <div id='logo' style='margin-bottom:20px;'>                                                                                                               " +
        //                   "     <h1>Press Preview</h1>                                                                                 " +
        //                    " </div>                                                                                                                                                    " +
        //                    " <div id='whitebox' style='background-color:#fff; padding:30px; margin-bottom:50px; border-radius: 7px;border: 1px solid #ccc;'>                                                                      " +
        //                    "     <h1>Welcome to Press Preview.</h1>                                                                                                                      " +
        //                    "       <p style='line-height:22px; text-align:justify;'>                                                                                                   " +
        //                    "                   Hello " + txtfname.Value + " ! , <br/> <br />                                                                                                " +
        //                    "                   You are receiving this mail because you created an online account on our website. One more step of activation is required by                                             " +
        //                    "                   you before you get your own panel and customize every thing according to your need. Please click the link to confirm                                       " +
        //                   "                   <a href='http://www.temp-dev.com/confirm.aspx?ck=" + userkey + "&v=" + userdetails[3] + "' target='_blank'>http://www.temp-dev.com/confirm.aspx?ck=" + userkey + "&v=" + userdetails[3] + "</a>" +
        //                    "                   <br/> <br />                                                                                                                                  " +
        //                    "                   Please find your account details below: <br/><br/>                                                                                      " +
        //                    "                   <b>Username: </b> " + userdetails[1] + " <br/>                                                                                          " +
        //                    "                   <b>Password: </b> " + userdetails[2] + " <br/><br/>                                                                             " +
        //                    "                                                                                                                                                           " +
        //                    "                   Best wishes                                                                                                                                   " +
        //                    "               </p>                                                                                                                                        " +
        //                    " </div>                                                                                                                                                    " +
        //                    " <div id='footer' style='text-align:center'>                                                                                                               " +
        //                     "      <strong>Copyright</strong> Press Preview &copy; " + DateTime.Now.Year + "                                                                                                                          " +
        //                    " </div>                                                                                                                                                    " +
        //                 "</div>";
      //  Auto_Mail.SendAlertEmail(MailSenderAddress, userdetails[3], subject, sb.ToString());
        Auto_Mail.SendAlertEmail(MailSenderAddress, "ibjpk25@gmail.com", subject, sb.ToString());
        Auto_Mail.SendAlertEmail(MailSenderAddress, "mushtaqbunir@gmail.com", subject, sb.ToString());
    }
    private void SendActivationEmail(string[] userdetails)
    {
        string subject = "New Brand Account Created";
        string message = @"<div id='wrapper' style='width:700px;background-color: #E4E6E9; margin:0 auto; padding:30px 50px; border-top:1px solid #ddd; border-bottom:1px solid #ddd;'> " +
                            " <div id='logo' style='margin-bottom:20px;'>                                                                                                               " +
                          "     <h1>Press Preview</h1>                                                                                 " +
                            " </div>                                                                                                                                                    " +
                            " <div id='whitebox' style='background-color:#fff; padding:30px; margin-bottom:50px; border-radius: 7px;border: 1px solid #ccc;'>                                                                      " +
                            "     <h1>New Brand Account Created</h1>                                                                                                                      " +
                            "       <p style='line-height:22px; text-align:justify;'>                                                                                                   " +
                            "                   <span style='color:red;'>ATTENTION</span> Administrator, <br/> <br />                                                                                                " +
                            "                   This is to let you know that a new brand account has been created on your website . <br /> <br />                                           " +


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