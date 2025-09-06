<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Set, java.util.HashSet, java.util.ArrayList" %>
<%@ page import="com.brandenbed.entity.Transaction" %>
<%
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    if (currentPage == null) currentPage = 0;

    Integer totalPages = (Integer) request.getAttribute("totalPages");
    if (totalPages == null || totalPages == 0) totalPages = 1;

    String adminName = (String) request.getAttribute("adminName");
    List<Transaction> payments = (List<Transaction>) request.getAttribute("payments");

    double totalCollected = 0;
    double totalPending = 0;
    Set<String> propertySet = new HashSet<>();
    Set<String> paymentTypeSet = new HashSet<>();

    if(payments != null){
        for(Transaction t : payments){
            if("Confirmed".equalsIgnoreCase(t.getStatus())){
                totalCollected += t.getAmount();
            } else if("Pending".equalsIgnoreCase(t.getStatus())){
                totalPending += t.getAmount();
            }
            if(t.getProperty() != null) propertySet.add(t.getProperty().getName());
            paymentTypeSet.add(t.getTransactionType());
        }
    }

    int uniqueProperties = propertySet.size();
    int uniquePaymentTypes = paymentTypeSet.size();

    String selectedStatus = (String) request.getAttribute("selectedStatus");
    List<Transaction> filteredPayments = new ArrayList<>();
    if(payments != null){
        for(Transaction t : payments){
            if(selectedStatus == null || selectedStatus.isEmpty() || selectedStatus.equalsIgnoreCase(t.getStatus())){
                filteredPayments.add(t);
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Rent Collection | Brandenbed</title>
<style>
/* ---------- Body & Layout ---------- */
body {
    margin: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #f4f6f9;
    display: flex;
    min-height: 100vh;
    overflow-x: hidden;
}

/* ---------- Sidebar ---------- */
.sidebar {
    position: fixed;
    top: 0;
    left: 0;
    width: 240px;
    min-width: 240px;
    height: 100vh;
    background: linear-gradient(135deg, #2c5282, #3182ce);
    color: #fff;
    display: flex;
    flex-direction: column;
    padding: 20px;
    box-sizing: border-box;
    overflow-y: auto;
    flex-shrink: 0;
    transition: all 0.3s ease;
    z-index: 100;
}

.sidebar h2 {
    text-align: center;
    margin-bottom: 2rem;
    font-size: 1.4rem;
}

.sidebar a {
    text-decoration: none;
    color: #fff;
    padding: 12px 15px;
    border-radius: 8px;
    margin-bottom: 10px;
    display: block;
    transition: background 0.3s, padding-left 0.3s;
}

.sidebar a:hover, .sidebar a.active {
    background: rgba(255, 255, 255, 0.2);
    padding-left: 20px;
}

.sidebar .logout {
    margin-top: auto;
    background: #e53e3e;
    text-align: center;
    padding: 12px;
    border-radius: 8px;
    cursor: pointer;
    transition: background 0.3s, transform 0.2s;
}

.sidebar .logout:hover {
    background: #c53030;
    transform: translateY(-2px);
}

/* ---------- Main Content ---------- */
.main {
    margin-left: 240px;
    flex: 1;
    display: flex;
    flex-direction: column;
    overflow: hidden;
}

.header {
    background: #fff;
    padding: 15px 25px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-shrink: 0;
}
.header h1 { font-size: 1.5rem; color: #2c5282; }

.content {
    padding: 1.5rem 2rem;
    flex: 1;
    overflow-y: auto;
}

/* ---------- Cards ---------- */
.cards {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 1.5rem;
    margin-bottom: 1.5rem;
}
.card {
    background: #fff;
    border-radius: 12px;
    padding: 1rem;
    text-align: center;
    box-shadow: 0 4px 15px rgba(0,0,0,0.05);
    transition: transform 0.2s ease;
}
.card:hover { transform: translateY(-3px); }
.card h2 { font-size: 1.5rem; color: #3182ce; margin-bottom: 0.3rem; }
.card p { color: #4a5568; font-weight: 500; }

/* ---------- Filter ---------- */
.filters {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-bottom: 1rem;
}
.filters select {
    padding: 10px 12px;
    border-radius: 12px;
    border: 1px solid #ccc;
    font-size: 0.9rem;
}

/* ---------- Table ---------- */
.table-container {
    background: #fff;
    padding: 0.8rem;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.05);
    overflow-x: auto;
    font-size: 0.9rem;
}
.table-container table {
    width: 100%;
    border-collapse: collapse;
}
.table-container th, .table-container td {
    padding: 12px 10px;
    text-align: center;
    border-bottom: 1px solid #e2e8f0;
}
.table-container th {
    background: #3182ce;
    color: #fff;
}
.table-container tr:hover { background: #f1f5f9; }

/* ---------- Status ---------- */
.status-confirmed { color: #38a169; font-weight: bold; }
.status-pending { color: #e53e3e; font-weight: bold; }
.status-failed { color: #718096; font-weight: bold; }

/* ---------- Pagination ---------- */
.pagination {
    display: flex;
    list-style: none;
    padding: 0;
    gap: 5px;
    justify-content: center;
    margin-top: 1rem;
}
.pagination li {
    display: inline-block;
}
.pagination .page-link {
    padding: 6px 12px;
    border-radius: 6px;
    border: 1px solid #cbd5e0;
    color: #2c5282;
    text-decoration: none;
    cursor: pointer;
}
.pagination .page-item.active .page-link {
    background-color: #3182ce;
    border-color: #3182ce;
    color: #fff;
}

/* ---------- Media Queries ---------- */
@media (max-width: 1200px) { .cards { grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); } }
@media (max-width: 768px) {
    .main { margin-left: 200px; }
    .header { padding: 12px 20px; }
}
@media (max-width: 576px) {
    body { flex-direction: column; }
    .sidebar { position: relative; width: 100%; height: auto; flex-direction: row; overflow-x: auto; padding: 10px; }
    .sidebar h2 { display: none; }
    .sidebar a { display: inline-block; margin: 0 5px; padding: 8px 12px; }
    .sidebar .logout { margin-left: auto; margin-right: 10px; }
    .main { margin-left: 0; margin-top: 10px; }
    .header { flex-direction: column; align-items: flex-start; }
    .content { padding: 1rem; }
}
</style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h2>Brandenbed</h2>
    <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
    <a href="${pageContext.request.contextPath}/admin/propertiesList">Properties</a>
    <a href="${pageContext.request.contextPath}/admin/tenant-queries">Tenant Queries</a>
    <a href="${pageContext.request.contextPath}/admin/rent-collection" class="active">Rent Collection</a>
    <a href="${pageContext.request.contextPath}/admin/employeeList">Employees</a>
    <div class="logout" onclick="window.location.href='${pageContext.request.contextPath}/logout'">Logout</div>
</div>

<!-- Main -->
<div class="main">
    <div class="header">
        <h1>Rent Collection</h1>
        <div>Welcome, <%= adminName != null ? adminName : "Admin" %></div>
    </div>

    <div class="content">
        <!-- Summary Cards -->
        <div class="cards">
            <div class="card"><h2>€<%= String.format("%.2f", totalCollected) %></h2><p>Total Collected</p></div>
            <div class="card"><h2>€<%= String.format("%.2f", totalPending) %></h2><p>Total Pending</p></div>
            <div class="card"><h2><%= uniqueProperties %></h2><p>Properties Collected</p></div>
            <div class="card"><h2><%= uniquePaymentTypes %></h2><p>Payment Types Used</p></div>
        </div>

        <!-- Filter -->
        <div class="filters">
            <form method="get" action="rent-collection" style="display:flex; gap:10px; flex-wrap:wrap;">
                <select name="status" onchange="this.form.submit()">
                    <option value="">All Status</option>
                    <option value="Confirmed" <%= "Confirmed".equals(selectedStatus)?"selected":"" %>>Confirmed</option>
                    <option value="Pending" <%= "Pending".equals(selectedStatus)?"selected":"" %>>Pending</option>
                    <option value="Failed" <%= "Failed".equals(selectedStatus)?"selected":"" %>>Failed</option>
                </select>
            </form>
        </div>

        <!-- Payment Table -->
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Property</th>
                        <th>Tenant</th>
                        <th>Amount</th>
                        <th>Payment Type</th>
                        <th>Transaction ID</th>
                        <th>Payment Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% if(filteredPayments != null && !filteredPayments.isEmpty()){
                        for(Transaction t : filteredPayments){ %>
                    <tr>
                        <td><%= t.getProperty()!=null?t.getProperty().getName():"-" %></td>
                        <td><%= t.getResident()!=null?t.getResident().getName():"-" %></td>
                        <td>€<%= String.format("%.2f", t.getAmount()) %></td>
                        <td><%= t.getTransactionType() %></td>
                        <td><%= t.getTransactionId() %></td>
                        <td><%= t.getTransactionDate() %></td>
                        <td class="status-<%= t.getStatus().toLowerCase() %>"><%= t.getStatus() %></td>
                    </tr>
                    <% } } else { %>
                    <tr><td colspan="7" style="text-align:center;">No payments found</td></tr>
                    <% } %>
                </tbody>
            </table>

            <!-- Pagination -->
            <ul class="pagination">
                <% if(currentPage>0){ %>
                <li class="page-item"><a class="page-link" href="?page=<%=currentPage-1%>&status=<%=selectedStatus!=null?selectedStatus:""%>">Previous</a></li>
                <% } %>
                <% for(int i=0;i<totalPages;i++){ %>
                <li class="page-item <%= i==currentPage?"active":"" %>">
                    <a class="page-link" href="?page=<%=i%>&status=<%=selectedStatus!=null?selectedStatus:""%>"><%=i+1%></a>
                </li>
                <% } %>
                <% if(currentPage<totalPages-1){ %>
                <li class="page-item"><a class="page-link" href="?page=<%=currentPage+1%>&status=<%=selectedStatus!=null?selectedStatus:""%>">Next</a></li>
                <% } %>
            </ul>
        </div>
    </div>
</div>

</body>
</html>
