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
                LoadSliderData();

            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }


    protected void LoadSliderData()
    {
        try
        {
            var db = new DatabaseManagement();
            string selectQuery = string.Format("SELECT BannerID,BannerImg,BannerLink FROM Tbl_ActivityBanners  Where BannerID={0}",
                                                IEUtils.SafeSQLString(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(selectQuery);
            if (dr.HasRows)
            {
                dr.Read();
                imgCurrent.ImageUrl = "../../imgSmall/" + dr[1].ToString();
                lblimagename.Text = dr[1].ToString();
                txtLink.Text = dr[2].ToString();
            }
            dr.Close();
            dr.Dispose();
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
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
    private void UpdateQuery(DatabaseManagement db)
    {
        if (fup1.HasFile)
        {
            string ext = Path.GetExtension(fup1.PostedFile.FileName);
            if (ext == ".jpg" || ext == ".jpeg" || ext == ".gif" || ext == ".png" || ext == ".bmp")
            {
                if (fup1.PostedFile.ContentLength > 0 && fup1.PostedFile.ContentLength <= 3145728)
                {
                    var fname = Common.RandomPinCode() + ext;
                    var rootpath = Server.MapPath("../../photobank/");
                    var imagepath = rootpath + fname;
                    fup1.SaveAs(imagepath);
                    var thumbnail820 = Utility.GenerateThumbNail(fname, imagepath, "../imgSmall/", 200);
                    string insertQuery = string.Format("Update Tbl_ActivityBanners set BannerImg={0},BannerLink={1} WHERE BannerID={2}",
               IEUtils.SafeSQLString(fname),
               IEUtils.SafeSQLString(txtLink.Text),
               IEUtils.ToInt(Request.QueryString["v"]));
                    db.ExecuteSQL(insertQuery);
                    db._sqlConnection.Close();
                    db._sqlConnection.Dispose();
                    File.Delete(lblimagename.Text);

                }
                else
                {
                    ErrorMessage.ShowErrorAlert(lblStatus, "Maximum size exceeded. Please ensure your image is less than 3MB", divAlerts);
                }
            }
            else
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "Invalid file format. Valid image formats are JPG,JPEG,PNG, GIF,BMP", divAlerts);
            }

        }
        else
        {
            string insertQuery = string.Format("Update Tbl_ActivityBanners set BannerImg={0},BannerLink={1} WHERE BannerID={2}",
              IEUtils.SafeSQLString(lblimagename.Text),
              IEUtils.SafeSQLString(txtLink.Text),
              IEUtils.SafeSQLString(Request.QueryString["v"]));
            db.ExecuteSQL(insertQuery);
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
        }

        txtLink.Text = "";
        ErrorMessage.ShowSuccessAlert(lblStatus, "Slider image updated.", divAlerts);
       
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
             UpdateQuery(db);            
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