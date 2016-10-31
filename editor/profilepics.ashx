<%@ WebHandler Language="C#" Class="profilepics" %>

using System;
using System.IO;
using System.Web;
using DLS.DatabaseServices;

public class profilepics : IHttpHandler
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        var db = new DatabaseManagement();
        foreach (string fileName in context.Request.Files)
        {
            HttpPostedFile file = context.Request.Files.Get(fileName);
           // int eventId = Convert.ToInt32(db.GetExecuteScalar("SELECT MAX(EventID) From Tbl_Events"));
            int itemId = Convert.ToInt32(context.Request.QueryString["v"]);
            //Save file content goes here
            string fName = file.FileName;
            if (file.ContentLength > 0)
            {
                string fileExtension = Path.GetExtension(fName);
                var fname = Common.RandomPinCode() + fileExtension;
                var rootpath = HttpContext.Current.Server.MapPath("../photobank/");
                var imagepath = rootpath + fname;
                file.SaveAs(imagepath);


                string insertQuery =
                                    string.Format(
                                        "INSERT INTO Tbl_Dropzone(ImgPath,DatePosted) VALUES({0},{1})",
                                        IEUtils.SafeSQLString(fname),
                                        "'" + DateTime.Now + "'"
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