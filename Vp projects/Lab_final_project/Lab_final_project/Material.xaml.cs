using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace Lab_final_project
{
    /// <summary>
    /// Interaction logic for Material.xaml
    /// </summary>
    public partial class Material : Window
    {
        private MydbContext dbContext;

        public Material()
        {
            InitializeComponent();
            // Initialize your LINQ to SQL DataContext
            dbContext = new MydbContext("Data Source = DESKTOP-GF7QPBG\\SQLEXPRESS; Initial Catalog = Inventory; Integrated Security = True");
            //LoadData();
        }

        private void LoadData()
        {
            try
            {
                // Retrieve data from the Materials table
                var materials = dbContext.Materials.ToList();

                // Bind the data to the data grid
                dataGrid.ItemsSource = materials;
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
                // Create a new Material object with data from the textboxes
                var newMaterial = new Material // Assuming Material is your data class
                {
                    ProductsDescription = M_ProductDescription.Text,
                    MaterialName = M_MaterialName.Text,
                    Quantity = M_Quantity.Text,
                    CoverageArea = M_CoverageArea.Text,
                    Width = M_Width.Text,
                    Lengths = M_Length.Text,
                    Height = M_Height.Text,
                    E_ID = Convert.ToInt32(M_EID.Text)
                };

                // Add the newMaterial to the Materials table
                dbContext.Materials.InsertOnSubmit(newMaterial);

                // Submit changes to the database
                dbContext.SubmitChanges();

                // Optionally, clear the textboxes or provide user feedback
                ClearTextBoxes();
                MessageBox.Show("Material added successfully!");
                LoadData();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error adding material: {ex.Message}");
            }
        }

        private void Emp_Update_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Get the selected Material from the data grid
                Material selectedMaterial = (Material)dataGrid.SelectedItem;

                if (selectedMaterial != null)
                {
                    // Update properties based on user input or new data
                    selectedMaterial.ProductsDescription = M_ProductDescription.Text;
                    selectedMaterial.MaterialName = M_MaterialName.Text;
                    selectedMaterial.Quantity = M_Quantity.Text;
                    selectedMaterial.CoverageArea = M_CoverageArea.Text;
                    selectedMaterial.Width = M_Width.Text;
                    selectedMaterial.Lengths = M_Length.Text;
                    selectedMaterial.Height = M_Height.Text;
                    selectedMaterial.E_ID = Convert.ToInt32(M_EID.Text);

                    // Submit changes to the database
                    dbContext.SubmitChanges();

                    // Optionally, clear the textboxes or provide user feedback
                    ClearTextBoxes();
                    MessageBox.Show("Material updated successfully!");
                    LoadData();
                }
                else
                {
                    MessageBox.Show("Please select a material from the grid to update.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error updating material: {ex.Message}");
            }
        }

        private void Emp_Delete_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Get the selected Material from the data grid
                Material selectedMaterial = (Material)dataGrid.SelectedItem;

                if (selectedMaterial != null)
                {
                    // Remove the selectedMaterial from the Materials table
                    dbContext.Materials.DeleteOnSubmit(selectedMaterial);

                    // Submit changes to the database
                    dbContext.SubmitChanges();

                    // Optionally, clear the textboxes or provide user feedback
                    ClearTextBoxes();
                    MessageBox.Show("Material deleted successfully!");
                    LoadData();
                }
                else
                {
                    MessageBox.Show("Please select a material from the grid to delete.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error deleting material: {ex.Message}");
            }
        }

        private void ClearTextBoxes()
        {
            // Clear all textboxes
            materialid.Clear();
            M_ProductDescription.Clear();
            M_MaterialName.Clear();
            M_Quantity.Clear();
            M_CoverageArea.Clear();
            M_Width.Clear();
            M_Length.Clear();
            M_Height.Clear();
            M_EID.Clear();
        }

        private void btn_display(object sender, RoutedEventArgs e)
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
