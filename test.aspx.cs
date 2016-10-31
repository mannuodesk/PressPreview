using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class test : System.Web.UI.Page
{
    static readonly string MailSenderAddress = System.Configuration.ConfigurationManager.AppSettings["SenderEmail"];
    protected void Page_Load(object sender, EventArgs e)
    {
        // Response.Redirect("../itemview2/21");

        string[] userdetails = new string[4];
        userdetails[0] = "abc123";
        userdetails[1] = "123abc";
        SendConfirmationEmail("asadabd", userdetails);
      //  const string body = @"<div id='wrapper' style='width:700px;background-color: #E4E6E9; margin:0 auto; padding:30px 50px; border-top:1px solid #ddd; border-bottom:1px solid #ddd;'> This is test body </div>";
      //bool isSent=  Auto_Mail.SendAlertEmail(MailSenderAddress, "ifalcons2014@gmail.com", "Please check in inbox", body);
      //  Auto_Mail.SendAlertEmail(MailSenderAddress, "mushtaqbunir@gmail.com", "Please check in inbox", body);
        
    }

    private void SendConfirmationEmail(string userkey, string[] userdetails)
    {
        const string subject = "Confirm your registration";
        StringBuilder sb = new StringBuilder();
        sb.Append(
            "<div id='wrapper' style='width:700px;background-color: #E4E6E9; margin:0 auto; padding:30px 50px; border-top:1px solid #ddd; border-bottom:1px solid #ddd;'> " +
            " <div id='logo' style='margin-bottom:20px;'>                                                                                                               " +
            "     <h1>Press Preview</h1>                                                                                 " +
            " </div>                                                                                                                                                    " +
            " <div id='whitebox' style='background-color:#fff; padding:30px; margin-bottom:50px; border-radius: 7px;border: 1px solid #ccc;'>                                                                      " +
            "     <h1>Welcome to Press Preview.</h1>                                                                                                                      " +
            "       <p style='line-height:22px; text-align:justify;'>                                                                                                   " +
            "                   Hello Ibrar" + //txtfname.Value +
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
        bool isSent = Auto_Mail.SendAlertEmail(MailSenderAddress, "ifalcons2014@gmail.com", subject, sb.ToString());
        Auto_Mail.SendAlertEmail(MailSenderAddress, "mushtaqbunir@gmail.com", subject, sb.ToString());
        if (isSent)
            lblSent.Text = "Email Sent";
        else
        {
            lblSent.Text = "Email sending failed;";
        }
    }
}