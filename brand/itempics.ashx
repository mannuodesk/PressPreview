<%@ WebHandler Language="C#" Class="Itempics" %>

using System;
using System.IO;
using System.Web;
using DLS.DatabaseServices;
using System.Collections.Generic;
public class Itempics : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        var db = new DatabaseManagement();
        int itemId;
        var httpCookie = HttpContext.Current.Request.Cookies["CurrentItemId"];
        if (httpCookie != null && !string.IsNullOrEmpty(httpCookie.Value))
        {
            //itemId = Convert.ToInt32(httpCookie.Value);
        }
        else
        {
           // string insertEvent =
           //string.Format(
           //    "INSERT INTO Tbl_Items(DatePosted) VALUES({0})",
           //    IEUtils.SafeSQLDate(DateTime.Now)
           //    );
           // db.ExecuteSQL(insertEvent);
           // itemId = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(ItemID) From Tbl_Items"));
           // var currItem = new HttpCookie("CurrentItemId") { Value = itemId.ToString() };
           // HttpContext.Current.Response.Cookies.Add(currItem);
        }
        foreach (string fileName in context.Request.Files)
        {
            HttpPostedFile file = context.Request.Files.Get(fileName);
           // int eventId = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(EventID) From Tbl_Events"));
            //int itemId = Convert.ToInt32(context.Request.QueryString["v"]);
            //Save file content goes here
            string fName = file.FileName;
            if (file.ContentLength > 0)
                {
                string fileExtension = Path.GetExtension(fName);
                var fname = Common.RandomPinCode() + fileExtension;
                var rootpath = HttpContext.Current.Server.MapPath("../tempstorage/");
                var imagepath = rootpath + fname;
                file.SaveAs(imagepath);
                var resizeimg = Utility.GenerateThumbNail(fname, imagepath, "photobank/", 900);
                var featured1 = Utility.GenerateThumbNail(fname, imagepath, "imgLarge/", 642);
                var featured2 = Utility.GenerateThumbNail(fname, imagepath, "imgMedium/", 418);
                File.Delete(imagepath); 


                //string insertQuery =
                //                    string.Format(
                //                        "INSERT INTO Tbl_ItemImages(ItemImg,ItemID,TempName) VALUES({0},{1},{2})",
                //                        IEUtils.SafeSQLString(fname),
                //                        itemId,
                //                        IEUtils.SafeSQLString(fName)
                //                        );
                //db.ExecuteSQL(insertQuery);
                  
                if (HttpContext.Current.Session["ThumbnailImageList"] == null)
                    {
                    FeatureImage fImage = new FeatureImage();
                    fImage.FeatureImageName = fname;
                    fImage.FeatureImageTempname = fName;
                    List<FeatureImage> feaImageList = new List<FeatureImage>();
                    feaImageList.Add(fImage);
                    HttpContext.Current.Session["ThumbnailImageList"]=feaImageList;
                    }
                else
                    {
                    List<FeatureImage> feaImageList = (List<FeatureImage>)HttpContext.Current.Session["ThumbnailImageList"];
                    FeatureImage fImage = new FeatureImage();
                    fImage.FeatureImageName = fname;
                    fImage.FeatureImageTempname = fName;
                    feaImageList.Add(fImage);
                    HttpContext.Current.Session["ThumbnailImageList"] = feaImageList;
                    
                    }
            
             }
        }
        //db._sqlConnection.Close();
        //db._sqlConnection.Dispose();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}