using DLS.DatabaseServices;
using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;


public partial class admin_home_Default : System.Web.UI.Page
{
    string currentLogo = string.Empty;
    #region "Private Properties"
    private int _currentPage;
    public int CurrentPage
    {
        get
        {
            Object objPage = ViewState["_CurrentPage"];
            _currentPage = objPage == null ? 0 : Convert.ToInt32(objPage);
            return _currentPage;
        }
        set
        {
            ViewState["_CurrentPage"] = value;
        }
    }
    private int _firstindex;
    public int FirstIndex
    {
        get
        {
            _firstindex = string.IsNullOrEmpty(ViewState["_FirstIndex"].ToString()) ? 0 : Convert.ToInt32(ViewState["_FirstIndex"]);
            return _firstindex;
        }
        set
        {
            ViewState["_FirstIndex"] = value;
        }
    }
    private int _lastindex;
    public int LastIndex
    {
        get
        {
            _lastindex = string.IsNullOrEmpty(ViewState["_LastIndex"].ToString()) ? 0 : Convert.ToInt32(ViewState["_FirstIndex"]);
            return _lastindex;
        }
        set
        {
            ViewState["_LastIndex"] = value;
        }
    }
    #endregion
    #region "Private Methods"
    private DataTable GetDataTable()
    {
        var dtItems = new DataTable();
        var dcName = new DataColumn { ColumnName = "Title", DataType = System.Type.GetType("System.String") };
        dtItems.Columns.Add(dcName);
        for (int i = 1; i <= 100; i++)
        {
            DataRow row = dtItems.NewRow();
            row["Title"] = "Sample Row: &nbsp; I am putting here sample data";
            dtItems.Rows.Add(row);
        }
        return dtItems;
    }
    
