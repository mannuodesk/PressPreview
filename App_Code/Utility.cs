using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;

/// <summary>
/// Summary description for Utility
/// </summary>
public class Utility:Page
{

    public Utility()
    {
        
    }

    private static string _watermarktext = "PRESS PREVIEW";
    public static string WatermarkText
    {
        get { return _watermarktext; }
        set { _watermarktext = value; }
    }
    private static string _rootImagePath="../photobank/";
    public static string RootImagePath
    {
        get { return _rootImagePath; }
        set { _rootImagePath = value; }
    }

    private static string _subImagePaht="../../photobank/";
    public static string SubImagePaht
    {
        get { return _subImagePaht; }
        set { _subImagePaht = value; }
    }

    private static string _rootThumbPath="../thumbnails/";
    public static string RootThumbPath
    {
        get { return _rootThumbPath; }
        set { _rootThumbPath = value; }
    }

    private static string _subThumbPaht="../../thumbnails/";
    public static string SubThumbPaht
    {
        get { return _subThumbPaht; }
        set { _subThumbPaht = value; }
    }

    public static void getCountry(DropDownList ddCountry)
    {
        Dictionary<string, string> objDic = new Dictionary<string, string>();
        ddCountry.Items.Add(new ListItem("---Select---", "0"));
        foreach (CultureInfo ObjCultureInfo in CultureInfo.GetCultures(CultureTypes.SpecificCultures))
        {
            RegionInfo objRegionInfo = new RegionInfo(ObjCultureInfo.Name);
            if (!objDic.ContainsKey(objRegionInfo.EnglishName))
            {
                objDic.Add(objRegionInfo.EnglishName, objRegionInfo.TwoLetterISORegionName.ToLower());
            }
        }

        //objDic.Remove("Islamic Republic of Pakistan");
        //objDic.Add("Pakistan", "pk");
        //var obj = objDic.OrderBy(p => p.Key);
        //foreach (KeyValuePair<string, string> val in obj)
        //{
        //    ddCountry.Items.Add(new ListItem(val.Key, val.Value));
        //}
    }

    public static void getCountrySelectedValue(DropDownList ddCountry)
    {
        Dictionary<string, string> objDic = new Dictionary<string, string>();
        ddCountry.Items.Add(new ListItem("---Select---", "0"));
        foreach (CultureInfo ObjCultureInfo in CultureInfo.GetCultures(CultureTypes.SpecificCultures))
        {
            RegionInfo objRegionInfo = new RegionInfo(ObjCultureInfo.Name);
            if (!objDic.ContainsKey(objRegionInfo.EnglishName))
            {
                objDic.Add(objRegionInfo.EnglishName, objRegionInfo.TwoLetterISORegionName.ToLower());
            }
        }

        //objDic.Remove("Islamic Republic of Pakistan");
        //objDic.Add("Pakistan", "pk");
        //var obj = objDic.OrderBy(p => p.Key);
        //foreach (KeyValuePair<string, string> val in obj)
        //{
        //    ddCountry.Items.Add(new ListItem(val.Key, val.Key));
        //}
    }
    public static void ValidateApLogin(Label lblUsername)
    {
        if (HttpContext.Current.Session["userId"].ToString() != "")
            lblUsername.Text = HttpContext.Current.Session["FirstName"].ToString();
        else
        {
           HttpContext.Current.Response.Redirect("../login/");
        }
        
    }
    public  static void ValidateHomePageSession(Label lblUsername)
    {
        if (string.IsNullOrEmpty(HttpContext.Current.Session["userId"].ToString()))
        {
            lblUsername.Text = "";
        }
        else
        {
            lblUsername.Text = HttpContext.Current.Session["FirstName"].ToString();
        }
       // lblUsername.Text = HttpContext.Current.Session["userId"].ToString() != "" ? HttpContext.Current.Session["FirstName"].ToString() : "";
    }

    public static void ClearAllSessions()
    {
        HttpContext.Current.Session["userId"] = "";
        HttpContext.Current.Session["EmailId"] = "";
        HttpContext.Current.Session["userType"] = "";
        HttpContext.Current.Session["FirstName"] = "";
        HttpContext.Current.Session["LastName"] = "";
    }

