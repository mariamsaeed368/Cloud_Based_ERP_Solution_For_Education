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
    public partial class Classes : System.Web.UI.Page
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
            SqlDataAdapter sqlDa = new SqlDataAdapter("ClassViewAll", sqlCon);
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
            SqlCommand cmd1 = new SqlCommand("Select Count(Section) from Class where ClassName='" + txtClassName.Text + "'", sqlCon);
            int check = (int)cmd1.ExecuteScalar();
            if(check < 4)
            {
                SqlCommand sqlCmd = new SqlCommand("ClassCreateOrUpdate", sqlCon);
                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.AddWithValue("@ClassID", (hfClassID.Value == "" ? 0 : Convert.ToInt32(hfClassID.Value)));
                sqlCmd.Parameters.AddWithValue("@ClassName", txtClassName.Text);
                sqlCmd.Parameters.AddWithValue("@StartTiming", txtStartTiming.Text);
                sqlCmd.Parameters.AddWithValue("@EndTiming", txtEndTiming.Text);
                sqlCmd.Parameters.AddWithValue("@Section", txtSection.Text.Trim());
                sqlCmd.ExecuteNonQuery();
                sqlCon.Close();
                Clear();
                string classID = hfClassID.Value;
                if (classID == "")
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
                lblErrormessage.Text = "A Class Cannot Have More than 4 Sections";
            } 
        }
        public void Clear()
        {
            hfClassID.Value = "";
            txtClassName.Text = txtStartTiming.Text = txtEndTiming.Text = txtSection.Text= " ";
            lblErrormessage.Text = lblSuccessMessage.Text = " ";
            btnAdd.Text = "Add";
            btnDelete.Enabled = false;
        }
        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }
        protected void lnk_OnClick(object sender, EventArgs e)
        {
            int classid = Convert.ToInt32((sender as LinkButton).CommandArgument);
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("ClassViewByID", sqlCon);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlDa.SelectCommand.Parameters.AddWithValue("@ClassID", classid);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            hfClassID.Value = classid.ToString();
            txtClassName.Text = dtbl.Rows[0]["ClassName"].ToString();
            txtStartTiming.Text = dtbl.Rows[0]["StartTiming"].ToString();
            txtEndTiming.Text = dtbl.Rows[0]["EndTiming"].ToString();
            txtSection.Text = dtbl.Rows[0]["Section"].ToString();
            btnAdd.Text = "Update";
            btnDelete.Enabled = true;
        }
      //  public static int classid1;
        protected void lnkenrollment_OnClick(object sender, EventArgs e)
        {       
            LinkButton btndetails = sender as LinkButton;
            GridViewRow gvrow = (GridViewRow)btndetails.NamingContainer;
            LinkButton ln = (LinkButton)GridView1.Rows[gvrow.RowIndex].FindControl("lnkenrollment");
            string[] arguments = ln.CommandArgument.ToString().Split(new char[] { '~' });
            Session["test"] = arguments[0];
            Session["Section"] = arguments[1];
            Response.Redirect("StudentClass.aspx");
            //lblSuccessMessage.Text = arguments[0];


        }
        protected void lnkfee_OnClick(object sender, EventArgs e)
        {
            int classid = Convert.ToInt32((sender as LinkButton).CommandArgument);
            Session["classid"] = classid;
            Response.Redirect("Fee.aspx");
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Delete from Enrollment where ClassID='" + Convert.ToInt32(hfClassID.Value) + "'";
            cmd.ExecuteNonQuery();
            SqlCommand cmd2 = sqlCon.CreateCommand();
            cmd2.CommandType = CommandType.Text;
            cmd2.CommandText = "Select ClassCourseID from ClassCourse where ClassID='" + Convert.ToInt32(hfClassID.Value) + "'";
            int id = Convert.ToInt32(cmd2.ExecuteScalar());
            SqlCommand cmd3 = sqlCon.CreateCommand();
            cmd3.CommandType = CommandType.Text;
            cmd3.CommandText = "Delete from Attendence where ClassCourseID='" + id + "'";
            cmd3.ExecuteNonQuery();
            SqlCommand cmd4 = sqlCon.CreateCommand();
            cmd4.CommandType = CommandType.Text;
            cmd4.CommandText = "Delete from CourseMaterial where ClassCourseID='" + id + "'";
            cmd4.ExecuteNonQuery();
            SqlCommand cmd6 = sqlCon.CreateCommand();
            cmd6.CommandType = CommandType.Text;
            cmd6.CommandText = "Select ExamID from Exam where ClassCourseID='" + id + "'";
            int examid=Convert.ToInt32(cmd6.ExecuteScalar());
            SqlCommand cmd7 = sqlCon.CreateCommand();
            cmd7.CommandType = CommandType.Text;
            cmd7.CommandText = "Delete from CourseTest where ExamID='" + examid + "'";
            cmd7.ExecuteNonQuery();
            SqlCommand cmd8 = sqlCon.CreateCommand();
            cmd8.CommandType = CommandType.Text;
            cmd8.CommandText = "Delete from Result where ExamID='" + examid + "'";
            cmd8.ExecuteNonQuery();
            SqlCommand cmd5 = sqlCon.CreateCommand();
            cmd5.CommandType = CommandType.Text;
            cmd5.CommandText = "Delete from Exam where ClassCourseID='" + id + "'";
            cmd5.ExecuteNonQuery();
            SqlCommand cmd1 = sqlCon.CreateCommand();
            cmd1.CommandType = CommandType.Text;
            cmd1.CommandText = "Delete from ClassCourse where ClassID='" + Convert.ToInt32(hfClassID.Value) + "'";
            cmd1.ExecuteNonQuery();
            SqlCommand sqlCmd = new SqlCommand("ClassDeleteByID", sqlCon);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@ClassID", Convert.ToInt32(hfClassID.Value));
            sqlCmd.ExecuteNonQuery();
            sqlCon.Close();
            lblSuccessMessage.Text = "Deleted Successfully";
            FillGridView();
            Clear();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            FillGridView(); //bindgridview will get the data source and bind it again
        }
    }
}