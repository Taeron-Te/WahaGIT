--SERGEY
CREATE TABLE public.typeOfMA(
	id int GENERATED ALWAYS AS IDENTITY UNIQUE,
	name text NOT NULL
);

INSERT INTO public.typeOfMA(name) VALUES
('Walk'),
('Run'),
('Jump'),
('Fly'),
('Jump with jump pack'),
('Phase shift'),
('Warp shift'),
('Teleport'),
('Darkness shift');

select * from typeOfMA;
--SERGEY
CREATE TABLE public.typeOfW(
	id int GENERATED ALWAYS AS IDENTITY UNIQUE,
	name text NOT NULL
);

INSERT INTO public.typeOfW(name) VALUES
('One Hand Range'),
('Two Hand Range'),
('Melee'),
('Throwable');


select * from typeOfW;
--SERGEY
CREATE TABLE public.typeOfAA(
	id int GENERATED ALWAYS AS IDENTITY UNIQUE,
	name text NOT NULL
);

INSERT INTO public.typeOfAA(name) VALUES
('Shield'),
('Teleport'),
('Heal'),
('Repair Armour');


select * from typeOfAA;
--SERGEY
CREATE TABLE public.armourLevel(
	id int GENERATED ALWAYS AS IDENTITY UNIQUE,
	name text NOT NULL,
	value int NOT NULL
);

INSERT INTO public.armourLevel(name, value) VALUES
('Low Caliber Autogun', 10),
('Shotgun Buckshot', 12),
('Shotgun Slug', 15),
('Blade', 15),
('Lasgun low-power', 15),

('High-Power Autogun', 20),
('Lasgun normal-power', 25),
('Lasgun high-power', 30),
('Low-power stubber', 30),
('High-power stubber', 35),

('Hot-shot Lasgun', 40),
('Double Hellgun shot', 50),
('Shotgun Armor-piercing', 50),
('Monoatomic blade', 60),
('Boltgun', 80),

('Chain sword', 100),
('Sniper boltgun', 100),
('Heavy bolter', 100),
('Autocanon', 120),
('Plasma', 140),

('Melta', 190),
('Gauss', 200),
('Tesla-ray', 220),
('Lascanon', 250),
('Power field', 400),

('Phase blade', 900),
('Gravity', 1000),
('Hell Energy', 1000)
;


select * from armourLevel;
--SERGEY
CREATE TABLE public.ammoType(
	id int GENERATED ALWAYS AS IDENTITY UNIQUE,
	name text NOT NULL,
	value int NOT NULL
);

INSERT INTO public.ammoType(name, value) VALUES
('Low Caliber Autogun', 10),
('Shotgun Buckshot', 12),
('Shotgun Slug', 15),
('Blade', 15),
('Lasgun low-power', 15),
('High-Power Autogun', 20),
('Lasgun normal-power', 25),
('Lasgun high-power', 30),
('Low-power stubber', 30),
('High-power stubber', 35),
('Hot-shot Lasgun', 40),
('Double Hellgun shot', 50),
('Shotgun Armor-piercing', 50),
('Monoatomic blade', 60),
('Boltgun', 80),
('Chain sword', 100),
('Sniper boltgun', 100),
('Heavy bolter', 100),
('Autocanon', 120),
('Plasma', 140),
('Melta', 190),
('Gauss', 200),
('Tesla-ray', 220),
('Lascanon', 250),
('Power field', 400),
('Phase blade', 900),
('Gravity', 1000),
('Hell Energy', 1000)
;


select * from ammoType;
--SERGEY
CREATE TABLE public.typeOfEffect(
	id int GENERATED ALWAYS AS IDENTITY UNIQUE,
	name text NOT NULL
	
);

INSERT INTO public.typeOfEffect(name) VALUES
('Buff'),
('Debuff'),
('Contorversial effect')
;


