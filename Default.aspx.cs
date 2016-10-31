using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;

public partial class _Default : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.Cookies["UserName"] != null && Request.Cookies["Password"] != null)
            {
                var usernameCookie = Request.Cookies["UserName"];
                if (usernameCookie != null)
                {
                    var passcookie = Request.Cookies["Password"];
                    if (passcookie != null)
                        ValidateLogin(usernameCookie.Value, passcookie.Value);
                }
            }
        }
    }

    private void ValidateLogin(string username, string password)
    {
        var db = new DatabaseManagement();
        string selectQuery =
            string.Format(
                "SELECT Tbl_Users.UserID,U_FirstName + ' ' + U_Lastname as [U_Firstname],U_Status,U_EmailStatus,U_Email, U_Type,IsApproved  FROM Tbl_Users  Where (U_Username={0} OR U_Email={1}) AND U_Password={2}  ",
                IEUtils.SafeSQLString(username),
                IEUtils.SafeSQLString(username),
                IEUtils.SafeSQLString(password)
                );
        SqlDataReader dr = db.ExecuteReader(selectQuery);
        if (dr.HasRows)
        {
            dr.Read();
            if (dr["U_Status"].ToString() == "0")
            {
              //  ErrorMessage.ShowErrorAlert(lblStatus, "Your account is blocked. Please contact the website administrator. ",
               //                             divAlerts);
            }
            else
            {

                if (dr.IsDBNull(6))
                {
                  //  ErrorMessage.ShowErrorAlert(lblStatus, "Your account is pending for approval. ", divAlerts);
                }
                else
                {
                    var aCookie = new HttpCookie("FrUserID") { Value = dr["UserID"].ToString() };
                    HttpContext.Current.Response.Cookies.Add(aCookie);
                    var UsernameCookie = new HttpCookie("Username") { Value = dr["U_FirstName"].ToString() };
                    HttpContext.Current.Response.Cookies.Add(UsernameCookie);
                    var emailCookie = new HttpCookie("UserEmail") { Value = dr["U_Email"].ToString() };
                    HttpContext.Current.Response.Cookies.Add(emailCookie);

                    switch (dr["U_Type"].ToString())
                    {

                        case "Brand":

                            Session["UserID"] = dr["UserID"].ToString();
                            Session["Username"] = dr["U_FirstName"].ToString();
                            Session["UserEmail"] = dr["U_Email"].ToString();
                            Response.Redirect("brand/profile-page-items.aspx");
                            break;
                        case "Editor":
                            Session["UserID"] = dr["UserID"].ToString();
                            Session["Username"] = dr["U_FirstName"].ToString();
                            Session["UserEmail"] = dr["U_Email"].ToString();
                            Response.Redirect("editor/");
                            break;
                    }


                }

            }
        }
        else
        {
           // ErrorMessage.ShowErrorAlert(lblStatus, "Incorrect username or password !", divAlerts);
        }
    }
}