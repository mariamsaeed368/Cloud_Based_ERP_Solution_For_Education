using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OTeaching.Student
{
    public partial class Reports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btn_enrolled_courses_report_click(object sender, EventArgs e)
        {
            Response.Redirect("~/Student/EnrolledCoursesReport.aspx");
        }
        protected void btn_attendence_report_click(object sender, EventArgs e)
        {
            Response.Redirect("~/Student/StudentAttendenceReport.aspx");
        }
        protected void btn_result_report_click(object sender, EventArgs e)
        {
            Response.Redirect("~/Student/StudentResultReport.aspx");
        }
        
    }
}