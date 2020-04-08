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
    public partial class TakeFee : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-BDBIBK1;Initial Catalog=LoginDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtstdregno.Text = Session["RegistrationNo"].ToString();
                if (sqlCon.State == ConnectionState.Closed)
                    sqlCon.Open();
                SqlCommand cmd1 = new SqlCommand("Select RegistrationID from StudentRegistration where RegistrationNo='" + txtstdregno.Text + "'", sqlCon);
                int id = (int)cmd1.ExecuteScalar();
                SqlCommand cmd = new SqlCommand("Select c.ClassName from Class c join Enrollment e on e.ClassID = c.ClassID join StudentRegistration sr on sr.RegistrationID = e.RegistrationID where sr.RegistrationID = '" + id + "'", sqlCon);
                string classname = Convert.ToString(cmd.ExecuteScalar());
                SqlCommand cmd2 = new SqlCommand("Select f.TotalFee from Fee f join Class c on c.ClassID=f.ClassID where c.ClassName='"+classname+"'", sqlCon);
                string classfee = Convert.ToString(cmd2.ExecuteScalar());
                txtClassFee.Text = classfee;
                FillGridView();
            }
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
           // FillGridView(); //bindgridview will get the data source and bind it again
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd1 = new SqlCommand("Select RegistrationID from StudentRegistration where RegistrationNo='" + txtstdregno.Text + "'", sqlCon);
            int id = (int)cmd1.ExecuteScalar();
            SqlCommand cmd = new SqlCommand("Select c.ClassName from Class c join Enrollment e on e.ClassID = c.ClassID join StudentRegistration sr on sr.RegistrationID = e.RegistrationID where sr.RegistrationID = '" + id + "'", sqlCon);
            string classname = Convert.ToString(cmd.ExecuteScalar());
            SqlCommand cmd3 = new SqlCommand("Select f.FeeID from Fee f join Class c on c.ClassID=f.ClassID where c.ClassName='" + classname + "'", sqlCon);
            string feeid = Convert.ToString(cmd3.ExecuteScalar());
            SqlCommand sqlCmd = new SqlCommand("TakeFeeCreateOrUpdate", sqlCon);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@TakeFeeID", (hfTakeFeeID.Value == "" ? 0 : Convert.ToInt32(hfTakeFeeID.Value)));
            sqlCmd.Parameters.AddWithValue("@StudentParentID", Session["StudentParentID"].ToString());
            sqlCmd.Parameters.AddWithValue("@FeeID",feeid);
            sqlCmd.Parameters.AddWithValue("@Date", Convert.ToDateTime(txtDate.Text));
            sqlCmd.ExecuteNonQuery();
            sqlCon.Close();
            Clear();
            string TakeFeeID = hfTakeFeeID.Value;
            if (TakeFeeID == "")
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
            hfTakeFeeID.Value = "";
            txtDate.Text = " ";
            lblErrormessage.Text = lblSuccessMessage.Text = " ";
            btnAdd.Text = "Add";
            btnDelete.Enabled = false;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }
        public void FillGridView()
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select tf.TakeFeeID,st.RegistrationNo,f.TotalFee,tf.Date from StudentRegistration st join Enrollment e on e.RegistrationID=st.RegistrationID join Class c on c.ClassID=e.ClassID join StudentParent sp on sp.RegistrationID=st.RegistrationID join TakeFee tf on tf.StudentParentID=sp.StudentParentID join Fee f on f.FeeID=tf.FeeID";
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            sqlCon.Close();
        }
        protected void lnk_OnClick(object sender, EventArgs e)
        {
            int takefeeid = Convert.ToInt32((sender as LinkButton).CommandArgument);
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select st.RegistrationNo,f.TotalFee,tf.Date from StudentRegistration st join Enrollment e on e.RegistrationID=st.RegistrationID join Class c on c.ClassID=e.ClassID join StudentParent sp on sp.RegistrationID=st.RegistrationID join TakeFee tf on tf.StudentParentID=sp.StudentParentID join Fee f on f.FeeID=tf.FeeID where tf.TakeFeeID='"+takefeeid+"'";
            cmd.ExecuteNonQuery();
            DataTable dtbl = new DataTable();
            SqlDataAdapter sqlDa = new SqlDataAdapter(cmd);
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            hfTakeFeeID.Value = takefeeid.ToString();
            txtClassFee.Text = dtbl.Rows[0]["TotalFee"].ToString();
            txtstdregno.Text = dtbl.Rows[0]["RegistrationNo"].ToString();
            txtDate.Text = dtbl.Rows[0]["Date"].ToString();
            btnAdd.Text = "Update";
            btnDelete.Enabled = true;
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd1 = new SqlCommand("Delete from TakeFee where TakeFeeID='" + hfTakeFeeID.Value + "'", sqlCon);
            cmd1.ExecuteNonQuery();
            lblSuccessMessage.Text = "Deleted Successfully";
            FillGridView();
            Clear();
        }
    }
}