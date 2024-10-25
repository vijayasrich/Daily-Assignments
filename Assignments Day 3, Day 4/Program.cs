#region 11
/*11) Create a Book and Author class with suitable properties and Hardcoded with Minimum 5 data for both the classes and
 covert into Json and XML Format  and store that data in Local Disk using File  concept .
 Read the Json and XML data and display the same in console App

using System;
using System.Collections.Generic;
using System.IO;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Xml.Serialization;

namespace BookAuthorSerializationApp
{
    public class Book
    {
        public int BookId { get; set; }
        public string Title { get; set; }
        public string Genre { get; set; }
        public int AuthorId { get; set; }
    }
    public class Author
    {
        public int AuthorId { get; set; }
        public string Name { get; set; }
        public string Nationality { get; set; }
    }
    class Program
    {
        static void Main()
        {
           
            string basePath = @"C:\Users\VIJJI\Documents\HEXAWARE";
            string jsonAuthorPath = Path.Combine(basePath, "authors.json");
            string jsonBookPath = Path.Combine(basePath, "books.json");
            string xmlAuthorPath = Path.Combine(basePath, "authors.xml");
            string xmlBookPath = Path.Combine(basePath, "books.xml");
            if (!Directory.Exists(basePath))
            {
                Directory.CreateDirectory(basePath);
            }
            List<Author> authors = new List<Author>
            {
                new Author { AuthorId = 1, Name = "George Orwell", Nationality = "British" },
                new Author { AuthorId = 2, Name = "J.K. Rowling", Nationality = "British" },
                new Author { AuthorId = 3, Name = "Harper Lee", Nationality = "American" },
                new Author { AuthorId = 4, Name = "J.R.R. Tolkien", Nationality = "British" },
                new Author { AuthorId = 5, Name = "Agatha Christie", Nationality = "British" }
            };
            List<Book> books = new List<Book>
            {
                new Book { BookId = 1, Title = "1984", Genre = "Dystopian", AuthorId = 1 },
                new Book { BookId = 2, Title = "Harry Potter", Genre = "Fantasy", AuthorId = 2 },
                new Book { BookId = 3, Title = "To Kill a Mockingbird", Genre = "Fiction", AuthorId = 3 },
                new Book { BookId = 4, Title = "The Hobbit", Genre = "Fantasy", AuthorId = 4 },
                new Book { BookId = 5, Title = "Murder on the Orient Express", Genre = "Mystery", AuthorId = 5 }
            };
            string jsonAuthorData = JsonSerializer.Serialize(authors, new JsonSerializerOptions { WriteIndented = true });
            string jsonBookData = JsonSerializer.Serialize(books, new JsonSerializerOptions { WriteIndented = true });

            File.WriteAllText(jsonAuthorPath, jsonAuthorData);
            File.WriteAllText(jsonBookPath, jsonBookData);

            XmlSerializer xmlAuthorSerializer = new XmlSerializer(typeof(List<Author>));
            XmlSerializer xmlBookSerializer = new XmlSerializer(typeof(List<Book>));

            using (StreamWriter sw = new StreamWriter(xmlAuthorPath))
            {
                xmlAuthorSerializer.Serialize(sw, authors);
            }
            using (StreamWriter sw = new StreamWriter(xmlBookPath))
            {
                xmlBookSerializer.Serialize(sw, books);
            }

            // Deserialize JSON
            string readJsonAuthorData = File.ReadAllText(jsonAuthorPath);
            string readJsonBookData = File.ReadAllText(jsonBookPath);
            List<Author> deserializedAuthors = JsonSerializer.Deserialize<List<Author>>(readJsonAuthorData);
            List<Book> deserializedBooks = JsonSerializer.Deserialize<List<Book>>(readJsonBookData);

            // Deserialize XML
            List<Author> deserializedAuthorsXml;
            List<Book> deserializedBooksXml;

            using (StreamReader sr = new StreamReader(xmlAuthorPath))
            {
                deserializedAuthorsXml = (List<Author>)xmlAuthorSerializer.Deserialize(sr);
            }
            using (StreamReader sr = new StreamReader(xmlBookPath))
            {
                deserializedBooksXml = (List<Book>)xmlBookSerializer.Deserialize(sr);
            }

            
            Console.WriteLine("JSON Author Data:");
            foreach (var author in deserializedAuthors)
            {
                Console.WriteLine($"AuthorId: {author.AuthorId}, Name: {author.Name}, Nationality: {author.Nationality}");
            }

            Console.WriteLine("\nJSON Book Data:");
            foreach (var book in deserializedBooks)
            {
                Console.WriteLine($"BookId: {book.BookId}, Title: {book.Title}, Genre: {book.Genre}, AuthorId: {book.AuthorId}");
            }

            Console.WriteLine("\nXML Author Data:");
            foreach (var author in deserializedAuthorsXml)
            {
                Console.WriteLine($"AuthorId: {author.AuthorId}, Name: {author.Name}, Nationality: {author.Nationality}");
            }

            Console.WriteLine("\nXML Book Data:");
            foreach (var book in deserializedBooksXml)
            {
                Console.WriteLine($"BookId: {book.BookId}, Title: {book.Title}, Genre: {book.Genre}, AuthorId: {book.AuthorId}");
            }
            Console.ReadLine();
        }
    }
}*/
#endregion
#region 12
/*12) create a Customer class with the below properties
    public string Name { get; set; }
    public string Email { get; set; }
    public string PhoneNumber { get; set; }
    public DateTime DateOfBirth { get; set; }
create a separate class to validate PhoneNumber, Email,DOB using some function which should return bool (true if valid ,False if invalid)*/

