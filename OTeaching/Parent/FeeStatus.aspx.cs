using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace OTeaching.Parent
{
    public partial class FeeStatus : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-SI0GDUH\SQLEXPRESS;Initial Catalog=loginDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                filldropdownlist();
            }
        }
        void filldropdownlist()
        {
            ddlclassname.Items.Clear();
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand sqlCmd0 = sqlCon.CreateCommand();
            sqlCmd0.CommandType = CommandType.Text;
            sqlCmd0.CommandText = "Select ClassName from Class Group by ClassName";
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
        public void Clear()
        {
            txtRegNo.Text = " ";
            lblErrormessage.Text = lblSuccessMessage.Text = " ";
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            sqlCon.Open();
            SqlCommand cmd2 = new SqlCommand("Select Count(*) from StudentRegistration where RegistrationNo='" + txtRegNo.Text + "'", sqlCon);
            int check1 = (int)cmd2.ExecuteScalar();
            if(check1 != 0)
            {
                SqlCommand cmd = new SqlCommand("Select RegistrationID from StudentRegistration where RegistrationNo='" + txtRegNo.Text + "'", sqlCon);
                int id = (int)cmd.ExecuteScalar();
                SqlCommand cmd1 = new SqlCommand("Select Count(*) from StudentParent where RegistrationID='" + id + "' AND GaurdianID='" + Session["GaurdianID"].ToString() + "'", sqlCon);
                int check = (int)cmd1.ExecuteScalar();
                if (check != 0)
                {
                    SqlCommand cmd3 = new SqlCommand("Select Count(*) from Class c join Enrollment e on e.ClassID = c.ClassID join StudentRegistration sr on sr.RegistrationID = e.RegistrationID where sr.RegistrationID = '"+id+"'", sqlCon);
                    int check2 = (int)cmd3.ExecuteScalar();
                    if(check2!=0)
                    {
                        SqlCommand cmd4 = new SqlCommand("Select c.ClassName from Class c join Enrollment e on e.ClassID = c.ClassID join StudentRegistration sr on sr.RegistrationID = e.RegistrationID where sr.RegistrationID = '" + id + "'", sqlCon);
                        string classname = Convert.ToString(cmd4.ExecuteScalar());
                        if(ddlclassname.SelectedValue==classname)
                        {
                            FillGridView();
                        }
                        else
                        {
                            lblErrormessage.Text = "This Registration Number is not in this Class";
                        }
                    }
                    else
                    {
                        lblErrormessage.Text = "No Such Record Exist.Please Try Again";
                    }
                }
                else
                {
                    lblErrormessage.Text = "Please Enter the Registration Number of your Child.";
                }
            }
            else
            {
                lblErrormessage.Text = "Please Enter Valid Registration No.";
            }
            
        }
        void FillGridView()
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select c.ClassName,f.TutionFee,f.AdmissionFee,f.BusFee,f.LibraryFee,f.TotalFee from Fee f join Class c on c.ClassID=f.ClassID where c.ClassName='"+ddlclassname.SelectedValue+"' ";
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            sqlCon.Close();
        }
    }
}