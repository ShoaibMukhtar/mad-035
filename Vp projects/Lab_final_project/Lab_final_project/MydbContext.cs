using System;
using System.Data.Linq;
using System.Data.Linq.Mapping;
using System.Windows.Controls;

namespace Lab_final_project
{
    [Table(Name = "Employee")]
    public partial class Employee
    {
        [Column(IsPrimaryKey = true, IsDbGenerated = true, Name = "Emp_ID")]
        public int Emp_ID { get; set; }

        [Column(Name = "NameFirst")]
        public string NameFirst { get; set; }

        [Column(Name = "NameLast")]
        public string NameLast { get; set; }

        [Column(Name = "Designation")]
        public string Designation { get; set; }

        [Column(Name = "Gender")]
        public string Gender { get; set; }

        [Column(Name = "HiredDate")]
        public string HiredDate { get; set; }

        [Column(Name = "TerminationDate")]
        public string TerminationDate { get; set; }

        [Column(Name = "IsActive")]
        public string IsActive { get; set; }

        [Column(Name = "StreetAddress")]
        public string StreetAddress { get; set; }

        [Column(Name = "City")]
        public string City { get; set; }

        [Column(Name = "Province")]
        public string Province { get; set; }

        [Column(Name = "Country")]
        public string Country { get; set; }

        [Column(Name = "Phone")]
        public string Phone { get; set; }

        [Column(Name = "Email")]
        public string Email { get; set; }
    }



    [Table(Name = "Projects")]
    public partial class Project
    {
        [Column(IsPrimaryKey = true, IsDbGenerated = true, Name = "P_ID")]
        public int P_ID { get; set; }

       

        [Column(Name = "Project_Title")]
        public string Project_Title { get; set; }

        [Column(Name = "Project_Description")]
        public string Project_Description { get; set; }

        [Column(Name = "Statuses")]
        public string Statuses { get; set; }

        [Column(Name = "StartDate")]
        public string StartDate { get; set; }

        [Column(Name = "CompletionDate")]
        public string CompletionDate { get; set; }

        public static explicit operator Project(TextBox v)
        {
            throw new NotImplementedException();
        }
    }

    [Table(Name = "Quotation")]
    public partial class Quotation
    {
        [Column(IsPrimaryKey = true, IsDbGenerated = true, Name = "Q_id")]
        public int Q_id { get; set; }

        [Column(Name = "ID")]
        public int? ID { get; set; }

        [Association(Storage = "_client", ThisKey = "ID", OtherKey = "ID", IsForeignKey = true)]
        public Client Client
        {
            get { return _client.Entity; }
            set { _client.Entity = value; }
        }
        private EntityRef<Client> _client;

        [Column(Name = "PreTaxSaleAmount")]
        public string PreTaxSaleAmount { get; set; }

        [Column(Name = "Discount")]
        public string Discount { get; set; }

        [Column(Name = "Category")]
        public string Category { get; set; }

        [Column(Name = "Height")]
        public string Height { get; set; }

        [Column(Name = "Width")]
        public string Width { get; set; }

        [Column(Name = "preparationDate")]
        public string PreparationDate { get; set; }

        [Column(Name = "Expirydate")]
        public string Expirydate { get; set; }

    }



    [Table(Name = "Clients")]
    public partial class Client
    {
        [Column(IsPrimaryKey = true, IsDbGenerated = true, Name = "ID")]
        public int ID { get; set; }

        [Column(Name = "NameFirst")]
        public string NameFirst { get; set; }

        [Column(Name = "NameLast")]
        public string NameLast { get; set; }

        [Column(Name = "StreetAddress")]
        public string StreetAddress { get; set; }

        [Column(Name = "City")]
        public string City { get; set; }

        [Column(Name = "Province")]
        public string Province { get; set; }

        [Column(Name = "Country")]
        public string Country { get; set; }

        [Column(Name = "Phone")]
        public string Phone { get; set; }

        [Column(Name = "Email")]
        public string Email { get; set; }
    }

    [Table(Name = "Materials")]
    public partial class Material
    {
        [Column(IsPrimaryKey = true, IsDbGenerated = true, Name = "M_ID")]
        public int M_ID { get; set; }

        [Column(Name = "ProductsDescription")]
        public string ProductsDescription { get; set; }

        [Column(Name = "MaterialName")]
        public string MaterialName { get; set; }

        [Column(Name = "Quantity")]
        public string Quantity { get; set; }

        [Column(Name = "CoverageArea")]
        public string CoverageArea { get; set; }

        [Column(Name = "Width")]
        public string Width { get; set; }

        [Column(Name = "Lengths")]
        public string Lengths { get; set; }

        [Column(Name = "Height")]
        public string Height { get; set; }

        [Column(Name = "E_ID")]
        public int E_ID { get; set; }

        [Association(Storage = "_element", ThisKey = "E_ID", OtherKey = "E_ID", IsForeignKey = true)]
        public Element Element
        {
            get { return _element.Entity; }
            set { _element.Entity = value; }
        }
        private EntityRef<Element> _element;
    }

    [Table(Name = "Element")]
    public partial class Element
    {
        [Column(IsPrimaryKey = true, IsDbGenerated = true, Name = "E_ID")]
        public int E_ID { get; set; }

        [Column(Name = "ElementsName")]
        public string ElementsName { get; set; }

        [Column(Name = "ElementsTag")]
        public string ElementsTag { get; set; }
    }

    public partial class MydbContext : DataContext
    {
        public Table<Employee> Employees;
        public Table<Project> Projects;
        public Table<Quotation> Quotations;
        public Table<Client> Clients;
        public Table<Material> Materials;
        public Table<Element> Elements;

        public MydbContext(string connection) : base(connection)
        {
            Employees = GetTable<Employee>();
            Projects = GetTable<Project>();
            Quotations = GetTable<Quotation>();
            Clients = GetTable<Client>();
            Materials = GetTable<Material>();
            Elements = GetTable<Element>();
        }
    }
}
