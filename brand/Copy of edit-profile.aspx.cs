﻿using System.Collections;
using System.Collections.Specialized;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;
using System;
using System.Data.SqlClient;

public partial class home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        NameValueCollection n = Request.QueryString;
        if(n.HasKeys())
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
            LoadBrandData();
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
        txtbname.Focus();
        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
        
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
                imgCover.ImageUrl = "../profileimages/" + dr[3].ToString();
                imgProfile.ImageUrl = "../brandslogoThumb/" + dr[4].ToString();
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
            var httpCookie = Request.Cookies["FrUserID"];
            
            var db = new DatabaseManagement();
            if (httpCookie != null)
            {
                string getUserData = string.Format("SELECT UserID, U_Email,U_Firstname,U_CoverPic,U_ProfilePic From Tbl_Users Where UserID={0}",
                                                   IEUtils.ToInt(httpCookie.Value));
                SqlDataReader dr = db.ExecuteReader(getUserData);
                if (dr.HasRows)
                {
                    dr.Read();
                    imgCover.ImageUrl = "../profileimages/" + dr[3];
                    imgProfile.ImageUrl = "../brandslogoThumb/" + dr[4];
                }
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
            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
            {
                string getBrandData = string.Format("SELECT BrandID,BrandKey,Name,Logo,Bio,Country,Province,City," +
                                                    "PostalCode,Address,Phone,Email,Url,FbURL,TwitterURL," +
                                                    "InstagramURL,History,Org,Designation,Address2," +
                                                    "YoutubeURL,PinterestURL,U_Firstname,U_Lastname,U_ProfilePic From Tbl_Brands INNER JOIN Tbl_Users ON Tbl_Brands.UserID=Tbl_Users.UserID  Where Tbl_Brands.UserID={0}",
                                                    IEUtils.ToInt(httpCookie.Value));
                SqlDataReader dr = db.ExecuteReader(getBrandData);
                if (dr.HasRows)
                {
                    dr.Read();
                    txtbname.Value = dr[2].ToString();
                    imgProfile.ImageUrl = "../brandslogoThumb/" + dr[24];
                    txtAbout.Text = dr[4].ToString();
                    txtCountry.Value = dr[5].ToString();
                    ddStates.SelectedValue = dr[6].ToString();
                    txtCity.Value = dr[7].ToString();
                    txtzip.Value = dr[8].ToString();
                    txtAddress1.Value = dr[9].ToString();
                    txtPhone.Value = dr[10].ToString();
                    txtEmail.Value = dr[11].ToString();
                    txtWeb.Value = dr[12].ToString();
                    txtFacebook.Value = dr[13].ToString();
                    txtTwitter.Value = dr[14].ToString();
                    txtInstagram.Value = dr[15].ToString();
                    txtHistory.Text = dr[16].ToString();
                    txtorg.Value = dr[17].ToString();
                    txtdesig.Value = dr[18].ToString();
                    txtAddress2.Value = dr[19].ToString();
                    txtYoutube.Value = dr[20].ToString();
                    txtPinterest.Value = dr[21].ToString();
                    txtfname.Value = dr[22].ToString();
                    txtlname.Value = dr[23].ToString();

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
            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
            {
                string updateBrandProfile =
                    string.Format(
                        "Update Tbl_Brands Set Name={0}, Logo={1},Bio={2}," +
                        "Province={3},City={4},PostalCode={5},Address={6}," +
                        "Phone={7},Email={8},History={9},Url={10}," +
                        "DatePosted={11}, Org={12}, Designation={13}, Address2={14}, Country={15} " +
                        "Where UserID={16}",
                        IEUtils.SafeSQLString(txtbname.Value),
                        IEUtils.SafeSQLString(profilepic),
                        IEUtils.SafeSQLString(txtAbout.Text),
                        IEUtils.SafeSQLString(ddStates.SelectedValue),
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
                        IEUtils.ToInt(httpCookie.Value)

                        );
                db.ExecuteSQL(updateBrandProfile);
                string updateUserInfo =
                       string.Format(
                           "Update Tbl_Users Set U_Firstname={0}, U_Lastname={1} Where UserID={2}",
                           IEUtils.SafeSQLString(txtfname.Value),
                           IEUtils.SafeSQLString(txtlname.Value),
                           IEUtils.ToInt(httpCookie.Value)

                           );
                db.ExecuteSQL(updateUserInfo);
                Response.Redirect("profile-page-items.aspx");
            }
           

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

            var httpCookie = Request.Cookies["FrUserID"];
            if (httpCookie != null)
            {
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
                        IEUtils.ToInt(httpCookie.Value)

                        );
                db.ExecuteSQL(updateBrandSocailLinks);
            }
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

    //protected void upload_btn_OnClick(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        Boolean FileOK = false;
    //        Boolean FileSaved = false;
    //        if (photo.HasFile)
    //        {
    //            //  var db = new DatabaseManagement();
                
    //            string fileExtension = Path.GetExtension(photo.PostedFile.FileName);
    //            if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png" || fileExtension == ".gif" || fileExtension == ".pdf")
    //            {
    //                var fname = Common.RandomPinCode() + fileExtension;
    //                Session["WorkingImage"] = "../photobank/" +fname;
    //                var rootpath = HttpContext.Current.Server.MapPath("../photobank/");
    //                var imagepath = rootpath + fname;
    //                photo.SaveAs(imagepath);
    //                //pnlUpload.Visible = false;
    //                //pnlCrop.Visible = true;
    //                //imgCrop.ImageUrl = imagepath;
    //                //imgCover.ImageUrl = "../photobank/" + fname;
    //                string jsFunc = "show_popup_crop(" + imagepath + ")";
    //                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "myJsFn", jsFunc, true);
    //                //// var thumbnail567 = Utility.GenerateThumbNail(fname, imagepath, "../profileimages/", 1300, 300);
    //                // WebCropImage2.Crop("~/profileimages\\" + fname );
    //                //// string coverpic = fname;
    //                // if both the images are selected
    //                // update user profile
    //                //string updateUserProfile =
    //                //  string.Format("UPDATE Tbl_Users Set U_CoverPic={0} Where UserID={1}",
    //                //                IEUtils.SafeSQLString(coverpic),
    //                //                IEUtils.ToInt(Session["UserID"].ToString()));
    //                //db.ExecuteSQL(updateUserProfile);

                     


    //            }
    //            else
    //            {
    //                ErrorMessage.ShowErrorAlert(lblStatus, "Please select a valid image file for cover photo.", divAlerts);
    //            }
    //        }
    //        else
    //        {
    //            ErrorMessage.ShowErrorAlert(lblStatus, "Please select cover photo", divAlerts);
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
    //    }
    //}
   
}