select * from typeOfEffect;
--SERGEY
CREATE TABLE public.effects(
	id int GENERATED ALWAYS AS IDENTITY UNIQUE,
	name text NOT NULL,
	effDuration int,
	pimatyEffect text NOT NULL,
	type int NOT NULL,
	FOREIGN KEY (type) REFERENCES public.typeOfEffect(id)
);

INSERT INTO public.effects(name, effDuration, pimatyEffect, type) VALUES
('Emperor`s will', 2400, 'Increases all characteristics by 5', 1),
('The Emperor`s Curse', 6000, 'Decreases all characteristics by 10', 2),
('The Blessing of Chaos ', 2400 , 'Increases all characteristics by 20', 1),
('Bleed', 60 , 'You loosing 1% health per 5 seconds', 2),
('Gaussian entropy', 30, 'You loosing 5% health per 1 second', 2),
('Encouragement', 120, 'Durability and strength characteristics increases by 1', 1),
('Fury of Khorne', 120, 'Your damage increases for 50% but you loosing 1% health per 5 seconds', 3),
('Power of Warp', 5 , 'You sign the body out of warp, making it super strong. Increases strength by 2', 1),
('Changing the skin', 10 , 'You can change the structure of the skin by thickening it or completely changing its communication lattice. Increases durability by 5', 1),
('Regeneration', 1 , 'You use the power of the warp to cause wounds to heal and missing flesh to re-grow from an imprint in the warp. You gain 0.5% healing per 1 second', 1),
('Burning', 10,'You take 250 damage per 1 second',2)
;

select * from effects;

--SERGEY

CREATE TABLE public.ranks(
	id int GENERATED ALWAYS AS IDENTITY UNIQUE,
	name text NOT NULL,
	powerRatio float NOT NULL
);

INSERT INTO public.ranks(name, powerRatio) VALUES
('Alpha', 50),
('Beta', 10),
('Gamma', 4),
('Delta', 2),
('Epsilon', 1.2),
('Zeta', 1),
('Etta', 0.7)
;

SELECT * FROM ranks;
--SERGEY
CREATE TABLE public.magicSchools(
	id int GENERATED ALWAYS AS IDENTITY UNIQUE,
	name text NOT NULL
);

INSERT INTO public.magicSchools(name) VALUES
('Pyromancy'),
('Telekinetics'),
('Biomancy'),
('Telepathy'),
('Geokinesis'),
('Cryokinesis'),
('Fulmination'),
('Human divination'),
('Demonology Sanctum'),
('Demonology Maleficent'),
('Theosophy'),
('Thaumaturgy'),
('Technomancy'),
('Feats of Faith')
;

select * from magicSchools;
--SERGEY
CREATE TABLE public.magicAbility(
	id int GENERATED ALWAYS AS IDENTITY UNIQUE,
	name text NOT NULL,
	skillPointPrice int NOT NULL,
	magicSchool int NOT NULL,
	castPrice int NOT NULL,
	inSecond int,
    damage int NOT NULL,
	sector int NOT NULL,
	FOREIGN KEY (magicSchool) REFERENCES public.magicschools(id)
);

INSERT INTO public.magicAbility(name, skillPointPrice,  magicSchool, castPrice, inSecond, damage, sector) VALUES
('Clap', 0, 1, 15, NULL, 40, 2),
('Fire ball', 1, 1, 40, NULL, 120, 1),
('Fire flow', 2, 1, 15, 1, 45, 0),
('Fire wall', 3, 1, 150, 5, 45, 2),
('Kinetic impact', 1, 2, 40, NULL, 200, 0),

('Moving', 2, 2, 5, 1, 0, 0),
('Kinetic hammer', 2, 2, 40, 1, 250, 0),
('Kinetic hammer pulse', 2, 2, 100, NULL, 500, 0),
('Kinetic shield', 2, 2, 90, 5, 0, 0),
('Blood stop', 0, 3, 2, 1, 0, 0),

('Basic regeneration', 1, 3, 5, 1, 0, 0),
('Regeneration', 2, 3, 15, 1, 0, 0),
('Speed regeneration', 3, 3, 450, NULL, 0, 0),
('Psi manipulation', 0, 4, 50, NULL, 0, 0),
('Dreamwalking', 1, 4, 40, NULL, 0, 0),

