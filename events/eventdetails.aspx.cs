using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DLS.DatabaseServices;

public partial class events_eventdetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        LoadEventData();
        //txtLocation.Text = "10 Down Street, London";
        txtLocation.Attributes.Add("onchange", "javascript:FindLocaiton()");
    }

    protected void LoadEventData()
    {
        try
        {
            var db =new DatabaseManagement();
            string getEventData = string.Format("SELECT * From Tbl_Events Where EventID={0}",
                                                IEUtils.ToInt(Request.QueryString["e"]));
            SqlDataReader dr = db.ExecuteReader(getEventData);
            if(dr.HasRows)
            {
                dr.Read();
                lblEventTitle.Text = dr[1].ToString();
                lblEventDateTime.Text = Convert.ToDateTime(dr[2]).ToString("r").Replace("00:00:00 GMT"," at") + " " + dr[4] + " GMT";
                lblEndDateTime.Text = Convert.ToDateTime(dr[3]).ToString("r").Replace("00:00:00 GMT", " at") + " " + dr[5] + " GMT";

                lblEventDateTime1.Text = Convert.ToDateTime(dr[2]).ToString("r").Replace("00:00:00 GMT", " at") + " " + dr[4] + " GMT";
                lblEndDateTime1.Text = Convert.ToDateTime(dr[3]).ToString("r").Replace("00:00:00 GMT", " at") + " " + dr[5] + " GMT";
                lblPara1.Text = dr[6].ToString();
                lblPara2.Text = dr[7].ToString();
                imgFeature.ImageUrl = "../eventpics/" + dr[8];
                lblMediaType.Text = dr[9].ToString();
                if (lblMediaType.Text == "image")
                {
                    imgCenter.Visible = true;
                    imgCenter.ImageUrl = "../eventpics/" + dr[10];
                    grdVideo.Visible = false;
                    Session["videoLink"] = "";
                }
                else
                {
                    imgCenter.Visible = false;
                    grdVideo.Visible = true;
                    
                    lblVideoLink.Text = dr[10].ToString();

                }
                lblLocation.Text = dr[13].ToString();
                lblLocation1.Text = dr[13].ToString();
                txtLocation.Text = dr[13].ToString();
                //txtLocation.Focus();
                lblRSVPType.Text = dr[18].ToString();
                if(lblRSVPType.Text=="External Link")
                {
                    btnRSVPLink.Visible = true;
                    btnRSVPLink.HRef = dr[17].ToString();
                    btnMailTo.Visible = false;
                }
                else
                {
                    btnRSVPLink.Visible = false;
                    btnMailTo.Visible = true;
                    btnMailTo.HRef = dr[17].ToString();
                }

            }
        }
        catch (Exception ex)
        {
            
            throw;
        }
    }
}