    private void BindLikeList(string @orderby, int brandId)
    {
        try
        {
            var db = new DatabaseManagement();
            var dSet = new DataSet();
            var da = new SqlDataAdapter("SELECT U_Firstname + ' ' + U_Lastname as FullName, Tbl_Users.UserID, U_ProfilePic From Tbl_Users Where UserID IN (SELECT LikeID From Tbl_BrandsLikes Where UserID=(SELECT UserID From Tbl_Brands Where BrandID=" + brandId + "))", db.ConnectionString);
            da.Fill(dSet);
            DataTable dt = dSet.Tables[0];
            _likesDataSource.DataSource = dt.DefaultView;
            _likesDataSource.AllowPaging = true;
            // set the data list page size
            _likesDataSource.PageSize = Convert.ToInt32(ddLikePageSize.SelectedValue);
            // set the first page
            _likesDataSource.CurrentPageIndex = CurrentPage;
            ViewState["TotalPages"] = _likesDataSource.PageCount;
            if (_likesDataSource.DataSourceCount > 0)
            {
                if (!_likesDataSource.IsLastPage)
                    lblLikesPageInfo.Text = "Showing " + _likesDataSource.FirstIndexInPage + 1 + " to " +
                                   ((_likesDataSource.CurrentPageIndex + 1) * (_likesDataSource.PageSize)).ToString(CultureInfo.InvariantCulture) +
                                   " of " + _likesDataSource.DataSourceCount.ToString(CultureInfo.InvariantCulture) + " ( " +
                                   _likesDataSource.PageCount + " Pages )";
                else
                    lblLikesPageInfo.Text = "Showing " + _likesDataSource.FirstIndexInPage + 1 + " to " +
                                   _likesDataSource.DataSourceCount.ToString(CultureInfo.InvariantCulture) +
                                   " of " + _likesDataSource.DataSourceCount.ToString(CultureInfo.InvariantCulture) + " ( " +
                                   _likesDataSource.PageCount + " Pages )";
            }
            else
                lblLikesPageInfo.Text = "No Likes Record Found !";

            lbLikePrev.Enabled = !_likesDataSource.IsFirstPage;
            lbLikeNext.Enabled = !_likesDataSource.IsLastPage;

            dlLikes.DataSource = _likesDataSource;
            dlLikes.DataBind();
            DoLikesPaging();
            //}
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    
    private void DoLikesPaging()
    {
        var dt = new DataTable();
        dt.Columns.Add("PageIndex");
        dt.Columns.Add("PageText");
        FirstIndex = CurrentPage - 3;
        if (CurrentPage > 3)
            LastIndex = CurrentPage + 3;
        else
            LastIndex = 3;
        if (LastIndex > Convert.ToInt32(ViewState["TotalPages"]))
        {
            LastIndex = Convert.ToInt32(ViewState["TotalPages"]);
            FirstIndex = LastIndex - 3;
        }
        for (int i = FirstIndex; i < LastIndex; i++)
        {
            DataRow dr = dt.NewRow();
            dr[0] = i;
            dr[1] = i + 1;
            dt.Rows.Add(dr);
        }

        dlPaging2.DataSource = dt;
        dlPaging2.DataBind();
    }
    #endregion
    #region "PagedDataSource"
    readonly PagedDataSource _pageDataSource = new PagedDataSource();
    readonly PagedDataSource _likesDataSource = new PagedDataSource();
    #endregion
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
                //ddCountry.DataSource = Utility.GetCountryList();
                //ddCountry.DataBind();
                
                BindLikeList(ddLikeSort.SelectedValue, IEUtils.ToInt(Request.QueryString["v"]));
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
            string selectQuery = string.Format("SELECT * From Tbl_Brands Where BrandID={0}", IEUtils.ToInt(Request.QueryString["v"]));
            SqlDataReader dr = db.ExecuteReader(selectQuery);
            if(dr.HasRows)
            {
                dr.Read();
                txtBrandName.Value = dr[2].ToString();
                Session["CurrentBrand"] = dr[2].ToString();
                //lblImageName.Text = dr[4].ToString();
                //if (dr.IsDBNull(4))
                //    imgLogo.ImageUrl = "../../brandslogoThumb/blank.png";
                //else
                //{
                //    imgLogo.ImageUrl = "../../brandslogoThumb/" + dr[4].ToString(); 
                //}
                
                txtBio.Value = dr[5].ToString();
                txtCountry.Value = dr[6].ToString();
                txtState.Value = dr[7].ToString();
                txtCity.Value = dr[8].ToString();
                txtPostalCode.Value = dr[9].ToString();
                txtAddress.Value = dr[10].ToString();
                txtPhone.Value = dr[11].ToString();
                txtEmail.Value = dr[12].ToString();
                txtBrandURL.Value = dr[13].ToString();
                txtFbURL.Value = dr[14].ToString();
                txtTwitterURL.Value = dr[15].ToString();
                txtInstaURL.Value = dr[16].ToString();
                txtBrandHistory.Text = dr[17].ToString();
                txtYoutube.Value = dr[27].ToString();
                txtPinterest.Value = dr[28].ToString();
            }
            dr.Close();
            string usersettings = string.Format("SELECT U_Status, U_EmailStatus,U_ProfilePic From Tbl_Users Where UserID=(SELECT UserID From Tbl_Brands Where BrandID={0})", IEUtils.ToInt(Request.QueryString["v"]));
            dr = db.ExecuteReader(usersettings);
            if (dr.HasRows)
            {
                dr.Read();
                ddAccountStatus.SelectedValue = dr[0].ToString();
                lblImageName.Text = dr[2].ToString();
                if (dr.IsDBNull(2))
                    imgLogo.ImageUrl = "../../brandslogoThumb/blank.png";
                else
                {
                    imgLogo.ImageUrl = "../../brandslogoThumb/" + dr[2].ToString();
                }
                //ddEmailStatus.SelectedValue = dr[1].ToString();
            }
            dr.Close();
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
    private void UpdateQuery(string pic, DatabaseManagement db)
    {
        string updateQuery = string.Empty;
        if (Session["CurrentBrand"].ToString() != txtBrandName.Value)
        {
            if (db.RecordExist("SELECT BrandID From Tbl_Brands Where Name=" + IEUtils.SafeSQLString(txtBrandName.Value)))
                ErrorMessage.ShowErrorAlert(lblStatus, "Brand already exist. Please try different name.", divAlerts);
            else
            {
                updateQuery =
                    string.Format("Update Tbl_Brands Set Name={0},Logo={1},Bio={2},Country={3}," +
                                  "Province={4},City={5},PostalCode={6},Address={7},Phone={8},Email={9},Url={10}, FbURL={11},TwitterURL={12},InstagramURL={13},History={14},DateModified={15}  Where BrandID={16}",
                                  IEUtils.SafeSQLString(txtBrandName.Value),
                                  IEUtils.SafeSQLString(pic),
                                  IEUtils.SafeSQLString(txtBio.Value),
                                  IEUtils.SafeSQLString(txtCountry.Value),
                                  IEUtils.SafeSQLString(txtState.Value),
                                  IEUtils.SafeSQLString(txtCity.Value),
                                  IEUtils.SafeSQLString(txtPostalCode.Value),
                                  IEUtils.SafeSQLString(txtAddress.Value),
                                  IEUtils.SafeSQLString(txtPhone.Value),
                                  IEUtils.SafeSQLString(txtEmail.Value),
                                  IEUtils.SafeSQLString(txtBrandURL.Value),
                                  IEUtils.SafeSQLString(txtFbURL.Value),
                                  IEUtils.SafeSQLString(txtTwitterURL.Value),
                                  IEUtils.SafeSQLString(txtInstaURL.Value),
                                  IEUtils.SafeSQLString(txtBrandHistory.Text),
                                  IEUtils.SafeSQLDate(DateTime.Now),
                                  IEUtils.SafeSQLString(Request.QueryString["v"].Trim())

                        );
            }
        }
        else
        {
            updateQuery =
                   string.Format("Update Tbl_Brands Set Name={0},Logo={1},Bio={2},Country={3}," +
                                 "Province={4},City={5},PostalCode={6},Address={7},Phone={8},Email={9},Url={10}, FbURL={11},TwitterURL={12},InstagramURL={13},History={14},DateModified={15}  Where BrandID={16}",
                                 IEUtils.SafeSQLString(txtBrandName.Value),
                                 IEUtils.SafeSQLString(pic),
                                 IEUtils.SafeSQLString(txtBio.Value),
                                 IEUtils.SafeSQLString(txtCountry.Value),
                                 IEUtils.SafeSQLString(txtState.Value),
                                 IEUtils.SafeSQLString(txtCity.Value),
                                 IEUtils.SafeSQLString(txtPostalCode.Value),
                                 IEUtils.SafeSQLString(txtAddress.Value),
                                 IEUtils.SafeSQLString(txtPhone.Value),
                                 IEUtils.SafeSQLString(txtEmail.Value),
                                 IEUtils.SafeSQLString(txtBrandURL.Value),
                                 IEUtils.SafeSQLString(txtFbURL.Value),
                                 IEUtils.SafeSQLString(txtTwitterURL.Value),
                                 IEUtils.SafeSQLString(txtInstaURL.Value),
                                 IEUtils.SafeSQLString(txtBrandHistory.Text),
                                 IEUtils.SafeSQLDate(DateTime.Now),
                                 IEUtils.SafeSQLString(Request.QueryString["v"].Trim())

                       );
        }
        db.ExecuteSQL(updateQuery);
        string AddUser = string.Format("UPDATE Tbl_Users Set U_Email={0},U_ProfilePic={1},U_Status={2} WHERE UserID=(SELECT UserID From Tbl_Brands Where BrandID={3})",
          IEUtils.SafeSQLString(txtEmail.Value),
          IEUtils.SafeSQLString(pic),
          IEUtils.ToInt(ddAccountStatus.SelectedValue),
          //IEUtils.ToInt(ddEmailStatus.SelectedValue),
          IEUtils.SafeSQLString(Request.QueryString["v"].Trim()));
        db.ExecuteSQL(AddUser);
        Common.EmptyTextBoxes(this);
        Response.Redirect("Default.aspx");
        //LoadData();
        //ErrorMessage.ShowSuccessAlert(lblStatus, "Brand record updated.", divAlerts);

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            var db = new DatabaseManagement();
            if (!fupLogo.HasFile)
                UpdateQuery(lblImageName.Text, db);
            else
            {
                string ext = Path.GetExtension(fupLogo.PostedFile.FileName);
                switch (ext)
                {
                    case ".bmp":
                    case ".png":
                    case ".gif":
                    case ".jpeg":
                    case ".jpg":
                        {
                            var fname = Common.RandomPinCode() + ext;
                            var rootpath = Server.MapPath("../../brandslogo/");
                            var imagepath = rootpath + fname;
                            fupLogo.SaveAs(imagepath);
                            var thumbnaillogo = Utility.GenerateThumbNail(fname, imagepath, "../brandslogoThumb/", 200,200);
                            UpdateQuery(fname, db);
                        }
                        break;
                    default:
                        ErrorMessage.ShowErrorAlert(lblStatus,
                                                    "Invalid file format. Valid image formats are JPG,JPEG,PNG, GIF,BMP",
                                                    divAlerts);
                        break;
                }
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
   
   
   
    protected void dlpaging_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        try
        {
            var lnkbtnPage = (LinkButton)e.Item.FindControl("lnkbtnPage");
            if (lnkbtnPage.CommandArgument == CurrentPage.ToString(CultureInfo.InvariantCulture))
            {
                lnkbtnPage.Enabled = false;
                lnkbtnPage.Style.Add("font-size", "14px");
                lnkbtnPage.Font.Bold = true;
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void ddSort_SelectedIndexChanged(object sender, EventArgs e)
    {
      
    }
    protected void ddPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }

    #region "Likes Grid"
    protected void lbLikePrev_Click(object sender, EventArgs e)
    {
        try
        {
            CurrentPage -= 1;
            BindLikeList(ddLikeSort.SelectedValue, Convert.ToInt32(Request.QueryString["v"]));
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void lbLikeNext_Click(object sender, EventArgs e)
    {
        try
        {
            CurrentPage += 1;
            BindLikeList(ddLikeSort.SelectedValue, Convert.ToInt32(Request.QueryString["v"]));
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void dlPaging2_ItemCommand(object source, DataListCommandEventArgs e)
    {
        try
        {
            if (e.CommandName.Equals("Paging"))
            {
                CurrentPage = Convert.ToInt16(e.CommandArgument.ToString());
                BindLikeList(ddLikeSort.SelectedValue, Convert.ToInt32(Request.QueryString["v"]));
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void dlPaging2_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        try
        {
            var lnkbtnPage = (LinkButton)e.Item.FindControl("lnkbtnPage");
            if (lnkbtnPage.CommandArgument == CurrentPage.ToString(CultureInfo.InvariantCulture))
            {
                lnkbtnPage.Enabled = false;
                lnkbtnPage.Style.Add("font-size", "14px");
                lnkbtnPage.Font.Bold = true;
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void ddLikeSort_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindLikeList(ddLikeSort.SelectedValue, Convert.ToInt32(Request.QueryString["v"]));
    }
    protected void ddLikePageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindLikeList(ddLikeSort.SelectedValue, Convert.ToInt32(Request.QueryString["v"]));
    }
    #endregion

    protected void dlFollowers_ItemCommand(object source, DataListCommandEventArgs e)
    {
        try
        {
            if (e.CommandName.Equals("1"))
            {
                DatabaseManagement db = new DatabaseManagement();
                int FollowerID = IEUtils.ToInt(e.CommandArgument);
                string UnfollowQuery = string.Format("Delete From Tbl_UserFollowers Where UserID=(select UserID From Tbl_Brands Where BrandID={0}) AND FollowerID={1}", IEUtils.ToInt(Request.QueryString["v"]), FollowerID);
                db.ExecuteSQL(UnfollowQuery);
                               
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }

    protected void dlLikes_ItemCommand(object source, DataListCommandEventArgs e)
    {
        try
        {
            if (e.CommandName.Equals("1"))
            {
                DatabaseManagement db = new DatabaseManagement();
                int LikeID = IEUtils.ToInt(e.CommandArgument);
                string UnLikeQuery = string.Format("Delete From Tbl_BrandsLikes Where UserID=(select UserID From Tbl_Brands Where BrandID={0}) AND LikeID={1}", IEUtils.ToInt(Request.QueryString["v"]), LikeID);
                db.ExecuteSQL(UnLikeQuery);
                BindLikeList(ddLikeSort.SelectedValue, Convert.ToInt32(Request.QueryString["v"]));
            }
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