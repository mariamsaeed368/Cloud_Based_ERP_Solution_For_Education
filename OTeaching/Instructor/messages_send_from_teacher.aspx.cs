using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace OTeaching.Instructor
{
    public partial class messages_send_from_teacher : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-SI0GDUH\SQLEXPRESS;Initial Catalog=loginDB;Integrated Security=True");
        string username = " ";
        string message = " ";
        string instructorusername = " ";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            con.Open();
            username = Request.QueryString["Studentusername"].ToString();
            instructorusername = Session["Instructor_username"].ToString();
            message = Request.QueryString["message"].ToString();


            SqlCommand cmd = con.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into Messages values('" + instructorusername.ToString() + "','" + username.ToString() + "','" + message.ToString() + "','no')";
            cmd.ExecuteNonQuery();
        }
    }
}