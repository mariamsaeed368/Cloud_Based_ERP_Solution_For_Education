<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminClassReport.aspx.cs" Inherits="OTeaching.Admin.AdminClassReport1" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            
<asp:scriptmanager runat="server"></asp:scriptmanager>
            
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="1100" BackColor="" ClientIDMode="AutoID" HighlightBackgroundColor="" InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" InternalBorderWidth="1px" LinkActiveColor="" LinkActiveHoverColor="" LinkDisabledColor="" PrimaryButtonBackgroundColor="" PrimaryButtonForegroundColor="" PrimaryButtonHoverBackgroundColor="" PrimaryButtonHoverForegroundColor="" SecondaryButtonBackgroundColor="" SecondaryButtonForegroundColor="" SecondaryButtonHoverBackgroundColor="" SecondaryButtonHoverForegroundColor="" SplitterBackColor="" ToolbarDividerColor="" ToolbarForegroundColor="" ToolbarForegroundDisabledColor="" ToolbarHoverBackgroundColor="" ToolbarHoverForegroundColor="" ToolBarItemBorderColor="" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px" ToolBarItemHoverBackColor="" ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226">
                <LocalReport ReportPath="Admin\AdminClassReport.rdlc">
                    <DataSources>
                        <rsweb:ReportDataSource Name="DataSet1" DataSourceId="SqlDataSource1"></rsweb:ReportDataSource>
                    </DataSources>
                </LocalReport>
            </rsweb:ReportViewer>
            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='Data Source=DESKTOP-SI0GDUH\SQLEXPRESS;Initial Catalog=loginDB;Integrated Security=True;MultipleActiveResultSets=true' SelectCommand="SELECT Class.ClassID, Class.ClassName, Class.StartTiming, Class.Section, Class.EndTiming, ClassCourse.ClassID AS Expr1, ClassCourse.InstructorCourseID, ClassCourse.ClassCourseID, ClassCourse.AssignedOn FROM Class INNER JOIN ClassCourse ON Class.ClassID = ClassCourse.ClassID"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
