using System;
using System.Data;
using System.Collections;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using DLS.DatabaseServices;
using System.Web.Mail;

/// <summary>
/// Summary description for IEUtils
/// </summary>
    public class IEUtils
    {
        
        public static String SafeSQLString(String str)
        {
            return "'" + str.Replace("'", "''") + "'";
        }

        public static String SearchSafeSQLString(String str)
        {
            return  str.Replace("'", "''") ;
        }

        public static String SafeSQLDate(DateTime d)
        {
            return "'" + d.ToString("G") + "'";
        }


        public static DateTime ToDate(object o, DateTime defaults)
        {
            if (o == null) return defaults;
            if (o is DBNull) return defaults;
            try
            {
                return o is string ? Convert.ToDateTime(o.ToString()) : DateTime.Parse(o.ToString());
            }
            catch
            {
                return defaults;
            }
        }

        public static DateTime ToDate(object o)
        {
            return ToDate(o, new DateTime(1, 1, 1));
        }

        public static Boolean ToBoolean(object o)
        {
            if (o == null) return false;
            if (o is DBNull) return false;
            if (o is bool) return (bool)o;
            return (ToInt(o) != 0);
        }

        static public Double ToDouble(object o)
        {
            if (o == null)
                return (System.Double)0;
            if (o.GetType().Equals(typeof(System.DBNull)))
                return (System.Double)0;
            if (o.GetType().Equals(typeof(System.Double)))
                return (System.Double)o;
            if (o.GetType().Equals(typeof(System.Single)))
                return (System.Double)(System.Single)o;
            else if (o.GetType().Equals(typeof(System.Decimal)))
                return (System.Double)(System.Decimal)o;
            else if (o.GetType().Equals(typeof(System.Int64)))
                return Double.Parse(o.ToString());
            else if (o.GetType().Equals(typeof(System.Int32)))
                return Double.Parse(o.ToString());
            else if (o.GetType().Equals(typeof(System.Int16)))
                return Double.Parse(o.ToString());
            else if (o.GetType().Equals(typeof(System.String)))
            {
                try
                {
                    return Double.Parse(o.ToString());
                }
                catch
                {
                    return 0;
                }
            }
            else
            {
                return (System.Double)o;
            }
        }

        public static Decimal ToDecimal(object o)
        {
            return ToDecimal(o, (System.Decimal)0);
        }

        public static Decimal ToDecimal(object o, decimal defaults)
        {
            if (o == null) return defaults;
            if (o.GetType().Equals(typeof(System.DBNull))) return defaults;

            if (o.GetType().Equals(typeof(System.Single)))
                return (System.Decimal)(System.Single)o;

            if (o.GetType().Equals(typeof(System.Double)))
                return (System.Decimal)(System.Double)o;
            try
            {
                return Decimal.Parse(o.ToString());
            }
            catch
            {
                return defaults;
            }
        }


        static public int ToInt(object o)
        {
            return ToInt(o, 0);
        }

        static public int ToInt(object o, int defaultInt)
        {
            if (o == null)
                return defaultInt;

            if (o.GetType().Equals(typeof(System.Boolean)))
            {
                if (((bool)o) == true)
                    return 1;
                else
                    return 0;
            }

            if (o.GetType().Equals(typeof(System.Int32)))
                return (int)o;

            try
            {
                if (o.GetType().Equals(typeof(System.String)))
                    return (int)Int32.Parse(o.ToString());
            }
            catch
            {
                return defaultInt;
            }

            if (o.GetType().Equals(typeof(System.Int16)))
                return (Int16)o;

            if (o.GetType().Equals(typeof(System.Decimal)))
                return System.Decimal.ToInt32((System.Decimal)o);

            if (o.GetType().Equals(typeof(System.Byte)))
                return (int)((Byte)o);

            if (o.GetType().Equals(typeof(System.DBNull)))
                return defaultInt;

            if (o.GetType().Equals(typeof(double)))
                return (int)((double)o);

            return 0;
        }

        public static string ToString(object o)
        {
            if (o == null) return "";
            if (o.GetType().Equals(typeof(System.DBNull)))
                return "";
            return o.ToString();
        }

        public static DataView GetCodes(DatabaseManagement conn,string strCode)
        {
            String strSQL = "SELECT * FROM ADM_CODE_ITEMS WHERE CODE='" + strCode + "' ORDER BY ITEM_NUMBER";
            conn.SqlCommandText = strSQL;
            
            return conn.GetRecords("ADM_CODE_ITEMS").Tables["ADM_CODE_ITEMS"].DefaultView;

        }
       
        public static DataTable ParseCSV(string inputString)
        {

            DataTable dt = new DataTable();

            // declare the Regular Expression that will match versus the input string |(?<field>[^\\s])
            //Regex re = new Regex("((?<field>[^\",\\r\\n]+)|\"(?<field>([^\"]|[^:blank:]|\"\")+)\")(,|(?<rowbreak>\\r\\n|\\n|$))");
            //str.replace( /['"](?!\b)/g , "").replace( /([^\w])['"]/g, "$1" ).replace( /^['"]|['"]$/g, "" );
            Regex re = new Regex("[^,]*,{0,1}");


           ArrayList colArray = new ArrayList();
            ArrayList rowArray = new ArrayList();

            int colCount = 0;
            int maxColCount = 0;
            int chkRow = 1;
            //string rowbreak = "";
            //string field = "";
            MatchCollection mc;
            String[] inputArr = inputString.Split("\r\n".ToCharArray());
            foreach (String InputStr in inputArr)
            {
                if (chkRow == 1)
                {
                    chkRow = 1;
                }
                if (InputStr.Length > 0)
                {
                    mc = re.Matches(InputStr);
                    String fieldVal = "";
                    bool QouteStarted = false;
                    foreach (Match m in mc)
                    {
                        if (m.Value.Length > 0)
                        {
                            if (m.Value.StartsWith("\""))
                            {
                                fieldVal = m.Value.Substring(1);
                                QouteStarted = true;
                            }
                            else
                            {
                                if (QouteStarted)
                                {
                                    if (m.Value.EndsWith("\","))
                                    {
                                        QouteStarted = false;
                                        fieldVal += m.Value.Substring(0, m.Value.Length - 2);
                                    }
                                    else
                                    {
                                        fieldVal += m.Value;
                                    }
                                }
                                else
                                {//Check if not ends with comma

                                    if (m.Value.EndsWith(","))
                                    {
                                        fieldVal = m.Value.Substring(0, m.Value.Length - 1);
                                    }
                                    else
                                    {
                                        fieldVal = m.Value;
                                    }
                                }
                            }

                            if (!QouteStarted)
                            {
                                //Field Values
                                if (chkRow == 1)
                                {
                                    colArray.Add(fieldVal);
                                }
                                else
                                {
                                    rowArray.Add(fieldVal);
                                }
                                colCount++;

                            }
                        }
                        if ((chkRow == 1) && (colCount > maxColCount))
                        {
                            dt.Columns.Add(colArray[maxColCount].ToString());
                        }
                        else if (colCount == maxColCount)
                        {
                            chkRow = 0;
                        }
                        if (colCount > maxColCount)
                        {
                            maxColCount = colCount;
                        }

                    }
                    if (rowArray.Count > 0)
                    {

                        dt.Rows.Add(rowArray.ToArray());
                        rowArray = new ArrayList();
                    }
                    colCount = 0;
                    maxColCount = 0;
                }
            }



            // in case no data was parsed, create a single column
            //if (dt.Columns.Count == 0)
            //    dt.Columns.Add("NoData");

            return dt;
        }

        public static String GenerateRandomPassword(int PasswordLength)
        {
            String AllowedChars = "abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ0123456789";
            String strPWD = "";
            char[] chars = AllowedChars.ToCharArray();
            int length = AllowedChars.Length;
            Random r = new Random(0);
            for (int i = 0; i < PasswordLength; i++)
            {
                strPWD+= chars[r.Next(length-1)];
            }
            return strPWD;
        }

      
        public static bool IsEmail(string inputEmail)
        {
            string pattern = @"^[a-z][a-z|0-9|]*([_][a-z|0-9]+)*([.][a-z|" +
                   @"0-9]+([_][a-z|0-9]+)*)?@[a-z][a-z|0-9|]*\.([a-z]" +
                   @"[a-z|0-9]*(\.[a-z][a-z|0-9]*)?)$";
            System.Text.RegularExpressions.Match match =
                Regex.Match(inputEmail.Trim(), pattern, RegexOptions.IgnoreCase);

            return match.Success;
        }


        public static void RecordEmailError(DatabaseManagement DBConn, Decimal SourceID, String EmailAddress)
        {
            int ErrorID = DBConn.GetMaxID("ERROR_ID", "FMM_SOURCE_ERRORS");
            String strSQL = "INSERT INTO FMM_SOURCE_ERRORS(ERROR_ID,SOURCE_ID,EMAIL_ADDRESS) VALUES(" + ErrorID + "," + SourceID + "," + SafeSQLString(EmailAddress) + ")";
            DBConn.ExecuteSQL(strSQL);
        }

        public static String ReplaceCRwithBR(String Input)
        {
            return Input.Replace("\r", "<br>");
        }

        public static String ArrayToString(IList List, String Separator)
        {
            String str = "";
            for (int i = 0; i < List.Count; i++)
            {
                str += List[i].ToString() + Separator;
            }
            return str.Substring(0, str.LastIndexOf(Separator));
        }
        public static void EnableButton(ListItemCollection Items, Button btnSave)
        {
            if (Items.Count > 0 && ToInt(Items[0].Value) > 0)
            {
                btnSave.Enabled = true;
            }
            else
            {
                btnSave.Enabled = false;
            }
        }
        public static void UploadFile(System.Web.UI.WebControls.FileUpload fileUploadPicture, string FilepathPicture, System.Web.UI.WebControls.FileUpload fileUploadPoster, string FilepathPoster, string DestinationPath)
        {
	        try
	        {
               if ((fileUploadPicture.PostedFile != null) && (fileUploadPicture.PostedFile.ContentLength > 0))// check whether tere is some file with some data in it
               {
                    string FileNamePicture = System.IO.Path.GetFileName(fileUploadPicture.PostedFile.FileName);// to get teh file name

                    if (FileNamePicture.Substring(FileNamePicture.Length - 3, 3).ToLower() == "jpg" || FileNamePicture.Substring(FileNamePicture.Length - 3, 3) == "gif")
                    {
                        fileUploadPicture.PostedFile.SaveAs(DestinationPath+FileNamePicture);
                    }
                }
                if ((fileUploadPoster.PostedFile != null) && (fileUploadPoster.PostedFile.ContentLength > 0))// check whether tere is some file with some data in it
                {
                    string FileNamePoster = System.IO.Path.GetFileName(fileUploadPoster.PostedFile.FileName);// to get teh file name

                    if (FileNamePoster.Substring(FileNamePoster.Length - 3, 3).ToLower() == "jpg" || FileNamePoster.Substring(FileNamePoster.Length - 3, 3) == "gif")
                    {
                        fileUploadPoster.PostedFile.SaveAs(DestinationPath + FileNamePoster);
                    }
                }
	        }
	        catch (Exception ex)
	        {
		        
	        }
        }
         public static void UploadFileSingle(System.Web.UI.WebControls.FileUpload fileUploadPicture, string FilepathPicture,string DestinationPath)
        {
	        try
	        {
               if ((fileUploadPicture.PostedFile != null) && (fileUploadPicture.PostedFile.ContentLength > 0))// check whether tere is some file with some data in it
               {
                    string FileNamePicture = System.IO.Path.GetFileName(fileUploadPicture.PostedFile.FileName);// to get teh file name

                    if (FileNamePicture.Substring(FileNamePicture.Length - 3, 3).ToLower() == "jpg" || FileNamePicture.Substring(FileNamePicture.Length - 3, 3) == "gif")
                    {
                        fileUploadPicture.PostedFile.SaveAs(DestinationPath+FileNamePicture);
                    }
                }
            }
            catch (Exception ex)
            {

            }
        }


        public static string InitialCap(string a)
        {
            if (a.Length <= 1)
            {
                return a;

            }
            else
            {
                Char[] letters = a.ToCharArray();
                letters[0] = Char.ToUpper(letters[0]);
                return new string(letters);
            
            }
        
        }
        public static bool existCity(string cit)
        {
            SqlConnection sqlConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["dbSST"].ToString());
            SqlCommand cmd = sqlConn.CreateCommand();
            if (sqlConn.State == ConnectionState.Closed)
            {
                sqlConn.Open();
            }
            cmd.CommandText = "Select * from [city] where city.cityname="+"'"+ cit.ToString()+"'"; // Where tblMovie.MovieID=" + Request.QueryString["MovieID"];

           SqlDataReader rdr1 = cmd.ExecuteReader();

            if (rdr1.Read())
            {
                rdr1.Close();
                sqlConn.Close();
                return true;
            }
            else
            {
                rdr1.Close();
                sqlConn.Close();
                return false;
            }
            
        
        }
        public static bool existCountry(string country)
        {
            SqlConnection sqlConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["dbSST"].ToString());
            SqlCommand cmd = sqlConn.CreateCommand();
            if (sqlConn.State == ConnectionState.Closed)
            {
                sqlConn.Open();
            }
            cmd.CommandText = "Select countryname from [country] where countryname=" + "'" + country.ToString() + "'"; // Where tblMovie.MovieID=" + Request.QueryString["MovieID"];

           SqlDataReader rdr2 = cmd.ExecuteReader();

            if (rdr2.Read())
            {
                rdr2.Close();
                sqlConn.Close();
                return true;
            }
            else
            {
                rdr2.Close();
                sqlConn.Close();
                return false;
            }


        }
        public static bool existEmail(string email)
        {
            SqlConnection sqlConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["dbSST"].ToString());
            SqlCommand cmd = sqlConn.CreateCommand();
            if (sqlConn.State == ConnectionState.Closed)
            {
                sqlConn.Open();
            }
            cmd.CommandText = "Select email from [user] where email=" + "'" + email.ToString() + "'"; // Where tblMovie.MovieID=" + Request.QueryString["MovieID"];

           SqlDataReader rdr2 = cmd.ExecuteReader();

            if (rdr2.Read())
            {
                rdr2.Close();
                sqlConn.Close();
                return true;
            }
            else
            {
                rdr2.Close();
                sqlConn.Close();
                return false;
            }


        }
        public static Int32 CountryID(string country)
        {
            Int32 cid=0;
            SqlConnection sqlConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["dbSST"].ToString());
            SqlCommand cmd = sqlConn.CreateCommand();
            if (sqlConn.State == ConnectionState.Closed)
            {
                sqlConn.Open();
            }
            cmd.CommandText = "Select countryid from [country] where countryname=" + "'" + country.ToString() + "'"; // Where tblMovie.MovieID=" + Request.QueryString["MovieID"];

           SqlDataReader rdr1 = cmd.ExecuteReader();

            if (rdr1.Read())
            {
                if (rdr1["countryid"] != System.DBNull.Value)
                {
                    cid = Convert.ToInt32(rdr1["countryid"]);
                }
            }
            rdr1.Close();
            sqlConn.Close();
            return cid;
            
        }
        public static Int32 Userid(string email)
        {
            Int32 Maxid = 0;
            SqlConnection SqlConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["dbSST"].ToString());
            SqlCommand command = SqlConnection.CreateCommand();
            if (SqlConnection.State == ConnectionState.Closed)
            {
                SqlConnection.Open();
            }
            command.CommandText = "Select userid as MaxUserID from [user] Where [user].email=" +"'"+email+"'";
           SqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                if (reader["MaxUserID"] != System.DBNull.Value)
                {
                    Maxid = Convert.ToInt32(reader["MaxUserID"]);

                }
            }
            reader.Close();
            SqlConnection.Close();
            return Maxid;
        
        
        }
        public static Int32 Orgid()
        {
            Int32 Maxid = 0;
            SqlConnection SqlConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["dbSST"].ToString());
            SqlCommand command = SqlConnection.CreateCommand();
            if (SqlConnection.State == ConnectionState.Closed)
            {
                SqlConnection.Open();
            }
            command.CommandText = "Select MAX(orgid) as OrgID from [organizations]";
           SqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                if (reader["OrgID"] != System.DBNull.Value)
                {
                    Maxid = Convert.ToInt32(reader["OrgID"]);

                }
            }
            reader.Close();
            SqlConnection.Close();
            return Maxid;


        }
        public static Int32 MaxCountryID()
        {
            Int32 cid = 0;
            SqlConnection sqlConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["dbSST"].ToString());
            SqlCommand cmd = sqlConn.CreateCommand();
            if (sqlConn.State == ConnectionState.Closed)
            {
                sqlConn.Open();
            }
            cmd.CommandText = "Select Max(countryid) as MaxCountryID from [country]"; // Where tblMovie.MovieID=" + Request.QueryString["MovieID"];

           SqlDataReader rdr1 = cmd.ExecuteReader();

            if (rdr1.Read())
            {
                if (rdr1["MaxCountryID"] != System.DBNull.Value)
                {
                    cid = Convert.ToInt32(rdr1["MaxCountryID"]);
                }
            }
            rdr1.Close();
            sqlConn.Close();
            return cid;
        } 
        
        public static Int32 CNewsID(DateTime  date,Int32 cid)
        {
            Int32 newsid = 0;
            SqlConnection sqlConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["dbSST"].ToString());
            SqlCommand cmd = sqlConn.CreateCommand();
            if (sqlConn.State == ConnectionState.Closed)
            {
                sqlConn.Open();
            }
            cmd.CommandText = "Select cnewsid as NewsID from [cnews] where newstime=" + "'" + Convert.ToDateTime(date) + "'"+" "+ "AND"+" "+ "coresid=" + "'" + Convert.ToDecimal(cid) + "'";

           SqlDataReader rdr1 = cmd.ExecuteReader();

            if (rdr1.Read())
            {
                if (rdr1["NewsID"] != System.DBNull.Value)
                {
                    newsid = Convert.ToInt32(rdr1["NewsID"]);
                }
            }
            rdr1.Close();
            sqlConn.Close();
            return newsid;

        }
        public static bool levelExist(Decimal level)
        {
            
            SqlConnection sqlConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["dbSST"].ToString());
            SqlCommand cmd = sqlConn.CreateCommand();
            if (sqlConn.State == ConnectionState.Closed)
            {
                sqlConn.Open();
            }
            cmd.CommandText = "Select plevel from [editednews] where plevel=" + "'" +level+ "'"; // Where tblMovie.MovieID=" + Request.QueryString["MovieID"];

           SqlDataReader rdr4 = cmd.ExecuteReader();

            if (rdr4.Read())
            {

                levelupdate(level);
                rdr4.Close();
                sqlConn.Close();
                return true;
            }
            else
            {
                rdr4.Close();
                sqlConn.Close();
                return false;
            }

        
        }
        public static bool plevelExist(Decimal level)
        {

            SqlConnection sqlConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["dbSST"].ToString());
            SqlCommand cmd = sqlConn.CreateCommand();
            if (sqlConn.State == ConnectionState.Closed)
            {
                sqlConn.Open();
            }
            cmd.CommandText = "Select plevel from [editednews] where plevel=" + "'" + level + "'"; // Where tblMovie.MovieID=" + Request.QueryString["MovieID"];

           SqlDataReader rdr4 = cmd.ExecuteReader();

            if (rdr4.Read())
            {

                rdr4.Close();
                sqlConn.Close();
                return true;
            }
            else
            {
                rdr4.Close();
                sqlConn.Close();
                return false;
            }


        }
        public static void levelupdate(Decimal plevel) 
        {
            SqlConnection sqlConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["dbSST"].ToString());
            SqlCommand cmd = sqlConn.CreateCommand();
            if (sqlConn.State == ConnectionState.Closed)
            {
                sqlConn.Open();
            }
            cmd.CommandText = "UPDATE [editednews] SET plevel = plevel+1 WHERE plevel >= " + plevel+"AND plevel!= 0";
            cmd.ExecuteNonQuery();
            sqlConn.Close();
        }
        public static void swaplevel(Decimal plevel,Decimal newlevel)
        {
            SqlConnection sqlConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["dbSST"].ToString());
            SqlCommand cmd = sqlConn.CreateCommand();
            if (sqlConn.State == ConnectionState.Closed)
            {
                sqlConn.Open();
            }
            cmd.CommandText = "UPDATE [editednews] SET plevel = " + newlevel + " where plevel=" + "'" + plevel + "'";
            cmd.ExecuteNonQuery();
            sqlConn.Close();
        }
        public static void SendEmail(string mailto, string mailfrom, string mailsubject, string mailbody)
        {
            MailMessage mail = new MailMessage();
            mail.To = mailto.ToString();
            mail.From = mailfrom.ToString();
            mail.Subject = mailsubject.ToString();
           // mail.BodyFormat=MailFormat.Html;
            mail.Body = mailbody.ToString();
            SmtpMail.Send(mail);
            
               
         }
        

    }
