using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;


public partial class editor_cropper : System.Web.UI.Page
{
    public string ServerValue = String.Empty;
    public string photo_loc = String.Empty;
    public string db_photo_name = String.Empty;
    public string db_photo_loc = String.Empty;
    public string db_photo_ext = String.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

     protected void btncrop_Click(object sender, EventArgs e)
    {
        try
        {

            //string photo_path = imgcrop.Src;

            string photo_name = Request.Form["img_name"];

            string fname = photo_name;
            string fpath = Path.Combine(Server.MapPath("~/photobank"), fname);
            Image oimg = Image.FromFile(fpath);
            Rectangle cropcords = new Rectangle(
            Convert.ToInt32(hdnx.Value),
            Convert.ToInt32(hdny.Value),
            Convert.ToInt32(hdnw.Value),
            Convert.ToInt32(hdnh.Value)
            

            
            );
            string cfname, cfpath;
            Bitmap bitMap = new Bitmap(cropcords.Width, cropcords.Height, oimg.PixelFormat);
            Graphics grph = Graphics.FromImage(bitMap);
            grph.DrawImage(oimg, new Rectangle(0, 0, bitMap.Width, bitMap.Height), cropcords, GraphicsUnit.Pixel);
            cfname = "crop_" + fname;
            cfpath = Path.Combine(Server.MapPath("~/profileimages"), cfname);
            bitMap.Save(cfpath);
            imgcropped.Visible = true;
            imgcropped.Src = "~/profileimages/" + cfname;
            db_photo_loc = "profileimages/" + cfname;
            db_photo_name = cfname;





            string id = db_photo_name;

            //UPDATE THE IMAGE IN DB
            try
            {


                //SqlConnection conn = new SqlConnection(con);
                //SqlCommand sqlcomm = new SqlCommand(" write your query for update", conn);
                //conn.Open();
                //sqlcomm.ExecuteNonQuery();
                //conn.Close();
                my_ad_err_lbl.Text = "Profile photo cropped and saved.";


                if (my_ad_err_lbl.Text == "Done")
                {


                }

            }
            catch (Exception ex)
            {
                my_ad_err_lbl.Text = ex.Message;


            }
            finally
            {

            }



        }
        catch (Exception ex)
        {
            throw ex;
        }
    }



    protected void btndelete_Click(object sender, EventArgs e)
    {

        delete_photo();
    }


    public void delete_photo()
    {


        //DELETE THE IMAGE BEFORE UPDATE
        try
        {
            //SqlConnection conn = new SqlConnection(con);
            //conn.Open();
            //SqlCommand cmd = new SqlCommand("  write your query to delete    '", conn);
            //SqlDataReader dr = cmd.ExecuteReader();


            //while (dr.Read())
            //{
            //    string imageurl = dr["profile_img_loc"].ToString();
            //    string imageFilePath = HttpContext.Current.Server.MapPath("~/" + imageurl);
            //    System.IO.File.Delete(imageFilePath);

            //}
        }
        catch (Exception ex)
        {
            my_ad_err_lbl.Text = ex.Message;
        }
        finally
        {

        }


    }

    protected void btnsave_original_Click(object sender, EventArgs e)
    {
        string id = db_photo_name;

        //UPDATE THE IMAGE IN DB
        try
        {


         

        }
        catch (Exception ex)
        {
           


        }
        finally
        {

        }

    }
}

