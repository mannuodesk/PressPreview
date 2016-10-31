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
        //ArrayList al = new ArrayList();
        //al.Add(lblUsername);
        //al.Add(imgUserIcon);
        //Common.UserSettings(al);
        if (!IsPostBack)
        {
            try
            {
              // Common.SetBannerImage(imgBanner);
              //  LoadBrandData();
                
            }
            catch (Exception ex)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
            
        }
    }
    //protected void LoadBrandData()
    //{
    //    try
    //    {
    //        DatabaseManagement db = new DatabaseManagement();
    //        string BrandData = string.Format("Select * From Tbl_Brands Where BrandID={0}", IEUtils.ToInt(Request.QueryString["v"]));
    //        SqlDataReader dr = db.ExecuteReader(BrandData);
    //        if(dr.HasRows)
    //        {
    //            dr.Read();
    //            lbBrandName.InnerText = dr[2].ToString();
    //            lbWebURL.HRef = dr[13].ToString();
    //            imgLogo.Src = "../brandslogoThumb/" + dr[4].ToString();
    //            lblCity.Text = dr[8].ToString();
    //            lblCountry.Text = dr[6].ToString();
    //            lblAbout.Text = dr[5].ToString();
    //            if (dr.IsDBNull(23))
    //                lblTotolViews.Text = "0";
    //            else
    //                lblTotolViews.Text = (Convert.ToInt32(dr[23])+1).ToString();
    //        }
    //        dr.Close();
    //        db._sqlConnection.Close();
    //    }
    //    catch (Exception ex)
    //    {
    //        ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
    //    }
    //}

}