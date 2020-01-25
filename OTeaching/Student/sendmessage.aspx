<%@ Page Title="" Language="C#" MasterPageFile="~/Student/Student.Master" AutoEventWireup="true" CodeBehind="sendmessage.aspx.cs" Inherits="OTeaching.Student.sendmessage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="c1" runat="server">
    <form id="form1" runat="server">
<div class="container-fluid" style="background-color:white; padding:20px">
    <asp:Repeater ID="Repeater1" runat="server">
        <HeaderTemplate>
            <table class="table table-bordered" id="example">
                <thead>
                    <tr> 
                        <th>Instructor Username</th>
                        <th>Instructor Name</th>
                        <th>Class Name</th>
                        <th>Course Name</th>
                        <th>Section</th>
                        <th>message</th>
                    </tr>
                </thead>
                <tbody>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td>
                    <%#Eval("Instructor_Username")%>
                </td>
                <td>
                    <%#Eval("Name")%>
                </td>
                <td>
                    <%#Eval("ClassName")%>
                </td>
                <td>
                    <%#Eval("CourseName")%>
                </td>
                <td>
                    <%#Eval("Section")%>
                </td>
                <td>
                    <a href="communication.aspx?username=<%#Eval("Instructor_Username")%>">Send Message</a>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </tbody>
            </table>
        </FooterTemplate>
    </asp:Repeater>
        </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#example').DataTable({
                "pagingType": "full_numbers"
            });
        });
 </script>
    </form>
</asp:Content>
