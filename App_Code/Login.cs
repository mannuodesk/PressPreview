using DLS.DatabaseServices;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Login
/// </summary>
public class Login
{
    public Login()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public bool ValidateUser(string username,string password,string userType)
    {
        DatabaseManagement db = new DatabaseManagement();
        string getUser = string.Format("SELECT UserID,U_Firstname + ' ' + U_Lastname as Fullname,U_Email  From Tbl_Users Where U_Username={0} AND U_Password={1} AND U_Type={2}", IEUtils.SafeSQLString(username), IEUtils.SafeSQLString(password), IEUtils.SafeSQLString(userType));
        SqlDataReader dr = db.ExecuteReader(getUser);
            if(dr.HasRows)
        {
            dr.Read();
            var aCookie = new HttpCookie("UserID") { Value = dr["UserID"].ToString() };
            HttpContext.Current.Response.Cookies.Add(aCookie);
            HttpContext.Current.Session["UserID"] = dr["UserID"].ToString();
            HttpContext.Current.Session["UserEmail"] = dr["U_Email"].ToString();
            HttpContext.Current.Session["Username"] = dr["Fullname"].ToString();            
            return true;
        }
            

        return false;
    }
    public bool ValidateUser(string username, string password)
    {
        DatabaseManagement db = new DatabaseManagement();
        string getUser = string.Format("SELECT UserID,U_Firstname + ' ' + U_Lastname as Fullname,U_Email  From Tbl_Users Where U_Username={0} AND U_Password={1} ", IEUtils.SafeSQLString(username), IEUtils.SafeSQLString(password));
        SqlDataReader dr = db.ExecuteReader(getUser);
        if (dr.HasRows)
        {
            dr.Read();
            HttpContext.Current.Session["UserID"] = dr["UserID"].ToString();
            HttpContext.Current.Session["UserEmail"] = dr["U_Email"].ToString();
            HttpContext.Current.Session["Username"] = dr["Fullname"].ToString();
            return true;
        }


        return false;
    }
}