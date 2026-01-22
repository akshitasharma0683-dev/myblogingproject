
# 📝 BlogSphere — Full-Stack Blogging Platform  
**Java | JSP | Servlets | MySQL | MVC Architecture**

---

## 📌 Overview

**BlogSphere** is a full-stack blogging web application developed using **Java (JSP & Servlets)** and **MySQL**.  
The platform allows users to publish blogs, interact through likes and comments, and manage content securely with role-based access and ownership enforcement.

The project closely mirrors real-world blogging platforms by combining **user interaction**, **admin moderation**, and **secure backend logic**.

---

## 🎯 Project Goals

- Build a real-world blogging platform using **core Java web technologies**
- Implement **user interaction features** (likes & comments)
- Apply **role-based access control** (Admin vs User)
- Enforce **content ownership rules**
- Follow **MVC & DAO design patterns**
- Demonstrate scalable backend architecture

---

## 🚀 Features

### 🔐 Authentication & Roles
- User registration & login
- Session-based authentication
- Role support:
  - **USER**
  - **ADMIN**

---

### 📝 Blog Management
- Users can:
  - Create blog posts
  - Edit their own blogs
  - Delete their own blogs
- Blogs include:
  - Title
  - Category
  - Content
  - Image upload
  - Timestamps

---

### 👍 Like System
- Any logged-in user can **like blogs**
- Likes are stored persistently in the database
- Like count updates dynamically

---

### 💬 Comment System
- Any user can comment on blogs
- Comment ownership rules:
  - Users can **delete only their own comments**
  - Users cannot delete others’ comments

```java
if (comment.getUserId() != loggedInUser.getId()) {
    // Deletion not allowed
}
```

---

### 🛡 Admin Moderation Panel
Admins can:
- View all blogs
- Delete any blog
- View all comments
- Delete inappropriate comments

```java
if (user.getRole().equals("ADMIN")) {
    // Admin privileges granted
}
```

---

### 🧑‍💼 User Dashboard
- Personalized dashboard
- Displays:
  - Profile picture (default fallback)
  - All blogs
  - Edit/Delete options only for owned blogs

---

### 🖼 Image Upload Support
- Upload using `multipart/form-data`
- Stored in `/images` directory
- Filename saved in database

---

## 🔒 Security & Authorization

- Session validation on protected pages
- Blog ownership enforcement
- Comment ownership enforcement
- Admin-only moderation actions

---

## 🧱 Technical Architecture

### 📐 Design Pattern
- MVC (Model–View–Controller)
- DAO (Data Access Object)

---

## 🗂 Project Structure

```
BlogSphere/
├── controller/
├── dao/
├── daoimpl/
├── pojo/
├── jsp/
├── images/
└── WEB-INF/
```

---

## 🛠 Tech Stack

**Backend:** Java, JSP, Servlets, JDBC, Apache Tomcat  
**Frontend:** HTML5, CSS3, Bootstrap, JSP  
**Database:** MySQL

---

## 🗄 Database Schema

### users
```sql
id (PK)
username
email
password
role
contact
dp
```

### blogs
```sql
id (PK)
user_id (FK)
title
category
content
image
created_at
updated_at
```

### comments
```sql
id (PK)
blog_id (FK)
user_id (FK)
comment_text
created_at
```

### likes
```sql
id (PK)
blog_id (FK)
user_id (FK)
```

---

## 🧪 How to Run Locally

1. Clone the repository
2. Import into Eclipse
3. Configure Apache Tomcat
4. Create MySQL database `blogingproject`
5. Update DB credentials
6. Run on server

---

## 📈 What This Project Demonstrates

- Advanced Java backend development
- Role-based authorization
- Content moderation
- Secure session handling
- Real-world database relationships

---

## 👩‍💻 Author

**Akshita Sharma**  
Java Backend / Full-Stack Developer

---

## ⭐ Final Note

This project demonstrates real-world backend logic, security, and moderation features, making it suitable for portfolios and technical interviews.
