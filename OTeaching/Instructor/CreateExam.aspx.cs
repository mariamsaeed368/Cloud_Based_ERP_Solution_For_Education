using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace OTeaching.Instructor
{
    public partial class CreateExam : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-SI0GDUH\SQLEXPRESS;Initial Catalog=loginDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                btnDelete.Enabled = false;
                FillGridView();
            }            
        }
        void FillGridView()
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select ex.ExamID,ex.ExamName,ex.ExamDescription,ex.ExamDate,ex.ExamDuration,ex.ExamMarks,ex.ExamPassingMarks from Instructor i join InstructorCourse ic on ic.InstructorID=i.InstructorID join ClassCourse cc on cc.InstructorCourseID=ic.InstructorCourseID join Exam ex on ex.ClassCourseID=cc.ClassCourseID where i.InstructorID='"+Session["InstructorID"]+"'";
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            sqlCon.Close();
        }

        protected void btn_addexam_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            if(Convert.ToInt32(txt_exampassmarks.Text) > Convert.ToInt32(txt_exammatotalmarks.Text))
            {
                lblErrormessage.Text = "Exam Passing Marks should be less than Total Marks.";
            }
            else
            {
                SqlCommand sqlCmd = new SqlCommand("ExamCreateOrUpdate", sqlCon);
                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.AddWithValue("@ExamID", (hfExamID.Value == "" ? 0 : Convert.ToInt32(hfExamID.Value)));
                sqlCmd.Parameters.AddWithValue("@ExamName", txt_examname.Text);
                sqlCmd.Parameters.AddWithValue("@ExamDescription", txt_examdis.Text);
                sqlCmd.Parameters.AddWithValue("@ExamDate", txt_examdate.Text);
                sqlCmd.Parameters.AddWithValue("@ExamDuration", txt_examduration.Text);
                sqlCmd.Parameters.AddWithValue("@ExamMarks", txt_exammatotalmarks.Text);
                sqlCmd.Parameters.AddWithValue("@ClassCourseID", Session["classcourseid"].ToString());
                sqlCmd.Parameters.AddWithValue("@ExamPassingMarks", txt_exampassmarks.Text);
                sqlCmd.ExecuteNonQuery();
                sqlCon.Close();
                Clear();
                string ExamID = hfExamID.Value;
                if (ExamID == "")
                {
                    lblSuccessMessage.Text = "Added Successfully";
                    FillGridView();
                    Clear();
                }
                else
                {
                    lblErrormessage.Text = "Updated Succesfully";
                    FillGridView();
                    Clear();
                }
            }           
        }
        public void Clear()
        {
            hfExamID.Value = "";
            txt_examname.Text = txt_examdis.Text = txt_examdate.Text = txt_examduration.Text = txt_exammatotalmarks.Text = txt_exampassmarks.Text = " ";
            lblSuccessMessage.Text = " ";
            lblErrormessage.Text = " ";
            btn_addexam.Text = "Add Exam";
            btnDelete.Enabled = false;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }
        protected void lnk_OnClick(object sender, EventArgs e)
        {
            int examid = Convert.ToInt32((sender as LinkButton).CommandArgument);
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select * from Exam where ExamID='" + examid + "'";
            cmd.ExecuteNonQuery();
            DataTable dtbl = new DataTable();
            SqlDataAdapter sqlDa = new SqlDataAdapter(cmd);
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            hfExamID.Value = examid.ToString();
            txt_examname.Text = dtbl.Rows[0]["ExamName"].ToString();
            txt_examdis.Text = dtbl.Rows[0]["ExamDescription"].ToString();
            txt_examdate.Text = dtbl.Rows[0]["ExamDate"].ToString();
            txt_examduration.Text = dtbl.Rows[0]["ExamDuration"].ToString();
            txt_exammatotalmarks.Text = dtbl.Rows[0]["ExamMarks"].ToString();
            txt_exampassmarks.Text = dtbl.Rows[0]["ExamPassingMarks"].ToString();
            btn_addexam.Text = "Update";
            btnDelete.Enabled = true;
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            SqlCommand cmd1 = new SqlCommand("Delete from CourseTest where ExamID='"+hfExamID.Value+"'", sqlCon);
            cmd1.ExecuteNonQuery();
            cmd.CommandText = "Delete from Exam where ExamID='" + hfExamID.Value + "'";
            cmd.ExecuteNonQuery();
            lblSuccessMessage.Text = "Deleted Successfully";
            FillGridView();
            Clear();
        }
        protected void lnkquestions_OnClick(object sender, EventArgs e)
        {
            int examid = Convert.ToInt32((sender as LinkButton).CommandArgument);
            Session["ExamID"] = examid;
            Response.Redirect("CreateTest.aspx");
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            FillGridView(); //bindgridview will get the data source and bind it again
        }
    }
}