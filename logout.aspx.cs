using System;
using System.Web;
using System.Web.Services;

public partial class admin_logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Session.Abandon();
        Session.Clear();
        //Session.RemoveAll();
        System.Web.Security.FormsAuthentication.SignOut();
        Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(-1);
        Response.Cookies["Password"].Expires = DateTime.Now.AddDays(-1);
        const string cookieName = "FrUserID";
        const string usernameCookie = "Username";
        const string emailCookie = "UserEmail";
        const string parentCookie = "ParentId";
        if (Request.Cookies[cookieName] != null)
        {
            var myCookie = new HttpCookie(cookieName) { Expires = DateTime.Now.AddDays(-1d) };
            Response.Cookies.Add(myCookie);
            var userCookie = new HttpCookie(usernameCookie) {Expires = DateTime.Now.AddDays(-1d)};
            Response.Cookies.Add(userCookie);
            var userEmailCookie = new HttpCookie(emailCookie) {Expires = DateTime.Now.AddDays(-1d)};
            Response.Cookies.Add(userEmailCookie);

            var pCookie = new HttpCookie(parentCookie) {Expires = DateTime.Now.AddDays(-1)};
            Response.Cookies.Add(pCookie);
            var messageIdCookie = new HttpCookie("MessageId") {Expires = DateTime.Now.AddDays(-1)};
            Response.Cookies.Add(messageIdCookie);
        }
        Response.Redirect("login.aspx");
    }

    [WebMethod]
    public static int LogoutCheck()
    {
        if (HttpContext.Current.Session["user"] == null)
        {
            return 0;
        }
        return 1;
    }
}