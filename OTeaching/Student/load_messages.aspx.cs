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
    public partial class load_messages : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-SI0GDUH\SQLEXPRESS;Initial Catalog=loginDB;Integrated Security=True");
        string studentusername = " ";
        string instructorusername = " ";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            con.Open();
            studentusername = Session["Student_Username"].ToString();
            instructorusername = Request.QueryString["username"].ToString();
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select * from Messages where (Susername='" + studentusername.ToString() + "' and Dusername='"+instructorusername.ToString()+"') or (Susername='"+instructorusername.ToString()+"' and Dusername='" + studentusername.ToString() + "')";
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

                if (dr["Dusername"].ToString() == studentusername.ToString())
                {
                    SqlCommand cmd1 = con.CreateCommand();
                    cmd1.CommandType = CommandType.Text;
                    cmd1.CommandText = "Update Messages Set Placed='yes' where MessageID='" + dr["MessageID"].ToString() + "'";
                    cmd1.ExecuteNonQuery();
                }
            }
        }
    }
}