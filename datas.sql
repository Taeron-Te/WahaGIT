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

INSERT INTO public.typeOfW(name) VALUES
('One Hand Range'),
('Two Hand Range'),
('Melee'),
('Throwable');

INSERT INTO public.typeOfAA(name) VALUES
('Shield'),
('Teleport'),
('Heal'),
('Repair Armour');


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

INSERT INTO public.typeOfEffect(name) VALUES
('Buff'),
('Debuff'),
('Contorversial effect')
;

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
