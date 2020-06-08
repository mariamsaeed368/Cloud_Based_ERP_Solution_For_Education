<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResultReport.aspx.cs" Inherits="OTeaching.Instructor.ResultReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager2" runat="server"></asp:ScriptManager>
            <rsweb:ReportViewer ID="ReportViewer1" runat="server"></rsweb:ReportViewer>
            



            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='Data Source=DESKTOP-BDBIBK1;Initial Catalog=LoginDB;Integrated Security=True' SelectCommand="SELECT Exam.ExamName, StudentRegistration.Name AS StudentName, StudentRegistration.RegistrationNo, Exam.ExamMarks AS TotalMarks, Result.ResultScore, Result.ResultStatus FROM Exam INNER JOIN Result ON Exam.ExamID = Result.ExamID CROSS JOIN StudentRegistration"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
