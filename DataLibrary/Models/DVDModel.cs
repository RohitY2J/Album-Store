using System;
using System.Collections.Generic;
using System.Text;

namespace DataLibrary.Models
{
    public class DVDModel
    {
        public string Dvd_ID { get; set; }
        public string Title { get; set; }
        public string Genres { get; set; }
        public int Stock { get; set; }
        public string date_added { get; set; }
        public int Cast_ID { get; set; }
        public int Studio_ID { get; set; }
        public int Producer_ID { get; set; }
    }
}
