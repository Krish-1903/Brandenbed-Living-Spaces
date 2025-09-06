<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.brandenbed.entity.Employee" %>
<%@ page import="com.brandenbed.entity.Admin" %>
<!DOCTYPE html>
<html>
<head>
    <title>Employees | Brandenbed</title>
    <style>
        /* ---------- Body & Layout ---------- */
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            min-height: 100vh;
            background: #f4f6f9;
            overflow-x: hidden;
        }

        /* ---------- Sidebar ---------- */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 240px;
            height: 100vh;
            min-width: 240px;
            background: linear-gradient(135deg, #2c5282, #3182ce);
            color: #fff;
            display: flex;
            flex-direction: column;
            padding: 20px;
            box-sizing: border-box;
            overflow-y: auto;
            flex-shrink: 0;
            transition: all 0.3s ease;
            z-index: 105;
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
        .sidebar a:hover, .sidebar a.active { background: rgba(255,255,255,0.2); padding-left: 20px; }
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

        /* ---------- Main ---------- */
        .main {
            margin-left: 240px;
            flex: 1;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            transition: margin-left 0.3s ease;
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
        .content { padding: 1.5rem 2rem; flex: 1; overflow-y: auto; }

        /* ---------- Messages ---------- */
        .message-success { color: #38a169; font-weight: bold; margin-bottom: 1rem; }
        .message-error { color: #e53e3e; font-weight: bold; margin-bottom: 1rem; }

        /* ---------- Add Button ---------- */
        .btn-add {
            display: inline-block;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, #38a169, #2f855a);
            color: white;
            padding: 0.7rem 1.2rem;
            border-radius: 8px;
            font-size: 0.95rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .btn-add:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(56,161,105,0.3); }

        /* ---------- Table ---------- */
        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            font-size: 0.9rem;
        }
        thead { background: #3182ce; color: #fff; }
        th, td { padding: 12px 15px; text-align: left; border-bottom: 1px solid #e2e8f0; }
        tbody tr:hover { background: #f1f5f9; }
        .status-active { color: #38a169; font-weight: bold; }
        .status-inactive { color: #e53e3e; font-weight: bold; }

        /* ---------- Modal ---------- */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5);
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background: #fff;
            padding: 2rem;
            border-radius: 12px;
            width: 400px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            animation: fadeIn 0.3s ease-out;
        }
        .modal-content h2 { margin-bottom: 1rem; color: #2c5282; }
        .modal-content label { display: block; margin-top: 0.8rem; font-weight: 500; color: #4a5568; }
        .modal-content input, .modal-content select { width: 100%; padding: 0.6rem; margin-top: 0.3rem; border: 1px solid #cbd5e0; border-radius: 8px; }
        .modal-content button {
            margin-top: 1.2rem;
            width: 100%;
            padding: 0.8rem;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: bold;
            color: #fff;
            background: linear-gradient(135deg, #3182ce, #2c5282);
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .modal-content button:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(49,130,206,0.3); }
        .close { float: right; font-size: 1.2rem; font-weight: bold; cursor: pointer; color: #e53e3e; }

        @keyframes fadeIn { from {opacity: 0; transform: translateY(-20px);} to {opacity: 1; transform: translateY(0);} }

        /* ---------- Hamburger ---------- */
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

        /* ---------- Media Queries (same as dashboard) ---------- */
        @media (max-width: 1200px) {
            table { font-size: 0.85rem; }
        }
        @media (max-width: 768px) {
            .hamburger { display: flex; }
            .sidebar { transform: translateX(-260px); }
            .sidebar.show { transform: translateX(0); }
            .main { margin-left: 0; }
            table { font-size: 0.8rem; }
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
    <!-- Hamburger for mobile -->
    <div class="hamburger" id="hamburger">
        <div></div>
        <div></div>
        <div></div>
    </div>

    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <h2>Brandenbed</h2>
        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/propertiesList">Properties</a>
        <a href="${pageContext.request.contextPath}/admin/tenant-queries">Tenant Queries</a>
        <a href="${pageContext.request.contextPath}/admin/rent-collection">Rent Collection</a>
        <a href="${pageContext.request.contextPath}/admin/employeeList" class="active">Employees</a>
        <div class="logout" onclick="window.location.href='${pageContext.request.contextPath}/logout'">Logout</div>
    </div>

    <!-- Main -->
    <div class="main">
        <div class="header">
            <h1>Employees</h1>
            <div>
                <% String adminName = (String) request.getAttribute("adminName");
                   if(adminName != null) { out.print("Welcome, " + adminName); }
                   else { out.print("Welcome, Admin"); } %>
            </div>
        </div>

        <div class="content">
            <% String succmsg = (String) request.getAttribute("succmsg");
               String errmsg = (String) request.getAttribute("errmsg");
               if(succmsg != null) { %><p class="message-success"><%= succmsg %></p><% }
               if(errmsg != null) { %><p class="message-error"><%= errmsg %></p><% } %>

            <button class="btn-add" onclick="openModal()">+ Add Employee</button>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Role</th>
                        <th>Contact</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Employee> emp =(List<Employee>) request.getAttribute("emp");
                        if(emp != null && !emp.isEmpty()) {
                            for(Employee employee : emp) {
                    %>
                        <tr>
                            <td><%= employee.getId() %></td>
                            <td><%= employee.getName() %></td>
                            <td><%= employee.getRole() %></td>
                            <td><%= employee.getPhone() %></td>
                            <td>
                                <% if("ACTIVE".equalsIgnoreCase(employee.getStatus().name())) { %>
                                    <span class="status-active">Active</span>
                                <% } else { %>
                                    <span class="status-inactive">Inactive</span>
                                <% } %>
                            </td>
                        </tr>
                    <% } } else { %>
                        <tr><td colspan="5" style="text-align:center;">No employees found</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Add Employee Modal -->
    <div id="addEmployeeModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2>Add Employee</h2>
            <form action="addEmployee" method="post">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
                <label for="role">Role:</label>
                <input type="text" id="role" name="role" required>
                <label for="phone">Contact:</label>
                <input type="text" id="phone" name="phone" required>
                <label for="status">Status:</label>
                <select id="status" name="status" required>
                    <option value="ACTIVE">Active</option>
                    <option value="INACTIVE">Inactive</option>
                </select>
                <button type="submit">Save Employee</button>
            </form>
        </div>
    </div>

    <script>
        function openModal() { document.getElementById("addEmployeeModal").style.display = "flex"; }
        function closeModal() {
            document.getElementById("addEmployeeModal").style.display = "none";
            document.querySelector("#addEmployeeModal form").reset();
        }

        // Hamburger toggle
        const hamburger = document.getElementById('hamburger');
        const sidebar = document.getElementById('sidebar');
        hamburger.addEventListener('click', () => {
            hamburger.classList.toggle('active');
            sidebar.classList.toggle('show');
        });
    </script>
</body>
</html>
