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
    public partial class ResultReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection(@"Data Source=DESKTOP-SI0GDUH\SQLEXPRESS;Initial Catalog=loginDB;Integrated Security=True;MultipleActiveResultSets=true");

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
                cmd.CommandText = "SELECT Exam.ExamName, Result.RegistrationNo, StudentRegistration.Name as StudentName, Exam.ExamMarks as TotalMarks, ResultScore, ResultStatus FROM Result join StudentRegistration on StudentRegistration.RegistrationNo = Result.RegistrationNo join Exam on Exam.ExamID = Result.ExamID";
               
                if (conn.State == ConnectionState.Closed)
                    conn.Open();
                SqlDataReader dr1 = cmd.ExecuteReader();

                DataTable dt = new DataTable();
                dt.Load(dr1);
                conn.Close();
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSetResultReport", dt));
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Instructor/ResultReport.rdlc");
            }
        }
    }
}