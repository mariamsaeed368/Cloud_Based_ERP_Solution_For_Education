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
    public partial class StartTest : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-SI0GDUH\SQLEXPRESS;Initial Catalog=loginDB;Integrated Security=True;MultipleActiveResultSets=true");
        protected void Page_Load(object sender, EventArgs e)
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

            if (!IsPostBack)
            {
                int id = Convert.ToInt32(Session["examid"].ToString());
                questionistmethod(id);
            }
        }
        public void questionistmethod(int id)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select * from CourseTest where ExamID='"+id+"'";
            cmd.ExecuteNonQuery();
                try
                {
                    SqlDataReader rd = cmd.ExecuteReader();
                    if (rd.HasRows)
                    {
                        gridview_examquestion.DataSource = rd;
                        gridview_examquestion.DataBind();
                    }
                    else
                    {
                        panel_questshow_warning.Visible = true;
                        lbl_questshowwarning.Text = "Sorry! There is no question in this exam";
                    }
                }
                catch (Exception ex)
                {
                    panel_questshow_warning.Visible = true;
                    lbl_questshowwarning.Text = "Something went wrong. Please try after sometime later</br> Contact you developer for this problem" + ex.Message;
                }
        }
        //decalring some varibles to exam marking 
        string result = string.Empty;
        int total_questions;
        int select_number = 0;
        float correct_number = 0;
        int wrong_number = 0;
        int count = 0;
        protected void btn_submit_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gridview_examquestion.Rows)
            {
                Label li = row.FindControl("lblid") as Label;
                RadioButton r1 = row.FindControl("option_one") as RadioButton;
                RadioButton r2 = row.FindControl("option_two") as RadioButton;
                RadioButton r3 = row.FindControl("option_three") as RadioButton;
                RadioButton r4 = row.FindControl("option_four") as RadioButton;

                if (r1.Checked == true)
                {
                    select_number = 1;
                }
                else if (r2.Checked == true)
                {
                    select_number = 2;
                }
                else if (r3.Checked == true)
                {
                    select_number = 3;
                }
                else if (r4.Checked == true)
                {
                    select_number = 4;
                }

                checkanswer(li.Text);
                panel_questshow_warning.Visible = false;
            }
            saveinresult(passfail(), correct_number, gridview_examquestion.Rows.Count);
        }
        //method for checking answer wheter it is right or wrong 

        public void checkanswer(string qid)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            int id = Convert.ToInt32(Session["examid"].ToString());
            SqlCommand cmd1 = sqlCon.CreateCommand();
            cmd1.CommandType = CommandType.Text;
            cmd1.CommandText = "Select ExamMarks from Exam where ExamID='" + id + "'";
            int exammarks=Convert.ToInt32(cmd1.ExecuteScalar());
            SqlCommand cmd2 = sqlCon.CreateCommand();
            cmd2.CommandType = CommandType.Text;
            cmd2.CommandText = "Select Count(*) from CourseTest where ExamID='" + id + "'";
            int totalquestions = Convert.ToInt32(cmd2.ExecuteScalar());
            float marks = (float)exammarks / (float)totalquestions;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Select * from CourseTest where QuestionID = @QuestionID" + count;
            cmd.Parameters.AddWithValue("@QuestionID" + count, qid);
            cmd.Connection = sqlCon;
            SqlDataReader rd = cmd.ExecuteReader();
                while (rd.Read())
                {
                    if (select_number == Convert.ToInt32(rd["CorrectAnswer"]))
                    {

                        correct_number = correct_number + marks;
                        break;
                    }
                    else
                    {
                        wrong_number = wrong_number + 1;
                        break;
                    }
                }
                count++;
        }

    //method for cheking if examinee pass or fail from the exam pass mark in database
    public string passfail()
    {
            int id = Convert.ToInt32(Session["examid"].ToString());
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = new SqlCommand("Select ExamPassingMarks from Exam where ExamID = @ExamID", sqlCon);
            cmd.Parameters.AddWithValue("@ExamID", id);
            SqlDataReader rd = cmd.ExecuteReader();
            while (rd.Read())
            {
                if (correct_number >= Convert.ToInt32(rd["ExamPassingMarks"]))
                {

                    result = result + "Pass";
                    break;
                }
                else
                {
                    result = result + "Fail";
                    break;
                }
            }
            return result;
    }

    // method for  saving the result info in databse
    public void saveinresult(string status, float score, int tquestion)
    {
            int id = Convert.ToInt32(Session["examid"].ToString());
            SqlCommand cmd2 = sqlCon.CreateCommand();
            cmd2.CommandType = CommandType.Text;
            cmd2.CommandText = "Select RegistrationNo from StudentRegistration where Username = '" + getstringuser.Text + "'";
            string regno = cmd2.ExecuteScalar().ToString();          
            SqlCommand cmd = new SqlCommand("spResultInsert", sqlCon);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ExamID", id);
            cmd.Parameters.AddWithValue("@ResultStatus", status);
            cmd.Parameters.AddWithValue("@ResultScore", score);
            cmd.Parameters.AddWithValue("@TotalQuestion", tquestion);
            cmd.Parameters.AddWithValue("@RegistrationNo", regno);
            try
            {
                cmd.ExecuteNonQuery();
                Response.Redirect("~/Student/StudentCourse.aspx");
            }
            catch (Exception ex)
            {
                panel_questshow_warning.Visible = true;
                lbl_questshowwarning.Text = "Something went wrong. Please try after sometime later</br> Contact you developer for this problem" + ex.Message;
            }
        }
        static int ss = 59;
        static int mm;
        protected void Timer1_Tick(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            int id = Convert.ToInt32(Session["examid"].ToString());
            SqlCommand cmd2 = sqlCon.CreateCommand();
            cmd2.CommandType = CommandType.Text;
            cmd2.CommandText = "Select ExamDuration from Exam where ExamID = '" + id+ "'";
            mm = Convert.ToInt32(cmd2.ExecuteScalar().ToString());
            mm = mm - 1;
            ss--;
            if(ss<0)
            {
                mm--;
                ss = 59;
            }
            LabelTimer.Text = "Timer:"+"00:" + mm.ToString() +":"+ ss.ToString() ;
        }
    }
}