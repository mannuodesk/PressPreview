<%@ WebHandler Language="C#" Class="eventimges" %>

using System;
using System.IO;
using System.Web;
using DLS.DatabaseServices;

public class eventimges : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        var db = new DatabaseManagement();
       // int eventId = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(EventID) From Tbl_Events"));
        int eventId = Convert.ToInt32(context.Request.QueryString["v"]);
        foreach (string fileName in context.Request.Files)
        {
            HttpPostedFile file = context.Request.Files.Get(fileName);

            //Save file content goes here
            string fName = file.FileName;
            if (file.ContentLength > 0)
            {
                string fileExtension = Path.GetExtension(fName);
                var fname = Common.RandomPinCode() + fileExtension;
                var rootpath = HttpContext.Current.Server.MapPath("../../eventpics/");
                var imagepath = rootpath + fname;
                file.SaveAs(imagepath);

                
               
                string insertQuery =
                    string.Format(
                        "INSERT INTO Tbl_EventImages(EImg,EventID,TempName) VALUES({0},{1},{2})",
                        IEUtils.SafeSQLString(fname),
                        eventId,
                        IEUtils.SafeSQLString(fName)
                        );
                db.ExecuteSQL(insertQuery);
               
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