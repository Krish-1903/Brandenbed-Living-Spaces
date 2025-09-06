<%@ page import="java.util.List" %>
<%@ page import="com.brandenbed.entity.Property" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Properties | Brandenbed</title>
    <style>
        body { margin:0; font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; display:flex; min-height:100vh; background:#f4f6f9; overflow-x:hidden; }
        .sidebar { position:fixed; top:0; left:0; width:240px; height:100vh; background:linear-gradient(135deg,#2c5282,#3182ce); color:#fff; display:flex; flex-direction:column; padding:20px; box-sizing:border-box; overflow-y:auto; flex-shrink:0; transition: all 0.3s ease; z-index:105; }
        .sidebar h2 { text-align:center; margin-bottom:2rem; font-size:1.4rem; }
        .sidebar a { text-decoration:none; color:#fff; padding:12px 15px; border-radius:8px; margin-bottom:10px; display:block; transition: background 0.3s, padding-left 0.3s; }
        .sidebar a:hover, .sidebar a.active { background: rgba(255,255,255,0.2); padding-left:20px; }
        .sidebar .logout { margin-top:auto; background:#e53e3e; text-align:center; padding:12px; border-radius:8px; cursor:pointer; transition: background 0.3s, transform 0.2s; }
        .sidebar .logout:hover { background:#c53030; transform:translateY(-2px); }

        .main { margin-left:240px; flex:1; display:flex; flex-direction:column; overflow:hidden; transition:margin-left 0.3s ease; }
        .header { background:#fff; padding:15px 25px; box-shadow:0 2px 10px rgba(0,0,0,0.1); display:flex; justify-content:space-between; align-items:center; flex-shrink:0; }
        .header h1 { font-size:1.5rem; color:#2c5282; }
        .filters { display:flex; flex-wrap:wrap; gap:10px; margin:20px 2rem; }
        .filters input, .filters select, .filters button { padding:10px 12px; border-radius:12px; border:1px solid #ccc; font-size:14px; }
        .filters input { flex:1; }
        .filters select { width:200px; }
        .filters button { background:#3182ce; color:white; border:none; cursor:pointer; }
        .filters button:hover { background:#2c5282; }

        .content { padding:0 2rem 2rem 2rem; flex:1; overflow-y:auto; }
        .cards { display:grid; grid-template-columns:repeat(auto-fit,minmax(280px,1fr)); gap:1.5rem; }
        .card { background:#fff; border-radius:12px; box-shadow:0 4px 15px rgba(0,0,0,0.05); overflow:hidden; }
        .card img { width:100%; height:160px; object-fit:cover; }
        .card-body { padding:15px; }
        .card-body h3 { margin:0 0 5px 0; font-size:18px; color:#3182ce; }
        .card-body p { margin:4px 0; color:#4a5568; font-size:14px; }
        .status { padding:4px 10px; border-radius:12px; font-size:12px; color:white; display:inline-block; margin-top:6px; }
        .status.Available { background:#27ae60; }
        .status.Rented { background:#e74c3c; }
        .status.Maintenance { background:#f39c12; }
        .card-footer { padding:12px 15px; display:flex; justify-content:space-between; border-top:1px solid #eee; }
        .card-footer a { color:#3182ce; cursor:pointer; text-decoration:none; font-weight:500; }
        .card-footer a:hover { color:#2c5282; }
        .btn { padding:8px 15px; background:#3182ce; color:white; border:none; border-radius:8px; cursor:pointer; }
        .btn:hover { background:#2c5282; }

        .modal { position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.6); display:none; justify-content:center; align-items:center; z-index:1000; }
        .modal-content { background:#fff; padding:25px; border-radius:12px; width:400px; box-shadow:0 8px 25px rgba(0,0,0,0.15); }
        .modal-content h2 { margin-top:0; color:#2c5282; }
        .modal-content input, .modal-content select { width:100%; margin:8px 0; padding:10px; border-radius:8px; border:1px solid #ccc; }
        .modal-actions { text-align:right; margin-top:10px; }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h2>Brandenbed</h2>
    <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
    <a href="${pageContext.request.contextPath}/admin/propertiesList" class="active">Properties</a>
    <a href="${pageContext.request.contextPath}/admin/tenant-queries">Tenant Queries</a>
    <a href="${pageContext.request.contextPath}/admin/rent-collection">Rent Collection</a>
    <a href="${pageContext.request.contextPath}/admin/employeeList">Employees</a>
    <div class="logout" onclick="window.location.href='${pageContext.request.contextPath}/logout'">Logout</div>
</div>

<div class="main">
    <div class="header">
        <h1>Properties</h1>
        <button class="btn" onclick="openAddModal()">+ Add Property</button>
    </div>

    <div class="filters">
        <form action="<%= request.getContextPath() %>/admin/filter" method="get" style="display:flex; width:100%; gap:10px;">
            <input type="text" name="name" placeholder="Search by name" value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>"/>
            <select name="status">
                <option value="">All Status</option>
                <option value="Available" <%= "Available".equals(request.getParameter("status")) ? "selected" : "" %>>Available</option>
                <option value="Rented" <%= "Rented".equals(request.getParameter("status")) ? "selected" : "" %>>Rented</option>
                <option value="Maintenance" <%= "Maintenance".equals(request.getParameter("status")) ? "selected" : "" %>>Maintenance</option>
            </select>
            <button type="submit">Search</button>
        </form>
    </div>

    <div class="content">
        <div class="cards">
            <%
                List<Property> properties = (List<Property>) request.getAttribute("properties");
                if(properties != null && !properties.isEmpty()){
                    for(Property property : properties){
            %>
            <div class="card">
                <img src="<%= request.getContextPath() %>/images/<%= (property.getImagePath() != null ? property.getImagePath() : "default.jpg") %>" alt="<%= property.getName() %>">
                <div class="card-body">
                    <h3><%= property.getName() %></h3>
                    <p><%= property.getLocation() %></p>
                    <p>Rent: €<%= String.format("%.2f", property.getPrice()) %></p>
                    <span class="status <%= property.getStatus() %>"><%= property.getStatus() %></span>
                </div>
                <div class="card-footer">
                    <a onclick="openEditModal('<%= property.getId() %>', '<%= property.getName() %>', '<%= property.getLocation() %>', '<%= property.getStatus() %>', '<%= property.getPrice() %>')">Edit</a>
                    <a onclick="confirmDelete('<%= property.getId() %>', '<%= property.getName() %>')">Delete</a>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <p style="text-align:center; width:100%;">No properties found</p>
            <%
                }
            %>
        </div>
    </div>
</div>

<!-- Add Modal -->
<div class="modal" id="addModal">
    <div class="modal-content">
        <h2>Add Property</h2>
        <form action="<%= request.getContextPath() %>/admin/addProperty" method="post" enctype="multipart/form-data">
            <input type="text" name="name" placeholder="Property Name" required>
            <input type="text" name="location" placeholder="Location" required>
            <input type="number" step="0.01" name="price" placeholder="Rent" required>
            <select name="status" required>
                <option value="Available">Available</option>
                <option value="Rented">Rented</option>
                <option value="Maintenance">Maintenance</option>
            </select>
            <input type="file" name="image">
            <div class="modal-actions">
                <button type="submit" class="btn">Add</button>
                <button type="button" class="btn" onclick="closeAddModal()">Cancel</button>
            </div>
        </form>
    </div>
</div>

<!-- Edit Modal -->
<div class="modal" id="editModal">
    <div class="modal-content">
        <h2>Edit Property</h2>
        <form action="<%= request.getContextPath() %>/admin/editProperty" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" id="editId">
            <input type="text" name="name" id="editName" placeholder="Property Name" required>
            <input type="text" name="location" id="editAddress" placeholder="Location" required>
            <input type="number" step="0.01" name="price" id="editRent" placeholder="Rent" required>
            <select name="status" id="editStatus" required>
                <option value="Available">Available</option>
                <option value="Rented">Rented</option>
                <option value="Maintenance">Maintenance</option>
            </select>
            <input type="file" name="image">
            <div class="modal-actions">
                <button type="submit" class="btn">Update</button>
                <button type="button" class="btn" onclick="closeEditModal()">Cancel</button>
            </div>
        </form>
    </div>
</div>

<!-- Delete Modal -->
<div class="modal" id="deleteModal">
    <div class="modal-content">
        <h2>Delete Property</h2>
        <p id="deleteMessage"></p>
        <form id="deleteForm" action="<%= request.getContextPath() %>/admin/deleteProperty" method="post">
            <input type="hidden" name="id" id="deleteId">
            <div class="modal-actions">
                <button type="button" class="btn" onclick="submitDelete()">Yes, Delete</button>
                <button type="button" class="btn" onclick="closeDeleteModal()">Cancel</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openAddModal(){ document.getElementById("addModal").style.display = "flex"; }
    function closeAddModal(){ document.getElementById("addModal").style.display = "none"; }

    function openEditModal(id,name,location,status,rent){
        document.getElementById("editId").value = id;
        document.getElementById("editName").value = name;
        document.getElementById("editAddress").value = location;
        document.getElementById("editStatus").value = status;
        document.getElementById("editRent").value = rent;
        document.getElementById("editModal").style.display = "flex";
    }
    function closeEditModal(){ document.getElementById("editModal").style.display = "none"; }

    let deletePropertyId = null;
    function confirmDelete(id,name){
        deletePropertyId = id;
        document.getElementById("deleteMessage").textContent = "Are you sure you want to delete '"+name+"'?";
        document.getElementById("deleteModal").style.display = "flex";
    }
    function closeDeleteModal(){ deletePropertyId=null; document.getElementById("deleteModal").style.display="none"; }
    function submitDelete(){
        if(deletePropertyId !== null){
            document.getElementById("deleteId").value = deletePropertyId;
            document.getElementById("deleteForm").submit();
        }
    }
</script>
</body>
</html>
