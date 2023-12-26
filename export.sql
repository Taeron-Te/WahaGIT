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

/* Independent part */

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

CREATE PROCEDURE addSpell(i int) as $$
BEGIN
	UPDATE spellBook
	SET idMAbility = idMAbility || i;
END
$$ LANGUAGE 'plpgsql';

SELECT * FROM public.spellBook;

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
	mentalStength int NOT NULL CHECK (mentalStength > 10) DEFAULT 1,
	mysticism int NOT NULL CHECK (mysticism > 10) DEFAULT 1,
	mindDurability int NOT NULL CHECK (mindDurability > 10) DEFAULT 1,
	magicSkill int NOT NULL CHECK (magicSkill > 10) DEFAULT 1,
	sourcePower int NOT NULL GENERATED ALWAYS AS ((mentalStength + mysticism)/2::int) STORED,
	magicRank int NOT NULL GENERATED ALWAYS AS ((mindDurability + magicSkill)/2::int) STORED,
	spellBook int,
	
	FOREIGN KEY (curRank) REFERENCES public.ranks(id),
	FOREIGN KEY (spellBook) REFERENCES public.spellbook(id)
);

INSERT INTO public.psykers(name, soulPoint, mindPoint, curRank, mentalStength, mysticism, mindDurability, magicSkill, spellBook) VALUES

;


select * from psykers;