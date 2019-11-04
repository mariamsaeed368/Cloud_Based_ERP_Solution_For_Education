using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace OTeaching.Admin
{
    public partial class Instructor : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-BDBIBK1;Initial Catalog=LoginDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnDelete.Enabled = false;
                btnDelete.CssClass = "btn btn-success";

                FillGridView();

            }
        }
        public void Clear()
        {
            hfInstructorId.Value = "";

            tbname.Text = tbmobile.Text = tbaddress.Text = tbcity.Text = tbqualification.Text = tbexperience.Text=tbemail.Text=tbpass.Text="";
            lblMsg.Text = "";
            btnadd.Text = "Add";
            btnDelete.Enabled = false;

        }
        void FillGridView()
        {
            if (sqlCon.State == ConnectionState.Closed)
                try
                {
                    sqlCon.Open();
                    SqlDataAdapter sqlDa = new SqlDataAdapter("ViewAllInstructor", sqlCon);
                    sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
                    DataTable dtbl = new DataTable();
                    sqlDa.Fill(dtbl);
                    sqlCon.Close();
                    GridView1.DataSource = dtbl;
                    GridView1.DataBind();

                }
                catch (Exception ex)
                {
                    lblMsg.Text = ex.Message;
                }

        }

        protected void btnadd_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                try
                {
                    sqlCon.Open();


                    if (btnadd.Text == "Add")
                    {
                        SqlCommand sqlCmd3 = new SqlCommand("SELECT COUNT(*) FROM Instructor WHERE Email='" + tbemail.Text.Trim() + "'", sqlCon);

                        int count = Convert.ToInt32(sqlCmd3.ExecuteScalar());
                        if (count == 0)
                        {
                            SqlCommand sqlCmd = new SqlCommand("AddInstructor", sqlCon);
                            sqlCmd.CommandType = CommandType.StoredProcedure;
                            sqlCmd.Parameters.AddWithValue("@InstructorID", (hfInstructorId.Value == "" ? 0 : Convert.ToInt32(hfInstructorId.Value)));
                            sqlCmd.Parameters.AddWithValue("@Name", tbname.Text.Trim());
                            sqlCmd.Parameters.AddWithValue("@Mobile", tbmobile.Text.Trim());
                            sqlCmd.Parameters.AddWithValue("@Address", tbaddress.Text.Trim());
                            sqlCmd.Parameters.AddWithValue("@City", tbcity.Text.Trim());
                            sqlCmd.Parameters.AddWithValue("@Qualification", tbqualification.Text.Trim());
                            sqlCmd.Parameters.AddWithValue("@Experience", tbexperience.Text.Trim());
                            sqlCmd.Parameters.AddWithValue("@Email", tbemail.Text.Trim());
                            sqlCmd.Parameters.AddWithValue("@Password", tbpass.Text.Trim());
                            sqlCmd.ExecuteNonQuery();
                            string instructorID = hfInstructorId.Value;
                            Clear();

                            //   sqlCon.Close();

                            lblMsg.Text = "Added Successfully";
                        }
                        else
                        {
                            lblMsg.Text = "Email Already Exist";
                        }

                    }

                    else
                    {
                        SqlCommand sqlCmd7 = new SqlCommand("SELECT COUNT(*) FROM Instructor  WHERE Email='" + tbemail.Text.Trim() + "' AND InstructorID!='" + Convert.ToInt32(hfInstructorId.Value) + "'", sqlCon);

                        int countEdit = Convert.ToInt32(sqlCmd7.ExecuteScalar());
                        if (countEdit == 0)
                        {
                            SqlCommand sqlCmd1 = new SqlCommand("EditInstructor", sqlCon);
                            sqlCmd1.CommandType = CommandType.StoredProcedure;
                            sqlCmd1.Parameters.AddWithValue("@InstructorID", (hfInstructorId.Value == "" ? 0 : Convert.ToInt32(hfInstructorId.Value)));
                            sqlCmd1.Parameters.AddWithValue("@Name", tbname.Text.Trim());
                            sqlCmd1.Parameters.AddWithValue("@Mobile", tbmobile.Text.Trim());
                            sqlCmd1.Parameters.AddWithValue("@Address", tbaddress.Text.Trim());
                            sqlCmd1.Parameters.AddWithValue("@City", tbcity.Text.Trim());
                            sqlCmd1.Parameters.AddWithValue("@Qualification", tbqualification.Text.Trim());
                            sqlCmd1.Parameters.AddWithValue("@Experience", tbexperience.Text.Trim());
                            sqlCmd1.Parameters.AddWithValue("@Email", tbemail.Text.Trim());
                            sqlCmd1.Parameters.AddWithValue("@Password", tbpass.Text.Trim());
                            sqlCmd1.ExecuteNonQuery();
                            string instructorID = hfInstructorId.Value;




                            if (instructorID != "")
                                lblMsg.Text = "Updated Succesfully";
                        }
                        else
                        {
                           lblMsg.Text = "Email Already Exist";
                        }

                    }

                    sqlCon.Close();
                    Clear();
                    FillGridView();

                }
                catch (Exception ex)
                {
                    lblMsg.Text = ex.Message;
                }



        }
        protected void lnk_OnClick(object sender, EventArgs e)
        {
            int instructorId = Convert.ToInt32((sender as LinkButton).CommandArgument);

            if (sqlCon.State == ConnectionState.Closed)
                try
                {

                    sqlCon.Open();
                    SqlDataAdapter sqlDa = new SqlDataAdapter("ViewInstructorByID", sqlCon);
                    sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
                    sqlDa.SelectCommand.Parameters.AddWithValue("@InstructorID", instructorId);

                    DataTable dtbl = new DataTable();
                    sqlDa.Fill(dtbl);
                    sqlCon.Close();
                    hfInstructorId.Value = instructorId.ToString();

                    tbname.Text = dtbl.Rows[0]["Name"].ToString();
                    tbmobile.Text = dtbl.Rows[0]["Mobile"].ToString();
                    tbaddress.Text = dtbl.Rows[0]["Address"].ToString();
                    tbcity.Text = dtbl.Rows[0]["City"].ToString();
                    tbqualification.Text = dtbl.Rows[0]["Qualification"].ToString();
                    tbexperience.Text = dtbl.Rows[0]["Experience"].ToString();
                    tbemail.Text = dtbl.Rows[0]["Email"].ToString();
                    tbpass.Text = dtbl.Rows[0]["Password"].ToString();
                    btnadd.Text = "Update";
                    btnDelete.Enabled = true;

                }
                catch (Exception ex)
                {
                    lblMsg.Text = ex.Message;
                }
        }       
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                try
                {
                    sqlCon.Open();
                    SqlCommand sqlCmd = new SqlCommand("DeleteInstructorByID", sqlCon);
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.Parameters.AddWithValue("@InstructorID", Convert.ToInt32(hfInstructorId.Value));
                    sqlCmd.ExecuteNonQuery();

                    sqlCon.Close();

                    FillGridView();
                    lblMsg.Text = "Deleted Successfully";
                    Clear();
                }
                catch (Exception ex)
                {
                    lblMsg.Text = ex.Message;
                }

        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }
    }
}