using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Day_5_assignment
{
    public class Student : IUser
    {
        public void BorrowBook(string bookId)
        {
            Console.WriteLine("Student borrowed a book with ID: " + bookId);
        }

        public void ReserveBook(string bookId)
        {
            throw new NotSupportedException("Students cannot reserve books.");
        }

        public void ManageInventory(string action, string bookId)
        {
            throw new NotSupportedException("Students cannot manage inventory.");
        }
    }

    

   
}
