<%@ WebHandler Language="C#" Class="Featured" %>

using System;
using System.IO;
using System.Web;
using DLS.DatabaseServices;

public class Featured : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
    
    public void ProcessRequest (HttpContext context) {
    FeatureImage fImage = new FeatureImage();
        context.Response.ContentType = "text/plain";
        var db = new DatabaseManagement();
        foreach (string fileName in context.Request.Files)
        {
            HttpPostedFile file = context.Request.Files.Get(fileName);
           // int eventId = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(EventID) From Tbl_Events"));
            //int itemId =Convert.ToInt32(context.Request.QueryString["v"]);
            int itemId;
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
                var httpCookie = HttpContext.Current.Request.Cookies["CurrentItemId"];
                if(httpCookie != null && !string.IsNullOrEmpty(httpCookie.Value))
                {
                    //itemId = Convert.ToInt32(httpCookie.Value);
                    // string dbQuery = string.Format("UPDATE Tbl_Items Set FeatureImg={0} WHERE ItemID={1} ",
                    //                                IEUtils.SafeSQLString(fname),
                    //                                IEUtils.ToInt(httpCookie.Value));
                    // db.ExecuteSQL(dbQuery);
                }
                else  
                {
                   // string insertEvent =
                   //string.Format(
                   //    "INSERT INTO Tbl_Items(FeatureImg,DatePosted) VALUES({0},{1})",
                   //    IEUtils.SafeSQLString(fname),
                   //    IEUtils.SafeSQLDate(DateTime.Now)
                   //    );
                   // db.ExecuteSQL(insertEvent);
                    
                   // itemId = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(ItemID) From Tbl_Items"));
                   // var currItem = new HttpCookie("CurrentItemId") { Value = itemId.ToString() };
                   // HttpContext.Current.Response.Cookies.Add(currItem);
                   // string insertQuery =
                   //               string.Format(
                   //                   "INSERT INTO Tbl_ItemImages(ItemImg,ItemID,TempName) VALUES({0},{1},{2})",
                   //                   IEUtils.SafeSQLString(fname),
                   //                   itemId,
                   //                   IEUtils.SafeSQLString(fName)
                   //                   );
                   // db.ExecuteSQL(insertQuery);

                }

                                fImage.FeatureImageName = fname;
                fImage.FeatureImageTempname = fName;
                ((FeatureImage)HttpContext.Current.Session["FeatureImage"]).FeatureImageName = fImage.FeatureImageName;
                ((FeatureImage)HttpContext.Current.Session["FeatureImage"]).FeatureImageTempname = fImage.FeatureImageTempname;
                
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