using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OTeaching.Parent
{
    public partial class ParentReports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btn_enrolled_courses_report_click(object sender, EventArgs e)
        {
            Response.Redirect("~/Parent/ParentEnrolledCourses.aspx");
        }
        protected void btn_attendence_report_click(object sender, EventArgs e)
        {
            Response.Redirect("~/Parent/ParentAttendenceReport.aspx");
        }
        protected void btn_result_report_click(object sender, EventArgs e)
        {
            Response.Redirect("~/Parent/ParentResultReport.aspx");
        }
    }
}