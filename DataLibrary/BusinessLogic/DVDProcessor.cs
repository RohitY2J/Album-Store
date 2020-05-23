using System;
using System.Collections.Generic;
using System.Text;
using DataLibrary.Models;
using DataLibrary.DataAccess;

namespace DataLibrary.BusinessLogic
{
    public class DVDProcessor
    {
        public static int insertDVD(string title, string genre,
            int stock, int year, int month, int day, int cast_id, int studio_id, int producer_id)
        { 
            DVDModel data = new DVDModel
            {
                Title = title,
                Genres = genre,
                Stock = stock,
                date_added = year.ToString()+'-'+month.ToString()+'-'+day.ToString(),
                Cast_ID = cast_id,
                Studio_ID = studio_id,
                Producer_ID = producer_id
            };

            string sql = @"insert into dbo.DVD_Detail(Title, Genres, Stock, date_added, Cast_ID, Studio_ID, Producer_ID)
                        values (@Title, @Genres, @Stock, @date_added, @Cast_ID, @Studio_ID, @Producer_ID);";

            return SqlDataAccess.SaveData<DVDModel>(sql, data);
        }

        //EmployeeModel is the one in the datalibrary.
        public static List<DVDModel> LoadDVD()
        {
            string sql = @"Select * from dbo.DVD_Detail;";

            return SqlDataAccess.LoadData<DVDModel>(sql);
        }
    }
}
