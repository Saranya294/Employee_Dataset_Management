# Employee_Dataset_Management

**🚀PROJECT TITLE : Employee Management System (EMS)**
- The Employee Management System (EMS) is a database-driven project designed to efficiently manage employee-related information within an organization.It helps track employee personal details, job roles, salary structures, qualifications, leave records, and payroll data.
           
- The system ensures data accuracy and consistency using relational tables, foreign keys, and cascading actions.

- It also provides useful insights such as payroll calculation, leave tracking, and department-wise analysis to support HR operations.


**📝PROBLEM STATEMENT** 

Managing employee data is often difficult when information is scattered across multiple files or systems.
This can cause:
        - Errors in payroll calculation
        - Difficulty in tracking leaves
        - Inefficiency in HR processes

Solution:

This project integrates all employee-related details into a single system.
By using relational database design with foreign keys and cascading updates/deletes, the system keeps data consistent and allows easy management of:
                    - Job departments
                    - Employee details
                    - Salary and bonuses
                    - Qualifications
                    - Leave records
                    - Payroll processing

 ### 🗂 Database Structure ###                  

``` mermaid
erDiagram
    jobdepartment {
        int job_id
        varchar jobdept
        varchar name
        text description
        varchar salaryrange
    }

    salarybonus {
        int salary_id
        int jobid
        decimal amount
        decimal annual
        decimal bonus
    }

    employee {
        int emp_id
        varchar firstname
        varchar lastname
        varchar gender
        int age
        varchar contact_add
        varchar emp_email
        varchar emp_pass
        int job_id
    }

    qualification {
        int qualid
        int emp_id
        varchar position
        varchar requirements
        date date_in
    }

    leaves {
        int leave_id
        int emp_id
        date date
        text reason
    }

    payroll {
        int payroll_id
        int emp_id
        int job_id
        int salary_id
        int leave_id
        date date
        text report
        decimal total_amount
    }

    %% Relationships
    jobdepartment ||--o{ employee : has
    jobdepartment ||--|| salarybonus : defines
    employee ||--o{ qualification : earns
    employee ||--o{ leaves : takes
    employee ||--o{ payroll : linked
    jobdepartment ||--o{ payroll : linked
    salarybonus ||--o{ payroll : linked
    leaves ||--o{ payroll : linked

```

**📊 Example Analysis Questions**

1. EMPLOYEE INSIGHTS
   - How many unique employees are currently in the system?
   - Which departments have the highest number of employees?
   - What is the average salary per department?
   - Who are the top 5 highest-paid employees?
   - What is the total salary expenditure across the company?

2. JOB ROLE AND DEPARTMENT ANALYSIS
   - How many different job roles exist in each department?
   - What is the average salary range per department?
   - Which job roles offer the highest salary?
   - Which departments have the highest total salary allocation?

3. QUALIFICATION AND SKILLS ANALYSIS
   - How many employees have at least one qualification listed?
   - Which positions require the most qualifications?
   - Which employees have the highest number of qualifications?

4. LEAVE AND ABSENCE PATTERNS
   - Which year had the most employees taking leaves?
   - What is the average number of leave days taken by its employees per department?
   - Which employees have taken the most leaves?
   - What is the total number of leave days taken company-wide?
   - How do leave days correlate with payroll amounts?

5. PAYROLL AND COMPENSATION ANALYSIS
   - What is the total monthly payroll processed?
   - What is the average bonus given per department?
   - Which department receives the highest total bonuses?
   - What is the average value of total_amount after considering leave deductions?

6. EMPLOYEE PERFORMANCE AND GROWTH
   - Which year had the highest number of employee promotions?


**⚙️ Technologies Used**
               - SQL / MySQL – Database design and implementation
               - ER Model – For relationships and schema design

**🔑 Key Features**
               - Centralized storage of employee information.
               - Secure relationships between tables using foreign keys.
               - Cascade actions to keep data consistent across all tables.
               - Payroll processing with salary and leave deductions.
               - Easy query support for HR analysis.

**🚀 How to Use**
              - Clone this repository.
              - Import the .sql file into MySQL or any relational database system.
              - Run the provided queries to create tables and insert sample data.
              - Use SQL queries to analyze employee and payroll data.



















































                    
