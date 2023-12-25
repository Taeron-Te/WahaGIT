CREATE OR REPLACE FUNCTION public.ispsyker(
	heroid integer)
    RETURNS boolean
    LANGUAGE 'plpgsql'
AS $BODY$
begin
	return exists (select * from psykers where id = heroid);
end
$BODY$;

