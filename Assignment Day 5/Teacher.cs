using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Day_5_assignment
{
    public class Teacher : IUser
    {
        public void BorrowBook(string bookId)
        {
            Console.WriteLine("Teacher borrowed a book with ID: " + bookId);
        }

        public void ReserveBook(string bookId)
        {
            Console.WriteLine("Teacher reserved a book with ID: " + bookId);
        }

        public void ManageInventory(string action, string bookId)
        {
            throw new NotSupportedException("Teachers cannot manage inventory.");
        }
    }
}
