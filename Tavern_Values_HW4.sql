---USE tavern_db;
--GO

INSERT INTO tavern_info (tavern_id, tavern_name, tavern_location, tavern_floors) VALUES
(26426194, 'Whimpering Wyvern', 'Olmsfeld', 3),
(26499878, 'Festering Forest', 'Bromwood', 3),
(26486821, 'Bungling Bonemare', 'Poutsmough', 3),
(26463458, 'Restless Halfling', 'Outer Shire Overpass', 2),
(26491992, 'Furtive Pygmy', 'New Londo', 3),
(26477255, 'Grey Wizard', 'Isengard', 3),
(26425352, 'Creepy Bard', 'Whiterun',1),
(26425217, 'Resplendent Runestone', 'Moonglow', 2),
(26426267, 'White Lotus', 'Ember Island', 4);

INSERT INTO role_desc VALUES
('Owner','Owns and maintains physical structure and surrounding property; manages day-to-day operations, sales, services, inventory, and personnel.'),
('Bard',  'Entertains guests with tales of great adventures. Provides soothing and encouraging music to ease weary travelers.'),
('Groundskeeper', 'Sweeps, mops, and cleans up all manner of mess.'),
('Bartender', 'Serves up food and drink to paying customers.'),
('Stylist', 'Because you could use a makeover!');

INSERT INTO tavern_humanoids (humanoid_name, humanoid_title, humanoid_birthday, humanoid_cakeday, humanoid_race, humanoid_class, humanoid_notes) VALUES
('Gurok','The Feckless', '1213-12-06', '1000-06-03','Orc', 'Necromancer','Don''t talk to him about the Battle of Bagtosh. He lost family in that fight.'),
('Flizzbang','Dragon Mechanic','1221-08-11', '1000-08-04', 'Gnome', 'Engineer','Likes spicy food.'),
('Kelthelas','The Vengeful','1209-09-12', '1000-04-11', 'Blood Elf','Rogue','Not the sharpest tool in the shed.'),
('Ghouldag','The Humorless', '1060-09-01', '1000-02-22','Undead', 'Fighter','Two-time arm-wrestling champion of the Underworld.'),
('Samwise','Pleasantly Plump','1218-10-10','1000-07-17','Hobbit','Chef','Is sensitive about his weight.'),
('Gwydolin','The Dark Sun','', '1000-01-01','Demigod', 'Sorcerer','Leader of the secretive Darkmoon clan.'),
('Freya','The Courageous','1204-04-08', '1000-10-26', 'Burmecian','Dragon Knight','Loyal, extremely perseverent. Excellent battlefield companion'),
('Jethro','Aqualung', '1217-05-09','1000-12-03', 'Human','Adventurer','No sense of humor.'), 
('Maeiv', 'The Warden', '1226-03-06','1000-07-13', 'Night Elf', 'Ranger','Don''t ask to see her belongings unless you want to get a poison dagger stuck into your leg.'),
('Pippin', 'Seeker of the Tasty', '1228-02-06','1000-12-19', 'Hobbit', 'Entertainer','Get''s out of hand after a few too many drinks. He is on probation at Samwise''s tavern.'), 
('Eserelda', 'Defender of the Stars', '1216-01-06','1000-11-26', 'Dwarf', 'Paladin',''), 
('Dwerkas', 'Shaman of the Blue', '1220-07-13','1000-08-10', 'Reptilian', 'Shaman','Needs to be reminded to keep the noise down.') ,
('Isidane','Lady of Communication', '1221-01-08','1000-10-16', 'Elf', 'White Mage','Refuses to use healing spells to help tavern employees with chronic back pain'),
('Gazlowe','The Singluarity', '1208-10-01','1000-09-13', 'Cyborg', 'Fighter','Hallucinates that the trees are following him.'),
('Jelpil', 'Guardian of Ash','1203-04-26','1000-01-19', 'Imp','Warlock','');

--if time -- add more humanoids -- more employees, more guests

INSERT INTO employee_id(humanoid_id) VALUES (100001), (100002), (100003),(100004),(100005),(100006),(100007),(100008),(100009);


