using System;
using System.Web;

public partial class admin_logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session.Clear();
        const string cookieName = "UserID";
        if (Request.Cookies[cookieName] != null)
        {
            var myCookie = new HttpCookie(cookieName) { Expires = DateTime.Now.AddDays(-1d) };
            Response.Cookies.Add(myCookie);
        }
        Response.Redirect("login.aspx");
    }
}