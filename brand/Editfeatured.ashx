<%@ WebHandler Language="C#" Class="Featured" %>

using System;
using System.IO;
using System.Web;
using DLS.DatabaseServices;

public class Featured : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        /*var db = new DatabaseManagement();*/
        foreach (string fileName in context.Request.Files)
        {
            HttpPostedFile file = context.Request.Files.Get(fileName);
            int itemId =Convert.ToInt32(context.Request.QueryString["v"]);
            //Save file content goes here
            string fName = file.FileName;
            if (file.ContentLength > 0)
            {
                string fileExtension = Path.GetExtension(fName);
                var fname = Common.RandomPinCode() + fileExtension;
                var rootpath = HttpContext.Current.Server.MapPath("../tempstorage/");
                var imagepath = rootpath + fname;
                file.SaveAs(imagepath);
                var photoPathPhotoBank = HttpContext.Current.Server.MapPath("../photobank/");
                var photoPathPhotoBankFile = photoPathPhotoBank + fname;
                var photoPathImageLarge = HttpContext.Current.Server.MapPath("../imgLarge/");
                var photoPathImageLargeFile = photoPathPhotoBank + fname;
                var photoPathImageMedium = HttpContext.Current.Server.MapPath("../imgMedium/");
                var photoPathImageMediumFile = photoPathPhotoBank + fname;
                ImageCompressionWithDimensionsFormula imageCompressionWithDimensionsFormula = new ImageCompressionWithDimensionsFormula();
                System.Drawing.Image image = imageCompressionWithDimensionsFormula.CompessImage(file.InputStream);
                image.Save(photoPathPhotoBankFile);
                image.Save(photoPathImageLargeFile);
                image.Save(photoPathImageMediumFile);
                //file.SaveAs(photoPathPhotoBankFile);
                //file.SaveAs(photoPathImageLargeFile);
                //file.SaveAs(photoPathImageMediumFile);
                /*#region Compression
                ImageCompress imgCompress = ImageCompress.GetImageCompressObject;
                imgCompress.GetImage = new System.Drawing.Bitmap(imagepath);
                imgCompress.Height = imgCompress.GetImage.Height;
                imgCompress.Width = imgCompress.GetImage.Width;
                imgCompress.Save(fname, photoPathPhotoBank);
                imgCompress.Save(fname, photoPathImageLarge);
                imgCompress.Save(fname, photoPathImageMedium);
                imgCompress.GetImage.Dispose();
                #endregion*/
                //var resizeimg = Utility.GenerateThumbNail(fname, imagepath, "photobank/", 900);
                //var featured1 = Utility.GenerateThumbNail(fname, imagepath, "imgLarge/", 642);
                //var featured2 = Utility.GenerateThumbNail(fname, imagepath, "imgMedium/", 418);
                File.Delete(imagepath);
                if(context.Session["EditItemDetails"]==null)
                {
                    EditItemDetails editItemDetails = new EditItemDetails();
                    context.Session["EditItemDetails"] = editItemDetails;
                }
                (context.Session["EditItemDetails"] as EditItemDetails).FeaturedImage = fname;
                /*string dbQuery = string.Format("UPDATE Tbl_Items Set FeatureImg={0} WHERE ItemID={1} ",
                                                    IEUtils.SafeSQLString(fname),
                                                    itemId);
                     db.ExecuteSQL(dbQuery);*/

            }
        }
        /*db._sqlConnection.Close();
        db._sqlConnection.Dispose();*/
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}