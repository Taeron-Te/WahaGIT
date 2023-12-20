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
    "responseDelay" double precision NOT NULL,
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
    "walkRange" integer NOT NULL,
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
    "healthCur" integer NOT NULL,
    "armourCur" integer NOT NULL,
    "shieldCur" integer NOT NULL,
    strength integer NOT NULL,
    durability integer NOT NULL,
    evasion integer NOT NULL,
    artm integer NOT NULL,
    "armourSet" integer NOT NULL,
    "primaryWeapon" integer NOT NULL,
    "secondWeapon" integer NOT NULL,
    "meleeWeapon" integer NOT NULL,
    "throwWeapon" integer NOT NULL,
    effects integer[] NOT NULL
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
-- Name: race; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.race (
    id integer NOT NULL,
    name text NOT NULL,
    "walkRange" integer NOT NULL,
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
-- Name: armour armour_to_aa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.armour
    ADD CONSTRAINT armour_to_aa FOREIGN KEY ("armourAbility") REFERENCES public."armourAbility"(id);


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
-- PostgreSQL database dump complete
--

