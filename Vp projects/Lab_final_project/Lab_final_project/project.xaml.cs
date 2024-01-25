using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Data.Linq;

namespace Lab_final_project
{
    public partial class project : Window
    {
        private MydbContext dbContext;

        public project()
        {
            InitializeComponent();
            dbContext = new MydbContext("Data Source=DESKTOP-GF7QPBG\\SQLEXPRESS;Initial Catalog=Inventory;Integrated Security=True");
            LoadData();
        }

        private void LoadData()
        {
            var projects = dbContext.Projects.ToList();
            dataGrid.ItemsSource = projects;
        }

        private void BtnAdd_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                Project newProject = new Project
                {
                   
                    Project_Title = txtLastName.Text,
                    Project_Description = txtStreetAddress.Text,
                    Statuses = txtCity.Text,
                    StartDate = txtProvince.Text,
                    CompletionDate = txtCountry.Text
                };

                dbContext.Projects.InsertOnSubmit(newProject);
                dbContext.SubmitChanges();

                LoadData();
                ClearInputs();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error adding project: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void BtnUpdate_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                Project selectedProject = (Project)dataGrid.SelectedItem;

                if (selectedProject != null)
                {
                   
                    selectedProject.Project_Title = txtLastName.Text;
                    selectedProject.Project_Description = txtStreetAddress.Text;
                    selectedProject.Statuses = txtCity.Text;
                    selectedProject.StartDate = txtProvince.Text;
                    selectedProject.CompletionDate = txtCountry.Text;

                    dbContext.SubmitChanges();
                    LoadData();
                    ClearInputs();
                }
                else
                {
                    MessageBox.Show("Please select a project to update.", "Warning", MessageBoxButton.OK, MessageBoxImage.Warning);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error updating project: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void BtnDelete_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                Project selectedProject = (Project)dataGrid.SelectedItem;

                if (selectedProject != null)
                {
                    dbContext.Projects.DeleteOnSubmit(selectedProject);
                    dbContext.SubmitChanges();
                    LoadData();
                    ClearInputs();
                }
                else
                {
                    MessageBox.Show("Please select a project to delete.", "Warning", MessageBoxButton.OK, MessageBoxImage.Warning);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error deleting project: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void ClearInputs()
        {
           // txtFirstName.Text = string.Empty;
            txtLastName.Text = string.Empty;
            txtStreetAddress.Text = string.Empty;
            txtCity.Text = string.Empty;
            txtProvince.Text = string.Empty;
            txtCountry.Text = string.Empty;
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