/*using System;
using System.Text.RegularExpressions;

namespace CustomerValidationApp
{
    // Customer class with properties
    public class Customer
    {
        public string Name { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public DateTime DateOfBirth { get; set; }
    }

    // CustomerValidator class with validation methods
    public static class CustomerValidator
    {
        // Validate Email format
        public static bool ValidateEmail(string email)
        {
            if (string.IsNullOrWhiteSpace(email))
                return false;

            // Regular expression pattern for a simple email validation
            string emailPattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
            return Regex.IsMatch(email, emailPattern);
        }

        // Validate PhoneNumber format (e.g., for a 10-digit phone number)
        public static bool ValidatePhoneNumber(string phoneNumber)
        {
            if (string.IsNullOrWhiteSpace(phoneNumber))
                return false;

            // Regex pattern for a 10-digit phone number
            string phonePattern = @"^\d{10}$";
            return Regex.IsMatch(phoneNumber, phonePattern);
        }

        // Validate Date of Birth (e.g., must be 18 years or older)
        public static bool ValidateDateOfBirth(DateTime dob)
        {
            DateTime today = DateTime.Today;
            int age = today.Year - dob.Year;

            // Adjust age if the birthday hasn't occurred yet this year
            if (dob.Date > today.AddYears(-age)) age--;

            return age >= 18;
        }
    }

    class Program
    {
        static void Main()
        {
            // Sample customer data
            Customer customer = new Customer
            {
                Name = "Aara C",
                Email = "aara.cexample.com",
                PhoneNumber = "1234567891",
                DateOfBirth = new DateTime(2003,6,1)
            };

            // Validating Customer data
            bool isEmailValid = CustomerValidator.ValidateEmail(customer.Email);
            bool isPhoneNumberValid = CustomerValidator.ValidatePhoneNumber(customer.PhoneNumber);
            bool isDOBValid = CustomerValidator.ValidateDateOfBirth(customer.DateOfBirth);

            // Output validation results
            Console.WriteLine($"Email Valid: {isEmailValid}");
            Console.WriteLine($"Phone Number Valid: {isPhoneNumberValid}");
            Console.WriteLine($"Date of Birth Valid: {isDOBValid}");
            Console.ReadLine();
        }
    }
}*/