INSERT INTO tavern_employment(employee_id, tavern_id,employee_role,role_start_date, role_end_date, admin_status) VALUES
(900001,26426267, 'Owner','1234-10-24', NULL,'YES'),
(900002,26425217, 'Owner','1232-02-11', NULL,'YES'),
(900003,26426194, 'Owner','1239-03-18', NULL,'YES'),
(900004,26486821, 'Owner','1239-10-24', NULL,'YES'),
(900005,26463458, 'Owner','1234-08-07', NULL,'YES'),
(900006,26491992, 'Owner','1232-10-07', NULL,'YES'),
(900007,26425352, 'Owner','1241-12-13', NULL,'YES'),
(900008,26491992, 'Bard' ,'1240-05-15', NULL,'NO'),
(900009,26499878, 'Owner','1239-02-01', NULL,'YES');


 INSERT INTO tavern_supplies (item_name, item_unit, item_cost) VALUES
 ('Summoning Scroll', 'scroll', 24.85),    --33001  
 ('Spellbook', 'book', 92.50),             --33002
 ('Hogsmeade', 'bottle', 3.25),            --33003                  
 ('Elixir', 'vial', 58.65),                --33004
 ('Tankard', 'each', 1.20),                --33005
 ('Torch', 'bundle of 3', 7.10),           --33006
 ('Leather Armlet', 'pair', 39.90),        --33007
 ('Crossbow Bolts', 'each', 0.28),         --33008
 ('Rations', 'package', 4.05),             --33009
 ('Wine', 'cask', 48.20),                  --33010
 ('Cider', 'barrel', 36.95),               --33011
 ('First Aid Kit', 'kit', 6.40),           --33012
 ('Brawl Resistant Table','each', 41.60),  --33013
 ('Beard Shampoo', 'bottle', 2.75),        --33014
 ('Wood Polish', 'bottle', 5.30),          --33015
 ('Mop', 'each', 8.00),                    --33016
 ('Lyre', 'each', 345.95),                 --33017
 ('Bag of Holding','each', 27.00);                --33018

 INSERT INTO tavern_inventory (item_sku, tavern_id, item_qty, item_sale_price, last_delivery) VALUES
 (33002, 26463458, 25, 200.00,'1244-03-08 14:21:15'), --YYYY-MM-DD HH:MI:SS
 (33008, 26426267, 800, 1.50,'1244-01-21 11:17:33'),
 (33009, 26426194, 100, 20.00,'1243-10-18 16:50:25'),
 (33003, 26463458, 200, 7.50,'1244-02-24 9:05:49'),
 (33006, 26426267, 80, 15.00,'1243-11-29 13:02:15'),
 (33013, 26425352, 2, NULL, '1243-12-20 15:11:52');

 INSERT INTO delivery_received (tavern_id, item_sku,order_qty,order_total, delivery_time) VALUES

(26463458,33010,3, 124.80,'1244-02-11 11:40:21'),
(26477255,33002,5, 462.50,'1244-02-25 21:19:21'),
(26477255,33001,16, 397.60,'1244-01-06 14:02:44'),
(26425217,33017,1, 345.95, '1243-11-24 17:32:13'),
(26425217,33014,12, 33.00,'1244-01-29 10:36:16');

 INSERT INTO service_desc(service_title,service_desc) VALUES	
 ('Beard Wash', 'Feel Fresh and Clean with a full beard comb and wash'),
 ('Hair Styling', 'Change your hair style - includes hair and beard'),
 ('Hair Coloring', 'Choose from dozens of color dyes for your hair and beard'),
 ('Foot Rub', 'Relieve common adventurer foot aches'),
 ('Armor Shine','Intimidate your foes with the shine of newly polished armor - not available for leather, cloth, or chain-mail'),
 ('Dinner', 'Satiate your hunger with a four course dinner fit for a hero. Ask about our specials!');

INSERT INTO service_status VALUES
(1, 26426194, 'Active'),
(3, 26426267,'Active'),
(5, 26463458, 'Active'),
(6, 26425352,'Active'),
(4, 26477255,'Inactive');


INSERT INTO visitor_id (humanoid_id,tavern_id)Values
(100010, 26486821),
(100011, 26463458),
(100012, 26491992),
(100013, 26425352),
(100014, 26425217),
(100015, 26426267);


INSERT INTO class (class_name, class_desc) VALUES
('Sorcerer', 'Improves spellcasting. Can cast strong offensive spells.'),
('Healer', 'Improves poison resistance. Can use spells and spell scrolls to heal wounds.'),
('Thief', 'Improves Dagger expertise. Can use stealth and pickpocket skills. Improves critical attack rate.'),
('Ranger', 'Improves skill with ranged weapons. Improves Reflexes. Improves precision. Improves critical attack damage.'),
('Warrior','Improves skill with 1-handed and 2-handed melee weapons. Can activate ruthless battle techniques.'),
('Summoner', 'Uses incantations that harness the power of dark forces. Summons spirits and manipulates life force');
-- 1:Sorcerer 2:Healer 3:Thief 4:Ranger 5:Warrior 6:Summoner

