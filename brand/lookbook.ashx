<%@ WebHandler Language="C#" Class="Featured" %>

using System;
using System.IO;
using System.Web;
using DLS.DatabaseServices;

public class Featured : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        var db = new DatabaseManagement();
        foreach (string fileName in context.Request.Files)
        {
            HttpPostedFile file = context.Request.Files.Get(fileName);
           // int eventId = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(EventID) From Tbl_Events"));
            //int itemId =Convert.ToInt32(context.Request.QueryString["v"]);
            int lookID;
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
                
                File.Delete(imagepath);
                var httpCookie = HttpContext.Current.Request.Cookies["CurrentLookId"];
                if(httpCookie != null && !string.IsNullOrEmpty(httpCookie.Value))
                {
                    lookID = Convert.ToInt32(httpCookie.Value);
                     string dbQuery = string.Format("UPDATE Tbl_Lookbooks Set MainImg={0} WHERE LookID={1} ",
                                                    IEUtils.SafeSQLString(fname),
                                                    lookID);
                     db.ExecuteSQL(dbQuery);
                }
                else  
                {
                    string insertEvent =
                   string.Format(
                       "INSERT INTO Tbl_Lookbooks(MainImg,DatePosted) VALUES({0},{1})",
                       IEUtils.SafeSQLString(fname),
                       IEUtils.SafeSQLDate(DateTime.Now)
                       );
                    db.ExecuteSQL(insertEvent);
                    lookID = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(LookID) From Tbl_Lookbooks"));
                    var currItem = new HttpCookie("CurrentLookId") { Value = lookID.ToString() };
                    HttpContext.Current.Response.Cookies.Add(currItem);
                }


                
             }
        }
        db._sqlConnection.Close();
        db._sqlConnection.Dispose();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}