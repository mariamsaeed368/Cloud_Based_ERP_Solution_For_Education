using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;

namespace OTeaching
{
    public partial class Registration : System.Web.UI.Page
    {
        public bool validregistration(string registration)
        {
            if (registration.Length == 11)
            {
                string str = registration.Substring(0, 4);
                string last = registration.Substring(registration.Length - 3);
                if (str.All(Char.IsDigit))
                {
                    if (registration[4] == '-')
                    {
                        if (char.IsLetter(registration, 5) && char.IsLetter(registration, 6))
                        {
                            if (registration[7] == '-')
                            {
                                if (last.All(Char.IsDigit))
                                {
                                    return true;
                                }
                            }
                        }
                    }
                }
            }
            return false;
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnregister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (!validregistration(tbregisteration.Text))
                {
                    lblMsg.Text = "Please Enter Valid Registration number.";

                }
                else
                {
                    string CS = @"Data Source=DESKTOP-J0A56S8\SQLEXPRESS;Initial Catalog=LoginDB;Integrated Security=True";
                    using (SqlConnection con = new SqlConnection(CS))
                    {
                        con.Open();
                        SqlCommand cmd = new SqlCommand("Select Count(*) from (Select * from [LoginDB].[dbo].[StudentRegistration] where RegistrationNo='" + tbregisteration.Text + "') as x", con);
                        int row = (int)cmd.ExecuteScalar();
                        if (row < 1)
                        {
                            SqlCommand cmd2 = new SqlCommand("Select Count(*) from StudentRegistration where Username='" + tbusername.Text + "'", con);
                            int checkusername = (int)cmd2.ExecuteScalar();
                            if (checkusername < 1)
                            {
                                if (tbpass.Text == tbconfirmpass.Text)
                                {
                                    SqlCommand cmd1 = new SqlCommand("Select Count(*) from Constraints where Email='" + tbemail.Text + "'", con);
                                    int check = (int)cmd1.ExecuteScalar();
                                    if (check < 1)
                                    {
                                        SqlCommand cmd3 = new SqlCommand("Select Count(*) from Constraints where Username='" + tbusername.Text + "'", con);
                                        int check1 = (int)cmd3.ExecuteScalar();
                                        if (check1 < 1)
                                        {
                                            SqlCommand sqlCmd = new SqlCommand("spRegisterUser", con);
                                            sqlCmd.CommandType = CommandType.StoredProcedure;
                                            sqlCmd.Parameters.AddWithValue("@Name", tbname.Text);
                                            sqlCmd.Parameters.AddWithValue("@Address", tbaddress.Text);
                                            sqlCmd.Parameters.AddWithValue("@City", tbcity.Text);
                                            sqlCmd.Parameters.AddWithValue("@Username", tbusername.Text);
                                            sqlCmd.Parameters.AddWithValue("@RegistrationNo", tbregisteration.Text);
                                            sqlCmd.Parameters.AddWithValue("@Email", tbemail.Text);
                                            sqlCmd.Parameters.AddWithValue("@Password", tbpass.Text);
                                            sqlCmd.Parameters.AddWithValue("@ConfirmPassword", tbconfirmpass.Text);
                                            int ReturnCode = (int)sqlCmd.ExecuteScalar();
                                            SqlCommand cmd4 = new SqlCommand("Insert into Constraints(Email,Username) values('" + tbemail.Text + "','" + tbusername.Text + "')", con);
                                            cmd4.ExecuteNonQuery();
                                            if (ReturnCode == -1)
                                            {
                                                lblMsg.ForeColor = Color.Red;
                                                lblMsg.Text = "Email have been already used ";
                                                tbname.Text = " ";
                                                tbregisteration.Text = " ";
                                                tbpass.Text = " ";
                                                tbconfirmpass.Text = " ";
                                                tbaddress.Text = " ";
                                                tbcity.Text = " ";
                                            }
                                            else
                                            {
                                                Response.Redirect("~/StudentLogin.aspx");
                                            }
                                        }
                                        else
                                        {
                                            lblMsg.Text = "This Username is Already Registered in System.";
                                        }
                                    }
                                    else
                                    {
                                        lblMsg.Text = "This Email is already in use.";
                                    }
                                }
                                else
                                {
                                    lblMsg.Text = "Confirm Password Doesn't match with Password";
                                }
                            }
                            else
                            {
                                lblMsg.Text = "This Userame is being used by another Student.Please Try Another One.";
                            }
                        }
                        else
                        {
                            lblMsg.Text = "This Registration No is already in use.";
                        }
                    }
                }
            }
        }
    }
}