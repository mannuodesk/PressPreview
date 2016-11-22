using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D; 
using DLS.DatabaseServices;


public partial class home : System.Web.UI.Page
{
    private string path;
    private static string newimgname;
    protected void Page_Load(object sender, EventArgs e)
    {
        loading_progress.InnerHtml = "<img src='../images/ajax-loader.gif'>Loading photo...";
        path = Session["ImagePath"].ToString();
        imgCrop.ImageUrl = path + Session["WorkingImage"];
        if (Session["BrandCoverPicUpload"] != null)
        {
            if ((Session["BrandCoverPicUpload"] as BrandCoverPicUpload).width > 800)
            {
                double widthAspect = ((double)800 / (Session["BrandCoverPicUpload"] as BrandCoverPicUpload).width);
                imgCrop.Width = (int)(widthAspect * (Session["BrandCoverPicUpload"] as BrandCoverPicUpload).width);
                imgCrop.Height = (int)(widthAspect * (Session["BrandCoverPicUpload"] as BrandCoverPicUpload).height);
            }
            else if ((Session["BrandCoverPicUpload"] as BrandCoverPicUpload).height > 600)
            {
                double heightAspect = ((double)600 / (Session["BrandCoverPicUpload"] as BrandCoverPicUpload).height);
                imgCrop.Width = (int)(heightAspect * (Session["BrandCoverPicUpload"] as BrandCoverPicUpload).width);
                imgCrop.Height = (int)(heightAspect * (Session["BrandCoverPicUpload"] as BrandCoverPicUpload).height);
            }
            else
            {
                imgCrop.Width = (Session["BrandCoverPicUpload"] as BrandCoverPicUpload).width;
                imgCrop.Height = (Session["BrandCoverPicUpload"] as BrandCoverPicUpload).height;
            }
        }
        Page.LoadComplete += new EventHandler(Page_LoadComplete);
    }

    void Page_LoadComplete(object sender, EventArgs e)
    {
        loading_progress.Visible = false;
    }

    static byte[] Crop(string Img, int Width, int Height, int X, int Y)
    {
        try
        {
            //using (System.Drawing.Image originalImage = System.Drawing.Image.FromFile(Img))
            using (System.Drawing.Image originalImage = System.Drawing.Image.FromFile(((HttpContext.Current.Session["BrandCoverPicUpload"] as BrandCoverPicUpload).originalImagePath)))
            {
                using (Bitmap bmp = new Bitmap(Width, Height))
                {
                    bmp.SetResolution(originalImage.HorizontalResolution, originalImage.VerticalResolution);
                    using (Graphics Graphic = Graphics.FromImage(bmp))
                    {
                        Graphic.SmoothingMode = SmoothingMode.AntiAlias;
                        Graphic.InterpolationMode = InterpolationMode.HighQualityBicubic;
                        Graphic.PixelOffsetMode = PixelOffsetMode.HighQuality;
                        Graphic.DrawImage(originalImage, new Rectangle(0, 0, Width, Height), X, Y, Width, Height, GraphicsUnit.Pixel);
                        MemoryStream ms = new MemoryStream();
                        bmp.Save(ms, originalImage.RawFormat);
                        return ms.GetBuffer();
                    }
                }
            }
        }
        catch (Exception Ex)
        {
            throw (Ex);
        }
    }
    protected void btnCrop_OnServerClick(object sender, EventArgs e)
    {
        string imageName = Session["WorkingImage"].ToString();
        string[] intHeight = H.Value.Split('.');
        string[] intWidth = W.Value.Split('.');
        int w = Convert.ToInt32(intWidth[0]);
        int h = Convert.ToInt32(intHeight[0]);
        string[] intX = X.Value.Split('.');
        string[] intY = Y.Value.Split('.');
        int x = Convert.ToInt32(intX[0]);
        int y = Convert.ToInt32(intY[0]);
        
        #region Crop Logic
        int originalImageWidth = (Session["BrandCoverPicUpload"] as BrandCoverPicUpload).width;
        int originalImageHeight = (Session["BrandCoverPicUpload"] as BrandCoverPicUpload).height;
        int containerHeight = Convert.ToInt32(imgCrop.Height.Value);
        int containerWidth = Convert.ToInt32(imgCrop.Width.Value);
        double aspectRatioWidth = ((double)originalImageWidth / containerWidth);
        double aspectRatioHeight = ((double)originalImageHeight / containerHeight);
        x = (int)((double)x * aspectRatioWidth);
        y = (int)((double)y * aspectRatioHeight);
        w = (int)((double)w * aspectRatioWidth);
        h = (int)((double)h * aspectRatioHeight);
        #endregion


        byte[] cropImage = Crop(Server.MapPath(path) + imageName, w, h, x, y);
        using (MemoryStream ms = new MemoryStream(cropImage, 0, cropImage.Length))
        {
            ms.Write(cropImage, 0, cropImage.Length);
            using (System.Drawing.Image croppedImage = System.Drawing.Image.FromStream(ms, true))
            {
                newimgname = "cr" + imageName;
                string saveTo = Server.MapPath("../profileimages/") + newimgname;
                croppedImage.Save(saveTo, croppedImage.RawFormat);
               
                imgCrop.Width = 0;
                imgCrop.Height = 0;
                imgCrop.ImageUrl = "../profileimages/" + newimgname;
                btnCrop.Visible = false;
                btnSave.Visible = true;
                File.Delete(Server.MapPath(path+imageName));
                //   File.Decrypt(path+ImageName);
                //pnlCrop.Visible = false;
                //pnlCropped.Visible = true;
                //imgCropped.ImageUrl = "images/crop" + ImageName;
            }
        }
    }


    protected void save_btn_OnServerClick(object sender, EventArgs e)
    {
        if (Session["signedUpUser"]==null)
        {
            SignedUpUser signedUpUser = new SignedUpUser();
            Session["signedUpUser"] = signedUpUser;
        }
        (Session["signedUpUser"] as SignedUpUser).coverPicURL = newimgname;
        Session["coverPicURL"] = newimgname;
        /*var db = new DatabaseManagement();
        string updateUserProfile =
          string.Format("UPDATE Tbl_Users Set U_CoverPic={0} Where UserID={1}",
                        IEUtils.SafeSQLString(newimgname),
                        IEUtils.ToInt(Session["UserID"].ToString()));
        db.ExecuteSQL(updateUserProfile);*/


    }

    protected void upload_btn_OnServerClick(object sender, EventArgs e)
    {
        Response.Redirect("CoverPic.aspx?v="+Request.QueryString["v"]);
    }
}