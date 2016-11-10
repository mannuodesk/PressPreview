using System.Web;
using DLS.DatabaseServices;
using System;
using System.Data.SqlClient;
using System.Globalization;

public partial class frmlogin : System.Web.UI.Page 
{
    static readonly string MailSenderAddress = System.Configuration.ConfigurationManager.AppSettings["SenderEmail"];
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!IsPostBack)
        {
            if (Request.Cookies["UserName"] != null && Request.Cookies["Password"] != null)
            {
                var usernameCookie = Request.Cookies["UserName"];
                if (usernameCookie != null)
                {
                    var passcookie = Request.Cookies["Password"];
                    if (passcookie != null)
                        ValidateLogin(usernameCookie.Value,passcookie.Value);
                }
            }
        }

        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
    }

    protected void btnSignUp_ServerClick(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
            
                if (db.RecordExist("SELECT UserID From Tbl_Users Where U_Email=" + IEUtils.SafeSQLString(txtSignUpEmail.Value)))
                {
                    ErrorMessage.ShowErrorAlert(lblStatus, "Email already exist. Please try another email.", divAlerts);
                } else if (db.RecordExist("SELECT UserID From Tbl_Users Where U_Username=" + IEUtils.SafeSQLString(txtUsername.Value)))
                {
                    ErrorMessage.ShowErrorAlert(lblStatus, "Username already exist. Please try another username.", divAlerts);
                }
                else if(txtSignUpEmail.Value==string.Empty)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "Username is required.", divAlerts);
            } else if(txtSignUpPassword.Text==string.Empty)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "Password is required.", divAlerts);
            } else if(txtSignUpPassword.Text !=txtRpassword.Value)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "Re-typed password does not match with password.", divAlerts);
            }
                else
                {
                    SignedUpUser signedUpUser = new SignedUpUser();
                    signedUpUser.email = txtSignUpEmail.Value;
                    signedUpUser.password = txtSignUpPassword.Text;
                    signedUpUser.userName = txtUsername.Value;
                    int userId = db.GetMaxID("UserID", "Tbl_Users");
                    Session["signedUpUser"] = signedUpUser;
                    /*string userkey = Encryption64.Encrypt(userId.ToString(CultureInfo.InvariantCulture)).Replace('+', '=');
                    string insertQuery =
                            string.Format(
                                "INSERT INTO Tbl_Users(UserKey,U_Username,U_Email,U_Password,U_Status,U_EmailStatus,U_ProfilePic,DateCreated) " +
                                "VALUES({0},{1},{2},{3},{4},{5},{6},{7})",
                                IEUtils.SafeSQLString(userkey),
                                IEUtils.SafeSQLString(txtUsername.Value),
                                IEUtils.SafeSQLString(txtSignUpEmail.Value),
                                IEUtils.SafeSQLString(txtSignUpPassword.Text),
                                1,
                                1,
                                IEUtils.SafeSQLString("blank.png"),
                                IEUtils.SafeSQLDate(DateTime.UtcNow)
                                );
                    db.ExecuteSQL(insertQuery);*/
                 //   SendConfirmationEmail(userkey);
                    //SendActivationEmail();
                    //Response.Redirect("signup.aspx?k=" + userkey);
                    Response.Redirect("signup.aspx");
                   
                }
            

        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    private void SendConfirmationEmail(string userkey)
    {
        const string subject = "Confirm your registration";
        string message = @"<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'> " +
                        "<html xmlns='http://www.w3.org/1999/xhtml'>" +
                        "<head><title></title></head> <body>" +
                            "<div id='wrapper' style='width:700px;background-color: #E4E6E9; margin:0 auto; padding:30px 50px; border-top:1px solid #ddd; border-bottom:1px solid #ddd;'> " +
                            " <div id='logo' style='margin-bottom:20px;'>                                                                                                               " +
                           "     <h1>Press Preview</h1>                                                                                 " +
                            " </div>                                                                                                                                                    " +
                            " <div id='whitebox' style='background-color:#fff; padding:30px; margin-bottom:50px; border-radius: 7px;border: 1px solid #ccc;'>                                                                      " +
                            "     <h1>Welcome to Press Preview.</h1>                                                                                                                      " +
                            "       <p style='line-height:22px; text-align:justify;'>                                                                                                   " +
                            "                   Hello Member ! , <br/> <br />                                                                                                " +
                            "                   You are receiving this mail because you created an online account on our website. One more step of activation is required by                                             " +
                            "                   you before you get your own panel and customize every thing according to your need. Please click the link to confirm                                       " +
                           "                   <a href='http://presspreview.azurewebsites.net/confirm.aspx?ck=" + userkey + "&email=" + txtSignUpEmail.Value + "' target='_blank'>http://presspreview.azurewebsites.net/confirm.aspx?ck=" + userkey + "&email=" + txtSignUpEmail.Value + "</a>" +
                            "                   <br/> <br />                                                                                                                                  " +
                            "                   Please find your account details below: <br/><br/>                                                                                      " +
                            "                   <b>Username: </b> " + txtSignUpEmail.Value + " <br/>                                                                                          " +
                            "                   <b>Password: </b> " + txtSignUpPassword.Text + " <br/><br/>                                                                             " +
                            "                                                                                                                                                           " +
                            "                   Best wishes                                                                                                                                   " +
                            "               </p>                                                                                                                                        " +
                            " </div>                                                                                                                                                    " +
                            " <div id='footer' style='text-align:center'>                                                                                                               " +
                             "      <strong>Copyright</strong> Press Preview &copy; " + DateTime.Now.Year + "                                                                                                                          " +
                            " </div>                                                                                                                                                    " +
                         "</div>" +
                           "</body></html>"; 
        Auto_Mail.SendAlertEmail(MailSenderAddress, txtSignUpEmail.Value, subject, message);
    }
    private void SendActivationEmail()
    {
        const string subject = "New Customer Account Created";
        string message = @"<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'> " +
                        "<html xmlns='http://www.w3.org/1999/xhtml'>" +
                        "<head><title></title></head> <body>" +
                            "<div id='wrapper' style='width:700px;background-color: #E4E6E9; margin:0 auto; padding:30px 50px; border-top:1px solid #ddd; border-bottom:1px solid #ddd;'> " +
                            " <div id='logo' style='margin-bottom:20px;'>                                                                                                               " +
                          "     <h1>Press Preview</h1>                                                                                 " +
                            " </div>                                                                                                                                                    " +
                            " <div id='whitebox' style='background-color:#fff; padding:30px; margin-bottom:50px; border-radius: 7px;border: 1px solid #ccc;'>                                                                      " +
                            "     <h1>New Customer Account Created</h1>                                                                                                                      " +
                            "       <p style='line-height:22px; text-align:justify;'>                                                                                                   " +
                            "                   <span style='color:red;'>ATTENTION</span> Administrator, <br/> <br />                                                                                                " +
                            "                   This is to let you know that a new customer account has been created on your website . <br /> <br />                                           " +


                            "                   Please find customer details below: <br/><br/>                                                                                      " +
                            "                                                                                                           " +
                            "                   <b>Username: </b> " + txtSignUpEmail.Value + " <br/>                                                                                          " +
                            "                   <b>Password: </b> " + txtSignUpPassword.Text + "<br/>                                                                             " +
                              "                   <b>Date Created: </b> " + DateTime.UtcNow + " <br/><br/>                                                                             " +
                            "                                                                                                                                                           " +
                            "                   Thanks                                                                                                                                  " +
                            "               </p>                                                                                                                                        " +
                            " </div>                                                                                                                                                    " +
                            " <div id='footer' style='text-align:center'>                                                                                                               " +
                              "      <strong>Copyright</strong> Press Preview &copy; " + DateTime.Now.Year + "                                                                                                                          " +
                            " </div>                                                                                                                                                    " +
                         "</div>"+
                         "</body></html>"; 

        Auto_Mail.SendAlertEmail(MailSenderAddress, "info@temp-devs.com", subject, message);
    }
    protected void login_ServerClick(object sender, EventArgs e)
    {
        try
        {
            if (chkRemember.Checked)
            {
                //Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(7);
                //Response.Cookies["Password"].Expires = DateTime.Now.AddDays(7);

                Response.Cookies["UserName"].Value = txtLoginEmail.Text.Trim();
                Response.Cookies["Password"].Value = txtLoginPassword.Text.Trim();
            }
            else
            {
                Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(-1);
                Response.Cookies["Password"].Expires = DateTime.Now.AddDays(-1);

            }
            
            ValidateLogin(txtLoginEmail.Text,txtLoginPassword.Text);
            
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, "Incorrect username or password !", divAlerts);
        }
    }

    private void ValidateLogin(string username,string password)
    {
        var db = new DatabaseManagement();
        string selectQuery =
            string.Format(
                "SELECT Tbl_Users.UserID,U_FirstName + ' ' + U_Lastname as [U_Firstname],U_Status,U_EmailStatus,U_Email, U_Type,IsApproved  FROM Tbl_Users  Where (U_Username={0} OR U_Email={1}) AND U_Password={2}  ",
                IEUtils.SafeSQLString(username),
                IEUtils.SafeSQLString(username),
                IEUtils.SafeSQLString(password)
                );
        SqlDataReader dr = db.ExecuteReader(selectQuery);
        if (dr.HasRows)
        {
            dr.Read();
            if (dr["U_Status"].ToString() == "0")
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "Your account is blocked. Please contact the website administrator. ",
                                            divAlerts);
            }
            else
            {
                
                    if (dr.IsDBNull(6))
                    {
                        ErrorMessage.ShowErrorAlert(lblStatus, "Your account is pending for approval. ", divAlerts);
                    }
                    else
                    {
                        var aCookie = new HttpCookie("FrUserID") {Value = dr["UserID"].ToString()};
                        HttpContext.Current.Response.Cookies.Add(aCookie);
                        var UsernameCookie = new HttpCookie("Username") {Value = dr["U_FirstName"].ToString()};
                        HttpContext.Current.Response.Cookies.Add(UsernameCookie);
                        var emailCookie = new HttpCookie("UserEmail") {Value = dr["U_Email"].ToString()};
                        HttpContext.Current.Response.Cookies.Add(emailCookie);
                        var viewpnl = new HttpCookie("viewpnl") { Value = "1" };
                        HttpContext.Current.Response.Cookies.Add(viewpnl);
                        Session["selectedFolder"] = "1";
                        Session["RUsername"] = "";
                        switch (dr["U_Type"].ToString())
                        {
                            
                            case "Brand":
                                
                                Session["UserID"] = dr["UserID"].ToString();
                                Session["Username"] = dr["U_FirstName"].ToString();
                                Session["UserEmail"] = dr["U_Email"].ToString();
                                Response.Redirect("brand/profile-page-items.aspx");
                                break;
                            case "Editor":
                                Session["UserID"] = dr["UserID"].ToString();
                                Session["Username"] = dr["U_FirstName"].ToString();
                                Session["UserEmail"] = dr["U_Email"].ToString();
                                Response.Redirect("editor/");
                                break;
                        }

                        
                    }
               
            }
        }
        else
        {
            ErrorMessage.ShowErrorAlert(lblStatus, "Incorrect username or password !", divAlerts);
        }
    }
}