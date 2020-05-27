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
    public partial class StudentParentRelationship : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-J0A56S8\SQLEXPRESS;Initial Catalog=LoginDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnDelete.Enabled = false;
                FillGridView();
                txtGaurdianID.Text = Session["gaurdianid"].ToString();
            }
        }
        void FillGridView()
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select sp.StudentParentID,sp.GaurdianID,sr.RegistrationNo,sp.RelationshipType from StudentParent sp join StudentRegistration sr on sr.RegistrationID=sp.RegistrationID";
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            sqlCon.Close();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }
        public void Clear()
        {
            hfStudentParentID.Value = "";
            txtGaurdianID.Text = txtsturegno.Text = " ";
            lblErrormessage.Text = lblSuccessMessage.Text = " ";
            btnAdd.Text = "Add";
            btnDelete.Enabled = false;
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd2 = new SqlCommand("select Count(*) from StudentRegistration where RegistrationNo='" + txtsturegno.Text + "'", sqlCon);
            int check = (int)cmd2.ExecuteScalar();
            if (check == 0)
            {
                lblErrormessage.Text = "Sorry! This Registration No does not exist in our database.";
            }
            else
            {
                SqlCommand cmd1 = new SqlCommand("Select RegistrationID from StudentRegistration where RegistrationNo='" + txtsturegno.Text + "'", sqlCon);
                int regid = (int)cmd1.ExecuteScalar();
                SqlCommand cmd3 = new SqlCommand("select Count(*) from StudentParent where RegistrationID='" + regid + "' AND RelationshipType='" + ddlRelationshipType.SelectedItem.Text + "'", sqlCon);
                int check1 = (int)cmd3.ExecuteScalar();
                if(check1 < 1 )
                {
               
                    SqlCommand sqlCmd = new SqlCommand("RelationCreateOrUpdate", sqlCon);
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.Parameters.AddWithValue("@StudentParentID", (hfStudentParentID.Value == "" ? 0 : Convert.ToInt32(hfStudentParentID.Value)));
                    sqlCmd.Parameters.AddWithValue("@GaurdianID", txtGaurdianID.Text);
                    sqlCmd.Parameters.AddWithValue("@RelationshipType", ddlRelationshipType.SelectedItem.Text);
                    sqlCmd.Parameters.AddWithValue("@RegistrationID", regid);
                    sqlCmd.ExecuteNonQuery();
                    sqlCon.Close();
                    Clear();
                    string StudentParentID = hfStudentParentID.Value;
                    if (StudentParentID == "")
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
                    lblErrormessage.Text = "The Relationship with this student has already been declared.";
                }
            }
        }
        protected void lnkTakeFee_OnClick(object sender, EventArgs e)
        {
            LinkButton btndetails = sender as LinkButton;
            GridViewRow gvrow = (GridViewRow)btndetails.NamingContainer;
            LinkButton ln = (LinkButton)GridView1.Rows[gvrow.RowIndex].FindControl("lnkTakeFee");
            string[] arguments = ln.CommandArgument.ToString().Split(new char[] { '~' });
            Session["StudentParentID"] = arguments[0];
            Session["RegistrationNo"] = arguments[1];
            Response.Redirect("TakeFee.aspx");
        }

        protected void lnk_OnClick(object sender, EventArgs e)
        {
            int studentparentid = Convert.ToInt32((sender as LinkButton).CommandArgument);
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select sp.StudentParentID,sr.RegistrationNo,sp.RelationshipType,sp.GaurdianID from StudentParent sp join StudentRegistration sr on sr.RegistrationID=sp.RegistrationID where sp.StudentParentID='"+studentparentid+ "'";
            cmd.ExecuteNonQuery();
            DataTable dtbl = new DataTable();
            SqlDataAdapter sqlDa = new SqlDataAdapter(cmd);
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            hfStudentParentID.Value = studentparentid.ToString();
            txtGaurdianID.Text = dtbl.Rows[0]["GaurdianID"].ToString();
            txtsturegno.Text = dtbl.Rows[0]["RegistrationNo"].ToString();
            ddlRelationshipType.SelectedItem.Text = dtbl.Rows[0]["RelationshipType"].ToString();
            btnAdd.Text = "Update";
            btnDelete.Enabled = true;
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd1 = new SqlCommand("Delete from StudentParent where StudentParentID='" + hfStudentParentID.Value + "'", sqlCon);
            cmd1.ExecuteNonQuery();
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