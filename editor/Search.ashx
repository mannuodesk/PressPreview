<%@ WebHandler Language="C#" Class="Search" %>

using System;
using System.Text;
using System.Web;
using System.Web.SessionState;
using DLS.DatabaseServices;

public class Search : IHttpHandler, IReadOnlySessionState 
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string searchText = context.Request.QueryString["q"];
        var db=new DatabaseManagement();

        var httpCookie = context.Request.Cookies["FrUserID"];
        if (httpCookie != null)
        {
            string getUserInfo =
                string.Format(
                    "SELECT U_Firstname + ' ' + U_Lastname as Name, U_ProfilePic, U_Username  From Tbl_Users Where U_Firstname LIKE {0}+'%'  AND U_Type='Brand'",
                    IEUtils.SafeSQLString(searchText));
            var sb = new StringBuilder();
            using (System.Data.SqlClient.SqlDataReader dr = db.ExecuteReader(getUserInfo))
            {
                while (dr.Read())
                {
                    sb.Append(string.Format("{0},{1},{2}{3}", dr["Name"], dr["U_ProfilePic"], dr["U_Username"], Environment.NewLine));
                }
            }
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
            context.Response.Write(sb.ToString());
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}