using System;
using System.Collections.Generic;
using System.Text;
using DataLibrary.Models;
using DataLibrary.DataAccess;

namespace DataLibrary.BusinessLogic
{
    public static class UserProcessor
    {
        public static int CreateUser(string userName,
            string email)
        {
            UserModel data = new UserModel
            {
                UserName = userName,
                Email = email
            };

            string sql = @"insert into dbo.Users(Username, Email)
                        values (@UserName, @Email);";

            return SqlDataAccess.SaveData<UserModel>(sql, data);
        }

        //UserModel is the one in the datalibrary.
        public static List<UserModel> LoadUsers()
        {
            string sql = @"Select User_ID, Username, Email from dbo.Users;";

            return SqlDataAccess.LoadData<UserModel>(sql);
        }
        
        public static int get_id(string userName)
        {
            string sql = @"Select User_ID from dbo.Users where Username = '" + userName + "'";
            var result = SqlDataAccess.LoadData<UserModel>(sql);
            foreach(var row in result)
            {
                return row.User_ID;
            }
            return 0;
        }
    }
}
