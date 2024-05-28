-- Step 1: Add Columns to Each Table

-- Add created_at and updated_at columns to the commitment table
ALTER TABLE commitment
ADD COLUMN created_at timestamptz DEFAULT NOW(),
ADD COLUMN updated_at timestamptz DEFAULT NOW();

-- Add created_at and updated_at columns to the target table
ALTER TABLE target
ADD COLUMN created_at timestamptz DEFAULT NOW(),
ADD COLUMN updated_at timestamptz DEFAULT NOW();

-- Add created_at and updated_at columns to the emission table
ALTER TABLE emission
ADD COLUMN created_at timestamptz DEFAULT NOW(),
ADD COLUMN updated_at timestamptz DEFAULT NOW();

-- Step 2: Ensure updated_at Column is Automatically Updated

-- Create the update_timestamp function
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers for each table

-- For the commitment table
CREATE TRIGGER set_timestamp_commitment
BEFORE UPDATE ON commitment
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- For the target table
CREATE TRIGGER set_timestamp_target
BEFORE UPDATE ON target
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- For the emission table
CREATE TRIGGER set_timestamp_emission
BEFORE UPDATE ON emission
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- For the company table
CREATE TRIGGER set_timestamp_company
BEFORE UPDATE ON company
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