('Telepathy', 1, 4, 15, NULL, 0, 0),
('Mind hacking', 3, 4, 140, 3, 0, 0),
('Earth shakes', 1, 5, 290, NULL, 50, 20),
('Underground punch', 2, 5, 80, NULL, 200, 0),
('Destroy', 3, 5, 340, 4, 0, 5),

('Earh brige', 2, 5, 100, NULL, 0, 0)
;

select * from magicAbility;

CREATE FUNCTION mana (mentalStength int, curRank int) returns int
AS $$
BEGIN 
	RETURN (mentalStength * (SELECT powerratio FROM public.ranks WHERE id = curRank))::int;
END
$$ LANGUAGE 'plpgsql';	
--SERGEY
CREATE TABLE spellBook (
	id int GENERATED ALWAYS AS IDENTITY UNIQUE,
	idMAbility int[]
);

CREATE OR REPLACE FUNCTION public.checkSpellId()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
declare
  i integer;
begin
  if NEW.idMAbility is not null then
  foreach i in array NEW.idMAbility
  loop
    if not exists (select id from public.magicability where id = i)
      then raise exception 'spell doesn''t exist';
    end if;
  end loop;
  end if;
  return NEW;
end
$BODY$;

ALTER FUNCTION public.checkSpellId()
    OWNER TO postgres;
	
CREATE OR REPLACE TRIGGER spellBookChecker
    BEFORE INSERT OR UPDATE 
    ON public.spellBook
    FOR EACH ROW
    EXECUTE FUNCTION public.checkSpellId();
	
INSERT INTO spellBook (idMAbility) VALUES (ARRAY[1,2 ,3, 4, 5, 6, 9, 10, 11]);
INSERT INTO spellBook (idMAbility) VALUES (ARRAY[3, 4, 5, 6, 9, 10, 11, 12, 14, 15]);
INSERT INTO spellBook (idMAbility) VALUES (ARRAY[1,2 ,3, 4, 5, 6, 9, 10, 11, 14, 16, 18, 20, 21]);

CREATE PROCEDURE addSpell(i int) as $$
BEGIN
	UPDATE spellBook
	SET idMAbility = idMAbility || i;
END
$$ LANGUAGE 'plpgsql';

SELECT * FROM public.spellBook;
--SERGEY
CREATE TABLE public.psykers(
	id int primary key,
	mana int NOT NULL DEFAULT 0,
	manaRegen int NOT NULL DEFAULT 0,
	skillPoint int NOT NULL DEFAULT 0,
	soulPoint int NOT NULL DEFAULT 0,
	mindPoint int NOT NULL DEFAULT 0,
	soulShard int NOT NULL DEFAULT 0,
	godPowerPoint int NOT NULL DEFAULT 0,
	curRank int NOT NULL DEFAULT 7,
	mentalStength int NOT NULL CHECK (mentalStength <= 10) DEFAULT 1,
	mysticism int NOT NULL CHECK (mysticism <= 10) DEFAULT 1,
	mindDurability int NOT NULL CHECK (mindDurability <= 10) DEFAULT 1,
	magicSkill int NOT NULL CHECK (magicSkill <= 10) DEFAULT 1,
	sourcePower int NOT NULL GENERATED ALWAYS AS ((mentalStength + mysticism)/2::int) STORED,
	magicRank int NOT NULL GENERATED ALWAYS AS ((mindDurability + magicSkill)/2::int) STORED,
	spellBook int,
	
	FOREIGN KEY (curRank) REFERENCES public.ranks(id),
	FOREIGN KEY (spellBook) REFERENCES public.spellbook(id)
);


INSERT INTO public.psykers(id, mana, curRank, mentalStength, mysticism, mindDurability, magicSkill, spellBook) VALUES
	(6, 1400, 4, 3, 3, 2, 2, 1)
