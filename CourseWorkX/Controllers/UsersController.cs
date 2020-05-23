using CourseWorkX.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DataLibrary.BusinessLogic;
using System.Threading.Tasks;
using DataLibrary.DataAccess;
using DataLibrary.Models;
using System.Security.Permissions;
using System.Configuration;
using System.Security.Cryptography;
using Microsoft.Ajax.Utilities;
using Antlr.Runtime.Tree;

namespace CourseWorkX.Controllers
{
    public class UsersController : Controller
    {
        // GET: Users
        public ActionResult Index(int id, int mem_id)
        {
            if (User.Identity.IsAuthenticated)
            {                
                var user = User.Identity;
                ViewBag.Name = user.Name;
                ViewBag.id = id;
                ViewBag.mem_id = mem_id;
                ViewBag.displayMenu = "No";

                if (isAdminUser())
                {
                    ViewBag.displayMenu = "Yes";
                }
                return View();
            }
            else
            {
                ViewBag.Name = "Not Logged IN";

            }
            return View();

        }
        public Boolean isAdminUser()
        {
            if (User.Identity.IsAuthenticated)
            {
                var user = User.Identity;
                ApplicationDbContext context = new ApplicationDbContext();
                var UserManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));
                var s = UserManager.GetRoles(user.GetUserId());
                if (s[0].ToString() == "Admin")
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            return false;
        }
        
        
        public ActionResult Main()
        {
            return View();
        }


