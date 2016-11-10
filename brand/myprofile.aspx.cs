using System;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;
using System.Globalization;

public partial class brandProfile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
        {
            LoadUserData();
        }
    }


    protected void LoadUserData()
    {
        try
        {
            SignedUpUser signedUpUser = (SignedUpUser)Session["signedUpUser"];
            txtEmail.Value = signedUpUser.email;
            if (signedUpUser.coverPicURL != "" && signedUpUser.coverPicURL != null)
            {
                imgCover.ImageUrl = "../profileimages/"+signedUpUser.coverPicURL;
            }
            if (signedUpUser.profilePicURL != "" && signedUpUser.profilePicURL!=null)
            {
                imgProfile.ImageUrl = "../brandslogoThumb/"+signedUpUser.profilePicURL;
            }
            var db = new DatabaseManagement();
            /* string getUserData = string.Format("SELECT UserID, U_Email,U_Firstname,U_CoverPic,U_ProfilePic From Tbl_Users Where UserKey={0}",
                                                IEUtils.SafeSQLString(Request.QueryString["v"]));
             SqlDataReader dr = db.ExecuteReader(getUserData);
             if(dr.HasRows)
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
                 imgCover.ImageUrl = "../profileimages/" + dr[3];
                 imgProfile.ImageUrl = "../brandslogoThumb/" + dr[4];
             }*/
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
             if (db.RecordExist("SELECT BrandID From Tbl_Brands Where Name=" + IEUtils.SafeSQLString(txtbname.Value)))
             {
                 ErrorMessage.ShowErrorAlert(lblStatus, "Brand name already exist. Try another name", divAlerts);
             } else
             {
                /* string updateBrandProfile =
               string.Format(
                   "Update Tbl_Brands Set Name={0}, Logo={1},Bio={2}," +
                   "Province={3},City={4},PostalCode={5},Address={6}," +
                   "Phone={7},Email={8},History={9},Url={10}," +
                   "DatePosted={11}, Org={12}, Designation={13}, Address2={14}, Country={15} " +
                   "Where UserID=(Select UserID From Tbl_Users Where UserKey={16})",
                   IEUtils.SafeSQLString(txtbname.Value),
                   IEUtils.SafeSQLString(profilepic),
                   IEUtils.SafeSQLString(txtAbout.Text),
                   IEUtils.SafeSQLString(ddStates.Items[ddStates.SelectedIndex].Text),
                   IEUtils.SafeSQLString(txtCity.Value),
                   IEUtils.SafeSQLString(txtzip.Value),
                   IEUtils.SafeSQLString(txtAddress1.Value),
                   IEUtils.SafeSQLString(txtPhone.Value),
                   IEUtils.SafeSQLString(txtEmail.Value),
                   IEUtils.SafeSQLString(txtHistory.Text),
                   IEUtils.SafeSQLString(txtWeb.Value),
                   "'" + DateTime.UtcNow + "'",
                   IEUtils.SafeSQLString(txtorg.Value),
                   IEUtils.SafeSQLString(txtdesig.Value),
                   IEUtils.SafeSQLString(txtAddress2.Value),
                   IEUtils.SafeSQLString(txtCountry.Value),
                   IEUtils.SafeSQLString(Request.QueryString["v"]));


                 db.ExecuteSQL(updateBrandProfile);

                 string updateUserProfile =
                     string.Format("Update Tbl_Users Set U_Firstname={0},U_Lastname={1} Where UserID=(Select UserID From Tbl_Users Where UserKey={2})",
                                   IEUtils.SafeSQLString(txtfname.Value), IEUtils.SafeSQLString(txtlname.Value),
                                   IEUtils.SafeSQLString(Request.QueryString["v"]));
                 db.ExecuteSQL(updateUserProfile);
                 Common.EmptyTextBoxes(this);
                 txtHistory.Text = string.Empty;
                 txtAbout.Text = string.Empty;*/
                 //string userkey = Encryption64.Encrypt(userId.ToString(CultureInfo.InvariantCulture)).Replace('+', '=');
                 int userId = db.GetMaxID("UserID", "Tbl_Users");
                 string userkey = Encryption64.Encrypt(userId.ToString(CultureInfo.InvariantCulture)).Replace('+', '=');
                 
                 SignedUpUser signedUpUser = (SignedUpUser)Session["signedUpUser"];
                 string profilePicURL="blank.png";
                 string coverPictureURL="brandimage.jpg";
                 if (signedUpUser.profilePicURL != "" && signedUpUser.profilePicURL!=null)
                 {
                     profilePicURL=signedUpUser.profilePicURL;
                 }
                 if (signedUpUser.coverPicURL != "" && signedUpUser.coverPicURL!=null)
                 {
                     coverPictureURL=signedUpUser.coverPicURL;
                 }
                 string insertQuery =
                         string.Format(
                             "INSERT INTO Tbl_Users(U_Username,U_Email,U_Password,U_Status,U_EmailStatus,U_ProfilePic,DateCreated,U_Firstname,U_Lastname,U_Type,U_CoverPic,UserKey) " +
                             "VALUES({0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11})",
                             IEUtils.SafeSQLString(signedUpUser.userName),
                             IEUtils.SafeSQLString(signedUpUser.email),
                             IEUtils.SafeSQLString(signedUpUser.password),
                             1,
                             1,
                             IEUtils.SafeSQLString(profilePicURL),
                             IEUtils.SafeSQLDate(DateTime.UtcNow),
                             IEUtils.SafeSQLString(txtfname.Value),
                             IEUtils.SafeSQLString(txtlname.Value),
                             IEUtils.SafeSQLString("Brand"),
                             IEUtils.SafeSQLString(coverPictureURL),
                             IEUtils.SafeSQLString(userkey)
                             );
                 db.ExecuteSQL(insertQuery);

                 int brandID = db.GetMaxID("BrandID", "Tbl_Brands");

                 string editorKey = Encryption64.Encrypt(brandID.ToString(CultureInfo.InvariantCulture)).Replace('+', '=');

                 string getUserId = string.Format("SELECT UserID From Tbl_Users Where UserKey={0}",
                                             "'"+userkey+"'");
                 int addeduserId = 0;
                 SqlDataReader dr = db.ExecuteReader(getUserId);
                 if (dr.HasRows)
                 {
                     dr.Read();
                     addeduserId = Convert.ToInt32(dr[0]);
                 }
                 dr.Close();
                 dr.Dispose();

                 insertQuery =
                    string.Format(
                        "INSERT INTO Tbl_Brands(BrandKey,UserID,DatePosted,Name,Logo,Bio,Province,City,PostalCode,Address,Phone,Email,History,Url,Org,Designation,Address2,Country,InstagramURL,TwitterURL,FbURL,YoutubeURL,PinterestURL) " +
                        "VALUES({0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13},{14},{15},{16},{17},{18},{19},{20},{21},{22})",
                        IEUtils.SafeSQLString(editorKey),
                        addeduserId,
                        IEUtils.SafeSQLDate(DateTime.UtcNow),
                        IEUtils.SafeSQLString(txtbname.Value),
                        IEUtils.SafeSQLString(profilePicURL),
                        IEUtils.SafeSQLString(txtAbout.Text),
                        IEUtils.SafeSQLString(ddStates.Items[ddStates.SelectedIndex].Text),
                        IEUtils.SafeSQLString(txtCity.Value),
                        IEUtils.SafeSQLString(txtzip.Value),
                        IEUtils.SafeSQLString(txtAddress1.Value),
                        IEUtils.SafeSQLString(txtPhone.Value),
                        IEUtils.SafeSQLString(txtEmail.Value),
                        IEUtils.SafeSQLString(txtHistory.Text),
                        IEUtils.SafeSQLString(txtWeb.Value),
                        IEUtils.SafeSQLString(txtorg.Value),
                        IEUtils.SafeSQLString(txtdesig.Value),
                        IEUtils.SafeSQLString(txtAddress2.Value),
                        IEUtils.SafeSQLString(txtCountry.Value),
                        IEUtils.SafeSQLString(txtInstagram.Value),
                        IEUtils.SafeSQLString(txtTwitter.Value),
                        IEUtils.SafeSQLString(txtFacebook.Value),
                        IEUtils.SafeSQLString(txtYoutube.Value),
                        IEUtils.SafeSQLString(txtPinterest.Value)
                        );
                 db.ExecuteSQL(insertQuery);
                 db._sqlConnection.Close();

                 Response.Redirect("../confirm.aspx");
             }
           
           // ErrorMessage.ShowSuccessAlert(lblStatus, "Your Account has been created. An email will be sent to you after it is approved by the admin. Please do check your inbox, spam/bulk folder for the approval email", divAlerts);

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
            var db=new DatabaseManagement();
            
            string updateBrandSocailLinks =
                string.Format(
                    "Update Tbl_Brands Set InstagramURL={0}, TwitterURL={1},FbURL={2}," +
                    "YoutubeURL={3},PinterestURL={4}  " +
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
    protected void rptMessageList_ItemCommand(object sender, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "2")
            {
                string[] messageIDs = e.CommandArgument.ToString().Split(',');
                var parentIDCookie = new HttpCookie("ParentId") { Value = messageIDs[0] };
                HttpContext.Current.Response.Cookies.Add(parentIDCookie);
                var messageIDCookie = new HttpCookie("MessageId") { Value = messageIDs[1] };
                HttpContext.Current.Response.Cookies.Add(messageIDCookie);

                var db = new DatabaseManagement();

                // update the status of the message to read
                db.ExecuteSQL(string.Format("Update Tbl_Mailbox Set MessageStatus={0} Where ParentID={1}",
                                            IEUtils.SafeSQLString("read"), IEUtils.ToInt(messageIDs[1])));
                Response.Redirect("massenger.aspx");
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    [WebMethod, ScriptMethod]
    public static void UpdateMessageStatus(string userID)
    {
        var db = new DatabaseManagement();
        string insertQuery = string.Format("UPDATE Tbl_MailboxFor Set ReadStatus={0} Where ReceiverID={1}",
                                           1, IEUtils.ToInt(userID));
        db.ExecuteSQL(insertQuery);


    }

    protected void rptNotifications_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var lblDatePosted = (Label)e.Item.FindControl("lblDatePosted");
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