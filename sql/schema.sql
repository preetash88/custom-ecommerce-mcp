
CREATE DATABASE preetash_mcp_ecommerce_crud;
use preetash_mcp_ecommerce_crud;

CREATE TABLE IF NOT EXISTS products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  sku VARCHAR(64) NOT NULL UNIQUE,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  quantity INT NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Helpful indexes
CREATE INDEX IF NOT EXISTS idx_products_name ON products(name);

select * from products;
select * from products where id=5;

INSERT INTO products (sku, name, description, price, quantity, created_at, updated_at) VALUES
('IPHONE17PRO@202511111540', 'iPhone 17 Pro', 'Apple iPhone 17 Pro 256GB Titanium Edition', 1299.00, 120, '2025-11-11 15:40:20', '2025-11-11 15:40:20'),
('SAMSUNGGALAXYS25@202511111545', 'Samsung Galaxy S25 Ultra', 'Samsung Galaxy S25 Ultra with AI-powered zoom camera', 1199.00, 150, '2025-11-11 15:45:18', '2025-11-11 15:45:18'),
('METAQUEST4@202511111550', 'Meta Quest 4', 'Meta Quest 4 VR headset with retina display and hand tracking', 699.00, 80, '2025-11-11 15:50:09', '2025-11-11 15:50:09'),
('BMWIX9@202511111555', 'BMW iX9', 'BMW iX9 Electric SUV 2026 Model', 125000.00, 5, '2025-11-11 15:55:47', '2025-11-11 15:55:47'),
('CYBERTRUCK2@202511111600', 'Tesla Cybertruck Gen 2', 'Tesla Cybertruck second-generation dual-motor edition', 98000.00, 8, '2025-11-11 16:00:25', '2025-11-11 16:00:25'),
('APPLEWATCH10@202511111605', 'Apple Watch Series 10', 'Apple Watch Series 10 with glucose monitoring and microLED', 599.00, 250, '2025-11-11 16:05:42', '2025-11-11 16:05:42'),
('DELLXPS18@202511111610', 'Dell XPS 18', 'Dell XPS 18-inch laptop with OLED touchscreen and Intel Lunar Lake', 2499.00, 60, '2025-11-11 16:10:18', '2025-11-11 16:10:18'),
('NIKONZ9II@202511111615', 'Nikon Z9 II', 'Nikon Z9 Mark II mirrorless camera with 16K video and dual CFExpress slots', 7499.00, 15, '2025-11-11 16:15:27', '2025-11-11 16:15:27'),
('ASUSROGALLY2@202511111620', 'ASUS ROG Ally 2', 'ASUS ROG Ally 2 portable gaming console with Ryzen Z2 Extreme', 899.00, 90, '2025-11-11 16:20:41', '2025-11-11 16:20:41'),
('SONYA9IV@202511111625', 'Sony A9 IV', 'Sony A9 IV mirrorless camera with AI autofocus and global shutter', 5999.00, 25, '2025-11-11 16:25:55', '2025-11-11 16:25:55');


