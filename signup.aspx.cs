using System.Data.SqlClient;
using System.Globalization;
using System.Text;
using DLS.DatabaseServices;
using System;

public partial class signup : System.Web.UI.Page
{
   
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnBrand_ServerClick(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
            string updateQuery = string.Format("UPDATE Tbl_Users Set U_Type={0},U_CoverPic={1} Where UserKey={2}",
                IEUtils.SafeSQLString("Brand"),
                IEUtils.SafeSQLString("brandimage.jpg"),
                IEUtils.SafeSQLString(Request.QueryString["k"]));
            db.ExecuteSQL(updateQuery);
            string getUserId = string.Format("SELECT UserID From Tbl_Users Where UserKey={0}",
                                             IEUtils.SafeSQLString(Request.QueryString["k"]));
            int userId = 0;
            SqlDataReader dr = db.ExecuteReader(getUserId);
            if (dr.HasRows)
            {
                dr.Read();
                userId = Convert.ToInt32(dr[0]);
            }
            dr.Close();
            dr.Dispose();
            db._sqlConnection.Close();
            int brandID = db.GetMaxID("BrandID", "Tbl_Brands");
            
            string editorKey = Encryption64.Encrypt(brandID.ToString(CultureInfo.InvariantCulture)).Replace('+', '=');
            string insertQuery =
                    string.Format(
                        "INSERT INTO Tbl_Brands(BrandKey,UserID,DatePosted) " +
                        "VALUES({0},{1},{2})",
                        IEUtils.SafeSQLString(editorKey),
                        userId,
                        IEUtils.SafeSQLDate(DateTime.UtcNow)
                        );
            db.ExecuteSQL(insertQuery);
            db._sqlConnection.Close();
            Response.Redirect("brand/myprofile.aspx?v=" + Request.QueryString["k"]);

            //var sb = new StringBuilder();
            //sb.Append(
            //    "Congratulation ! <br/></br>Your account has been created. A confirmation email has been sent to your email. Please verify your email.");
            //// string message = "Your username is " + txtSignUpEmail.Value;
            //ClientScript.RegisterStartupScript(GetType(), "Popup", "ShowPopup('" + sb.ToString() + "');", true);

        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void btnEditor_ServerClick(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
            string updateQuery = string.Format("UPDATE Tbl_Users Set U_Type={0}, U_CoverPic={1} Where UserKey={2}",
                IEUtils.SafeSQLString("Editor"),
                IEUtils.SafeSQLString("profilebanner.jpg"),
                IEUtils.SafeSQLString(Request.QueryString["k"]));
            db.ExecuteSQL(updateQuery);
            string getUserId = string.Format("SELECT UserID From Tbl_Users Where UserKey={0}",
                                             IEUtils.SafeSQLString(Request.QueryString["k"]));
            int userId = 0;
            SqlDataReader dr = db.ExecuteReader(getUserId);
            if(dr.HasRows)
            {
                dr.Read();
                userId = Convert.ToInt32(dr[0]);
            }
            dr.Close();
            dr.Dispose();
            db._sqlConnection.Close();
            int editorId = db.GetMaxID("EditorID", "Tbl_Editors");
           
            string editorKey = Encryption64.Encrypt(editorId.ToString(CultureInfo.InvariantCulture)).Replace('+', '=');
            string insertQuery =
                    string.Format(
                        "INSERT INTO Tbl_Editors(EditorKey,UserID,DatePosted) " +
                        "VALUES({0},{1},{2})",
                        IEUtils.SafeSQLString(editorKey),
                        userId,
                        IEUtils.SafeSQLDate(DateTime.UtcNow)
                        );
            db.ExecuteSQL(insertQuery);
            db._sqlConnection.Close();
            Response.Redirect("editor/myprofile.aspx?v=" + Request.QueryString["k"]);
            //var sb = new StringBuilder();
            //sb.Append(
            //    "Congratulation ! <br/></br>. Your account has been created. A confirmation email has been sent to your email. Please verify your email.");
            //// string message = "Your username is " + txtSignUpEmail.Value;
            //ClientScript.RegisterStartupScript(GetType(), "Popup", "ShowPopup('" + sb.ToString() + "');", true);

        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    
}