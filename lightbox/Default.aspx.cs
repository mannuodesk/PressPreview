using DLS.DatabaseServices;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

public partial class home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                LoadLBData();
                SetTotalViews();
                Common.SetLightboxContent(rptLbItems, Convert.ToInt32(Request.QueryString["v"]));
                BrandFollowers();
                BrandLikes();
            }
            catch (Exception ex)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
            
        }
    }
    protected void SetTotalViews()
    {
        try
        {
            DatabaseManagement db = new DatabaseManagement();
            int TotalViews = Convert.ToInt32(lblTotalViews.Text);
            string qryViews = string.Format("UPDATE Tbl_Lookbooks Set Views={0}  Where LookID={1}",TotalViews, IEUtils.ToInt(Request.QueryString["v"]));
            db.ExecuteSQL(qryViews);
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void BrandLikes()
    {
        try
        {
            var db = new DatabaseManagement();
            string followers = string.Format("SELECT COUNT(Id) as TotalLikes From Tbl_LookBook_Likes Where LookID={0}", IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(followers);
            int result = 0;
            if(dr.HasRows)
            {
                dr.Read();
                if (!dr.IsDBNull(0))
                    result = Convert.ToInt32(dr[0]);
            }
            dr.Close();
            lblTotalLikes.Text= result.ToString();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
       
    }
    protected void BrandFollowers()
    {
        try
        {
            DatabaseManagement db = new DatabaseManagement();
            string followers = string.Format("SELECT COUNT(Id) as TotalLikes From Tbl_UserFollowers Where UserID={0}", IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(followers);
            int result = 0;
            if (dr.HasRows)
            {
                dr.Read();
                if (!dr.IsDBNull(0))
                    result = Convert.ToInt32(dr[0]);
            }
            dr.Close();
           // lblTotalFollowers.Text = result.ToString();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
       
    }

    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
  public static List<string> GetLookbookTitle(string lbName)
    {
        List<string> empResult = new List<string>();
        DatabaseManagement db = new DatabaseManagement();
        using (SqlConnection con = new SqlConnection(db.ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT Top 10 Title From Tbl_Lookbooks Where Title LIKE ''+@SearchName+'%'";
                cmd.Connection = con;
                con.Open();
                cmd.Parameters.AddWithValue("@SearchName", lbName);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    empResult.Add(dr["Name"].ToString());
                }
                con.Close();
                return empResult;
            }
        }
        
    }

    protected void LoadLBData()
    {
        try
        {
            DatabaseManagement db = new DatabaseManagement();
            string lookbookData = string.Format("SELECT dbo.Tbl_Lookbooks.LookID, dbo.Tbl_Lookbooks.LookKey, dbo.Tbl_Lookbooks.Title," + 
                " dbo.Tbl_Lookbooks.Description as [LbDescription], ISNULL(dbo.Tbl_Lookbooks.Views,0) as [Views], dbo.Tbl_Lookbooks.BrandID, dbo.Tbl_Images.Image," + 
                " dbo.Tbl_Images.Description AS [ItemDescription] " + 
                " FROM dbo.Tbl_Lookbooks INNER JOIN dbo.Tbl_Images ON dbo.Tbl_Lookbooks.LookID = dbo.Tbl_Images.LookID " +
                "Where  dbo.Tbl_Lookbooks.LookID ={0} AND  dbo.Tbl_Lookbooks.IsDeleted IS NULL AND IsPublished = 1", IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(lookbookData);
            if (dr.HasRows)
            {
                dr.Read();
                lblLookbookName.Text = dr[2].ToString();
               lblLbDescription.Text = dr[3].ToString();
                lblTotalViews.Text = dr.IsDBNull(4) ? "0" : (Convert.ToInt32(dr[4])+1).ToString();
            }
            dr.Close();
            db._sqlConnection.Close();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void btnPostComment_ServerClick(object sender, EventArgs e)
    {

    }
      

    protected void lbtnLike_Click(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
            string qryAddLike = string.Format("INSERT INTO Tbl_LookBook_Likes(LookID,LikeID) VALUES({0},{1})", IEUtils.ToInt(Request.QueryString["v"]), IEUtils.ToInt(Session["UserID"]));
            db.ExecuteSQL(qryAddLike);
            if (lblTotalLikes.Text == "")
                lblTotalLikes.Text = "0";
            lblTotalLikes.Text = (Convert.ToInt32(lblTotalLikes.Text) + 1).ToString();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
}