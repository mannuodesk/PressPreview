using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;

public partial class Demo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        gvUsers.DataBind();
    }

    [WebMethod]
    [ScriptMethod]
    public static void SaveUser(User user)
    {
        var db=new DatabaseManagement();
        string insertQuery = string.Format("INSERT INTO Tbl_Test(Username,Password) VALUES({0},{1})",
                                           IEUtils.SafeSQLString(user.Username), IEUtils.SafeSQLString(user.Password));
        db.ExecuteSQL(insertQuery);
        
       
    }
}