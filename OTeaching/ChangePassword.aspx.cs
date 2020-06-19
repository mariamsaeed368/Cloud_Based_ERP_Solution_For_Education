using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OTeaching
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!IsPasswordResetLinkValid())
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Password Reset link has expired or is invalid";
                }
            }
        }
        private bool IsPasswordResetLinkValid()
        {
            List<SqlParameter> paramList = new List<SqlParameter>()
            {
                    new SqlParameter()
                    {
                        ParameterName = "@GUID",
                        Value = Request.QueryString["uid"]
                    }
            };
            return ExecuteSP("spIsPasswordResetLinkValid", paramList);
        }
        private bool ExecuteSP(string SPName, List<SqlParameter> SPParameters)
        {
            string CS = @"Data Source=DESKTOP-SI0GDUH\SQLEXPRESS;Initial Catalog=loginDB;Integrated Security=True";
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand(SPName, con);
                cmd.CommandType = CommandType.StoredProcedure;

                foreach (SqlParameter parameter in SPParameters)
                {
                    cmd.Parameters.Add(parameter);
                }

                con.Open();
                return Convert.ToBoolean(cmd.ExecuteScalar());
            }
        }
        private bool ChangeUserPassword()
        {
            List<SqlParameter> paramList = new List<SqlParameter>()
            {
                new SqlParameter()
                {
                    ParameterName = "@GUID",
                    Value = Request.QueryString["uid"]
                },
                new SqlParameter()
                {
                    ParameterName = "@Password",
                    Value = tbpassword.Text
                }
            };
            return ExecuteSP("spChangePassword", paramList);
        }

        protected void btnchangepassword_Click(object sender, EventArgs e)
        {
            if (ChangeUserPassword())
            {
                lblMessage.Text = "Password Changed Successfully!";
            }
            else
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Password Reset link has expired or is invalid";
            }
        }
    }
}