-- Абилка как ты будешь бить лицо
CREATE TABLE IF NOT EXISTS public.attackAbility
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name text COLLATE pg_catalog."default" NOT NULL,
    sector double precision,
    minDist integer NOT NULL,
    maxDist integer NOT NULL,
    damageArea integer,
    rechargeTime double precision NOT NULL,
    responseDelay double precision,
    doPointsPrice integer NOT NULL,
    defDamage integer NOT NULL,

    CONSTRAINT attackAbility_pkey PRIMARY KEY (id),
    CONSTRAINT aauname UNIQUE (name),
    CONSTRAINT aacheckdamageArea CHECK (damageArea >= 0) NOT VALID,
    CONSTRAINT aacheckdefDamage CHECK (defDamage > 0) NOT VALID,
    CONSTRAINT aacheckdoPointPrice CHECK (doPointsPrice > 0) NOT VALID,
    CONSTRAINT aacheckminDis CHECK (minDist < maxDist) NOT VALID,
    CONSTRAINT aacheckrechargeTime CHECK (rechargeTime > 0::double precision) NOT VALID,
    CONSTRAINT aacheckresponseDelay CHECK (responseDelay > 0::double precision) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.attackAbility
    OWNER to postgres;

INSERT INTO public.attackAbility(
	        name,             sector, minDist, maxDist, damageArea, rechargeTime, responseDelay, doPointsPrice, defDamage)
	VALUES  ('Humiliating spit',    1,      1, 2,   null, 1, null, 1,   1),
            ('Standart shot',       15,     1, 40,  null, 1, null, 1,   15),
            ('Power shot',          7.5,    1, 60,  null, 2, null, 1,   40),
            ('Sinper shot',         2,      60, 280,null, 5, 2,    2,   180),
            ('Lasgun shot',         15,     1, 150, null, 1, null, 1,   30),
            
            ('Power sword strike',  45,     1, 2,   null, 1, null, 1,   200),
            ('Chain sword strike',  45,     1, 2,   null, 1, null, 1,   140),
            ('Hellgun shot',        12.5,   1, 180, null, 1, null, 1,   40),
            ('Plasma shot',         4,      5, 90,  null, 1, null, 2,   400),
            ('Explosion frag',      0.15,   10, 30, 12,   1, 1,    1,  150),
            
            ('Explosion krak',      0.15,   4, 30,  4,    1, 1,    1,  200),
            ('Explosion melta',     0.2,    2, 30,  2,    1, 1,    1,  400),
            ('Shoulder strike',     30,     1, 2,   null, 1, null, 1,   140),
            ('Death from above',    0.5,    1, 2,   null, 1, null, 1,   140),
            
            ('Storm kick',          7,      1, 2,   null, 1, null, 1,   140),
            ('Heroic strike',       45,     1, 2,   null, 2, null, 2,   400),
            ('Warp bolt',           15,     20,50,  1,    5, null, 1,   500),
            ('Melee stike',         45,     0, 1,   null, 1, null, 1,   50);

;

select * from public.attackAbility
-- Броня полупокера, лол 

