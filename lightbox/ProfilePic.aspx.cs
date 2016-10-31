using System;
using System.IO;
using System.Web;
using DLS.DatabaseServices;

public partial class home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
               
            }
            catch (Exception ex)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
            
        }
    }


    protected void btnUpload_OnClick(object sender, EventArgs e)
    {
        try
        {
            if (fupCover.HasFile)
            {
                var db=new DatabaseManagement();
                string fileExtension = Path.GetExtension(fupCover.PostedFile.FileName);
                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png" || fileExtension == ".gif" || fileExtension == ".pdf")
                {
                    var fname = Common.RandomPinCode() + fileExtension;
                    var rootpath = HttpContext.Current.Server.MapPath("../photobank/");
                    var imagepath = rootpath + fname;
                    fupCover.SaveAs(imagepath);

                    var thumbnail567 = Utility.GenerateThumbNail(fname, imagepath, "../brandslogoThumb/", 100, 100);
                  // WebCropImage2.Crop("~/profileimages\\" + fname );
                    string coverpic = fname;
                    // if both the images are selected
                    // update user profile
                    string updateUserProfile =
                      string.Format("UPDATE Tbl_Users Set U_ProfilePic={0} Where UserID={1}",
                                    IEUtils.SafeSQLString(coverpic),
                                    IEUtils.ToInt(Session["UserID"].ToString()));
                    db.ExecuteSQL(updateUserProfile);

                }
                else
                {
                    ErrorMessage.ShowErrorAlert(lblStatus, "Please select a valid image file for profile photo.", divAlerts);
                }
            }
            else
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "Please select profile photo", divAlerts);
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