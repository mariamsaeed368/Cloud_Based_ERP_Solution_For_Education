using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace OTeaching.Admin
{
    public partial class Courses : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-BDBIBK1;Initial Catalog=LoginDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnDelete.Enabled = false;
                FillGridView();

            }
        }
        void FillGridView()
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("CourseViewAll", sqlCon);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            GridView1.DataSource = dtbl;
            GridView1.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = new SqlCommand("Select Count(*) from Courses Where CourseNo='" + txtCourseNo.Text + "'", sqlCon);
            int check = (int)cmd.ExecuteScalar();
            if (check < 1)
            {
                SqlCommand sqlCmd = new SqlCommand("CourseCreateOrUpdate", sqlCon);
                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.AddWithValue("@CourseID", (hfCourseID.Value == "" ? 0 : Convert.ToInt32(hfCourseID.Value)));
                sqlCmd.Parameters.AddWithValue("@CourseName", txtCourseName.Text.Trim());
                sqlCmd.Parameters.AddWithValue("@CourseDescription", txtDescription.Text.Trim());
                sqlCmd.Parameters.AddWithValue("@CourseNo", txtCourseNo.Text.Trim());
                sqlCmd.ExecuteNonQuery();
                sqlCon.Close();
                Clear();
                string courseNO = hfCourseID.Value;
                if (courseNO == "")
                {
                    lblSuccessMessage.Text = "Added Successfully";
                    FillGridView();
                    Clear();
                }
                else
                {
                    lblSuccessMessage.Text = "Updated Succesfully";
                    FillGridView();
                    Clear();
                }
            }
            else
            {
                lblErrormessage.Text = "This Course No is already in use. Please Try Another.";
            }

        }
        public void Clear()
        {
            hfCourseID.Value = "";
            txtCourseName.Text = txtDescription.Text = txtCourseNo.Text = " ";
            lblErrormessage.Text = lblSuccessMessage.Text = " ";
            btnAdd.Text = "Add";
            btnDelete.Enabled = false;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand sqlCmd = new SqlCommand("CourseDeleteByID", sqlCon);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@CourseID", Convert.ToInt32(hfCourseID.Value));
            sqlCmd.ExecuteNonQuery();
            sqlCon.Close();
            lblSuccessMessage.Text = "Deleted Successfully";
            FillGridView();
            Clear();
        }
        protected void lnk_OnClick(object sender, EventArgs e)
        {
            int courseid = Convert.ToInt32((sender as LinkButton).CommandArgument);
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("CourseViewByID", sqlCon);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlDa.SelectCommand.Parameters.AddWithValue("@CourseID", courseid);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            hfCourseID.Value = courseid.ToString();
            txtCourseName.Text = dtbl.Rows[0]["CourseName"].ToString();
            txtDescription.Text = dtbl.Rows[0]["CourseDescription"].ToString();
            txtCourseNo.Text = dtbl.Rows[0]["CourseNo"].ToString();
            btnAdd.Text = "Update";
            btnDelete.Enabled = true;
        }
        protected void lnkassigninstructor_OnClick(object sender, EventArgs e)
        {
            int courseid = Convert.ToInt32((sender as LinkButton).CommandArgument);
            Session["courseid"] = courseid;
            Response.Redirect("InstructorCourse.aspx");
        }
    }
}