ALTER TABLE `players` ADD COLUMN `med_gear` TEXT NULL AFTER `mediclevel`;
UPDATE `players` SET `med_gear` = '"[]"';