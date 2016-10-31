using DLS.DatabaseServices;
using System;
using System.Collections;
using System.Data.SqlClient;
using System.IO;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class admin_home_Default : System.Web.UI.Page
{
    
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
                LoadUserData();
               
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void LoadUserData()
    {
        try
        {
            DatabaseManagement db = new DatabaseManagement();
            string selectQuery = string.Format("Select * From Tbl_Users Where UserID={0}",
                                               Convert.ToInt32(Request.Cookies["UserID"].Value));
            SqlDataReader dr = db.ExecuteReader(selectQuery);
            if (dr.HasRows)
            {
                dr.Read();
                txtUsername.Text = dr["U_Username"].ToString();
                txtFirstname.Text = dr["U_FirstName"].ToString();
                txtLastname.Text = dr["U_LastName"].ToString();
                txtEmail.Text = dr["U_Email"].ToString();
                imgProfile.ImageUrl = "../../brandslogoThumb/" + dr["U_ProfilePic"].ToString();
                imgPath.Text = dr["U_ProfilePic"].ToString();
                Session["UserEmail"] = dr["U_Email"].ToString();
                Session["Username"] = dr["U_FirstName"] + " " + dr["U_LastName"].ToString();
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
            string pic = string.Empty;
            if (fupProfile.HasFile)
            {
                string ext = Path.GetExtension(fupProfile.PostedFile.FileName);
                if (ext == ".jpg" || ext == ".jpeg" || ext == ".gif" || ext == ".png" || ext == ".bmp")
                {
                    var fname = Common.RandomPinCode() + ext;
                    var rootpath = Server.MapPath("../../profileimages/");
                    pic = fname;
                    var imagepath = rootpath + fname;
                    fupProfile.SaveAs(imagepath);
                    var thumbnail100 = Utility.GenerateThumbNail(fname, imagepath, "../brandslogoThumb/", 100, 100);
                }
                else
                {
                    ErrorMessage.ShowErrorAlert(lblStatus, "Invalid file format. Valid image formats are JPG,JPEG,PNG, GIF,BMP", divAlerts);
                }
            }
            else
            {
                pic = imgPath.Text;
            }

            string updateProfile = string.Format("Update Tbl_Users Set U_FirstName={0},U_LastName={1}," +
                                                 "U_Email={2}, U_ProfilePic={3} Where UserID={4}",
                                                   IEUtils.SafeSQLString(txtFirstname.Text),
                                                   IEUtils.SafeSQLString(txtLastname.Text),
                                                   IEUtils.SafeSQLString(txtEmail.Text),
                                                   IEUtils.SafeSQLString(pic),
                                                   IEUtils.ToInt(Request.Cookies["UserID"].Value)
                                                 );
            db.ExecuteSQL(updateProfile);
            ErrorMessage.ShowSuccessAlert(lblStatus, "Profile updated successfully.", divAlerts);
            LoadUserData();
            var alCommonControls = new ArrayList { lblUsername, imgUserphoto};
            Common.AdminSettings(alCommonControls);
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        try
        {
            if(txtnewpassword.Text=="")
                ErrorMessage.ShowErrorAlert(lblStatus, "Please enter new password.", divAlerts);
            else if(txtConfirmPassword.Text=="")
                ErrorMessage.ShowErrorAlert(lblStatus, "Please confirm new password.", divAlerts);
            else if(txtnewpassword.Text !=txtConfirmPassword.Text)
                ErrorMessage.ShowErrorAlert(lblStatus, "Confirm password does not match new password !.", divAlerts);
            else
            {
                var db = new DatabaseManagement();
                string updatePassword = string.Format("Update Tbl_Users Set U_Password={0} Where UserID={1}",
                                                      IEUtils.SafeSQLString(txtnewpassword.Text),
                                                      IEUtils.ToInt(Request.Cookies["UserID"].Value));
                db.ExecuteSQL(updatePassword);
                txtnewpassword.Text = "";
                txtConfirmPassword.Text = "";
                ErrorMessage.ShowSuccessAlert(lblStatus, "Password changed successfully.", divAlerts);
                tab2.HRef = "#edit-password";
            }
           
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
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