#endregion
#region 13
/*13 )Create a TransportSchedule class with properties like TransportType (bus or flight), Route, DepartureTime, ArrivalTime, Price, and SeatsAvailable.
 
Create a TransportManager class to manage a list of transport schedules.
LINQ Operations:
Search: Find schedules by transport type, route, or time.
Group By: Group schedules by transport type (bus or flight).
Order By: Order schedules by departure time, price, or seats available.
Filter: Filter schedules based on availability of seats or routes within a time range.
Aggregate: Calculate the total number of available seats and the average price of transport.
Select: Project a list of routes and their departure times.*/


/*using System;
using System.Collections.Generic;
using System.Linq;

namespace TransportScheduleApp
{
    public class TransportSchedule
    {
        public string TransportType { get; set; }
        public string Route { get; set; }
        public DateTime DepartureTime { get; set; }
        public DateTime ArrivalTime { get; set; }
        public decimal Price { get; set; }
        public int SeatsAvailable { get; set; }
    }

    public class TransportManager
    {
        private List<TransportSchedule> schedules;

        public TransportManager()
        {
            schedules = new List<TransportSchedule>();
        }

       
        public void AddSchedule(TransportSchedule schedule)
        {
            schedules.Add(schedule);
        }

        // LINQ Operations
        // Search schedules by transport type, route, or time
        public IEnumerable<TransportSchedule> SearchSchedules(string transportType = null, string route = null, DateTime? time = null)
        {
            return schedules.Where(s =>
                (transportType == null || s.TransportType.Equals(transportType, StringComparison.OrdinalIgnoreCase)) &&
                (route == null || s.Route.Equals(route, StringComparison.OrdinalIgnoreCase)) &&
                (time == null || s.DepartureTime == time));
        }
        // Group schedules by transport type
        public IEnumerable<IGrouping<string, TransportSchedule>> GroupByTransportType()
        {
            return schedules.GroupBy(s => s.TransportType);
        }
        // Order schedules by departure time, price, or seats available
        public IEnumerable<TransportSchedule> OrderSchedules(string orderBy)
        {
            if (orderBy == "DepartureTime")
            {
                return schedules.OrderBy(s => s.DepartureTime);
            }
            else if (orderBy == "Price")
            {
                return schedules.OrderBy(s => s.Price);
            }
            else if (orderBy == "SeatsAvailable")
            {
                return schedules.OrderBy(s => s.SeatsAvailable);
            }
            else
            {
                return schedules; // Default case: return unsorted schedules
            }
        }
        // Filter schedules by availability of seats and within a time range
        public IEnumerable<TransportSchedule> FilterSchedules(int minSeats = 0, DateTime? startTime = null, DateTime? endTime = null)
        {
            return schedules.Where(s =>
                s.SeatsAvailable >= minSeats &&
                (startTime == null || s.DepartureTime >= startTime) &&
                (endTime == null || s.ArrivalTime <= endTime));
        }
        // Aggregate operation to calculate total seats available and average price
        public (int totalSeats, decimal averagePrice) CalculateAggregate()
        {
            int totalSeats = schedules.Sum(s => s.SeatsAvailable);
            decimal averagePrice = schedules.Any() ? schedules.Average(s => s.Price) : 0; // Handle division by zero
            return (totalSeats, averagePrice);
        }
        // Select projection of routes and their departure times
        public IEnumerable<(string Route, DateTime DepartureTime)> SelectRoutesAndDepartureTimes()
        {
            return schedules.Select(s => (s.Route, s.DepartureTime));
        }
    }

    class Program
    {
        static void Main()
        {
            
            TransportManager manager = new TransportManager();
            manager.AddSchedule(new TransportSchedule { TransportType = "Bus", Route = "Ongole-Chennai", DepartureTime = DateTime.Parse("2024-10-25 08:00"), ArrivalTime = DateTime.Parse("2024-10-25 10:00"), Price = 1500, SeatsAvailable = 20 });
            manager.AddSchedule(new TransportSchedule { TransportType = "Bus", Route = "Ongole-Banglore", DepartureTime = DateTime.Parse("2024-10-25 09:00"), ArrivalTime = DateTime.Parse("2024-10-25 11:00"), Price = 1850, SeatsAvailable = 15 });
            manager.AddSchedule(new TransportSchedule { TransportType = "Flight", Route = "Chennai-Hyderabad", DepartureTime = DateTime.Parse("2024-10-25 14:00"), ArrivalTime = DateTime.Parse("2024-10-25 15:30"), Price = 7500, SeatsAvailable = 5 });
            manager.AddSchedule(new TransportSchedule { TransportType = "Flight", Route = "Banglore-Hyderabad", DepartureTime = DateTime.Parse("2024-10-25 16:00"), ArrivalTime = DateTime.Parse("2024-10-25 17:30"), Price = 9500, SeatsAvailable = 2 });
            manager.AddSchedule(new TransportSchedule { TransportType = "Bus", Route = "Ongole-Chennai", DepartureTime = DateTime.Parse("2024-10-25 12:00"), ArrivalTime = DateTime.Parse("2024-10-25 14:00"), Price = 1600, SeatsAvailable = 10 });

            // 1. Search schedules by transport type
            var searchResults = manager.SearchSchedules(transportType: "Bus");
            Console.WriteLine("Search Results by Transport Type (Bus):");
            foreach (var schedule in searchResults)
            {
                Console.WriteLine($"Route: {schedule.Route}, Departure: {schedule.DepartureTime}, Price: {schedule.Price:n}");
            }

            // 2. Group schedules by transport type
            var groupedSchedules = manager.GroupByTransportType();
            Console.WriteLine("\nGrouped Schedules by Transport Type:");
            foreach (var group in groupedSchedules)
            {
                Console.WriteLine($"Transport Type: {group.Key}");
                foreach (var schedule in group)
                {
                    Console.WriteLine($"  Route: {schedule.Route}, Departure: {schedule.DepartureTime}, Seats: {schedule.SeatsAvailable}");
                }
            }

            // 3. Order schedules by departure time
            var orderedSchedules = manager.OrderSchedules("DepartureTime");
            Console.WriteLine("\nOrdered Schedules by Departure Time:");
            foreach (var schedule in orderedSchedules)
            {
                Console.WriteLine($"Route: {schedule.Route}, Departure: {schedule.DepartureTime}, Price: {schedule.Price:n}");
            }

            // 4. Filter schedules by availability of seats
            var filteredSchedules = manager.FilterSchedules(minSeats: 10, startTime: DateTime.Parse("2024-10-25 08:00"), endTime: DateTime.Parse("2024-10-25 13:00"));
            Console.WriteLine("\nFiltered Schedules with min 10 seats and time range 08:00-13:00:");
            foreach (var schedule in filteredSchedules)
            {
                Console.WriteLine($"Route: {schedule.Route}, Departure: {schedule.DepartureTime}, Seats: {schedule.SeatsAvailable}");
            }

            // 5. Aggregate operation to calculate total seats and average price
            var aggregateResult = manager.CalculateAggregate();
            Console.WriteLine($"\nTotal Seats Available: {aggregateResult.totalSeats}");
            Console.WriteLine($"Average Price of Transport: {aggregateResult.averagePrice:n}");

            // 6. Select projection of routes and their departure times
            var routeTimes = manager.SelectRoutesAndDepartureTimes();
            Console.WriteLine("\nRoutes and Departure Times:");
            foreach (var (Route, DepartureTime) in routeTimes)
            {
                Console.WriteLine($"Route: {Route}, Departure Time: {DepartureTime}");
            }
            Console.ReadLine();
        }
    }
}
*/
#endregion
