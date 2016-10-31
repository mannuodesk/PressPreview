using DLS.DatabaseServices;
using System;
using System.Collections;
using System.Data.SqlClient;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;


public partial class admin_home_Default : System.Web.UI.Page
{
    static readonly string MailSenderAddress = System.Configuration.ConfigurationManager.AppSettings["SenderEmail"];
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                if (Common.Getunread_Alerts() > 0)
                {
                    lblTotalNotifications.Visible = true;
                    lblTotalNotifications.Text = Common.Getunread_Alerts().ToString();
                }
                var alCommonControls = new ArrayList { lblUsername, imgUserphoto };
                Common.AdminSettings(alCommonControls);
                LoadData();
               
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }


    protected void LoadData()
    {
        try
        {
            var db = new DatabaseManagement();
            string selectQuery = string.Format("SELECT  Name,U_Firstname,U_Lastname,U_ProfilePic,Bio," +
                                               "Country,Province,City,PostalCode, Address,Phone," +
                                               "Email,Url, InstagramURL,TwitterURL,FbURL," +
                                               "YoutubeURL,PinterestURL,History,Org,Designation " +
                                               " FROM Tbl_Brands INNER JOIN Tbl_Users " +
                                               "ON Tbl_Brands.UserID=Tbl_Users.UserID  " +
                                               "Where Tbl_Brands.UserID={0}", IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(selectQuery);
            if (dr.HasRows)
            {
                dr.Read();
                txtBrandName.Value = dr[0].ToString();
                txtFirstname.Value = dr[1].ToString();
                txtLastname.Value = dr[2].ToString();
                Session["CurrentBrand"] = dr[0].ToString();
                lblImageName.Text = dr[3].ToString();
                imgLogo.ImageUrl = "../../brandslogoThumb/" + dr[3];
                txtBio.Value = dr[4].ToString();
                txtCountry.Value = dr[5].ToString();
                txtState.Value = dr[6].ToString();
                txtCity.Value = dr[7].ToString();
                txtPostalCode.Value = dr[8].ToString();
                txtAddress.Value = dr[9].ToString();
                txtPhone.Value = dr[10].ToString();
                txtEmail.Value = dr[11].ToString();
                txtBrandURL.Value = dr[12].ToString();
                txtInstaURL.Value = dr[13].ToString();
                txtTwitterURL.Value = dr[14].ToString();
                txtFbURL.Value = dr[15].ToString();
                txtYoutube.Value = dr[16].ToString();
                txtPinterest.Value = dr[17].ToString();
                txtBrandHistory.Value = dr[18].ToString();
                txtOrg.Value = dr[19].ToString();
                txtDesignation.Value = dr[20].ToString();



            }
            dr.Close();
            string usersettings = string.Format("SELECT U_Status, U_EmailStatus,UserKey,U_Username From Tbl_Users Where UserID={0}", IEUtils.ToInt(Request.QueryString["v"]));
            dr = db.ExecuteReader(usersettings);
            if (dr.HasRows)
            {
                dr.Read();
                Session["userkey"] = dr[2];
                Session["Username"] = dr[3];

            }
            dr.Close();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Default.aspx");
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    private void UpdateQuery(DatabaseManagement db)
    {
        if(db.RecordExist("SELECT BrandID From Tbl_Brands Where Name IS NOT NULL AND Org IS NOT NULL AND Designation IS NOT NULL AND UserID=" +IEUtils.ToInt(Request.QueryString["v"]) ))
        {
            string ApproveBrand = string.Format("Update Tbl_Users Set IsApproved=1 Where UserID={0}",
                                            IEUtils.ToInt(Request.QueryString["v"]));
            db.ExecuteSQL(ApproveBrand);
            SendApprovalEmail(Session["userkey"].ToString(), Session["Username"].ToString());
            Common.EmptyTextBoxes(this);
            Response.Redirect("../home/");
        }
        else
        {
            ErrorMessage.ShowErrorAlert(lblStatus, "Incomplete Brand profile information.Brand account can not be approved.", divAlerts); 
        }
        

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
            UpdateQuery(db);
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    private void SendApprovalEmail(string userkey,string username)
    {
        const string subject = "Your Press Preview Account Approved";
        string message = @"<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'> " +
                        "<html xmlns='http://www.w3.org/1999/xhtml'>" +
                        "<head><title></title></head> <body>"+
                        "<div id='wrapper' style='width:700px;background-color: #E4E6E9; margin:0 auto; padding:20px 50px; border-top:1px solid #ddd; border-bottom:1px solid #ddd;'> " +
                            " <div id='logo' style='margin-bottom:20px;'>                                                                                                               " +
                          "     <h1><a href='http://presspreview.azurewebsites.net'><img src='http://presspreview.azurewebsites.net/images/logo.png' alt='thePRESSPreview' /></a></h1>                                                                                 " +
                            " </div>                                                                                                                                                    " +
                            "<div><img src='http://presspreview.azurewebsites.net/photobank/banner.jpg' alt='' style='width:700px; height:200px;'/></div> " +
                            " <div id='whitebox' style='background-color:#fff; padding:20px; margin-bottom:50px; border-radius: 7px;border: 1px solid #ccc;'>                        " +
                            "     <h1>Congratulations !</h1>                                                                                                                      " +
                            "       <p style='line-height:22px; text-align:justify;'>                                                                                                   " +
                            "                   <span style='color:red;'>HELLO</span> " + username + " <br/> <br />                                                                                                " +
                            "                   This is to let you know that your account created on our website has been approved by the administrator.  <br />                                           " +


                            "                   Please click on the following link to complete your profile: <br/><br/>                                                                                      " +
                            "                                                                                                           " +
                              "                   <a href='http://presspreview.azurewebsites.net/brand/profile-page-items.aspx?v=" + userkey + "' target='_blank'>http://presspreview.azurewebsites.net/brand/profile-page-items.aspx?v=" + userkey + "</a>" +
                   
                            
                            "                  <br/> <br/> Thanks                                                                                                                                  " +
                            "               </p>                                                                                                                                        " +
                            " </div>                                                                                                                                                    " +
                            " <div id='footer' style='text-align:center;  background-color:#000; height:30px; color:#fff;'>                                                                                                               " +
                              "      <strong>Copyright</strong> Press Preview &copy; " + DateTime.Now.Year + "                                                                                                                          " +
                            " </div>                                                                                                                                                    " +
                         "</div>" +
                         "</body></html>";

        Auto_Mail.SendAlertEmail(MailSenderAddress, txtEmail.Value, subject, message);
    }
    protected void grdNotifications_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var lblDatePosted = (Label)e.Row.FindControl("lblDatePosted");
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
}