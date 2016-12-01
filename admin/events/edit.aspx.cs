using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
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
                LoadData();
              
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void DeleteUnsavedData()
    {
        try
        {
            var db=new DatabaseManagement();
            const string deleteImages = "Delete from Tbl_EventImages Where EventID IN (SELECT EventID From Tbl_Events Where IsSaved IS NULL) ";
            db.ExecuteSQL(deleteImages);
            const string deleteUnsavedEvents = "Delete from Tbl_Events Where IsSaved IS NULL";
            db.ExecuteSQL(deleteUnsavedEvents);
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
   
    protected void LoadData()
    {
        try
        {
            var db=new DatabaseManagement();
            
            string getEvent = string.Format("SELECT * From Tbl_Events Where EventID={0}",
                                            IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(getEvent);
            if(dr.HasRows)
            {
                dr.Read();
                txtEventTitle.Value = dr[1].ToString();
                txtStartDate.Text = dr[2].ToString();
                txtEndDate.Text = dr[3].ToString();
                txtStartTime.Text = dr[4].ToString();
                txtEndTime.Text = dr[5].ToString();
                txtPara1.Text = dr[6].ToString();
                txtPara2.Text = dr[7].ToString();
                if (dr[9].ToString() == "image")
                {
                    tbCenterMedia.ActiveTab = tbImage;
                    imgCenterFeature.ImageUrl = "../../eventpics/" + dr[10].ToString();
                    
                }
                else if (dr[9].ToString() == "embed")
                {
                    tbCenterMedia.ActiveTab = tbVideo;
                    ddVideoSource.SelectedValue = dr[20].ToString();
                    txtEmbedVideo.Value = dr[21].ToString();
                }
               
                ddCategory.SelectedValue = dr[11].ToString();
                txtLocation.Value = dr[13].ToString();
                txtCity.Value = dr[15].ToString();
                txtRSVP.Value = dr[17].ToString();
                ddRsvpType.SelectedValue = dr[18].ToString();
                imgEventFeature.ImageUrl = "../../eventpics/" + dr[8].ToString();
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string mediaType = string.Empty;
            string centerMedia = string.Empty;
            // upload images to the database
            var db = new DatabaseManagement();
                string mainimg = db.GetExecuteScalar("SELECT Top 1 EImg From Tbl_EventImages Where EventID=" + Convert.ToInt32(Request.QueryString["v"]));
                if (string.IsNullOrEmpty(mainimg))
                {
                    ErrorMessage.ShowErrorAlert(lblStatus, "Please upload atleast one event image.", divAlerts);
                }
                else
                {
                    string videoURL = string.Empty;
                    int videosource = 0;
                    string videoID = string.Empty;
                    switch (tbCenterMedia.ActiveTab.ID)
                    {
                        case "tbImage":
                            mediaType = "image";
                            RfvEmbedVideo.Enabled = false;
                            break;
                        case "tbVideo":
                           
                        switch (ddVideoSource.SelectedValue)
                        {
                            case "1":
                                videosource = 1;
                                videoURL = "http://www.youtube.com/embed/" + txtEmbedVideo.Value;
                                
                                break;
                            case "2":
                                videosource = 2;
                                videoURL = "https://player.vimeo.com/video/" + txtEmbedVideo.Value;
                                break;
                        };
                        videoID = txtEmbedVideo.Value;
                        mediaType = "embed";
                        RfvEmbedVideo.Enabled = true;
                        centerMedia = videoURL;
                        break;
                    }
                    
                    string updateQuery = string.Empty;
                    if(mediaType=="image")
                    {
                        updateQuery = string.Format("UPDATE Tbl_Events Set EventTitle={0}," +
                                                      "StartDate={1},StartTime={2},EventPara1={3}," +
                                                      "EventPara2={4}," +
                                                      "ECategoryID={5},ECategory={6},ELocation={7}," +
                                                      "ECity={8}, EventRSVP={9},IsSaved={10}, EndDate={11},EndTime={12},RSVPType={13} WHERE EventID={14} ",
                                                      IEUtils.SafeSQLString(txtEventTitle.Value),
                                                       "'" + Convert.ToDateTime(txtStartDate.Text).ToUniversalTime() + "'",
                                                      IEUtils.SafeSQLString(txtStartTime.Text),
                                                     IEUtils.SafeSQLString(txtPara1.Text),
                                                     IEUtils.SafeSQLString(txtPara2.Text),
                                                     IEUtils.ToInt(ddCategory.SelectedValue),
                                                     IEUtils.SafeSQLString(ddCategory.SelectedItem.Text),
                                                      IEUtils.SafeSQLString(txtLocation.Value),
                                                      IEUtils.SafeSQLString(txtCity.Value),
                                                      IEUtils.SafeSQLString(txtRSVP.Value),
                                                      1,
                                                      "'" + Convert.ToDateTime(txtEndDate.Text).ToUniversalTime() + "'",
                                                      IEUtils.SafeSQLString(txtEndTime.Text),
                                                      IEUtils.SafeSQLString(ddRsvpType.SelectedItem.Text),
                                                     Convert.ToInt32(Request.QueryString["v"]));
                    }
                    else if(mediaType=="embed")
                    {
                        updateQuery = string.Format("UPDATE Tbl_Events Set EventTitle={0}," +
                                                     "StartDate={1},StartTime={2},EventPara1={3}," +
                                                     "EventPara2={4},EventMediaType={5}," +
                                                     "EventMedia={6},ECategoryID={7},ECategory={8},ELocation={9}," +
                                                     "ECity={10}, EventRSVP={11},IsSaved={12},EndDate={13},EndTime={14}, RSVPType={15},VideoSource={16}, VideoID={17} WHERE EventID={18} ",
                                                     IEUtils.SafeSQLString(txtEventTitle.Value),
                                                     "'" + Convert.ToDateTime(txtStartDate.Text).ToUniversalTime() + "'",
                                                     IEUtils.SafeSQLString(txtEndTime.Text),
                                                    IEUtils.SafeSQLString(txtPara1.Text),
                                                    IEUtils.SafeSQLString(txtPara2.Text),
                                                    IEUtils.SafeSQLString(mediaType),
                                                    IEUtils.SafeSQLString(centerMedia),
                                                    IEUtils.ToInt(ddCategory.SelectedValue),
                                                    IEUtils.SafeSQLString(ddCategory.SelectedItem.Text),
                                                     IEUtils.SafeSQLString(txtLocation.Value),
                                                     IEUtils.SafeSQLString(txtCity.Value),
                                                     IEUtils.SafeSQLString(txtRSVP.Value),
                                                     1,
                                                      "'" + Convert.ToDateTime(txtEndDate.Text).ToUniversalTime() + "'",
                                                      IEUtils.SafeSQLString(txtEndTime.Text),
                                                     IEUtils.SafeSQLString(ddRsvpType.SelectedItem.Text),
                                                     videosource,
                                                     IEUtils.SafeSQLString(videoID),
                                                    Convert.ToInt32(Request.QueryString["v"]));
                    }
                   
                    
                    db.ExecuteSQL(updateQuery);
                    DeleteUnsavedData();
                    db._sqlConnection.Close();
                    db._sqlConnection.Dispose();
                    Response.Redirect("Default.aspx");
                    // }
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
        db._sqlConnection.Close();
        db._sqlConnection.Dispose();

    }

    protected void dlImages_ItemCommand(object source, System.Web.UI.WebControls.DataListCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "1")
            {
                int recordId = Convert.ToInt32(e.CommandArgument);
                var db = new DatabaseManagement();
                string deleteQuery = "Delete from Tbl_EventImages Where EImgID=" + recordId;
                db.ExecuteSQL(deleteQuery);
                dlImages.DataBind();
            }

        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    //public void SaveUploadedFile(HttpFileCollection httpFileCollection)
    //{

    //    foreach (string fileName in httpFileCollection)
    //    {
    //        HttpPostedFile file = httpFileCollection.Get(fileName);

    //        //Save file content goes here
    //        string fName = file.FileName;
    //        if (file.ContentLength > 0)
    //        {
    //            string fileExtension = Path.GetExtension(fName);
    //            var fname = Common.RandomPinCode() + fileExtension;
    //            var rootpath = Server.MapPath("../../eventpics/");
    //            var imagepath = rootpath + fname;
    //            file.SaveAs(imagepath);
                
    //            var db = new DatabaseManagement();
    //            if (Session["CurrentEventId"].ToString() == "0")
    //            {
    //                string insertEvent =
    //                    string.Format(
    //                        "INSERT INTO Tbl_Events(DatePosted) VALUES({0})",
    //                         IEUtils.SafeSQLDate(DateTime.Now)
    //                        );
    //                db.ExecuteSQL(insertEvent);

    //                int eventId = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(EventID) From Tbl_Events"));
    //               // string productKey = Encryption64.Encrypt(eventId.ToString(CultureInfo.InvariantCulture)).Replace('+', '=');
    //                Session["CurrentEventId"] = eventId;
    //                //string updateProduct = String.Format("Update Tbl_Products Set ProductKey={0} Where ProductID={1}", IEUtils.SafeSQLString(productKey), eventId);
    //                //db.ExecuteSQL(updateProduct);

    //            }
    //            string insertQuery =
    //                string.Format(
    //                    "INSERT INTO Tbl_EventImages(EImg,EventID,TempName) VALUES({0},{1},{2})",
    //                    IEUtils.SafeSQLString(fname),
    //                    Convert.ToInt32(Session["CurrentEventId"].ToString()),
    //                    IEUtils.SafeSQLString(fName)
    //                    );
    //            db.ExecuteSQL(insertQuery);
    //            db._sqlConnection.Close();
    //            db._sqlConnection.Dispose();

    //        }

    //    }

    //}
    [WebMethod, ScriptMethod]
    public static void RemoveImage(string filename)
    {
        var db = new DatabaseManagement();
        string actualName =
            db.GetExecuteScalar(
                string.Format("Select EImg From Tbl_EventImages Where TempName={0}  AND EventID={1}",
                              IEUtils.SafeSQLString(filename), IEUtils.ToInt(HttpContext.Current.Session["CurrentEventId"])));
        string deleteQuery = string.Format("Delete From Tbl_EventImages Where TempName={0} AND EventID={1}",
                                            IEUtils.SafeSQLString(filename), IEUtils.ToInt(HttpContext.Current.Session["CurrentEventId"]));
        db.ExecuteSQL(deleteQuery);
        File.Delete("../../eventpics/" + actualName);
        db._sqlConnection.Close();
        db._sqlConnection.Dispose();
       
    }

    [WebMethod, ScriptMethod]
    public static List<Attachment> GetFeatureImage()
    {
        var lstFeatureImage=new List<Attachment>();
        var db=new DatabaseManagement();
        string getFeatureImg = string.Format("SELECT EFeaturePic From Tbl_Events Where EventID={0}",
                                             IEUtils.ToInt(HttpContext.Current.Request.QueryString["v"]));
        var dr = db.ExecuteReader(getFeatureImg);
        if(dr.HasRows)
        {
            dr.Read();
            var obj = new Attachment
                                 {AttachmentID = 1, FileName = dr[0].ToString(), Path = "../../eventpics" + dr[0]};
            lstFeatureImage.Add(obj);
        }
        return  lstFeatureImage;
    }

    
}