using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Day_5_assignment
{
    public static class UserFactory
    {
        public static IUser CreateUser(string userType)
        {
            switch (userType)
            {
                case "Student":
                    return new Student();
                case "Teacher":
                    return new Teacher();
                case "Librarian":
                    return new Librarian();
                default:
                    throw new ArgumentException("Invalid user type.");
            }
        }
    }

}
