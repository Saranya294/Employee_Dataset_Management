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

select * from jobdepartment;
select * from salarybonus;
select * from employee;
select * from qualification;
select * from leaves;
select * from payroll;

show tables;


-- Analysis Questions

-- 1. EMPLOYEE INSIGHTS
 
 -- How many unique employees are currently in the system?
 select count(distinct emp_id)  as employee_count from employee;
 
 
 -- Which departments have the highest number of employees?
 
select jobdepartment.jobdept , count(emp_id)  as employee_count
from employee
inner join jobdepartment  on
employee.job_id = jobdepartment.job_id
group by jobdept
order by employee_count desc limit 2; 


-- What is the average salary per department?

select jobdepartment.jobdept,avg(amount) as avg_salary
from jobdepartment
inner join salarybonus on 
jobdepartment.job_id = salarybonus.jobid 
group by jobdept ;

-- Who are the top 5 highest-paid employees?

select employee.firstname,employee.lastname,salarybonus.amount
from employee
inner join salarybonus on
employee.job_id = salarybonus.jobid
order by salarybonus.amount
limit 5;

-- What is the total salary expenditure across the company?

select sum(salarybonus.amount) as total_emp_expenditure
from employee
inner join salarybonus on
employee.job_id = salarybonus.jobid;


-- 2. JOB ROLE AND DEPARTMENT ANALYSIS 

-- How many different job roles exist in each department?

select jobdept, count(distinct name)  as unique_count from jobdepartment
group by jobdept;

-- What is the average salary range per department?

select jobdepartment.jobdept,avg(salarybonus.amount) as avg_salary
from jobdepartment 
inner join salarybonus on
jobdepartment.job_id = salarybonus.jobid
group by jobdept;


-- Which job roles offer the highest salary?

select jobdepartment.name as job_role,jobdepartment.jobdept,salarybonus.amount as 
salary from jobdepartment 
inner join salarybonus on 
jobdepartment.job_id = salarybonus.jobid
where amount = (select max(amount) as max_salary from salarybonus);

--  Which departments have the highest total salary allocation?

select jobdepartment.jobdept,sum(salarybonus.amount) as total_salary_allocation
from jobdepartment 
inner join salarybonus on 
jobdepartment.job_id  = salarybonus.jobid
group by jobdepartment.jobdept
order by total_salary_allocation desc;


-- 3. QUALIFICATION AND SKILLS ANALYSIS 

-- How many employees have at least one qualification listed?


select count(distinct qualification.emp_id) as employee_count
from qualification
inner join employee on
qualification.emp_id = employee.emp_id;

-- Which positions require the most qualifications?

select position,count(*) as total_qualification
from qualification
group by position
order by  total_qualification desc;

-- Which employees have the highest number of qualifications?

select employee.emp_id,employee.firstname,employee.lastname,count(qualification.qualid)
as qualification_count from qualification
inner join employee on qualification.emp_id =  employee.emp_id
group by employee.emp_id, employee.firstname,employee.lastname
order by qualification_count desc;


-- 4. LEAVE AND ABSENCE PATTERNS

-- Which year had the most employees taking leaves?

select year(leaves.date) as year,
count(distinct employee.emp_id) as total_employee
from employee
inner join leaves
on leaves.emp_id = employee.emp_id
group by year(leaves.date)
order by total_employee desc;

-- What is the average number of leave days taken by its employees per department?


with emp_leave as(
			select employee.emp_id,employee.job_id,count(*) as leave_count
            from leaves
            inner join employee on
            leaves.emp_id = employee.emp_id
            group by employee.emp_id , employee.job_id
)
select jobdepartment.jobdept,avg(emp_leave.leave_count) as avg_leave_per_emp
from emp_leave
inner join jobdepartment on
emp_leave.job_id = jobdepartment.job_id
group by jobdepartment.jobdept;

--  Which employees have taken the most leaves?

select employee.emp_id,employee.firstname,employee.lastname ,count(leaves.leave_id) as leaves_count
from employee
inner join leaves on
employee.emp_id = leaves.emp_id
group by employee.emp_id,employee.firstname,employee.lastname 
order by leaves_count desc;

-- What is the total number of leave days taken company-wide?

select count(*) as total_leave_days
from leaves;

-- How do leave days correlate with payroll amounts?

select employee.emp_id,employee.firstname,employee.lastname,
count(leaves.leave_id) as total_leave,
sum(payroll.total_amount) as total_payroll_amount
from employee
left join leaves on
employee.emp_id = leaves.emp_id
left join payroll on
employee.emp_id = payroll.emp_id
group by employee.emp_id , employee.firstname,employee.lastname
order by total_leave desc;

-- 5.PAYROLL AND COMPENSATION ANALYSIS

-- What is the total monthly payroll processed?

select
	year(date) as payroll_year,
    month(date) as payroll_month,
    sum(total_amount) as total_monthly_payroll
from payroll
group by year(date),month(date)
order by payroll_year,payroll_month;

--  What is the average bonus given per department?

select 
	jobdepartment.jobdept,
    avg(salarybonus.bonus) as avg_bonus
from jobdepartment
inner join  salarybonus on
salarybonus.jobid = jobdepartment.job_id
group by jobdepartment.jobdept;


--   Which department receives the highest total bonuses?

select 
	jobdepartment.jobdept,
    sum(salarybonus.bonus) as total_bonus
from jobdepartment
inner join salarybonus on
salarybonus.jobid= jobdepartment.job_id
group by jobdepartment.jobdept
order by total_bonus desc;

--  What is the average value of total_amount after considering leave deductions?

select 
	avg(total_amount) as avg_pay_after_leaves
from payroll;

-- 6. EMPLOYEE PERFORMANCE AND GROWTH

-- Which year had the highest number of employee promotions?

select 
	year(date_in) as promotion_year,
    count(*) as total_promotions
from qualification
group by year(date_in)
order by total_promotions desc
limit 1;
