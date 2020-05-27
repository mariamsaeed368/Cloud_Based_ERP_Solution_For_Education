using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace OTeaching
{
    public partial class StudentLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.Cookies["EMAIL"] != null && Request.Cookies["PWD"] != null)
                {
                    tbemail.Text = Request.Cookies["EMAIL"].Value; // move the values from cookies to text box
                    tbpass.Attributes["value"] = Request.Cookies["PWD"].Value;
                    CheckBox1.Checked = true;
                }
            }
        }

        protected void btnlogin_Click(object sender, EventArgs e)
        {
            string CS = @"Data Source=DESKTOP-J0A56S8\SQLEXPRESS;Initial Catalog=LoginDB;Integrated Security=True";
            using (SqlConnection con = new SqlConnection(CS))
            {

                SqlCommand read = new SqlCommand("Select * from StudentRegistration where Email='" + tbemail.Text + "' and Password='" + tbpass.Text + "'", con);
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(read);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                if (dt.Rows.Count != 0)
                {
                    if (CheckBox1.Checked)
                    {
                        Response.Cookies["EMAIL"].Value = tbemail.Text;
                        Response.Cookies["PWD"].Value = tbpass.Text;
                        //after that specific day the cookies will disable
                        Response.Cookies["EMAIL"].Expires = DateTime.Now.AddDays(15);
                        Response.Cookies["PWD"].Expires = DateTime.Now.AddDays(15);
                    }
                    //if the user dont want to store the password  
                    else
                    {
                        Response.Cookies["EMAIL"].Expires = DateTime.Now.AddDays(-1);
                        Response.Cookies["PWD"].Expires = DateTime.Now.AddDays(-1);
                    }
                        Session["EMAIL"] = tbemail.Text;
                        SqlCommand cmd = new SqlCommand("Select RegistrationNo from StudentRegistration where Email='" + tbemail.Text + "'", con);
                        string registration_no = cmd.ExecuteScalar().ToString();
                        Session["Registration_No"] = registration_no;
                        SqlCommand cmd1 = new SqlCommand("Select Username from StudentRegistration where Email='" + tbemail.Text + "'", con);
                        string Student_username = cmd1.ExecuteScalar().ToString();
                        Session["Student_Username"] = Student_username;
                        Response.Redirect("~/Student/StudentCourse.aspx");
                }
                else
                {
                    lblError.Text = "Invalid Email or Password";
                }
            }
        }

        protected void forgetpass_Click(object sender, EventArgs e)
        {
            Response.Redirect("ResetPassword.aspx");
        }
    }
}