    public static void SetYearsDD(DropDownList dd)
    {
        dd.Items.Add(new ListItem("---Please select---","0"));
        int currentYear = DateTime.Now.Year;
        for(int i=currentYear; i>1900; i--)
        {
            dd.Items.Add(i.ToString());
        }
    }
    public static string GenerateThumbNail(string imageName,string imagePath, string thumbNailFolder, int width,int desiredHeight)
    {
        System.Drawing.Image image =
        System.Drawing.Image.FromFile(imagePath);
        int srcWidth = image.Width;
        int srcHeight = image.Height;
        Size currentDimensions = new Size(srcWidth, srcHeight);
        Size requiredDimensions = ResizeKeepAspect(currentDimensions, width, desiredHeight);
        int thumbWidth = requiredDimensions.Width;
        int thumbHeight = requiredDimensions.Height;
        //int thumbWidth = width;
        //int thumbHeight = desiredHeight;
        Bitmap bmp;
        //if (srcHeight > srcWidth)
        //{
        //    thumbHeight = (srcHeight / srcWidth) * thumbWidth;
        //    bmp = new Bitmap(thumbWidth, thumbHeight);
        //}
        //else
        //{
        //    thumbHeight = thumbWidth;
        //    thumbWidth = (srcWidth / srcHeight) * thumbHeight;
        //    bmp = new Bitmap(thumbWidth, thumbHeight);
        //}
        bmp = new Bitmap(thumbWidth, thumbHeight);
        Graphics gr = Graphics.FromImage(bmp);
        gr.SmoothingMode = SmoothingMode.HighQuality;
        gr.CompositingQuality = CompositingQuality.HighQuality;
        gr.InterpolationMode = InterpolationMode.High;
        Rectangle rectDestination =
               new Rectangle(0, 0, thumbWidth, thumbHeight);
        gr.DrawImage(image, rectDestination, 0, 0, srcWidth, srcHeight, GraphicsUnit.Pixel);
        string aa = imageName;

        bmp.Save(HttpContext.Current.Server.MapPath("../"+thumbNailFolder + imageName));
        bmp.Dispose();
        image.Dispose();
        return aa;

    }


    public static Size ResizeKeepAspect(Size CurrentDimensions, int maxWidth, int maxHeight)
    {
        int newHeight = CurrentDimensions.Height;
        int newWidth = CurrentDimensions.Width;
        if (maxWidth > 0 && newWidth > maxWidth) //WidthResize
        {
            Decimal divider = Math.Abs((Decimal)newWidth / (Decimal)maxWidth);
            newWidth = maxWidth;
            newHeight = (int)Math.Round((Decimal)(newHeight / divider));
        }
        if (maxHeight > 0 && newHeight > maxHeight) //HeightResize
        {
            Decimal divider = Math.Abs((Decimal)newHeight / (Decimal)maxHeight);
            newHeight = maxHeight;
            newWidth = (int)Math.Round((Decimal)(newWidth / divider));
        }
        return new Size(newWidth, newHeight);
    }

    // Method No. 3

    public static string ResizeImage(string imageName, string imagePath, string thumbNailFolder, int width)
    {
        System.Drawing.Image image =
        System.Drawing.Image.FromFile(imagePath);
        int srcWidth = image.Width;
        int srcHeight = image.Height;
        Size currentDimensions = new Size(srcWidth, srcHeight);
        
        int thumbWidth = width;
        int thumbHeight = 0;
        Bitmap bmp;
        if (srcHeight > srcWidth)
        {
            thumbHeight = (srcHeight / srcWidth) * thumbWidth;
            bmp = new Bitmap(thumbWidth, thumbHeight);
        }
        else
        {
            thumbHeight = thumbWidth;
            thumbWidth = (srcWidth / srcHeight) * thumbHeight;
            bmp = new Bitmap(thumbWidth, thumbHeight);
        }
        Size requiredDimensions = ResizeKeepAspect(currentDimensions, thumbWidth, thumbHeight);
        thumbWidth = requiredDimensions.Width;
        thumbHeight = requiredDimensions.Height;
        bmp = new Bitmap(thumbWidth, thumbHeight);
        Graphics gr = Graphics.FromImage(bmp);
        gr.SmoothingMode = SmoothingMode.HighQuality;
        gr.CompositingQuality = CompositingQuality.HighQuality;
        gr.InterpolationMode = InterpolationMode.High;
        Rectangle rectDestination =
               new Rectangle(0, 0, thumbWidth, thumbHeight);
        gr.DrawImage(image, rectDestination, 0, 0, srcWidth, srcHeight, GraphicsUnit.Pixel);
        string aa = imageName;

        bmp.Save(HttpContext.Current.Server.MapPath("../" + thumbNailFolder + imageName));
        bmp.Dispose();
        image.Dispose();
        return aa;
    }

