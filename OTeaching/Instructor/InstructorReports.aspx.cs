using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OTeaching.Instructor
{
    public partial class InstructorReports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_assigned_courses_report_click(object sender, EventArgs e)
        {
            Response.Redirect("~/Instructor/InstructorAssignedCoursesReport.aspx");
        }

        protected void btn_attendence_report_click(object sender, EventArgs e)
        {
            Response.Redirect("~/Instructor/AttendanceReport.aspx");
        }

        protected void btn_result_report_click(object sender, EventArgs e)
        {
            Response.Redirect("~/Instructor/ResultReport.aspx");
        }
    }
}