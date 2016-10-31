using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;

public partial class events_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSearch_OnServerClick(object sender, EventArgs e)
    {
        try
        {
            string searchQuery =
                string.Format(
                    "SELECT [EventID], [EventTitle], [EventDate], [StartTime], [EFeaturePic], [ELocation] FROM [Tbl_Events] Where EventTitle IS NOT NULL  AND EventTitle LIKE  {0} + '%'  OR ECity={1} OR ECategoryID={2}",
                    IEUtils.SafeSQLString(txtEventTitle.Value),
                    IEUtils.SafeSQLString(ddCity.SelectedValue),
                    IEUtils.ToInt(ddCategory.SelectedValue));
            sdsSearchEvents.SelectCommand = searchQuery;
            dlEvents.DataSourceID = "";
            dlEvents.DataSource = sdsSearchEvents;
            dlEvents.DataBind();
        }
        catch (Exception  ex)
        {
           ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
}