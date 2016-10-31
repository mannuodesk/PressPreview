using System.IO;
using DLS.DatabaseServices;
using System;
using System.Collections;
using System.Data.SqlClient;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class admin_home_Default : System.Web.UI.Page
{
    string currentLogo = string.Empty;
        
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
                //ddCountry.DataSource = Utility.GetCountryList();
                //ddCountry.DataBind();
              
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
            DatabaseManagement db = new DatabaseManagement();
            string selectQuery = string.Format("SELECT * From Tbl_Editors Where EditorID={0}", IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(selectQuery);
            if(dr.HasRows)
            {
                dr.Read();
                txtFirstName.Value = dr[2].ToString();
                txtLastname.Value = dr[3].ToString();
                txtOrg.Value = dr[5].ToString();
                txtDesignation.Value = dr[6].ToString();
                txtCountry.Value = dr[7].ToString();
                txtState.Value = dr[8].ToString();
                txtCity.Value = dr[9].ToString();
                txtPostalCode.Value = dr[10].ToString();
                txtAddress.Value = dr[11].ToString();
                txtHPhone.Value = dr[13].ToString();
                txtEmail.Value = dr[16].ToString();
                txtEditorURL.Value = dr[17].ToString();
                txtFbURL.Value = dr[18].ToString();
                txtTwitterURL.Value = dr[19].ToString();
                txtInstaURL.Value = dr[20].ToString();
                txtDescription.Text = dr[21].ToString();
                txtTop.Text = dr[25].ToString();
                txtEcalender.Text = dr[26].ToString();
                txtYoutube.Value = dr[27].ToString();
                txtPinterest.Value = dr[28].ToString();

            }
            dr.Close();
            string usersettings = string.Format("SELECT U_Status, U_EmailStatus,U_ProfilePic From Tbl_Users Where UserID=(SELECT UserID From Tbl_Editors Where EditorID={0})", IEUtils.ToInt(Request.QueryString["v"]));
            dr = db.ExecuteReader(usersettings);
            if(dr.HasRows)
            {
                dr.Read();
                ddAccountStatus.SelectedValue = dr[0].ToString();
                lblImageName.Text = dr[2].ToString();
                imgLogo.ImageUrl = "../../brandslogoThumb/" + dr[2].ToString();
                //ddEmailStatus.SelectedValue = dr[1].ToString();
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
    private void UpdateQuery(string pic, DatabaseManagement db)
    {
        string updateQuery = string.Empty;
        
                updateQuery =
                    string.Format("Update Tbl_Editors Set Firstname={0},Lastname={1},Org={2},Designation={3},Country={4}," +
                                  "Province={5},City={6},PostalCode={7},Address1={8},HPhone={9},Email={10},WebURL={11}, FbURL={12},TwitterURL={13},InstagramURL={14},Description={15},DateModified={16},ToProject={17},ECalendar={18},YoutubeURL={19},PinterestURL={20}  Where EditorID={21}",
                                  IEUtils.SafeSQLString(txtFirstName.Value),
                                  IEUtils.SafeSQLString(txtLastname.Value),
                                  IEUtils.SafeSQLString(txtOrg.Value),
                                  IEUtils.SafeSQLString(txtDesignation.Value),
                                  IEUtils.SafeSQLString(txtCountry.Value),
                                  IEUtils.SafeSQLString(txtState.Value),
                                  IEUtils.SafeSQLString(txtCity.Value),
                                  IEUtils.SafeSQLString(txtPostalCode.Value),
                                  IEUtils.SafeSQLString(txtAddress.Value),
                                  IEUtils.SafeSQLString(txtHPhone.Value),
                                 
                                  IEUtils.SafeSQLString(txtEmail.Value),
                                  IEUtils.SafeSQLString(txtEditorURL.Value),
                                  IEUtils.SafeSQLString(txtFbURL.Value),
                                  IEUtils.SafeSQLString(txtTwitterURL.Value),
                                  IEUtils.SafeSQLString(txtInstaURL.Value),
                                  IEUtils.SafeSQLString(txtDescription.Text),
                                  IEUtils.SafeSQLDate(DateTime.Now),
                                  IEUtils.SafeSQLString(txtTop.Text),
                                  IEUtils.SafeSQLString(txtEcalender.Text),
                                  IEUtils.SafeSQLString(txtYoutube.Value),
                                  IEUtils.SafeSQLString(txtPinterest.Value),
                                  IEUtils.SafeSQLString(Request.QueryString["v"].Trim())

                        );
          
        db.ExecuteSQL(updateQuery);
        string AddUser = string.Format("UPDATE Tbl_Users Set U_Email={0},U_Status={1},U_ProfilePic={2} WHERE UserID=(SELECT UserID From Tbl_Editors Where EditorID={3})",
             IEUtils.SafeSQLString(txtEmail.Value),
             IEUtils.ToInt(ddAccountStatus.SelectedValue),
             IEUtils.SafeSQLString(pic),
             IEUtils.SafeSQLString(Request.QueryString["v"].Trim()));
        db.ExecuteSQL(AddUser);
        Common.EmptyTextBoxes(this);
       Response.Redirect("Default.aspx");

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
            if (!fupLogo.HasFile)
                UpdateQuery(lblImageName.Text, db);
            else
            {
                string ext = Path.GetExtension(fupLogo.PostedFile.FileName);
                switch (ext)
                {
                    case ".bmp":
                    case ".png":
                    case ".gif":
                    case ".jpeg":
                    case ".jpg":
                        {
                            var fname = Common.RandomPinCode() + ext;
                            var rootpath = Server.MapPath("../../brandslogo/");
                            var imagepath = rootpath + fname;
                            fupLogo.SaveAs(imagepath);
                            var thumbnaillogo = Utility.GenerateThumbNail(fname, imagepath, "../brandslogoThumb/", 200, 200);
                            UpdateQuery(fname, db);
                        }
                        break;
                    default:
                        ErrorMessage.ShowErrorAlert(lblStatus,
                                                    "Invalid file format. Valid image formats are JPG,JPEG,PNG, GIF,BMP",
                                                    divAlerts);
                        break;
                }
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