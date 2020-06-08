using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace OTeaching.Parent
{
    public partial class StudentParentResult : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-BDBIBK1;Initial Catalog=LoginDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FillGridView();
            }
        }
        
        void FillGridView()
        {
            HttpCookie usercookie = Request.Cookies["user_cookies"];
            if (Session["GaurdianID"] != null || usercookie != null)
            {
                if (Session["GaurdianID"] == null)
                {
                    getstringuser.Text = usercookie["GaurdianID"];
                }
                else
                {
                    getstringuser.Text = Session["GaurdianID"].ToString();
                }
            }
            else
            {
                Response.Redirect("ParentLogin.aspx");
            }
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd2 = sqlCon.CreateCommand();
            cmd2.CommandType = CommandType.Text;
            cmd2.CommandText = "Select RegistrationID from StudentParent where GaurdianID = '" + getstringuser.Text + "'";
            string regid = cmd2.ExecuteScalar().ToString();
            SqlCommand cmd3 = sqlCon.CreateCommand();
            cmd3.CommandType = CommandType.Text;
            cmd3.CommandText = "Select RegistrationNo from StudentRegistration where RegistrationID = '"+ Convert.ToInt16(regid) +"'";
            string regno = cmd3.ExecuteScalar().ToString();
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