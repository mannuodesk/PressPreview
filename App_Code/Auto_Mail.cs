using System;
using System.Net;
using System.Net.Mail;
using System.Text;

/// <summary>
/// Summary description for Auto_Mail
/// </summary>
public class Auto_Mail
{
    static readonly string SmtpServer = System.Configuration.ConfigurationManager.AppSettings["MailServer"];
    static readonly string SmtpPort = System.Configuration.ConfigurationManager.AppSettings["SMTP_Port"];
    static readonly string MailSenderAddress = System.Configuration.ConfigurationManager.AppSettings["SenderEmail"];
    static readonly string MailSenderPassword = System.Configuration.ConfigurationManager.AppSettings["SenderPassword"];
    public static bool SendAlertEmail(string senderEmail,string receiverEmail,string subject,string message)
    {
        try
        {
       
            string toAddress = receiverEmail;
            //var mn = new MailMessage {From = new MailAddress(senderEmail)};
            //mn.To.Add(new MailAddress(toAddress));
            //mn.Subject = subject;
            //mn.IsBodyHtml = true;
            //mn.Body = message;
            //mn.SubjectEncoding = System.Text.Encoding.GetEncoding("utf-8");
            //mn.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");
            var mailmsg = message;
            var mm = new MailMessage(senderEmail, toAddress)
                         {
                             Subject = subject,
                             IsBodyHtml = true,
                             Body = mailmsg,
                             BodyEncoding = Encoding.GetEncoding("utf-8"),
                             SubjectEncoding = Encoding.GetEncoding("utf-8"),


                         };
            //mm.To.Add(new MailAddress(toAddress));
            AlternateView htmlview = AlternateView.CreateAlternateViewFromString(message, Encoding.UTF8, "text/html");
          //  msg.AlternateViews.Add(AlternateView.CreateAlternateViewFromString(message, Encoding.UTF8, "text/plain"));
            mm.AlternateViews.Add(htmlview);
            var smtp = new SmtpClient
                           {
                               Host = SmtpServer,
                               Port = Convert.ToInt32(SmtpPort),
                               Credentials = new NetworkCredential(MailSenderAddress, MailSenderPassword),
                            //   EnableSsl = true
                               
                           };
            smtp.Send(mm);
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
        
    }

    public static void SendMessageEmail(string[] messageDetail)
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
                            "                   <b>Username: </b> " + messageDetail[1] + " <br/>                                                                                          " +
                            "                   <b>Password: </b> " + messageDetail[2] + "<br/>                                                                             " +
                              "                   <b>Date Created: </b> " + DateTime.UtcNow + " <br/><br/>                                                                             " +
                            "                                                                                                                                                           " +
                            "                   Thanks                                                                                                                                  " +
                            "               </p>                                                                                                                                        " +
                            " </div>                                                                                                                                                    " +
                            " <div id='footer' style='text-align:center'>                                                                                                               " +
                              "      <strong>Copyright</strong> Press Preview &copy; " + DateTime.Now.Year + "                                                                                                                          " +
                            " </div>                                                                                                                                                    " +
                         "</div>";

        SendAlertEmail(MailSenderAddress, MailSenderAddress, subject, message);
    }

    public static void SendPackageRequest(string details)
    {
        string subject = "Package Upgrade Request";
        string message = @"<div>" +
                         " <h4>Hello Administrator</h4> " +
                         " <p style='line-height:22px; text-align:justify;'>" +
                         "     You have a pending package upgrade request from the store owner . Please check your panel. " +
                         "     <br/>" +
                         "     Please find the request details as given below: <br/><br/>" + details +
                         //"     <b>Username: </b> " + txtEmail.Value + " <br/>" +
                         //"     <b>Password: </b> " + txtPassword.Value + " <br/><br/>" +
                         "" +
                         "     Thanks" +
                         " </p>" +
                         " </div>";
        SendAlertEmail(MailSenderAddress, MailSenderAddress, subject, message);
    }
}