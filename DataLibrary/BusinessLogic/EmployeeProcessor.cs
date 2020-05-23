using System;
using System.Collections.Generic;
using System.Text;
using DataLibrary.Models;
using DataLibrary.DataAccess;

namespace DataLibrary.BusinessLogic
{
    public static class EmployeeProcessor
    {
        public static int CreateEmployee(int employeeId, string firstName,
            string lastName, string email)
        {
            EmployeeModel data = new EmployeeModel
            {
                EmployeeId = employeeId,
                FirstName = firstName,
                LastName = lastName,
                Email = email
            };

            string sql = @"insert into dbo.Emp_Tb(Id, EmployeeId, FirstName, LastName, Email)
                        values (@EmployeeId, @EmployeeId, @FirstName, @LastName, @Email);";

            return SqlDataAccess.SaveData<EmployeeModel>(sql, data);
        }

        //EmployeeModel is the one in the datalibrary.
        public static List<EmployeeModel> LoadEmployees()
        {
            string sql = @"Select Id, EmployeeId, FirstName, LastName, 
                        Email from dbo.Emp_Tb;";
            
            return SqlDataAccess.LoadData<EmployeeModel>(sql);
        }
    }
}
