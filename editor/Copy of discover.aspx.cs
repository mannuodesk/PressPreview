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
        var al = new ArrayList {lblUsername, imgUserIcon};
        Common.UserSettings(al);
        if (!IsPostBack)
        {
            try
            {
                Common.SetBannerImage(imgBanner);
            }
            catch (Exception ex)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
            
        }
    }
    
    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
  public static List<string> GetBrandName(string empName)
    {
        var empResult = new List<string>();
        var db = new DatabaseManagement();
        using (var con = new SqlConnection(db.ConnectionString))
        {
            using (var cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT Top 10 Name From Tbl_Brands Where Name LIKE '" + empName + "%'";
                cmd.Connection = con;
                con.Open();
                cmd.Parameters.AddWithValue("@SearchEmpName", empName);
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
    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static SqlDataReader GetBrandList(string rowNum)
    {
        List<string> empResult = new List<string>();
        DatabaseManagement db = new DatabaseManagement();
        using (SqlConnection con = new SqlConnection(db.ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT Top "+ rowNum + " BrandID,BrandKey,Name From Tbl_Brands ORDER BY TotalViews DESC";
                cmd.Connection = con;
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                return dr;     
                            
            }
        }

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
                lblLikes.Text = (Convert.ToInt32(lblLikes.Text)).ToString();

            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void txtsearch_ServerChange(object sender, EventArgs e)
    {
        var db = new DatabaseManagement();
        using (var con = new SqlConnection(db.ConnectionString))
        {
            using (var cmd = new SqlCommand())
            {
                string qrySeason = "SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, dbo.Tbl_Brands.Logo, dbo.Tbl_Lookbooks.LookID," +
                           " dbo.Tbl_Lookbooks.Title, dbo.Tbl_Lookbooks.LookKey, dbo.Tbl_Lookbooks.Description, dbo.Tbl_Lookbooks.MainImg, dbo.Tbl_Lookbooks.Views," +
                           " CAST(Tbl_Lookbooks.DatePosted AS VARCHAR(12)) as DatePosted, Tbl_Lookbooks.DatePosted as [dated] FROM dbo.Tbl_Brands " +
                           " INNER JOIN dbo.Tbl_Lookbooks ON dbo.Tbl_Brands.BrandID = dbo.Tbl_Lookbooks.BrandID " +
                           " Where dbo.Tbl_Lookbooks.Title LIKE '" + txtsearch.Value + "%'  AND dbo.Tbl_Lookbooks.IsDeleted IS NULL AND dbo.Tbl_Lookbooks.IsPublished = 1 " +
                           " ORDER BY dbo.Tbl_Lookbooks.DatePosted DESC";
                cmd.CommandText = qrySeason;
                cmd.Connection = con;
                con.Open();
                rptLookbook.DataSourceID = "";
                rptLookbook.DataSource = cmd.ExecuteReader();
                rptLookbook.DataBind();
                con.Close();

            }
        }
    }
    protected void ByCategory(int categryId)
    {
        try
        {
            var db = new DatabaseManagement();
            string qryCategory = string.Format("SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, dbo.Tbl_Brands.Logo, dbo.Tbl_Lookbooks.LookID," +
                            " dbo.Tbl_Lookbooks.Title, dbo.Tbl_Lookbooks.LookKey, dbo.Tbl_Lookbooks.Description, dbo.Tbl_Lookbooks.MainImg, dbo.Tbl_Lookbooks.Views," +
                            " CAST(Tbl_Lookbooks.DatePosted AS VARCHAR(12)) as DatePosted, Tbl_Lookbooks.DatePosted as [dated] FROM dbo.Tbl_Brands " +
                            " INNER JOIN dbo.Tbl_Lookbooks ON dbo.Tbl_Brands.BrandID = dbo.Tbl_Lookbooks.BrandID " +
                            " Where  CategoryID={0} AND dbo.Tbl_Lookbooks.IsDeleted IS NULL AND dbo.Tbl_Lookbooks.IsPublished = 1 " +
                            " ORDER BY dbo.Tbl_Lookbooks.DatePosted DESC",  categryId);
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
            var db = new DatabaseManagement();
            string qrySeason = string.Format("SELECT dbo.Tbl_Brands.Name, dbo.Tbl_Brands.BrandID, dbo.Tbl_Brands.BrandKey, dbo.Tbl_Brands.Logo, dbo.Tbl_Lookbooks.LookID," +
                            " dbo.Tbl_Lookbooks.Title, dbo.Tbl_Lookbooks.LookKey, dbo.Tbl_Lookbooks.Description, dbo.Tbl_Lookbooks.MainImg, dbo.Tbl_Lookbooks.Views," +
                            " CAST(Tbl_Lookbooks.DatePosted AS VARCHAR(12)) as DatePosted, Tbl_Lookbooks.DatePosted as [dated] FROM dbo.Tbl_Brands " +
                            " INNER JOIN dbo.Tbl_Lookbooks ON dbo.Tbl_Brands.BrandID = dbo.Tbl_Lookbooks.BrandID " +
                            " Where  seasonID={0} AND dbo.Tbl_Lookbooks.IsDeleted IS NULL AND dbo.Tbl_Lookbooks.IsPublished = 1 " +
                            " ORDER BY dbo.Tbl_Lookbooks.DatePosted DESC", seasonId);
            rptLookbook.DataSourceID = "";
            rptLookbook.DataSource = db.ExecuteReader(qrySeason);
            rptLookbook.DataBind();
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void rptCategories_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "1")
            {
                txtsearch.Value = string.Empty;
                int categoryID = Convert.ToInt32(e.CommandArgument);
                ByCategory(categoryID);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void rptSeasons_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "1")
            {
                txtsearch.Value = string.Empty;
                int seasonID = Convert.ToInt32(e.CommandArgument);
                BySeason(seasonID);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
}