using DLS.DatabaseServices;
using System;
using System.Collections;
using System.Collections.Generic;
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
        if(db.RecordExist("SELECT NotifyID From Tbl_Notifications Where Title=" + IEUtils.SafeSQLString(txtName.Value.Trim())))
        {
            ErrorMessage.ShowErrorAlert(lblStatus, "Notification already exist", divAlerts);
        }
        else
        {
            List<int> lstUsersID = new List<int>();
            if(ddTo.SelectedValue=="0")
            {
                lstUsersID = GetAll();               
            }
            else if(ddTo.SelectedValue=="1")
            {
                lstUsersID = GetBrandsList();               
            }
            else if(ddTo.SelectedValue=="2")
            {
                lstUsersID = GetEditorsList();               
            }
            else if(ddTo.SelectedValue=="3")
            {
                lstUsersID.Add(IEUtils.ToInt(ddBrands.SelectedValue));
            }
            else if(ddTo.SelectedValue=="4")
            {
                lstUsersID.Add(IEUtils.ToInt(ddEditors.SelectedValue));
            }
            int notifyID = db.GetMaxID("NotifyID", "Tbl_Notifications");
          string  AddNotification =
                   string.Format("INSERT INTO Tbl_Notifications(UserID,Title,DatePosted) VALUES({0},{1},{2})",

                                 IEUtils.ToInt(1),
                                 IEUtils.SafeSQLString(txtName.Value),
                                 IEUtils.SafeSQLDate(DateTime.UtcNow)

                       );

            db.ExecuteSQL(AddNotification);
            foreach (int userID in lstUsersID)
            {
                updateQuery =
                   string.Format("INSERT INTO Tbl_NotifyFor(NotifyID,RecipID) VALUES({0},{1})",
                                IEUtils.ToInt(notifyID),
                                 IEUtils.ToInt(userID)                               

                       );

                db.ExecuteSQL(updateQuery);
            }
           
            Common.EmptyTextBoxes(this);
            ddBrands.Visible = false;
            ddEditors.Visible = false;
            ErrorMessage.ShowSuccessAlert(lblStatus, "Notification record posted.", divAlerts);            
        }               

    }
    protected List<int> GetAll()
    {
        DatabaseManagement db = new DatabaseManagement();
        List<int> lstAll = new List<int>();
        string selectAll = "SELECT UserID From Tbl_Users";
        SqlDataReader dr = db.ExecuteReader(selectAll);
        if (dr.HasRows)
        {
            while (dr.Read())
                lstAll.Add(IEUtils.ToInt(dr[0]));
        }
        dr.Close();
        return lstAll;
    }
    protected List<int> GetBrandsList()
    {
        DatabaseManagement db = new DatabaseManagement();
        List<int> lstBrands = new List<int>();
        string selectBrands = string.Format("SELECT UserID From Tbl_Users Where U_Type={0}", IEUtils.SafeSQLString("Brand"));
        SqlDataReader dr = db.ExecuteReader(selectBrands);
        if(dr.HasRows)
        {
            while (dr.Read())
                lstBrands.Add(IEUtils.ToInt(dr[0]));
        }
        dr.Close();
        return lstBrands;
    }
    protected List<int> GetEditorsList()
    {
        DatabaseManagement db = new DatabaseManagement();
        List<int> lstEditors = new List<int>();
        string selectEditors = string.Format("SELECT UserID From Tbl_Users Where U_Type={0}", IEUtils.SafeSQLString("Editor"));
        SqlDataReader dr = db.ExecuteReader(selectEditors);
        if (dr.HasRows)
        {
            while (dr.Read())
                lstEditors.Add(IEUtils.ToInt(dr[0]));
        }
        dr.Close();
        return lstEditors;
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



    protected void ddTo_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if(ddTo.SelectedValue=="3")
            {
                ddBrands.Visible = true;
                ddEditors.Visible = false;
            }
            else if(ddTo.SelectedValue=="4")
            {
                ddBrands.Visible = false;
                ddEditors.Visible = true;
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
}