    public static string GenerateThumbNail(string imageName, string imagePath, string thumbNailFolder, int width)
    {
        System.Drawing.Image image =
        System.Drawing.Image.FromFile(imagePath);
        float srcWidth = image.Width;
        float srcHeight = image.Height;
      //  Size currentDimensions = new Size(srcWidth, srcHeight);
       
        float thumbWidth = width;
        float thumbHeight = 0;
        Bitmap bmp;
        if (srcHeight > srcWidth)
        {
            float ratio = srcHeight/srcWidth;
            thumbHeight = ratio * thumbWidth;
            bmp = new Bitmap(Convert.ToInt32(thumbWidth), Convert.ToInt32(thumbHeight));
        }
        else
        {
            thumbHeight = thumbWidth;
            thumbWidth = (srcWidth / srcHeight) * thumbHeight;
            bmp = new Bitmap(Convert.ToInt32(thumbWidth), Convert.ToInt32(thumbHeight));
        }
        //Size requiredDimensions = ResizeKeepAspect(currentDimensions, thumbWidth, thumbHeight);
        // //thumbWidth = requiredDimensions.Width;
        // //thumbHeight = requiredDimensions.Height;
        bmp = new Bitmap(Convert.ToInt32(thumbWidth), Convert.ToInt32(thumbHeight));
        Graphics gr = Graphics.FromImage(bmp);
        gr.SmoothingMode = SmoothingMode.HighQuality;
        gr.CompositingQuality = CompositingQuality.HighQuality;
        gr.InterpolationMode = InterpolationMode.High;
        Rectangle rectDestination =
               new Rectangle(0, 0, Convert.ToInt32(thumbWidth), Convert.ToInt32(thumbHeight));
        gr.DrawImage(image, rectDestination, 0, 0, srcWidth, srcHeight, GraphicsUnit.Pixel);
        string aa = imageName;

        bmp.Save(HttpContext.Current.Server.MapPath("../" + thumbNailFolder + imageName));
        bmp.Dispose();
        image.Dispose();
        return aa;

    }

