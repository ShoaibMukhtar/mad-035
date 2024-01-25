using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Data.Linq;

namespace Lab_final_project
{
    public partial class Quatation : Window
    {
        private MydbContext dbContext;

        public Quatation()
        {
            InitializeComponent();
            dbContext = new MydbContext("Data Source = DESKTOP-GF7QPBG\\SQLEXPRESS; Initial Catalog = Inventory; Integrated Security = True");
            //  LoadData();
        }

        private void GenerateBill()
        {
            try
            {
                // Get the selected Quotation from the DataGrid
                Quotation selectedQuotation = dataGrid.SelectedItem as Quotation;

                if (selectedQuotation != null)
                {
                    // Calculate total area
                    double height = Convert.ToDouble(selectedQuotation.Height);
                    double width = Convert.ToDouble(selectedQuotation.Width);
                    double totalArea = height * width;

                    // Determine rate based on the category
                    double rate = 0.0;
                    switch (selectedQuotation.Category)
                    {
                        case "System.Windows.Controls.ComboBoxItem: Basic":
                            rate = 30.0;
                            break;
                        case "System.Windows.Controls.ComboBoxItem: Classic":
                            rate = 50.0;
                            break;
                        case "System.Windows.Controls.ComboBoxItem: Luxury":
                            rate = 75.0;
                            break;
                            // Handle other cases if needed
                    }

                    // Calculate cost before tax and discount
                    double costBeforeTaxAndDiscount = totalArea * rate;

                    // Apply tax
                    double taxAmount = Convert.ToDouble(selectedQuotation.PreTaxSaleAmount);
                    double totalCost = costBeforeTaxAndDiscount + taxAmount;

                    // Apply discount
                    double discountAmount = Convert.ToDouble(selectedQuotation.Discount);
                    totalCost -= discountAmount;

                    // Display the bill details (you can modify this as per your UI)
                    MessageBox.Show($"Name: {selectedQuotation.Client.NameFirst} {selectedQuotation.Client.NameLast}\n" +
                                    $"Address: {selectedQuotation.Client.StreetAddress}, {selectedQuotation.Client.City}, {selectedQuotation.Client.Province}, {selectedQuotation.Client.Country}\n" +
                                    $"Phone: {selectedQuotation.Client.Phone}\n\n" +
                                   
                                     $"StartDate:{selectedQuotation.PreparationDate} \n" +
                                      $"ExpiryDate:{selectedQuotation.Expirydate} \n" +
                                       $"Tax:{selectedQuotation.PreTaxSaleAmount} \n" +
                                        $"Discount:{selectedQuotation.Discount} \n" +
                                    $"Total Bill: {totalCost:C}", "Bill Details", MessageBoxButton.OK, MessageBoxImage.Information);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error generating bill: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void btnGenerateBill_Click(object sender, RoutedEventArgs e)
        {
            GenerateBill();
            LoadData();
        }

        private void LoadData()
        {
            // Load data into the DataGrid
            var quotations = dbContext.GetTable<Quotation>();
            dataGrid.ItemsSource = quotations;
        }

        private void BtnAdd_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Create a new Quotation object
                Quotation newQuotation = new Quotation
                {
                    // Set properties based on your TextBoxes and ComboBox
                    ID = Convert.ToInt32(Q_ID.Text),
                    PreTaxSaleAmount = PreSaleTaxAmount.Text,
                    Discount = Discount.Text,
                    Category = proj_category_comboBox.SelectedItem?.ToString(),
                    Height = Height.Text,
                    Width = Width.Text,
                    PreparationDate = PreprationDate.Text,
                    Expirydate = ExpiryDate.Text,
                };

                // Add the new Quotation to the database
                dbContext.GetTable<Quotation>().InsertOnSubmit(newQuotation);
                dbContext.SubmitChanges();

                // Refresh the DataGrid
                LoadData();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error adding new quotation: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }


        private void BtnUpdate_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Get the selected Quotation from the DataGrid
                Quotation selectedQuotation = dataGrid.SelectedItem as Quotation;

                if (selectedQuotation != null)
                {
                    // Update properties based on your TextBoxes and ComboBox
                    selectedQuotation.PreTaxSaleAmount = PreSaleTaxAmount.Text;
                    selectedQuotation.Discount = Discount.Text;
                    selectedQuotation.Category = proj_category_comboBox.SelectedItem?.ToString();
                    selectedQuotation.Height = Height.Text;
                    selectedQuotation.Width = Width.Text;
                    selectedQuotation.PreparationDate = PreprationDate.Text;
                    selectedQuotation.Expirydate = ExpiryDate.Text;

                    // Submit the changes to the database
                    dbContext.SubmitChanges();

                    // Refresh the DataGrid
                    LoadData();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error updating quotation: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void BtnDelete_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Get the selected Quotation from the DataGrid
                Quotation selectedQuotation = dataGrid.SelectedItem as Quotation;

                if (selectedQuotation != null)
                {
                    // Remove the selected Quotation from the database
                    dbContext.GetTable<Quotation>().DeleteOnSubmit(selectedQuotation);
                    dbContext.SubmitChanges();

                    // Refresh the DataGrid
                    LoadData();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error deleting quotation: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void disp_btn_Click(object sender, RoutedEventArgs e)
        {
            LoadData();  // Display operation, you can implement it based on your requirements
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            MainWindow main = new MainWindow();
            this.Hide();
            main.Show();
        }
    }
}
