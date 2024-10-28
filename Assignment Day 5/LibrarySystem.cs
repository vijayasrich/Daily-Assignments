using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Day_5_assignment
{
    public class LibrarySystem
    {
        private readonly IUser _currentUser;

        public LibrarySystem(IUser user)
        {
            _currentUser = user;
        }

        public void BorrowBook(string bookId)
        {
            _currentUser.BorrowBook(bookId);
        }

        public void ReserveBook(string bookId)
        {
            _currentUser.ReserveBook(bookId);
        }

        public void ManageInventory(string action, string bookId)
        {
            _currentUser.ManageInventory(action, bookId);
        }
    }

}
