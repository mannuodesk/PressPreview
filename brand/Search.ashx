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
                    "SELECT U_Firstname + ' ' + U_Lastname as Name, U_ProfilePic, U_Username  From Tbl_Users Where U_Firstname LIKE {0}+'%'  AND U_Type='Editor' AND  (UserID IN (SELECT SenderID From Tbl_MailboxMaster Where ReceiverID={1} AND BlockStatus IS NULL) " +
                    "OR  UserID IN (SELECT LikeID From Tbl_BrandsLikes Where UserID={2}) " +
                    "OR  UserID IN (SELECT UserID From  Tbl_Item_Likes Where BrandID={3}) " +
                    "OR  UserID IN (SELECT UserID From Tbl_Posts Where BrandID={4}) " +
                    "OR  UserID IN (SELECT UserID From Tbl_Comments Where BrandID={5})) ",
                    IEUtils.SafeSQLString(searchText),
                    IEUtils.ToInt(httpCookie.Value),
                    IEUtils.ToInt(httpCookie.Value),
                    IEUtils.ToInt(httpCookie.Value),
                    IEUtils.ToInt(httpCookie.Value),
                    IEUtils.ToInt(httpCookie.Value));
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