using DLS.DatabaseServices;
using System;

public partial class forgetpassword : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!IsPostBack)
        //    ConfirmEmail();
        dvFailed.Visible = false;
        dvSuccess.Visible = true;
    }

    protected void btnGoTo_ServerClick(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }

    protected void ConfirmEmail()
    {
        try
        {
            var db = new DatabaseManagement();
            bool isAccountExist = db.RecordExist(string.Format("Select UserID From Tbl_Users Where UserKey={0} AND U_Email={1}", IEUtils.SafeSQLString(Request.QueryString["ck"]), IEUtils.SafeSQLString(Request.QueryString["email"])));
            if(isAccountExist)
            {
                dvFailed.Visible = false;
                dvSuccess.Visible = true;
                string updateQuery =
                string.Format("UPDATE Tbl_Users Set U_EmailStatus=1, U_Status=1 Where UserKey={0} AND U_Email={1}",
                              IEUtils.SafeSQLString(Request.QueryString["ck"]),
                              IEUtils.SafeSQLString(Request.QueryString["email"]));
                db.ExecuteSQL(updateQuery);
            }
            else
            {
                dvFailed.Visible = true;
                dvSuccess.Visible = false;
                ErrorMessage.ShowErrorAlert(lblStatus, "Invalid parameters. Account verification failed.", divAlerts);
            }
            
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
}