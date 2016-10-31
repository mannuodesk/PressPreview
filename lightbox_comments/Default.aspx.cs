using DLS.DatabaseServices;
using System;
using System.Web.UI.WebControls;

public partial class home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                Common.SetLightboxContent_comments(rptLbItems, Convert.ToInt32(Request.QueryString["v"]));
               
            }
            catch (Exception ex)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
            
        }
    }
      
    protected void btnAddComment_Click(object sender, EventArgs e)
    {
        try
        {
            if(! string.IsNullOrEmpty(txtComments.Text))
            {
                DatabaseManagement db = new DatabaseManagement();
                string qryAddComment = string.Format("INSERT INTO Tbl_LbComments(Title,UserID,LookID,DatePosted,ParentID) VALUES({0},{1},{2},{3},{4})",
                    IEUtils.SafeSQLString(txtComments.Text),
                    IEUtils.ToInt(Response.Cookies["UserID"].Value),
                    IEUtils.ToInt(Request.QueryString["v"]),
                    "'" + DateTime.UtcNow + "'",
                    0
                    );
                db.ExecuteSQL(qryAddComment);
                txtComments.Text = "";
                grdComments.DataBind();
            }
            else
            {
                ErrorMessage.ShowErrorAlert(lblStatus, "Please write your comment..", divAlerts);
            }
            
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    
    protected void grdComments_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                ImageButton imgbtnReply = (ImageButton)e.Row.FindControl("imgbtnReply");
                GridView grdReply = (GridView)e.Row.FindControl("grdReply");
                SqlDataSource sdsReply = (SqlDataSource)e.Row.FindControl("sdsComments");
                string qrySelect = "SELECT dbo.Tbl_LbComments.CommID, dbo.Tbl_LbComments.Title, dbo.Tbl_LbComments.DatePosted, dbo.Tbl_LbComments.LookID, U_Firstname + ' ' +U_Lastname as [U_Firstname], dbo.Tbl_Users.U_ProfilePic FROM dbo.Tbl_Users INNER JOIN dbo.Tbl_LbComments ON dbo.Tbl_Users.UserID = dbo.Tbl_LbComments.UserID " +
                " Where ParentID =" + Convert.ToInt32(imgbtnReply.CommandArgument) + " ORDER BY Tbl_LbComments.DatePosted DESC";
                sdsReply.SelectCommand = qrySelect;
                grdReply.DataSourceID = "";
                grdReply.DataSource = sdsReply;
                grdReply.DataBind();                
        }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
        
    }

    protected void grdComments_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if(e.CommandName=="1")
        {
            Panel pnlReply = (Panel)((GridViewRow)((DataControlFieldCell)((ImageButton)e.CommandSource).Parent).Parent).FindControl("pnlReply");
            pnlReply.Visible = true;
        }
        else if(e.CommandName=="2")
        {
            Panel pnlReply = (Panel)(((Button)e.CommandSource).Parent).FindControl("pnlReply");
            TextBox txtReply = (TextBox)pnlReply.FindControl("txtReply");
            int parentID = Convert.ToInt32(e.CommandArgument);
            DatabaseManagement db = new DatabaseManagement();
            string qryAddComment = string.Format("INSERT INTO Tbl_LbComments(Title,UserID,LookID,DatePosted,ParentID) VALUES({0},{1},{2},{3},{4})",
                    IEUtils.SafeSQLString(txtReply.Text),
                    IEUtils.ToInt(Session["UserID"]),
                    IEUtils.ToInt(Request.QueryString["v"]),
                    "'" + DateTime.UtcNow + "'",
                    parentID
                    );
            db.ExecuteSQL(qryAddComment);
            txtReply.Text = "";
            grdComments.DataBind();
        }
        
    }

    
}