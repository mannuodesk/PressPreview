using DLS.DatabaseServices;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_Login : System.Web.UI.Page
{
    static readonly string MailSenderAddress = System.Configuration.ConfigurationManager.AppSettings["SenderEmail"];
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        
            try
            {
                var db = new DatabaseManagement();
                string selectQuery =
                    string.Format(
                        "SELECT Tbl_Users.UserID,U_Email,U_Username,U_Password,U_FirstName FROM Tbl_Users  Where U_Email={0} ",
                        IEUtils.SafeSQLString(txtEmail.Value)
                        );
                SqlDataReader dr = db.ExecuteReader(selectQuery);
                if (dr.HasRows)
                {
                    dr.Read();
                    string subject = "Account Details";
                    string message = @"<div id='wrapper' style='width:700px;background-color: #E4E6E9; margin:0 auto; padding:30px 50px; border-top:1px solid #ddd; border-bottom:1px solid #ddd;'> " +
                                " <div id='logo' style='margin-bottom:20px;'>                                                                                                               " +
                                "     <h1>Press Preview</h1>                                                                                 " +
                                " </div>                                                                                                                                                    " +
                                " <div id='whitebox' style='background-color:#fff; padding:30px; margin-bottom:50px; border-radius: 7px;border: 1px solid #ccc;'>                                                                      " +
                                "     <h2>Forgot Password</h2>                                                                                                                      " +
                                "       <p style='line-height:22px; text-align:justify;'>                                                                                                   " +
                                "                   Hello " + dr[4] + ", <br/> <br />                                                                                                " +
                                "                   We have received a forgot password request from your email. <br />                                           " +
                               "                   Please find your account details below: <br/><br/>                                                                                      " +
                                "                   <b>Username: </b> " + dr["U_Username"] + " <br/>                                                                                          " +
                                "                   <b>Password: </b> " + dr["U_Password"] + " <br/><br/>                                                                             " +
                                "                                                                                                                                                           " +
                                "                   Thanks                                                                                                                                  " +
                                "               </p>                                                                                                                                        " +
                                " </div>                                                                                                                                                    " +
                                " <div id='footer' style='text-align:center'>                                                                                                               " +
                                "      <strong>Copyright</strong> Press Preview &copy; " + DateTime.Now.Year +  "                                                                                                                          " +
                                " </div>                                                                                                                                                    " +
                             "</div>";

                    Auto_Mail.SendAlertEmail(MailSenderAddress, txtEmail.Value, subject, message);
                    txtEmail.Value = "";
                    ErrorMessage.ShowSuccessAlert(lblStatus, "Your acount details have been sent to your email address.Please check your email.", divAlerts);

                }
                else
                {
                    ErrorMessage.ShowErrorAlert(lblStatus, "Sorry !, we could not found this email in our database.", divAlerts);
                }
                dr.Close();
            }
            catch (Exception ex)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
        
    }
}