using System;

namespace Tco.DatabaseServices
{
    public class Users
    {
        public int UserID { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Designation { get; set; }
        public string UserRole { get; set; }
        public string  UserStatus { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
      
        public Boolean Add(DatabaseManagement2 db)
        {
            var strQuery = string.Format("INSERT INTO Tbl_Users(Name,Email,Designation,UserRole,UserName,Password,UserStatus) " +
                                         "VALUES({0},{1},{2},{3},{4},{5},{6})",
                                         IEUtils.SafeSQLString(Name),
                                         IEUtils.SafeSQLString(Email),
                                         IEUtils.SafeSQLString(Designation),
                                         IEUtils.SafeSQLString(UserRole),
                                         IEUtils.SafeSQLString(UserName),
                                         IEUtils.SafeSQLString(Password),
                                         IEUtils.SafeSQLString(UserStatus));
            db.ExecuteSQL(strQuery);
            return true;
        }

        public Boolean Save(DatabaseManagement2 db)
        {
            var strQuery = string.Format("UPDATE Tbl_Users set Name={0}, " +
                                                                "Designation={1}, " +
                                                                 "Email={2}," +
                                                                 "UserRole={3}, " +
                                                                 "UserName={4}," +
                                                                 "Password ={5}," +
                                                                 "UserStatus={6} " +
                                                                
                                         "WHERE UserID={7}",
                                         IEUtils.SafeSQLString(Name),
                                        IEUtils.SafeSQLString(Designation),
                                         IEUtils.SafeSQLString(Email),
                                         IEUtils.SafeSQLString(UserRole),
                                         IEUtils.SafeSQLString(UserName),
                                         IEUtils.SafeSQLString(Password),
                                         IEUtils.SafeSQLString(UserStatus),
                                         UserID);
            db.ExecuteSQL(strQuery);
            return true;
        }

        public Boolean Load(DatabaseManagement2 db, Decimal userId)
        {
            var strSQL = string.Format("SELECT UserID," +
                                                "Name," +
                                                "Designation," +
                                                "Email," +
                                                "UserRole," +
                                                "UserName," +
                                                "Password," +
                                                "UserStatus " +
                                              "FROM Tbl_Users  WHERE UserID={0}", userId);
            var reader = db.ExecuteReader(strSQL);
            if (reader.Read())
            {
                UserID = int.Parse(reader["UserID"].ToString());
                Name = IEUtils.ToString(reader["Name"]);
                Designation = IEUtils.ToString(reader["Designation"]);
                Email = IEUtils.ToString(reader["Email"]);
                UserRole = IEUtils.ToString(reader["UserRole"]);
                UserName = IEUtils.ToString(reader["UserName"]);
                Password = IEUtils.ToString(reader["Password"]);
                UserStatus = IEUtils.ToString(reader["UserStatus"]);
             }
            reader.Close();
            return true;
        }

    }
}
