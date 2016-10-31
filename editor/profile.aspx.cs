using DLS.DatabaseServices;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ArrayList al = new ArrayList();
        al.Add(lblUsername);
        al.Add(imgUserIcon);
        Common.UserSettings(al);
        if (!IsPostBack)
        {
            try
            {
               Common.SetBannerImage(imgBanner);
                LoadBrandData();
                SetTotalViews();
                BrandFollowers();
                BrandLikes();
            }
            catch (Exception ex)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
            
        }
    }

    protected void BrandLikes()
    {
        try
        {
            DatabaseManagement db = new DatabaseManagement();
            string followers = string.Format("SELECT COUNT(Id) as TotalLikes From Tbl_BrandsLikes Where UserID={0}", IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(followers);
            int result = 0;
            if(dr.HasRows)
            {
                dr.Read();
                if (!dr.IsDBNull(0))
                    result = Convert.ToInt32(dr[0]);
            }
            dr.Close();
            lblTotolLikes.Text= result.ToString();
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
            lblTotalFollowers.Text = result.ToString();
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
    protected void SetTotalViews()
    {
        try
        {
            DatabaseManagement db = new DatabaseManagement();
            int TotalViews = Convert.ToInt32(lblTotolViews.Text);
            string qryViews = string.Format("UPDATE Tbl_Brands Set TotalViews={0}  Where BrandID={1}", TotalViews, IEUtils.ToInt(Request.QueryString["v"]));
            db.ExecuteSQL(qryViews);
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void LoadBrandData()
    {
        try
        {
            DatabaseManagement db = new DatabaseManagement();
            string BrandData = string.Format("Select * From Tbl_Brands Where BrandID={0}", IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(BrandData);
            if(dr.HasRows)
            {
                dr.Read();
                lbBrandName.InnerText = dr[2].ToString();
                lbWebURL.HRef = dr[13].ToString();
                imgLogo.Src = "../brandslogoThumb/" + dr[4].ToString();
                lblCity.Text = dr[8].ToString();
                lblCountry.Text = dr[6].ToString();
                lblAbout.Text = dr[5].ToString();
                if (dr.IsDBNull(23))
                    lblTotolViews.Text = "0";
                else
                    lblTotolViews.Text = (Convert.ToInt32(dr[23])+1).ToString();
            }
            dr.Close();
            db._sqlConnection.Close();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected int LbLikes(int lookId)
    {
        try
        {
            DatabaseManagement db = new DatabaseManagement();
            string followers = string.Format("SELECT COUNT(Id) as TotalLikes From Tbl_LookBook_Likes  Where LookID={0}", lookId);
            SqlDataReader dr = db.ExecuteReader(followers);
            int result = 0;
            if (dr.HasRows)
            {
                dr.Read();
                if (!dr.IsDBNull(0))
                    result = Convert.ToInt32(dr[0]);
            }
            dr.Close();
            return result;
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
        return 0;
    }
    protected void rptLookbook_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblDatePosted = (Label)e.Item.FindControl("lblDate");
                Label lblDate2 = (Label)e.Item.FindControl("lblDate2");
                DateTime dbDate = Convert.ToDateTime(lblDatePosted.Text);
                lblDate2.Text = Common.GetRelativeTime(dbDate);
                var lblLikes = (Label)e.Item.FindControl("lblLikes");
                lblLikes.Text = LbLikes(Convert.ToInt32(lblLikes.Text)).ToString();

            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void ByCategory(int categryId)
    {
        try
        {
            DatabaseManagement db = new DatabaseManagement();
            string qryCategory = string.Format("SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, dbo.Tbl_Brands.Logo, dbo.Tbl_Lookbooks.LookID," +
                            " dbo.Tbl_Lookbooks.Title, dbo.Tbl_Lookbooks.LookKey, dbo.Tbl_Lookbooks.Description, dbo.Tbl_Lookbooks.MainImg, dbo.Tbl_Lookbooks.Views," +
                            " CAST(Tbl_Lookbooks.DatePosted AS VARCHAR(12)) as DatePosted, Tbl_Lookbooks.DatePosted as [dated] FROM dbo.Tbl_Brands " +
                            " INNER JOIN dbo.Tbl_Lookbooks ON dbo.Tbl_Brands.BrandID = dbo.Tbl_Lookbooks.BrandID " +
                            " Where dbo.Tbl_Brands.BrandID ={0} AND CategoryID={1} AND dbo.Tbl_Lookbooks.IsDeleted IS NULL AND dbo.Tbl_Lookbooks.IsPublished = 1 " +
                            " ORDER BY dbo.Tbl_Lookbooks.DatePosted DESC", IEUtils.ToInt(Request.QueryString["v"]), categryId);
            rptLookbook.DataSourceID = "";
            rptLookbook.DataSource = db.ExecuteReader(qryCategory);
            rptLookbook.DataBind();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void BySeason(int seasonId)
    {
        try
        {
            DatabaseManagement db = new DatabaseManagement();
            string qrySeason = string.Format("SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, dbo.Tbl_Brands.Logo, dbo.Tbl_Lookbooks.LookID," +
                            " dbo.Tbl_Lookbooks.Title, dbo.Tbl_Lookbooks.LookKey, dbo.Tbl_Lookbooks.Description, dbo.Tbl_Lookbooks.MainImg, dbo.Tbl_Lookbooks.Views," +
                            " CAST(Tbl_Lookbooks.DatePosted AS VARCHAR(12)) as DatePosted, Tbl_Lookbooks.DatePosted as [dated] FROM dbo.Tbl_Brands " +
                            " INNER JOIN dbo.Tbl_Lookbooks ON dbo.Tbl_Brands.BrandID = dbo.Tbl_Lookbooks.BrandID " +
                            " Where dbo.Tbl_Brands.BrandID ={0} AND seasonID={1} AND dbo.Tbl_Lookbooks.IsDeleted IS NULL AND dbo.Tbl_Lookbooks.IsPublished = 1 " +
                            " ORDER BY dbo.Tbl_Lookbooks.DatePosted DESC", IEUtils.ToInt(Request.QueryString["v"]), seasonId);
            rptLookbook.DataSourceID = "";
            rptLookbook.DataSource = db.ExecuteReader(qrySeason);
            rptLookbook.DataBind();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void rptbrdCategories_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if(e.CommandName=="1")
            {
                txtsearch.Text = string.Empty;
                int categoryID = Convert.ToInt32(e.CommandArgument);
                ByCategory(categoryID);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void rptSeason_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "1")
            {
                txtsearch.Text = string.Empty;
                int seasonID = Convert.ToInt32(e.CommandArgument);
                BySeason(seasonID);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void txtsearch_TextChanged(object sender, EventArgs e)
    {
        DatabaseManagement db = new DatabaseManagement();
        using (SqlConnection con = new SqlConnection(db.ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                string qrySeason = "SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, dbo.Tbl_Brands.Logo, dbo.Tbl_Lookbooks.LookID," +
                           " dbo.Tbl_Lookbooks.Title, dbo.Tbl_Lookbooks.LookKey, dbo.Tbl_Lookbooks.Description, dbo.Tbl_Lookbooks.MainImg, dbo.Tbl_Lookbooks.Views," +
                           " CAST(Tbl_Lookbooks.DatePosted AS VARCHAR(12)) as DatePosted, Tbl_Lookbooks.DatePosted as [dated] FROM dbo.Tbl_Brands " +
                           " INNER JOIN dbo.Tbl_Lookbooks ON dbo.Tbl_Brands.BrandID = dbo.Tbl_Lookbooks.BrandID " +
                           " Where dbo.Tbl_Brands.BrandID =@BrandID AND dbo.Tbl_Lookbooks.Title LIKE ''+@SearchName+'%'  AND dbo.Tbl_Lookbooks.IsDeleted IS NULL AND dbo.Tbl_Lookbooks.IsPublished = 1 " +
                           " ORDER BY dbo.Tbl_Lookbooks.DatePosted DESC";
                cmd.CommandText = qrySeason;
                cmd.Connection = con;
                con.Open();
                cmd.Parameters.AddWithValue("@BrandID", Convert.ToInt32(Request.QueryString["v"]));
                cmd.Parameters.AddWithValue("@SearchName", txtsearch.Text);

               // SqlDataReader dr = cmd.ExecuteReader();
                rptLookbook.DataSourceID = "";
                rptLookbook.DataSource = cmd.ExecuteReader();
                rptLookbook.DataBind();
                con.Close();
                
            }
        }
    }
}