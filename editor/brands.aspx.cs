using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using DLS.DatabaseServices;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
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
                ViewState["CurrentAlphabet"] = "ALL";
                this.GenerateAlphabets();
                this.BindDataList();
                Common.SetBannerImage(imgBanner);
                if (Common.Getunread_Messages() > 0)
                {
                    lblTotalMessages.Visible = true;
                    lblTotalMessages.Text = Common.Getunread_Messages().ToString();
                }

                if (Common.Getunread_Alerts() > 0)
                {
                    lblTotalNotifications.Visible = true;
                    lblTotalNotifications.Text = Common.Getunread_Alerts().ToString();
                }
            }
            catch (Exception ex)
            {
                ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
            }
            
        }
    }
    private void GenerateAlphabets()
    {
        List<Alphabet> alphabets = new List<Alphabet>();
        Alphabet alphabet = new Alphabet();
        alphabet.Value = "ALL";
        alphabet.isNotSelected = !alphabet.Value
                    .Equals(ViewState["CurrentAlphabet"]);
        alphabets.Add(alphabet);
        for (int i = 65; i <= 90; i++)
        {
            alphabet = new Alphabet();
            alphabet.Value = Char.ConvertFromUtf32(i);
            alphabet.isNotSelected = !alphabet.Value
                    .Equals(ViewState["CurrentAlphabet"]);
            alphabets.Add(alphabet);
        }
        //  rptAlphabets.DataSource = alphabets;
        //  rptAlphabets.DataBind();
    }
      private void BindDataList()
    {
    int pageIndex = 1;
    int pagesize = 2;
    var itemList = new List<BrandsSorting>();
        DatabaseManagement db = new DatabaseManagement();
        SqlCommand cmd = new SqlCommand("spx_GetBrands");
        db._sqlConnection.Open();
        cmd.Connection = db._sqlConnection;
        cmd.CommandType = CommandType.StoredProcedure;
        Session["CurrentAlphabet"] = ViewState["CurrentAlphabet"].ToString();
        string alphabets = ViewState["CurrentAlphabet"].ToString();
        cmd.Parameters.AddWithValue("@Alphabet", ViewState["CurrentAlphabet"]);
        SqlDataReader dr = cmd.ExecuteReader();
        int startItems = ((pageIndex - 1) * pagesize) + 1;
        int endItems = (startItems + pagesize) - 1;
        int tempCount = 1;
        if (dr.HasRows)
            {
            while (dr.Read())
                {

                var objitem = new BrandsSorting
                {
                    brandId = IEUtils.ToInt(dr["BrandID"]),
                    brandKey = IEUtils.ToString(dr["BrandKey"]),
                    name = IEUtils.ToString(dr["Name"]),
                    userId = IEUtils.ToInt(dr["UserID"]),
                    userKey = IEUtils.ToString(dr["UserKey"])
                    
                };

                if (tempCount >= startItems && tempCount <= endItems)
                    {
                    itemList.Add(objitem);
                    }
                tempCount++;

                }
            }






        //dlBrands.DataSource = itemList;
        //dlBrands.DataBind();
        db._sqlConnection.Close();

        if (ViewState["CurrentAlphabet"].ToString().Equals("ALL"))
            lblView.Text = "All Brands.";
        else
            lblView.Text = "Brands whose name starts with "
                        + ViewState["CurrentAlphabet"].ToString();
    }
    
      [WebMethod(EnableSession = true), ScriptMethod]
    public static List<BrandsSorting> GetData(int pageIndex, string alphabet)
        {
        
        int pagesize = 20;
        var itemList = new List<BrandsSorting>();
        DatabaseManagement db = new DatabaseManagement();
        SqlCommand cmd = new SqlCommand("spx_GetBrands");
        db._sqlConnection.Open();
        cmd.Connection = db._sqlConnection;
        cmd.CommandType = CommandType.StoredProcedure;
        //string alphabets =HttpContext.Current.Session["CurrentAlphabet"].ToString();
        cmd.Parameters.AddWithValue("@Alphabet", alphabet);
        SqlDataReader dr = cmd.ExecuteReader();
        int startItems = ((pageIndex - 1) * pagesize) + 1;
        int endItems = (startItems + pagesize) - 1;
        int tempCount = 1;
        if (dr.HasRows)
            {
            while (dr.Read())
                {

                var objitem = new BrandsSorting
                {
                    brandId = IEUtils.ToInt(dr["BrandID"]),
                    brandKey = IEUtils.ToString(dr["BrandKey"]),
                    name = IEUtils.ToString(dr["Name"]),
                    userId = IEUtils.ToInt(dr["UserID"]),
                    userKey = IEUtils.ToString(dr["UserKey"])

                };

                if (tempCount >= startItems && tempCount <= endItems)
                    {
                    itemList.Add(objitem);
                    }
                tempCount++;

                }
            }




        return itemList;

        }

    protected void Alphabet_Click(object sender, EventArgs e)
    {
        LinkButton lnkAlphabet = (LinkButton)sender;
        ViewState["CurrentAlphabet"] = lnkAlphabet.Text;
        this.GenerateAlphabets();
        this.BindDataList();
    }
    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
  public static List<string> GetBrandName(string empName)
    {
        List<string> empResult = new List<string>();
        DatabaseManagement db = new DatabaseManagement();
        using (SqlConnection con = new SqlConnection(db.ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT Top 10 Name From Tbl_Brands Where Name LIKE '"+ empName + "%'";
                cmd.Connection = con;
                con.Open();
               // cmd.Parameters.AddWithValue("@SearchEmpName", empName);
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

    // Top menu message list binding
    protected void rptMessageList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblDatePosted = (Label)e.Item.FindControl("lblDate");
                // Label lblDate2 = (Label)e.Item.FindControl("lblDate2");
                DateTime dbDate = Convert.ToDateTime(lblDatePosted.Text);
                lblDatePosted.Text = Common.GetRelativeTime(dbDate);

            }


        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    protected void rptMessageList_ItemCommand(object sender, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "2")
            {
                string[] messageIDs = e.CommandArgument.ToString().Split(',');
                var parentIDCookie = new HttpCookie("ParentId") { Value = messageIDs[0] };
                HttpContext.Current.Response.Cookies.Add(parentIDCookie);
                var messageIDCookie = new HttpCookie("MessageId") { Value = messageIDs[1] };
                HttpContext.Current.Response.Cookies.Add(messageIDCookie);

                var db = new DatabaseManagement();

                // update the status of the message to read
                db.ExecuteSQL(string.Format("Update Tbl_Mailbox Set MessageStatus={0} Where ParentID={1}",
                                            IEUtils.SafeSQLString("read"), IEUtils.ToInt(messageIDs[1])));
                Response.Redirect("massenger.aspx");
            }
        }
        catch (Exception ex)
        {
            ErrorMessage.ShowErrorAlert(lblStatus, ex.Message, divAlerts);
        }
    }
    [WebMethod, ScriptMethod]
    public static void UpdateMessageStatus(string userID)
    {
        var db = new DatabaseManagement();
        string insertQuery = string.Format("UPDATE Tbl_MailboxFor Set ReadStatus={0} Where ReceiverID={1}",
                                           1, IEUtils.ToInt(userID));
        db.ExecuteSQL(insertQuery);


    }

    protected void rptNotifications_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var lblDatePosted = (Label)e.Item.FindControl("lblDatePosted");
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