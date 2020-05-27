using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace OTeaching.Student
{
    public partial class Student : System.Web.UI.MasterPage
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-J0A56S8\SQLEXPRESS;Initial Catalog=LoginDB;Integrated Security=True");
        string username = " ";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            con.Open();
            username = Session["Student_Username"].ToString();
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select * from Messages where Dusername='" + username + "' and Placed='no'";
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(dt);
            int count = 0;
            count = Convert.ToInt32(dt.Rows.Count.ToString());
            notification.Text = count.ToString();
            notification2.Text = count.ToString();
            r1.DataSource = dt;
            r1.DataBind();
        }
        public string Get20characters(object myvalues)
        {
            string a;
            a = Convert.ToString(myvalues.ToString());
            string b = "";
            if (a.Length > 15)
            {
                b = a.Substring(0, 15);
                return b.ToString() + "...";
            }
            else
            {
                b = a.ToString();
                return b.ToString();
            }
        }
    }
}