;
INSERT INTO public.psykers(id, mana, skillPoint, soulPoint, mindPoint, soulShard, curRank, godPowerPoint, mentalStength, mysticism, mindDurability, magicSkill, spellBook) VALUES
						  (11, 3400, 4, 		 3, 		3, 		   12, 		  2, 		0, 				7, 				9, 			6, 				6, 			2)
;
INSERT INTO public.psykers(id, mana, skillPoint, soulPoint, mindPoint, soulShard, curRank, godPowerPoint, mentalStength, mysticism, mindDurability, magicSkill, spellBook) VALUES
						  (12, 15400, 12, 		 14, 		15, 		   23, 		  1, 		49, 		9, 				10, 			8, 			10, 		3)
;

	


select * from psykers;

--VLAD
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

select * from public.attackAbility;
--VLAD
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

SELECT * FROM public.armourAbility;
--VLAD
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
		
SELECT * FROM moveAbility;
--VLAD
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
('Monoatomic knife',    3, null,80,     18, null, null, 14, null),
('Chotic knife',        3, null,110,    18, 17, null,   25, 50),


('Frag grenade',        4, 300, 800,    10, null, null, 14, null),
('Krak grenade',        4, 400, 900,    11, null, null, 21, null),
('Melta bomb',          4, 1500, 2000,  12, null, null, 21, null),
('Cristal',             4, 1,5,         17, null, null, 28, null)
;
SELECT * FROM weapon, public.attackAbility
WHERE public.attackAbility.id = weapon.primaryAttack;
--VLAD
CREATE TYPE public.appliedEffect AS
(
	effect integer,
	durability integer
);

ALTER TYPE public.appliedEffect
    OWNER TO postgres;
--VLAD
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

