create database employeesdb;
use employeesdb;

create table jobdepartment(
			job_id int primary key,
            jobdept varchar(50),
            name varchar(100),
            description text,
            salaryrange varchar(50)
);

create table salarybonus(
			  salary_id int primary key,
              jobid int,
              amount decimal(10,2),
              annual decimal(10,2),
              bonus decimal(10,2),
              constraint fk_salary_job foreign key (jobid)
              references jobdepartment (job_id)
              on delete cascade
              on update cascade
);

create table employee(
			 emp_id int primary key,
             firstname varchar(50),
             lastname varchar(50),
             gender varchar(10),
             age int,
             contact_add varchar(100),
             emp_email varchar(100) unique,
             emp_pass varchar(50),
             job_id int,
             constraint fk_employee_job foreign key (job_id)
             references jobdepartment (job_id)
             on delete set null
             on update cascade
);

create table qualification(
			 qualid int primary key ,
             emp_id int,
             position varchar(50),
             requirements varchar(50),
             date_in date,
             constraint fk_qualification_emp foreign key (emp_id)
             references employee(emp_id)
             on delete cascade
             on update cascade
);

create table leaves(
			 leave_id int primary key,
             emp_id int,
             date date,
             reason text,
             constraint fk_leave_emp foreign key (emp_id)
             references employee(emp_id)
             on delete cascade
             on update cascade
);

create table payroll(
			 payroll_id int primary key ,
             emp_id int,
             job_id int,
             salary_id int,
             leave_id int,
             date Date,
             report text,
             total_amount decimal(10,2),
             
             constraint fk_payroll_emp foreign key (emp_id) 
             references employee(emp_id)
             on delete cascade on update cascade,
             
             constraint fk_payroll_job foreign key (job_id)
             references jobdepartment(job_id)
             on delete cascade on update cascade,
             
			 constraint fk_payroll_salary foreign key (salary_id) 
             references salarybonus(salary_id)
             on delete cascade on update cascade,
             
             constraint fk_payroll_leave foreign key (leave_id) 
             references leaves(leave_id)
             on delete set null on update cascade
);




-- Analysis Questions

-- 1. EMPLOYEE INSIGHTS
 
 -- How many unique employees are currently in the system?
 

