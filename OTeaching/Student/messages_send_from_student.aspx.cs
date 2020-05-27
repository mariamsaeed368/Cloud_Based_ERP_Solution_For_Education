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
    public partial class messages_send_from_student : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-J0A56S8\SQLEXPRESS;Initial Catalog=LoginDB;Integrated Security=True");
        string username = " ";
        string message = " ";
        string studentusername = " ";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            con.Open();
            username = Request.QueryString["Instructorusername"].ToString();
            studentusername = Session["Student_Username"].ToString();
            message = Request.QueryString["message"].ToString();

            SqlCommand cmd = con.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into Messages values('" + studentusername.ToString() + "','" + username.ToString() + "','" + message.ToString() + "','no')";
            cmd.ExecuteNonQuery();
        }
    }
}