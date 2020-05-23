using System;
using System.Collections.Generic;
using System.Text;
using DataLibrary.Models;
using DataLibrary.DataAccess;

namespace DataLibrary.BusinessLogic
{
    public class StudioProcessor
    {
        public static int CreateStudio(string studio_name)
        {
            StudioModel data = new StudioModel
            {
                Studio_Name = studio_name
            };

            string sql = @"insert into dbo.Studio_Details(Studio_Name)
                        values (@Studio_Name);";

            return SqlDataAccess.SaveData<StudioModel>(sql, data);
        }

        //EmployeeModel is the one in the datalibrary.
        public static List<StudioModel> LoadStudio()
        {
            string sql = @"Select Studio_ID, Studio_Name from dbo.Studio_Details;";

            return SqlDataAccess.LoadData<StudioModel>(sql);
        }

        public static int get_id(string studio_name)
        {
            string sql = @"Select Studio_ID from dbo.Studio_Details where Studio_Name = '" + studio_name + "'";
            var result = SqlDataAccess.LoadData<StudioModel>(sql);
            foreach (var row in result)
            {
                return row.Studio_ID;
            }
            return 0;
        }
    }
}
