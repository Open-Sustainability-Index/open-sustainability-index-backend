ALTER TABLE emission RENAME COLUMN currency TO currency_local;

ALTER TABLE emission ADD COLUMN currency VARCHAR(3) DEFAULT 'USD';
