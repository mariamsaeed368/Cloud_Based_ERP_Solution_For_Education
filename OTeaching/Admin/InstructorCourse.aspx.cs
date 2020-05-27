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
    public partial class InstructorCourse : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-J0A56S8\SQLEXPRESS;Initial Catalog=LoginDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnDelete.Enabled = false;
                filldropdownlist();
                FillGridView();
                txtCourseID.Text = Session["courseid"].ToString();
            }
        }
        void filldropdownlist()
        {
            ddlusername.Items.Clear();
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand sqlCmd0 = sqlCon.CreateCommand();
            sqlCmd0.CommandType = CommandType.Text;
            sqlCmd0.CommandText = "SELECT Username FROM Instructor";
            sqlCmd0.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(sqlCmd0);
            da.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                ddlusername.Items.Add(dr["Username"].ToString());
            }

            sqlCon.Close();
        }
        void FillGridView()
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select i.CourseID,ins.Username,i.AssignedOn,i.InstructorCourseID from InstructorCourse i join Instructor ins on ins.InstructorID=i.InstructorID";
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            sqlCon.Close();
        }
        public void Clear()
        {
            hfInstructorCourseID.Value = "";
            txtCourseID.Text = " ";
            lblErrormessage.Text = lblSuccessMessage.Text = " ";
            btnAdd.Text = "Add";
            btnDelete.Enabled = false;
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            sqlCon.Open();
            SqlCommand cmd = new SqlCommand("Select InstructorID from Instructor where Username='" + ddlusername.Text + "'", sqlCon);
            int id = (int)cmd.ExecuteScalar();
            SqlCommand cmd1 = new SqlCommand("Select Count(*) from InstructorCourse where InstructorID='" + id + "' AND CourseID='"+txtCourseID.Text+"' AND AssignedOn='"+ Convert.ToDateTime(txtAssignment.Text) + "'", sqlCon);
            int check = (int)cmd1.ExecuteScalar();
            if (check < 1)
            {
                SqlCommand sqlCmd = new SqlCommand("InstructorCourseCreateOrUpdate", sqlCon);
                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.AddWithValue("@InstructorCourseID", (hfInstructorCourseID.Value == "" ? 0 : Convert.ToInt32(hfInstructorCourseID.Value)));
                sqlCmd.Parameters.AddWithValue("@CourseID", txtCourseID.Text);
                sqlCmd.Parameters.AddWithValue("@InstructorID", id);
                sqlCmd.Parameters.AddWithValue("@AssignedOn", Convert.ToDateTime(txtAssignment.Text));
                sqlCmd.ExecuteNonQuery();
                sqlCon.Close();
                Clear();
                string InstructorCourseID = hfInstructorCourseID.Value;
                if (InstructorCourseID == "")
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
                lblErrormessage.Text = "This Instructor is Already Registered in this Course.";
            }
        }
        protected void lnk_OnClick(object sender, EventArgs e)
        {
            int instructorcourseid = Convert.ToInt32((sender as LinkButton).CommandArgument);
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select i.CourseID,ins.Username,i.AssignedOn from InstructorCourse i join Instructor ins on ins.InstructorID = i.InstructorID where InstructorCourseID='"+instructorcourseid+"'";
            cmd.ExecuteNonQuery();
            DataTable dtbl = new DataTable();
            SqlDataAdapter sqlDa = new SqlDataAdapter(cmd);
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            hfInstructorCourseID.Value = instructorcourseid.ToString();
            txtCourseID.Text = dtbl.Rows[0]["CourseID"].ToString();
            ddlusername.Text = dtbl.Rows[0]["Username"].ToString();
            txtAssignment.Text = dtbl.Rows[0]["AssignedOn"].ToString();
            btnAdd.Text = "Update";
            btnDelete.Enabled = true;
        }
        protected void lnkAssignClass_OnClick(object sender, EventArgs e)
        {
            int instructorcourseid = Convert.ToInt32((sender as LinkButton).CommandArgument);
            Session["InstructorCourseID"] = instructorcourseid;
            Response.Redirect("AssignClassCourse.aspx");
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd1 = new SqlCommand("Delete from ClassCourse where InstructorCourseID='"+hfInstructorCourseID+"'", sqlCon);
            cmd1.ExecuteNonQuery();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Delete from InstructorCourse where InstructorCourseID='" + hfInstructorCourseID.Value + "'";
            cmd.ExecuteNonQuery();
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