# 🛒 Cloud-Native Grocery Web App

** DevOps / Cloud Engineering Capstone **

## 📌 Project Overview

This project showcases a containerized, cloud-native grocery web application deployed on AWS. It emphasizes DevOps principles, Infrastructure as Code (IaC), and scalable, secure architecture using a range of AWS services.

## ☁️ AWS Services Used

* **EC2** – Host Docker containers running the web app
* **S3** – Store static assets and backups
* **Application Load Balancer (ALB)** – Distribute traffic across EC2 instances
* **RDS (PostgreSQL)** – Managed relational database for persistent storage
* **IAM** – Secure access control
* **VPC, Subnets, Security Groups** – Custom network configuration
* **Terraform** – Infrastructure provisioning via code

## 🧱 Architecture Overview

```
User → ALB → EC2 (Dockerized App) → RDS (PostgreSQL)
                         ↓
                        S3 (Static Assets)
```

* The application is containerized using Docker and deployed on EC2 instances.
* Traffic is routed through an Application Load Balancer for high availability.
* A PostgreSQL database (RDS) handles backend data storage.
* Static content is hosted in an S3 bucket.
* Infrastructure is entirely managed via Terraform for repeatable deployments.

## 🛠️ Deployment & Setup Process

1. **Provision AWS Resources with Terraform**

   * Launches VPC, Subnets, EC2, ALB, S3, RDS, and IAM roles.

2. **Access EC2 and Deploy App**

   * SSH into the EC2 instance
   * Install Docker and Docker Compose (if needed)
   * Clone the repository:

     ```bash
     git clone --branch version2 https://github.com/AlejandroRomanIbanez/AWS_grocery.git && cd AWS_grocery
     ```

3. **Configure PostgreSQL**

   ```bash
   psql -U postgres -c "CREATE DATABASE grocerymate_db;"
   psql -U postgres -c "CREATE USER grocery_user WITH ENCRYPTED PASSWORD '<your_secure_password>';"
   psql -U postgres -c "ALTER USER grocery_user WITH SUPERUSER;"
   ```

4. **Populate the Database**

   ```bash
   psql -U grocery_user -d grocerymate_db -f app/sqlite_dump_clean.sql
   ```

   * Verify with:

     ```bash
     psql -U grocery_user -d grocerymate_db -c "SELECT * FROM users;"
     psql -U grocery_user -d grocerymate_db -c "SELECT * FROM products;"
     ```

5. **Set Up Python Environment**

   ```bash
   cd backend
   pip install -r requirements.txt
   ```

6. **Set Environment Variables**

   * Create a `.env` file:

     ```bash
     touch .env
     ```
   * Generate a secure JWT key:

     ```bash
     python3 -c "import secrets; print(secrets.token_hex(32))"
     ```
   * Add to `.env`:

     ```env
     JWT_SECRET_KEY=<your_generated_key>
     POSTGRES_USER=grocery_user
     POSTGRES_PASSWORD=grocery_test
     POSTGRES_DB=grocerymate_db
     POSTGRES_HOST=localhost
     POSTGRES_URI=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:5432/${POSTGRES_DB}
     ```

7. **Start the Application**

   ```bash
   python3 run.py
   ```

## 🔍 Features

* 🐳 Dockerized web app
* ☁️ AWS-native deployment (EC2, RDS, S3, ALB)
* ⚙️ Infrastructure as Code with Terraform
* 🧱 Modular and scalable architecture
* 🔐 Secure IAM roles and security groups
* 🛡️ User Authentication, JWT & Session Management
* 🛍️ Shopping Basket & Checkout Flow
* 🔎 Product Search and Favorites

## 🧑‍💻 Tech Stack

* **Frontend / Backend**: Python, JavaScript
* **Infrastructure**: Terraform, AWS CLI
* **Database**: PostgreSQL (Amazon RDS)
* **Containerization**: Docker
* **OS**: Amazon Linux 2

## 🧠 Lessons Learned

* Built and deployed a full-stack e-commerce platform on AWS
* Learned how to manage infrastructure using Terraform
* Gained hands-on experience with RDS, ALB, and Docker on EC2
* Strengthened troubleshooting and DevOps automation skills

## 👤 Author

**Suma Hotti**
[LinkedIn](https://www.linkedin.com/in/sumah)

---


