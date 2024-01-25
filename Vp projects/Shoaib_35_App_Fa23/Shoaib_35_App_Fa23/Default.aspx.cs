using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace Shoaib_35_App_Fa23
{
    public partial class _Default : System.Web.UI.Page
    {
        private static string connectionString = ConfigurationManager.ConnectionStrings["shoaib"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
                BindGridView_1();
            }
        }

        private void BindGridView()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "SELECT * FROM Material";
                    string queryelementInsertQuery = "SELECT * FROM Element";

                    using (SqlDataAdapter adapter = new SqlDataAdapter(query, connection))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);

                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Literal1.Text = "Error: " + ex.Message;
            }
        }

        private void BindGridView_1()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string queryelementInsertQuery = "SELECT * FROM Element";

                    using (SqlDataAdapter adapter = new SqlDataAdapter(queryelementInsertQuery, connection))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);

                        GridView2.DataSource = dt;
                        GridView2.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Literal1.Text = "Error: " + ex.Message;
            }
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Insert into Element table first
                    string elementInsertQuery = "INSERT INTO Element (ElementsName, ElementsTag) VALUES (@ElementsName, @ElementsTag); SELECT SCOPE_IDENTITY()";

                    int lastInsertedEID;
                    using (SqlCommand cmdElement = new SqlCommand(elementInsertQuery, connection))
                    {
                        cmdElement.Parameters.AddWithValue("@ElementsName", txtElementName.Text);
                        cmdElement.Parameters.AddWithValue("@ElementsTag", txtElementtag.Text);

                        // Get the last inserted ID (E_ID)
                        lastInsertedEID = Convert.ToInt32(cmdElement.ExecuteScalar());
                    }

                    // Now insert into Material table
                    string materialInsertQuery = "INSERT INTO Material (Name, Qunatity, Price, Desription, E_ID) " +
                                                 "VALUES (@Name, @Qunatity, @Price, @Desription, @E_ID)";

                    using (SqlCommand cmdMaterial = new SqlCommand(materialInsertQuery, connection))
                    {
                        cmdMaterial.Parameters.AddWithValue("@Name", txtMaterialName.Text);
                        cmdMaterial.Parameters.AddWithValue("@Qunatity", txtQuantity.Text);
                        cmdMaterial.Parameters.AddWithValue("@Price", txtPrice.Text);
                        cmdMaterial.Parameters.AddWithValue("@Desription", txtDescription.Text);
                        cmdMaterial.Parameters.AddWithValue("@E_ID", lastInsertedEID);  // Use the retrieved identity value

                        cmdMaterial.ExecuteNonQuery();
                    }
                }

                BindGridView();
                BindGridView_1();
            }
            catch (Exception ex)
            {
                Literal1.Text = "Error: " + ex.Message;
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "DELETE FROM Material WHERE ID = @ID";

                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        cmd.Parameters.AddWithValue("@ID", txtMaterialID.Text);

                        cmd.ExecuteNonQuery();
                    }
                }

                BindGridView();
            }
            catch (Exception ex)
            {
                Literal1.Text = "Error: " + ex.Message;
            }
           
            
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "DELETE FROM Element WHERE E_ID = @E_ID";

                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        cmd.Parameters.AddWithValue("@E_ID", txtElementID.Text);

                        cmd.ExecuteNonQuery();
                    }
                

                BindGridView_1();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "SELECT * FROM Material WHERE id = @ID";

                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        cmd.Parameters.AddWithValue("@ID", txtMaterialID.Text);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtMaterialName.Text = reader["Name"].ToString();
                                txtQuantity.Text = reader["Qunatity"].ToString();
                                txtPrice.Text = reader["Price"].ToString();
                                txtDescription.Text = reader["Desription"].ToString();
                            }
                            else
                            {
                                Literal1.Text = "No record found.";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Literal1.Text = "Error: " + ex.Message;
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "UPDATE Material SET name = @Name, Qunatity = @Qunatity, " +
                                   "price = @Price, Desription = @Desription WHERE ID = @ID";

                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        cmd.Parameters.AddWithValue("@ID", txtMaterialID.Text);
                        cmd.Parameters.AddWithValue("@Name", txtMaterialName.Text);
                        cmd.Parameters.AddWithValue("@Qunatity", txtQuantity.Text);
                        cmd.Parameters.AddWithValue("@Price", txtPrice.Text);
                        cmd.Parameters.AddWithValue("@Desription", txtDescription.Text);

                        cmd.ExecuteNonQuery();
                    }
                }

                BindGridView();
               
            }
            catch (Exception ex)
            {
                Literal1.Text = "Error: " + ex.Message;
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string elementInsertQuery = "INSERT INTO Element (ElementsName, ElementsTag) VALUES (@ElementsName, @ElementsTag); SELECT SCOPE_IDENTITY()";

                int lastInsertedEID;
                using (SqlCommand cmdElement = new SqlCommand(elementInsertQuery, connection))
                {
                    cmdElement.Parameters.AddWithValue("@ElementsName", txtElementName.Text);
                    cmdElement.Parameters.AddWithValue("@ElementsTag", txtElementtag.Text);

                    lastInsertedEID = Convert.ToInt32(cmdElement.ExecuteScalar());
                }

                BindGridView_1(); // Refresh the second GridView
            }
        }
    }
}
