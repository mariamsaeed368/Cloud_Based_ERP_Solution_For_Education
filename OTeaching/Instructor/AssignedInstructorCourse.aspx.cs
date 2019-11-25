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
    public partial class AssignedInstructorCourse : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-BDBIBK1;Initial Catalog=LoginDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            string username = Session["Instructor_username"].ToString();
            cmd.CommandText = "Select cr.CourseName,ins.Name as Instructor_Name,cl.ClassName,cl.Section,i.InstructorCourseID from ClassCourse c join Class cl on cl.ClassID = c.ClassID join InstructorCourse i on i.InstructorCourseID = c.InstructorCourseID join Courses cr on cr.CourseID = i.CourseID join Instructor ins on ins.InstructorID = i.InstructorID where ins.Username = '" + username + "'";
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            sqlCon.Close();
        }
        protected void lnkcoursematerial_OnClick(object sender, EventArgs e)
        {
            int instructorcourseid = Convert.ToInt32((sender as LinkButton).CommandArgument);
            Session["instructorcourseid"] = instructorcourseid;
            Response.Redirect("UploadCourseMaterial.aspx");
        }
    }
}