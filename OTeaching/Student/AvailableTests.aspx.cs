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
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-SI0GDUH\SQLEXPRESS;Initial Catalog=loginDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                FillGridView();
            }
        }
        void FillGridView()
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd1 = new SqlCommand("Select RegistrationID from StudentRegistration where Username='" + Session["Student_Username"] + "'", sqlCon);
            int regid = (int)cmd1.ExecuteScalar();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select ex.ExamID,ex.ExamName,ex.ExamDescription,ex.ExamDuration,ex.ExamMarks,ex.ExamPassingMarks from Exam ex Join ClassCourse c on ex.ClassCourseID=c.ClassCourseID join Class cl on cl.ClassID=c.ClassID join Enrollment e on e.ClassID=cl.ClassID join StudentRegistration sr on sr.RegistrationID=e.RegistrationID where sr.RegistrationID='" + regid + "'";
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
            cmd.CommandText = "Select Count(*) from Result where RegistrationNo='"+registration_no+"' AND ExamID='"+examid+"'";
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

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            FillGridView(); //bindgridview will get the data source and bind it again
        }
    }
}