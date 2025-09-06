<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Settings | Brandenbed</title>
<style>
    body {
        margin: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        display: flex;
        height: 100vh;
        background: #f4f6f9;
    }

    /* Sidebar */
    .sidebar {
        width: 240px;
        background: linear-gradient(135deg, #2c5282, #3182ce);
        color: #fff;
        display: flex;
        flex-direction: column;
        padding: 20px;
    }
    .sidebar h2 { text-align: center; margin-bottom: 2rem; font-size: 1.4rem; }
    .sidebar a { text-decoration: none; color: #fff; padding: 12px 15px; border-radius: 8px; margin-bottom: 10px; display: block; transition: background 0.3s; }
    .sidebar a:hover { background: rgba(255, 255, 255, 0.2); }

    /* Main content */
    .main { flex: 1; display: flex; flex-direction: column; }
    .header { background: #fff; padding: 15px 25px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
    .header h1 { font-size: 1.5rem; color: #2c5282; margin: 0; }

    /* Settings options */
    .content { padding: 20px 2rem; flex: 1; overflow-y: auto; }
    .settings-option { background: #fff; padding: 15px; border-radius: 12px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); margin-bottom: 15px; }
    .settings-option h3 { margin-top: 0; color: #3182ce; }
    .settings-option p { margin: 5px 0; color: #4a5568; font-size: 14px; }

    /* Logout button */
    .logout-btn { display: inline-block; padding: 10px 20px; background: #e74c3c; color: #fff; text-decoration: none; border-radius: 8px; margin-top: 10px; }
    .logout-btn:hover { background: #c0392b; }
</style>
</head>
<body>

	<div class="sidebar">
	        <h2>Brandenbed</h2>
	        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
	        <a href="${pageContext.request.contextPath}/admin/propertiesList">Properties</a>
	        <a href="#">Tasks</a>
	        <a href="${pageContext.request.contextPath}/admin/tenant-queries">Tenant Queries</a>
	        <a href="${pageContext.request.contextPath}/admin/rent-collection">Rent Collection</a>
	        <a href="${pageContext.request.contextPath}/admin/employeeList">Employees</a>
	        <a href="${pageContext.request.contextPath}/admin/settings">Settings</a>
	    </div>

<div class="main">
    <div class="header">
        <h1>Settings</h1>
    </div>

    <div class="content">
        <div class="settings-option">
            <h3>User & Access</h3>
            <p><a href="/settings/user-access">Manage roles and permissions</a></p>
        </div>

        <div class="settings-option">
            <h3>System Preferences</h3>
            <p><a href="/settings/system-preferences">Currency, date/time, notifications</a></p>
        </div>

        <div class="settings-option">
            <h3>Property & Tenant Defaults</h3>
            <p><a href="/settings/property-tenant-defaults">Default payment types and reminders</a></p>
        </div>

        <div class="settings-option">
            <h3>Financial Settings</h3>
            <p><a href="/settings/financial">Tax rates, late fees, bank info</a></p>
        </div>

        <div class="settings-option">
            <h3>Notifications</h3>
            <p><a href="/settings/notifications">Email/SMS templates and alerts</a></p>
        </div>

        <div class="settings-option">
            <h3>Application Settings</h3>
            <p><a href="/settings/application">Logo, theme, backup/restore</a></p>
        </div>

        <div class="settings-option">
            <a href="/logout" class="logout-btn">Logout</a>
        </div>
    </div>
</div>

</body>
</html>