INSERT INTO public.race (name, walkRange, health, bonusManaMin, bonusManaMax, bonusS, bonusD,
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
SELECT * FROM race;

--VLAD
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
SELECT * FROM public.class;

--VLAD

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
				('Mk.7 "Aquila"', 2, 	14, 	1500, 		1, 			0,			6),
('Mk.8 "Errant"', 2, 14, 1700, 1, 0, 7),
('Mk.7 with Repair elemnt', 2, 15, 1400, 1,0, 8),
('Eldar Soul Bone', 4, 10, 900, 2, 3, 5),
('Mk.4 "Maximus"', 2, 14, 1700, 2,0, 6)
;

SELECT * FROM armour;
--VLAD

--VLAD
CREATE FUNCTION public.armourracetrigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	if (select race from armour where id = NEW.armourSet) != NEW.race
		then 
			raise exception 'armour race isn''t compatible with hero race';
	end if;
	return NEW;
end
$$;

CREATE FUNCTION public.checkeffectsid() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
	i public.appliedEffect;
begin
	if NEW.effects is not null then
	foreach i in array NEW.effects
	loop
		if not exists (select id from effects where id = i.effect)
			then raise exception 'effect doesn''t exist';
		end if;
	end loop;
	end if;
	return NEW;
end
$$;

CREATE FUNCTION public.checkweapons() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	if NEW.primaryWeapon is not null then
		if (select type from weapon where id = NEW.primaryWeapon) != 1
			then raise exception 'primary weapon has uncompatible type';
		end if;
		
		if (select manaRegen>0 from weapon where id = NEW.primaryWeapon) and not ispsyker(NEW."id")
			then raise exception 'primary weapon is only available to psykers';
		end if;
	end if;
	
	if NEW.secondWeapon is not null then
		if (select type from weapon where id = NEW.secondWeapon) != 2
			then raise exception 'second weapon has uncompatible type';
		end if;
		
		if (select manaRegen>0 from weapon where id = NEW.secondWeapon) and not ispsyker(NEW."id")
			then raise exception 'second weapon is only available to psykers';
		end if;
	end if;
	
	if NEW.meleeWeapon is not null then
		if (select type from weapon where id = NEW.meleeWeapon) != 3
			then raise exception 'melee weapon has uncompatible type';
		end if;
		
		if (select manaRegen>0 from weapon where id = NEW."meleeWeapon") and not ispsyker(NEW."id")
			then raise exception 'melee weapon is only available to psykers';
		end if;
	end if;
	
	if NEW.throwWeapon is not null then
		if (select type from weapon where id = NEW.throwWeapon) != 4
			then raise exception 'throw weapon has uncompatible type';
		end if;
		
		if (select manaRegen>0 from weapon where id = NEW.throwWeapon) and not ispsyker(NEW."id")
			then raise exception 'throw weapon is only available to psykers';
		end if;
	end if;
	
	return new;
end
$$;


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

INSERT INTO public.hero(name, 		family,  age, race, class, healthCur, armourCur, effects)
VALUES					('Arnold', 'Delam',  33, 	1, 	2,		 100, 	0,			 ARRAY[]::appliedeffect[]);

INSERT INTO public.hero(name, family,  age, race, class, healthCur, armourCur, lead, effects)
VALUES  ('Deny', 'Aaron',       18, 1, 2, 100, 0, 1, ARRAY[]::appliedeffect[]),
        ('Edgard', 'Swanson',   21, 1, 2, 100, 0, 1, ARRAY[]::appliedeffect[]),
        ('Nikola', 'Kachinski', 26, 1, 2, 100, 0, 1, ARRAY[]::appliedeffect[]),
        ('Harry', 'Bishop',     23, 1, 2, 100, 0, 1, ARRAY[]::appliedeffect[]),
        ('Garry', 'Bishop',     23, 1, 9, 100, 0, 1, ARRAY[]::appliedeffect[])
        
;

INSERT INTO public.hero(name,  age, race, class, healthCur, armourCur, lead, effects)
VALUES  ('Bratigen',        154, 2, 3, 1500, 0, null, ARRAY[]::appliedeffect[]),
        ('Gally',           95, 2, 3, 1500, 0, 7, ARRAY[]::appliedeffect[]),
        ('Alex',            63, 2, 4, 1500, 0, 7, ARRAY[]::appliedeffect[]),
        ('Vicor',           83, 2, 5, 1500, 0, 7, ARRAY[]::appliedeffect[]),
        ('Desteriel',       143, 2, 9, 1500, 0, 7, ARRAY[]::appliedeffect[])
        
;
INSERT INTO public.hero
(name,          family,    age, race,   class,  healthCur,  armourCur,  lead, effects) VALUES
('Immlerih',    'Codel',   24,  1,      9,      100,        0,          1,      ARRAY[]::appliedeffect[]);
SELECT * FROM hero, public.class
WHERE hero.class = public.class.id;

CREATE FUNCTION public.heroview(heroid integer) RETURNS TABLE(property text, value text)
    LANGUAGE plpgsql
    AS $$
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
$$;

--SERGEY
CREATE OR REPLACE FUNCTION public.ispsyker(
	heroid integer)
    RETURNS boolean
    LANGUAGE 'plpgsql'
AS $BODY$
begin
	return exists (select * from psykers where id = heroid);
end
$BODY$;

--SERGEY
CREATE INDEX IF NOT EXISTS effects_type_idx
    ON public.effects USING hash
    (type)
    TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS magicability_magicschool_idx
    ON public.magicability USING hash
    (magicschool)
    TABLESPACE pg_default;
--VLAD
CREATE INDEX IF NOT EXISTS armour_race_idx
ON public.armour USING hash
(race)
TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS weapon_type_idx
    ON public.weapon USING hash
    (type)
    TABLESPACE pg_default;

--SERGEY
CREATE VIEW lookingGoodPsyker AS 
SELECT hero.name as "Имя псайкера", race as Раса, mana AS "Запас Маны", skillpoint as "Очки навыка",
soulpoint as "Очки развития души", mindpoint as "Очки развития разума", godpowerpoint as "Божественные частицы",
ranks.name as "Текущий ранг", mentalstength as "Ментальная сила", mysticism as Мистицизм,
minddurability as "Ментальное сопротивление",
magicskill as Владение, sourcepower as "Источник сил", magicrank as "Ранг магии" FROM psykers, hero, ranks
WHERE hero.id = psykers.id and psykers.curRank = ranks.id;
--SERGEY
create view topPsykers as  (with top  as (select race.name as racename, max(mentalstength) from psykers
join hero on psykers.id = hero.id
join race on hero.race = race.id
group by grouping sets ((), (race.name))
)
select racename, hero.name from hero, top, psykers
where hero.id=psykers.id and mentalstength = max);
--SERGEY
create view toppsykersforrank as WITH top AS (
         SELECT ranks.name AS rankname,
            max(psykers.mentalstength) AS max
           FROM psykers
             JOIN hero ON psykers.id = hero.id
             JOIN ranks ON psykers.curRank = ranks.id
          GROUP BY GROUPING SETS ((), (ranks.name))
        )
 SELECT top.rankname,
    hero.name
   FROM hero,
    top,
    psykers
  WHERE hero.id = psykers.id AND psykers.mentalstength = top.max;

--VLAD
CREATE VIEW public.classstat AS
SELECT
    NULL::text AS name,
    NULL::bigint AS count,
    NULL::double precision AS countperc;

CREATE OR REPLACE VIEW public.classstat AS
 SELECT class.name,
        CASE
            WHEN (max(hero.id) IS NULL) THEN (0)::bigint
            ELSE count(*)
        END AS count,
        CASE
            WHEN (max(hero.id) IS NULL) THEN (0)::double precision
            ELSE ((count(*))::double precision / (count(*) OVER ())::double precision)
        END AS countperc
   FROM (public.hero
     RIGHT JOIN public.class ON ((hero.class = class.id)))
  GROUP BY class.id
  ORDER BY
        CASE
            WHEN (max(hero.id) IS NULL) THEN (0)::double precision
            ELSE ((count(*))::double precision / (count(*) OVER ())::double precision)
        END;
-- VLAD	
CREATE VIEW public.herostat AS
 SELECT 'avg strength'::text AS property,
    (avg(hero.strength))::text AS value
   FROM public.hero
UNION
 SELECT 'avg durability'::text AS property,
    (avg(hero.durability))::text AS value
   FROM public.hero
UNION
 SELECT 'avg evasion'::text AS property,
    (avg(hero.evasion))::text AS value
   FROM public.hero
UNION
 SELECT 'avg artm'::text AS property,
    (avg(hero.artm))::text AS value
   FROM public.hero
UNION
 SELECT 'avg artm'::text AS property,
    (avg(hero.artm))::text AS value
   FROM public.hero
UNION
 SELECT 'favorite class'::text AS property,
    ( SELECT class.name
           FROM public.class
          WHERE (class.id = mode() WITHIN GROUP (ORDER BY hero.class))) AS value
   FROM public.hero
UNION
 SELECT 'favorite race'::text AS property,
    ( SELECT race.name
           FROM public.race
          WHERE (race.id = mode() WITHIN GROUP (ORDER BY hero.race))) AS value
   FROM public.hero;
--VLAD
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
--VLAD
CREATE OR REPLACE VIEW public.racestat
 AS
 SELECT DISTINCT race.name,
    class.name AS classname,
        CASE
            WHEN max(hero.id) IS NULL THEN 0::bigint
            WHEN GROUPING(race.name) = 1 THEN count(hero.id) OVER ()
            WHEN GROUPING(class.name) = 1 THEN count(hero.id) OVER (PARTITION BY race.name)
            ELSE count(hero.id) OVER (PARTITION BY race.name, class.name)
        END AS herocount,
        CASE
            WHEN max(hero.id) IS NULL OR GROUPING(class.name) = 1 THEN ''::text
            ELSE ((
            CASE
                WHEN max(hero.id) IS NULL THEN 0::bigint
                WHEN GROUPING(race.name) = 1 THEN count(hero.id) OVER ()
                WHEN GROUPING(class.name) = 1 THEN count(hero.id) OVER (PARTITION BY race.name)
                ELSE count(hero.id) OVER (PARTITION BY race.name, class.name)
            END::double precision * 100::double precision / count(hero.id) OVER (PARTITION BY race.name)::double precision)::text) || '%'::text
        END AS classperc
   FROM hero
     RIGHT JOIN race ON hero.race = race.id
     LEFT JOIN class ON class.id = hero.class
  GROUP BY ROLLUP(race.name, class.name, hero.id)
  ORDER BY race.name;

ALTER TABLE public.racestat
    OWNER TO postgres;


--SERGEY (VLAD?)
CREATE OR REPLACE VIEW public.psykerscount AS
 SELECT race.name,
        CASE
            WHEN (max(hero.id) IS NULL) THEN (0)::bigint
            ELSE count(*)
        END AS psykers
   FROM ((public.hero
     JOIN public.psykers ON ((psykers.id = hero.id)))
     RIGHT JOIN public.race ON ((hero.race = race.id)))
  GROUP BY race.id;

--VLAD
  
CREATE PROCEDURE public.applyeffect(IN heroid integer, IN effect integer)
    LANGUAGE plpgsql
    AS $$
declare
	dur int;
begin
	select effduration into dur from effects where effects.id = effect;
	call applyeffect(heroid, (effect, dur)::public."appliedEffect");
end
$$;
--VLAD

CREATE PROCEDURE public.applyeffect(IN heroid integer, IN effect public.appliedEffect)
    LANGUAGE plpgsql
    AS $$
begin
	update hero
	set effects = array_append(effects, effect)
	where id = heroid;
end
$$;
--VLAD
CREATE PROCEDURE public.tickeffects(IN heroid integer)
    LANGUAGE plpgsql
    AS $$
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
$$;
--VLAd
CREATE OR REPLACE FUNCTION public.heroesiterator(
	name refcursor)
    RETURNS refcursor
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	open name for select * from hero;
	return name;
end
$BODY$;

ALTER FUNCTION public.heroesiterator(refcursor)
    OWNER TO postgres;

--VLAD

create or replace procedure printdamage(heroid int) as
$$
declare
	wpns cursor(hid int) for 
		select name, primaryAttack, scndA, thrdA, fotyA, fivtyA from weapon
		where id in ((select primaryWeapon from hero where id = hid),
					 (select secondWeapon from hero where id = hid),
					 (select meleeWeapon from hero where id = hid),
					 (select throwWeapon from hero where id = hid));
	
	abils refcursor;
	
	abl record;
	
	sum int;
begin

	sum = 0;

	for w in wpns(heroid)
	loop
		raise notice '%', w.name;
		
		open abils for select name, defDamage from attackability
			where id in (w.primaryAttack, w.scndA, w.thrdA, w.fotyA, w.fivtyA);
		
		loop
		
		fetch abils into abl;
		
		exit when not found;
		
		raise notice '--->% %', abl.name, abl.defdamage;
		
		sum = sum + abl.defdamage;
		
		end loop;
		
		close abils;
	end loop;
	
	raise notice '%', sum;
end
$$ language 'plpgsql';

-- VLAD
CREATE OR REPLACE PROCEDURE public.healsquad(
	IN leader integer, IN hp integer)
LANGUAGE 'plpgsql'
AS $BODY$
declare
	heroes refcursor;
	
	curhero record;
	
	squad int[];
begin
	heroes = heroesiterator('newcursor');
	
	squad = squad || leader;
	
	loop
	fetch heroes into curhero;
	
	exit when not found;
	
	if curhero.lead = any(squad) 
	then 
		raise notice '%', curhero.name;
		squad = squad || curhero.id;
		update hero set healthCur = healthCur + hp where current of heroes;
	end if;
	
	end loop;
	
	close heroes;

end
$BODY$;
ALTER PROCEDURE public.healsquad(integer, integer)
    OWNER TO postgres;

