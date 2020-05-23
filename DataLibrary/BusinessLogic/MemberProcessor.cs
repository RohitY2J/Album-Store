using System;
using System.Collections.Generic;
using System.Text;
using DataLibrary.Models;
using DataLibrary.DataAccess;

namespace DataLibrary.BusinessLogic
{
    public class MemberProcessor
    {
        public static int CreateMember(string userName, string firstName,
            string lastName, int phone_num)
        {
            int id = UserProcessor.get_id(userName);

            MemberModel data = new MemberModel
            {
                FirstName = firstName,
                LastName = lastName,
                Phone_Num = phone_num,
                User_ID = id
            };

            string sql = @"insert into dbo.Member(FirstName, LastName, Phone, User_ID)
                        values (@FirstName, @LastName, @Phone_num, @User_ID);";

            return SqlDataAccess.SaveData<MemberModel>(sql, data);
        }

        //EmployeeModel is the one in the datalibrary.
        public static List<MemberModel> LoadEmployees()
        {
            string sql = @"Select Id, EmployeeId, FirstName, LastName, 
                        Email from dbo.Emp_Tb;";

            return SqlDataAccess.LoadData<MemberModel>(sql);
        }
        public static int get_id(int userid)
        {
            string sql = @"Select Member_ID from dbo.Member where User_ID = '" + userid + "'";
            var result = SqlDataAccess.LoadData<MemberModel>(sql);
            foreach (var row in result)
            {
                return row.Member_ID;
            }
            return 0;
        }
    }
}
