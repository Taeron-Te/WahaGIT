--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0 (Debian 16.0-1.pgdg120+1)
-- Dumped by pg_dump version 16.0 (Debian 16.0-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: appliedEffect; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."appliedEffect" AS (
	effect integer,
	durability integer
);


--
-- Name: addspell(integer); Type: PROCEDURE; Schema: public; Owner: -
--

CREATE PROCEDURE public.addspell(IN i integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE spellBook
	SET idMAbility = idMAbility || i;
END
$$;


--
-- Name: applyeffect(integer, integer); Type: PROCEDURE; Schema: public; Owner: -
--

CREATE PROCEDURE public.applyeffect(IN id integer, IN durability integer)
    LANGUAGE plpgsql
    AS $$
begin
	update hero
	set effects = effects || (id, durability);
end
$$;


--
-- Name: armourracetrigger(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.armourracetrigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	if (select race from armour where id = NEW."armourSet") != NEW.race
		then 
			raise exception 'armour race isn''t compatible with hero race';
	end if;
	return NEW;
end
$$;


--
-- Name: checkeffectsid(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.checkeffectsid() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
	i integer;
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


--
-- Name: checkspellid(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.checkspellid() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


--
-- Name: checkweapons(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.checkweapons() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	if NEW."primaryWeapon" is not null then
		if (select type from weapon where id = NEW."primaryWeapon") != 1
			then raise exception 'primary weapon has uncompatible type';
		end if;
		
		if (select "manaRegen">0 from weapon where id = NEW."primaryWeapon") and not ispsyker(NEW."id")
			then raise exception 'primary weapon is only available to psykers';
		end if;
	end if;
	
	if NEW."secondWeapon" is not null then
		if (select type from weapon where id = NEW."secondWeapon") != 2
			then raise exception 'second weapon has uncompatible type';
		end if;
		
		if (select "manaRegen">0 from weapon where id = NEW."secondWeapon") and not ispsyker(NEW."id")
			then raise exception 'second weapon is only available to psykers';
		end if;
	end if;
	
	if NEW."meleeWeapon" is not null then
		if (select type from weapon where id = NEW."meleeWeapon") != 3
			then raise exception 'melee weapon has uncompatible type';
		end if;
		
		if (select "manaRegen">0 from weapon where id = NEW."meleeWeapon") and not ispsyker(NEW."id")
			then raise exception 'melee weapon is only available to psykers';
		end if;
	end if;
	
	if NEW."throwWeapon" is not null then
		if (select type from weapon where id = NEW."throwWeapon") != 4
			then raise exception 'throw weapon has uncompatible type';
		end if;
		
		if (select "manaRegen">0 from weapon where id = NEW."throwWeapon") and not ispsyker(NEW."id")
			then raise exception 'throw weapon is only available to psykers';
		end if;
	end if;
	
	return new;
end
$$;


--
-- Name: ispsyker(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.ispsyker(id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
begin
	return exists (select * from psyker where id = id);
end
$$;


--
-- Name: mana(integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.mana(mentalstength integer, currank integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN 
	RETURN (mentalStength * (SELECT powerratio FROM public.ranks WHERE id = curRank))::int;
END
$$;


--
-- Name: ammotype; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ammotype (
    id integer NOT NULL,
    name text NOT NULL,
    value integer NOT NULL
);


--
-- Name: ammotype_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.ammotype ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ammotype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: armour; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.armour (
    id integer NOT NULL,
    name text NOT NULL,
    race integer NOT NULL,
    "apdLevel" integer NOT NULL,
    armour integer NOT NULL,
    "bonusS" integer,
    "bonusD" integer,
    "bonusE" integer,
    "bonusA" integer,
    "bonusDoPoints" integer,
    shield integer,
    "shReducePercent" double precision,
    "armourAbility" integer,
    "manaRegen" integer
);


--
-- Name: armourAbility; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."armourAbility" (
    id integer NOT NULL,
    name text NOT NULL,
    range double precision,
    "doPointsPrice" integer NOT NULL,
    type integer NOT NULL
);


--
-- Name: armourAbility_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."armourAbility" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."armourAbility_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: armour_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.armour ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.armour_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: armourlevel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.armourlevel (
    id integer NOT NULL,
    name text NOT NULL,
    value integer NOT NULL
);


--
-- Name: armourlevel_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.armourlevel ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.armourlevel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: attackAbility; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."attackAbility" (
    id integer NOT NULL,
    name text NOT NULL,
    sector double precision,
    "minDist" integer NOT NULL,
    "maxDist" integer NOT NULL,
    "damageArea" integer,
    "rechargeTime" double precision NOT NULL,
    "responseDelay" double precision,
    "doPointsPrice" integer NOT NULL,
    "defDamage" integer NOT NULL
);


--
-- Name: attackAbility_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."attackAbility" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."attackAbility_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: class; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.class (
    id integer NOT NULL,
    name text NOT NULL,
    "walkRange" integer DEFAULT 1 NOT NULL,
    "bonusHealth" integer NOT NULL,
    "uniqueMove" integer NOT NULL,
    "classMeleeAttackAbility" integer,
    "bonusSkillPoint" integer NOT NULL,
    "doPoints" integer NOT NULL
);


--
-- Name: class_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.class ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: classstat; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.classstat AS
SELECT
    NULL::text AS name,
    NULL::bigint AS count,
    NULL::double precision AS countperc;


--
-- Name: effects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.effects (
    id integer NOT NULL,
    name text NOT NULL,
    effduration integer,
    pimatyeffect text NOT NULL,
    type integer NOT NULL
);


--
-- Name: effects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.effects ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.effects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: hero; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hero (
    id integer NOT NULL,
    name text NOT NULL,
    family text,
    nickname text,
    age integer,
    race integer NOT NULL,
    class integer NOT NULL,
    "healthCur" integer DEFAULT 0 NOT NULL,
    "armourCur" integer DEFAULT 0 NOT NULL,
    "shieldCur" integer DEFAULT 0 NOT NULL,
    strength integer DEFAULT 1 NOT NULL,
    durability integer DEFAULT 1 NOT NULL,
    evasion integer DEFAULT 1 NOT NULL,
    artm integer DEFAULT 1 NOT NULL,
    "armourSet" integer,
    "primaryWeapon" integer,
    "secondWeapon" integer,
    "meleeWeapon" integer,
    "throwWeapon" integer,
    lead integer,
    effects public."appliedEffect"[] NOT NULL
);


--
-- Name: hero_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.hero ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.hero_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: race; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.race (
    id integer NOT NULL,
    name text NOT NULL,
    "walkRange" integer DEFAULT 1 NOT NULL,
    health integer NOT NULL,
    "bonusManaMin" integer,
    "bonusManaMax" integer,
    "bonusS" integer,
    "bonusD" integer,
    "bonusE" integer,
    "bonusA" integer,
    "doPoints" integer NOT NULL
);


--
-- Name: herostat; Type: VIEW; Schema: public; Owner: -
--

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


--
-- Name: magicability; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.magicability (
    id integer NOT NULL,
    name text NOT NULL,
    skillpointprice integer NOT NULL,
    magicschool integer NOT NULL,
    castprice integer NOT NULL,
    insecond integer,
    damage integer NOT NULL,
    sector integer NOT NULL
);


--
-- Name: magicability_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.magicability ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.magicability_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: magicschools; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.magicschools (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- Name: magicschools_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.magicschools ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.magicschools_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: moveAbility; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."moveAbility" (
    id integer NOT NULL,
    name text NOT NULL,
    "rangeIndex" double precision,
    "doPointPrice" integer NOT NULL,
    type integer NOT NULL
);


--
-- Name: moveAbility_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."moveAbility" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."moveAbility_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: psykers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.psykers (
    id integer NOT NULL,
    mana integer DEFAULT 0 NOT NULL,
    manaregen integer DEFAULT 0 NOT NULL,
    skillpoint integer DEFAULT 0 NOT NULL,
    soulpoint integer DEFAULT 0 NOT NULL,
    mindpoint integer DEFAULT 0 NOT NULL,
    soulshard integer DEFAULT 0 NOT NULL,
    godpowerpoint integer DEFAULT 0 NOT NULL,
    currank integer DEFAULT 7 NOT NULL,
    mentalstength integer DEFAULT 1 NOT NULL,
    mysticism integer DEFAULT 1 NOT NULL,
    minddurability integer DEFAULT 1 NOT NULL,
    magicskill integer DEFAULT 1 NOT NULL,
    sourcepower integer GENERATED ALWAYS AS (((mentalstength + mysticism) / 2)) STORED NOT NULL,
    magicrank integer GENERATED ALWAYS AS (((minddurability + magicskill) / 2)) STORED NOT NULL,
    spellbook integer,
    CONSTRAINT psykers_magicskill_check CHECK ((magicskill > 10)),
    CONSTRAINT psykers_mentalstength_check CHECK ((mentalstength > 10)),
    CONSTRAINT psykers_minddurability_check CHECK ((minddurability > 10)),
    CONSTRAINT psykers_mysticism_check CHECK ((mysticism > 10))
);


--
-- Name: race_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.race ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.race_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: racestat; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.racestat AS
SELECT
    NULL::text AS name,
    NULL::bigint AS count,
    NULL::double precision AS countperc;


--
-- Name: ranks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ranks (
    id integer NOT NULL,
    name text NOT NULL,
    powerratio double precision NOT NULL
);


--
-- Name: ranks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.ranks ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ranks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: spellbook; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spellbook (
    id integer NOT NULL,
    idmability integer[]
);


--
-- Name: spellbook_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.spellbook ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.spellbook_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: squads; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.squads AS
 WITH RECURSIVE r AS (
         SELECT hero.id,
            (hero.name || '*'::text) AS name,
            hero.lead,
            0 AS level,
            (hero.id || ''::text) AS path
           FROM public.hero
          WHERE (hero.lead IS NULL)
        UNION
         SELECT hero.id,
            hero.name,
            hero.lead,
            (r_1.level + 1) AS level,
            ((r_1.path || '|'::text) || hero.id) AS path
           FROM (r r_1
             JOIN public.hero ON ((r_1.id = hero.lead)))
        )
 SELECT ((repeat('-'::text, (level * 3)) ||
        CASE
            WHEN (level > 0) THEN '>'::text
            ELSE ''::text
        END) || id) AS id,
    name
   FROM r
  ORDER BY path;


--
-- Name: typeofaa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.typeofaa (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- Name: typeofaa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.typeofaa ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.typeofaa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: typeofeffect; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.typeofeffect (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- Name: typeofeffect_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.typeofeffect ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.typeofeffect_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: typeofma; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.typeofma (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- Name: typeofma_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.typeofma ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.typeofma_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: typeofw; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.typeofw (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- Name: typeofw_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.typeofw ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.typeofw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: weapon; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.weapon (
    id integer NOT NULL,
    name text NOT NULL,
    type integer NOT NULL,
    "minDamage" integer,
    "maxDamage" integer NOT NULL,
    "primaryAttack" integer NOT NULL,
    "scndA" integer,
    "thrdA" integer,
    "fotyA" integer,
    "fivtyA" integer,
    "ammoType" integer NOT NULL,
    "bonusA" integer,
    "bonusE" integer,
    "manaRegen" integer
);


--
-- Name: weapon_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.weapon ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.weapon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: attackAbility aacheckdamageArea; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public."attackAbility"
    ADD CONSTRAINT "aacheckdamageArea" CHECK (("damageArea" >= 0)) NOT VALID;


--
-- Name: attackAbility aacheckdefDamage; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public."attackAbility"
    ADD CONSTRAINT "aacheckdefDamage" CHECK (("defDamage" > 0)) NOT VALID;


--
-- Name: attackAbility aacheckdoPointPrice; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public."attackAbility"
    ADD CONSTRAINT "aacheckdoPointPrice" CHECK (("doPointsPrice" > 0)) NOT VALID;


--
-- Name: attackAbility aacheckminDis; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public."attackAbility"
    ADD CONSTRAINT "aacheckminDis" CHECK (("minDist" < "maxDist")) NOT VALID;


--
-- Name: attackAbility aacheckrechargeTime; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public."attackAbility"
    ADD CONSTRAINT "aacheckrechargeTime" CHECK (("rechargeTime" > (0)::double precision)) NOT VALID;


--
-- Name: attackAbility aacheckresponseDelay; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public."attackAbility"
    ADD CONSTRAINT "aacheckresponseDelay" CHECK (("responseDelay" > (0)::double precision)) NOT VALID;


--
-- Name: attackAbility aauname; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."attackAbility"
    ADD CONSTRAINT aauname UNIQUE (name);


--
-- Name: ammotype ammotype_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ammotype
    ADD CONSTRAINT ammotype_id_key UNIQUE (id);


--
-- Name: armourAbility arauname; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."armourAbility"
    ADD CONSTRAINT arauname UNIQUE (name);


--
-- Name: armourAbility armacheckdoPointPrice; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public."armourAbility"
    ADD CONSTRAINT "armacheckdoPointPrice" CHECK (("doPointsPrice" > 0)) NOT VALID;


--
-- Name: armourAbility armacheckrange; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public."armourAbility"
    ADD CONSTRAINT armacheckrange CHECK ((range > (0)::double precision)) NOT VALID;


--
-- Name: armourAbility armourAbility_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."armourAbility"
    ADD CONSTRAINT "armourAbility_pkey" PRIMARY KEY (id);


--
-- Name: armour armour_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.armour
    ADD CONSTRAINT armour_pkey PRIMARY KEY (id);


--
-- Name: armour armourcheckbonusA; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.armour
    ADD CONSTRAINT "armourcheckbonusA" CHECK (("bonusA" <= 5)) NOT VALID;


--
-- Name: armour armourcheckbonusD; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.armour
    ADD CONSTRAINT "armourcheckbonusD" CHECK (("bonusD" <= 15)) NOT VALID;


--
-- Name: armour armourcheckbonusE; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.armour
    ADD CONSTRAINT "armourcheckbonusE" CHECK (("bonusE" <= 5)) NOT VALID;


--
-- Name: armour armourcheckbonusS; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.armour
    ADD CONSTRAINT "armourcheckbonusS" CHECK (("bonusS" <= 5)) NOT VALID;


--
-- Name: armour armourcheckmanaRegen; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.armour
    ADD CONSTRAINT "armourcheckmanaRegen" CHECK (("manaRegen" >= 0)) NOT VALID;


--
-- Name: armour armourcheckshReducePercent; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.armour
    ADD CONSTRAINT "armourcheckshReducePercent" CHECK (("shReducePercent" <= (100)::double precision)) NOT VALID;


--
-- Name: armourlevel armourlevel_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.armourlevel
    ADD CONSTRAINT armourlevel_id_key UNIQUE (id);


--
-- Name: armour armouruname; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.armour
    ADD CONSTRAINT armouruname UNIQUE (name);


--
-- Name: attackAbility attackAbility_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."attackAbility"
    ADD CONSTRAINT "attackAbility_pkey" PRIMARY KEY (id);


--
-- Name: class class_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT class_pkey PRIMARY KEY (id);


--
-- Name: class classcheckbonusSkillPoint; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.class
    ADD CONSTRAINT "classcheckbonusSkillPoint" CHECK (("bonusSkillPoint" <= 60)) NOT VALID;


--
-- Name: class classcheckbonushealth; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.class
    ADD CONSTRAINT classcheckbonushealth CHECK (("bonusHealth" >= 0)) NOT VALID;


--
-- Name: class classuname; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT classuname UNIQUE (name);


--
-- Name: effects effects_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.effects
    ADD CONSTRAINT effects_id_key UNIQUE (id);


--
-- Name: hero hero_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hero
    ADD CONSTRAINT hero_pkey PRIMARY KEY (id);


--
-- Name: hero herocheck artm; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.hero
    ADD CONSTRAINT "herocheck artm" CHECK (((artm >= 1) AND (artm <= 20))) NOT VALID;


--
-- Name: hero herocheckdurability; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.hero
    ADD CONSTRAINT herocheckdurability CHECK (((durability >= 1) AND (durability <= 20))) NOT VALID;


--
-- Name: hero herocheckevasion; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.hero
    ADD CONSTRAINT herocheckevasion CHECK (((evasion >= 1) AND (evasion <= 20))) NOT VALID;


--
-- Name: hero herocheckstrength; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.hero
    ADD CONSTRAINT herocheckstrength CHECK (((strength >= 1) AND (strength <= 100))) NOT VALID;


--
-- Name: hero herouname; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hero
    ADD CONSTRAINT herouname UNIQUE (name);


--
-- Name: moveAbility macheckdoPointPrice; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public."moveAbility"
    ADD CONSTRAINT "macheckdoPointPrice" CHECK (("doPointPrice" > 0)) NOT VALID;


--
-- Name: moveAbility macheckrangeindex; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public."moveAbility"
    ADD CONSTRAINT macheckrangeindex CHECK (("rangeIndex" > (0)::double precision)) NOT VALID;


--
-- Name: magicability magicability_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.magicability
    ADD CONSTRAINT magicability_id_key UNIQUE (id);


--
-- Name: magicschools magicschools_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.magicschools
    ADD CONSTRAINT magicschools_id_key UNIQUE (id);


--
-- Name: moveAbility moveAbility_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."moveAbility"
    ADD CONSTRAINT "moveAbility_pkey" PRIMARY KEY (id);


--
-- Name: moveAbility moveabilityunamew; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."moveAbility"
    ADD CONSTRAINT moveabilityunamew UNIQUE (name);


--
-- Name: psykers psykers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.psykers
    ADD CONSTRAINT psykers_pkey PRIMARY KEY (id);


--
-- Name: race race_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.race
    ADD CONSTRAINT race_pkey PRIMARY KEY (id);


--
-- Name: race racecheckbonusA; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.race
    ADD CONSTRAINT "racecheckbonusA" CHECK (("bonusA" <= 5)) NOT VALID;


--
-- Name: race racecheckbonusD; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.race
    ADD CONSTRAINT "racecheckbonusD" CHECK (("bonusD" <= 5)) NOT VALID;


--
-- Name: race racecheckbonusE; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.race
    ADD CONSTRAINT "racecheckbonusE" CHECK (("bonusE" <= 5)) NOT VALID;


--
-- Name: race racecheckbonusS; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.race
    ADD CONSTRAINT "racecheckbonusS" CHECK (("bonusS" <= 5)) NOT VALID;


--
-- Name: race racecheckbonusmanaMin; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.race
    ADD CONSTRAINT "racecheckbonusmanaMin" CHECK (("bonusManaMin" < "bonusManaMax")) NOT VALID;


--
-- Name: race racecheckdopoint; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.race
    ADD CONSTRAINT racecheckdopoint CHECK (("doPoints" <= 2)) NOT VALID;


--
-- Name: race racecheckhealth; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.race
    ADD CONSTRAINT racecheckhealth CHECK ((health > 0)) NOT VALID;


--
-- Name: race racecheckwalkrange; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.race
    ADD CONSTRAINT racecheckwalkrange CHECK (("walkRange" > 0)) NOT VALID;


--
-- Name: race raceuname; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.race
    ADD CONSTRAINT raceuname UNIQUE (name);


--
-- Name: ranks ranks_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ranks
    ADD CONSTRAINT ranks_id_key UNIQUE (id);


--
-- Name: spellbook spellbook_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spellbook
    ADD CONSTRAINT spellbook_id_key UNIQUE (id);


--
-- Name: typeofaa typeofaa_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typeofaa
    ADD CONSTRAINT typeofaa_id_key UNIQUE (id);


--
-- Name: typeofeffect typeofeffect_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typeofeffect
    ADD CONSTRAINT typeofeffect_id_key UNIQUE (id);


--
-- Name: typeofma typeofma_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typeofma
    ADD CONSTRAINT typeofma_id_key UNIQUE (id);


--
-- Name: typeofw typeofw_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typeofw
    ADD CONSTRAINT typeofw_id_key UNIQUE (id);


--
-- Name: weapon weapon_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weapon
    ADD CONSTRAINT weapon_pkey PRIMARY KEY (id);


--
-- Name: weapon weaponcheckbonusA; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.weapon
    ADD CONSTRAINT "weaponcheckbonusA" CHECK (("bonusA" <= 15)) NOT VALID;


--
-- Name: weapon weaponcheckbonusE; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.weapon
    ADD CONSTRAINT "weaponcheckbonusE" CHECK (("bonusE" <= 5)) NOT VALID;


--
-- Name: weapon weaponcheckmanaRegen; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.weapon
    ADD CONSTRAINT "weaponcheckmanaRegen" CHECK (("manaRegen" >= 0)) NOT VALID;


--
-- Name: weapon weaponcheckmindamage; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.weapon
    ADD CONSTRAINT weaponcheckmindamage CHECK (((type <> 3) OR ("minDamage" IS NULL))) NOT VALID;


--
-- Name: weapon weapondamagecheck; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.weapon
    ADD CONSTRAINT weapondamagecheck CHECK (("maxDamage" > "minDamage")) NOT VALID;


--
-- Name: weapon weaponuname; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weapon
    ADD CONSTRAINT weaponuname UNIQUE (name);


--
-- Name: classstat _RETURN; Type: RULE; Schema: public; Owner: -
--

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


--
-- Name: racestat _RETURN; Type: RULE; Schema: public; Owner: -
--

CREATE OR REPLACE VIEW public.racestat AS
 SELECT race.name,
        CASE
            WHEN (max(hero.id) IS NULL) THEN (0)::bigint
            ELSE count(*)
        END AS count,
        CASE
            WHEN (max(hero.id) IS NULL) THEN (0)::double precision
            ELSE ((count(*))::double precision / (count(*) OVER ())::double precision)
        END AS countperc
   FROM (public.hero
     RIGHT JOIN public.race ON ((hero.race = race.id)))
  GROUP BY race.id;


--
-- Name: hero checkarmourrace; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER checkarmourrace BEFORE INSERT OR UPDATE ON public.hero FOR EACH ROW EXECUTE FUNCTION public.armourracetrigger();


--
-- Name: hero effectchecker; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER effectchecker BEFORE INSERT OR UPDATE ON public.hero FOR EACH ROW EXECUTE FUNCTION public.checkeffectsid();


--
-- Name: hero heroweapons; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER heroweapons BEFORE INSERT OR UPDATE ON public.hero FOR EACH ROW EXECUTE FUNCTION public.checkweapons();


--
-- Name: spellbook spellbookchecker; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER spellbookchecker BEFORE INSERT OR UPDATE ON public.spellbook FOR EACH ROW EXECUTE FUNCTION public.checkspellid();


--
-- Name: armourAbility aa_to_typeofaa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."armourAbility"
    ADD CONSTRAINT aa_to_typeofaa FOREIGN KEY (type) REFERENCES public.typeofaa(id) NOT VALID;


--
-- Name: armour armour_to_aa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.armour
    ADD CONSTRAINT armour_to_aa FOREIGN KEY ("armourAbility") REFERENCES public."armourAbility"(id);


--
-- Name: armour armour_to_armourlevel; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.armour
    ADD CONSTRAINT armour_to_armourlevel FOREIGN KEY ("apdLevel") REFERENCES public.armourlevel(id) NOT VALID;


--
-- Name: armour armour_to_race; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.armour
    ADD CONSTRAINT armour_to_race FOREIGN KEY (race) REFERENCES public.race(id);


--
-- Name: class class_to_aa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT class_to_aa FOREIGN KEY ("classMeleeAttackAbility") REFERENCES public."attackAbility"(id);


--
-- Name: class class_to_ma; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT class_to_ma FOREIGN KEY ("uniqueMove") REFERENCES public."moveAbility"(id);


--
-- Name: effects effects_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.effects
    ADD CONSTRAINT effects_type_fkey FOREIGN KEY (type) REFERENCES public.typeofeffect(id);


--
-- Name: hero hero_to_armor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hero
    ADD CONSTRAINT hero_to_armor FOREIGN KEY ("armourSet") REFERENCES public.armour(id) NOT VALID;


--
-- Name: hero hero_to_class; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hero
    ADD CONSTRAINT hero_to_class FOREIGN KEY (class) REFERENCES public.class(id);


--
-- Name: hero hero_to_hero; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hero
    ADD CONSTRAINT hero_to_hero FOREIGN KEY (lead) REFERENCES public.hero(id) NOT VALID;


--
-- Name: hero hero_to_race; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hero
    ADD CONSTRAINT hero_to_race FOREIGN KEY (race) REFERENCES public.race(id);


--
-- Name: hero hero_to_weapon1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hero
    ADD CONSTRAINT hero_to_weapon1 FOREIGN KEY ("primaryWeapon") REFERENCES public.weapon(id);


--
-- Name: hero hero_to_weapon2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hero
    ADD CONSTRAINT hero_to_weapon2 FOREIGN KEY ("secondWeapon") REFERENCES public.weapon(id);


--
-- Name: hero hero_to_weapon3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hero
    ADD CONSTRAINT hero_to_weapon3 FOREIGN KEY ("meleeWeapon") REFERENCES public.weapon(id);


--
-- Name: hero hero_to_weapon4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hero
    ADD CONSTRAINT hero_to_weapon4 FOREIGN KEY ("throwWeapon") REFERENCES public.weapon(id);


--
-- Name: moveAbility ma_to_typeofma; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."moveAbility"
    ADD CONSTRAINT ma_to_typeofma FOREIGN KEY (type) REFERENCES public."moveAbility"(id) NOT VALID;


--
-- Name: magicability magicability_magicschool_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.magicability
    ADD CONSTRAINT magicability_magicschool_fkey FOREIGN KEY (magicschool) REFERENCES public.magicschools(id);


--
-- Name: psykers psykers_currank_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.psykers
    ADD CONSTRAINT psykers_currank_fkey FOREIGN KEY (currank) REFERENCES public.ranks(id);


--
-- Name: psykers psykers_spellbook_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.psykers
    ADD CONSTRAINT psykers_spellbook_fkey FOREIGN KEY (spellbook) REFERENCES public.spellbook(id);


--
-- Name: weapon weapon_to_aa1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weapon
    ADD CONSTRAINT weapon_to_aa1 FOREIGN KEY ("primaryAttack") REFERENCES public."attackAbility"(id);


--
-- Name: weapon weapon_to_aa2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weapon
    ADD CONSTRAINT weapon_to_aa2 FOREIGN KEY ("scndA") REFERENCES public."attackAbility"(id);


--
-- Name: weapon weapon_to_aa3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weapon
    ADD CONSTRAINT weapon_to_aa3 FOREIGN KEY ("thrdA") REFERENCES public."attackAbility"(id);


--
-- Name: weapon weapon_to_aa4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weapon
    ADD CONSTRAINT weapon_to_aa4 FOREIGN KEY ("fotyA") REFERENCES public."attackAbility"(id);


--
-- Name: weapon weapon_to_aa5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weapon
    ADD CONSTRAINT weapon_to_aa5 FOREIGN KEY ("fivtyA") REFERENCES public."attackAbility"(id);


--
-- Name: weapon weapon_to_ammotype; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weapon
    ADD CONSTRAINT weapon_to_ammotype FOREIGN KEY ("ammoType") REFERENCES public.ammotype(id) NOT VALID;


--
-- Name: weapon weapon_to_typeofw; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weapon
    ADD CONSTRAINT weapon_to_typeofw FOREIGN KEY (type) REFERENCES public.typeofw(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

