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
    public partial class ParentResultReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection("Data Source=DESKTOP-BDBIBK1;Initial Catalog=LoginDB;Integrated Security=True;MultipleActiveResultSets=true");
            string gaurdian_id = Session["GaurdianID"].ToString();
            if (!IsPostBack)
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                SqlCommand cmd1 = new SqlCommand("SELECT RegistrationID FROM StudentParent WHERE GaurdianID= '" + gaurdian_id + "'", conn);
                int registrationID = (int)cmd1.ExecuteScalar();
                SqlCommand cmd2 = new SqlCommand("SELECT RegistrationNo FROM StudentRegistration WHERE RegistrationID= '" + registrationID + "'", conn);
                string registration_no = cmd2.ExecuteScalar().ToString();
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

                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSetParentResultReport", dt));
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Parent/ParentResultReport.rdlc");

            }
        }
    }
}