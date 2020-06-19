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
    public partial class AssignClassCourse : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-SI0GDUH\SQLEXPRESS;Initial Catalog=loginDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnDelete.Enabled = false;
                filldropdownlist();
                filldropdownlistSection();
                FillGridView();
                txtInstructorCourseID.Text = Session["InstructorCourseID"].ToString();
            }
        }
        void filldropdownlist()
        {
            ddlclassname.Items.Clear();
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand sqlCmd0 = sqlCon.CreateCommand();
            sqlCmd0.CommandType = CommandType.Text;
            sqlCmd0.CommandText = "Select ClassName from Class group by ClassName";
            sqlCmd0.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(sqlCmd0);
            da.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                ddlclassname.Items.Add(dr["ClassName"].ToString());
            }

            sqlCon.Close();
        }
        void filldropdownlistSection()
        {
            ddlsection.Items.Clear();
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand sqlCmd0 = sqlCon.CreateCommand();
            sqlCmd0.CommandType = CommandType.Text;
            sqlCmd0.CommandText = "Select Section from Class where ClassName='"+ddlclassname.Text+"'";
            sqlCmd0.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(sqlCmd0);
            da.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                ddlsection.Items.Add(dr["Section"].ToString());
            }

            sqlCon.Close();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            sqlCon.Open();
            SqlCommand cmd = new SqlCommand("Select ClassID from Class where ClassName='" + ddlclassname.Text + "' AND Section='" + ddlsection.Text + "'", sqlCon);
            int id = (int)cmd.ExecuteScalar();
            SqlCommand cmd1 = new SqlCommand("Select CourseID from InstructorCourse where InstructorCourseID='" + txtInstructorCourseID.Text + "'", sqlCon);
            int check = (int)cmd1.ExecuteScalar();
            SqlCommand cmd2 = new SqlCommand("Select Count(*) from ClassCourse c join Class cl on c.ClassID=cl.ClassID join InstructorCourse ic on ic.InstructorCourseID=c.InstructorCourseID where ic.CourseID='"+check+"' AND cl.ClassName='"+ddlclassname.Text+"' AND cl.Section='"+ddlsection.Text+"'", sqlCon);
            int check1 = (int)cmd2.ExecuteScalar();
            if(check1<1)
            {
                SqlCommand sqlCmd = new SqlCommand("ClassCourseCreateOrUpdate", sqlCon);
                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.AddWithValue("@ClassCourseID", (hfClassCourseID.Value == "" ? 0 : Convert.ToInt32(hfClassCourseID.Value)));
                sqlCmd.Parameters.AddWithValue("@ClassID", id);
                sqlCmd.Parameters.AddWithValue("@InstructorCourseID", txtInstructorCourseID.Text);
                sqlCmd.Parameters.AddWithValue("@AssignedOn", Convert.ToDateTime(txtAssignment.Text));
                sqlCmd.ExecuteNonQuery();
                sqlCon.Close();
                Clear();
                string ClassCourseID = hfClassCourseID.Value;
                if (ClassCourseID == "")
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
                lblErrormessage.Text = "This Course is already enrolled in this Section.";
            }
            
        }
        void FillGridView()
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select c.ClassCourseID,c.InstructorCourseID,cl.ClassName,cl.Section,c.AssignedOn from ClassCourse c join Class cl on cl.ClassID=c.ClassID";
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
            hfClassCourseID.Value = "";
            txtAssignment.Text = " ";
            lblErrormessage.Text = lblSuccessMessage.Text = " ";
            btnAdd.Text = "Add";
            btnDelete.Enabled = false;
        }
        protected void lnk_OnClick(object sender, EventArgs e)
        {
            int classcourseid = Convert.ToInt32((sender as LinkButton).CommandArgument);
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select c.ClassCourseID,c.InstructorCourseID,cl.ClassName,cl.Section,c.AssignedOn from ClassCourse c join Class cl on cl.ClassID = c.ClassID where ClassCourseID = '"+classcourseid+"'";
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            sqlCon.Close();
            hfClassCourseID.Value = classcourseid.ToString();
            txtInstructorCourseID.Text = dt.Rows[0]["InstructorCourseID"].ToString();
            ddlclassname.Text = dt.Rows[0]["ClassName"].ToString();
            ddlsection.Text= dt.Rows[0]["Section"].ToString();
            txtAssignment.Text = dt.Rows[0]["AssignedOn"].ToString();
            btnAdd.Text = "Update";
            btnDelete.Enabled = true;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd1 = new SqlCommand("Delete from Attendence where ClassCourseID='"+hfClassCourseID.Value+"'", sqlCon);
            cmd1.ExecuteNonQuery();
            SqlCommand cmd2 = new SqlCommand("Delete from CourseMaterial where ClassCourseID='" + hfClassCourseID.Value + "'", sqlCon);
            cmd2.ExecuteNonQuery();
            SqlCommand cmd3 = new SqlCommand("Delete from Exam where ClassCourseID='" + hfClassCourseID.Value + "'", sqlCon);
            cmd3.ExecuteNonQuery();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Delete from ClassCourse where ClassCourseID='" + hfClassCourseID.Value + "'";
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