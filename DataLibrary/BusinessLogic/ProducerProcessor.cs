using DataLibrary.Models;
using System;
using System.Collections.Generic;
using System.Text;
using DataLibrary.DataAccess;

namespace DataLibrary.BusinessLogic
{
    public class ProducerProcessor
    {
        public static int CreateProducer(string producer_name)
        {
            ProducerModel data = new ProducerModel
            {
                Producer_name = producer_name
            };

            string sql = @"insert into dbo.Producer_Details(Producer_name)
                        values (@Producer_name);";

            return SqlDataAccess.SaveData<ProducerModel>(sql, data);
        }

        //EmployeeModel is the one in the datalibrary.
        public static List<ProducerModel> LoadEmployees()
        {
            string sql = @"Select Id, EmployeeId, FirstName, LastName, 
                        Email from dbo.Emp_Tb;";

            return SqlDataAccess.LoadData<ProducerModel>(sql);
        }

        public static int get_id(string producer_name)
        {
            string sql = @"Select Producer_ID from dbo.Producer_Details where Producer_name = '" + producer_name + "'";
            var result = SqlDataAccess.LoadData<ProducerModel>(sql);
            foreach (var row in result)
            {
                return row.Producer_ID;
            }
            return 0;
        }
    }
}
