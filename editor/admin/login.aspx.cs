using System;

public partial class admin_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            var objLogin = new Login();
            if (objLogin.ValidateUser(txtEmail.Value, txtPassword.Value, "Admin"))
                Response.Redirect("home/");
            else
                lblMessage.Visible = true;            
        }
        catch (Exception ex)
        {
            lblMessage.Visible = true;
            lblMessage.Text = ex.Message;
        }
    }
}