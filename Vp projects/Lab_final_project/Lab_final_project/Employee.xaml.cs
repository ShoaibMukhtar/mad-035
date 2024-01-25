using System;
using System.Collections.Generic;
using System.Linq; // Add this using directive
using System.Windows;
using System.Data.Linq;


namespace Lab_final_project
{
    public partial class MydbContext : DataContext
    {
        

       
    }

    public partial class Employee : Window
    {
        private MydbContext dbContext;

        public Employee()
        {
            InitializeComponent();
            // Initialize your LINQ to SQL DataContext
           dbContext = new MydbContext("Data Source = DESKTOP-GF7QPBG\\SQLEXPRESS; Initial Catalog = Inventory; Integrated Security = True");
            // Use your actual DataContext type
        //   LoadData();
        }
        private void LoadData()
        {
            try
            {
                // Retrieve data from the Employee table
                var employees = dbContext.GetTable<Lab_final_project.Employee>().ToList();

                // Clear existing items in the data grid
                dataGrid.ItemsSource = null;

                // Bind the new data to the data grid
                dataGrid.ItemsSource = employees;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error loading data: {ex.Message}");
            }
        }


        private void Emp_Add_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Create a new Employee object with data from the textboxes
                var newEmployee = new Lab_final_project.Employee
                {
                    NameFirst = Emp_FirstName.Text,
                    NameLast = Emp_LastName.Text,
                    Designation = Emp_Designation.Text,
                    Gender = Emp_Gender.Text,
                    HiredDate = Emp_HiredDate.Text,
                    TerminationDate = Emp_TerminateDate.Text,
                    IsActive = Emp_IsActive.Text,
                    StreetAddress = Emp_StreetAddress.Text,
                    City = Emp_City.Text,
                    Province = Emp_Province.Text,
                    Country = Emp_Country.Text,
                    Phone = Emp_Phone.Text,
                    Email = Emp_Email.Text
                };

                // Add the newEmployee to the Employee table
                dbContext.GetTable<Lab_final_project.Employee>().InsertOnSubmit(newEmployee);

                // Submit changes to the database
                dbContext.SubmitChanges();

                // Optionally, clear the textboxes or provide user feedback
                ClearTextBoxes();
                MessageBox.Show("Employee added successfully!");
                LoadData();
                
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error adding employee: {ex.Message}");
            }
        }

        private void ClearTextBoxes()
        {
            // Clear all textboxes
            Emp_FirstName.Clear();
            Emp_LastName.Clear();
            Emp_Designation.Clear();
            Emp_Gender.Clear();
            Emp_HiredDate.Clear();
            Emp_TerminateDate.Clear();
            Emp_IsActive.Clear();
            Emp_StreetAddress.Clear();
            Emp_City.Clear();
            Emp_Province.Clear();
            Emp_Country.Clear();
            Emp_Phone.Clear();
            Emp_Email.Clear();
        }

        private void Emp_Update_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Get the selected Employee from the data grid
                Lab_final_project.Employee selectedEmployee = (Lab_final_project.Employee)dataGrid.SelectedItem;

                if (selectedEmployee != null)
                {
                    // Update properties based on user input or new data
                    selectedEmployee.NameFirst = Emp_FirstName.Text;
                    selectedEmployee.NameLast = Emp_LastName.Text;
                    selectedEmployee.Designation = Emp_Designation.Text;
                    // ... (update other properties)

                    // Submit changes to the database
                    dbContext.SubmitChanges();

                    // Optionally, clear the textboxes or provide user feedback
                    ClearTextBoxes();
                    MessageBox.Show("Employee updated successfully!");
                    LoadData();
                }
                else
                {
                    MessageBox.Show("Please select an employee from the grid to update.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error updating employee: {ex.Message}");
            }
        }

        private void Emp_Delete_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Get the selected Employee from the data grid
                Lab_final_project.Employee selectedEmployee = (Lab_final_project.Employee)dataGrid.SelectedItem;

                if (selectedEmployee != null)
                {
                    // Remove the selectedEmployee from the Employee table
                    dbContext.GetTable<Lab_final_project.Employee>().DeleteOnSubmit(selectedEmployee);

                    // Submit changes to the database
                    dbContext.SubmitChanges();

                    // Optionally, clear the textboxes or provide user feedback
                    ClearTextBoxes();
                    MessageBox.Show("Employee deleted successfully!");
                    LoadData();
                }
                else
                {
                    MessageBox.Show("Please select an employee from the grid to delete.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error deleting employee: {ex.Message}");
            }
        }

        private void Emp_Disp_Click(object sender, RoutedEventArgs e)
        {
            LoadData();
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            MainWindow main = new MainWindow();
            this.Hide();
            main.Show();
        }
    }
}
