using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Day_5_assignment
{
    class Program
    {
        static void Main()
        {
            IUser student = new Student();

            try
            {
                student.BorrowBook("123"); 
                student.ReserveBook("456");
            }
            catch (NotSupportedException ex)
            {
                Console.WriteLine(ex.Message); 
            }

            IUser teacher = UserFactory.CreateUser("Teacher");
            LibrarySystem librarySystemTeacher = new LibrarySystem(teacher);

            librarySystemTeacher.BorrowBook("456");
            librarySystemTeacher.ReserveBook("789");

            IUser librarian = UserFactory.CreateUser("Librarian");
            LibrarySystem librarySystemLibrarian = new LibrarySystem(librarian);

            librarySystemLibrarian.ManageInventory("add", "123");
            librarySystemLibrarian.ManageInventory("remove", "456");
            Console.ReadLine();
        }
    }

}
