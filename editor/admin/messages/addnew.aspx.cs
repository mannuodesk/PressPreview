using DLS.DatabaseServices;
using System;
using System.Collections;
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
                ddCountry.DataSource = Utility.GetCountryList();
                ddCountry.DataBind();
                
            }
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
       
            if (db.RecordExist("SELECT BrandID From Tbl_Brands Where Name=" + IEUtils.SafeSQLString(txtBrandName.Value)))
                ErrorMessage.ShowErrorAlert(lblStatus, "Brand already exist. Please try different name.", divAlerts);
            else
            {
                updateQuery =
                    string.Format("INSERT INTO Tbl_Brands (Name,Logo,Bio,Country,Province,City,PostalCode,Address,Phone,Email,Url,FbURL,TwitterURL,InstagramURL,History,Story,DatePosted) VALUES({0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13},{14},{15},{16})",
                                  IEUtils.SafeSQLString(txtBrandName.Value),
                                  IEUtils.SafeSQLString(pic),
                                  IEUtils.SafeSQLString(txtBio.Value),
                                  IEUtils.SafeSQLString(ddCountry.SelectedValue),
                                  IEUtils.SafeSQLString(txtState.Value),
                                  IEUtils.SafeSQLString(txtCity.Value),
                                  IEUtils.SafeSQLString(txtPostalCode.Value),
                                  IEUtils.SafeSQLString(txtAddress.Value),
                                  IEUtils.SafeSQLString(txtPhone.Value),
                                  IEUtils.SafeSQLString(txtEmail.Value),
                                  IEUtils.SafeSQLString(txtBrandURL.Value),
                                  IEUtils.SafeSQLString(txtFbURL.Value),
                                  IEUtils.SafeSQLString(txtTwitterURL.Value),
                                  IEUtils.SafeSQLString(txtInstaURL.Value),
                                  IEUtils.SafeSQLString(txtBrandHistory.Value),
                                  IEUtils.SafeSQLString(txtBrandStory.Value),
                                  IEUtils.SafeSQLDate(DateTime.Now)

                        );
            }
        
        db.ExecuteSQL(updateQuery);
        string AddUser = string.Format("INSERT INTO Tbl_Users(U_Email,U_Username,U_Password,U_Type,U_Status,U_EmailStatus,DateCreated,U_ProfilePic) VALUES({0},{1},{2},{3},{4},{5},{6},{7})",
            IEUtils.SafeSQLString(txtEmail.Value),
            IEUtils.SafeSQLString(txtEmail.Value),
            IEUtils.SafeSQLString("Pass123"),
            IEUtils.SafeSQLString("Brand"),
            IEUtils.ToInt(1),
            IEUtils.ToInt(1),
            IEUtils.SafeSQLDate(DateTime.Now),
            IEUtils.SafeSQLString(pic));
        db.ExecuteSQL(AddUser);
        Common.EmptyTextBoxes(this);        
        ErrorMessage.ShowSuccessAlert(lblStatus, "Brand record Created.", divAlerts);

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
            if (fupLogo.Value=="")
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
                            fupLogo.PostedFile.SaveAs(imagepath);
                            var thumbnaillogo = Utility.GenerateThumbNail(fname, imagepath, "../brandslogoThumb/", 200,200);
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