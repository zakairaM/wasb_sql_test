-- Select the necessary fields and calculate total expenses for each employee
SELECT 
    e.employee_id,  -- Get the employee ID
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,  -- Combine first and last name for employee
    e.manager_id,  -- Get the manager ID
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name,  -- Combine first and last name for manager
    SUM(exp.unit_price * exp.quantity) AS total_expensed_amount  -- Calculate total expense amount
FROM 
    memory.default.EXPENSE exp  -- From the EXPENSE table
JOIN 
    memory.default.EMPLOYEE e ON exp.employee_id = e.employee_id  -- Join with EMPLOYEE table to get employee details
JOIN 
    memory.default.EMPLOYEE m ON e.manager_id = m.employee_id  -- Join with EMPLOYEE table again to get manager details
GROUP BY 
    e.employee_id, e.first_name, e.last_name, e.manager_id, m.first_name, m.last_name  -- Group by employee and manager details
HAVING 
    SUM(exp.unit_price * exp.quantity) > 1000  -- Filter to include only employees with total expenses over 1000
ORDER BY 
    total_expensed_amount DESC;  -- Order results by total_expensed_amount in descending order
