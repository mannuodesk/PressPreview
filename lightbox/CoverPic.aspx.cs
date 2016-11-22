using System;
using System.IO;
using System.Web;

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


    protected void upload_btn_OnClick(object sender, EventArgs e)
    {
        try
        {
            loading_progress.InnerHtml = "<img src='../images/ajax-loader.gif'>Uploading your photo...";
            if (photo.HasFile)
            {
                string fileExtension = Path.GetExtension(photo.PostedFile.FileName);
                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png" || fileExtension == ".gif" || fileExtension == ".pdf")
                {
                    var fname = Common.RandomPinCode() + fileExtension;
                    Session["WorkingImage"] =fname;
                    var rootpath = HttpContext.Current.Server.MapPath("../photobank/");
                    var imagepath = rootpath + fname;
                    photo.SaveAs(imagepath);
                     System.Drawing.Image originalImage = System.Drawing.Image.FromFile(imagepath);
                    int width = originalImage.Width;
                    int height = originalImage.Height;
                    if(Session["BrandCoverPicUpload"]==null)
                    {
                        BrandCoverPicUpload brandCoverPicUpload = new BrandCoverPicUpload();
                        Session["BrandCoverPicUpload"] = brandCoverPicUpload;
                    }
                    (Session["BrandCoverPicUpload"] as BrandCoverPicUpload).width = width;
                    (Session["BrandCoverPicUpload"] as BrandCoverPicUpload).height = height;
                    (Session["BrandCoverPicUpload"] as BrandCoverPicUpload).originalImagePath=imagepath;
                    // Pre Size the image
                   if(Request.QueryString["v"]=="c")
                   {
                       var thumbnail567 = Utility.GenerateThumbNail(fname, imagepath, "profileimages/", 1100);
                        Session["ImagePath"] = "../profileimages/";
                        Response.Redirect("cropcover.aspx");
                   }
                    else if(Request.QueryString["v"]=="p")
                    {
                        Session["ImagePath"] = "../photobank/";
                        Response.Redirect("corpavatar.aspx");
                    }
                        


                }
                else
                {
                    ErrorMessage.ShowErrorAlert(lblStatus, "Please select a valid image file for cover photo.", divAlerts);
                }
            }
            else
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "Please select cover photo", divAlerts);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    
}