﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.IO;

namespace OTeaching.Instructor
{
    public partial class UploadCourseMaterial : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-BDBIBK1;Initial Catalog=LoginDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            txtInstructorCourseID.Text = Session["instructorcourseid"].ToString();
            FillGridView();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string fname = FileUpload1.FileName;
            string flocation = "CourseRelatedStuff/";
            string pathstring = System.IO.Path.Combine(flocation, fname);
            sqlCon.Open();
            SqlCommand cmd = new SqlCommand("Insert into CourseMaterial(InstructorCourseID,FileName,FileLocation) values('" + txtInstructorCourseID.Text + "','" + txtFileName.Text + "','" + pathstring + "')", sqlCon);
            cmd.ExecuteNonQuery();
            //Saving the physcal file location
            string path = Server.MapPath(pathstring);
            FileUpload1.SaveAs(@path);
            lblSuccessMessage.Text = "File Uploaded Successfully";
        }
        public void Clear()
        {
            txtFileName.Text = " ";
            hfUploadID.Value = " ";
            lblErrormessage.Text = lblSuccessMessage.Text = " ";
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }
        void FillGridView()
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select * from CourseMaterial";
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
            }
            else
            {
                lblErrormessage.Text = "This file does not exists ";
            }
        }
    }
}