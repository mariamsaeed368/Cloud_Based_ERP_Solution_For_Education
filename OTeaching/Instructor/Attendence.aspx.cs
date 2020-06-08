using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace OTeaching.Instructor
{
    public partial class Attendence : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-BDBIBK1;Initial Catalog=LoginDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Label1.Text = "Mark Attendance for " + DateTime.Now.ToShortDateString();
                FillGridView();
            }
            
        }
        void FillGridView()
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select s.RegistrationID,s.Name as StudentName,s.RegistrationNo,c.ClassName,c.Section,cs.CourseName from StudentRegistration s join Enrollment e on e.RegistrationID = s.RegistrationID  join Class c on c.ClassID = e.ClassID join ClassCourse cc on cc.ClassID = c.ClassID join InstructorCourse ic on ic.InstructorCourseID = cc.InstructorCourseID join Instructor i on i.InstructorID = ic.InstructorID join Courses cs on cs.CourseID = ic.CourseID where cc.ClassCourseID = '" + Session["classcourseid"] + "'";
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            sqlCon.Close();
        }
        public int status1;
        protected void btnAdd_Click(object sender, EventArgs e)
        {

            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            foreach (GridViewRow row in GridView1.Rows)
            {
                Label regno = (row.Cells[0].FindControl("RegistrationID") as Label);

                //string registrationid = row.Cells[0].Text;
                int classcourseid = Convert.ToInt32(Session["classcourseid"].ToString());
                String dateofclass1 = DateTime.Now.ToShortDateString();
                RadioButton rbtn1 = (row.Cells[6].FindControl("RadioButton1") as RadioButton);
                RadioButton rbtn2 = (row.Cells[6].FindControl("RadioButton2") as RadioButton);
                RadioButton rbtn3 = (row.Cells[6].FindControl("RadioButton3") as RadioButton);
                if (rbtn1.Checked)
                {
                    status1 = 1;

                }
                else if(rbtn2.Checked)
                {
                    status1 = 2;
                }
                else
                {
                    status1 = 2;
                }
                SqlCommand cmd1 = new SqlCommand("Select Count(*) from Attendence where RegistrationID='"+regno.Text+"' and Date='"+Convert.ToDateTime(dateofclass1)+"' and ClassCourseID='"+classcourseid+"'", sqlCon);
                int check = (int)cmd1.ExecuteScalar();
                if(check < 1)
                {
                    String query = "Insert into Attendence(RegistrationID,ClassCourseID,Status,Date) values('" + regno.Text + "','" + classcourseid + "','" + status1 + "','" + Convert.ToDateTime(dateofclass1) + "')";
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandText = query;
                    cmd.Connection = sqlCon;
                    cmd.ExecuteNonQuery();
                    Label2.Text = "Attendance Has Been Saved Successfully";
                }
                else
                {
                    Label2.Text = "Attendence is already stored in Database.";
                }
            }
        }
        protected void GridView1_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            //NewEditIndex property used to determine the index of the row being edited.  
            GridView1.EditIndex = e.NewEditIndex;
            FillGridView();
        }
        protected void GridView1_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            //Finding the controls from Gridview for the row which is going to update
            Label registrationid =(GridView1.Rows[e.RowIndex].FindControl("RegistrationID") as Label);
            int classcourseid = Convert.ToInt32(Session["classcourseid"].ToString());
            RadioButton rbtn1 = (GridView1.Rows[e.RowIndex].FindControl("RadioButton1") as RadioButton);
            RadioButton rbtn2 = (GridView1.Rows[e.RowIndex].FindControl("RadioButton2") as RadioButton);
            RadioButton rbtn3 = (GridView1.Rows[e.RowIndex].FindControl("RadioButton3") as RadioButton);
            if (rbtn1.Checked)
            {
                status1 = 1;

            }
            else if (rbtn2.Checked)
            {
                status1 = 2;
            }
            else
            {
                status1 = 2;
            }
            //updating the record  
            SqlCommand cmd = new SqlCommand("Update Attendence set Status='" + status1 + "' where ClassCourseID='" + classcourseid+"' AND RegistrationID='"+registrationid.Text+"'", sqlCon);
            cmd.ExecuteNonQuery();
            Label2.Text = "Updated Successfully.";
            sqlCon.Close();
            //Setting the EditIndex property to -1 to cancel the Edit mode in Gridview  
            GridView1.EditIndex = -1;
            //Call ShowData method for displaying updated data  
            FillGridView();
        }

        protected void GridView1_RowCancelingEdit1(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            FillGridView();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            FillGridView(); //bindgridview will get the data source and bind it again
        }
    }
}