CREATE OR REPLACE FUNCTION public.ispsyker(
	heroid integer)
    RETURNS boolean
    LANGUAGE 'plpgsql'
AS $BODY$
begin
	return exists (select * from psykers where id = heroid);
end
$BODY$;

CREATE INDEX IF NOT EXISTS effects_type_idx
    ON public.effects USING hash
    (type)
    TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS magicability_magicschool_idx
    ON public.magicability USING hash
    (magicschool)
    TABLESPACE pg_default;

CREATE VIEW lookingGoodPsyker AS 
SELECT hero.name as "Имя псайкера", race as Раса, mana AS "Запас Маны", skillpoint as "Очки навыка",
soulpoint as "Очки развития души", mindpoint as "Очки развития разума", godpowerpoint as "Божественные частицы",
ranks.name as "Текущий ранг", mentalstength as "Ментальная сила", mysticism as Мистицизм,
minddurability as "Ментальное сопротивление",
magicskill as Владение, sourcepower as "Источник сил", magicrank as "Ранг магии" FROM psykers, hero, ranks
WHERE hero.id = psykers.id and psykers.curRank = ranks.id 

create view topPsykers as  (with top  as (select race.name as racename, max(mentalstength) from psykers
join hero on psykers.id = hero.id
join race on hero.race = race.id
group by grouping sets ((), (race.name))
)
select racename, hero.name from hero, top, psykers
where hero.id=psykers.id and mentalstength = max)