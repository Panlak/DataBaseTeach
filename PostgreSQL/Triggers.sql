DROP TABLE TriggersTable;
CREATE TABLE TriggersTable
(
	Id INTEGER PRIMARY KEY,
	S TEXT

);
SELECT * FROM TriggersTable;





 /*Тригер BEFORE*/
CREATE TRIGGER TriggersTable_before_stmt
BEFORE INSERT OR UPDATE OR DELETE ON TriggersTable
FOR EACH STATEMENT EXECUTE PROCEDURE describe(); 
/*Тригер рівня оператора для кожного оператора потрібно виконувати процедуру describe
(Функція)*/ 

/*Тригер AFTER*/
CREATE TRIGGER TriggersTable2_after_stmt
AFTER INSERT OR UPDATE OR DELETE ON TriggersTable 
FOR EACH STATEMENT EXECUTE PROCEDURE describe(); 

/*---------------------------------------------*/

/* На рівні рядків*/
/*Тригер BEFORE*/
CREATE TRIGGER TriggersTable3_before_stmt
BEFORE INSERT OR UPDATE OR DELETE ON TriggersTable 
FOR EACH ROW EXECUTE PROCEDURE describe(); 
/*Тригер AFTER*/
CREATE TRIGGER TriggersTable4_after_stmt
AFTER INSERT OR UPDATE OR DELETE ON TriggersTable 
FOR EACH ROW EXECUTE PROCEDURE describe();





CREATE OR REPLACE FUNCTION describe() RETURNS trigger as $$ /* describe без параметрів і повертає спеціальне значення trigger*/
DECLARE
	rec record;
	str text :='';
BEGIN
	IF TG_LEVEL = 'ROW' THEN /*TG_LEVEL це контекст в яку трігер буде передавати в цю функцію може бути ROW або STATEMENT*/
		CASE TG_OP /*якщ була визвана функція строчного тригера то ми ще подивимося TG_OP перемінну це яка операція виконувалася над рядком*/
			WHEN 'DELETE' THEN rec :=OLD; str := OLD ::text; /*для DELETE є запис  OLD :: перетворенна до text в string переміну(рядкову) яка була створена раніше в неї запишемо*/
			WHEN 'UPDATE' THEN rec :=NEW; str :=OLD || ' -> ' || NEW; /*Для UPDATE записуєм дві і NEW , OLD*/
			WHEN 'INSERT' THEN rec :=NEW; str :=NEW::text;/* для INSERT запишемо новий запис NEW*/
		END CASE; 
	END IF;
	RAISE NOTICE '% % % %: %', TG_TABLE_NAME, TG_WHEN, TG_OP,TG_LEVEL,str; /*в кінці роботи трігера через ROISE NOTTICE виведемо
	контекст імя таблиці (TG_TABLE_NAME),умову(TG_WHEN) якщо була,операцію (TG_OP), рівень трігера(TG_LEVEL),і str(рядок) заповнену зформеровану */
	RETURN rec;
	/*В кінці якщо це був ROW трігер ми повинні щось вернути в данному випадку rec*/
END;
$$ LANGUAGE plpgsql;


INSERT INTO TriggersTable VALUES(1,'ccc');

UPDATE TriggersTable SET S = 'aaa';


INSERT INTO TriggersTable VALUES(1,'sss'),(3,'ddd')
ON CONFLICT(Id) DO UPDATE SET s = EXCLUDED.s; 

DELETE FROM TriggersTable;
/*-------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------*/

DROP TABLE main;

CREATE TABLE main
(
	Id INTEGER PRIMARY KEY,
	S TEXT

);
/*Історична таблиця*/


DROP TRIGGER main_history_update ON main;
DROP TRIGGER main_history_delete ON main;
DROP TABLE main_history;



CREATE TABLE main_history(LIKE TriggersTable);


ALTER TABLE main_history ADD  start_date timestamp, ADD end_date timestamp;


/*Одна тригерна функція буде образувати вставку рядків*/
CREATE OR REPLACE FUNCTION history_insert() RETURNS trigger as $$
BEGIN
	EXECUTE format('INSERT INTO %I SELECT($1).*,current_timestamp, NULL', /*Буде вставляти в таблицю в яку треба що була таблиця _history і
				   щоб у таблиці  з припискою history була така сама строктура так як у main(таблиці) і + 2 стовпця tart_date timestamp, ADD end_date timestamp*/
				  	TG_TABLE_NAME || '_history')/* ($1).* це ми будемо все передавати запись NEW*/
	USING NEW;
	
	RETURN NEW;	
END;
$$ LANGUAGE plpgsql;

/*Друга функція буде обробляти видалення*/
CREATE OR REPLACE FUNCTION history_delete() RETURNS trigger as $$
BEGIN
	EXECUTE format('UPDATE %I SET end_date = current_timestamp WHERE id = $1 AND end_date IS NULL',
				   	TG_TABLE_NAME || '_history')
	USING OLD.id;
			
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;



/**/

CREATE TRIGGER main_history_update
AFTER INSERT OR UPDATE ON main
FOR EACH ROW EXECUTE PROCEDURE history_insert();

