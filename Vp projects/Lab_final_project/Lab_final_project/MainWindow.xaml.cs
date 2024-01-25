using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Lab_final_project
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            WindowStartupLocation = WindowStartupLocation.CenterScreen;
        }

        private void Emp_Click(object sender, RoutedEventArgs e)
        {
            Employee emp = new Employee();
            this.Hide();
            emp.Show();

        }

        private void Client_Click(object sender, RoutedEventArgs e)
        {
            Clients cli = new Clients();
            this.Hide();
            cli.Show();

        }

        private void Projects_Click(object sender, RoutedEventArgs e)
        {
            project pro = new project();
            this.Hide();
            pro.Show();
        }

     

        private void Material_Click(object sender, RoutedEventArgs e)
        {
            Material mat = new Material();
            this.Hide();
            mat.Show(); 
        }

        private void Quo_Click(object sender, RoutedEventArgs e)
        {
            Quatation quo = new Quatation();
            this.Hide();
            quo.Show();
        }

        private void Element_Click(object sender, RoutedEventArgs e)
        {
            Element ele = new Element();
            this.Hide();
            ele.Show();
        }
    }
}
