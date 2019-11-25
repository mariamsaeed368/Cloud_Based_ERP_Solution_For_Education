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
    public partial class AdminLogin : System.Web.UI.Page
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
            if (tbemail.Text == "admin@gmail.com" && tbpass.Text == "admin")
            {
                 Response.Redirect("~/Admin/Welcome.aspx");

            }
            else
            {
                lblError.Text = "Invalid Email or Password";
            }
        }
    }
}