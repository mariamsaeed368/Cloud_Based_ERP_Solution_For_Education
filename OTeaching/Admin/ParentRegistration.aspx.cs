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
    public partial class ParentRegistration : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-BDBIBK1;Initial Catalog=LoginDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnDelete.Enabled = false;
                btnDelete.CssClass = "btn btn-danger";

                FillGridView();

            }
        }
        public void Clear()
        {
            hfGaurdianId.Value = "";

            tbname.Text = tbmobile.Text = tbaddress.Text = tbcity.Text = tbincome.Text = tbcnic.Text = tbemail.Text = tbpass.Text = "";
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
                    SqlDataAdapter sqlDa = new SqlDataAdapter("ViewAllGaurdian", sqlCon);
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
                        SqlCommand cmd1 = new SqlCommand("Select Count(*) from Constraints where Email='" + tbemail.Text + "'", sqlCon);
                        int check = (int)cmd1.ExecuteScalar();
                        if (check < 1)
                        {
                            SqlCommand cmd2 = new SqlCommand("Select Count(*) from Constraints where CNIC='" + tbcnic.Text + "'", sqlCon);
                            int check1 = (int)cmd2.ExecuteScalar();
                            if(check1 < 1)
                            {
                                SqlCommand cmd3 = new SqlCommand("Select Count(*) from Constraints where Mobile='" + tbmobile.Text + "'", sqlCon);
                                int check2 = (int)cmd3.ExecuteScalar();
                                if (check2 < 1)
                                {
                                    SqlCommand sqlCmd4 = new SqlCommand("SELECT COUNT(*) FROM Gaurdian WHERE CNIC='" + tbcnic.Text.Trim() + "'", sqlCon);
                                    int count = Convert.ToInt32(sqlCmd4.ExecuteScalar());
                                    if (count == 0)
                                    {
                                        SqlCommand sqlCmd3 = new SqlCommand("SELECT COUNT(*) FROM Gaurdian WHERE Mobile='" + tbmobile.Text.Trim() + "'", sqlCon);
                                        int count1 = Convert.ToInt32(sqlCmd3.ExecuteScalar());
                                        if (count1 == 0)
                                        {
                                            SqlCommand sqlCmd5 = new SqlCommand("SELECT COUNT(*) FROM Gaurdian WHERE Email='" + tbemail.Text.Trim() + "'", sqlCon);
                                            int count3 = Convert.ToInt32(sqlCmd5.ExecuteScalar());
                                            if (count3 == 0)
                                            {
                                                SqlCommand sqlCmd = new SqlCommand("AddGaurdian", sqlCon);
                                                sqlCmd.CommandType = CommandType.StoredProcedure;
                                                sqlCmd.Parameters.AddWithValue("@GaurdianID", (hfGaurdianId.Value == "" ? 0 : Convert.ToInt32(hfGaurdianId.Value)));
                                                sqlCmd.Parameters.AddWithValue("@Name", tbname.Text.Trim());
                                                sqlCmd.Parameters.AddWithValue("@Address", tbaddress.Text.Trim());
                                                sqlCmd.Parameters.AddWithValue("@Mobile", tbmobile.Text.Trim());
                                                sqlCmd.Parameters.AddWithValue("@City", tbcity.Text.Trim());
                                                sqlCmd.Parameters.AddWithValue("@Income", tbincome.Text.Trim());
                                                sqlCmd.Parameters.AddWithValue("@CNIC", tbcnic.Text.Trim());
                                                sqlCmd.Parameters.AddWithValue("@Email", tbemail.Text.Trim());
                                                sqlCmd.Parameters.AddWithValue("@Password", tbpass.Text.Trim());
                                                sqlCmd.ExecuteNonQuery();
                                                SqlCommand cmd4 = new SqlCommand("Insert into Constraints(Email,CNIC,Mobile) values('" + tbemail.Text + "','" + tbcnic.Text + "','" + tbmobile.Text + "')", sqlCon);
                                                cmd4.ExecuteNonQuery();
                                                string gaurdianID = hfGaurdianId.Value;
                                                Clear();
                                                lblMsg.Text = "Added Successfully";
                                            }
                                            else
                                            {
                                                lblMsg.Text = "Email is already in use.";
                                            }
                                        }
                                        else
                                        {
                                            lblMsg.Text = "Mobile Number is already in use.";
                                        }
                                    }
                                    else
                                    {
                                        lblMsg.Text = "CNIC is already in use.";
                                    }
                                }
                                else
                                {
                                    lblMsg.Text = "Mobile Number Already Exist.";
                                }        
                            }
                            else
                            {
                                lblMsg.Text = "CNIC Already Exist.";
                            }  
                        }
                        else
                        {
                            lblMsg.Text = "Email Already Exist";
                        }
                    }
                    else
                    {
                        SqlCommand sqlCmd7 = new SqlCommand("SELECT COUNT(*) FROM Gaurdian WHERE Email='" + tbemail.Text.Trim() + "' AND GaurdianID!='" + Convert.ToInt32(hfGaurdianId.Value) + "'", sqlCon);
                        int countEdit = Convert.ToInt32(sqlCmd7.ExecuteScalar());
                        if (countEdit == 0)
                        {
                            SqlCommand cmd2 = new SqlCommand("Delete from Constraints where Email='" + tbemail.Text + "' AND CNIC='"+tbcnic.Text+"' AND Mobile='"+tbmobile.Text+"'", sqlCon);
                            cmd2.ExecuteNonQuery();
                            SqlCommand sqlCmd1 = new SqlCommand("EditGaurdian", sqlCon);
                            sqlCmd1.CommandType = CommandType.StoredProcedure;
                            sqlCmd1.Parameters.AddWithValue("@GaurdianID", (hfGaurdianId.Value == "" ? 0 : Convert.ToInt32(hfGaurdianId.Value)));
                            sqlCmd1.Parameters.AddWithValue("@Name", tbname.Text.Trim());
                            sqlCmd1.Parameters.AddWithValue("@Address", tbaddress.Text.Trim());
                            sqlCmd1.Parameters.AddWithValue("@Mobile", tbmobile.Text.Trim());
                            sqlCmd1.Parameters.AddWithValue("@City", tbcity.Text.Trim());
                            sqlCmd1.Parameters.AddWithValue("@Income", tbincome.Text.Trim());
                            sqlCmd1.Parameters.AddWithValue("@CNIC", tbcnic.Text.Trim());
                            sqlCmd1.Parameters.AddWithValue("@Email", tbemail.Text.Trim());
                            sqlCmd1.Parameters.AddWithValue("@Password", tbpass.Text.Trim());
                            sqlCmd1.ExecuteNonQuery();
                            SqlCommand cmd3 = new SqlCommand("Insert into Constraints(Email,CNIC,Mobile) values('" + tbemail.Text + "','"+tbcnic.Text+"','"+tbmobile.Text+"')", sqlCon);
                            cmd3.ExecuteNonQuery();
                            string gaurdianID = hfGaurdianId.Value;
                            if (gaurdianID != " ")
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
            int gaurdianId = Convert.ToInt32((sender as LinkButton).CommandArgument);

            if (sqlCon.State == ConnectionState.Closed)
                try
                {

                    sqlCon.Open();
                    SqlDataAdapter sqlDa = new SqlDataAdapter("ViewGaurdianByID", sqlCon);
                    sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
                    sqlDa.SelectCommand.Parameters.AddWithValue("@GaurdianID", gaurdianId);
                    DataTable dtbl = new DataTable();
                    sqlDa.Fill(dtbl);
                    sqlCon.Close();
                    hfGaurdianId.Value = gaurdianId.ToString();

                    tbname.Text = dtbl.Rows[0]["Name"].ToString();
                    tbaddress.Text = dtbl.Rows[0]["Address"].ToString();
                    tbmobile.Text = dtbl.Rows[0]["Mobile"].ToString();
                    tbcity.Text = dtbl.Rows[0]["City"].ToString();
                    tbincome.Text = dtbl.Rows[0]["Income"].ToString();
                    tbcnic.Text = dtbl.Rows[0]["CNIC"].ToString();
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
        protected void lnkrelationwithstudent_OnClick(object sender, EventArgs e)
        {
            int gaurdianid = Convert.ToInt32((sender as LinkButton).CommandArgument);
            Session["gaurdianid"] = gaurdianid;
            Response.Redirect("StudentParentRelationship.aspx");
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                try
                {
                    sqlCon.Open();
                    SqlCommand cmd2 = new SqlCommand("Delete from Constraints where Email='" + tbemail.Text + "' AND CNIC='"+tbcnic.Text+"' AND Mobile='"+tbmobile.Text+"'", sqlCon);
                    cmd2.ExecuteNonQuery();
                    SqlCommand sqlCmd = new SqlCommand("DeleteGaurdianByID", sqlCon);
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.Parameters.AddWithValue("@GaurdianID", Convert.ToInt32(hfGaurdianId.Value));
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

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            FillGridView(); //bindgridview will get the data source and bind it again
        }
    }
}