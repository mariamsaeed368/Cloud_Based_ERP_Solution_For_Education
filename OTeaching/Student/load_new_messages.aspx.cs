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
    public partial class load_new_messages : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-BDBIBK1;Initial Catalog=LoginDB;Integrated Security=True");
        string message = " ";
        string username = " ";
        int count = 0;
        string studentusername = " ";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            con.Open();
            studentusername = Session["Student_Username"].ToString();
            username = Request.QueryString["username"].ToString();
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandType = CommandType.Text;
            //it means we are going to load new messages only
            cmd.CommandText = " Select * from Messages where Dusername='" + studentusername + "' and Placed='no'";
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                count = count + 1;
                if (count == 1)
                {
                    message = dr["Susername"].ToString() + ":" + dr["Message"].ToString();
                }
                else
                {
                    //if in 10 secconds we are getting multiple messages then
                    message = message + "||abcd||" + dr["Susername"].ToString() + ":" + dr["Message"].ToString();
                }
                SqlCommand cmd1 = con.CreateCommand();
                cmd1.CommandType = CommandType.Text;
                //it means we are going to load new messages only
                cmd1.CommandText = "Update Messages set Placed='yes' where MessageID='" + dr["MessageID"].ToString() + "'";
                cmd1.ExecuteNonQuery();
            }
            if (count == 0)
            {
                Response.Write("0");
            }
            else
            {
                Response.Write(message.ToString());
            }
        }
    }
}