using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Reporting.WebForms;


namespace OTeaching.Instructor
{
    public partial class AttendanceReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            SqlConnection conn = new SqlConnection("Data Source=DESKTOP-DABV6FC\\SQLEXPRESS;Initial Catalog=LoginDB;Integrated Security=True");


            if (!IsPostBack)
            {
                if (conn.State == ConnectionState.Closed)

                {
                    conn.Open();

                }


                //Reporting Work

                ReportViewer1.SizeToReportContent = true;

                SqlCommand cmd = new SqlCommand();

                cmd.Connection = conn;


                cmd.CommandType = CommandType.Text;

                cmd.CommandText = "select  at.Date,ins.Name as InstructorName,s.RegistrationNo,s.Name as StudentName,   cr.CourseName ,e.ClassName as Class,e.Section,(CASE WHEN status = '1'THEN 'Present' ELSE 'Absent' End) as Status from Attendence at JOIN ClassCourse cc ON at.ClassCourseID = cc.ClassCourseID JOIN Class e ON e.ClassID = cc.ClassID JOIN InstructorCourse i ON i.InstructorCourseID = cc.InstructorCourseID JOIN Courses cr ON cr.CourseID = i.CourseID JOIN Instructor ins ON ins.InstructorID = i.InstructorID join StudentRegistration s on at.RegistrationID = s.RegistrationID group by at.RegistrationID,cr.CourseName,ins.Name,e.ClassName,e.Section, at.Date, at.Status, s.RegistrationNo, s.Name";
                if (conn.State == ConnectionState.Closed)
                    conn.Open();
                SqlDataReader dr1 = cmd.ExecuteReader();

                DataTable dt = new DataTable();
                dt.Load(dr1);
                conn.Close();
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSetAttendanceReport", dt));
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Instructor/AttendanceReport.rdlc");
            }
            }
    }
}