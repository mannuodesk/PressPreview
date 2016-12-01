using System;
using System.Collections;
using System.Collections.Specialized;
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
        
        NameValueCollection n = Request.QueryString;
        if (n.HasKeys())
        {
            LoadUserDataFromKey();
        }
        else
        {
            LoadUserData();
        }
        var al = new ArrayList { lblUsername, imgUserIcon };
        Common.UserSettings(al);
        if (!IsPostBack)
        {
            LoadEditorData();
            if (Common.Getunread_Messages() > 0)
            {
                lblTotalMessages.Visible = true;
                lblTotalMessages.Text = Common.Getunread_Messages().ToString();
            }

            if (Common.Getunread_Alerts() > 0)
            {
                lblTotalNotifications.Visible = true;
                lblTotalNotifications.Text = Common.Getunread_Alerts().ToString();
            }
        }
    }

    protected void LoadUserDataFromKey()
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
                if (Session["coverPicURL"] != "" && Session["coverPicURL"] != null)
                {
                    imgCover.ImageUrl = "../profileimages/" + Session["coverPicURL"].ToString();
                }
                else
                {
                    imgCover.ImageUrl = "../profileimages/" + dr[3].ToString();
                    Session["coverPicURL"] = imgCover.ImageUrl;
                }
                if (Session["profilePicURL"] != "" && Session["profilePicURL"] != null)
                {
                    imgProfile.ImageUrl = "../brandslogoThumb/" + Session["profilePicURL"].ToString();
                }
                else
                {
                    imgProfile.ImageUrl = "../brandslogoThumb/" + dr[4].ToString();
                    Session["profilePicURL"] = imgProfile.ImageUrl;
                }
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
            var db = new DatabaseManagement();
            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
            {
                string getUserData = string.Format("SELECT UserID, U_Email,U_Firstname,U_CoverPic,U_ProfilePic From Tbl_Users Where UserID={0}",
                                                   IEUtils.ToInt(httpCookie.Value));
                SqlDataReader dr = db.ExecuteReader(getUserData);
                if (dr.HasRows)
                {
                    dr.Read();
                    if (Session["coverPicURL"] != "" && Session["coverPicURL"] != null)
                    {
                        imgCover.ImageUrl = "../profileimages/" + Session["coverPicURL"].ToString();
                    }
                    else
                    {
                        imgCover.ImageUrl = "../profileimages/" + dr[3].ToString();
                        Session["coverPicURL"] = imgCover.ImageUrl;
                    }
                    if (Session["profilePicURL"] != "" && Session["profilePicURL"] != null)
                    {
                        imgProfile.ImageUrl = "../brandslogoThumb/" + Session["profilePicURL"].ToString();
                    }
                    else
                    {
                        imgProfile.ImageUrl = "../brandslogoThumb/" + dr[4].ToString();
                        Session["profilePicURL"] = imgProfile.ImageUrl;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    /*protected void btnChange_ServerClick(object sender, EventArgs e)
    {
        try
        {
            if (isPasswordCorrect(oldPassword.Value))
            {
                var httpCookie = Request.Cookies["FrUserID"];
                var db = new DatabaseManagement();
                if (httpCookie != null)
                {
                    string updateUserPassword = string.Format("Update Tbl_Users set U_Password={0} Where UserID={1}",
                                                       IEUtils.SafeSQLString(newPassword.Value), IEUtils.ToInt(httpCookie.Value));
                    db.ExecuteSQL(updateUserPassword);
                }
            }
        }
        catch (Exception exc)
        {

        }
    }
    private bool isPasswordCorrect(string password)
    {
        var httpCookie = Request.Cookies["FrUserID"];

        var db = new DatabaseManagement();
        if (httpCookie != null)
        {
            string getUserPassword = string.Format("SELECT U_Password From Tbl_Users Where UserID={0}",
                                               IEUtils.ToInt(httpCookie.Value));
            SqlDataReader dr = db.ExecuteReader(getUserPassword);
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    string passwordFromDB = dr["U_Password"].ToString();
                    if (passwordFromDB == password)
                    {
                        return true;
                    }
                    return false;
                }
            }
        }
        return false;
    }*/
    protected void LoadEditorData()
    {
        try
        {
            var db = new DatabaseManagement();
            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
            {
                string getEditorData = string.Format("SELECT EditorID,EditorKey,Firstname,Lastname,Country,Province,City," +
                                                     "PostalCode,Address1,HPhone,Email,WebUrl,FbURL,TwitterURL," +
                                                     "InstagramURL,Description,Org,Designation,Address2," +
                                                     "YoutubeURL,PinterestURL,ToProject,ECalendar From Tbl_Editors Where UserID={0}",
                                                     IEUtils.ToInt(httpCookie.Value));
                SqlDataReader dr = db.ExecuteReader(getEditorData);
                if (dr.HasRows)
                {
                    dr.Read();
                    txtfname.Value = dr[2].ToString();
                    txtlname.Value = dr[3].ToString();
                    txtCountry.Value = dr[4].ToString();
                    ddStates.SelectedValue = dr[5].ToString();
                    txtCity.Value = dr[6].ToString();
                    txtzip.Value = dr[7].ToString();
                    txtAddress1.Value = dr[8].ToString();
                    txtPhone.Value = dr[9].ToString();
                    txtEmail.Value = dr[10].ToString();
                    txtWeb.Value = dr[11].ToString();
                    txtFacebook.Value = dr[12].ToString();
                    txtTwitter.Value = dr[13].ToString();
                    txtInstagram.Value = dr[14].ToString();
                    txtAbout.Text =Server.HtmlDecode(dr[15].ToString());
                    txtorg.Value = dr[16].ToString();
                    txtdesig.Value = dr[17].ToString();
                    txtAddress2.Value = dr[18].ToString();
                    txtYoutube.Value = dr[19].ToString();
                    txtPinterest.Value = dr[20].ToString();
                    txtTop.Text = Server.HtmlDecode(dr[21].ToString());
                    txtECalendar.Text = Server.HtmlDecode(dr[22].ToString());

                }
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
            var db=new DatabaseManagement();
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
            // update user profile
            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
            {
                string updateUserProfile =
                       string.Format(
                           "Update Tbl_Users Set U_Firstname={0}, U_Lastname={1}, U_ProfilePic={2}, U_CoverPic={3}  Where UserID={4}",
                           IEUtils.SafeSQLString(txtfname.Value),
                           IEUtils.SafeSQLString(txtlname.Value),
                           IEUtils.SafeSQLString(Session["profilePicURL"].ToString()),
                           IEUtils.SafeSQLString(Session["coverPicURL"].ToString()),
                           IEUtils.ToInt(httpCookie.Value)

                           );
                db.ExecuteSQL(updateUserProfile);
            }

            // update brand profile
                   // string updateBrandProfile=string.Format("UPDATE Tbl_Brands set ")
            
            if (httpCookie != null)
            {
                string updateBrandProfile =
                    string.Format(
                        "Update Tbl_Editors Set Firstname={0}, Lastname={1},Description={2}," +
                        "Province={3},City={4},PostalCode={5},Address1={6}," +
                        "Address2={7},HPhone={8},Email={9},WebURL={10}," +
                        "DatePosted={11}, Org={12}, Designation={13}, ToProject={14}, ECalendar={15}, Country={16} " +
                        "Where UserID={17}",
                        IEUtils.SafeSQLString(txtfname.Value),
                        IEUtils.SafeSQLString(txtlname.Value),
                        IEUtils.SafeSQLString(Server.HtmlEncode(txtAbout.Text)),
                        IEUtils.SafeSQLString(ddStates.SelectedValue),
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
                        IEUtils.ToInt(httpCookie.Value)

                        );
                db.ExecuteSQL(updateBrandProfile);
            }
            Common.EmptyTextBoxes(this);
                    txtTop.Text = string.Empty;
                    txtECalendar.Text = string.Empty;
                    txtAbout.Text = string.Empty;
                    Response.Redirect("editor-profile.aspx");
                   // ErrorMessage.ShowSuccessAlert(lblStatus, "Your profile saved successfully", divAlerts);
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

            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
            {
                string updateBrandSocailLinks =
                    string.Format(
                        "Update Tbl_Editors Set InstagramURL={0}, TwitterURL={1},FbURL={2}," +
                        "YoutubeURL={3},PinterestURL={4} " +
                        "Where UserID={5}",
                IEUtils.SafeSQLString("www.instagram.com/" + txtInstagram.Value),
                        IEUtils.SafeSQLString("twitter.com/" + txtTwitter.Value),
                        IEUtils.SafeSQLString("www.facebook.com/" + txtFacebook.Value),
                        IEUtils.SafeSQLString("www.youtube.com/user/" + txtYoutube.Value),
                        IEUtils.SafeSQLString("www.pinterest.com/" + txtPinterest.Value),
                        IEUtils.ToInt(httpCookie.Value)

                        );
                db.ExecuteSQL(updateBrandSocailLinks);
                ErrorMessage.ShowSuccessAlert(lblSocialS, "Social Links saved successfully !", dvAlert2);
            }
            
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