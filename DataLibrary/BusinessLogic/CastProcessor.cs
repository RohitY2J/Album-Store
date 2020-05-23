using System;
using System.Collections.Generic;
using System.Text;
using DataLibrary.Models;
using DataLibrary.DataAccess;
using System.Runtime.Versioning;

namespace DataLibrary.BusinessLogic
{
    public class CastProcessor
    {
        public static int CreateCast(string fname, string lname)
        {
            CastModel data = new CastModel
            {
                FirstName = fname,
                LastName = lname
            };

            string sql = @"insert into dbo.Cast_Details(FirstName, LastName)
                        values (@FirstName, @LastName);";

            return SqlDataAccess.SaveData<CastModel>(sql, data);
        }

        //EmployeeModel is the one in the datalibrary.
        public static List<CastModel> LoadEmployees()
        {
            string sql = @"Select Id, EmployeeId, FirstName, LastName, 
                        Email from dbo.Emp_Tb;";

            return SqlDataAccess.LoadData<CastModel>(sql);
        }

        public static int get_id_fname(string fname)
        {
            string sql = @"Select * from dbo.Cast_Details where FirstName = '" + fname + "'";
            var result = SqlDataAccess.LoadData<CastModel>(sql);
            foreach (var row in result)
            {
                return row.Cast_ID;
            }
            return 0;
        }

        public static int get_id_lname(string lname)
        {
            string sql = @"Select Cast_ID from dbo.Cast_Details where LastName = '" + lname + "'";
            var result = SqlDataAccess.LoadData<CastModel>(sql);
            foreach (var row in result)
            {
                return row.Cast_ID;
            }
            return 0;
        }
    }
}
