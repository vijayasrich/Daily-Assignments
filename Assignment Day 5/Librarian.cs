using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Day_5_assignment
{
    public class Librarian : IUser
    {
        public void BorrowBook(string bookId)
        {
            Console.WriteLine("Librarian borrowed a book with ID: " + bookId);
        }

        public void ReserveBook(string bookId)
        {
            Console.WriteLine("Librarian reserved a book with ID: " + bookId);
        }

        public void ManageInventory(string action, string bookId)
        {
            if (action == "add")
                Console.WriteLine("Librarian added a book with ID: " + bookId);
            else if (action == "remove")
                Console.WriteLine("Librarian removed a book with ID: " + bookId);
            else
                throw new ArgumentException("Invalid action for managing inventory.");
        }
    }
}