----('Defender','Improves Armor and Constitution. Can use attack and defense techniques to turn the tide of battle.'),
--('Enchanter','Improves elemental resistsance. Can use ancient wisdom of elements to increase or reduce target''s power.')
--('Alchemist',),
--('Engineer', 'Improves' ),

INSERT INTO tavern_visitors(visitor_id, visitor_status, visitor_notes, visitor_in, visitor_out) VALUES
(600001, 'Drunk','Drunk and Raging.','1244-03-05 22:10:00','1244-03-06 18:14:00'),
(600002, 'Sickly', 'Kept the peace and broke up a bar fight.','1244-02-03 12:05:00','1244-02-04 11:51:00'),
(600003, 'Wounded', 'Left the place a mess. Blood dripping everywhere.','1244-02-22 09:10:00','1244-03-01 23:42:00'),
(600004, 'Cursed', 'Good Tipper.','1244-01-23 16:17:00','1244-01-24 13:35:00'),
(600005, 'Grumpy', 'Bad Attitude','1244-03-01 20:40:00','1244-03-06 19:37:00'),
(600006, 'Despondent', 'Was looking for someone familiar with the dark ','1244-02-14 15:21:00','1244-02-16 12:10:00');

-- 1:Sorcerer 2:Healer 3:Thief 4:Ranger 5:Warrior 6:Summoner
INSERT INTO classlvl (guest_id, class_id, lvl) VALUES
(600001, 3, 18),
(600002, 2, 35),
(600003, 1, 28),
(600004, 2, 55),
(600005, 5, 17),
(600006, 6, 50),
(600001, 6, 7),
(600002, 4, 12),
(600003, 5, 14),
(600004, 1, 21),
(600005, 3, 9),
(600006, 2, 6),
(600001, 5, 18),
(600003, 2, 3),
(600005, 4, 4);

select* from tavern_sales;

INSERT INTO tavern_sales (customer_id, service_id, service_price, service_qty, total_sale, sale_datetime, tavern_id) VALUES
( 600004,6, 12.00, 3, 36.00, '1244-03-05 13:22:54', 26425352),
( 600001,3, 14.00, 1, 14.00, '1244-03-03 18:21:23', 26426267),
( 600002,1, 11.00, 1, 11.00, '1244-03-05 11:26:35', 26426267),
( 600003,6, 12.00, 2, 24.00, '1244-03-05 22:14:28', 26477255),
( 600005,5, 28.00, 1, 28.00, '1244-03-02 16:00:31', 26463458),
( 600004,4, 32.00,1,32.00, '1244-03-06 12:14:35', 26425352),
( 600006,6, 12.00, 4, 48.00, '1244-03-05 22:14:28', 26477255);


INSERT INTO tavern_rooms (room_attr, room_status, room_rate, tavern_id) VALUES
('Single / QUEEN', 'AVIALABLE', 75, 26486821),
('Economy / TWIN','Occupied', 60 , 26463458),
('Exec Suite / KING','Available', 200, 26491992),
('Double / QUEEN','Occupied', 150 ,26425352),
('Lakeside Balcony / QUEEN','Avialable', 135, 26425217),
('Single / TWIN','Available', 85, 26426267);


INSERT INTO room_stays (room_id, guest_id, DATE_IN, DATE_OUT, days_stayed, sale_amt, time_of_sale) VALUES
(474001, 600001, '1244-03-05 22:10:00','1244-03-06 18:14:00', 1,75, '1244-03-06 18:22:00'),
(474002, 600002,'1244-02-03 12:05:00', '1244-02-04 11:51:00', 1, 60,'1244-02-04 12:12:00'),
(474003, 600003, '1244-02-22 09:10:00', '1244-03-01 23:42:00',8, 1600,'1244-03-01 23:50:00'),
(474004, 600004, '1244-01-23 16:17:00','1244-01-24 13:35:00', 1, 150,'1244-01-24 14:00:00'),
(474005, 600005, '1244-03-01 20:40:00', '1244-03-06 19:37:00',5, 675 ,'1244-03-06 19:45:00'),
(474006, 600006, '1244-02-14 15:21:00', '1244-02-16 12:10:00',2, 170,'1244-02-16 12:10:00');
