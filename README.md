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

    ```sh
    git clone --branch version2 https://github.com/AlejandroRomanIbanez/AWS_grocery.git && cd AWS_grocery
    ```



3. **Configure PostgreSQL**
  ```sh
   psql -U postgres -c "CREATE DATABASE grocerymate_db;"
   psql -U postgres -c "CREATE USER grocery_user WITH ENCRYPTED PASSWORD '<your_secure_password>';"
   psql -U postgres -c "ALTER USER grocery_user WITH SUPERUSER;"
   ```

4. **Populate the Database**

   ```sh
   psql -U grocery_user -d grocerymate_db -f app/sqlite_dump_clean.sql
   ```

   * Verify with:

     ```sh
     psql -U grocery_user -d grocerymate_db -c "SELECT * FROM users;"
     psql -U grocery_user -d grocerymate_db -c "SELECT * FROM products;"
     ```

5. **Set Up Python Environment**

   ```sh
   cd backend
   pip install -r requirements.txt
   ```

6. **Set Environment Variables**

   * Create a `.env` file:

     ```sh
     touch .env
     ```
   * Generate a secure JWT key:

     ```sh
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

   ```sh
   python3 run.py
   ```

DevOps Features & Cloud Skills Demonstrated

🐳 Dockerized deployment on EC2
☁️ AWS-native architecture with modular design
⚙️ Full Infrastructure as Code using Terraform
🔐 Secure IAM setup and fine-grained access control
📦 PostgreSQL provisioning and initialization on Amazon RDS
🌐 Load balancing with ALB for high availability
📁 Static asset hosting with S3
🔒 Custom VPC, public/private subnets, security groups, and routing

🧑‍💻 Tooling & Technologies

Terraform – AWS resource provisioning and state management
Docker – App containerization and deployment
PostgreSQL (RDS) – Managed relational database
Amazon EC2 – Compute environment
Amazon S3 – Object storage for static content
ALB, IAM, VPC – Load balancing, security, and networking

🧠 Lessons Learned

Built and deployed a reproducible cloud infrastructure with Terraform
Automated deployment of a containerized application using AWS EC2
Implemented secure, scalable cloud architecture using best practices
Deepened understanding of VPC networking, IAM roles, and resource security

## 👤 Author

**Suma Hotti**
[LinkedIn](https://www.linkedin.com/in/sumah)

---


