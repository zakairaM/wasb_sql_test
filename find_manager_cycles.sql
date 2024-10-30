-- Select the manager ID as employee_id and concatenate direct reports
SELECT 
    e.manager_id AS employee_id,  -- Select the manager ID and alias it as employee_id
    ARRAY_JOIN(ARRAY_AGG(e.employee_id), ',') AS direct_reports  -- Aggregate employee IDs into an array and join them as a comma-separated string
FROM 
    memory.default.EMPLOYEE e  
GROUP BY 
    e.manager_id  -- Group the results by the manager ID to collect all employees reporting to the same manager
ORDER BY 
    employee_id;  -- Order the results by employee_id for a clear output
