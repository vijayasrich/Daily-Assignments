using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Day_5_assignment
{
    public interface IUser
    {
        void BorrowBook(string bookId);
        void ReserveBook(string bookId);
        void ManageInventory(string action, string bookId);
    }
}
