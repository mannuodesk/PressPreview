using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for ErrorMessage
/// </summary>
public class ErrorMessage
{
    public static void SetErrorMessage(Label lblErrorMessage, Image imgError, string errorMessage, bool isShow)
    {
        lblErrorMessage.Visible = isShow;
        lblErrorMessage.Text = errorMessage;
        imgError.Visible = isShow;
    }
    public static void SetErrorMessage(Label lblErrorMessage, string successMessage, bool isShow, System.Drawing.Color color)
    {
        lblErrorMessage.Visible = isShow;
        lblErrorMessage.Text = successMessage;
        lblErrorMessage.ForeColor = color;
    }

    public static void ShowErrorAlert(Label lblTarget,string message,HtmlGenericControl divAlert)
    {
        lblTarget.Text = message;
        var currentClass = divAlert.Attributes["class"];
        var newclassvalue = divAlert.Attributes["class"].Replace(currentClass, "alert alert-danger fade in");
        divAlert.Attributes.Remove("class");
        divAlert.Attributes.Add("class", newclassvalue);
        divAlert.Visible = true;
    }

    public static void ShowSuccessAlert(Label lblTarget, string message, HtmlGenericControl divAlert)
    {
        lblTarget.Text = message;
        var currentClass = divAlert.Attributes["class"];
        var newclassvalue = divAlert.Attributes["class"].Replace(currentClass, "alert alert-success fade in");
        divAlert.Attributes.Remove("class");
        divAlert.Attributes.Add("class", newclassvalue);
        divAlert.Visible = true;
    }

}
