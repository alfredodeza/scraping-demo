-- Uncomment when db doesn't exist
-- CREATE DATABASE exploitdb
--  ENCODING 'UTF8';

CREATE TABLE IF NOT EXISTS exploit (
	id integer primary key,
	exploit_id VARCHAR(60),
	cves TEXT);
