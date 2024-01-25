using System;
using System.Linq;
using System.Windows;

namespace Lab_final_project
{
    /// <summary>
    /// Interaction logic for Element.xaml
    /// </summary>
    public partial class Element : Window
    {
        private MydbContext dbContext;

        public Element()
        {
            InitializeComponent();
            // Initialize your LINQ to SQL DataContext
            dbContext = new MydbContext("Data Source = DESKTOP-GF7QPBG\\SQLEXPRESS; Initial Catalog = Inventory; Integrated Security = True");
          //  LoadData();
        }

        private void LoadData()
        {
            try
            {
                // Retrieve data from the Element table
                var elements = dbContext.Elements.ToList();

                // Bind the data to the data grid
                dataGrid.ItemsSource = elements;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error loading data: {ex.Message}");
            }
        }

        private void Ele_sub_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Create a new Element object with data from the textboxes
                var newElement = new Lab_final_project.Element
                {
                    ElementsName = txtName.Text,
                    ElementsTag = txtTag.Text
                };

                // Add the newElement to the Element table
                dbContext.Elements.InsertOnSubmit(newElement);

                // Submit changes to the database
                dbContext.SubmitChanges();

                // Optionally, clear the textboxes or provide user feedback
                ClearTextBoxes();
                MessageBox.Show("Element added successfully!");
                LoadData();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error adding element: {ex.Message}");
            }
        }

        private void ele_Update_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Get the selected Element from the data grid
                Lab_final_project.Element selectedElement = (Lab_final_project.Element)dataGrid.SelectedItem;

                if (selectedElement != null)
                {
                    // Update properties based on user input or new data
                    selectedElement.ElementsName = txtName.Text;
                    selectedElement.ElementsTag = txtTag.Text;

                    // Submit changes to the database
                    dbContext.SubmitChanges();

                    // Optionally, clear the textboxes or provide user feedback
                    ClearTextBoxes();
                    MessageBox.Show("Element updated successfully!");
                   LoadData();
                }
                else
                {
                    MessageBox.Show("Please select an element from the grid to update.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error updating element: {ex.Message}");
            }
        }

        private void ele_del_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Get the selected Element from the data grid
                Lab_final_project.Element selectedElement = (Lab_final_project.Element)dataGrid.SelectedItem;

                if (selectedElement != null)
                {
                    // Remove the selectedElement from the Element table
                    dbContext.Elements.DeleteOnSubmit(selectedElement);

                    // Submit changes to the database
                    dbContext.SubmitChanges();

                    // Optionally, clear the textboxes or provide user feedback
                    ClearTextBoxes();
                    MessageBox.Show("Element deleted successfully!");
                    LoadData();
                }
                else
                {
                    MessageBox.Show("Please select an element from the grid to delete.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error deleting element: {ex.Message}");
            }
        }

        private void ClearTextBoxes()
        {
            // Clear all textboxes
            txtID.Clear();
            txtName.Clear();
            txtTag.Clear();
        }

        private void Display_Click(object sender, RoutedEventArgs e)
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
