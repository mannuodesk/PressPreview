<%@ WebHandler Language="C#" Class="Itempics" %>

using System;
using System.IO;
using System.Web;
using DLS.DatabaseServices;

public class Itempics : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
       // var db = new DatabaseManagement();
        int itemId = Convert.ToInt32(context.Request.QueryString["v"]);
        foreach (string fileName in context.Request.Files)
        {
            HttpPostedFile file = context.Request.Files.Get(fileName);
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


                /*string insertQuery =
                                    string.Format(
                                        "INSERT INTO Tbl_ItemImages(ItemImg,ItemID,TempName) VALUES({0},{1},{2})",
                                        IEUtils.SafeSQLString(fname),
                                        itemId,
                                        IEUtils.SafeSQLString(fName)
                                        );*/

                if (context.Session["EditItemDetails"] == null)
                {
                    EditItemDetails editItemDetails = new EditItemDetails();
                    editItemDetails.ImagesToAdd = new System.Collections.Generic.List<ItemImageFileName>();
                    context.Session["EditItemDetails"] = editItemDetails;
                }
                else
                {
                    if((context.Session["EditItemDetails"] as EditItemDetails).ImagesToAdd==null)
                    {
                        (context.Session["EditItemDetails"] as EditItemDetails).ImagesToAdd = new System.Collections.Generic.List<ItemImageFileName>();
                    }
                }
                ItemImageFileName itemImageFileName = new ItemImageFileName();
                itemImageFileName.FileName = fname;
                itemImageFileName.TempFileName = fName;
                (context.Session["EditItemDetails"] as EditItemDetails).ImagesToAdd.Add(itemImageFileName);
                
                //db.ExecuteSQL(insertQuery);

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