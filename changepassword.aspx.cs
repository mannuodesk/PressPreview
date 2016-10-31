using DLS.DatabaseServices;
using System;

public partial class frmlogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSignUp_ServerClick(object sender, EventArgs e)
    {
       
    }
    
    protected void btnChangePass_OnServerClick(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();

                    string insertQuery =
                        string.Format(
                            "Update Tbl_Users Set U_Password={0} Where UserKey={1} AND U_Email={2} ",
                            IEUtils.SafeSQLString(txtSignUpPassword.Value),
                            IEUtils.SafeSQLString(Request.QueryString["ck"]),
                            IEUtils.SafeSQLString(Request.QueryString["email"])
                           
                            );
                db.ExecuteSQL(insertQuery);
                ErrorMessage.ShowSuccessAlert(lblStatus, "Your password changed successfully.", divAlerts);
            dvForm.Visible = false;
            lbGotoHome.Visible = true;

        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
}