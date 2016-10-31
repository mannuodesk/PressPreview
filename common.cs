using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;

/// <summary>
/// Summary description for common
/// </summary>
public static class Common
{
    static readonly string SmtpServer = System.Configuration.ConfigurationManager.AppSettings["MailServer"];
    static readonly string SmtpPort = System.Configuration.ConfigurationManager.AppSettings["SMTP_Port"];
    static readonly string MailSenderAddress = System.Configuration.ConfigurationManager.AppSettings["SenderEmail"];
    static readonly string MailSenderPassword = System.Configuration.ConfigurationManager.AppSettings["SenderPassword"];

    public static string RandomPinCode()
    {
        string guidResult = Guid.NewGuid().ToString();
        guidResult = guidResult.Replace("-", string.Empty);
        const int length = 10;
        if (length > guidResult.Length)
        {
            throw new ArgumentException("Length must be between 1 and " + guidResult.Length);
        }
        return guidResult.Substring(0, length);
    }

    public static bool Send_Contact_Mail_Message(string senderMailAdress, string receiverMailAddress, string mailSubject, string mailMessage)
    {
        bool functionReturnValue = false;
        try
        {
            string mailmsg = null;
            string toAddress = receiverMailAddress;
            var mm = new MailMessage(senderMailAdress, toAddress) {Subject = mailSubject};
            mailmsg = mailMessage;
            mm.Body = mailmsg;
            mm.IsBodyHtml = true;
            var smtp = new SmtpClient
                           {
                               Host = SmtpServer,
                               Port = Convert.ToInt32(SmtpPort),
                               Credentials = new NetworkCredential(MailSenderAddress, MailSenderPassword)
                           };
            smtp.Send(mm);
            functionReturnValue = true;
        }
        catch
        {
            functionReturnValue = false;
        }
        return functionReturnValue;
    }

    public static bool Send_ConfirmationEmail(string senderMailAdress, string receiverMailAddress, string mailSubject, string mailMessage)
    {
        bool functionReturnValue = false;
        try
        {
            string mailmsg = null;
            string toAddress = receiverMailAddress;
            var mm = new MailMessage(senderMailAdress, toAddress) { Subject = mailSubject };
            mailmsg = mailMessage;
            mm.Body = mailmsg;
            mm.IsBodyHtml = true;
            AlternateView htmlview = AlternateView.CreateAlternateViewFromString(mailMessage, null, "text/html");
            mm.AlternateViews.Add(htmlview);
            var smtp = new SmtpClient
            {
                Host = SmtpServer,
                Port = Convert.ToInt32(SmtpPort),
                Credentials = new NetworkCredential(MailSenderAddress, MailSenderPassword)
            };
            smtp.Send(mm);
            functionReturnValue = true;
        }
        catch
        {
            functionReturnValue = false;
        }
        return functionReturnValue;
    }

    public static void LoadYearVal(DropDownList ddYearList)
    {
        ddYearList.Items.Add(new ListItem("--- Select ---", "0"));
            int currentYear = DateTime.Now.Year;
            for (int cnt = currentYear; cnt > 2000; cnt--)
                ddYearList.Items.Add(new ListItem(cnt.ToString(), cnt.ToString()));
       
    }

    public static void ExportToExcel(GridView grdView, string filename)
    {
       // grdView.Visible = true;
        grdView.AllowPaging = false;
        grdView.DataBind();
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + filename + ".xls");
        HttpContext.Current.Response.Charset = "";

        HttpContext.Current.Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
        HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        grdView.Visible = true;
        grdView.RenderControl(htmlWrite);
        grdView.Visible = false;
        HttpContext.Current.Response.Write(stringWrite.ToString());
        HttpContext.Current.Response.End();
        
