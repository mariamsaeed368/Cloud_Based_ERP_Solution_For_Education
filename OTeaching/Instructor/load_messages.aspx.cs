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
    public partial class load_messages : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-J0A56S8\SQLEXPRESS;Initial Catalog=LoginDB;Integrated Security=True");
        string username = " ";
        string instructorusername = " ";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            con.Open();
            username = Request.QueryString["username"].ToString();
            instructorusername = Session["Instructor_username"].ToString();

            SqlCommand cmd = con.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select * from Messages where (Susername='" + username.ToString() + "' and Dusername='"+instructorusername+"') or (Susername='"+instructorusername+"' and Dusername='" + username.ToString() + "')";
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                Response.Write("<p>");
                Response.Write(dr["Susername"].ToString() + ":" + dr["Message"].ToString());
                Response.Write("</p>");
                Response.Write("<hr>");

                if (dr["Dusername"].ToString() == instructorusername)
                {
                    SqlCommand cmd1 = con.CreateCommand();
                    cmd1.CommandType = CommandType.Text;
                    cmd1.CommandText = "update Messages set Placed='yes' where MessageID='" + dr["MessageID"].ToString() + "'";
                    cmd1.ExecuteNonQuery();
                }
            }
        }
    }
}