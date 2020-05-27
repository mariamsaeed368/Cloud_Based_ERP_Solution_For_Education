using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace OTeaching.Instructor
{
    public partial class sendmessage : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-J0A56S8\SQLEXPRESS;Initial Catalog=LoginDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            string username = Session["Instructor_username"].ToString();
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            con.Open();
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select s.Username as Student_Username,s.RegistrationNo,c.ClassName,c.Section,cs.CourseName from StudentRegistration s join Enrollment e on e.RegistrationID=s.RegistrationID  join Class c on c.ClassID=e.ClassID join ClassCourse cc on cc.ClassID=c.ClassID join InstructorCourse ic on ic.InstructorCourseID=cc.InstructorCourseID join Instructor i on i.InstructorID=ic.InstructorID join Courses cs on cs.CourseID=ic.CourseID where i.Username='" + username + "'";
            cmd.ExecuteNonQuery();
            DataTable dt1 = new DataTable();
            SqlDataAdapter sda1 = new SqlDataAdapter(cmd);
            sda1.Fill(dt1);
            Repeater1.DataSource = dt1;
            Repeater1.DataBind();
        }
    }
}