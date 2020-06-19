using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OTeaching.Parent
{
    public partial class ParentEnrolledCourses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection(@"Data Source=DESKTOP-SI0GDUH\SQLEXPRESS;Initial Catalog=loginDB;Integrated Security=True");
            if (!IsPostBack)
            {
                ReportViewer1.SizeToReportContent = true;
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                string gaurdian_id = Session["GaurdianID"].ToString();
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                SqlCommand cmd1 = new SqlCommand("SELECT RegistrationID FROM StudentParent WHERE GaurdianID= '" + gaurdian_id + "'", conn);
                int registrationID = (int)cmd1.ExecuteScalar();
                SqlCommand cmd2 = new SqlCommand("SELECT RegistrationNo FROM StudentRegistration WHERE RegistrationID= '" + registrationID + "'", conn);
                string registration_no = cmd2.ExecuteScalar().ToString();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Select c.ClassCourseID,cr.CourseName,ins.Name as Instructor_Name,cl.ClassName,cl.Section,s.RegistrationNo from ClassCourse c join Class cl on cl.ClassID=c.ClassID join Enrollment e on e.ClassID=c.ClassID join StudentRegistration s on s.RegistrationID=e.RegistrationID join InstructorCourse i on i.InstructorCourseID=c.InstructorCourseID join Courses cr on cr.CourseID=i.CourseID join Instructor ins on ins.InstructorID=i.InstructorID where RegistrationNo='" + registration_no + "'";
                //conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                conn.Close();

                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSetParentEnrolledCourses", dt));
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Parent/ParentEnrolledCoursesReport.rdlc");

            }
        }
    }
}