/**/

CREATE TRIGGER main_history_delete
AFTER UPDATE OR DELETE ON main
FOR EACH ROW EXECUTE PROCEDURE history_delete();

/*Важливі моменти*/
/*
*Оновлення трактується як вставка і видалення; тут важливий порядок, в
якому спрацюють тригери (по алфавіту).

*Current_timestamp повертає час початоку транзакції потому при обновленні
start_date одного рядку буде рівно end_date іншої.

*Використання АFTER-тригрів позволяє запобігти проблем с UPSERT і
потенцільними конфліктами с інакшими трігерами котрі можуть існувати в основній таблиці
*/

INSERT INTO main VALUES (1,'Перше значення');

INSERT INTO main VALUES (2,'Друге значення');

UPDATE main SET s = 'Перше значення (змінено)' WHERE Id = 1;

SELECT NOW();

SELECT * FROM main ORDER BY  id;


INSERT INTO main VALUES(2,'Друге значення (змінено)'),(3,'Третє значення')
ON CONFLICT(id) DO UPDATE SET s = EXCLUDED.s;


DELETE FROM main WHERE id = 1;


SELECT * FROM main_history ORDER BY id, start_date;

/*-------------------------------------------------------------------------------------------*/
/*Тепер по історичній таблиці можна востановити історію  на любий момент часу (це нагадує роботу механізма MVCC) */



SELECT id,s
FROM main_history
WHERE start_date <= '2021-04-04 17:03:50.843766+02' AND '2021-04-04 17:03:50.843766+02' < end_date
ORDER BY id;

/*-------------------------------------------------------------------------------------------*/
/*Оновлюєме представлення*/

/*2 таблиці : позиції (items) і рядки заказів (order_lines) :*/

CREATE TABLE items
(
	id serial PRIMARY KEY,
	description text NOT NULL,
	CONSTRAINT items_desc_unique UNIQUE(description)
);

CREATE TABLE order_lines
(
	id serial PRIMARY KEY,
	item_id integer NOT NULL ,
	qty integer NOT NULL,
	FOREIGN KEY (item_id) REFERENCES items(id)
);

INSERT INTO items (description) VALUES	('Цвях');

INSERT INTO items (description) VALUES	('Гайка');

INSERT INTO items (description) VALUES	('Шуруп');


INSERT INTO order_lines (item_id,qty) VALUES (2,50);

INSERT INTO order_lines (item_id,qty) VALUES (1,50);


/*Представлення View*/

CREATE VIEW order_lines_v AS SELECT ol.id , i.description, ol.qty
FROM order_lines ol JOIN items i ON ol.item_id = i.id;

/*----------------------------------------------------------------*/
UPDATE order_lines_v SET  description = 'Шоруп' WHERE id = 3;
/*ERROR:  cannot update view "order_lines_v"
DETAIL:  Views that do not select from a single table or view are not automatically updatable.
HINT:  To enable updating the view, provide an INSTEAD OF UPDATE trigger or an unconditional ON UPDATE DO INSTEAD rule.
SQL state: 55000*/
	
/*Ми можемо визначити тригер. Тригерна функція може виглядати наприклад так */

CREATE OR REPLACE FUNCTION view_update() RETURNS trigger AS $$
BEGIN
	UPDATE order_lines 
	SET item_id = (SELECT id FROM items WHERE description = NEW.description),
	qty = NEW.qty;
	RETURN NEW;
EXCEPTION
	WHEN not_null_violation THEN
		RAISE EXCEPTION 'Вкзаної позиції "%" не існує', NEW.description;
END;
$$ LANGUAGE plpgsql;
	
/*Сам тригер*/


CREATE TRIGGER order_lines_v_upd
INSTEAD OF UPDATE ON order_lines_v
FOR EACH ROW EXECUTE PROCEDURE view_update();

/*Перевіремо*/


UPDATE order_lines_v SET qty = qty + 10 RETURNING *;
/*ТАБЛИЦЯ ПРЕДСТАВЛЕННЯ*/
SELECT * FROM order_lines_v;
/*------------------*/

/*Основна таблиця*/
SELECT * FROM order_lines;
/*------------------*/



/*Тригери подій*/

/*Приклад тригера для події DLL_COMMAND_END*/

/*Зробимо функцію котра описує контекст виклика*/

CREATE OR REPLACE FUNCTION describe_ddl() RETURNS event_trigger AS $$
DECLARE
	r record;
BEGIN
	--для події DLL_COMMAND_END контекст виклика в спеціальній функції
	FOR r IN SELECT * FROM pg_event_trigger_ddl_commands() LOOP
		RAISE NOTICE '%. тип: %, OID: %, імя: % ',
			r.command_tag, r.object_type, r.objid, r.object_identity;
	END LOOP;
	
	--Функції тригера подій не потрібно повертати значення
END;
$$ LANGUAGE plpgsql;


/*Сам тригер*/

	CREATE EVENT TRIGGER after_ddl
	ON ddl_command_end EXECUTE PROCEDURE describe_ddl();
	
CREATE TABLE t3(id serial primary key);	
	
	
