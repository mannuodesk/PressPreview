using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;

public partial class pr_brand_myprofile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if(!IsPostBack)
            LoadUserData();
    }

    protected void LoadUserData()
    {
        try
        {
            var db = new DatabaseManagement();
            string getUserData = string.Format("SELECT UserID, U_Email,U_Firstname,U_CoverPic,U_ProfilePic From Tbl_Users Where UserKey={0}",
                                               IEUtils.SafeSQLString(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(getUserData);
            if (dr.HasRows)
            {
                dr.Read();
                var aCookie = new HttpCookie("FrUserID") { Value = dr["UserID"].ToString() };
                HttpContext.Current.Response.Cookies.Add(aCookie);
                var UsernameCookie = new HttpCookie("Username") { Value = dr["U_FirstName"].ToString() };
                HttpContext.Current.Response.Cookies.Add(UsernameCookie);
                var emailCookie = new HttpCookie("UserEmail") { Value = dr["U_Email"].ToString() };
                HttpContext.Current.Response.Cookies.Add(emailCookie);
                txtEmail.Value = dr[1].ToString();
                Session["UserID"] = dr["UserID"].ToString();
                Session["Username"] = dr["U_FirstName"].ToString();
                Session["UserEmail"] = dr["U_Email"].ToString();
                imgCover.ImageUrl = "../profileimages/" + dr[3].ToString();
                imgProfile.ImageUrl = "../brandslogoThumb/" + dr[4].ToString();
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
            //string profilepic = string.Empty;
            //if(fupCover.HasFile)
            //{
            //    string fileExtension = Path.GetExtension(fupCover.PostedFile.FileName);
            //    if(fileExtension==".jpg" || fileExtension==".png" || fileExtension==".gif" || fileExtension==".pdf")
            //    {
            //        var fname = Common.RandomPinCode() + fileExtension;
            //        var rootpath = HttpContext.Current.Server.MapPath("../profileimages/");
            //        var imagepath = rootpath + fname;
            //        fupCover.SaveAs(imagepath);
            //        string coverpic = fname;

            //        // validate profile picture
            //        if (fupProfile.HasFile)
            //        {
            //            string profilefileExtension = Path.GetExtension(fupProfile.PostedFile.FileName);
            //            if (profilefileExtension == ".jpg" || profilefileExtension == ".png" || profilefileExtension == ".gif" || profilefileExtension == ".pdf")
            //            {
            //                var profilefname = Common.RandomPinCode() + profilefileExtension;
            //                var profilerootpath = HttpContext.Current.Server.MapPath("../profileimages/");
            //                var profileimagepath = profilerootpath + profilefname;
            //                fupProfile.SaveAs(profileimagepath);
            //                profilepic = profilefname;
            //            }
            //            else
            //            {
            //                ErrorMessage.ShowErrorAlert(lblStatus, "Please select a valid image file for profile photo.", divAlerts);
            //            }
            //        }
            //        else
            //        {
            //            ErrorMessage.ShowErrorAlert(lblStatus, "Please select profile photo", divAlerts);
            //        }

            //        // if both the images are selected
           
                string updateUserProfile =
                    string.Format("UPDATE Tbl_Users Set U_Firstname={0},U_Lastname={1} Where UserID={2}",
                                  IEUtils.SafeSQLString(txtfname.Value), IEUtils.SafeSQLString(txtlname.Value),
                                 IEUtils.SafeSQLString(Request.QueryString["v"]));
                db.ExecuteSQL(updateUserProfile);
            
            // update brand profile
            // string updateBrandProfile=string.Format("UPDATE Tbl_Brands set ")
            string updateBrandProfile =
                string.Format(
                    "Update Tbl_Editors Set Firstname={0}, Lastname={1},Description={2}," +
                    "Province={3},City={4},PostalCode={5},Address1={6}," +
                    "Address2={7},HPhone={8},Email={9},WebURL={10}," +
                    "DatePosted={11}, Org={12}, Designation={13}, ToProject={14}, ECalendar={15}, Country={16} " +
                    "Where UserID=(SELECT UserID From Tbl_Users Where UserKey={17})",
                    IEUtils.SafeSQLString(txtfname.Value),
                    IEUtils.SafeSQLString(txtlname.Value),
                    IEUtils.SafeSQLString(Server.HtmlEncode(txtAbout.Text)),
                    IEUtils.SafeSQLString(ddStates.Items[ddStates.SelectedIndex].Text),
                    IEUtils.SafeSQLString(txtCity.Value),
                    IEUtils.SafeSQLString(txtzip.Value),
                    IEUtils.SafeSQLString(txtAddress1.Value),
                    IEUtils.SafeSQLString(txtAddress2.Value),
                    IEUtils.SafeSQLString(txtPhone.Value),
                    IEUtils.SafeSQLString(txtEmail.Value),
                     IEUtils.SafeSQLString(txtWeb.Value),
                    "'" + DateTime.UtcNow + "'",
                    IEUtils.SafeSQLString(txtorg.Value),
                    IEUtils.SafeSQLString(txtdesig.Value),
                    IEUtils.SafeSQLString(Server.HtmlEncode(txtTop.Text)),
                    IEUtils.SafeSQLString(Server.HtmlEncode(txtECalendar.Text)),
                    IEUtils.SafeSQLString(txtCountry.Value),
                    IEUtils.SafeSQLString(Request.QueryString["v"])

                    );
            db.ExecuteSQL(updateBrandProfile);
            Common.EmptyTextBoxes(this);
            txtTop.Text = string.Empty;
            txtECalendar.Text = string.Empty;
            txtAbout.Text = string.Empty;
            Response.Redirect("../confirm.aspx");
           // ErrorMessage.ShowSuccessAlert(lblStatus, "Your Account has been created. An email will be sent to you after it is approved by the admin. Please do check your inbox, spam/bulk folder for the approval email", divAlerts);
            //    }
            //    else
            //    {
            //        ErrorMessage.ShowErrorAlert(lblStatus, "Please select a valid image file for cover photo.", divAlerts);
            //    }
            //}
            //else
            //{
            //    ErrorMessage.ShowErrorAlert(lblStatus,"Please select cover photo",divAlerts);
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
                    "Update Tbl_Editors Set InstagramURL={0}, TwitterURL={1},FbURL={2}," +
                    "YoutubeURL={3},PinterestURL={4} " +
                    "Where UserID=(SELECT UserID From Tbl_Users Where UserKey={5})",
                    IEUtils.SafeSQLString(txtInstagram.Value),
                    IEUtils.SafeSQLString(txtTwitter.Value),
                    IEUtils.SafeSQLString(txtFacebook.Value),
                    IEUtils.SafeSQLString(txtYoutube.Value),
                    IEUtils.SafeSQLString(txtPinterest.Value),
                    IEUtils.SafeSQLString(Request.QueryString["v"])

                    );
            db.ExecuteSQL(updateBrandSocailLinks);
            ErrorMessage.ShowSuccessAlert(lblSocialS, "Social Links saved successfully !", dvAlert2);
            // Common.EmptyTextBoxes(this);
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblSocialS, ex.Message, dvAlert2);
        }
    }
    // Top menu message list binding
    protected void rptMessageList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblDatePosted = (Label)e.Item.FindControl("lblDate");
                // Label lblDate2 = (Label)e.Item.FindControl("lblDate2");
                DateTime dbDate = Convert.ToDateTime(lblDatePosted.Text);
                lblDatePosted.Text = Common.GetRelativeTime(dbDate);

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