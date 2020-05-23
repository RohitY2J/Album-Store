using System;
using System.Collections.Generic;
using System.Text;
using Dapper;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

//dapper is used to map between the two models

namespace DataLibrary.DataAccess
{
    public static class SqlDataAccess
    {
        public static string GetConnectionString(string connectionName = "CourseDB")
        {
            // returns the connection string
            return ConfigurationManager.ConnectionStrings[connectionName].ConnectionString;
        }

        //templates
        //returns the list of model
        public static List<T> LoadData<T>(string sql)
        {
            using(IDbConnection cnn = new SqlConnection(GetConnectionString()))
            {
                return cnn.Query<T>(sql).ToList();
            }
        }

        //saves the data into database
        public static int SaveData<T>(string sql, T data)
        {
            using (IDbConnection cnn = new SqlConnection(GetConnectionString()))
            {
                return cnn.Execute(sql, data);
            }
        }
    }
}
