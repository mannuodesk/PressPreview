using System;
using System.Web.UI.WebControls;
using Tco.DatabaseServices;
public partial class home_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            var db = new DatabaseManagement();
            var objbanner = new Bannerimages();
            objbanner.bindNivoSlider(db, repeaterNivoSlider);
        }
    }


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if(e.Row.RowType==DataControlRowType.DataRow)
            {
                //dtlstImageGallery
                Label lblgallaryID = (Label) e.Row.FindControl("lblGid");
                int gallaryID = Convert.ToInt32(lblgallaryID.Text);
                var dlimages = (DataList) e.Row.FindControl("dtlstImageGallery");
                string selectQuery = "SELECT * FROM Tbl_Gallaryimages Where GallaryID=" + gallaryID;
                sdsimages.SelectCommand = selectQuery;
                dlimages.DataSource = sdsimages;
                dlimages.DataBind();
            }
        }
        catch (Exception ex)
        {
           // ErrorMessage.SetErrorMessage(lblStatus, ex.Message, true, System.Drawing.Color.Yellow);
        }
    }
}