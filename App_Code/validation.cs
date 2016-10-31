using System.Text.RegularExpressions;
using System;
using System.Data;

public class validation
{
    public string Email_Activation_Code_Email;
    public string phone_Activation_Code_Phone;
    string connstring = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];
    string connstring2 = System.Configuration.ConfigurationManager.AppSettings["ConnectionString3"];
    public void Email_Activation_Code()
    {
        string guidResult = System.Guid.NewGuid().ToString();
        guidResult = guidResult.Replace("-", string.Empty);
        int length = 10;
        if (length <= 0 || length > guidResult.Length)
        {
            throw new ArgumentException("Length must be between 1 and " + guidResult.Length);
        }
        Email_Activation_Code_Email = guidResult.Substring(0, length);
    }
    public string GetRandomNumber()
    {
        string guidResult = System.Guid.NewGuid().ToString();
        guidResult = guidResult.Replace("-", string.Empty);
        int length = 10;
        if (length <= 0 || length > guidResult.Length)
        {
            throw new ArgumentException("Length must be between 1 and " + guidResult.Length);
        }
        return guidResult.Substring(0, length);
    }
    public void Phone_Activation_Code()
    {
        string guidResult = System.Guid.NewGuid().ToString();
        guidResult = guidResult.Replace("-", string.Empty);
        int length = 10;
        if (length <= 0 || length > guidResult.Length)
        {
            throw new ArgumentException("Length must be between 1 and " + guidResult.Length);
        }

        phone_Activation_Code_Phone = guidResult.Substring(0, length);
    }
  public bool Admin_Mail_Validation(string Email)
    {
        bool functionReturnValue = false;
        connstring = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];
        System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection();
        if (conn.State == ConnectionState.Open)
            conn.Close();
        conn.ConnectionString = connstring;
        conn.Open();
        System.Data.OleDb.OleDbCommand SqlCmd = new System.Data.OleDb.OleDbCommand("Select * from Tbl_Admin_Users where Admin_User_Email='" + Email.Trim() + "'", conn);
        System.Data.OleDb.OleDbDataReader myreader = SqlCmd.ExecuteReader();
        if (myreader.HasRows == true)
        {
            myreader.Read();
            functionReturnValue = true;
        }
        else
        {
            functionReturnValue = false;
        }
        conn.Close();
        return functionReturnValue;
    }
    public bool User_Availibility(string User_Name)
    {
        bool functionReturnValue = false;
        System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection();
        if (conn.State == ConnectionState.Open)
            conn.Close();
        conn.ConnectionString = connstring;
        conn.Open();
        System.Data.OleDb.OleDbCommand SqlCmd = new System.Data.OleDb.OleDbCommand("Select * from Tbl_Users where User_name='" + User_Name + "'", conn);
        System.Data.OleDb.OleDbDataReader myreader = SqlCmd.ExecuteReader();
        if (myreader.HasRows == true)
        {
            myreader.Read();
            functionReturnValue = false;
        }
        else
        {
            functionReturnValue = true;
        }
        conn.Close();
        return functionReturnValue;
    }
    public bool M_User_mail_Address_Validation(string E_mail_Address)
    {
        bool functionReturnValue = false;
        System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection();
        if (conn.State == ConnectionState.Open)
            conn.Close();
        conn.ConnectionString = connstring2;
        conn.Open();
        System.Data.OleDb.OleDbCommand SqlCmd = new System.Data.OleDb.OleDbCommand("Select * from Tbl_Members where M_Email='" + E_mail_Address + "'", conn);
        System.Data.OleDb.OleDbDataReader myreader = SqlCmd.ExecuteReader();
        if (myreader.HasRows == true)
        {
            myreader.Read();
            functionReturnValue = true;
        }
        else
        {
            functionReturnValue = false;
        }
        conn.Close();
        return functionReturnValue;
    }
    public bool M_User_NTN_Validation(string NTN)
    {
        bool functionReturnValue = false;
        System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection();
        if (conn.State == ConnectionState.Open)
            conn.Close();
        conn.ConnectionString = connstring2;
        conn.Open();
        System.Data.OleDb.OleDbCommand SqlCmd = new System.Data.OleDb.OleDbCommand("Select * from Tbl_Members where M_NTN='" + NTN + "'", conn);
        System.Data.OleDb.OleDbDataReader myreader = SqlCmd.ExecuteReader();
        if (myreader.HasRows == true)
        {
            myreader.Read();
            functionReturnValue = true;
        }
        else
        {
            functionReturnValue = false;
        }
        conn.Close();
        return functionReturnValue;
    }
    public bool M_User_GST_Validation(string GST)
    {
        bool functionReturnValue = false;
        System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection();
       if (conn.State == ConnectionState.Open)
            conn.Close();
        conn.ConnectionString = connstring2;
        conn.Open();
        System.Data.OleDb.OleDbCommand SqlCmd = new System.Data.OleDb.OleDbCommand("Select * from Tbl_Members where GST='" + GST + "'", conn);
        System.Data.OleDb.OleDbDataReader myreader = SqlCmd.ExecuteReader();
        if (myreader.HasRows == true)
        {
            myreader.Read();
            functionReturnValue = true;
        }
        else
        {
            functionReturnValue = false;
        }
        conn.Close();
        return functionReturnValue;
    }
    public bool FL_User_mail_Address_Validation(string E_mail_Address)
    {
        bool functionReturnValue = false;
        System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection();
        if (conn.State == ConnectionState.Open)
            conn.Close();
        conn.ConnectionString = connstring;
        conn.Open();
        System.Data.OleDb.OleDbCommand SqlCmd = new System.Data.OleDb.OleDbCommand("Select * from Tbl_FL_Users where FL_Email_Address='" + E_mail_Address + "'", conn);
        System.Data.OleDb.OleDbDataReader myreader = SqlCmd.ExecuteReader();
        if (myreader.HasRows == true)
        {
            myreader.Read();
            functionReturnValue = true;
        }
        else
        {
            functionReturnValue = false;
        }
        conn.Close();
        return functionReturnValue;
    }
    public int FL_User_Return_ID(string E_mail_Address)
    {
        int functionReturnValue = 0;
        System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection();
        if (conn.State == ConnectionState.Open)
            conn.Close();
        conn.ConnectionString = connstring;
        conn.Open();
        System.Data.OleDb.OleDbCommand SqlCmd = new System.Data.OleDb.OleDbCommand("Select FL_User_Id from Tbl_FL_Users where FL_Email_Address='" + E_mail_Address + "'", conn);
        System.Data.OleDb.OleDbDataReader myreader = SqlCmd.ExecuteReader();

        if (myreader.Read() == true)
        {
            functionReturnValue = (int)myreader.GetValue(0);
        }
        else
        {
            functionReturnValue = 0;
        }
        conn.Close();
        return functionReturnValue;
    }
    public int M_User_Return_ID(string E_mail_Address)
    {
        int functionReturnValue = 0;
        System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection();
        if (conn.State == ConnectionState.Open)
            conn.Close();
        conn.ConnectionString = connstring2;
        conn.Open();
        System.Data.OleDb.OleDbCommand SqlCmd = new System.Data.OleDb.OleDbCommand("Select M_User_Id from Tbl_Members where M_Email='" + E_mail_Address + "'", conn);
        System.Data.OleDb.OleDbDataReader myreader = SqlCmd.ExecuteReader();

        if (myreader.Read() == true)
        {
            functionReturnValue = (int)myreader.GetValue(0);
        }
        else
        {
            functionReturnValue = 0;
        }
        conn.Close();
        return functionReturnValue;
    }
    public int FL_User_Return_Page_ID(string Url)
    {
        int functionReturnValue = 0;
        System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection();
        if (conn.State == ConnectionState.Open)
            conn.Close();
        conn.ConnectionString = connstring;
        conn.Open();
        System.Data.OleDb.OleDbCommand SqlCmd = new System.Data.OleDb.OleDbCommand("Select FL_Page_Id from TBL_Fl_Site where FL_Page_Link_Title='" + Url + "'", conn);
        System.Data.OleDb.OleDbDataReader myreader = SqlCmd.ExecuteReader();
        if (myreader.Read() == true)
        {
            functionReturnValue = (int)myreader.GetValue(0);
        }
        else
        {
            functionReturnValue = 0;
        }
        conn.Close();
        return functionReturnValue;
    }
    public int M_User_Return_Page_ID(string Url)
    {
        int functionReturnValue = 0;
        System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection();
        if (conn.State == ConnectionState.Open)
            conn.Close();
        conn.ConnectionString = connstring;
        conn.Open();
        System.Data.OleDb.OleDbCommand SqlCmd = new System.Data.OleDb.OleDbCommand("Select M_Page_Id from TBL_m_Site where M_Page_Link_Title='" + Url + "'", conn);
        System.Data.OleDb.OleDbDataReader myreader = SqlCmd.ExecuteReader();
        if (myreader.Read() == true)
        {
            functionReturnValue = (int)myreader.GetValue(0);
        }
        else
        {
            functionReturnValue = 0;
        }
        conn.Close();
        return functionReturnValue;
    }
    public int FL_User_Return_ID_URL(string Url)
    {
        int functionReturnValue = 0;
        System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection();
        if (conn.State == ConnectionState.Open)
            conn.Close();
        conn.ConnectionString = connstring;
        conn.Open();
        System.Data.OleDb.OleDbCommand SqlCmd = new System.Data.OleDb.OleDbCommand("Select FL_User_Id from Tbl_FL_Users where FL_URL='" + Url + "'", conn);
        System.Data.OleDb.OleDbDataReader myreader = SqlCmd.ExecuteReader();
        if (myreader.Read() == true)
        {
            functionReturnValue = (int)myreader.GetValue(0);
        }
        else
        {
            functionReturnValue = 0;
        }
        conn.Close();
        return functionReturnValue;
    }
    public int M_User_Return_ID_URL(string Url)
    {
        int functionReturnValue = 0;
        System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection();
        if (conn.State == ConnectionState.Open)
            conn.Close();
        conn.ConnectionString = connstring;
        conn.Open();
        System.Data.OleDb.OleDbCommand SqlCmd = new System.Data.OleDb.OleDbCommand("Select M_User_Id from Tbl_M_Users where m_URL='" + Url + "'", conn);
        System.Data.OleDb.OleDbDataReader myreader = SqlCmd.ExecuteReader();
        if (myreader.Read())
        {
            functionReturnValue = (int)myreader.GetValue(0);
        }
        else
        {
            functionReturnValue = 0;
        }
        conn.Close();
        return functionReturnValue;
    }
    public string M_User_Return_Display_Name(string Url)
    {
        string functionReturnValue = null;
        System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection();
        if (conn.State == ConnectionState.Open)
            conn.Close();
        conn.ConnectionString = connstring;
        conn.Open();
        System.Data.OleDb.OleDbCommand SqlCmd = new System.Data.OleDb.OleDbCommand("Select M_Display_name from Tbl_M_Users where M_URL='" + Url + "'", conn);
        System.Data.OleDb.OleDbDataReader myreader = SqlCmd.ExecuteReader();
        if (myreader.Read() == true)
        {
            functionReturnValue = myreader.GetString(0);
        }
        else
        {
            functionReturnValue = "";
        }
        conn.Close();
        return functionReturnValue;
    }
    
    public bool E_mail_Address_Validation(string email)
    {
        bool functionReturnValue = false;
        string strRegex = "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";
        Regex regex = new Regex(strRegex);
        if ((regex.IsMatch(email)) == true)
        {
            functionReturnValue = true;
        }
        else
        {
            functionReturnValue = false;
        }
        return functionReturnValue;
    }

}