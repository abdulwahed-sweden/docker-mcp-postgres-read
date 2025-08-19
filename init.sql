-- Schema
CREATE TABLE departments (
  dept_id SERIAL PRIMARY KEY,
  dept_name VARCHAR(50) NOT NULL UNIQUE,
  location VARCHAR(100)
);

CREATE TABLE employees (
  emp_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE,
  hire_date DATE NOT NULL,
  salary NUMERIC(10,2) CHECK (salary >= 0),
  dept_id INTEGER REFERENCES departments(dept_id)
);

CREATE TABLE projects (
  project_id SERIAL PRIMARY KEY,
  project_name VARCHAR(100) NOT NULL,
  dept_id INTEGER REFERENCES departments(dept_id),
  budget NUMERIC(12,2) CHECK (budget >= 0),
  start_date DATE,
  end_date DATE
);

CREATE TABLE assignments (
  emp_id INTEGER REFERENCES employees(emp_id),
  project_id INTEGER REFERENCES projects(project_id),
  role VARCHAR(80),
  allocation_percent INTEGER CHECK (allocation_percent BETWEEN 0 AND 100),
  PRIMARY KEY (emp_id, project_id)
);

-- Data: Departments
INSERT INTO departments (dept_name, location) VALUES
('Engineering', 'Floor 5'),
('Marketing',  'Floor 3'),
('Sales',      'Floor 2'),
('HR',         'Floor 1'),
('Finance',    'Floor 4');

-- Data: Employees
INSERT INTO employees (first_name, last_name, email, hire_date, salary, dept_id) VALUES
('John',   'Smith',   'john.smith@company.com',   '2020-06-15',  85000.00, 1),
('Sarah',  'Johnson', 'sarah.johnson@company.com','2019-03-22',  92000.00, 1),
('Michael','Williams','michael.w@company.com',    '2021-11-05',  78000.00, 2),
('Emily',  'Brown',   'emily.b@company.com',      '2022-01-30',  68000.00, 3),
('David',  'Jones',   'david.j@company.com',      '2018-07-14', 105000.00, 1),
('Jessica','Garcia',  'jessica.g@company.com',    '2023-02-18',  72000.00, 2),
('Robert', 'Miller',  'robert.m@company.com',     '2017-09-01', 112000.00, 5),
('Linda',  'Davis',   'linda.d@company.com',      '2020-12-10',  59000.00, 4),
('Chris',  'Wilson',  'chris.w@company.com',      '2024-03-21',  64000.00, 3),
('Patricia','Taylor', 'patricia.t@company.com',   '2022-06-02',  97000.00, 1),
('Barbara','Moore',   'barbara.m@company.com',    '2021-04-19',  73000.00, 2),
('James',  'Anderson','james.a@company.com',      '2019-10-07',  88000.00, 5);

-- Data: Projects
INSERT INTO projects (project_name, dept_id, budget, start_date, end_date) VALUES
('Data Platform Revamp', 1, 450000.00, '2023-01-01', NULL),
('Brand Refresh 2025',   2, 180000.00, '2024-09-01', '2025-03-31'),
('CRM Migration',        3, 220000.00, '2024-02-15', NULL),
('Talent Analytics',     4, 120000.00, '2024-05-01', NULL),
('Cost Optimization',    5, 300000.00, '2023-11-10', NULL);

-- Data: Assignments
INSERT INTO assignments (emp_id, project_id, role, allocation_percent) VALUES
(1, 1, 'Backend Engineer', 60),
(2, 1, 'Tech Lead',        50),
(5, 1, 'Data Architect',   70),
(3, 2, 'Marketing Analyst',40),
(6, 2, 'Content Strategist',50),
(4, 3, 'Sales Ops',        50),
(9, 3, 'Sales Analyst',    30),
(8, 4, 'HR Analyst',       60),
(10,5, 'Finance Partner',  40),
(7, 5, 'Cost Controller',  50);

-- Read-only user
CREATE USER readonly WITH PASSWORD 'readonly123';
GRANT CONNECT ON DATABASE company TO readonly;
GRANT USAGE ON SCHEMA public TO readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly
