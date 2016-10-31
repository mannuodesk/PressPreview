using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;

namespace DLS.DatabaseServices
{
   
    /// <summary>
    /// This class is to be used for Database manipulation. 
    /// </summary>
    public class DatabaseManagement
    {

        private string _strConnectionString = "";
        private string _strOldbConnectionString = "";
        public readonly SqlConnection _sqlConnection ;
        private SqlDataAdapter _sqlDataAdapter;
        private SqlCommand _sqlCommand;
        private SqlTransaction _sqlTransaction;

        /// <summary>
        /// Get or Set the ConnectionString property.
        /// </summary>
        public string ConnectionString
        {
            get { return _strConnectionString; }
            set { _strConnectionString = value; }
        }

        public string OLEDBConnectionString
        {
            get { return _strOldbConnectionString; }
            set { _strOldbConnectionString = value; }
        }
        /// <summary>
        /// Get or Set the CommandText property.
        /// </summary>
        public string SqlCommandText
        {
            get { return _sqlCommand.CommandText;  }
            set
            {
                if (_sqlCommand == null)

                    _sqlCommand = new SqlCommand();
                _sqlCommand.CommandText = value;
            }
        }
        public DatabaseManagement()
        {
            _strConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["dbConnectionPP"].ToString();
            _strOldbConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["GvConnection"].ToString();
            if (_strConnectionString == null)
            {
                throw new ArgumentException("Connection string has not been initialized.");
            }
            else
            {
                _sqlConnection  = new SqlConnection(_strConnectionString);

            }
        }

        public DatabaseManagement(string connectionString)
        {
            if (connectionString == null)
            {
                throw new ArgumentException("Connection string has not been initialized.");
            }
            else
            {
                _sqlConnection  = new SqlConnection(connectionString);

            }

        }
        ~DatabaseManagement()
        {
            /*if (SqlConnection  != null && SqlConnection .State == ConnectionState.Open)
            {
                SqlConnection .Close();
                this.SqlConnection  = null;
                this.strConnectionString = null;
            }*/


        }

        /// <summary>
        /// Query the database and returns a DataSet. Accept SqlCommand text and TableName as parameter.
        /// Use this function for short SQL queries.
        /// </summary>
        /// <param>SQL Query in the Text form. <name>SqlCommand</name> </param>
        /// <param name="sqlcommand"> </param>
        /// <param name="tableName">TableName for the DataSet</param>
        /// <returns>DataSet</returns>
        public DataSet GetRecords(string sqlcommand, string tableName)
        {
            try
            {
                if (_sqlConnection .State == ConnectionState.Closed)
                {
                    _sqlConnection .Open();
                }

                var ds = new DataSet();
                _sqlCommand = new SqlCommand {CommandText = sqlcommand};
                _sqlDataAdapter = new SqlDataAdapter(sqlcommand, _sqlConnection );
                _sqlDataAdapter.Fill(ds, tableName);

                return ds;

            }
            finally
            {
                _sqlConnection .Close();

            }

        }

        /// <summary>
        /// Query the database and returns a DataSet. Set the DatabaseManagement.SqlCommandText property before
        /// calling this method. Use this method for long SQL queries.
        /// </summary>
        /// <param name="tableName">TableName for the DataSet</param>
        /// <exception cref="ArgumentNullException"></exception>
        /// <returns>DataSet</returns>
        public DataSet GetRecords(string tableName)
        {
            try
            {

                if (_sqlCommand.CommandText == "")
                {
                    throw new ArgumentNullException("SqlCommandText property of DatabaseManagement class cannot be an empty string.");
                }
                if (_sqlConnection .State == ConnectionState.Closed)
                {
                    _sqlConnection .Open();
                }

                var ds = new DataSet();
                //SqlCommand = new SqlCommand();
                _sqlDataAdapter = new SqlDataAdapter(_sqlCommand.CommandText, _sqlConnection );
                _sqlDataAdapter.Fill(ds, tableName);

                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _sqlConnection .Close();
            }

        }
        public DataTable GetRecordsTable(string TableName)
        {
            try
            {

                if (this._sqlCommand.CommandText == "")
                {
                    throw new ArgumentNullException("SqlCommandText property of DatabaseManagement class cannot be an empty string.");
                }
                else
                {
                    if (_sqlConnection .State == ConnectionState.Closed)
                    {
                        _sqlConnection .Open();
                    }

                    DataTable ds = new DataTable();

                    //SqlCommand = new SqlCommand();
                    _sqlDataAdapter = new SqlDataAdapter(this._sqlCommand.CommandText, _sqlConnection );
                    _sqlDataAdapter.Fill(ds);

                    return ds;
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _sqlConnection .Close();
            }

        }
        /// <summary>
        /// Run a StoredProcedure of SQLServer and returns a dataset
        /// </summary>
        /// <param name="tableName">string</param>
        /// <param name="commandType">CommandType</param>
        /// <param name="commandText">string</param>
        /// <returns></returns>
        public DataSet GetRecords(string tableName, CommandType commandType, string commandText)
        {
            try
            {
                if (_sqlConnection .State == ConnectionState.Closed)
                {
                    _sqlConnection .Open();
                }

                DataSet ds = new DataSet();
                if (this._sqlCommand == null)
                    this._sqlCommand = new SqlCommand();
                this._sqlCommand.Connection = this._sqlConnection ;
                this._sqlCommand.CommandType = commandType;
                this._sqlCommand.CommandText = commandText;
                _sqlDataAdapter = new SqlDataAdapter(this._sqlCommand);
                _sqlDataAdapter.Fill(ds, tableName);

                return ds;

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _sqlConnection .Close();

            }

        }
        /// <summary>
        /// Query the database and return bool if SqlCommand has rows for the specified SQL query.
        /// Use this method for short SQL queries.
        /// </summary>
        /// <param name="sqlString">SQL query in the text form.</param>
        /// <returns>true if SqlCommand has rows and false if no rows are returned.</returns>
        public bool RecordExist(string sqlString)
        {
            try
            {
                if (_sqlConnection .State == ConnectionState.Closed)
                {
                    _sqlConnection .Open();
                }

                _sqlCommand = new SqlCommand {Connection = _sqlConnection, CommandText = sqlString};

                return _sqlCommand.ExecuteReader().HasRows;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _sqlConnection .Close();
                _sqlCommand = null;
            }
        }

        public SqlDataReader ExecuteReader(String SQLString)
        {
            try
            {
                if (_sqlConnection .State == ConnectionState.Closed)
                {
                    _sqlConnection .Open();
                }
                _sqlCommand = new SqlCommand();
                _sqlCommand.Connection = _sqlConnection ;
                _sqlCommand.CommandText = SQLString;
                return _sqlCommand.ExecuteReader();
            }
            catch (Exception ex)
            {
                _sqlConnection.Close();
                _sqlCommand = null;
                throw ex;
            }
        }


        /// <summary>
        /// Query the database and return bool if SqlCommand has rows for the specified SQL query.
        /// Set the DatabaseManagement.SqlCommandText property before calling this method. 
        /// Use this method for long SQL queries.
        /// </summary>
        /// <returns>true if SqlCommand has rows and false if no rows are returned.</returns>
        public bool RecordExist()
        {
            try
            {
                if (this._sqlCommand.CommandText == "")
                {
                    throw new ArgumentNullException("SqlCommandText property of DatabaseManagement class cannot be an empty string.");

                }
                else
                {
                    if (_sqlConnection .State == ConnectionState.Closed)
                    {
                        _sqlConnection .Open();
                    }

                    _sqlCommand = new SqlCommand();
                    _sqlCommand.Connection = _sqlConnection ;
                    return _sqlCommand.ExecuteReader().HasRows;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _sqlConnection .Close();
                _sqlCommand = null;
            }
        }
        /// <summary>
        /// Execute a StoredProcedure and return number of rows affected.
        /// </summary>
        /// <param name="commandType">SqlCommandType</param>
        /// <param name="commandText">Stored Procedure Name</param>
        /// <returns></returns>
        public int ExecuteSQL(CommandType commandType, string commandText)
        {
            try
            {
                if (_sqlConnection .State == ConnectionState.Closed)
                {
                    _sqlConnection .Open();
                }


                //Note: SqlCommand can be set either in here or in AddSqlParameterToCommandObject method 
                if (this._sqlCommand == null)
                    this._sqlCommand = new SqlCommand();
                this._sqlCommand.Connection = this._sqlConnection ;
                this._sqlCommand.CommandType = commandType;
                this._sqlCommand.CommandText = commandText;
                return this._sqlCommand.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _sqlConnection .Close();

            }

        }
        public int ExecuteSQL(SqlCommand sqlCommand)
        {
            try
            {
                switch (_sqlConnection .State)
                {
                    case ConnectionState.Closed:
                        _sqlConnection .Open();
                        break;
                }


                //Note: SqlCommand can be set either in here or in AddSqlParameterToCommandObject method 

                sqlCommand.Connection = _sqlConnection ;

                return sqlCommand.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _sqlConnection .Close();

            }

        }
        /// <summary>
        /// Execute the specified SQL and returns the number of rows affected.
        /// Use this method for short SQL queries.
        /// </summary>
        /// <param name="SQLString">SQL query in text format.</param>
        /// <returns>integer specifying number of rows affected as the result of SQL query.</returns>
        public int ExecuteSQL(string SQLString)
        {
            try
            {
                switch (_sqlConnection .State)
                {
                    case ConnectionState.Closed:
                        _sqlConnection .Open();
                        break;
                }

                _sqlCommand = new SqlCommand {Connection = _sqlConnection, CommandText = SQLString};
                return _sqlCommand.ExecuteNonQuery();

            }
            catch (SqlException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _sqlConnection .Close();
                _sqlCommand = null;
            }
        }
        /// <summary>
        /// Execute the specified SQL and returns the number of rows affected. 
        /// Set the DatabaseManagement.SqlCommandText property before calling this method.
        /// Use this method for long SQL queries.
        /// </summary>
        /// <returns>integer specifying number of rows affected as the result of SqlCommand</returns>
        public int ExecuteSQL()
        {
            try
            {
                switch (_sqlCommand.CommandText)
                {
                    case "":
                        throw new ArgumentNullException("SqlCommandText property of DatabaseManagement class cannot be an empty string.");
                    default:
                        _sqlConnection .Open();
                        _sqlCommand.Connection = _sqlConnection ;
                        return _sqlCommand.ExecuteNonQuery();
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _sqlConnection .Close();
                _sqlCommand = null;
            }
        }
        /// <summary>
        /// Check the SQL Server status and return SqlConnection State
        /// </summary>
        /// <returns></returns>
        /// <summary>
        /// Query the database and return Integer if SqlCommand has rows for the specified SQL query.
        /// Set the DatabaseManagement.SqlCommandText property before calling this method. 
        /// Use this method for long SQL queries.
        /// </summary>
        /// <param name="FieldName">Field for Max Number.</param>
        ///  <param name="TableName">Table Name .</param>
        /// <returns>return Max Number.</returns>
        public int GetMaxID(string FieldName, string TableName)
        {
            try
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("SELECT Max([" + FieldName + "]) ");
                sb.Append("AS " + FieldName + " FROM " + TableName + "");
                _sqlConnection .Open();
                _sqlCommand = new SqlCommand();
                _sqlCommand.Connection = _sqlConnection ;
                _sqlCommand.CommandText = sb.ToString();
                object MaxID = _sqlCommand.ExecuteScalar();
                if (MaxID != System.DBNull.Value)
                {
                    int MID = Convert.ToInt32(MaxID);
                    return MID + 1;
                }
                else
                {
                    return 1;
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _sqlConnection.Close();
                _sqlCommand = null;
            }
        }
        /// <summary>
        /// Query the database and return string if SqlCommand has rows for the specified SQL query.
        /// Set the DatabaseManagement.SqlCommandText property before calling this method. 
        /// Use this method for long SQL queries.
        /// </summary>
        ///  <param name="strSQL">Table Name.</param>
        /// <returns>return string.</returns>
        public string GetExecuteScalar(string strSQL)
        {
            try
            {
                _sqlConnection .Open();
                _sqlCommand = new SqlCommand {Connection = _sqlConnection, CommandText = strSQL};
                object strResult = _sqlCommand.ExecuteScalar();
                if (strResult != System.DBNull.Value)
                {
                    return strResult.ToString();
                }
                else
                {
                    return "";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _sqlConnection.Close();
                _sqlCommand = null;
            }
        }
        public string CheckSQLServerStatus()
        {
            try
            {
                this._sqlConnection .Open();
                return this._sqlConnection .State.ToString();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void ResetCommandObjectSqlParameters()
        {
            if (this._sqlCommand != null)
                this._sqlCommand.Parameters.Clear();
        }
        public void AddSqlParameterToCommandObject(string parameterName, SqlDbType dbType, int size, object Value)
        {
            if (this._sqlCommand == null)
                this._sqlCommand = new SqlCommand();
            SqlParameter sqlParameter = new SqlParameter(parameterName, dbType, size);
            sqlParameter.Value = Value;
            this._sqlCommand.Parameters.Add(sqlParameter);

        }

        /// <summary>
        /// Execute an array of specified SQL under a trasaction and return true if process complete successsfuly.
        /// Use this method for Array of SQL queries.
        /// </summary>
        /// <param name="SQLString">Array of SQL query in text format.</param>
        /// <returns>Boolean specifying success or failure of execution of Array of SQL queries.</returns>
        public bool ExecuteSQL(string[] SQLString)
        {
            try
            {
                int i = 0;
                _sqlConnection .Open();
                _sqlTransaction = _sqlConnection.BeginTransaction();
                _sqlCommand = new SqlCommand {Connection = _sqlConnection, Transaction = _sqlTransaction};

                int totalQueries = SQLString.Length;
                for (i = 0; i < totalQueries; i++)
                {
                    if (SQLString[i] != null)
                    {
                        string sqlString = SQLString[i];
                        if (sqlString.Trim().Length > 0)
                        {
                            _sqlCommand.CommandText = sqlString;
                            _sqlCommand.ExecuteNonQuery();
                        }
                    }
                }
                _sqlTransaction.Commit();
              
                return true;
            }
            catch (SqlException ex)
            {
                if (_sqlTransaction != null)
                    _sqlTransaction.Rollback();

                throw ex;

            }
            catch (Exception ex)
            {
                if (_sqlTransaction != null)
                    _sqlTransaction.Rollback();
                throw;
            }
            finally
            {
                _sqlConnection .Close();
                _sqlCommand = null;
            }
        }
    }
}