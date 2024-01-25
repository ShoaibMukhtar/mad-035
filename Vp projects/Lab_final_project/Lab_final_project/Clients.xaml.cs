using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;

namespace Lab_final_project
{
    public partial class Clients : Window
    {
        private MydbContext dbContext;

        public Clients()
        {
            InitializeComponent();
            dbContext = new MydbContext("Data Source = DESKTOP-GF7QPBG\\SQLEXPRESS; Initial Catalog = Inventory; Integrated Security = True");
        }

        private void LoadData()
        {
            // Load client data into the data grid
            dataGrid.ItemsSource = dbContext.Clients.ToList();
        }

        private void BtnAdd_Click(object sender, RoutedEventArgs e)
        {
            // Create a new client
            Client newClient = new Client
            {
                NameFirst = txtFirstName.Text,
                NameLast = txtLastName.Text,
                StreetAddress = txtStreetAddress.Text,
                City = txtCity.Text,
                Province = txtProvince.Text,
                Country = txtCountry.Text,
                Phone = txtPhone.Text,
                Email = txtEmail.Text
            };

            // Add the new client to the database
            dbContext.Clients.InsertOnSubmit(newClient);
            dbContext.SubmitChanges();

            // Refresh the data grid
            LoadData();

            // Clear the input fields
            ClearInputFields();
        }

        private void BtnUpdate_Click(object sender, RoutedEventArgs e)
        {
            if (dataGrid.SelectedItem != null)
            {
                // Get the selected client
                Client selectedClient = (Client)dataGrid.SelectedItem;

                // Update client information
                selectedClient.NameFirst = txtFirstName.Text;
                selectedClient.NameLast = txtLastName.Text;
                selectedClient.StreetAddress = txtStreetAddress.Text;
                selectedClient.City = txtCity.Text;
                selectedClient.Province = txtProvince.Text;
                selectedClient.Country = txtCountry.Text;
                selectedClient.Phone = txtPhone.Text;
                selectedClient.Email = txtEmail.Text;

                // Submit changes to the database
                dbContext.SubmitChanges();

                // Refresh the data grid
                LoadData();

                // Clear the input fields
                ClearInputFields();
            }
            else
            {
                MessageBox.Show("Please select a client to update.");
            }
        }

        private void BtnDelete_Click(object sender, RoutedEventArgs e)
        {
            if (dataGrid.SelectedItem != null)
            {
                // Get the selected client
                Client selectedClient = (Client)dataGrid.SelectedItem;

                // Remove the client from the database
                dbContext.Clients.DeleteOnSubmit(selectedClient);
                dbContext.SubmitChanges();

                // Refresh the data grid
                LoadData();

                // Clear the input fields
                ClearInputFields();
            }
            else
            {
                MessageBox.Show("Please select a client to delete.");
            }
        }

        private void ClearInputFields()
        {
            txtFirstName.Text = string.Empty;
            txtLastName.Text = string.Empty;
            txtStreetAddress.Text = string.Empty;
            txtCity.Text = string.Empty;
            txtProvince.Text = string.Empty;
            txtCountry.Text = string.Empty;
            txtPhone.Text = string.Empty;
            txtEmail.Text = string.Empty;
        }

        private void Cli_Add_Copy_Click(object sender, RoutedEventArgs e)
        {
            MainWindow main = new MainWindow();
            this.Hide();
            main.Show();
        }

        private void Display_Click(object sender, RoutedEventArgs e)
        {
            LoadData();
        }
    }
}
