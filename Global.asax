<%@ Application Language="C#" %>
<%@ Import Namespace="System.Web.Routing" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        // RegisterRoutes(RouteTable.Routes);
       RouteConfig.RegisterRoutes(RouteTable.Routes);
       
      //  ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

    }
    //static void RegisterRoutes(RouteCollection routes)
    //{
       
    //    routes.MapPageRoute("AdminLogin", "login", "~/admin/login.aspx");
    //    routes.MapPageRoute("FrondendLogin", "login", "~/login.aspx");
    //    routes.MapPageRoute("brandprofile", "brandprofile", "~/brand/profile-page-items.aspx");


    //}
    void Session_Start(object sender, EventArgs e)
    {
        Session["UserID"] = "";
        Session["UserEmail"] = "";
        Session["Username"] = "";
        Session["CurrentBrand"]="";
        Session["CurrentEventId"] = "0";
        Session["CurrentItemId"] = "0";
        Session["userkey"] = "";
        Session["ColorVal"] = "";
        Session["PriceList"] = "";
        Session["ParentId"] = "";
        Session["MessageId"] = "";
        Session["WorkingImage"] = "";
        Session["ImagePath"] = "";
        Session["ItemdID"] = "";
        Session["UKey"] = "";
        Session["query1"] = "";
        Session["selectedFolder"] = "";
        Session["RUsername"] = "";

    }

    void Session_End(object sender, EventArgs e)
    {
        Session["UserID"] = "";
        Session["ItemdID"] = "";
        Session["UserEmail"] = "";
        Session["Username"] = "";
        Session["CurrentBrand"]="";
        Session["CurrentEventId"] = "0";
        Session["CurrentItemId"] = "0";
        Session["userkey"] = "";
        Session["ColorVal"] = "";
        Session["PriceList"] = "";
        Session["WorkingImage"] = "";
        Session["ImagePath"] = "";
        Session["UKey"] = "";
        Session["query1"] = "";
        Session["selectedFolder"] = "";
        Session["RUsername"] = "";
    }

</script>
