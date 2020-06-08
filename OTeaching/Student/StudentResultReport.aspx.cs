using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OTeaching.Student
{
    public partial class StudentResultReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection("Data Source=DESKTOP-BDBIBK1;Initial Catalog=LoginDB;Integrated Security=True;MultipleActiveResultSets=true");
            string registration_no = Session["Registration_No"].ToString();
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
                cmd.CommandText = "Select e.ExamName,e.ExamDuration,e.ExamMarks,r.TotalQuestion,r.ResultScore,r.ResultStatus,r.RegistrationNo from Result r join Exam e on e.ExamID=r.ExamID where r.RegistrationNo='" + registration_no + "'";
                if (conn.State == ConnectionState.Closed)
                    conn.Open();
                SqlDataReader dr1 = cmd.ExecuteReader();

                DataTable dt = new DataTable();
                dt.Load(dr1);
                conn.Close();

                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSetStudentResultReport", dt));
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Student/StudentResultReport.rdlc");

            }
        }
    }
}