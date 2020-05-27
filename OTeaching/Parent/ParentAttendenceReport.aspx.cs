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
    public partial class ParentAttendenceReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection("Data Source=DESKTOP-J0A56S8\\SQLEXPRESS;Initial Catalog=LoginDB;Integrated Security=True;MultipleActiveResultSets=true");
            string gaurdian_id = Session["GaurdianID"].ToString();
            if (!IsPostBack)
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                SqlCommand cmd1 = new SqlCommand("SELECT RegistrationID FROM StudentParent WHERE GaurdianID= '" + gaurdian_id + "'", conn);
                int registrationID = (int)cmd1.ExecuteScalar();

                //Reporting Work
                ReportViewer1.SizeToReportContent = true;
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;

                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select  at.RegistrationID,cr.CourseName as Course, ins.Name as Instructor,e.ClassName as Class,e.Section,convert(varchar, dbo.fnpercent(sum(case when Status=2 then 0 else 1 end),at.RegistrationID,cr.CourseName,ins.Name,e.ClassName,e.Section)) + '%' 'AttendancePercentage' from Attendence at JOIN ClassCourse cc ON at.ClassCourseID = cc.ClassCourseID JOIN Class e ON e.ClassID = cc.ClassID JOIN InstructorCourse i ON i.InstructorCourseID = cc.InstructorCourseID JOIN Courses cr ON cr.CourseID = i.CourseID JOIN Instructor ins ON ins.InstructorID = i.InstructorID where at.RegistrationID = '" + registrationID + "' group by at.RegistrationID,cr.CourseName,ins.Name,e.ClassName,e.Section order by at.RegistrationID";
                if (conn.State == ConnectionState.Closed)
                    conn.Open();
                SqlDataReader dr1 = cmd.ExecuteReader();

                DataTable dt = new DataTable();
                dt.Load(dr1);
                conn.Close();
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSetParentEnrolledCoursesReport", dt));
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Parent/ParentEnrolledCoursesReport.rdlc");
                
            }
        }
    }

}