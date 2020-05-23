using System;
using System.Collections.Generic;
using System.Text;

namespace DataLibrary.Models
{
    public class MemberModel
    {
        public int Member_ID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int Phone_Num{ get; set; }
        public int User_ID { get; set; }
        public int DVD_On_Loan { get; set; }
    }
}
