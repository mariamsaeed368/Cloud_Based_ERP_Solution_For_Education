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
    public partial class Fee : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-SI0GDUH\SQLEXPRESS;Initial Catalog=loginDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnDelete.Enabled = false;
                FillGridView();
                if (sqlCon.State == ConnectionState.Closed)
                    sqlCon.Open();
                SqlCommand cmd = sqlCon.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Select ClassName from Class where ClassID='"+Session["classid"].ToString() + "'";
                string classname=cmd.ExecuteScalar().ToString();
                txtClassName.Text = classname;
            }
        }
        void FillGridView()
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select f.FeeID,c.ClassName,f.TutionFee,f.AdmissionFee,f.LibraryFee,f.BusFee,f.TotalFee from Fee f Join Class c on f.ClassID=c.ClassID";
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            sqlCon.Close();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            int ttlfee = Convert.ToInt32(txtTutionFee.Text) + Convert.ToInt32(txtAdmissionFee.Text) + Convert.ToInt32(txtLibraryFee.Text) + Convert.ToInt32(txtBusFee.Text);
            txtTotalFee.Text = ttlfee.ToString();
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd1 = new SqlCommand("Select Count(c.ClassName) from Fee f Join Class c on f.ClassID=c.ClassID",sqlCon);
            int check = (int)cmd1.ExecuteScalar();
            if (check < 1)
            {
                SqlCommand sqlCmd = new SqlCommand("FeeCreateOrUpdate", sqlCon);
                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.AddWithValue("@FeeID", (hfFeeID.Value == "" ? 0 : Convert.ToInt32(hfFeeID.Value)));
                sqlCmd.Parameters.AddWithValue("@ClassID", Session["classid"].ToString());
                sqlCmd.Parameters.AddWithValue("@TutionFee", txtTutionFee.Text);
                sqlCmd.Parameters.AddWithValue("@AdmissionFee", txtAdmissionFee.Text);
                sqlCmd.Parameters.AddWithValue("@LibraryFee", txtLibraryFee.Text);
                sqlCmd.Parameters.AddWithValue("@BusFee", txtBusFee.Text);
                sqlCmd.Parameters.AddWithValue("@TotalFee", txtTotalFee.Text);
                sqlCmd.ExecuteNonQuery();
                sqlCon.Close();
                Clear();
                string feeID = hfFeeID.Value;
                if (feeID == "")
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
                lblErrormessage.Text = "The Fee for this Class has been added already";
            }
            
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }
        public void Clear()
        {
            hfFeeID.Value = "";
            txtClassName.Text = txtTotalFee.Text = txtAdmissionFee.Text = txtBusFee.Text =txtLibraryFee.Text=txtTutionFee.Text= " ";
            lblErrormessage.Text = lblSuccessMessage.Text = " ";
            btnAdd.Text = "Add";
            btnDelete.Enabled = false;
        }
        protected void lnk_OnClick(object sender, EventArgs e)
        {
            int feeid = Convert.ToInt32((sender as LinkButton).CommandArgument);
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select f.FeeID,c.ClassName,f.TutionFee,f.AdmissionFee,f.LibraryFee,f.BusFee,f.TotalFee from Fee f Join Class c on f.ClassID=c.ClassID where f.FeeID='"+feeid.ToString()+"'";
            cmd.ExecuteNonQuery();
            DataTable dtbl = new DataTable();
            SqlDataAdapter sqlDa = new SqlDataAdapter(cmd);
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            hfFeeID.Value = feeid.ToString();
            txtClassName.Text = dtbl.Rows[0]["ClassName"].ToString();
            txtTutionFee.Text = dtbl.Rows[0]["TutionFee"].ToString();
            txtAdmissionFee.Text = dtbl.Rows[0]["AdmissionFee"].ToString();
            txtLibraryFee.Text = dtbl.Rows[0]["LibraryFee"].ToString();
            txtBusFee.Text= dtbl.Rows[0]["BusFee"].ToString();
            int ttlfee=Convert.ToInt32(txtTutionFee.Text)+ Convert.ToInt32(txtAdmissionFee.Text) + Convert.ToInt32(txtLibraryFee.Text) + Convert.ToInt32(txtBusFee.Text);
            txtTotalFee.Text = ttlfee.ToString();
            btnAdd.Visible = false;
            btnUpdate.Visible = true;
            btnDelete.Enabled = true;
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd1 = new SqlCommand("Delete from Fee where FeeID='" + hfFeeID.Value + "'", sqlCon);
            cmd1.ExecuteNonQuery();
            lblSuccessMessage.Text = "Deleted Successfully";
            FillGridView();
            Clear();
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int ttlfee = Convert.ToInt32(txtTutionFee.Text) + Convert.ToInt32(txtAdmissionFee.Text) + Convert.ToInt32(txtLibraryFee.Text) + Convert.ToInt32(txtBusFee.Text);
            txtTotalFee.Text = ttlfee.ToString();
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd1 = new SqlCommand("Update Fee SET ClassID = '"+ Session["classid"].ToString() + "',TutionFee ='"+txtTutionFee.Text+"',AdmissionFee = '"+txtAdmissionFee.Text+"',LibraryFee = '"+txtLibraryFee.Text+"', BusFee = '"+txtBusFee.Text+"',TotalFee = '"+txtTotalFee.Text+"' where FeeID='" + hfFeeID.Value + "'", sqlCon);
            cmd1.ExecuteNonQuery();
            lblSuccessMessage.Text = "Updated Successfully";
            btnAdd.Visible = true;
            btnUpdate.Visible = false;
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