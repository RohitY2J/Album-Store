using System;
using System.Collections.Generic;
using System.Text;

namespace DataLibrary.Models
{
    //needed to for data acess as employee model
    // in models of our web app is not suitable 
    // for eg : it consist of annotations that are not
    //needed.
    public class EmployeeModel
    {
        public int Id { get; set; }
        public int EmployeeId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }

    }

}
