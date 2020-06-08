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
    public partial class TeacherLogin : System.Web.UI.Page
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
            string CS = @"Data Source=DESKTOP-BDBIBK1;Initial Catalog=LoginDB;Integrated Security=True";
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand read = new SqlCommand("Select * from Instructor where Email='" + tbemail.Text + "' and Password='" + tbpass.Text + "'", con);
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
                    SqlCommand cmd = new SqlCommand("Select Username from Instructor where Email='" + tbemail.Text + "'", con);
                    string username = cmd.ExecuteScalar().ToString();
                    SqlCommand cmd1 = new SqlCommand("Select InstructorID from Instructor where Email='" + tbemail.Text + "'", con);
                    string id = cmd1.ExecuteScalar().ToString();
                    Session["InstructorID"] = id;
                    Session["Instructor_username"] = username;
                    Response.Redirect("~/Instructor/AssignedInstructorCourse.aspx");
                }
                else
                {
                    lblError.Text = "Invalid Email or Password";
                }
            }
        }
    }
}