CREATE TABLE IF NOT EXISTS public.armour
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name text COLLATE pg_catalog."default" NOT NULL,
    race integer NOT NULL,
    apdLevel integer NOT NULL,
    armour integer NOT NULL,
    bonusS integer,
    bonusD integer,
    bonusE integer,
    bonusA integer,
    bonusDoPoints integer,
    shield integer,
    shReducePercent double precision,
    armourAbility integer,
    manaRegen integer,

    CONSTRAINT armour_pkey PRIMARY KEY (id),
    CONSTRAINT armouruname UNIQUE (name),
    CONSTRAINT armour_to_aa FOREIGN KEY (armourAbility)
        REFERENCES public.armourAbility (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT armour_to_armourlevel FOREIGN KEY (apdLevel)
        REFERENCES public.armourlevel (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT armour_to_race FOREIGN KEY (race)
        REFERENCES public.race (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT armourcheckbonusA CHECK (bonusA <= 5) NOT VALID,
    CONSTRAINT armourcheckbonusD CHECK (bonusD <= 15) NOT VALID,
    CONSTRAINT armourcheckbonusE CHECK (bonusE <= 5) NOT VALID,
    CONSTRAINT armourcheckbonusS CHECK (bonusS <= 5) NOT VALID,
    CONSTRAINT armourcheckmanaRegen CHECK (manaRegen >= 0) NOT VALID,
    CONSTRAINT armourcheckshReducePercent CHECK (shReducePercent <= 100::double precision) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.armour
    OWNER to postgres;

INSERT INTO public.armour (name, race, apdLevel, armour) VALUES
('Guardsman`s equipment', 1, 5, 100),
('Carapax armour', 1, 8, 400),
('Kasr`kin armour', 1, 10, 800);

INSERT INTO public.armour (name, race, apdLevel, armour, bonusA) VALUES
('Scion Carapax', 1, 10, 800, 2);

INSERT INTO public.armour (name, race, apdLevel, armour, bonusS, bonusDoPoints, armourAbility) VALUES
('Mk.7 "Aquila"', 2, 14, 1500, 1, 6),
('Mk.8 "Errant"', 2, 14, 1700, 1, 7),
('Mk.7 with Repair elemnt', 2, 15, 1400, 1, 8),
('Eldar Soul Bone', 4, 10, 900, 2, 5),
('Mk.4 "Maximus"', 2, 14, 1700, 2, 6)
;

-- Способность брони

CREATE TABLE IF NOT EXISTS public.armourAbility
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name text COLLATE pg_catalog."default" NOT NULL,
    range double precision,
    doPointsPrice integer NOT NULL,
    type integer NOT NULL,
    CONSTRAINT armourAbility_pkey PRIMARY KEY (id),
    CONSTRAINT arauname UNIQUE (name),
    CONSTRAINT aa_to_typeofaa FOREIGN KEY (type)
        REFERENCES public.typeofaa (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT armacheckdoPointPrice CHECK (doPointsPrice > 0) NOT VALID,
    CONSTRAINT armacheckrange CHECK (range >= 0::double precision) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.armourAbility
    OWNER to postgres;

INSERT INTO public.armourAbility (name, range, doPointsPrice, type) VALUES
('Energy Shield', 0, 2, 1),
('Void Shield', 0, 3, 1),
('Warp Shield', 0, 1, 1),
('Teleporter backpack', 60, 1, 2),
('Eldar blink', 10, 1, 2),

('Self Healing', 0, 2, 3),
('Advanced Self Healing', 0, 3, 3),
('Self Repair', 0, 2, 4),
('Nano Repair', 0, 1, 4)
;
-- Классы

CREATE TABLE IF NOT EXISTS public.class
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name text COLLATE pg_catalog."default" NOT NULL,
    walkRange integer NOT NULL DEFAULT 1,
    bonusHealth integer NOT NULL,
    uniqueMove integer NOT NULL,
    classMeleeAttackAbility integer,
    bonusSkillPoint integer NOT NULL,
    doPoints integer NOT NULL,

    CONSTRAINT class_pkey PRIMARY KEY (id),
    CONSTRAINT classuname UNIQUE (name),
    CONSTRAINT class_to_aa FOREIGN KEY (classMeleeAttackAbility)
        REFERENCES public.attackAbility (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT class_to_ma FOREIGN KEY (uniqueMove)
        REFERENCES public.moveAbility (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT classcheckbonusSkillPoint CHECK (bonusSkillPoint <= 60) NOT VALID,
    CONSTRAINT classcheckbonushealth CHECK (bonusHealth >= 0) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.class
    OWNER to postgres;

INSERT INTO public.class(name, walkRange, bonusHealth, uniqueMove, classMeleeAttackAbility, bonusSkillPoint, doPoints

) VALUES    ('Infantry',                    10, 500, 1, null, 0, 1),
            ('Stormtrooper',                10, 1500, 2, 15, 0, 1),
            ('Tactical Space Marin',        20, 2500, 2, 13, 0, 2),
            ('Stormtrooper Space Marine',   40, 3000, 5, 14, 0, 2),
            ('Devastator',                  10, 4000, 1, null, 0, 2),

            ('The Phase Hunter',            60, 5000, 6, null, 0, 3),
            ('Demon',                       60, 5000, 7, null, 20, 3),
            ('Shadow Hunter',               30, 3500, 9, null, 0, 3),
            ('Psyker',                      10, 100,  1, null, 4, 2)
            ;

-- Герой

CREATE TABLE IF NOT EXISTS public.hero
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name text COLLATE pg_catalog."default" NOT NULL,
    family text COLLATE pg_catalog."default",
    nickname text COLLATE pg_catalog."default",
    age integer,
    race integer NOT NULL,
    class integer NOT NULL,
    healthCur integer NOT NULL DEFAULT 0,
    armourCur integer NOT NULL DEFAULT 0,
    shieldCur integer NOT NULL DEFAULT 0,
    strength integer NOT NULL DEFAULT 1,
    durability integer NOT NULL DEFAULT 1,
    evasion integer NOT NULL DEFAULT 1,
    artm integer NOT NULL DEFAULT 1,
    armourSet integer,
    primaryWeapon integer,
    secondWeapon integer,
    meleeWeapon integer,
    throwWeapon integer,
    lead integer,
    effects appliedEffect[] NOT NULL,

    CONSTRAINT hero_pkey PRIMARY KEY (id),
    CONSTRAINT herouname UNIQUE (name),
    CONSTRAINT hero_to_armor FOREIGN KEY (armourSet)
        REFERENCES public.armour (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT hero_to_class FOREIGN KEY (class)
        REFERENCES public.class (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT hero_to_hero FOREIGN KEY (lead)
        REFERENCES public.hero (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT hero_to_race FOREIGN KEY (race)
        REFERENCES public.race (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT hero_to_weapon1 FOREIGN KEY (primaryWeapon)
        REFERENCES public.weapon (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT hero_to_weapon2 FOREIGN KEY (secondWeapon)
        REFERENCES public.weapon (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT hero_to_weapon3 FOREIGN KEY (meleeWeapon)
        REFERENCES public.weapon (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT hero_to_weapon4 FOREIGN KEY (throwWeapon)
        REFERENCES public.weapon (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT herocheckArtm CHECK (artm >= 1 AND artm <= 20) NOT VALID,
    CONSTRAINT herocheckdurability CHECK (durability >= 1 AND durability <= 20) NOT VALID,
    CONSTRAINT herocheckevasion CHECK (evasion >= 1 AND evasion <= 20) NOT VALID,
    CONSTRAINT herocheckstrength CHECK (strength >= 1 AND strength <= 100) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.hero
    OWNER to postgres;

INSERT INTO public.hero(name, family,  age, race, class, healthCur, armourCur, effects)
VALUES('Arnold', 'Delam', 33, 1, 2, 100, 0, {});

INSERT INTO public.hero(name, family,  age, race, class, healthCur, armourCur, lead, effects)
VALUES  ('Deny', 'Aaron',       18, 1, 2, 100, 0, 1, {}),
        ('Edgard', 'Swanson',   21, 1, 2, 100, 0, 1, {}),
        ('Nikola', 'Kachinski', 26, 1, 2, 100, 0, 1, {}),
        ('Harry', 'Bishop',     23, 1, 2, 100, 0, 1, {}),
        ('Garry', 'Bishop',     23, 1, 9, 100, 0, 1, {})
        
;

INSERT INTO public.hero(name, family,  age, race, class, healthCur, armourCur, lead, effects)
VALUES  ('Bratigen',     154, 2, 2, 1500, 0, null, {}),
        ('Gally',       95, 2, 2, 1500, 0, 7, {}),
        ('Alex',      63, 2, 2, 1500, 0, 7, {}),
        ('Vicor',        83, 2, 2, 1500, 0, 7, {}),
        ('Desteriel',       143, 2, 9, 1500, 0, 7, {})
        
;

-- Trigger: checkarmourrace

-- DROP TRIGGER IF EXISTS checkarmourrace ON public.hero;

CREATE OR REPLACE TRIGGER checkarmourrace
    BEFORE INSERT OR UPDATE 
    ON public.hero
    FOR EACH ROW
    EXECUTE FUNCTION public.armourracetrigger();

-- Trigger: effectchecker

-- DROP TRIGGER IF EXISTS effectchecker ON public.hero;

CREATE OR REPLACE TRIGGER effectchecker
    BEFORE INSERT OR UPDATE 
    ON public.hero
    FOR EACH ROW
    EXECUTE FUNCTION public.checkeffectsid();

-- Trigger: heroweapons

-- DROP TRIGGER IF EXISTS heroweapons ON public.hero;

CREATE OR REPLACE TRIGGER heroweapons
    BEFORE INSERT OR UPDATE 
    ON public.hero
    FOR EACH ROW
    EXECUTE FUNCTION public.checkweapons();

-- Способность движения

CREATE TABLE IF NOT EXISTS public.moveAbility
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name text COLLATE pg_catalog."default" NOT NULL,
    rangeIndex double precision,
    doPointPrice integer NOT NULL,
    type integer NOT NULL,
    CONSTRAINT moveAbility_pkey PRIMARY KEY (id),
    CONSTRAINT moveabilityunamew UNIQUE (name),
    CONSTRAINT ma_to_typeofma FOREIGN KEY (type)
        REFERENCES public.moveAbility (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT macheckdoPointPrice CHECK (doPointPrice > 0) NOT VALID,
    CONSTRAINT macheckrangeindex CHECK (rangeIndex > 0::double precision) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.moveAbility
    OWNER to postgres;

INSERT INTO public.moveAbility (name, rangeIndex, doPointPrice, type)
VALUES  ('Walk',                1, 1, 1),
        ('Run',                 1.2, 1, 2),
        ('Jump',                1.2, 1, 3),
        ('Fly',                 1.5, 1, 4),
        ('Jump with jump pack', 1.5, 1, 5),
        ('Phase shift',         3, 1, 6),
        ('Warp shift',          3, 1, 7),
        ('Teleport',            2, 2, 8),
        ('Darkness shift',      0.6, 1, 9)
        ;

-- Расы

CREATE TABLE IF NOT EXISTS public.race
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name text COLLATE pg_catalog."default" NOT NULL,
    walkRange integer NOT NULL DEFAULT 1,
    health integer NOT NULL,
    bonusManaMin integer,
    bonusManaMax integer,
    bonusS integer,
    bonusD integer,
    bonusE integer,
    bonusA integer,
    doPoints integer NOT NULL,
    CONSTRAINT race_pkey PRIMARY KEY (id),
    CONSTRAINT raceuname UNIQUE (name),
    CONSTRAINT racecheckbonusA CHECK (bonusA <= 5) NOT VALID,
    CONSTRAINT racecheckbonusD CHECK (bonusD <= 5) NOT VALID,
    CONSTRAINT racecheckbonusE CHECK (bonusE <= 5) NOT VALID,
    CONSTRAINT racecheckbonusS CHECK (bonusS <= 5) NOT VALID,
    CONSTRAINT racecheckbonusmanaMin CHECK (bonusManaMin < bonusManaMax) NOT VALID,
    CONSTRAINT racecheckdopoint CHECK (doPoints <= 2) NOT VALID,
    CONSTRAINT racecheckhealth CHECK (health > 0) NOT VALID,
    CONSTRAINT racecheckwalkrange CHECK (walkRange > 0) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.race
    OWNER to postgres;

INSERT INTO public.race (name, walkRange, health, bonusManaMin, bonusManaMax, bonusS, bonusD
bonusE, bonusA, doPoints) VALUES
('Human',       5, 100, 0, 500,     0, 0, 0, 0, 1),
('Astartes',    15, 1500, 0, 1000,  3, 3, 3, 3, 2),
('Ogryn',       7, 4000, -300, 0,   5, 5, 2, 0, 1),
('Eldar',       20, 700, 500, 4000, 0, -2, 5, 3, 2),
('Demon',       20, 10000, 4000, 8000, 5, 5, 5, 5, 2),
('Ork',         15, 2000, -100, 100000, 5, 1, 1, -2, 1),
('Tyranid',     7, 1000, 0, 100000, 3, 5, 0, 0, 2),
('Tau',         5, 150, 0, 10,      1, 1, 1, 1, 1)
;
-- Оружие

CREATE TABLE IF NOT EXISTS public.weapon
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name text COLLATE pg_catalog."default" NOT NULL,
    type integer NOT NULL,
    minDamage integer,
    maxDamage integer NOT NULL,
    primaryAttack integer NOT NULL,
    scndA integer,
    thrdA integer,
    fotyA integer,
    fivtyA integer,
    ammoType integer NOT NULL,
    bonusA integer,
    bonusE integer,
    manaRegen integer,
    CONSTRAINT weapon_pkey PRIMARY KEY (id),
    CONSTRAINT weaponuname UNIQUE (name),
    CONSTRAINT weapon_to_aa1 FOREIGN KEY (primaryAttack)
        REFERENCES public.attackAbility (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT weapon_to_aa2 FOREIGN KEY (scndA)
        REFERENCES public.attackAbility (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT weapon_to_aa3 FOREIGN KEY (thrdA)
        REFERENCES public.attackAbility (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT weapon_to_aa4 FOREIGN KEY (fotyA)
        REFERENCES public.attackAbility (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT weapon_to_aa5 FOREIGN KEY (fivtyA)
        REFERENCES public.attackAbility (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT weapon_to_ammotype FOREIGN KEY (ammoType)
        REFERENCES public.ammotype (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT weapon_to_typeofw FOREIGN KEY (type)
        REFERENCES public.typeofw (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT weaponcheckbonusA CHECK (bonusA <= 15) NOT VALID,
    CONSTRAINT weaponcheckbonusE CHECK (bonusE <= 5) NOT VALID,
    CONSTRAINT weaponcheckmanaRegen CHECK (manaRegen >= 0) NOT VALID,
    CONSTRAINT weaponcheckmindamage CHECK (type <> 3 OR minDamage IS NULL) NOT VALID,
    CONSTRAINT weapondamagecheck CHECK (maxDamage > minDamage) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.weapon
    OWNER to postgres;

INSERT INTO public.weapon 
(name,          type, minDamage, maxDamage, primaryAttack,      scndA, thrdA, ammoType, manaRegen) VALUES
('Lasgun "Kantriel"',   2, 1,   30,     5,  3, 8,       7, null),
('Damned Lasgun',       2, 15,  150,    5,  8, 17,      7, 20),
('Boltgun',             2, 50,  400,    1,  2, 3,       15, null ),
('Carapted Boltgun',    2, 50,  550,    1,  2, 17,      28, 50),
('Plasma gun',          2, 500, 6500,   9,  null,       null, 20, null),


('Plasma pistol',       1, 500, 4000,   9,  null, null, 20, null),
('Stub pistol',         1, 1,   50,     1,  2, 3,       9, null),
('Training Las-pistol', 1, 1,   15,     1,  2, 3,       5, null),


('Chain sword',         3, null,200,    7,  null, null, 16, null),
('Monoatomic knife',    3, null,80,     19, null, null, 14, null),
('Chotic knife',        3, null,110,    19, 17, null,   25, 50),


('Frag grenade',        4, 300, 800,    10, null, null, 14, null),
('Krak grenade',        4, 400, 900,    11, null, null, 21, null),
('Melta bomb',          4, 1500, 2000,  12, null, null, 21, null),
('Cristal',             4, 1,5          18, null, null, 28, null)
;

-- Типы данных

CREATE TYPE public.appliedEffect AS
(
	effect integer,
	durability integer
);

ALTER TYPE public.appliedEffect
    OWNER TO postgres;

-- Функции

CREATE OR REPLACE FUNCTION public.heroview(
	heroid integer)
    RETURNS TABLE(property text, value text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
declare
	w1 integer;
	w2 integer;
	w3 integer;
	w4 integer;
begin
	w1 = (select "primaryWeapon" from hero where id = heroid);
	w2 = (select "secondWeapon" from hero where id = heroid);
	w3 = (select "meleeWeapon" from hero where id = heroid);
	w4 = (select "throwWeapon" from hero where id = heroid);
	
	return query (select 'hero name' as property, name as value
	from hero where id = heroid
	union
	select 'primary weapon', name from weapon where id = w1
	union
	select 'second weapon', name from weapon where id = w2
	union
	select 'melee weapon', name from weapon where id = w3
	union
	select 'throw weapon', name from weapon where id = w4
	);
end
$BODY$;

ALTER FUNCTION public.heroview(integer)
    OWNER TO postgres;


CREATE OR REPLACE FUNCTION public.ispsyker(
	heroid integer)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	return exists (select * from psykers where id = heroid);
end
$BODY$;

ALTER FUNCTION public.ispsyker(integer)
    OWNER TO postgres;

-- Процедуры

CREATE OR REPLACE PROCEDURE public.applyeffect(
	IN heroid integer,
	IN effect appliedEffect)
LANGUAGE 'plpgsql'
AS $BODY$
begin
	update hero
	set effects = array_append(effects, effect)
	where id = heroid;
end
$BODY$;
ALTER PROCEDURE public.applyeffect(integer, appliedEffect)
    OWNER TO postgres;

--
CREATE OR REPLACE PROCEDURE public.applyeffect(
	IN heroid integer,
	IN effect integer)
LANGUAGE 'plpgsql'
AS $BODY$
declare
	dur int;
begin
	select effduration into dur from effects where effects.id = effect;
	call applyeffect(heroid, (effect, dur)::public.appliedEffect);
end
$BODY$;
ALTER PROCEDURE public.applyeffect(integer, integer)
    OWNER TO postgres;

--
CREATE OR REPLACE PROCEDURE public.tickeffects(
	IN heroid integer)
LANGUAGE 'plpgsql'
AS $BODY$
declare
	i public.appliedEffect;
	buf public.appliedEffect[];
begin
	foreach i in array(select effects from hero where id = heroid)
	loop
		if i.durability - 1 > 0
			then
				i.durability = i.durability - 1;
				buf = array_append(buf, i);
		end if;
	end loop;
	update hero set effects = buf where id = heroid;
end
$BODY$;
ALTER PROCEDURE public.tickeffects(integer)
    OWNER TO postgres;

-- Представления 

CREATE OR REPLACE VIEW public.classstat
 AS
 SELECT class.name,
        CASE
            WHEN max(hero.id) IS NULL THEN 0::bigint
            ELSE count(*)
        END AS count,
        CASE
            WHEN max(hero.id) IS NULL THEN 0::double precision
            ELSE count(*)::double precision / count(*) OVER ()::double precision
        END AS countperc
   FROM hero
     RIGHT JOIN class ON hero.class = class.id
  GROUP BY class.id
  ORDER BY (
        CASE
            WHEN max(hero.id) IS NULL THEN 0::double precision
            ELSE count(*)::double precision / count(*) OVER ()::double precision
        END);

ALTER TABLE public.classstat
    OWNER TO postgres;

--
CREATE OR REPLACE VIEW public.herostat
 AS
 SELECT 'avg strength'::text AS property,
    avg(hero.strength)::text AS value
   FROM hero
UNION
 SELECT 'avg durability'::text AS property,
    avg(hero.durability)::text AS value
   FROM hero
UNION
 SELECT 'avg evasion'::text AS property,
    avg(hero.evasion)::text AS value
   FROM hero
UNION
 SELECT 'avg artm'::text AS property,
    avg(hero.artm)::text AS value
   FROM hero
UNION
 SELECT 'avg artm'::text AS property,
    avg(hero.artm)::text AS value
   FROM hero
UNION
 SELECT 'favorite class'::text AS property,
    ( SELECT class.name
           FROM class
          WHERE class.id = mode() WITHIN GROUP (ORDER BY hero.class)) AS value
   FROM hero
UNION
 SELECT 'favorite race'::text AS property,
    ( SELECT race.name
           FROM race
          WHERE race.id = mode() WITHIN GROUP (ORDER BY hero.race)) AS value
   FROM hero;

ALTER TABLE public.herostat
    OWNER TO postgres;

CREATE OR REPLACE VIEW public.psykerscount
 AS
 SELECT race.name,
        CASE
            WHEN max(hero.id) IS NULL THEN 0::bigint
            ELSE count(*)
        END AS psykers
   FROM hero
     JOIN psykers ON psykers.id = hero.id
     RIGHT JOIN race ON hero.race = race.id
  GROUP BY race.id;

ALTER TABLE public.psykerscount
    OWNER TO postgres;

--
CREATE OR REPLACE VIEW public.racestat
 AS
 SELECT race.name,
        CASE
            WHEN max(hero.id) IS NULL THEN 0::bigint
            ELSE count(*)
        END AS count,
        CASE
            WHEN max(hero.id) IS NULL THEN 0::double precision
            ELSE count(*)::double precision / count(*) OVER ()::double precision
        END AS countperc
   FROM hero
     RIGHT JOIN race ON hero.race = race.id
  GROUP BY race.id;

ALTER TABLE public.racestat
    OWNER TO postgres;

--
CREATE OR REPLACE VIEW public.squads
 AS
 WITH RECURSIVE r AS (
         SELECT hero.id,
            hero.name || '*'::text AS name,
            hero.lead,
            0 AS level,
            hero.id || ''::text AS path
           FROM hero
          WHERE hero.lead IS NULL
        UNION
         SELECT hero.id,
            hero.name,
            hero.lead,
            r_1.level + 1 AS level,
            (r_1.path || '|'::text) || hero.id AS path
           FROM r r_1
             JOIN hero ON r_1.id = hero.lead
        )
 SELECT (repeat('-'::text, level * 3) ||
        CASE
            WHEN level > 0 THEN '>'::text
            ELSE ''::text
        END) || id AS id,
    name
   FROM r
  ORDER BY path;

ALTER TABLE public.squads
    OWNER TO postgres;

