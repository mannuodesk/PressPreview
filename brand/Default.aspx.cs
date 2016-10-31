using System;
using System.Collections;

public class Brand_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        var al = new ArrayList {lblUsername, imgUserIcon};
        Common.UserSettings(al);
        if (!IsPostBack)
        {
            try
            {
                Common.SetFeatured1_brand(rptFeatured1,Convert.ToInt32(Session["UserID"]));
                Common.SetFeatured2_brand(rptFeatured2, Convert.ToInt32(Session["UserID"]));
                Common.SetBannerImage(imgBanner);
            }
            catch (Exception ex)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
            
        }
    }
}