INSERT INTO products (sku, name, description, price, quantity, created_at, updated_at) VALUES
('RAZERBLADE18@202511111630','Razer Blade 18','Razer Blade 18 Gaming Laptop with RTX 5090 and 4K 240Hz display',3899.00,30,'2025-11-11 16:30:12','2025-11-11 16:30:12'),
('HPOMEN17@202511111635','HP Omen 17','HP Omen 17 Gaming Laptop with Intel i9-14900HX and RTX 4080',2699.00,45,'2025-11-11 16:35:08','2025-11-11 16:35:08'),
('LGGRAM17@202511111640','LG Gram 17','Ultra-light LG Gram 17 2025 Edition with Intel Lunar Lake',1999.00,70,'2025-11-11 16:40:21','2025-11-11 16:40:21'),
('MACSTUDIO@202511111645','Apple Mac Studio M5 Ultra','Apple Mac Studio 2025 with M5 Ultra chip and 128GB RAM',4999.00,20,'2025-11-11 16:45:54','2025-11-11 16:45:54'),
('SURFACEPRO10@202511111650','Microsoft Surface Pro 10','Microsoft Surface Pro 10 with Snapdragon Elite X Gen 3 processor',1699.00,80,'2025-11-11 16:50:37','2025-11-11 16:50:37'),
('PIXEL9PRO@202511111655','Google Pixel 9 Pro','Google Pixel 9 Pro AI edition with Tensor G5 chip',1099.00,150,'2025-11-11 16:55:42','2025-11-11 16:55:42'),
('DJIMAVIC5@202511111700','DJI Mavic 5 Pro','DJI Mavic 5 Pro drone with 8K video and obstacle sensing',2599.00,25,'2025-11-11 17:00:11','2025-11-11 17:00:11'),
('ROGPHONE9@202511111705','ASUS ROG Phone 9','ASUS ROG Phone 9 with Snapdragon 8 Gen 5 and 6000mAh battery',1299.00,100,'2025-11-11 17:05:23','2025-11-11 17:05:23'),
('STEAMDECK2@202511111710','Steam Deck 2','Valve Steam Deck 2 with AMD Ryzen Z2 processor',799.00,60,'2025-11-11 17:10:30','2025-11-11 17:10:30'),
('MSIXONIC15@202511111715','MSI Xonic 15','MSI Xonic 15 laptop with RTX 5070 and i9-14900HX',2299.00,40,'2025-11-11 17:15:10','2025-11-11 17:15:10'),
('DELLALIENX19@202511111720','Alienware X19','Alienware X19 gaming laptop with dual-fan liquid cooling system',3799.00,25,'2025-11-11 17:20:59','2025-11-11 17:20:59'),
('BOSEQCULTRA@202511111725','Bose QuietComfort Ultra 2025','Bose QC Ultra headphones with adaptive ANC and AI voice optimization',599.00,200,'2025-11-11 17:25:17','2025-11-11 17:25:17'),
('SONYWH2000XM6@202511111730','Sony WH-2000XM6','Sony WH-2000XM6 noise-canceling headphones',499.00,250,'2025-11-11 17:30:20','2025-11-11 17:30:20'),
('JABRAELITE15@202511111735','Jabra Elite 15','Jabra Elite 15 earbuds with spatial audio and long battery life',299.00,220,'2025-11-11 17:35:27','2025-11-11 17:35:27'),
('BOSEFRAMES3@202511111740','Bose Frames 3','Bose Frames 3 smart audio sunglasses with voice control',399.00,90,'2025-11-11 17:40:15','2025-11-11 17:40:15'),
('TESLAMODELY@202511111745','Tesla Model Y 2026','Tesla Model Y 2026 Long Range AWD',72000.00,12,'2025-11-11 17:45:52','2025-11-11 17:45:52'),
('AUDIEQ7@202511111750','Audi e-tron Q7','Audi e-tron Q7 2026 Electric SUV',115000.00,7,'2025-11-11 17:50:41','2025-11-11 17:50:41'),
('MERCEDESAMGEQS@202511111755','Mercedes AMG EQS','Mercedes AMG EQS Sedan 2026 Performance Edition',165000.00,5,'2025-11-11 17:55:34','2025-11-11 17:55:34'),
('NIKEAIRMAXNEXT@202511111800','Nike Air Max Next Gen','Nike Air Max Next Gen running shoes with adaptive cushioning',299.00,300,'2025-11-11 18:00:18','2025-11-11 18:00:18'),
('ADIDASULTRABOOST26@202511111805','Adidas Ultraboost 26','Adidas Ultraboost 26 with graphene sole and smartfit tracking',279.00,280,'2025-11-11 18:05:20','2025-11-11 18:05:20'),
('GARMINEDGE1050@202511111810','Garmin Edge 1050','Garmin Edge 1050 Cycling Computer with solar charging',649.00,75,'2025-11-11 18:10:35','2025-11-11 18:10:35'),
('FITBITCHARGE8@202511111815','Fitbit Charge 8','Fitbit Charge 8 with continuous glucose monitoring',299.00,250,'2025-11-11 18:15:50','2025-11-11 18:15:50'),
('DYSONHAARDRYERPRO@202511111820','Dyson Hair Dryer Pro','Dyson Supersonic Pro 2025 hair dryer with ionic control',599.00,180,'2025-11-11 18:20:27','2025-11-11 18:20:27'),
('PHILIPSAIIRON@202511111825','Philips AI Steam Iron','Philips AI Smart Iron with fabric detection',249.00,190,'2025-11-11 18:25:14','2025-11-11 18:25:14'),
('SONYBRAVIAQLED@202511111830','Sony Bravia QLED 85"','Sony Bravia QLED 85-inch Smart TV with HDR12+',6999.00,35,'2025-11-11 18:30:51','2025-11-11 18:30:51'),
('SAMSUNGOLED98@202511111835','Samsung OLED 98"','Samsung 98-inch OLED TV with built-in AI upscaler',8999.00,25,'2025-11-11 18:35:42','2025-11-11 18:35:42'),
('LGQNED95@202511111840','LG QNED 95','LG QNED 95 8K Smart TV 2025 Edition',8499.00,18,'2025-11-11 18:40:23','2025-11-11 18:40:23'),
('ROKUVOICEPRO@202511111845','Roku Voice Pro','Roku Voice Pro 4K streaming device with gesture control',199.00,400,'2025-11-11 18:45:56','2025-11-11 18:45:56'),
('AMAZONECHOGEN6@202511111850','Amazon Echo Gen 6','Amazon Echo 6th Gen with home automation hub',199.00,380,'2025-11-11 18:50:35','2025-11-11 18:50:35'),
('GOOGLEANESTHUB@202511111855','Google Nest Hub 4','Google Nest Hub 4 with integrated temperature and air quality sensors',229.00,360,'2025-11-11 18:55:44','2025-11-11 18:55:44'),
('TPLINKMESHAX12@202511111900','TP-Link Mesh AX12','TP-Link Wi-Fi 7 Mesh Router AX12000',499.00,240,'2025-11-11 19:00:19','2025-11-11 19:00:19'),
('NETGEARORBIXE@202511111905','Netgear Orbi XE12000','Netgear Orbi XE12000 Tri-band Wi-Fi 7 System',699.00,220,'2025-11-11 19:05:33','2025-11-11 19:05:33'),
('APPLEHOMEPOD3@202511111910','Apple HomePod 3','Apple HomePod 3rd Gen with ultra-wideband and Siri 2.0',449.00,280,'2025-11-11 19:10:58','2025-11-11 19:10:58'),
('AMDRYZEN9800X@202511111915','AMD Ryzen 9 9800X','AMD Ryzen 9 9800X 12-core desktop processor',699.00,100,'2025-11-11 19:15:44','2025-11-11 19:15:44'),
('INTELCOREULTRA9@202511111920','Intel Core Ultra 9','Intel Core Ultra 9 185H Lunar Lake Processor',749.00,90,'2025-11-11 19:20:31','2025-11-11 19:20:31'),
('NVIDIAGTX4090SUPER@202511111925','NVIDIA RTX 4090 Super','NVIDIA RTX 4090 Super GPU with 48GB GDDR7',2999.00,55,'2025-11-11 19:25:47','2025-11-11 19:25:47'),
('MSKEYBOARDPRO@202511111930','Microsoft Keyboard Pro','Microsoft ergonomic wireless keyboard with AI keys',199.00,400,'2025-11-11 19:30:22','2025-11-11 19:30:22'),
('LOGITECHMXMASTER4@202511111935','Logitech MX Master 4','Logitech MX Master 4 mouse with haptic scroll wheel',179.00,420,'2025-11-11 19:35:44','2025-11-11 19:35:44'),
('APPLEVRHEADSET@202511111940','Apple Vision Ultra','Apple Vision Ultra VR headset with 16K per-eye resolution',3999.00,30,'2025-11-11 19:40:18','2025-11-11 19:40:18'),
('HUAWEIMATEPAD15@202511111945','Huawei MatePad 15','Huawei MatePad 15 tablet with HarmonyOS 5',1099.00,120,'2025-11-11 19:45:37','2025-11-11 19:45:37'),
('LENOVOYOGA9I@202511111950','Lenovo Yoga 9i 2025','Lenovo Yoga 9i 2-in-1 laptop with OLED 4K display',1899.00,100,'2025-11-11 19:50:24','2025-11-11 19:50:24'),
('ONEPLUS13PRO@202511111955','OnePlus 13 Pro','OnePlus 13 Pro smartphone with Hasselblad optics',999.00,160,'2025-11-11 19:55:55','2025-11-11 19:55:55'),
('XIAOMI14ULTRA@202511112000','Xiaomi 14 Ultra','Xiaomi 14 Ultra with Leica quad camera system',1199.00,140,'2025-11-11 20:00:31','2025-11-11 20:00:31'),
('REALMEGT7@202511112005','Realme GT 7 Pro','Realme GT 7 Pro with Snapdragon 8 Gen 5 and 240W charging',799.00,130,'2025-11-11 20:05:22','2025-11-11 20:05:22'),
('OPPOFINDX8@202511112010','Oppo Find X8','Oppo Find X8 smartphone with curved OLED display',899.00,150,'2025-11-11 20:10:44','2025-11-11 20:10:44'),
('HONORMAGIC7@202511112015','Honor Magic 7','Honor Magic 7 AI-powered smartphone',849.00,160,'2025-11-11 20:15:29','2025-11-11 20:15:29'),
('ASUSZENBOOKDUO@202511112020','ASUS Zenbook Duo','ASUS Zenbook Duo dual-screen laptop 2025',2599.00,70,'2025-11-11 20:20:17','2025-11-11 20:20:17'),
('MACBOOKAIRM5@202511112025','MacBook Air M5','Apple MacBook Air with M5 chip 2025 edition',1799.00,140,'2025-11-11 20:25:43','2025-11-11 20:25:43'),
('DELLPRECISIONX@202511112030','Dell Precision X','Dell Precision X workstation with 96-core Xeon Ultra',8899.00,10,'2025-11-11 20:30:19','2025-11-11 20:30:19'),
('HPZBOOKFURY@202511112035','HP ZBook Fury 18','HP ZBook Fury 18 Mobile Workstation',5899.00,15,'2025-11-11 20:35:54','2025-11-11 20:35:54'),
('CANONEOSR2@202511112040','Canon EOS R2','Canon EOS R2 full-frame mirrorless camera',6499.00,20,'2025-11-11 20:40:10','2025-11-11 20:40:10'),
('LEICAM12@202511112045','Leica M12','Leica M12 digital rangefinder camera',8999.00,8,'2025-11-11 20:45:12','2025-11-11 20:45:12'),
('PANASONICS1H@202511112050','Panasonic Lumix S1H II','Panasonic Lumix S1H II 8K video camera',5799.00,12,'2025-11-11 20:50:39','2025-11-11 20:50:39'),
('DJIPOCKET4@202511112055','DJI Pocket 4','DJI Pocket 4 handheld 6K camera',899.00,60,'2025-11-11 20:55:43','2025-11-11 20:55:43'),
('SONYZV2@202511112100','Sony ZV-2','Sony ZV-2 vlogging camera with real-time eye AF',799.00,90,'2025-11-11 21:00:26','2025-11-11 21:00:26'),
('LOGITECHSTREAMCAM2@202511112105','Logitech StreamCam 2','Logitech StreamCam 2 4K webcam for creators',299.00,200,'2025-11-11 21:05:50','2025-11-11 21:05:50'),
('RAZERKRONOS@202511112110','Razer Kronos','Razer Kronos gaming keyboard with magnetic analog switches',249.00,180,'2025-11-11 21:10:28','2025-11-11 21:10:28'),
('STEELSERIESARCTISX@202511112115','SteelSeries Arctis X','SteelSeries Arctis X wireless gaming headset',299.00,190,'2025-11-11 21:15:34','2025-11-11 21:15:34'),
('CORSAIRVOIDELITE2@202511112120','Corsair Void Elite 2','Corsair Void Elite 2 RGB headset with haptic feedback',279.00,200,'2025-11-11 21:20:48','2025-11-11 21:20:48'),
('LOGITECHPROWHEEL@202511112125','Logitech Pro Wheel 2','Logitech Pro Wheel 2 racing simulator controller',999.00,45,'2025-11-11 21:25:11','2025-11-11 21:25:11'),
('THRUSTMASTERXPRO@202511112130','Thrustmaster X-Pro','Thrustmaster X-Pro flight simulator joystick',699.00,50,'2025-11-11 21:30:15','2025-11-11 21:30:15'),
('XBOXELITE3@202511112135','Xbox Elite Controller 3','Microsoft Xbox Elite Series 3 Controller',249.00,300,'2025-11-11 21:35:42','2025-11-11 21:35:42'),
('PLAYSTATIONPORTAL2@202511112140','PlayStation Portal 2','Sony PlayStation Portal 2 streaming handheld',399.00,150,'2025-11-11 21:40:36','2025-11-11 21:40:36'),
('NINTENDOGAMECUBE2@202511112145','Nintendo GameCube 2','Nintendo GameCube 2 retro console with 4K remaster',499.00,70,'2025-11-11 21:45:22','2025-11-11 21:45:22'),
('SEGALEGEND@202511112150','SEGA Legend','SEGA Legend handheld retro console',399.00,100,'2025-11-11 21:50:10','2025-11-11 21:50:10'),
('ATARIORIGIN@202511112155','Atari Origin','Atari Origin retro gaming console with cloud library',299.00,130,'2025-11-11 21:55:31','2025-11-11 21:55:31');

