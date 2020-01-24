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
    public partial class AvailableTests : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-BDBIBK1;Initial Catalog=LoginDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select ex.ExamID,ex.ExamName,ex.ExamDescription,ex.ExamDuration,ex.ExamMarks,ex.ExamPassingMarks from Exam ex Join ClassCourse c on ex.ClassCourseID=c.ClassCourseID join Class cl on cl.ClassID=c.ClassID";
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            sqlCon.Close();
        }
        protected void lnktest_OnClick(object sender, EventArgs e)
        {
            int examid = Convert.ToInt32((sender as LinkButton).CommandArgument);
            Session["examid"] = examid;
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandType = CommandType.Text;
            string registration_no = Session["Registration_No"].ToString();
            cmd.CommandText = "Select Count(*) from Result where RegistrationNo='"+registration_no+"'";
            int check = Convert.ToInt32(cmd.ExecuteScalar());
            if(check < 1)
            {
                Response.Redirect("StartTest.aspx");
            }
            else
            {
                lblmessage.Text = "Dear Student. You have already taken this Exam.";
            }
        }
           
    }
}