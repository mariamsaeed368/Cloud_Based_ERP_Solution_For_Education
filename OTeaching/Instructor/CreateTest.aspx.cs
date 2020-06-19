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
    public partial class Create_Exam : System.Web.UI.Page
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
            cmd.CommandText = "Select e.* from CourseTest e join Exam c on c.ExamID=e.ExamID";
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            sqlCon.Close();
        }

        protected void btn_addquestion_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand sqlCmd = new SqlCommand("TestCreateOrUpdate", sqlCon);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@QuestionID", (hfQuestionID.Value == "" ? 0 : Convert.ToInt32(hfQuestionID.Value)));
            sqlCmd.Parameters.AddWithValue("@Question", txt_questionname.Text);
            sqlCmd.Parameters.AddWithValue("@Option1", txt_optionone.Text);
            sqlCmd.Parameters.AddWithValue("@Option2", txt_optiontwo.Text);
            sqlCmd.Parameters.AddWithValue("@Option3", txt_optionthree.Text);
            sqlCmd.Parameters.AddWithValue("@Option4", txt_optionfour.Text);
            sqlCmd.Parameters.AddWithValue("@ExamID", Session["ExamID"].ToString());
            sqlCmd.Parameters.AddWithValue("@CorrectAnswer", rdo_correctanswer.SelectedValue);
            sqlCmd.ExecuteNonQuery();
            sqlCon.Close();
            Clear();
            string ExamID = hfQuestionID.Value;
            if (ExamID == "")
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
        public void Clear()
        {
            hfQuestionID.Value = "";
            txt_questionname.Text = txt_optionone.Text = txt_optiontwo.Text = txt_optionthree.Text = txt_optionfour.Text = " ";
            lblSuccessMessage.Text = " ";
            lblErrormessage.Text = " ";
            btn_addquestion.Text = "Add Question";
            btnDelete.Enabled = false;
        }
        protected void lnk_OnClick(object sender, EventArgs e)
        {
            int questionid = Convert.ToInt32((sender as LinkButton).CommandArgument);
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select * from CourseTest where QuestionID='" + questionid + "'";
            cmd.ExecuteNonQuery();
            DataTable dtbl = new DataTable();
            SqlDataAdapter sqlDa = new SqlDataAdapter(cmd);
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            hfQuestionID.Value = questionid.ToString();
            txt_questionname.Text = dtbl.Rows[0]["Question"].ToString();
            txt_optionone.Text = dtbl.Rows[0]["Option1"].ToString();
            txt_optiontwo.Text = dtbl.Rows[0]["Option2"].ToString();
            txt_optionthree.Text = dtbl.Rows[0]["Option3"].ToString();
            txt_optionfour.Text = dtbl.Rows[0]["Option4"].ToString();
            rdo_correctanswer.SelectedValue = dtbl.Rows[0]["CorrectAnswer"].ToString();
            btn_addquestion.Text = "Update";
            btnDelete.Enabled = true;
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Delete from CourseTest where QuestionID='" + hfQuestionID.Value + "'";
            cmd.ExecuteNonQuery();
            lblSuccessMessage.Text = "Deleted Successfully";
            FillGridView();
            Clear();
        }
        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            FillGridView(); //bindgridview will get the data source and bind it again
        }
    }
}