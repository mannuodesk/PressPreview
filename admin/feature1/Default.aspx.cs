using System.Data.SqlClient;
using DLS.DatabaseServices;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_home_Default : Page
    {
    private int _feature1Count = 0;
    protected void Page_Load(object sender, EventArgs e)
        {

        try
            {
            if (!IsPostBack)
                {
                                   GridView1.Visible = true;
            GridView2.Visible = false;
            GridView3.Visible = false;
            GridView4.Visible = false;
                if (Common.Getunread_Alerts() > 0)
                    {
                    lblTotalNotifications.Visible = true;
                    lblTotalNotifications.Text = Common.Getunread_Alerts().ToString();
                    }
                var alCommonControls = new ArrayList { lblUsername, imgUserphoto };
                Common.AdminSettings(alCommonControls);

                }
            GetFeature1Count();
            }
        catch (Exception ex)
            {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
        }

    protected void GetFeature1Count()
        {
        try
            {
            var db = new DatabaseManagement();
            string getFeature1Count = db.GetExecuteScalar("SELECT COUNT(ItemID) FROM Tbl_Items Where IsFeatured1=1");
            if (string.IsNullOrEmpty(getFeature1Count))
                {
                if (getFeature1Count != null)
                    {
                    int count = int.Parse(getFeature1Count);
                    if (count < 8)
                        lblCount.Text = count + " items are marked as featured 1. You can select " + (8 - count) + " more items as featured 1.";
                    else
                        {
                        lblCount.Text = count + " items are marked as featured 1. You can select no more items as featured 1.";
                        }
                    }

                }
            }
        catch (Exception ex)
            {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
        }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
        try
            {

            var db = new DatabaseManagement();
            if (e.CommandName == "1") // Mark as Feature 1
                {
                int recordID = Convert.ToInt32(e.CommandArgument);  // get the item id
                int sortOrder = 0;
                const string getMaxOrderNo = "Select MAX(SortOrder) From Tbl_Items Where IsFeatured1=1";
                SqlDataReader dr = db.ExecuteReader(getMaxOrderNo);
                if (dr.HasRows)
                    {
                    dr.Read();
                    sortOrder = dr.IsDBNull(0) ? 1 : Convert.ToInt32(dr[0]) + 1;
                    }

                dr.Close();
                //  int sortOrder = db.GetMaxID("SortOrder", "Tbl_Items"); // Get the sort order 
                String setSortOrder = string.Format("Update Tbl_Items Set SortOrder={0}, IsFeatured1={1}  Where ItemID={2}", sortOrder, 1, recordID);
                db.ExecuteSQL(setSortOrder);
                GridView1.DataBind();
                ErrorMessage.ShowSuccessAlert(lblStatus, "Item is marked as Feature 1.", divAlerts);
                }
            else if (e.CommandName == "2") // Un Mark as Feature 1
                {
                int recordID = Convert.ToInt32(e.CommandArgument);  // get the item id
                // get the sort order of the item
                int sortOrder =
                    Convert.ToInt32(db.GetExecuteScalar("Select SortOrder From Tbl_Items Where ItemID=" + recordID));
                // update the sort order field for the selected item. 
                string updateItem = string.Format("Update Tbl_Items Set IsFeatured1=NULL,SortOrder=NULL WHERE ItemID={0}", recordID);
                db.ExecuteSQL(updateItem);
                var lstItemID = new List<int>();
                string getItemIDs = string.Format("SELECT ItemID From Tbl_Items Where IsFeatured1=1 AND SortOrder>{0} ORDER BY SortOrder ", sortOrder);
                SqlDataReader dr = db.ExecuteReader(getItemIDs);
                if (dr.HasRows)
                    {
                    while (dr.Read())
                        {
                        lstItemID.Add(Convert.ToInt32(dr[0]));
                        }
                    }

                dr.Close();
                dr.Dispose();

                // Adjust the sort order of the pre dessor items
                foreach (int itemId in lstItemID)
                    {
                    string updateSortOrder = string.Format(
                        "Update Tbl_Items Set SortOrder=SortOrder-1 Where ItemID={0}", itemId);
                    db.ExecuteSQL(updateSortOrder);
                    }
                ErrorMessage.ShowSuccessAlert(lblStatus, "Item is removed from the Feature 1.", divAlerts);
                }
            // close the db connections
            GridView1.DataBind();
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
            }
        catch (Exception ex)
            {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
        }
    protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
        try
            {

            var db = new DatabaseManagement();
            if (e.CommandName == "1") // Mark as Feature 1
                {
                int recordID = Convert.ToInt32(e.CommandArgument);  // get the item id
                int sortOrder = 0;
                const string getMaxOrderNo = "Select MAX(SortOrder) From Tbl_Items Where IsFeatured1=1";
                SqlDataReader dr = db.ExecuteReader(getMaxOrderNo);
                if (dr.HasRows)
                    {
                    dr.Read();
                    sortOrder = dr.IsDBNull(0) ? 1 : Convert.ToInt32(dr[0]) + 1;
                    }

                dr.Close();
                //  int sortOrder = db.GetMaxID("SortOrder", "Tbl_Items"); // Get the sort order 
                String setSortOrder = string.Format("Update Tbl_Items Set SortOrder={0}, IsFeatured1={1}  Where ItemID={2}", sortOrder, 1, recordID);
                db.ExecuteSQL(setSortOrder);
                GridView2.DataBind();
                ErrorMessage.ShowSuccessAlert(lblStatus, "Item is marked as Feature 1.", divAlerts);
                }
            else if (e.CommandName == "2") // Un Mark as Feature 1
                {
                int recordID = Convert.ToInt32(e.CommandArgument);  // get the item id
                // get the sort order of the item
                int sortOrder =
                    Convert.ToInt32(db.GetExecuteScalar("Select SortOrder From Tbl_Items Where ItemID=" + recordID));
                // update the sort order field for the selected item. 
                string updateItem = string.Format("Update Tbl_Items Set IsFeatured1=NULL,SortOrder=NULL WHERE ItemID={0}", recordID);
                db.ExecuteSQL(updateItem);
                var lstItemID = new List<int>();
                string getItemIDs = string.Format("SELECT ItemID From Tbl_Items Where IsFeatured1=1 AND SortOrder>{0} ORDER BY SortOrder ", sortOrder);
                SqlDataReader dr = db.ExecuteReader(getItemIDs);
                if (dr.HasRows)
                    {
                    while (dr.Read())
                        {
                        lstItemID.Add(Convert.ToInt32(dr[0]));
                        }
                    }

                dr.Close();
                dr.Dispose();

                // Adjust the sort order of the pre dessor items
                foreach (int itemId in lstItemID)
                    {
                    string updateSortOrder = string.Format(
                        "Update Tbl_Items Set SortOrder=SortOrder-1 Where ItemID={0}", itemId);
                    db.ExecuteSQL(updateSortOrder);
                    }
                ErrorMessage.ShowSuccessAlert(lblStatus, "Item is removed from the Feature 1.", divAlerts);
                }
            // close the db connections
            GridView2.DataBind();
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
            }
        catch (Exception ex)
            {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
        }
    protected void GridView3_RowCommand(object sender, GridViewCommandEventArgs e)
        {
        try
            {

            var db = new DatabaseManagement();
            if (e.CommandName == "1") // Mark as Feature 1
                {
                int recordID = Convert.ToInt32(e.CommandArgument);  // get the item id
                int sortOrder = 0;
                const string getMaxOrderNo = "Select MAX(SortOrder) From Tbl_Items Where IsFeatured1=1";
                SqlDataReader dr = db.ExecuteReader(getMaxOrderNo);
                if (dr.HasRows)
                    {
                    dr.Read();
                    sortOrder = dr.IsDBNull(0) ? 1 : Convert.ToInt32(dr[0]) + 1;
                    }

                dr.Close();
                //  int sortOrder = db.GetMaxID("SortOrder", "Tbl_Items"); // Get the sort order 
                String setSortOrder = string.Format("Update Tbl_Items Set SortOrder={0}, IsFeatured1={1}  Where ItemID={2}", sortOrder, 1, recordID);
                db.ExecuteSQL(setSortOrder);
                GridView3.DataBind();
                ErrorMessage.ShowSuccessAlert(lblStatus, "Item is marked as Feature 1.", divAlerts);
                }
            else if (e.CommandName == "2") // Un Mark as Feature 1
                {
                int recordID = Convert.ToInt32(e.CommandArgument);  // get the item id
                // get the sort order of the item
                int sortOrder =
                    Convert.ToInt32(db.GetExecuteScalar("Select SortOrder From Tbl_Items Where ItemID=" + recordID));
                // update the sort order field for the selected item. 
                string updateItem = string.Format("Update Tbl_Items Set IsFeatured1=NULL,SortOrder=NULL WHERE ItemID={0}", recordID);
                db.ExecuteSQL(updateItem);
                var lstItemID = new List<int>();
                string getItemIDs = string.Format("SELECT ItemID From Tbl_Items Where IsFeatured1=1 AND SortOrder>{0} ORDER BY SortOrder ", sortOrder);
                SqlDataReader dr = db.ExecuteReader(getItemIDs);
                if (dr.HasRows)
                    {
                    while (dr.Read())
                        {
                        lstItemID.Add(Convert.ToInt32(dr[0]));
                        }
                    }

                dr.Close();
                dr.Dispose();

                // Adjust the sort order of the pre dessor items
                foreach (int itemId in lstItemID)
                    {
                    string updateSortOrder = string.Format(
                        "Update Tbl_Items Set SortOrder=SortOrder-1 Where ItemID={0}", itemId);
                    db.ExecuteSQL(updateSortOrder);
                    }
                ErrorMessage.ShowSuccessAlert(lblStatus, "Item is removed from the Feature 1.", divAlerts);
                }
            // close the db connections
            GridView3.DataBind();
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
            }
        catch (Exception ex)
            {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
        }
    protected void GridView4_RowCommand(object sender, GridViewCommandEventArgs e)
        {
        try
            {

            var db = new DatabaseManagement();
            if (e.CommandName == "1") // Mark as Feature 1
                {
                int recordID = Convert.ToInt32(e.CommandArgument);  // get the item id
                int sortOrder = 0;
                const string getMaxOrderNo = "Select MAX(SortOrder) From Tbl_Items Where IsFeatured1=1";
                SqlDataReader dr = db.ExecuteReader(getMaxOrderNo);
                if (dr.HasRows)
                    {
                    dr.Read();
                    sortOrder = dr.IsDBNull(0) ? 1 : Convert.ToInt32(dr[0]) + 1;
                    }

                dr.Close();
                //  int sortOrder = db.GetMaxID("SortOrder", "Tbl_Items"); // Get the sort order 
                String setSortOrder = string.Format("Update Tbl_Items Set SortOrder={0}, IsFeatured1={1}  Where ItemID={2}", sortOrder, 1, recordID);
                db.ExecuteSQL(setSortOrder);
                GridView4.DataBind();
                ErrorMessage.ShowSuccessAlert(lblStatus, "Item is marked as Feature 1.", divAlerts);
                }
            else if (e.CommandName == "2") // Un Mark as Feature 1
                {
                int recordID = Convert.ToInt32(e.CommandArgument);  // get the item id
                // get the sort order of the item
                int sortOrder =
                    Convert.ToInt32(db.GetExecuteScalar("Select SortOrder From Tbl_Items Where ItemID=" + recordID));
                // update the sort order field for the selected item. 
                string updateItem = string.Format("Update Tbl_Items Set IsFeatured1=NULL,SortOrder=NULL WHERE ItemID={0}", recordID);
                db.ExecuteSQL(updateItem);
                var lstItemID = new List<int>();
                string getItemIDs = string.Format("SELECT ItemID From Tbl_Items Where IsFeatured1=1 AND SortOrder>{0} ORDER BY SortOrder ", sortOrder);
                SqlDataReader dr = db.ExecuteReader(getItemIDs);
                if (dr.HasRows)
                    {
                    while (dr.Read())
                        {
                        lstItemID.Add(Convert.ToInt32(dr[0]));
                        }
                    }

                dr.Close();
                dr.Dispose();

                // Adjust the sort order of the pre dessor items
                foreach (int itemId in lstItemID)
                    {
                    string updateSortOrder = string.Format(
                        "Update Tbl_Items Set SortOrder=SortOrder-1 Where ItemID={0}", itemId);
                    db.ExecuteSQL(updateSortOrder);
                    }
                ErrorMessage.ShowSuccessAlert(lblStatus, "Item is removed from the Feature 1.", divAlerts);
                }
            // close the db connections
            GridView4.DataBind();
            db._sqlConnection.Close();
            db._sqlConnection.Dispose();
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
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
        try
            {
            if (e.Row.RowType == DataControlRowType.DataRow)
                {
                var isFeature1 = (Label)(e.Row.FindControl("lblFeature1"));
                var btnMF = (Button)e.Row.FindControl("btnMF");
                var btnUMF = (Button)e.Row.FindControl("btnUMF");

                if (isFeature1.Text == "Yes")
                    {
                    _feature1Count = _feature1Count + 1;
                    btnMF.Visible = false;
                    btnUMF.Visible = true;
                    }
                else
                    {
                    btnMF.Visible = true;
                    btnUMF.Visible = false;
                    }
                }



            }
        catch (Exception ex)
            {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
        }
    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
        try
            {
            if (e.Row.RowType == DataControlRowType.DataRow)
                {
                var isFeature1 = (Label)(e.Row.FindControl("lblFeature1"));
                var btnMF = (Button)e.Row.FindControl("btnMF");
                var btnUMF = (Button)e.Row.FindControl("btnUMF");

                if (isFeature1.Text == "Yes")
                    {
                    _feature1Count = _feature1Count + 1;
                    btnMF.Visible = false;
                    btnUMF.Visible = true;
                    }
                else
                    {
                    btnMF.Visible = true;
                    btnUMF.Visible = false;
                    }
                }



            }
        catch (Exception ex)
            {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
        }
    protected void GridView3_RowDataBound(object sender, GridViewRowEventArgs e)
        {
        try
            {
            if (e.Row.RowType == DataControlRowType.DataRow)
                {
                var isFeature1 = (Label)(e.Row.FindControl("lblFeature1"));
                var btnMF = (Button)e.Row.FindControl("btnMF");
                var btnUMF = (Button)e.Row.FindControl("btnUMF");

                if (isFeature1.Text == "Yes")
                    {
                    _feature1Count = _feature1Count + 1;
                    btnMF.Visible = false;
                    btnUMF.Visible = true;
                    }
                else
                    {
                    btnMF.Visible = true;
                    btnUMF.Visible = false;
                    }
                }



            }
        catch (Exception ex)
            {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
        }
    protected void GridView4_RowDataBound(object sender, GridViewRowEventArgs e)
        {
        try
            {
            if (e.Row.RowType == DataControlRowType.DataRow)
                {
                var isFeature1 = (Label)(e.Row.FindControl("lblFeature1"));
                var btnMF = (Button)e.Row.FindControl("btnMF");
                var btnUMF = (Button)e.Row.FindControl("btnUMF");

                if (isFeature1.Text == "Yes")
                    {
                    _feature1Count = _feature1Count + 1;
                    btnMF.Visible = false;
                    btnUMF.Visible = true;
                    }
                else
                    {
                    btnMF.Visible = true;
                    btnUMF.Visible = false;
                    }
                }



            }
        catch (Exception ex)
            {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
        }
    protected void btnSearch_Click(object sender, EventArgs e)
        {
        try
            {
           
            if (ddbrandName.SelectedValue != "0" && txtName.Text != "") // Search by both
                {
                GridView1.Visible = false;
                GridView2.PageIndex = 0;
                GridView2.Visible = true;
                GridView3.Visible = false;
                GridView4.Visible = false;
                }
            else if (ddbrandName.SelectedValue == "0" && txtName.Text != "") // Search by Item name only
                {
                GridView1.Visible = false;
                GridView2.Visible = false;
                GridView3.Visible = false;
                GridView4.PageIndex = 0;
                GridView4.Visible = true;
                }
            else if (ddbrandName.SelectedValue != "0" && txtName.Text == "") // Search by brand only
                {
                GridView1.Visible = false;
                GridView2.Visible = false;
                GridView3.PageIndex = 0;
                GridView3.Visible = true;
                GridView4.Visible = false;
                }
            else
                {
                GridView1.PageIndex = 0;
                GridView1.Visible = true;
                GridView2.Visible = false;
                GridView3.Visible = false;
                GridView4.Visible = false;
                }
            
            }
        catch (Exception ex)
            {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
        }
    protected void btnViewAll_Click(object sender, EventArgs e)
        {
        try
            {
            ddbrandName.SelectedValue = "0";
            txtName.Text = "";
            //GridView1.DataSourceID = "";
            //GridView1.DataSource = sdsSlider;
            //GridView1.DataBind();
            GridView1.PageIndex = 0;
            GridView1.Visible = true;
            GridView2.Visible = false;
            GridView3.Visible = false;
            GridView4.Visible = false;
            }
        catch (Exception ex)
            {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }

        }

    [ScriptMethod()]
    [WebMethod]
    public static List<string> GetItemTitle(string lbName, string lbUser)
        {
        var empResult = new List<string>();
        var db = new DatabaseManagement();
        using (var con = new SqlConnection(db.ConnectionString))
            {
            using (var cmd = new SqlCommand())
                {
                cmd.CommandText = "SELECT Top 10 Title From Tbl_Items Where UserID=" + Convert.ToInt32(lbUser) + " AND Title LIKE  '" + lbName + "%'";
                cmd.Connection = con;
                con.Open();
                //  cmd.Parameters.AddWithValue("@SearchName", lbName);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                    {
                    empResult.Add(dr["Title"].ToString());
                    }
                con.Close();
                db._sqlConnection.Close();
                return empResult;
                }

            }

        }
    }