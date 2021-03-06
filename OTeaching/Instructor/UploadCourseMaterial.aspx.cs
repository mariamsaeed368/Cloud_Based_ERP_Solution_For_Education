﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace OTeaching.Instructor
{
    public partial class UploadCourseMaterial : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-SI0GDUH\SQLEXPRESS;Initial Catalog=loginDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                txtClassCourseID.Text = Session["classcourseid"].ToString();
                FillGridView();
            }           
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string fname = FileUpload1.FileName;
            string flocation = "CourseRelatedStuff/";
            string pathstring = System.IO.Path.Combine(flocation, fname);
            sqlCon.Open();
            SqlCommand cmd1 = new SqlCommand("Select * from CourseMaterial where FileLocation='" + pathstring + "' And ClassCourseID='" + txtClassCourseID.Text + "'",sqlCon);
            int check = (int)cmd1.ExecuteNonQuery();
            if (check < 1)
            {
                SqlCommand cmd = new SqlCommand("Insert into CourseMaterial(ClassCourseID,FileName,FileLocation) values('" + txtClassCourseID.Text + "','" + txtFileName.Text + "','" + pathstring + "')", sqlCon);
                cmd.ExecuteNonQuery();
                //Saving the physcal file location
                string path = Server.MapPath(pathstring);
                FileUpload1.SaveAs(@path);
                lblSuccessMessage.Text = "File Uploaded Successfully";
                FillGridView();
            }
            else
            {
                lblErrormessage.Text = "This File has already been uploaded in this Section.";
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtFileName.Text = " ";
            hfUploadID.Value = " ";
            lblErrormessage.Text = lblSuccessMessage.Text = " ";
        }
        void FillGridView()
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select cm.* from Instructor i join InstructorCourse ic on ic.InstructorID=i.InstructorID join ClassCourse cc on cc.InstructorCourseID=ic.InstructorCourseID join CourseMaterial cm on cm.ClassCourseID=cc.ClassCourseID where i.InstructorID='"+ Session["InstructorID"]+"'";
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            sqlCon.Close();
        }
        protected void lnkdelete_OnClick(object sender, EventArgs e)
        {
            int rowindex = ((GridViewRow)((sender as Control)).NamingContainer).RowIndex;
            string filelocation = GridView1.Rows[rowindex].Cells[2].Text;
            string filepath = Server.MapPath("~/Instructor/" + filelocation);
            FileInfo file = new FileInfo(filepath);
            if (file.Exists)//check file exsit or not
            {
                file.Delete();
                sqlCon.Open();
                int uploadid = Convert.ToInt32((sender as LinkButton).CommandArgument);
                SqlCommand cmd = new SqlCommand("Delete From CourseMaterial where UploadID='" + uploadid + "'", sqlCon);
                cmd.ExecuteNonQuery();
                lblSuccessMessage.Text = "File deleted successfully";
                FillGridView();
            }
            else
            {
                lblErrormessage.Text = "This file does not exists ";
                FillGridView();
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            FillGridView(); //bindgridview will get the data source and bind it again
        }
    }
}