        grdView.AllowPaging = true;
        grdView.DataBind();
       // 
    }

    public static void EmptyTextBoxes(Control parent)
    {
        // Loop through all the controls on the page
        foreach (Control c in parent.Controls)
        {
            // Check and see if it's a textbox
            if (object.ReferenceEquals(c.GetType(), typeof(TextBox)))
            {
                // Since its a textbox clear out the text  
                ((TextBox)c).Text = "";
            }
            else if (object.ReferenceEquals(c.GetType(), typeof(DropDownList)))
            {
                ((DropDownList)c).SelectedIndex = -1;
            }
            else if(object.ReferenceEquals(c.GetType(),typeof(HtmlInputText)))
            {
                ((HtmlInputText)c).Value = "";
            }
            // Now we need to call itself (recursive) because
            // all items (Panel, GroupBox, etc) is a container
            // so we need to check all containers for any
            // textboxes so we can clear them
            if (c.HasControls())
            {
                EmptyTextBoxes(c);
            }
        }
    }

    public static void 
        UserSettings(ArrayList alCommonControls)
    {
        try
        {
            if (HttpContext.Current.Session["UserID"].ToString() == "")
            {
                HttpContext.Current.Response.Redirect("../login.aspx");
            }
            else
            {
                var db = new DatabaseManagement();
                string selectQuery =
                    string.Format("SELECT UserID,U_Firstname + ' ' + U_Lastname as Fullname,U_ProfilePic From Tbl_Users  WHERE Tbl_Users.UserID={0}", IEUtils.ToInt(HttpContext.Current.Session["UserID"]));
                SqlDataReader dr = db.ExecuteReader(selectQuery);
                if (dr.HasRows)
                {
                    dr.Read();
                    //((HyperLink)alCommonControls[0]).Text = dr["StoreName"].ToString();
                    ((Label)alCommonControls[0]).Text = dr["Fullname"].ToString();
                    ((Image)alCommonControls[1]).ImageUrl = "../brandslogoThumb/" + dr["U_ProfilePic"];

                }
            }
        }
        catch (Exception)
        {
            throw;
        }
       
    }

    public static void AdminSettings(ArrayList alCommonControls)
    {
        if (HttpContext.Current.Session["UserID"].ToString() == "")
        {
            HttpContext.Current.Response.Redirect("../Default.aspx");
        }
        else
        {
            var db = new DatabaseManagement();
            string selectQuery =
                string.Format(
                    "SELECT U_FirstName,U_MainPic,StoreName,StoreLogo From Tbl_Users INNER JOIN Tbl_Stores ON Tbl_Users.UserID=Tbl_Stores.UserID  WHERE Tbl_Users.UserID={0}", IEUtils.ToInt(HttpContext.Current.Session["UserID"]));
            SqlDataReader dr = db.ExecuteReader(selectQuery);
            if (dr.HasRows)
            {
                dr.Read();
                // ((HyperLink)alCommonControls[0]).Text = dr["StoreName"].ToString();
                ((Label)alCommonControls[0]).Text = dr["U_FirstName"].ToString();
                ((Image)alCommonControls[1]).ImageUrl = "../../profilethumbs/" + dr["U_MainPic"];
                ((Image)alCommonControls[2]).ImageUrl = "../../images/logo-BrandsHub-yell.png";
            }
        }
    }
     
        
    
    public static void GetAdminSummary(List<Label> lstLabels)
    {
        try
        {
            var db = new DatabaseManagement();
            lstLabels[0].Text = db.GetExecuteScalar("SELECT COUNT(UserID) FROM Tbl_Users Where U_Type='Brand' AND IsApproved=1");
            lstLabels[1].Text = db.GetExecuteScalar("SELECT COUNT(UserID) FROM Tbl_Users Where U_Type='Editor' AND IsApproved=1");
            lstLabels[2].Text = db.GetExecuteScalar("SELECT COUNT(CategoryID) FROM Tbl_Categories");
            lstLabels[3].Text = " (" + db.GetExecuteScalar("SELECT COUNT(UserID) FROM Tbl_Users Where U_Type='Brand' AND IsApproved IS NULL") + ")";
            lstLabels[4].Text = " (" + db.GetExecuteScalar("SELECT COUNT(UserID) FROM Tbl_Users Where U_Type='Editor' AND IsApproved IS NULL") + ")";
        }
        catch (Exception)
        {
            throw;
        }
        
      //  lstLabels[3].Text = db.GetExecuteScalar("SELECT COUNT(ID) FROM Tbl_Store_Packages");
    }
    public static int Getunread_Alerts()
    {
        try
        {
            var db = new DatabaseManagement();
            string unreadMessages =
                string.Format(
                    "SELECT COUNT(NotifyID) as Total From Tbl_NotifyFor Where RecipID={0} AND ReadStatus IS NULL",
                    IEUtils.ToInt(HttpContext.Current.Session["UserID"]));
            return IEUtils.ToInt(db.GetExecuteScalar(unreadMessages));
        }
        catch (Exception)
        {
            throw;
        }
       

    }
    public static List<string> GetbannerImages(string slug)
    {
        var db=new DatabaseManagement();
        var lstImages=new List<string>();
        string cmdText = "SELECT '../bannerthumnails/' + SliderImg as [SliderImg] FROM Tbl_Store_Sliders WHERE StoreID=(SELECT StoreID From Tbl_Stores Where Slug=" + IEUtils.SafeSQLString(slug.Trim()) + ") AND Status='Active' ORDER BY ID DESC";
        SqlDataReader dr = db.ExecuteReader(cmdText);
        if (dr.HasRows)
           {
              while (dr.Read())
                    lstImages.Add(dr["SliderImg"].ToString());
              dr.Close();
           }
        return lstImages;
    }

    public static void SetFeatured1(Repeater targetControl)
    {
        var db = new DatabaseManagement();
        //(SELECT StoreID From Tbl_Stores Where Slug=" + IEUtils.SafeSQLString(slug.Trim()) + ")
        string cmdText = "Select Top 2 MAX(LookID) as LookID,LookKey,Title,Tbl_Brands.Name as Name,Tbl_Brands.UserID,Tbl_Brands.BrandID,MainImg,IsDeleted,CAST(Max(Tbl_Lookbooks.DatePosted) AS VARCHAR(12)) as DatePosted,IsPublished From Tbl_Lookbooks  INNER JOIN Tbl_Brands ON Tbl_Lookbooks.BrandID=Tbl_Brands.BrandID " +
        "Where IsDeleted IS NULL AND IsPublished = 1" +
        "GROUP BY Tbl_Brands.BrandID,Tbl_Brands.UserID,Tbl_Brands.Name,Title,Tbl_Lookbooks.DatePosted,LookKey,MainImg,IsDeleted,IsPublished " +
        "ORDER By Tbl_Lookbooks.DatePosted DESC";
        //===== Execute Query and bind data to Repeater control.
        targetControl.DataSource = db.ExecuteReader(cmdText);
        targetControl.DataBind();
    }
    public static void SetFeatured1_brand(Repeater targetControl,int userID)
    {
        var db = new DatabaseManagement();
        //(SELECT StoreID From Tbl_Stores Where Slug=" + IEUtils.SafeSQLString(slug.Trim()) + ")
        string cmdText = "Select Top 2 LookID,LookKey,Title,Tbl_Brands.Name as Name,Tbl_Brands.UserID,Tbl_Brands.BrandID,MainImg,IsDeleted,CAST(Tbl_Lookbooks.DatePosted AS VARCHAR(12)) as DatePosted,IsPublished From Tbl_Lookbooks  INNER JOIN Tbl_Brands ON Tbl_Lookbooks.BrandID=Tbl_Brands.BrandID " +
        "Where Tbl_Lookbooks.BrandID=(SELECT BrandID From Tbl_Brands Where UserID=" + userID + ") AND IsDeleted IS NULL AND IsPublished = 1" +       
        "ORDER By Tbl_Lookbooks.DatePosted DESC";
        //===== Execute Query and bind data to Repeater control.
        targetControl.DataSource = db.ExecuteReader(cmdText);
        targetControl.DataBind();
    }
    public static void SetFeatured2(Repeater targetControl)
    {
        var db = new DatabaseManagement();
        //(SELECT StoreID From Tbl_Stores Where Slug=" + IEUtils.SafeSQLString(slug.Trim()) + ")
        string cmdText = "SELECT CAST(MAX(Tbl_Lookbooks.DatePosted) AS VARCHAR(12)) as dated,LookID,LookKey,Title,Tbl_Brands.Name as Name,Tbl_Brands.UserID,Tbl_Brands.BrandID,MainImg,IsDeleted,IsPublished From Tbl_Lookbooks  INNER JOIN Tbl_Brands ON Tbl_Lookbooks.BrandID=Tbl_Brands.BrandID " +
            " WHERE Tbl_Lookbooks.BrandID NOT IN ( " +
            " Select Top 2 Tbl_Lookbooks.BrandID From Tbl_Lookbooks " +
            " WHERE IsDeleted IS NULL AND IsPublished = 1 " +
            " ORDER By Tbl_Lookbooks.DatePosted DESC " +
            ") AND IsDeleted IS NULL AND IsPublished = 1" +
            " Group by Tbl_Brands.BrandID,Tbl_Brands.UserID,Tbl_Brands.Name,Title,LookKey,MainImg,LookID,IsDeleted,IsPublished " +
            " ORDER By dated DESC";
        //===== Execute Query and bind data to Repeater control.
        targetControl.DataSource = db.ExecuteReader(cmdText);
        targetControl.DataBind();
    }
    public static void SetFeatured2_brand(Repeater targetControl,int userID)
    {
        var db = new DatabaseManagement();
        //(SELECT StoreID From Tbl_Stores Where Slug=" + IEUtils.SafeSQLString(slug.Trim()) + ")
        string cmdText = "SELECT CAST(Tbl_Lookbooks.DatePosted AS VARCHAR(12)) as dated,LookID,LookKey,Title,Tbl_Brands.Name as Name,Tbl_Brands.UserID,Tbl_Brands.BrandID,MainImg,IsDeleted,IsPublished From Tbl_Lookbooks  INNER JOIN Tbl_Brands ON Tbl_Lookbooks.BrandID=Tbl_Brands.BrandID " +
            " WHERE Tbl_Lookbooks.LookID NOT IN ( " +
            " Select Top 2 LookID From Tbl_Lookbooks " +
            " WHERE IsDeleted IS NULL AND IsPublished = 1 " +
            " ORDER By Tbl_Lookbooks.DatePosted DESC " +
            ") AND Tbl_Lookbooks.UserID="+ userID + "  AND IsDeleted IS NULL AND IsPublished = 1" +
            " ORDER By dated DESC";
        //===== Execute Query and bind data to Repeater control.
        targetControl.DataSource = db.ExecuteReader(cmdText);
        targetControl.DataBind();
    }
    public static void SetLightboxContent(Repeater targetControl,int lbID)
    {
        var db = new DatabaseManagement();
        //(SELECT StoreID From Tbl_Stores Where Slug=" + IEUtils.SafeSQLString(slug.Trim()) + ")
        string cmdText = string.Format("SELECT dbo.Tbl_Lookbooks.LookID, dbo.Tbl_Lookbooks.LookKey, dbo.Tbl_Lookbooks.Title," +
                " dbo.Tbl_Lookbooks.Description as [LbDescription], dbo.Tbl_Lookbooks.Views, dbo.Tbl_Lookbooks.BrandID, dbo.Tbl_Images.Image," +
                " dbo.Tbl_Images.Description AS [ItemDescription] " +
                " FROM dbo.Tbl_Lookbooks INNER JOIN dbo.Tbl_Images ON dbo.Tbl_Lookbooks.LookID = dbo.Tbl_Images.LookID " +
                "Where  dbo.Tbl_Lookbooks.LookID ={0} AND  dbo.Tbl_Lookbooks.IsDeleted IS NULL AND IsPublished = 1", lbID);
        //===== Execute Query and bind data to Repeater control.
        targetControl.DataSource = db.ExecuteReader(cmdText);
        targetControl.DataBind();
    }
    public static void SetLightboxContent_comments(Repeater targetControl, int lbID)
    {
        var db = new DatabaseManagement();
        //(SELECT StoreID From Tbl_Stores Where Slug=" + IEUtils.SafeSQLString(slug.Trim()) + ")
        string cmdText = string.Format("SELECT Top 1 Tbl_Lookbooks.LookID, Tbl_Lookbooks.BrandID, dbo.Tbl_Images.Image," +
                " dbo.Tbl_Images.Description AS [ItemDescription] " +
                " FROM dbo.Tbl_Lookbooks INNER JOIN dbo.Tbl_Images ON dbo.Tbl_Lookbooks.LookID = dbo.Tbl_Images.LookID " +
                "Where  dbo.Tbl_Lookbooks.LookID ={0} AND  dbo.Tbl_Lookbooks.IsDeleted IS NULL AND IsPublished = 1", lbID);
        //===== Execute Query and bind data to Repeater control.
        targetControl.DataSource = db.ExecuteReader(cmdText);
        targetControl.DataBind();
    }
    public static void SetBannerImage(Image imgctl)
    {
        var db = new DatabaseManagement();
      //  (SELECT StoreID From Tbl_Stores Where Slug=" + IEUtils.SafeSQLString(slug.Trim()) + ")
        string cmdText = "SELECT U_CoverPic From Tbl_Users Where UserID=" + IEUtils.ToInt(HttpContext.Current.Session["UserID"]);
        //===== Execute Query and bind data to Repeater control.
        imgctl.ImageUrl = "../profileimages/" + db.GetExecuteScalar(cmdText);
    }

    public static void SetCategories(Repeater targetControl)
    {
        var db = new DatabaseManagement();
        string cmdText = "select Top 10 CategoryID,Category_Name,'catimages/'+ Cat_Img as Img from Tbl_Categories Where ParentID=0 AND Cat_Img IS NOT NULL";
        //===== Execute Query and bind data to Repeater control.
        targetControl.DataSource = db.ExecuteReader(cmdText);
        targetControl.DataBind();
    }

    public static string HandleCheckOut(DataTable objDT,int userId)
    {
        try
        {
            var db = new DatabaseManagement();
            int invoiceID = db.GetMaxID("InvoiceID", "Tbl_Invoices");
            string invoiceKey = Encryption64.Encrypt(invoiceID.ToString(CultureInfo.InvariantCulture)).Replace('+','=');
            string addInvoice =
                string.Format(
                    "INSERT INTO Tbl_Invoices(InvoiceKey,DatePosted,UserID) VALUES({0},{1},{2})",
                    IEUtils.SafeSQLString(invoiceKey),
                    IEUtils.SafeSQLDate(DateTime.Now),
                    userId);
            db.ExecuteSQL(addInvoice);
            var result = from tab in objDT.AsEnumerable()
                         group tab by tab["StoreID"]
                             into groupDt
                             select new
                             {
                                 StoreID = groupDt.Key,
                                 OrderTotal = groupDt.Sum((r) => decimal.Parse(r["TotalPrice"].ToString()))
                             };
            foreach (var t in result)
            {
                int orderId = db.GetMaxID("OrderID", "Tbl_Orders");
                string orderKey = Encryption64.Encrypt(orderId.ToString(CultureInfo.InvariantCulture)).Replace('+', '=');
                string addOrder =
                    string.Format(
                        "INSERT INTO Tbl_Orders(UserID,Total_Price,Status,DatePosted,OrderKey,StoreID,InvoiceID) VALUES({0},{1},{2},{3},{4},{5},{6})",
                        userId,
                        IEUtils.ToDecimal(t.OrderTotal),
                        IEUtils.SafeSQLString("Pending"),
                        IEUtils.SafeSQLDate(DateTime.Now),
                        IEUtils.SafeSQLString(orderKey),
                        IEUtils.ToInt(t.StoreID),
                        invoiceID
                        );
                db.ExecuteSQL(addOrder);
                foreach (DataRow row in objDT.Rows)
                {
                    int currentStore = IEUtils.ToInt(t.StoreID);
                    int cartStore = IEUtils.ToInt(row["StoreID"]);
                    if(currentStore==cartStore)
                    {
                        string addItems =
                       string.Format("INSERT INTO Tbl_Order_Items(OrderID,ProductID,Product_Name,Price,Quantity,DatePosted,StoreID,InvoiceID) VALUES({0},{1},{2},{3},{4},{5},{6},{7})",
                           orderId,
                           IEUtils.ToInt(row["ProductID"]),
                           IEUtils.SafeSQLString(row["Name"].ToString()),
                           IEUtils.ToDouble(row["UnitPrice"]),
                           IEUtils.ToInt(row["Qty"]),
                           IEUtils.SafeSQLDate(DateTime.Now),
                           IEUtils.ToInt(row["StoreID"]),
                           invoiceID);
                        db.ExecuteSQL(addItems);
                    }
                }
            }
            return invoiceKey;
        }
        catch (Exception)
        {
            return "0";
        }
    }

    /* ******************************************** Menu ************************************************ */
    public static void GetMenuData(Menu menuBar)
    {
        var db = new DatabaseManagement();
        var table = new DataTable();
        var conn = new SqlConnection(db.ConnectionString);
        string sql = "SELECT distinct Tbl_Categories.CategoryID , Category_Name, COUNT(ProductID) as ProductCount,   CASE WHEN ParentID = 0  THEN NULL  ELSE ParentID END AS ParentID   FROM  Tbl_Categories INNER JOIN Tbl_Products ON " +
        " Tbl_Categories.CategoryID=Tbl_Products.CategoryID " +
        " Where Tbl_Products.StoreID=" + IEUtils.ToInt(HttpContext.Current.Session["FRStoreID"]) + "   GROUP BY Tbl_Categories.CategoryID , Category_Name,ParentID  ORDER BY ParentID";
        var cmd = new SqlCommand(sql, conn);
        var da = new SqlDataAdapter(cmd);
        da.Fill(table);
        var view = new DataView(table) { RowFilter = "ParentID is NULL" };
        foreach (DataRowView row in view)
        {
            var menuItem = new MenuItem(row["Category_Name"].ToString() + " ("+ row["ProductCount"] + ")",
                                             row["CategoryID"].ToString()) { NavigateUrl = "../sc.aspx?c=" + row["CategoryID"] };
            menuBar.Items.Add(menuItem);
            AddChildItems(table, menuItem);
        }
    }

    private static void AddChildItems(DataTable table, MenuItem menuItem)
    {
        var viewItem = new DataView(table) {RowFilter = "ParentID=" + menuItem.Value};
        foreach (DataRowView childView in viewItem)
        {
            var childItem = new MenuItem(childView["Category_Name"].ToString(),
                                              childView["CategoryID"].ToString()) { NavigateUrl = "../sc.aspx?c=" + childView["CategoryID"].ToString() };
            menuItem.ChildItems.Add(childItem);
            AddChildItems(table, childItem);
        }
    }

    public static void GetMenuDataR(Menu menuBar)
    {
        var db = new DatabaseManagement();
        var table = new DataTable();
        var conn = new SqlConnection(db.ConnectionString);
        string sql = "SELECT distinct Tbl_Categories.CategoryID , Category_Name, COUNT(ProductID) as ProductCount,   CASE WHEN ParentID = 0  THEN NULL  ELSE ParentID END AS ParentID   FROM  Tbl_Categories INNER JOIN Tbl_Products ON " +
        " Tbl_Categories.CategoryID=Tbl_Products.CategoryID " +
        " Where Tbl_Products.StoreID=" + IEUtils.ToInt(HttpContext.Current.Session["FRStoreID"]) + "   GROUP BY Tbl_Categories.CategoryID , Category_Name,ParentID  ORDER BY ParentID";
        var cmd = new SqlCommand(sql, conn);
        var da = new SqlDataAdapter(cmd);
        da.Fill(table);
        var view = new DataView(table) { RowFilter = "ParentID is NULL" };
        foreach (DataRowView row in view)
        {
            var menuItem = new MenuItem(row["Category_Name"].ToString() + " (" + row["ProductCount"] + ")",
                                             row["CategoryID"].ToString()) { NavigateUrl = "sc.aspx?c=" + row["CategoryID"] };
            menuBar.Items.Add(menuItem);
            AddChildItemsR(table, menuItem);
        }
    }

    private static void AddChildItemsR(DataTable table, MenuItem menuItem)
    {
        var viewItem = new DataView(table) { RowFilter = "ParentID=" + menuItem.Value };
        foreach (DataRowView childView in viewItem)
        {
            var childItem = new MenuItem(childView["Category_Name"].ToString(),
                                              childView["CategoryID"].ToString()) { NavigateUrl = "sc.aspx?c=" + childView["CategoryID"].ToString() };
            menuItem.ChildItems.Add(childItem);
            AddChildItems(table, childItem);
        }
    }

    public static string GetRelativeTime(DateTime dbDate)
    {
        const int SECOND = 1;
        const int MINUTE = 60 * SECOND;
        const int HOUR = 60 * MINUTE;
        const int DAY = 24 * HOUR;
        const int MONTH = 30 * DAY;

        var ts = new TimeSpan(DateTime.UtcNow.Ticks - dbDate.Ticks);
        double delta = Math.Abs(ts.TotalSeconds);

        if (delta < 1 * MINUTE)
        {
            return ts.Seconds == 1 ? "one second ago" : ts.Seconds + " seconds ago";
        }
        if (delta < 2 * MINUTE)
        {
            return "a minute ago";
        }
        if (delta < 45 * MINUTE)
        {
            return ts.Minutes + " minutes ago";
        }
        if (delta < 90 * MINUTE)
        {
            return "an hour ago";
        }
        if (delta < 24 * HOUR)
        {
            return ts.Hours + " hours ago";
        }
        if (delta < 48 * HOUR)
        {
            return "yesterday";
        }
        if (delta < 30 * DAY)
        {
            return ts.Days + " days ago";
        }
        if (delta < 12 * MONTH)
        {
            int months = Convert.ToInt32(Math.Floor((double)ts.Days / 30));
            return months <= 1 ? "one month ago" : months + " months ago";
        }
        int years = Convert.ToInt32(Math.Floor((double)ts.Days / 365));
        return years <= 1 ? "one year ago" : years + " years ago";
    }

}