CREATE OR REPLACE FUNCTION describe() RETURNS trigger as $$
DECLARE
	rec record;
	str text :='';
BEGIN
	IF TG_LEVEL = 'ROW' THEN
		CASE TG_OP
			WHEN 'DELETE' THEN rec :=OLD; str := OLD ::text;
			WHEN 'UPDATE' THEN rec :=NEW; str :=OLD || ' -> ' || NEW;
			WHEN 'INSERT' THEN rec :=NEW; str :=NEW::text;
		END CASE;
	END IF;
	RAISE NOTICE '% % % %: %', TG_TABLE_NAME, TG_WHEN, TG_OP, TG_OP,TG_LEVEL,str;
END;
$$ LANGUAGE plpsql;

CREATE FUNCTION;

