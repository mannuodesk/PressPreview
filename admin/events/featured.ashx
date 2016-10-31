<%@ WebHandler Language="C#" Class="featured" %>

using System;
using System.IO;
using System.Web;
using DLS.DatabaseServices;

public class featured : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        var db = new DatabaseManagement();
        foreach (string fileName in context.Request.Files)
        {
            HttpPostedFile file = context.Request.Files.Get(fileName);
           // int eventId = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(EventID) From Tbl_Events"));
           int eventId = Convert.ToInt32(context.Request.QueryString["v"]);
            //Save file content goes here
            string fName = file.FileName;
            if (file.ContentLength > 0)
            {
                string fileExtension = Path.GetExtension(fName);
                var fname = Common.RandomPinCode() + fileExtension;
                var rootpath = HttpContext.Current.Server.MapPath("../../eventpics/");
                var imagepath = rootpath + fname;
                file.SaveAs(imagepath);
              //  var thumbnail567 = Utility.GenerateThumbNail(fname, imagepath, "../imgMedium/", 336, 171);
                string updateQuery = string.Format("UPDATE Tbl_Events Set EFeaturePic={0} WHERE EventID={1} ",
                                                   IEUtils.SafeSQLString(fname),
                                                   eventId);

                db.ExecuteSQL(updateQuery);
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