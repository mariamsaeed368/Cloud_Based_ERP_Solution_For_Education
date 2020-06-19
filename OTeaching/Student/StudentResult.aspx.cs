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
    public partial class StudentResult : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-SI0GDUH\SQLEXPRESS;Initial Catalog=loginDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                FillGridView();
            }
        }
        void FillGridView()
        {
            HttpCookie usercookie = Request.Cookies["user_cookies"];
            if (Session["Student_Username"] != null || usercookie != null)
            {
                if (Session["Student_Username"] == null)
                {
                    getstringuser.Text = usercookie["Student_Username"];
                }
                else
                {
                    getstringuser.Text = Session["Student_Username"].ToString();
                }
            }
            else
            {
                Response.Redirect("StudentLogin.aspx");
            }
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd2 = sqlCon.CreateCommand();
            cmd2.CommandType = CommandType.Text;
            cmd2.CommandText = "Select RegistrationNo from StudentRegistration where Username = '" + getstringuser.Text + "'";
            string regno = cmd2.ExecuteScalar().ToString();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select e.ExamName,e.ExamDuration,e.ExamMarks,r.TotalQuestion,r.ResultScore,r.ResultStatus,r.RegistrationNo from Result r join Exam e on e.ExamID=r.ExamID where r.RegistrationNo='" + regno + "'";
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            gridmyresult.DataSource = dt;
            gridmyresult.DataBind();
            sqlCon.Close();
        }

        protected void gridmyresult_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gridmyresult.PageIndex = e.NewPageIndex;
            FillGridView(); //bindgridview will get the data source and bind it again
        }
    }
}