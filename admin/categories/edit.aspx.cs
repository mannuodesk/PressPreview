﻿using DLS.DatabaseServices;
using System;
using System.Collections;
using System.Data.SqlClient;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class admin_home_Default : System.Web.UI.Page
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                if (Common.Getunread_Alerts() > 0)
                {
                    lblTotalNotifications.Visible = true;
                    lblTotalNotifications.Text = Common.Getunread_Alerts().ToString();
                }
                var alCommonControls = new ArrayList { lblUsername, imgUserphoto };
                Common.AdminSettings(alCommonControls);
                LoadData();
                
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    
    protected void LoadData()
    {
        try
        {
            DatabaseManagement db = new DatabaseManagement();
            string selectQuery = string.Format("SELECT * From Tbl_Categories Where CategoryID={0}", IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(selectQuery);
            if(dr.HasRows)
            {
                dr.Read();
                txtName.Value = dr[2].ToString();
                txtDescription.Value = dr[4].ToString();
               

            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Default.aspx");
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    private void UpdateQuery(DatabaseManagement db)
    {
        string updateQuery = string.Empty;
        
                updateQuery =
                    string.Format("Update Tbl_Categories Set Title={0},Description={1} Where CategoryID={2}",
                                  IEUtils.SafeSQLString(txtName.Value),
                                  IEUtils.SafeSQLString(txtDescription.Value),
                                 
                                  IEUtils.ToInt(Request.QueryString["v"])

                        );
          
        db.ExecuteSQL(updateQuery);
      //  string updateUser = string.Format("Update Tbl_Users Set U_Status={0}, U_EmailStatus={1} Where UserID={2}",
                                  //        IEUtils.SafeSQLString(ddStatus.SelectedValue), IEUtils.SafeSQLString(ddEmailStatus.SelectedValue), IEUtils.ToInt(Session["StoreOwnerID"]));
       // db.ExecuteSQL(updateUser);
        Common.EmptyTextBoxes(this);
        LoadData();
        ErrorMessage.ShowSuccessAlert(lblStatus, "Category record updated.", divAlerts);

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
             UpdateQuery(db);            
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void grdNotifications_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var lblDatePosted = (Label)e.Row.FindControl("lblDatePosted");
                DateTime dbDate = Convert.ToDateTime(lblDatePosted.Text);
                lblDatePosted.Text = Common.GetRelativeTime(dbDate);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    [WebMethod, ScriptMethod]
    public static void UpdateNotifications(string userID)
    {
        var db = new DatabaseManagement();
        string insertQuery = string.Format("UPDATE Tbl_NotifyFor Set ReadStatus={0} Where RecipID={1}",
                                           1, IEUtils.ToInt(userID));
        db.ExecuteSQL(insertQuery);

    }

}