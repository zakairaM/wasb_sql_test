-- Create the SUPPLIER table
CREATE TABLE IF NOT EXISTS memory.default.SUPPLIER (
    supplier_id TINYINT,
    name VARCHAR
);



-- Create the INVOICE table
CREATE TABLE IF NOT EXISTS memory.default.INVOICE (
    supplier_id TINYINT,
    invoice_amount DECIMAL(8, 2),
    due_date DATE
);

--  Populate the SUPPLIER table

INSERT INTO memory.default.SUPPLIER (supplier_id, name) VALUES
    (1, 'Catering Plus'),
    (2, 'Dave''s Discos'),  
    (3, 'Entertainment Tonight'),
    (4, 'Ice Ice Baby'),
    (5, 'Party Animals');

--  Populate the INVOICE table
INSERT INTO memory.default.INVOICE (supplier_id, invoice_amount, due_date) VALUES
    (5, 6000.00, date_trunc('MONTH', date_add('MONTH', 4, current_date)) - interval '1' day), -- Last day of month in 3 months
    (1, 2000.00, date_trunc('MONTH', date_add('MONTH', 3, current_date)) - interval '1' day),  -- Last day of month in 2 months
    (1, 1500.00, date_trunc('MONTH', date_add('MONTH', 4, current_date)) - interval '1' day),  -- Last day of month in 3 months
    (2, 500.00, date_trunc('MONTH', date_add('MONTH', 2, current_date)) - interval '1' day),   -- Last day of month in 1 month
    (3, 6000.00, date_trunc('MONTH', date_add('MONTH', 4, current_date)) - interval '1' day),  -- Last day of month in 3 months
    (4, 4000.00, date_trunc('MONTH', date_add('MONTH', 7, current_date)) - interval '1' day);  -- Last day of month in 6 months


-- Explanation:
-- current_date: Gets today's date.
-- date_add('MONTH', x+1, current_date): Adds x+1 months to the current date.
-- date_trunc('MONTH', ...): Truncates the date to the first day of the month.
-- - interval '1' day: Subtracts one day to get the last day of the previous month which is the last day of the x month that we want.