<%@ page import="java.util.List" %>
<%@ page import="com.brandenbed.entity.TenantQuery" %>
<%@ page import="com.brandenbed.entity.Admin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String adminName = (String) request.getAttribute("adminName");
    List<TenantQuery> queries = (List<TenantQuery>) request.getAttribute("queries");

    int totalQueries = (queries != null) ? queries.size() : 0;
    int pendingQueries = 0;
    int inProgressQueries = 0;
    int resolvedQueries = 0;

    if(queries != null){
        for(TenantQuery q : queries){
            switch(q.getStatus()){
                case PENDING: pendingQueries++; break;
                case IN_PROGRESS: inProgressQueries++; break;
                case RESOLVED: resolvedQueries++; break;
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Tenant Queries | Brandenbed</title>
<style>
body {
    margin:0;
    font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    display:flex;
    min-height:100vh;
    background:#f4f6f9;
}

/* Sidebar */
.sidebar {
    position: fixed;
    top:0; left:0;
    width:240px;
    min-width:240px;
    height:100vh;
    background:linear-gradient(135deg,#2c5282,#3182ce);
    color:#fff;
    display:flex;
    flex-direction:column;
    padding:20px;
    box-sizing:border-box;
    overflow-y:auto;
    flex-shrink:0;
}
.sidebar h2 { text-align:center; margin-bottom:2rem; font-size:1.4rem; }
.sidebar a { text-decoration:none; color:#fff; padding:12px 15px; border-radius:8px; margin-bottom:10px; display:block; transition: background 0.3s; }
.sidebar a:hover, .sidebar a.active { background: rgba(255,255,255,0.2); }
.sidebar .logout { margin-top:auto; background:#e53e3e; text-align:center; padding:12px; border-radius:8px; cursor:pointer; transition: background 0.3s; }
.sidebar .logout:hover { background:#c53030; }

/* Main */
.main { margin-left:240px; flex:1; display:flex; flex-direction:column; overflow:hidden; }
.header { background:#fff; padding:15px 25px; box-shadow:0 2px 10px rgba(0,0,0,0.1); display:flex; justify-content:space-between; align-items:center; flex-shrink:0; }
.header h1 { font-size:1.5rem; color:#2c5282; }
.content { padding:1.5rem 2rem; flex:1; overflow-y:auto; }

/* Cards */
.cards { display:grid; grid-template-columns:repeat(auto-fit,minmax(220px,1fr)); gap:1.5rem; margin-bottom:1.5rem; }
.card { background:#fff; border-radius:12px; padding:1rem; text-align:center; box-shadow:0 4px 15px rgba(0,0,0,0.05); transition: transform 0.2s ease; }
.card:hover { transform:translateY(-3px); }
.card h2 { font-size:1.5rem; color:#3182ce; margin-bottom:0.3rem; }
.card p { color:#4a5568; font-weight:500; }

/* Table */
.table-container { background:#fff; padding:1rem; border-radius:12px; box-shadow:0 4px 15px rgba(0,0,0,0.05); overflow-x:auto; font-size:0.9rem; }
.table-container table { width:100%; border-collapse:collapse; }
.table-container th, .table-container td { padding:12px 10px; text-align:left; border-bottom:1px solid #e2e8f0; }
.table-container th { background:#3182ce; color:#fff; font-weight:600; }
.table-container tr:hover { background:#f1f5f9; cursor:pointer; }
.status { padding:5px 10px; border-radius:12px; font-weight:600; color:#fff; display:inline-block; text-transform:capitalize; }
.status-pending { background-color:#e53e3e; }
.status-in_progress { background-color:#dd6b20; }
.status-resolved { background-color:#38a169; }

/* Modal */
.modal { display:none; position:fixed; z-index:1000; left:0; top:0; width:100%; height:100%; overflow:auto; background-color: rgba(0,0,0,0.5); }
.modal-content { background:#fff; margin:10% auto; padding:20px; border-radius:12px; width:400px; text-align:center; box-shadow:0 5px 20px rgba(0,0,0,0.2); }
.modal-content select { width:80%; padding:10px; margin:15px 0; border-radius:6px; border:1px solid #ccc; }
.modal-content button { padding:10px 25px; border:none; border-radius:8px; margin:5px; cursor:pointer; font-weight:600; font-size:0.95rem; transition: all 0.3s ease; box-shadow:0 4px 12px rgba(0,0,0,0.15); }
.update-btn { background:linear-gradient(135deg,#3182ce,#2c5282); color:#fff; }
.update-btn:hover { background:linear-gradient(135deg,#2c5282,#1e3a5f); transform:translateY(-2px); box-shadow:0 6px 15px rgba(0,0,0,0.25); }
.cancel-btn { background:linear-gradient(135deg,#e53e3e,#c53030); color:#fff; }
.cancel-btn:hover { background:linear-gradient(135deg,#c53030,#9b2c2c); transform:translateY(-2px); box-shadow:0 6px 15px rgba(0,0,0,0.25); }

/* Responsive */
@media(max-width:768px){ .main{margin-left:200px;} .cards{grid-template-columns:repeat(auto-fit,minmax(180px,1fr));} }
@media(max-width:576px){ body{flex-direction:column;} .sidebar{position:relative;width:100%;height:auto;flex-direction:row;overflow-x:auto;padding:10px;} .sidebar h2{display:none;} .sidebar a{display:inline-block;margin:0 5px;padding:8px 12px;} .sidebar .logout{margin-left:auto;margin-right:10px;} .main{margin-left:0;margin-top:10px;} .header{flex-direction:column;align-items:flex-start;} .content{padding:1rem;} }
</style>
</head>
<body>

<div class="sidebar">
    <h2>Brandenbed</h2>
    <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
    <a href="${pageContext.request.contextPath}/admin/propertiesList">Properties</a>
    <a href="${pageContext.request.contextPath}/admin/tenant-queries" class="active">Tenant Queries</a>
    <a href="${pageContext.request.contextPath}/admin/rent-collection">Rent Collection</a>
    <a href="${pageContext.request.contextPath}/admin/employeeList">Employees</a>
    <div class="logout" onclick="window.location.href='${pageContext.request.contextPath}/logout'">Logout</div>
</div>

<div class="main">
    <div class="header">
        <h1>Tenant Queries</h1>
        <div>Welcome, <%= adminName != null ? adminName : "Admin" %></div>
    </div>

    <div class="content">
        <!-- Summary Cards -->
        <div class="cards">
            <div class="card"><h2><%= totalQueries %></h2><p>Total Queries</p></div>
            <div class="card"><h2><%= pendingQueries %></h2><p>Pending</p></div>
            <div class="card"><h2><%= inProgressQueries %></h2><p>In Progress</p></div>
            <div class="card"><h2><%= resolvedQueries %></h2><p>Resolved</p></div>
        </div>

        <!-- Queries Table -->
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Tenant Name</th>
                        <th>Query</th>
                        <th>Date Submitted</th>
                        <th>Status</th>
                        <th>Change Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if(queries != null){
                            int index=1;
                            for(TenantQuery q: queries){
                    %>
                    <tr>
                        <td><%= index++ %></td>
                        <td><%= q.getTenantName() %></td>
                        <td><%= q.getQueryText() %></td>
                        <td><%= q.getDateSubmitted().toLocalDate() %></td>
                        <td>
                            <span class="status status-<%= q.getStatus().name().toLowerCase() %>">
                                <%= q.getStatus().name().replace("_"," ") %>
                            </span>
                        </td>
                        <td><button onclick="openModal(<%= q.getId() %>, '<%= q.getStatus().name() %>')">Change</button></td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal -->
<div id="statusModal" class="modal">
    <div class="modal-content">
        <h3>Update Query Status</h3>
        <select id="modalStatusSelect">
            <option value="PENDING">Pending</option>
            <option value="IN_PROGRESS">In Progress</option>
            <option value="RESOLVED">Resolved</option>
        </select>
        <br>
        <button class="update-btn" onclick="confirmUpdate()">Update</button>
        <button class="cancel-btn" onclick="closeModal()">Cancel</button>
    </div>
</div>

<script>
let currentQueryId = null;

function openModal(id, currentStatus){
    currentQueryId = id;
    document.getElementById('modalStatusSelect').value = currentStatus;
    document.getElementById('statusModal').style.display = 'block';
}

function closeModal(){
    document.getElementById('statusModal').style.display = 'none';
    currentQueryId = null;
}

function confirmUpdate(){
    const newStatus = document.getElementById('modalStatusSelect').value;
    const contextPath = '<%= request.getContextPath() %>';

    fetch(contextPath + '/admin/updateTenantQueryStatus', {
        method:'POST',
        headers:{'Content-Type':'application/x-www-form-urlencoded'},
        body:'id=' + encodeURIComponent(currentQueryId) + '&status=' + encodeURIComponent(newStatus)
    })
    .then(res=>res.text())
    .then(msg=>{ alert(msg); location.reload(); })
    .catch(err=>console.error(err));

    closeModal();
}

window.onclick = function(event){
    const modal = document.getElementById('statusModal');
    if(event.target === modal) closeModal();
}
</script>

</body>
</html>
