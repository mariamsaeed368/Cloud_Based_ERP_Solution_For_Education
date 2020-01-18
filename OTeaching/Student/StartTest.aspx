<%@ Page Title="" Language="C#" MasterPageFile="~/Student/Student.Master" AutoEventWireup="true" CodeBehind="StartTest.aspx.cs" Inherits="OTeaching.Student.StartTest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="c1" runat="server">
    <form id="form1" runat="server">
    <h2 class="m-4">Answer all the questions</h2>
    <hr/>
        <div>
            <asp:ScriptManager ID="sm" runat="server"/>
            <asp:UpdatePanel ID="up" runat="server">
                <ContentTemplate>
                    <b><asp:Label ID="LabelTimer" runat="server" style="width:100px ; margin-left:25px;"/></b> 
                     <asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick" Interval="1000"></asp:Timer>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    <asp:TextBox ID="getstringuser" runat="server" Visible="false"></asp:TextBox>
    <asp:GridView ID="gridview_examquestion" runat="server" AutoGenerateColumns="false"  GridLines="None" CssClass="mGrid">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="lblid" runat="server" Text='<%# Eval("QuestionID") %>' Visible="false"></asp:Label>
                    <b><span><%#Container.DataItemIndex + 1 %>.</span>
                    <asp:Label ID="lbl_question" runat="server" Text='<%# Eval("Question") %>'></asp:Label></b> 
                    <br />
                    <b><span>a.</span></b>
                    <asp:RadioButton GroupName="a" Text='<%# Eval("Option1") %>' ID="option_one" runat="server" />
                    <br />
                    <b><span>b.</span></b>
                    <asp:RadioButton GroupName="a" Text='<%# Eval("Option2") %>' ID="option_two" runat="server" />
                    <br />
                    <b><span>c.</span></b>
                    <asp:RadioButton GroupName="a" Text='<%# Eval("Option3") %>' ID="option_three" runat="server" />
                    <br />
                    <b><span>d.</span></b>
                    <asp:RadioButton GroupName="a" Text='<%# Eval("Option4") %>' ID="option_four" runat="server" />
                    <hr />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
         <style>
            .mGrid { 
                    width: 96%; 
                    background-color: #fff; 
                    margin-left:25px;
                    border: solid 1px #525252; 
                    border-collapse:collapse; 
                    }
            .mGrid td { 
                     padding: 2px; 
                     border: solid 1px #c1c1c1; 
                     color: #717171; 
            }
            .mGrid th { 
                    padding: 4px 2px; 
                    color: #fff; 
                    background: #424242 url(grd_head.png) repeat-x top; 
                    border-left: solid 1px #525252; 
                    font-size: 0.9em; 
            }
.mGrid .alt { background: #D3D3D3 url(grd_alt.png) repeat-x top; }
.mGrid .pgr { background: #424242 url(grd_pgr.png) repeat-x top; }
.mGrid .pgr table { margin: 5px 0; }
.mGrid .pgr td { 
    border-width: 0; 
    padding: 0 6px; 
    border-left: solid 1px #666; 
    font-weight: bold; 
    color: #fff; 
    line-height: 12px; 
 }   
.mGrid .pgr a { color: #666; text-decoration: none; }
.mGrid .pgr a:hover { color: #000; text-decoration: none; }
             .auto-style1 {
                 float: left;
                 width: 468px;
             }
        </style>
    <asp:Button ID="btn_submit" runat="server" Text="Submit" CssClass="btn btn-success" OnClick="btn_submit_Click" style="margin-left:25px;"/>
    <div class="col-md-12" style="margin-left:15px; width:1250px;">
        <div class="card">
            <div class="card-header">
                <asp:Panel ID="panel_questshow_warning" runat="server" Visible="false">
                    <br />
                    <div class="alert alert-danger text-center">
                        <asp:Label ID="lbl_questshowwarning" runat="server" />
                    </div>
                </asp:Panel>
            </div>
        </div>
    </div>
    </form>
    <script>
        //Set the number of minutes you need
        var mins = 0.5;
        var secs = mins * 60;
        var currentSeconds = 0;
        var currentMinutes = 0;
        var ourtimer;
        function StartCountDown() {
            ourtimer = setTimeout(Decrement, 1000);
        }
        function EndCountDown() {
            clearTimeout(ourtimer);
        }
        $(document).ready(function () { StartCountDown(); }); //start the countdown
        function Decrement() {
            currentMinutes = Math.floor(secs / 60);
            currentSeconds = secs % 60;
            if (currentSeconds <= 9) currentSeconds = "0" + currentSeconds;
            secs--;
            document.getElementById("timerText").innerHTML = "Time Remaining " + currentMinutes + ":" + currentSeconds;
            if (secs !== -1) {
                setTimeout('Decrement()', 1000);
            }
            else {
                window.location.href = "Sign In.aspx?timeout=1"
            }
        }
        </script>
</asp:Content>
