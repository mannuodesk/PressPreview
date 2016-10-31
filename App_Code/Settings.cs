/// <summary>
/// Summary description for Settings
/// </summary>
public static class Settings
{
    static Settings()
    {
        ProjectName = "PR";
        DomainName = "presspreview.azurewebsites.net.net";
    }

    public static string ProjectName { get; private set; }
    public static string DomainName { get; private set; }
}