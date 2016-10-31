using DLS.DatabaseServices;
using System;
using System.Data.SqlClient;

public partial class forgetpassword : System.Web.UI.Page
{
    static readonly string MailSenderAddress = System.Configuration.ConfigurationManager.AppSettings["SenderEmail"];
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSend_ServerClick(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
            string selectQuery =
                string.Format(
                    "SELECT Tbl_Users.UserID,U_Email,U_Username,U_Password,U_FirstName,UserKey FROM Tbl_Users  Where U_Email={0} ",
                    IEUtils.SafeSQLString(txtEmail.Value)
                    );
            SqlDataReader dr = db.ExecuteReader(selectQuery);
            if (dr.HasRows)
            {
                dr.Read();
                SendPasswordLink(dr,dr[5].ToString(),dr[1].ToString());
                txtEmail.Value = "";
                divEmailSection.Visible = false;
                ErrorMessage.ShowSuccessAlert(lblMessage, "Password reset link has been sent to your email address.Please check your email.", divAlerts2);
                lbGotoHome.Visible = true;
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

    private void SendPasswordLink(SqlDataReader dr,string userkey,string email)
    {
        string subject = "Account Details";
        string message =
            @"<div id='wrapper' style='width:700px;background-color: #E4E6E9; margin:0 auto; padding:20px 50px; border-top:1px solid #ddd; border-bottom:1px solid #ddd;'> " +
            " <div id='logo' style='margin-bottom:20px;'>                                                                                                               " +
            "     <h1><a href='http://presspreview.azurewebsites.net'><img src='http://presspreview.azurewebsites.net/images/logo.png' alt='thePRESSPreview' /></a></h1>                                                                                 " +
            " </div>                                                                                                                                                    " +
            "<div><img src='http://presspreview.azurewebsites.net/photobank/banner.jpg' alt='' style='width:700px; height:200px;'/></div> " +
                            " <div id='whitebox' style='background-color:#fff; padding:20px; margin-bottom:50px; border-radius: 7px;border: 1px solid #ccc;'>                        " +
            "     <h2>Reset Your Password</h2>                                                                                                                      " +
            "       <p style='line-height:22px; text-align:justify;'>                                                                                                   " +
            "                   Dear  " + dr[4] +
            ", <br/> <br />                                                                                                " +
            "                   We have received a forgot password request from your email. To reset your password, click this link.<br />                                           " +
            "                   <a href='http://presspreview.azurewebsites.net/changepassword.aspx?ck=" + userkey + "&email=" +
            email + "' target='_blank'>http://presspreview.azurewebsites.net/changepassword.aspx?ck=" + userkey +
            "&email=" + email + "</a>" +
            "                                                                                                                                                           " +
            "                  <br /><br /> Thanks                                                                                                                                  " +
            "               </p>                                                                                                                                        " +
            " </div>                                                                                                                                                    " +
            " <div id='footer' style='text-align:center'>                                                                                                               " +
            "      <strong>Copyright</strong> Press Preview &copy; " + DateTime.Now.Year +
            "                                                                                                                          " +
            " </div>                                                                                                                                                    " +
            "</div>";

        Auto_Mail.SendAlertEmail(MailSenderAddress, txtEmail.Value, subject, message);
    }

   
}