ALTER TABLE `vehicles`
	CHANGE COLUMN `inventory` `inventory` TEXT NOT NULL AFTER `color`;
	UPDATE vehicles SET inventory = "\"[[],0]\"";