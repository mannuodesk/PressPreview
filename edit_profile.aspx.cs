using System.IO;
using System.Web;
using DLS.DatabaseServices;
using System;
using System.Data.SqlClient;

public partial class home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadBrandData();
            LoadUserData();
        }
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
    protected void LoadBrandData()
    {
        try
        {
            var db = new DatabaseManagement();
            string getBrandData = string.Format("SELECT BrandID,BrandKey,Name,Logo,Bio,Country,Province,City," +
                                                "PostalCode,Address,Phone,Email,Url,FbURL,TwitterURL," +
                                                "InstagramURL,History,Org,Designation,Address2," +
                                                "YoutubeURL,PinterestURL From Tbl_Brands Where UserID={0}",
                                               IEUtils.ToInt(Session["UserID"].ToString()));
            SqlDataReader dr = db.ExecuteReader(getBrandData);
            if (dr.HasRows)
            {
                dr.Read();
                txtbname.Value = dr[2].ToString();
                imgProfile.ImageUrl = "../brandslogoThumb/" + dr[3];
                txtAbout.Value = dr[4].ToString();
                txtCountry.Value = dr[5].ToString();
                ddStates.Value = dr[6].ToString();
                txtCity.Value = dr[7].ToString();
                txtzip.Value = dr[8].ToString();
                txtAddress1.Value = dr[9].ToString();
                txtPhone.Value = dr[10].ToString();
                txtEmail.Value = dr[11].ToString();
                txtWeb.Value = dr[12].ToString();
                txtFacebook.Value = dr[13].ToString();
                txtTwitter.Value = dr[14].ToString();
                txtInstagram.Value = dr[15].ToString();
                txtHistory.Value = dr[16].ToString();
                txtorg.Value = dr[17].ToString();
                txtdesig.Value = dr[18].ToString();
                txtAddress2.Value = dr[19].ToString();
                txtYoutube.Value = dr[20].ToString();
                txtPinterest.Value = dr[21].ToString();
              
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void btnSignup_ServerClick(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
            string profilepic = string.Empty;
            //if (fupCover.HasFile)
            //{
            //    string fileExtension = Path.GetExtension(fupCover.PostedFile.FileName);
            //    if (fileExtension == ".jpg" || fileExtension == ".png" || fileExtension == ".gif" || fileExtension == ".pdf")
            //    {
            //        var fname = Common.RandomPinCode() + fileExtension;
            //        var rootpath = HttpContext.Current.Server.MapPath("../profileimages/");
            //        var imagepath = rootpath + fname;
            //        fupCover.PostedFile.SaveAs(imagepath);
            //        string coverpic = fname;

                    // validate profile picture
                    //if (fupProfile.HasFile)
                    //{
                    //    string profilefileExtension = Path.GetExtension(fupProfile.PostedFile.FileName);
                    //    if (profilefileExtension == ".jpg" || profilefileExtension == ".png" || profilefileExtension == ".gif" || profilefileExtension == ".pdf")
                    //    {
                    //        var profilefname = Common.RandomPinCode() + profilefileExtension;
                    //        var profilerootpath = HttpContext.Current.Server.MapPath("../profileimages/");
                    //        var profileimagepath = profilerootpath + profilefname;
                    //        fupProfile.PostedFile.SaveAs(profileimagepath);
                    //        var thumbnail567 = Utility.GenerateThumbNail(fname, imagepath, "../brandslogoThumb/", 93);
                    //        profilepic = profilefname;
                    //    }
                    //    else
                    //    {
                    //        ErrorMessage.ShowErrorAlert(lblStatus, "Please select a valid image file for profile photo.", divAlerts);
                    //    }
                    //}
                    //else
                    //{
                    //    ErrorMessage.ShowErrorAlert(lblStatus, "Please select profile photo", divAlerts);
                    //}

                    // if both the images are selected
                    // update user profile
                    //string updateUserProfile =
                    //  string.Format("UPDATE Tbl_Users Set U_ProfilePic={0},U_CoverPic={1} Where UserID={2}",
                    //                IEUtils.SafeSQLString(profilepic), IEUtils.SafeSQLString(coverpic),
                    //                IEUtils.ToInt(Session["UserID"].ToString()));
                    //db.ExecuteSQL(updateUserProfile);

                    // update brand profile
                    // string updateBrandProfile=string.Format("UPDATE Tbl_Brands set ")
                    string updateBrandProfile =
                        string.Format(
                            "Update Tbl_Brands Set Name={0}, Logo={1},Bio={2}," +
                            "Province={3},City={4},PostalCode={5},Address={6}," +
                            "Phone={7},Email={8},History={9},Url={10}," +
                            "DatePosted={11}, Org={12}, Designation={13}, Address2={14} " +
                            "Where UserID={15}",
                            IEUtils.SafeSQLString(txtbname.Value),
                            IEUtils.SafeSQLString(profilepic),
                            IEUtils.SafeSQLString(txtAbout.Value),
                            IEUtils.SafeSQLString(ddStates.Value),
                            IEUtils.SafeSQLString(txtCity.Value),
                            IEUtils.SafeSQLString(txtzip.Value),
                            IEUtils.SafeSQLString(txtAddress1.Value),
                            IEUtils.SafeSQLString(txtPhone.Value),
                            IEUtils.SafeSQLString(txtEmail.Value),
                            IEUtils.SafeSQLString(txtHistory.Value),
                            IEUtils.SafeSQLString(txtWeb.Value),
                            "'" + DateTime.UtcNow + "'",
                            IEUtils.SafeSQLString(txtorg.Value),
                            IEUtils.SafeSQLString(txtdesig.Value),
                            IEUtils.SafeSQLString(txtAddress2.Value),
                            IEUtils.ToInt(Session["UserID"].ToString())

                            );
                    db.ExecuteSQL(updateBrandProfile);
                    Common.EmptyTextBoxes(this);
                    ErrorMessage.ShowSuccessAlert(lblStatus, "Congratulation. Your profile saved successfully", divAlerts);

            //    }
            //    else
            //    {
            //        ErrorMessage.ShowErrorAlert(lblStatus, "Please select a valid image file for cover photo.", divAlerts);
            //    }
            //}
            //else
            //{
            //    ErrorMessage.ShowErrorAlert(lblStatus, "Please select cover photo", divAlerts);
            //}
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void btnSubmit_Social_Links_OnServerClick(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();

            string updateBrandSocailLinks =
                string.Format(
                    "Update Tbl_Brands Set InstagramURL={0}, TwitterURL={1},FbURL={2}," +
                    "YoutubeURL={3},PinterestURL={4} " +
                    "Where UserID={5}",
                    IEUtils.SafeSQLString(txtInstagram.Value),
                    IEUtils.SafeSQLString(txtTwitter.Value),
                    IEUtils.SafeSQLString(txtFacebook.Value),
                    IEUtils.SafeSQLString(txtYoutube.Value),
                    IEUtils.SafeSQLString(txtPinterest.Value),
                   IEUtils.ToInt(Session["UserID"].ToString())

                    );
            db.ExecuteSQL(updateBrandSocailLinks);
            ErrorMessage.ShowSuccessAlert(lblStatus, "Socail Links saved successfully !", divAlerts);
            // Common.EmptyTextBoxes(this);
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
}