using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SignedUpUser
/// </summary>
public class SignedUpUser
{
    public string userName { get; set; }
    public string email { get; set; }
    public string password { get; set; }

    public string profilePicURL { get; set; }
    public string coverPicURL { get; set; }
    public SignedUpUser()
    {
    }
}