    public static void CreateWaterMarkedImage(string imagepath, string watermarkText)
    {
        System.Drawing.Image imgPhoto = System.Drawing.Image.FromFile(imagepath);
        int phWidth = imgPhoto.Width;
        int phHeight = imgPhoto.Height;

        var bmPhoto = new Bitmap(phWidth, phHeight, PixelFormat.Format24bppRgb);
        bmPhoto.SetResolution(72, 72);
        Graphics grPhoto = Graphics.FromImage(bmPhoto);
        grPhoto.SmoothingMode = SmoothingMode.AntiAlias;
        grPhoto.DrawImage(imgPhoto, new Rectangle(0, 0, phWidth, phHeight), 0, 0, phWidth, phHeight,
                          GraphicsUnit.Pixel);
        // To maximize the size of the Copyright message we will test 7 different Font sizes to determine 
        // the largest possible size we can use for the width of our Photograph.  
        // To effectively do this, we will define an array of integers then iterate through those values measuring the Copyright string in the various point sizes.  
        // Once we have determined the largest possible size we will exit the loop and draw the text.
        int[] sizes = new int[] { 16, 14, 12, 10, 8, 6, 4 };
        Font crFont = null;
        SizeF crSize = new SizeF();
        for (int i = 0; i < 7; i++)
        {
            crFont = new Font("arial", sizes[i], FontStyle.Bold);
            crSize = grPhoto.MeasureString(watermarkText, crFont);
            if ((ushort)crSize.Width < (ushort)phWidth)
                break;
        }

        //  Since all photographs will have varying heights, determine a position 5% from the bottom of the image.  
        //  Use the Copyright strings height to determine an appropriate y-coordinate for which to draw the string.  
        //  Determine its x-coordinate by calculating the centre of the image then define a StringFormat object and set the StringAlignment to Center. 

        int yPixlesFromBottom = (int)(phHeight * 0.5);
        float yPosFromBottom = ((phHeight - yPixlesFromBottom) - (crSize.Height / 2));
        float xCenterOfImg = (phWidth / 2);
        StringFormat strFormat = new StringFormat { Alignment = StringAlignment.Center };

        // Drawing the copyright string at the appropriate position offset 1 pixel to the right and 1 pixel down offset will create as shadow effect.

        SolidBrush semiTransBrush2 = new SolidBrush(Color.FromArgb(153, 0, 0, 0));
        grPhoto.DrawString(watermarkText, crFont, semiTransBrush2,
                           new PointF(xCenterOfImg + 1, yPosFromBottom + 1), strFormat);

        SolidBrush semiTransBrush = new SolidBrush(Color.FromArgb(153, 255, 255, 255));
        grPhoto.DrawString(watermarkText, crFont, semiTransBrush, new PointF(xCenterOfImg, yPosFromBottom),
                           strFormat);


        Bitmap bmWatermark = new Bitmap(bmPhoto);
        bmWatermark.SetResolution(
            imgPhoto.HorizontalResolution,
            imgPhoto.VerticalResolution);

        Graphics grWatermark =
            Graphics.FromImage(bmWatermark);


        ImageAttributes imageAttributes =
            new ImageAttributes();
        ColorMap colorMap = new ColorMap
        {
            OldColor = Color.FromArgb(255, 0, 255, 0),
            NewColor = Color.FromArgb(0, 0, 0, 0)
        };

        ColorMap[] remapTable = { colorMap };

        imageAttributes.SetRemapTable(remapTable,
                                      ColorAdjustType.Bitmap);

        imgPhoto = bmWatermark;
        grPhoto.Dispose();
        grWatermark.Dispose();

        // release the saved image
        GC.Collect();
        GC.WaitForPendingFinalizers();
        // Delete the already saved image
        System.IO.File.Delete(imagepath);

        // Replace the saved image with the watermarked image
        imgPhoto.Save(imagepath, ImageFormat.Jpeg);
        imgPhoto.Dispose();
        grPhoto.Dispose();
    }

    public static void DeleteMultipleRecords(StringCollection idcollection,DatabaseManagement db)
    {
        string ids = idcollection.Cast<string>().Aggregate(string.Empty, (current, id) => current + (id + ","));
        // Remove the last comma
        ids = ids.Substring(0, ids.LastIndexOf(','));
        string deleteQuery = "Update Tbl_Messages Set IsDeleted='Yes' Where MesgID IN (" + ids + ")";
        db.ExecuteSQL(deleteQuery);
    }

    public static List<string> GetCountryList()
    {
        List<string> list = new List<string>();
        CultureInfo[] cultures =
                    CultureInfo.GetCultures(CultureTypes.SpecificCultures);
        foreach (CultureInfo info in cultures)
        {
            RegionInfo info2 = new RegionInfo(info.LCID);
            if (!list.Contains(info2.EnglishName))
            {
                list.Add(info2.EnglishName);
            }
        }
        list.Sort();
        return list;
    }

    public static void LoadSearchItems(DropDownList lstSearch,Int32 userID)
    {
        DataSet ds = new DataSet();
        DatabaseManagement db = new DatabaseManagement();
        string selectItems = string.Format("SELECT ItemID,Title From Tbl_Items Where UserID={0}", userID);
        SqlDataReader dr = db.ExecuteReader(selectItems);

        lstSearch.DataSource = dr;
        lstSearch.DataTextField = "Title";
        lstSearch.DataValueField = "ItemID";
        lstSearch.DataBind();

    }

    public static void LoadSearchItems(DropDownList lstSearch, string userKey)
    {
        DataSet ds = new DataSet();
        DatabaseManagement db = new DatabaseManagement();
        string selectItems = string.Format("SELECT ItemID,Title From Tbl_Items Where UserID=(SELECT UserID From Tbl_Users Where UserKey={0})", IEUtils.SafeSQLString(userKey));
        SqlDataReader dr = db.ExecuteReader(selectItems);

        lstSearch.DataSource = dr;
        lstSearch.DataTextField = "Title";
        lstSearch.DataValueField = "ItemID";
        lstSearch.DataBind();

    }
}