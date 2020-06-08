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
    public partial class StudentCourse : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-BDBIBK1;Initial Catalog=LoginDB;Integrated Security=True");
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
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            string registration_no = Session["Registration_No"].ToString();
            cmd.CommandText = "Select c.ClassCourseID,cr.CourseName,ins.Name as Instructor_Name,cl.ClassName,cl.Section,s.RegistrationNo from ClassCourse c join Class cl on cl.ClassID=c.ClassID join Enrollment e on e.ClassID=c.ClassID join StudentRegistration s on s.RegistrationID=e.RegistrationID join InstructorCourse i on i.InstructorCourseID=c.InstructorCourseID join Courses cr on cr.CourseID=i.CourseID join Instructor ins on ins.InstructorID=i.InstructorID where RegistrationNo='" + registration_no + "'";
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
            int classcourseid = Convert.ToInt32((sender as LinkButton).CommandArgument);
            Session["ClassCourseID"] = classcourseid;
            Response.Redirect("DownloadCourseMaterial.aspx");
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            FillGridView(); //bindgridview will get the data source and bind it again
        }
    }
}