        [Authorize(Roles = "Manager")]
        public ActionResult Insert()
        {
            string[] s = { "Hip Hop", "Pop", "Musical", "Folk Music", "Jazz", "Blues", "Rock", "Singing", "World", "Pop", "Dubstep", "Others" };
            List<string> lst = new List<string>(s);
            ViewBag.Genres = new SelectList(lst);

            string sql = @"Select Studio_ID, Studio_Name from dbo.Studio_Details;";

            List<StudioModel> std = SqlDataAccess.LoadData<StudioModel>(sql);
            List<string> std_name = new List<string>();
            foreach(StudioModel row in std)
            {
                std_name.Add(row.Studio_Name);
                
            }
            ViewBag.Studio = new SelectList(std_name);
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Insert(DvdViewModel model)
        {
            string[] s = { "Hip Hop", "Pop", "Musical", "Folk Music", "Jazz", "Blues","Rock","Singing", "World","Pop", "Dubstep", "Others"};
            List<string> lst = new List<string>(s);
            ViewBag.Genres = new SelectList(lst);

            List<StudioModel> std = StudioProcessor.LoadStudio();
            List<string> std_name = new List<string>();
            foreach (StudioModel row in std)
            {
                std_name.Add(row.Studio_Name);
            }
            ViewBag.Studio = new SelectList(std_name);


            if (ModelState.IsValid)
            {
                CastProcessor.CreateCast(model.Cast_Fname, model.Cast_Lname);
                int cast_id_f = CastProcessor.get_id_fname(model.Cast_Fname);
                
                StudioProcessor.CreateStudio(model.Studio_Name);
                int studio_id = StudioProcessor.get_id(model.Studio_Name);
                
                ProducerProcessor.CreateProducer(model.Producer_Name);
                int producer_id = ProducerProcessor.get_id(model.Producer_Name);
                
                DVDProcessor.insertDVD(model.Title, model.Genres, model.Stock, model.Year, model.Month, model.Day, cast_id_f, studio_id, producer_id);
                
                return RedirectToAction("Main","Users");
            }
            return Content("Hello");
        }

        public ActionResult ListMusic()
        {
            string sql = @"select Dvd_ID, Title, Genres, Stock, date_added, FirstName, LastName,
                        Studio_Name, Producer_Name from dbo.DVD_Detail d inner join dbo.Studio_Details c on
                        d.Studio_ID = c.Studio_ID  inner join dbo.Cast_Details s on 
                        d.Cast_ID = s.Cast_ID inner join dbo.Producer_Details p on
                        d.Producer_ID = p.Producer_ID;";
            List<ListModel> lst = SqlDataAccess.LoadData<ListModel>(sql);
            return View(lst);
        }

        [HttpPost]
        public ActionResult Search(string search_box, string search_by)
        {
            if (search_by == "Last Name")
            {
                string sql = @"select Dvd_ID, Title, Genres, Stock, date_added, FirstName, LastName,
                        Studio_Name, Producer_Name from dbo.DVD_Detail d inner join dbo.Studio_Details c on
                        d.Studio_ID = c.Studio_ID  inner join dbo.Cast_Details s on 
                        d.Cast_ID = s.Cast_ID inner join dbo.Producer_Details p on
                        d.Producer_ID = p.Producer_ID where LastName = '" + search_box+"';";
                List<ListModel> lst = SqlDataAccess.LoadData<ListModel>(sql);
                return View(lst);
            }

            if (search_by == "Title")
            {
                string sql = @"select Dvd_ID, Title, Genres, Stock, date_added, FirstName, LastName,
                        Studio_Name, Producer_Name from dbo.DVD_Detail d inner join dbo.Studio_Details c on
                        d.Studio_ID = c.Studio_ID  inner join dbo.Cast_Details s on 
                        d.Cast_ID = s.Cast_ID inner join dbo.Producer_Details p on
                        d.Producer_ID = p.Producer_ID where Title = '" + search_box + "';";
                List<ListModel> lst = SqlDataAccess.LoadData<ListModel>(sql);
                return View(lst);
            }
            return Content(search_by);
        }

        public ActionResult Loan()
        {
            string sql = @"select Loan_ID, Date_out, Amount_paid, Date_returned, Penalty_Charge, FirstName, LastName, User_ID, Title 
                        from dbo.Loan l inner join dbo.Member m on
                        l.Member_ID = m.Member_ID  inner join dbo.DVD_Detail d on 
                        l.Dvd_ID = d.Dvd_ID;";
            List<LoanModel> loan_list = SqlDataAccess.LoadData<LoanModel>(sql);
            return View(loan_list);
        }
        
        [HttpPost]
        public ActionResult Loan_History(string search_box, string search_by)
        {
            if (search_by == "Last_Name")
            {
                string sql = @"select Loan_ID, Date_out, Amount_paid, Date_returned, Penalty_Charge, FirstName, LastName, User_ID, Title 
                        from dbo.Loan l inner join dbo.Member m on
                        l.Member_ID = m.Member_ID  inner join dbo.DVD_Detail d on 
                        l.Dvd_ID = d.Dvd_ID where LastName = '" + search_box + "';";
                List<LoanModel> lst = SqlDataAccess.LoadData<LoanModel>(sql);
                return View(lst);
            }

            if (search_by == "Title")
            {
                string sql = @"select Loan_ID, Date_out, Amount_paid, Date_returned, Penalty_Charge, FirstName, LastName, User_ID, Title 
                        from dbo.Loan l inner join dbo.Member m on
                        l.Member_ID = m.Member_ID  inner join dbo.DVD_Detail d on 
                        l.Dvd_ID = d.Dvd_ID where Title = '" + search_box + "';";
                List<LoanModel> lst = SqlDataAccess.LoadData<LoanModel>(sql);
                return View(lst);
            }
            return Content(search_by);
        }

        public ActionResult Issue_DVD(int id)
        {
            return View();
        }

        [HttpPost]
        public ActionResult Issue_DVD(LoanViewModel ld, int id)
        {
            Console.WriteLine("Hello there!!");

            int mem_id = 0 ;
            string sql_member = @"select Member_ID from dbo.Member where FirstName = '" + ld.FirstName + "' AND LastName = '" + ld.LastName + "';";
            List<int> lst = SqlDataAccess.LoadData<int>(sql_member);
            foreach (int row in lst)
            {
                mem_id = row;
                break;
            }

            string sql_check = @"select Loan_ID from dbo.Loan where Member_ID = "+mem_id+";";
            List<int> num = SqlDataAccess.LoadData<int>(sql_check);

            if (num.Count > 5)
            {
                return RedirectToAction("Limit_Exceeded", "Users");
            }

            else
            {
                string today = DateTime.Today.ToString("yyyy-MM-dd");
                LoanIssueModel iss = new LoanIssueModel();
                iss.Date_out = today;
                iss.Amount_paid = 100;
                iss.Date_returned = null;
                iss.Penalty_Charge = 0;
                iss.Dvd_ID = id;
                iss.Member_ID = mem_id;

                string sql_member2 = @"select * from dbo.Member where Member_ID = " + mem_id + ";";
                List<MemberModel> memlist = SqlDataAccess.LoadData<MemberModel>(sql_member2);
                MemberModel mem = new MemberModel();
                foreach (MemberModel row in memlist)
                {
                    mem = row;
                    break;
                }

                mem.DVD_On_Loan = mem.DVD_On_Loan + 1;
                string sql_member3 = @"UPDATE dbo.Member SET DVD_On_Loan = @DVD_On_Loan WHERE Member_ID = @Member_ID;";
                int result1 = SqlDataAccess.SaveData(sql_member3, mem);


                string sql_loan = @"insert into dbo.Loan(Date_out, Amount_paid, Date_returned, Penalty_Charge, Dvd_ID, Member_ID)
                        values (@Date_out, @Amount_paid, @Date_returned, @Penalty_Charge, @Dvd_ID, @Member_ID);";

                int result = SqlDataAccess.SaveData(sql_loan, iss);

                

                

                return RedirectToAction("Main", "Users");
            }
        }


        public ActionResult Return_DVD(int id)
        {
            string sql_member = @"select * from dbo.Loan where Loan_ID = "+id+";";
            string today = DateTime.Today.ToString("yyyy-MM-dd");
            string issue_date= "";

            LoanIssueModel lm = new LoanIssueModel();
            List<LoanIssueModel> lst = SqlDataAccess.LoadData<LoanIssueModel>(sql_member);
            foreach (LoanIssueModel row in lst)
            {
                lm = row;
                break;
            }

            // updating the member database
            int mem_id = lm.Member_ID;
            string sql_member2 = @"select * from dbo.Member where Member_ID = " + mem_id + ";";

            List<MemberModel> memlist = SqlDataAccess.LoadData<MemberModel>(sql_member2);
            MemberModel mem = new MemberModel();
            foreach (MemberModel row in memlist)
            {
                mem = row;
                break;
            }

            mem.DVD_On_Loan = mem.DVD_On_Loan - 1;
            string sql_mem_update = @"UPDATE dbo.Member SET DVD_On_Loan = @DVD_On_Loan WHERE Member_ID = @Member_ID;";
            int result2 = SqlDataAccess.SaveData(sql_mem_update, mem);
            
            

            /*
             * if (lm.Date_returned != null)
            {
                today = lm.Date_returned;
            }
            */

            issue_date = lm.Date_out;
            int penalty = Convert.ToInt32((DateTime.Parse(today) - DateTime.Parse(issue_date)).TotalDays);
            if(penalty > 30)
            {
                penalty = penalty - 30;
            }
            else
            {
                penalty = 0;
            }
            
            string sql_update = @"UPDATE dbo.Loan SET Date_returned = '"+today+"', Penalty_Charge = "+penalty+" WHERE Loan_ID = "+id+";";
            int result = SqlDataAccess.SaveData(sql_update, lm);
            
            return RedirectToAction("Loan", "Users");
        }

        public ActionResult Limit_Exceeded()
        {
            return View();
        }

        public ActionResult UserList()
        {
            string sql_aspuser = @"select id, UserName from dbo.AspNetUsers;";
            string sql_user = @"select User_ID, Username, Email from dbo.Users;";
            string sql_asp_user_roles = @"select UserId, RoleId from dbo.AspNetUserRoles;";
            string sql_asp_roles = @"select Id, Name from dbo.AspNetRoles;";
            string sql_member = @"select * from dbo.Member;";

            
            List<UserAspModel> lst = AspDataAccess.LoadData<UserAspModel>(sql_aspuser);
            List<AspUserRoles> user_roles = AspDataAccess.LoadData<AspUserRoles>(sql_asp_user_roles);
            List<AspRoles> roles = AspDataAccess.LoadData<AspRoles>(sql_asp_roles);
            List<UserModel> um = SqlDataAccess.LoadData<UserModel>(sql_user);
                      
            
            List<MemberModel> member = SqlDataAccess.LoadData<MemberModel>(sql_member);

            List<UserViewModel> demo = (from l in lst
                             join u in um on l.UserName equals u.UserName 
                             select new UserViewModel()
                             {
                                 First_Name = l.UserName,
                                 Last_Name = l.UserName == u.UserName ? u.Email : null,
                                 Role = l.id,
                                 DVD_On_Loan = l.UserName == u.UserName ? u.User_ID : 0
                             }).ToList();

            List<UserViewModel> demo2 = (from u in user_roles
                                         join r in roles on u.RoleId equals r.Id
                                         select new UserViewModel()
                                         {
                                             First_Name = r.Name,
                                             Last_Name = null,
                                             Role = u.UserId,
                                             DVD_On_Loan = 0
                                         }).ToList();

            List<UserViewModel> user = (from d1 in demo
                                            join d2 in demo2 on d1.Role equals d2.Role
                                            select new UserViewModel()
                                            {
                                                Role = d2.First_Name,
                                                First_Name = d1.First_Name,
                                                Last_Name = null,
                                                DVD_On_Loan = d1.DVD_On_Loan
                                            }).ToList();

            List<UserViewModel> userlist = (from u in user
                                            join m in member on u.DVD_On_Loan equals m.User_ID
                                            select new UserViewModel()
                                            {
                                                First_Name = m.FirstName,
                                                Last_Name = m.LastName,
                                                Role = u.Role,
                                                DVD_On_Loan = m.DVD_On_Loan
                                            }).ToList();
            

            return View(userlist);
        }
    }
}