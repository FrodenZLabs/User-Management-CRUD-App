<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.crud_app.model.User" %>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <title>User Management</title>
</head>
<body class="bg-gray-50 min-h-screen flex flex-col items-center py-10">

    <!-- Toast container -->
    <div id="toast" class="fixed top-5 right-5 hidden px-4 py-3 rounded-lg shadow-lg text-white text-sm transition-all duration-300 z-50"></div>

    <div class="w-full max-w-5xl bg-white rounded-2xl shadow p-8">
        <h2 class="text-3xl font-bold mb-6 text-gray-800 text-center">User Management</h2>

        <div class="flex justify-end mb-4">
            <button 
                onclick="openAddModal()"
                class="bg-blue-600 text-white px-4 py-2 rounded-lg shadow hover:bg-blue-700 transition">
                + Add New User
            </button>
        </div>

        <div class="overflow-x-auto">
            <table class="min-w-full border border-gray-200 rounded-lg">
                <thead class="bg-gray-100 text-gray-700 uppercase text-sm">
                    <tr>
                        <%-- <th class="py-3 px-4 text-left">ID</th> --%>
                        <th class="py-3 px-4 text-left">Name</th>
                        <th class="py-3 px-4 text-left">Email</th>
                        <th class="py-3 px-4 text-left">Country</th>
                        <th class="py-3 px-4 text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<User> listUser = (List<User>) request.getAttribute("listUser");
                        if (listUser != null && !listUser.isEmpty()) {
                            for (User user : listUser) {
                    %>
                        <tr class="border-t hover:bg-gray-50">
                            <%-- <td class="py-2 px-4"><%= user.getId() %></td> --%>
                            <td class="py-2 px-4"><%= user.getName() %></td>
                            <td class="py-2 px-4"><%= user.getEmail() %></td>
                            <td class="py-2 px-4"><%= user.getCountry() %></td>
                            <td class="py-2 px-4 text-center space-x-2">
                                <button 
                                    onclick="openEditModal('<%= user.getId() %>', '<%= user.getName() %>', '<%= user.getEmail() %>', '<%= user.getCountry() %>')"
                                    class="bg-green-500 text-white px-3 py-1 rounded-md hover:bg-green-600 transition">
                                    Edit
                                </button>
                                <a href="delete?id=<%= user.getId() %>" 
                                   class="bg-red-500 text-white px-3 py-1 rounded-md hover:bg-red-600 transition">
                                   Delete
                                </a>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="5" class="text-center py-4 text-gray-500">No users found.</td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

     <!-- Add/Edit Modal -->
    <div id="userModal" class="hidden fixed inset-0 bg-black/50 flex items-center justify-center z-50">
        <div class="bg-white rounded-2xl shadow-lg w-full max-w-lg p-6 relative">
            <h3 id="modalTitle" class="text-2xl font-semibold mb-4">Add New User</h3>

            <form id="userForm" method="post" action="insert">
                <input type="hidden" name="id" id="userId" />

                <div class="mb-4">
                    <label class="block text-gray-700 mb-1">Full Name</label>
                    <input type="text" id="name" name="name" required
                           class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none" />
                </div>

                <div class="mb-4">
                    <label class="block text-gray-700 mb-1">Email</label>
                    <input type="email" id="email" name="email" required
                           class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none" />
                </div>

                <div class="mb-4">
                    <label class="block text-gray-700 mb-1">Country</label>
                    <input type="text" id="country" name="country" required
                           class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none" />
                </div>

                <div class="flex justify-between gap-3">
                    <button type="button" 
                            onclick="closeModal()"
                            class="px-4 py-2 bg-gray-300 rounded-lg hover:bg-gray-400 transition">
                        Cancel
                    </button>
                    <button type="submit"
                            class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition">
                        Save
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        const modal = document.getElementById("userModal");
        const modalTitle = document.getElementById("modalTitle");
        const userForm = document.getElementById("userForm");
        const idInput = document.getElementById("userId");
        const nameInput = document.getElementById("name");
        const emailInput = document.getElementById("email");
        const countryInput = document.getElementById("country");

        // 🟢 Open Add Modal
        function openAddModal() {
            modal.classList.remove("hidden");
            modal.classList.add("flex");
            modalTitle.textContent = "Add New User";
            userForm.action = "insert";
            idInput.value = "";
            nameInput.value = "";
            emailInput.value = "";
            countryInput.value = "";
        }

        // 🟢 Open Edit Modal
        function openEditModal(id, name, email, country) {
            modal.classList.remove("hidden");
            modal.classList.add("flex");
            modalTitle.textContent = "Edit User";
            userForm.action = "update";
            idInput.value = id;
            nameInput.value = name;
            emailInput.value = email;
            countryInput.value = country;
        }

        // 🔴 Close Modal
        function closeModal() {
            modal.classList.add("hidden");
        }

        // ✅ Toast Logic
        function showToast(message) {
            const toast = document.getElementById('toast');
            toast.textContent = message;
            toast.classList.remove('hidden');
            toast.classList.add('bg-green-500', 'opacity-100');
            setTimeout(() => {
                toast.classList.add('opacity-0');
                setTimeout(() => toast.classList.add('hidden'), 500);
            }, 3000);
        }

        const params = new URLSearchParams(window.location.search);
        const successMessage = params.get('success');
        if (successMessage) {
            showToast(successMessage);
            const newUrl = window.location.origin + window.location.pathname;
            window.history.replaceState({}, document.title, newUrl);
        }
    </script>
</body>
</html>
