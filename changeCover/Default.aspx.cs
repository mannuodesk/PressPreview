using System;
using System.Collections;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using DLS.DatabaseServices;

public partial class pr_brand_myprofile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        LoadUserData();
    }
    protected void LoadUserData()
    {
        try
        {
            var db = new DatabaseManagement();
            string getUserData = string.Format("SELECT UserID, U_Email,U_Firstname,U_CoverPic,U_ProfilePic From Tbl_Users Where UserID={0}",
                                               IEUtils.ToInt(Session["UserID"]));
            SqlDataReader dr = db.ExecuteReader(getUserData);
            if (dr.HasRows)
            {
                dr.Read();
                imgCover.ImageUrl = "../profileimages/" + dr[3].ToString();
                imgProfile.ImageUrl = "../brandslogoThumb/" + dr[4].ToString();
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void btnUpload_OnClick(object sender, EventArgs e)
    {
        try
        {
            if (fupCover.HasFile)
            {
                var db = new DatabaseManagement();
                string fileExtension = Path.GetExtension(fupCover.PostedFile.FileName);
                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png" || fileExtension == ".gif" || fileExtension == ".pdf")
                {
                    var fname = Common.RandomPinCode() + fileExtension;
                    var rootpath = HttpContext.Current.Server.MapPath("../photobank/");
                    var imagepath = rootpath + fname;
                    fupCover.SaveAs(imagepath);

                    var thumbnail567 = Utility.GenerateThumbNail(fname, imagepath, "profileimages/", 1300, 300);
                    // WebCropImage2.Crop("~/profileimages\\" + fname );
                    string coverpic = fname;
                    // if both the images are selected
                    // update user profile
                    string updateUserProfile =
                      string.Format("UPDATE Tbl_Users Set U_CoverPic={0} Where UserID={1}",
                                    IEUtils.SafeSQLString(coverpic),
                                    IEUtils.ToInt(Session["UserID"].ToString()));
                    db.ExecuteSQL(updateUserProfile);

                }
                else
                {
                    ErrorMessage.ShowErrorAlert(lblStatus, "Please select a valid image file for cover photo.", divAlerts);
                }
            }
            else
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "Please select cover photo", divAlerts);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void btnSave_OnClick(object sender, EventArgs e)
    {

        var db = new DatabaseManagement();

        WebCropImage2.Crop(imgMain.ImageUrl);
        string coverpic = imgMain.ImageUrl;
        // if both the images are selected
        // update user profile
        string updateUserProfile =
          string.Format("UPDATE Tbl_Users Set U_CoverPic={0} Where UserID={1}",
                        IEUtils.SafeSQLString(coverpic),
                        IEUtils.ToInt(Session["UserID"].ToString()));
        db.ExecuteSQL(updateUserProfile);
    }
}