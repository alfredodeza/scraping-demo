-- Uncomment when db doesn't exist
CREATE DATABASE exploitdb
  ENCODING 'UTF8';

CREATE TABLE IF NOT EXISTS exploits (
	id integer primary key,
	exploit_id VARCHAR(60),
	cves TEXT);
