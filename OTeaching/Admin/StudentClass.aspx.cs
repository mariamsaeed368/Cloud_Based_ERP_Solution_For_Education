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
    public partial class StudentClass : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-J0A56S8\SQLEXPRESS;Initial Catalog=LoginDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnDelete.Enabled = false;
                filldropdownlist();
                FillGridView();
                txtClassID.Text = Session["test"].ToString();
            }
        }
        void filldropdownlist()
        {
            ddlregistration.Items.Clear();
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand sqlCmd0 = sqlCon.CreateCommand();
            sqlCmd0.CommandType = CommandType.Text;
            sqlCmd0.CommandText = "SELECT RegistrationNo FROM StudentRegistration";
            sqlCmd0.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(sqlCmd0);
            da.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                ddlregistration.Items.Add(dr["RegistrationNo"].ToString());
            }

            sqlCon.Close();
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            sqlCon.Open();
            SqlCommand cmd = new SqlCommand("Select RegistrationID from StudentRegistration where RegistrationNo='"+ddlregistration.Text+"'", sqlCon);
            int id= (int) cmd.ExecuteScalar();
            SqlCommand cmd1 = new SqlCommand("Select Count(*) from Enrollment where RegistrationID='"+id+"'", sqlCon);
            int check = (int)cmd1.ExecuteScalar();
            if( check < 1 )
            {
                string section = Session["Section"].ToString();
                SqlCommand cmd2 = new SqlCommand("Select Count(*) from Enrollment e JOIN Class c on c.ClassID=e.ClassID where c.Section='"+section+"'", sqlCon);
                int count = (int)cmd2.ExecuteScalar();
                if (count < 30)
                {
                    SqlCommand sqlCmd = new SqlCommand("EnrollmentCreateOrUpdate", sqlCon);
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.Parameters.AddWithValue("@StudentEnrollmentID", (hfStudentEnrollmentID.Value == "" ? 0 : Convert.ToInt32(hfStudentEnrollmentID.Value)));
                    sqlCmd.Parameters.AddWithValue("@ClassID", txtClassID.Text);
                    sqlCmd.Parameters.AddWithValue("@RegistrationID", id);
                    sqlCmd.Parameters.AddWithValue("@AssignedOn", Convert.ToDateTime(txtAssignment.Text));
                    sqlCmd.ExecuteNonQuery();
                    sqlCon.Close();
                    Clear();
                    string StudentEnrollmentID = hfStudentEnrollmentID.Value;
                    if (StudentEnrollmentID == "")
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
                    lblSuccessMessage.Text = "You cannot Enroll more than 30 students in the same section.";
                }
                
            }
            else
            {
                lblErrormessage.Text = "This Registration No is already registered in Class";
            }
            
        }
        void FillGridView()
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select e.StudentEnrollmentID,e.ClassID,s.RegistrationNo,e.AssignedOn from Enrollment e Join StudentRegistration s on e.RegistrationID=s.RegistrationID";
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
            hfStudentEnrollmentID.Value = "";
            txtAssignment.Text = " ";
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
            int studentenrollmentid = Convert.ToInt32((sender as LinkButton).CommandArgument);
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select e.StudentEnrollmentID,e.ClassID,s.RegistrationNo,e.AssignedOn from Enrollment e Join StudentRegistration s on e.RegistrationID=s.RegistrationID where StudentEnrollmentID='" + studentenrollmentid + "'";
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            sqlCon.Close();
            hfStudentEnrollmentID.Value = studentenrollmentid.ToString();
            txtClassID.Text = dt.Rows[0]["ClassID"].ToString();
            ddlregistration.Text = dt.Rows[0]["RegistrationNo"].ToString();
            txtAssignment.Text = dt.Rows[0]["AssignedOn"].ToString();
            btnAdd.Text = "Update";
            btnDelete.Enabled = true;
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Delete from Enrollment where StudentEnrollmentID='" + hfStudentEnrollmentID.Value + "'";
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