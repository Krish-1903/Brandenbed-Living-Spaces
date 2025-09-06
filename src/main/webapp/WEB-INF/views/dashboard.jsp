<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.brandenbed.entity.TenantQuery" %>
<%@ page import="com.brandenbed.entity.Transaction" %>
<%@ page import="com.brandenbed.entity.Admin" %>
<!DOCTYPE html>
<html>
<head>
    <title>Team Dashboard | Brandenbed</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            min-height: 100vh;
            background: #f4f6f9;
            overflow-x: hidden;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 240px;
            height: 100vh;
            background: linear-gradient(135deg, #2c5282, #3182ce);
            color: #fff;
            display: flex;
            flex-direction: column;
            padding: 20px;
            box-sizing: border-box;
            overflow-y: auto;
            z-index: 105;
            transition: all 0.3s ease;
        }

        .sidebar h2 { text-align: center; margin-bottom: 2rem; font-size: 1.4rem; }
        .sidebar a {
            text-decoration: none;
            color: #fff;
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 10px;
            display: block;
            transition: background 0.3s, padding-left 0.3s;
        }
        .sidebar a:hover { background: rgba(255,255,255,0.2); padding-left: 20px; }
        .sidebar .logout {
            margin-top: auto;
            background: #e53e3e;
            text-align: center;
            padding: 12px;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s, transform 0.2s;
        }
        .sidebar .logout:hover { background: #c53030; transform: translateY(-2px); }

        .main {
            margin-left: 240px;
            flex: 1;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
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
            width: 100%;
            box-sizing: border-box;
        }

        .alert { padding: 12px 15px; border-radius: 8px; margin-bottom: 1rem; font-weight: 500; width: 100%; }
        .alert-danger { background: #fed7d7; color: #c53030; }
        .alert-warning { background: #fefcbf; color: #975a16; }
        .alert-success { background: #c6f6d5; color: #2f855a; }

        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
            width: 100%;
        }
        .card {
            background: #fff;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            text-align: center;
            transition: transform 0.2s ease;
        }
        .card:hover { transform: translateY(-3px); }
        .card h2 { font-size: 1.5rem; margin-bottom: 0.3rem; color: #3182ce; }
        .card p { color: #4a5568; font-weight: 500; font-size: 0.85rem; }

        .grid-2 {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        .section {
            background: #fff;
            border-radius: 10px;
            padding: 1rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            overflow-x: auto;
        }
        .section h3 {
            margin-top: 0;
            margin-bottom: 1rem;
            color: #2c5282;
            font-size: 1.2rem;
        }
        table { width: 100%; border-collapse: collapse; font-size: 0.85rem; }
        table th, table td { text-align: left; padding: 8px; border-bottom: 1px solid #e2e8f0; }
        table th { background: #f8fafc; }
        table tr:hover { background: #f1f5f9; }

        .quick-actions button {
            margin: 5px 10px 5px 0;
            background: #3182ce;
            color: #fff;
            border: none;
            padding: 10px 15px;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.2s, transform 0.2s;
        }
        .quick-actions button:hover { background: #2b6cb0; transform: translateY(-2px); }

        .hamburger {
            display: none;
            position: fixed;
            top: 15px;
            left: 15px;
            width: 30px;
            height: 22px;
            flex-direction: column;
            justify-content: space-between;
            cursor: pointer;
            z-index: 110;
        }
        .hamburger div {
            width: 100%;
            height: 4px;
            background-color: #fff;
            border-radius: 2px;
            transition: all 0.3s ease;
        }
        .hamburger.active div:nth-child(1) { transform: rotate(45deg) translate(5px, 5px); }
        .hamburger.active div:nth-child(2) { opacity: 0; }
        .hamburger.active div:nth-child(3) { transform: rotate(-45deg) translate(5px, -5px); }

        @media (max-width: 768px) {
            .hamburger { display: flex; }
            .sidebar { transform: translateX(-260px); }
            .sidebar.show { transform: translateX(0); z-index: 200; }
            .main { margin-left: 0; width: 100%; }
            .cards { grid-template-columns: repeat(auto-fit, minmax(120px, 1fr)); gap: 0.8rem; }
            .card { padding: 1rem; font-size: 0.85rem; }
            .grid-2 { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="hamburger" id="hamburger">
        <div></div>
        <div></div>
        <div></div>
    </div>

    <div class="sidebar" id="sidebar">
        <h2>Brandenbed</h2>
        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/propertiesList">Properties</a>
        <a href="${pageContext.request.contextPath}/admin/tenant-queries">Tenant Queries</a>
        <a href="${pageContext.request.contextPath}/admin/rent-collection">Rent Collection</a>
        <a href="${pageContext.request.contextPath}/admin/employeeList">Employees</a>
        <div class="logout" onclick="window.location.href='${pageContext.request.contextPath}/logout'">Logout</div>
    </div>

    <div class="main">
        <div class="header">
            <h1>Team Dashboard</h1>
            <div>
                <% String adminName = (String) request.getAttribute("adminName");
                   if(adminName != null) { out.print("Welcome, " + adminName); }
                   else { out.print("Welcome, Admin"); } %>
            </div>
        </div>

        <div class="content">
            <div class="alert alert-danger">
                ⚠ Pending Rent: €<%= String.format("%.2f", request.getAttribute("totalPending")) %>
            </div>
            <div class="alert alert-warning">
                ⚠ ${pendingQueries} Tenant Queries Pending
            </div>

            <div class="cards">
                <div class="card"><h2>${totalProperties}</h2><p>Properties Managed</p></div>
                <div class="card"><h2>${totalTenantQueries}</h2><p>Tenant Queries</p></div>
                <div class="card"><h2>${totalEmployees}</h2><p>Total Employees</p></div>
                <div class="card"><h2>${activeEmployees}</h2><p>Active Employees</p></div>
                <div class="card"><h2>${inactiveEmployees}</h2><p>Inactive Employees</p></div>
            </div>

            <div class="grid-2">
                <div class="section">
                    <h3>Recent Tenant Queries</h3>
                    <table>
                        <tr><th>Tenant</th><th>Issue</th><th>Status</th><th>Date</th></tr>
                        <%
                            List<TenantQuery> queries = (List<TenantQuery>) request.getAttribute("recentQueries");
                            if (queries != null && !queries.isEmpty()) {
                                for (TenantQuery query : queries) {
                        %>
                            <tr>
                                <td><%= query.getTenantName() %></td>
                                <td><%= query.getQueryText() %></td>
                                <td><%= query.getStatus() %></td>
                                <td><%= query.getDateSubmitted() %></td>
                            </tr>
                        <%
                                }
                            } else {
                        %>
                            <tr><td colspan="4">No recent queries found.</td></tr>
                        <%
                            }
                        %>
                    </table>
                </div>

                <div class="section">
                    <h3>Pending Rent Collection</h3>
                    <table>
                        <tr><th>ID</th><th>Tenant</th><th>Property</th><th>Amount (€)</th><th>Transaction Date</th><th>Status</th></tr>
                        <%
                            List<Transaction> pendingRents = (List<Transaction>) request.getAttribute("pendingRents");
                            if (pendingRents != null && !pendingRents.isEmpty()) {
                                for (Transaction rent : pendingRents) {
                        %>
                            <tr>
                                <td><%= rent.getId() %></td>
                                <td><%= rent.getResident().getName() %></td>
                                <td><%= rent.getProperty().getName() %></td>
                                <td><%= String.format("%.2f", rent.getAmount()) %></td>
                                <td><%= rent.getTransactionDate() %></td>
                                <td><%= rent.getStatus() %></td>
                            </tr>
                        <%
                                }
                            } else {
                        %>
                            <tr><td colspan="6">No pending rents found.</td></tr>
                        <%
                            }
                        %>
                    </table>
                </div>
            </div>

        </div>
    </div>

    <script>
        const hamburger = document.getElementById('hamburger');
        const sidebar = document.getElementById('sidebar');
        hamburger.addEventListener('click', () => {
            hamburger.classList.toggle('active');
            sidebar.classList.toggle('show');
        });
    </script>
</body>
</html>
