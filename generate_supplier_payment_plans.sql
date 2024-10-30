SELECT 
    s.supplier_id AS SUPPLIER_ID,  -- Selects the supplier ID from the SUPPLIER table and aliases it as SUPPLIER_ID
    s.name AS SUPPLIER_NAME,        -- Selects the supplier name from the SUPPLIER table and aliases it as SUPPLIER_NAME
    LEAST(1500.00, i.invoice_amount - (1500.00 * (n - 1))) AS PAYMENT_AMOUNT, -- Calculates the payment amount, capping it at 1500
    GREATEST(0, i.invoice_amount - (1500.00 * n)) AS BALANCE_OUTSTANDING,  -- Calculates the outstanding balance after each payment, ensuring it doesn't go below 0
    date_add('MONTH', n - 1, date_trunc('MONTH', current_date) - interval '1' day) AS PAYMENT_DATE -- Calculates the payment date for each payment, adjusting to the end of the month
FROM 
    memory.default.SUPPLIER s  -- Specifies the SUPPLIER table from the memory.default schema
JOIN 
    memory.default.INVOICE i ON s.supplier_id = i.supplier_id  -- Joins the INVOICE table on supplier_id to get corresponding invoices
CROSS JOIN 
    UNNEST(SEQUENCE(1, 10)) AS t(n) -- Generates a sequence of numbers from 1 to 10, representing payment instances
WHERE 
    (i.invoice_amount - (1500.00 * (n - 1))) > 0 -- Filters rows to ensure payments are only made while there is a remaining balance
ORDER BY 
    SUPPLIER_ID, PAYMENT_DATE; -- Orders the final result set by SUPPLIER_ID and PAYMENT_DATE
