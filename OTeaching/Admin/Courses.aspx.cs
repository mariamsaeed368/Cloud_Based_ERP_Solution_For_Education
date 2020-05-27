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
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-J0A56S8\SQLEXPRESS;Initial Catalog=LoginDB;Integrated Security=True");
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
            SqlCommand cmd2 = sqlCon.CreateCommand();
            cmd2.CommandType = CommandType.Text;
            cmd2.CommandText = "Select InstructorCourseID from InstructorCourse where CourseID='" + Convert.ToInt32(hfCourseID.Value) + "'";
            int id = Convert.ToInt32(cmd2.ExecuteScalar());
            SqlCommand cmd10 = sqlCon.CreateCommand();
            cmd10.CommandType = CommandType.Text;
            cmd10.CommandText = "Select ClassCourseID from ClassCourse where InstructorCourseID='" + id + "'";
            int classcid = Convert.ToInt32(cmd10.ExecuteScalar());
            SqlCommand cmd9 = sqlCon.CreateCommand();
            cmd9.CommandType = CommandType.Text;
            cmd9.CommandText = "Delete from Attendence where ClassCourseID='" + classcid + "'";
            cmd9.ExecuteNonQuery();
            SqlCommand cmd4 = sqlCon.CreateCommand();
            cmd4.CommandType = CommandType.Text;
            cmd4.CommandText = "Delete from CourseMaterial where ClassCourseID='" + classcid + "'";
            cmd4.ExecuteNonQuery();
            SqlCommand cmd6 = sqlCon.CreateCommand();
            cmd6.CommandType = CommandType.Text;
            cmd6.CommandText = "Select ExamID from Exam where ClassCourseID='" + classcid + "'";
            int examid = Convert.ToInt32(cmd6.ExecuteScalar());
            SqlCommand cmd7 = sqlCon.CreateCommand();
            cmd7.CommandType = CommandType.Text;
            cmd7.CommandText = "Delete from CourseTest where ExamID='" + examid + "'";
            cmd7.ExecuteNonQuery();
            SqlCommand cmd8 = sqlCon.CreateCommand();
            cmd8.CommandType = CommandType.Text;
            cmd8.CommandText = "Delete from Result where ExamID='" + examid + "'";
            cmd8.ExecuteNonQuery();
            SqlCommand cmd11 = sqlCon.CreateCommand();
            cmd11.CommandType = CommandType.Text;
            cmd11.CommandText = "Delete from CourseTest where ExamID='" + examid + "'";
            cmd11.ExecuteNonQuery();
            SqlCommand cmd5 = sqlCon.CreateCommand();
            cmd5.CommandType = CommandType.Text;
            cmd5.CommandText = "Delete from Exam where ClassCourseID='" + id + "'";
            cmd5.ExecuteNonQuery();
            SqlCommand cmd1 = sqlCon.CreateCommand();
            cmd1.CommandType = CommandType.Text;
            cmd1.CommandText = "Delete from ClassCourse where InstructorCourseID='" + id + "'";
            cmd1.ExecuteNonQuery();
            SqlCommand cmd3 = sqlCon.CreateCommand();
            cmd3.CommandType = CommandType.Text;
            cmd3.CommandText = "Delete from InstructorCourse where CourseID='" + Convert.ToInt32(hfCourseID.Value) + "'";
            cmd3.ExecuteNonQuery();
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

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            FillGridView(); //bindgridview will get the data source and bind it again
        }
    }
}