# 🧩 Java CRUD Web App (Maven + PostgreSQL + TailwindCSS)

A simple yet modern **CRUD web application** built with **Java Servlets**, **JSP**, **Maven**, and **PostgreSQL**, styled using **TailwindCSS**.  
Includes **modal-based Add/Edit forms**, **toast notifications**, and a **confirmation modal** for deletes — all on one page.

---

## 🚀 Features

✅ Create, Read, Update, Delete (CRUD) operations  
✅ Modern UI with **TailwindCSS**  
✅ Modal forms for **Add/Edit** (no page reloads)  
✅ **Confirmation modal** for delete  
✅ Toast notifications for feedback  
✅ Clean MVC structure (DAO + Servlet + Model + JSP)  
✅ Runs on Tomcat (or any Jakarta Servlet container)

---

## 🏗️ Project Structure
```bash
crud_app/
├── src/
│ ├── main/
│ │ ├── java/com/crud_app/
│ │ │ ├── dao/UserDAO.java
│ │ │ ├── model/User.java
│ │ │ └── serverlet/UserServlet.java
│ │ ├── resources/
│ │ └── webapp/
│ │ ├── WEB-INF/web.xml
│ │ └── user-list.jsp
├── pom.xml
└── README.md
```

---

## ⚙️ Prerequisites

Before running, make sure you have the following installed:

- **Java 22** (or JDK 17+)  
- **Apache Maven 3.9+**  
- **PostgreSQL 14+**  
- **VS Code** (recommended IDE)  
- **Tomcat 10+** (or any Jakarta Servlet-compatible container)
- **Ubuntu WSL** (or Linux/MacOS terminal)

---

## 🗄️ Database Setup (PostgreSQL)

### 1. Login to PostgreSQL:
   ```bash
   psql -U postgres
Create a database and table:

CREATE DATABASE crud_app;
\c crud_app;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    country VARCHAR(100)
);
```
### 2. Update your DB credentials inside UserDAO.java:
```bash
private String jdbcURL = "jdbc:postgresql://localhost:5432/crud_app";
private String jdbcUsername = "postgres";
private String jdbcPassword = "your_password";
```

## 🧱 Build & Run
### 1️⃣ Clone the repository
```bash
git clone https://github.com/yourusername/jUser-Management-CRUD-App.git
cd crudapp
```
### 2️⃣ Build with Maven
```bash
mvn clean package
```
### 3️⃣ Deploy on Tomcat
Copy the generated .war file from target/ into Tomcat’s webapps/ directory.
Start Tomcat:
```bash
sudo systemctl start tomcat10
```
Access in your browser:
http://localhost:8080/crud_app/

## 🎨 UI Overview
### 🧍User List Page
- Displays all users in a styled Tailwind table. <br />
- Add/Edit buttons open a modal popup form. <br />
- Delete shows a confirmation modal.

### ✏️ Add/Edit Modal
- Add new user or update existing user data without leaving the page. <br />
- Submits form data to /insert or /update.

### ❌ Delete Confirmation
- Prevents accidental deletions. <br />
- Displays a success toast after deletion.

### 🔔 Toast Notifications
- Automatically appears after successful insert/update/delete.

## 🧑‍💻 Author

Stephen Kibe
Software Developer — Java, MERN, DevOps Enthusiast <br />
🌐 LinkedIn <br />
 • GitHub

## 🪪 License
This project is licensed under the MIT License — feel free to use and modify it.
MIT License © 2025 Stephen Kibe
