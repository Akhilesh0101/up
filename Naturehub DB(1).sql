

create DATABASE NatureHub3;
USE NatureHub3;

-- Create Roles Table (with two roles: Admin and User)
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY(1,1),
    RoleName NVARCHAR(10) NOT NULL UNIQUE
);

-- Insert default roles into the Roles table
INSERT INTO Roles (RoleName)
VALUES ('Admin'), ('User');

-- Admin Table 
CREATE TABLE Admin (
    AdminID INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(20) NOT NULL UNIQUE,
    Password NVARCHAR(20) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    RoleID INT NOT NULL,
    CONSTRAINT CHK_Password_Validation CHECK (
        LEN(Password) >= 8 AND
        Password LIKE '%[A-Z]%' AND  
        Password LIKE '%[a-z]%' AND  
        Password LIKE '%[0-9]%' 
    ),
	CONSTRAINT CHK_Email_Validation CHECK (
        Email LIKE '%_@__%.__%' -- basic validation for an email address format
    ),
    CONSTRAINT FK_Admin_Role FOREIGN KEY (RoleID) REFERENCES Roles(RoleID) ON DELETE CASCADE ON UPDATE CASCADE,
   
);
insert into Admin values('Akhilesh','Akhilesh123','akhilesh@gmail.com',1)

-- Users Table
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    UserName NVARCHAR(20) NOT NULL,
	UserImage VARBINARY(MAX),
    Email NVARCHAR(25) NOT NULL UNIQUE,
    Password NVARCHAR(20) NOT NULL,
    RoleID INT NOT NULL,
	  CONSTRAINT CHK_Password_Validation_User CHECK (
        LEN(Password) >= 8 AND
        Password LIKE '%[A-Z]%' AND  
        Password LIKE '%[a-z]%' AND  
        Password LIKE '%[0-9]%' 
    ),
	CONSTRAINT CHK_Email_Validation_User CHECK (
        Email LIKE '%_@__%.__%' -- basic validation for an email address format
    ),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID) ON DELETE CASCADE ON UPDATE CASCADE
);
select *from Users 
insert into Users values('Akhil','https://mbaybrew.com/wp-content/uploads/2023/06/vecteezy_profile-icon-design-vector_5544718-768x768.jpg','akhil@gmail.com','Akhil123',2)
insert into Users values('Aaditya','https://mbaybrew.com/wp-content/uploads/2023/06/vecteezy_profile-icon-design-vector_5544718-768x768.jpg','aaditya@gmail.com','Aadi123456',2)
insert into Users values('aman','https://mbaybrew.com/wp-content/uploads/2023/06/vecteezy_profile-icon-design-vector_5544718-768x768.jpg','aman@gmail.com','aman123456',2)
insert into Users values('amit','https://mbaybrew.com/wp-content/uploads/2023/06/vecteezy_profile-icon-design-vector_5544718-768x768.jpg','amit@gmail.com','amit123456',2)
insert into Users values('rohan','https://mbaybrew.com/wp-content/uploads/2023/06/vecteezy_profile-icon-design-vector_5544718-768x768.jpg','rohan@gmail.com','rohan123456',2)

select * from users
-- Fixed Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(20) NOT NULL UNIQUE
);

-- Populate Fixed Categories
INSERT INTO Categories (CategoryName) 
VALUES ('Hair'), ('Skin'), ('Body'), ('Digestion'), ('Immunity');

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(30) NOT NULL,
    Productimg VARBINARY(MAX),
    Price DECIMAL(10, 2) NOT NULL,
    Description NVARCHAR(MAX),
    StockQuantity INT DEFAULT 0,
    CategoryID INT NOT NULL,
    CreatedByAdminID INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CreatedByAdminID) REFERENCES Admin(AdminID) ON DELETE CASCADE ON UPDATE CASCADE
);
select * from Products

--  Cart Table (for storing products in a user's cart)
CREATE TABLE Cart (
    CartID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 0,  -- Default quantity is 0
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Remedies Table
CREATE TABLE Remedies (
    RemedyID INT PRIMARY KEY IDENTITY(1,1),
    RemedyName NVARCHAR(100) NOT NULL,
    Remediesimg VARBINARY(MAX),
    Description NVARCHAR(MAX),
    Benefits NVARCHAR(MAX),
    PreparationMethod NVARCHAR(MAX),
    UsageInstructions NVARCHAR(MAX),
    CategoryID INT NOT NULL,
    CreatedByAdminID INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CreatedByAdminID) REFERENCES Admin(AdminID) ON DELETE CASCADE ON UPDATE CASCADE
);
select * from Remedies

-- Health Tips Table
CREATE TABLE HealthTips (
    TipID INT PRIMARY KEY IDENTITY(1,1),
    TipTitle NVARCHAR(100) NOT NULL,
    TipDescription NVARCHAR(MAX),
    HealthTipsimg VARBINARY(MAX),
    CategoryID INT NOT NULL,
    CreatedByAdminID INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CreatedByAdminID) REFERENCES Admin(AdminID) ON DELETE CASCADE ON UPDATE CASCADE
);
select * from HealthTips
-- Address Table
CREATE TABLE Address (
    AddressID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    Street NVARCHAR(100),
    PhoneNumber VARCHAR(10) NOT NULL UNIQUE CHECK (PhoneNumber LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    City NVARCHAR(50),
    State NVARCHAR(50),
    Country NVARCHAR(50),
    ZipCode NVARCHAR(20),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE ON UPDATE CASCADE
);



-- Payments Table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE ON UPDATE CASCADE 
);

-- Bookmark Table
CREATE TABLE Bookmark (
    BookmarkID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    RemedyID INT NOT NULL, -- Links directly to Remedies
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ,
    FOREIGN KEY (RemedyID) REFERENCES Remedies(RemedyID) ON DELETE CASCADE ON UPDATE CASCADE
);

select * from Products order by ProductID


--products

INSERT INTO Products (ProductName, Productimg, Price, Description, StockQuantity, CategoryID, CreatedByAdminID)
VALUES 
('Herbal Shampoo', ' https://nibharra.com/wp-content/uploads/2022/07/HERBAL-SHAMPOO.jpg', 299, 'A nourishing shampoo for strong and shiny hair.', 0, 1, 1),
('Amla Hair Oil', 'https://5.imimg.com/data5/SELLER/Default/2024/3/398719961/IB/IV/GT/14843387/100-ml-amulya-amla-hair-oil.jpg', 149, 'Natural oil enriched with Amla for hair growth.', 0, 1, 1),
('Aloe Vera Conditioner', 'https://nathabit.in/_nat/images/1_435dee8517.jpg?format=auto&width=1920&quality=75
', 499, 'Hydrating conditioner for smooth, frizz-free hair.', 0, 1, 1),
('Neem Hair Mask', 'https://nathabit.in/_nat/images/neem_bhringraj_01_d8d56cea7a.jpg?format=auto&width=1920&quality=75
', 899, 'Deep cleansing mask for dandruff-free scalp.', 0, 1, 1),
('Hibiscus Hair Powder', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhnysVlnyDSxl_WPBCqAQaP-q0WMpuhFGo8A&s
', 949, 'Powder for strengthening and volumizing hair.', 0, 1, 1),
('Fenugreek Hair Serum', 'https://m.media-amazon.com/images/I/616QrEe4APL._SX355_.jpg
', 199, 'Serum to reduce hair fall and enhance shine.', 0, 1, 1),
('Onion Hair Oil', 'https://m.media-amazon.com/images/I/71lL7V+aTTL._AC_UF1000,1000_QL80_FMwebp_.jpg
', 199, 'Boosts hair regrowth and reduces hair thinning.', 0, 1, 1),
('Coconut Hair Cream', 'https://m.media-amazon.com/images/I/61RRLuGb6KL.jpg', 7.99, 'Cream for daily hair moisturization and styling.', 0, 1, 1);


INSERT INTO Products (ProductName, Productimg, Price, Description, StockQuantity, CategoryID, CreatedByAdminID)
VALUES 
('Aloe Vera Gel', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6r6dW5wvea9KlPbLbxjY1dh_5-WYjQMbmLw&s', 699, 'Hydrates and soothes dry or irritated skin.', 0, 2, 1),
('Turmeric Face Wash', 'https://m.media-amazon.com/images/I/51RqElWmvoL._SY550_.jpg', 849, 'A gentle cleanser with antibacterial properties.', 0, 2, 1),
('Rose Water Toner', ' https://m.media-amazon.com/images/I/614jVhg+iFL.jpg', 599, 'Refreshes and balances skin pH levels.', 0, 2, 1),
('Neem Face Pack', ' https://m.media-amazon.com/images/I/71FFq-XmuBL.jpg
', 999, 'Detoxifying pack for clear, acne-free skin.', 0, 2, 1),
('Shea Butter Lotion', 'https://www.mitchellbrands.com/cdn/shop/products/5_c747a3cd-dfeb-4da5-8af6-8498f7d3af25.jpg?v=1629501872
', 1299, 'Deeply moisturizes and softens dry skin.', 0, 2, 1),
('Charcoal Scrub', 'https://img.faballey.com/images/Product/28437012/3.jpg
', 1099, 'Exfoliates and removes impurities from pores.', 0, 2, 1),
('Cucumber Face Mist', 'https://loveearth.in/cdn/shop/files/NYLRTH0000003_2.png?v=1706351810&width=1500
', 499, 'Instantly cools and revitalizes tired skin.', 0, 2, 1),
('Sandalwood Cream', 'https://cdn.shopify.com/s/files/1/0277/8818/1622/products/JJ2A9028copy.jpg?v=1717145773', 199, 'Brightens skin tone and reduces blemishes.', 0, 2, 1);



INSERT INTO Products (ProductName, Productimg, Price, Description, StockQuantity, CategoryID, CreatedByAdminID)
VALUES 
('Herbal Body Wash', 'https://www.synaa.com/wp-content/uploads/2019/11/Synaa-24-Herbs-Body-Wash-1.jpg
', 999, 'A natural cleanser for refreshed and glowing skin.', 0, 3, 1),
('Lavender Body Lotion', 'https://prakritiherbals.in/cdn/shop/files/WhatsAppImage2023-12-05at6.08.02PM_720x.jpg?v=1701857671
', 1149, 'Hydrating lotion for smooth and fragrant skin.', 0, 3, 1),
('Eucalyptus Bath Oil', 'https://m.media-amazon.com/images/I/61rv74EGDkL.jpg
', 1499, 'Relaxing oil for rejuvenating bath experiences.', 0, 3, 1),
('Coffee Body Scrub', 'https://www.botanichearth.in/cdn/shop/files/81ZYH18t-2L._SL1500.jpg?v=1716451155
', 139, 'Exfoliates dead skin cells and improves texture.', 0, 3, 1),
('Almond Body Butter', 'https://www.mcaffeine.com/cdn/shop/products/PrimaryImage.jpg?v=1669275143', 1299, 'Intense hydration for dry and flaky skin.', 0, 3, 1),
('Neem and Turmeric Soap', 'https://assets.myntassets.com/w_412,q_60,dpr_2,fl_progressive/assets/images/28272832/2024/3/14/67ac7949-0023-4ce6-a76d-bd0bffb3448d1710414911323NeemeliaHerbalBathingBar1.jpg', 499, 'Antibacterial soap for healthy skin.', 0, 3, 1),
('Organic Deodorant', ' https://www.mypure.co.uk/cdn/shop/files/herbal-deodorant-476029.jpg?v=1726005251&width=860
', 899, 'Natural and long-lasting body odor protection.', 0, 3, 1),
('Aloe Vera Foot Cream', 'https://www.cosmeto-nature.com/2332/aloe-vera-foot-treatment-cream-nuevopie.jpg', 799, 'Soothes cracked heels and dry feet.', 0, 3, 1);



INSERT INTO Products (ProductName, Productimg, Price, Description, StockQuantity, CategoryID, CreatedByAdminID)
VALUES 
('Ginger Tea Powder', ' https://m.media-amazon.com/images/I/51sLGEzveUL.jpg
', 599, 'Relieves bloating and improves digestion.', 0, 4, 1),
('Triphala Powder', 'https://m.media-amazon.com/images/I/61yP5jRPOsL._SY450_.jpg', 799, 'Ayurvedic blend for better gut health.', 0, 4, 1),
('Peppermint Capsules', 'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/nwy/nwy14160/g/58.jpg', 999, 'Eases stomach discomfort and gas.', 0, 4, 1),
('Fennel Seeds', 'https://myshpl.com/web-admin/images/product/1713516681_jpg
', 399, 'A natural remedy for digestion and fresh breath.', 0, 4, 1),
('Aloe Vera Juice', 'images/aloe_vera_juice.jpg', 1299, 'Promotes digestion and detoxification.', 0, 4, 1),
('Probiotic Capsules', 'https://www.getsupp.com/static/media/__resized/images/products/IXBU76MUZELVOR1PI-b55a6a20-fbe9-48d7-9603-c09c30d90202-thumbnail_webp-1080x1080-70.webp
', 1599, 'Enhances gut flora and digestion.', 0, 4, 1),
('Lemon Ginger Syrup', 'https://www.jiomart.com/images/product/original/rv4vkj1zv1/rk-home-made-natural-syrup-ginger-lemon-syrup-750-ml-product-images-orv4vkj1zv1-  
                         p600824247-0-202304222111.jpg?im=Resize=(420,420)
', 849, 'Boosts metabolism and soothes indigestion.', 0, 4, 1),
('Ajwain Water', 'https://m.media-amazon.com/images/I/71lXfiH2hCL._SL1500_.jpg
', 499, 'Relieves acidity and improves appetite.', 0, 4, 1);

INSERT INTO Products (ProductName, Productimg, Price, Description, StockQuantity, CategoryID, CreatedByAdminID)
VALUES 
('Tulsi ', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbHHo7HNxYv6YdPz0DMCyh5KXr1QY1kCOW8LG8EIRqiiWdabRzjdevXemKbU_3Nqd9t-Q&usqp=CAU', 599, 'Strengthens immunity and combats infections.', 0, 5, 1)


INSERT INTO Products (ProductName, Productimg, Price, Description, StockQuantity, CategoryID, CreatedByAdminID)
VALUES 
('Tulsi Drops', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbHHo7HNxYv6YdPz0DMCyh5KXr1QY1kCOW8LG8EIRqiiWdabRzjdevXemKbU_3Nqd9t-Q&usqp=CAU', 599, 'Strengthens immunity and combats infections.', 0, 5, 1),
('Chyawanprash', 'https://hetha.in/cdn/shop/products/Organicchyawanprash_f5d7baa6-d547-4705-b1b5-f5b3971eeabc_grande.png?v=1657550084', 1199, 'An ancient herbal formula for immunity support.', 0, 5, 1),
('Vitamin C Gummies', 'https://images-cdn.ubuy.co.in/635376eb0bb0441c640d344d-vitamin-c-1000mg-gummies-with-zinc.jpg
', 1049, 'Boosts immune health and fights fatigue.', 0, 5, 1),
('Giloy Tablets', 'https://rukminim2.flixcart.com/image/850/1000/l5iid8w0/ayurvedic/w/q/p/giloy-ghanvati-tablet-help-for-boost-immunity-plates-100-veg-original-imagg69pubphxvbg.jpeg?q=
                         20&crop=false
', 999, 'Ayurvedic herb for enhanced immunity and vitality.', 0, 5, 1),
('Elderberry Syrup', ' https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT81eEMy6TDhe882nEgX5O6RHbVsuS97qh-xw&s', 1399, 'Natural remedy for colds and flu.', 0, 5, 1),
('Ashwagandha Powder', ' https://m.media-amazon.com/images/I/6195eN3CYFL.jpg
', 899, 'Reduces stress and boosts overall immunity.', 0, 5, 1),
('Moringa Capsules', 'https://rukminim2.flixcart.com/image/850/1000/xif0q/vitamin-supplement/y/b/n/ayurvedic-noni-capsule-morinda-citrifolia-noni-extract-tablet-original-
                         imagsc5nbqpumedq.jpeg?q=90&crop=false
', 1249, 'A superfood that fortifies the immune system.', 0, 5, 1),
('Herbal Kadha', 'https://m.media-amazon.com/images/I/61azOFElV2L._AC_UF1000,1000_QL80_.jpg
', 699, 'A traditional immunity-boosting herbal drink.', 0, 5, 1);


--remedies data

INSERT INTO Remedies (RemedyName, Remediesimg, Description, Benefits, PreparationMethod, UsageInstructions, CategoryID, CreatedByAdminID)
VALUES 
('Amla Hair Mask', 'https://media.post.rvohealth.io/wp-content/uploads/sites/3/2022/10/gooseberries_mnt_732x549_thumb.jpg', 'A natural remedy for strengthening hair roots.', 'Boosts hair growth and reduces hair fall.', 'Mix amla powder with water to form a paste.', 'Apply to scalp and leave for 30 minutes, then rinse.', 1, 1),
('Coconut Oil Massage', 'https://www.netmeds.com/images/cms/wysiwyg/blog/2019/07/Coconut-oil-extraction_898x898.jpg', 'A nourishing treatment for dry and damaged hair.', 'Moisturizes scalp and prevents split ends.', 'Warm coconut oil slightly.', 'Massage into scalp and hair, leave overnight, and wash.', 1, 1),
('Hibiscus Hair Pack', 'https://cdn.shopify.com/s/files/1/2028/2057/files/hibiscus-flower-and-oil-on-an-old-wooden-table.jpg?v=1655281967', 'A natural conditioner for frizzy hair.', 'Reduces frizz and adds shine to hair.', 'Blend hibiscus petals into a smooth paste.', 'Apply to hair and scalp for 20 minutes, then rinse.', 1, 1),
('Fenugreek Rinse', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwDOOsSyJHtMW0d_ZBwNI5EJarMwXZZQdz8BxgznrtfEqEyX6CnremNfGjT6gaqs8yGnE&usqp=CAU', 'An anti-dandruff remedy.', 'Soothes scalp irritation and removes dandruff.', 'Soak fenugreek seeds overnight and grind into a paste.', 'Apply to scalp, leave for 15 minutes, and wash off.', 1, 1),
('Onion Juice', 'https://imgs.littleextralove.com/wp-content/uploads/2022/08/fenugreek-and-onion-juice-for-hair-feat.jpg', 'A remedy to combat hair thinning.', 'Stimulates hair regrowth.', 'Extract juice from onions.', 'Apply directly to the scalp and leave for 30 minutes before rinsing.', 1, 1),
('Neem and Curry Leaf Oil', 'https://www.bigbasket.com/media/uploads/p/xxl/10000105_17-fresho-curry-leaves.jpg', 'A natural remedy for itchy scalp.', 'Cleanses and soothes the scalp.', 'Boil neem and curry leaves in coconut oil.', 'Strain and apply the oil to the scalp, leaving it overnight.', 1, 1),
('Aloe Vera Gel', 'https://images.onlymyhealth.com/imported/images/2023/July/18_Jul_2023/Main-aloe-vera-hair-mask.jpg', 'A cooling treatment for hair damage.', 'Repairs damaged hair and promotes smoothness.', 'Extract fresh aloe vera gel.', 'Apply the gel directly to your scalp and hair for 20 minutes, then rinse.', 1, 1),
('Castor Oil and Lemon Mix', 'https://www.treehugger.com/thmb/FkKaiJXlnGunKRObI9CGI3ewl9c=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/castor-oil-with-beans-on-wooden-surface-542794272-c9e75bf354d74da19c426d225927b022.jpg', 'A strengthening solution for hair.', 'Strengthens hair and prevents breakage.', 'Mix castor oil with a few drops of lemon juice.', 'Massage into hair roots, leave for an hour, and rinse.', 1, 1);

select * from Remedies order by RemedyID


INSERT INTO Remedies (RemedyName, Remediesimg, Description, Benefits, PreparationMethod, UsageInstructions, CategoryID, CreatedByAdminID)
VALUES 
('Aloe Vera Mask', 'https://media.post.rvohealth.io/wp-content/uploads/2019/07/Aloe_Vera_1200x628-facebook-1.jpg', 'A hydrating mask for glowing skin.', 'Soothes dryness and reduces redness.', 'Apply fresh aloe vera gel directly.', 'Leave for 20 minutes and rinse with water.', 2, 1),
('Turmeric and Honey Pack', 'https://www.shutterstock.com/image-photo/natural-face-mask-turmeric-powder-260nw-2352169029.jpg', 'A natural brightening pack.', 'Reduces blemishes and brightens skin.', 'Mix turmeric powder and honey into a paste.', 'Apply to face, leave for 15 minutes, and wash off.', 2, 1),
('Neem Face Pack', 'https://www.lustercosmetics.in/cdn/shop/products/4_1deec7d4-332f-492d-896c-6d016c0c3b0b.png?v=1670671466&width=1445', 'An acne-fighting remedy.', 'Cleanses pores and reduces acne.', 'Grind neem leaves into a paste with water.', 'Apply to face, leave for 15 minutes, and rinse.', 2, 1),
('Rose Water and Sandalwood Mix', 'https://www.kaya.in/media/mageplaza/blog/post/h/o/how-to-use-rose-water-for-skin-care.jpeg', 'A cooling face treatment.', 'Refreshes and softens skin.', 'Mix rose water with sandalwood powder.', 'Apply to the face, leave for 10 minutes, and rinse.', 2, 1),
('Cucumber Face Mask', 'https://thenerdyfarmwife.com/wp-content/uploads/2023/07/cucumber-face-mask-with-french-green-clay-600.jpg', 'A soothing remedy for tired skin.', 'Reduces puffiness and hydrates skin.', 'Blend cucumber into a smooth paste.', 'Apply to face, leave for 15 minutes, and wash off.', 2, 1),
('Charcoal Mask', 'https://media.post.rvohealth.io/wp-content/uploads/2019/08/charcoal-still-life-diy-beauty-mask-1200x628-facebook.jpg', 'A detoxifying remedy for oily skin.', 'Removes toxins and unclogs pores.', 'Mix activated charcoal powder with water.', 'Apply a thin layer to the face and wash after 20 minutes.', 2, 1),
('Yogurt and Honey Mix', 'https://www.mygreekdish.com/wp-content/uploads/2014/09/Greek-Yogurt-drizzled-with-Honey-and-Walnuts-Yiaourti-me-meli.jpg', 'A natural moisturizing pack.', 'Hydrates and smoothens skin.', 'Combine yogurt and honey.', 'Apply to the skin, leave for 15 minutes, and rinse.', 2, 1),
('Papaya Mask', 'https://cdn.shopify.com/s/files/1/1049/3064/files/Papaya_Face_Masks_5_cb4eca23-88b2-4378-9773-46ff0673ab48_large.jpg?v=1533917751', 'A natural exfoliator for soft skin.', 'Removes dead skin cells.', 'Mash ripe papaya into a paste.', 'Apply to the face for 10 minutes and rinse off.', 2, 1);


INSERT INTO Remedies (RemedyName, Remediesimg, Description, Benefits, PreparationMethod, UsageInstructions, CategoryID, CreatedByAdminID)
VALUES 
('Epsom Salt Bath', 'https://www.secretwhispers.co.uk/cdn/shop/articles/1_f1475a77-e3a4-4015-83c6-88203939637a.png?v=1660825835', 'A soothing bath remedy for muscle relaxation.', 'Relieves stress and relaxes sore muscles.', 'Dissolve 2 cups of Epsom salt in warm bathwater.', 'Soak in the bath for 20 minutes.', 3, 1),
('Coffee Body Scrub', 'https://www.lustercosmetics.in/cdn/shop/products/3c8687f6645bdcf01433a4f1ac25447f.jpg?v=1659762021&width=1946', 'An exfoliating scrub for smooth skin.', 'Removes dead skin cells and improves circulation.', 'Mix coffee grounds with coconut oil.', 'Gently scrub onto the skin and rinse.', 3, 1),
('Coconut Oil Body Massage', 'https://www.verywellhealth.com/thmb/YU_4tvUI3VVmGHrD2Dvp7-0zqJw=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-8081649701-5b37f75946e0fb0037ce0001.jpg', 'A hydrating massage for dry skin.', 'Moisturizes and nourishes the skin.', 'Slightly warm coconut oil.', 'Massage over the body and leave overnight.', 3, 1),
('Herbal Steam Therapy', 'https://i.herbalreality.com/wp-content/uploads/2023/04/21123141/How-to-make-a-herbal-steam-inhalation-scaled.jpg', 'A natural remedy for detoxification.', 'Opens pores and removes toxins.', 'Add mint leaves and eucalyptus oil to steaming water.', 'Inhale the steam for 10-15 minutes.', 3, 1),
('Aloe Vera and Turmeric Gel', 'https://rukminim2.flixcart.com/image/850/1000/xif0q/body-skin-treatment/f/r/5/400-aloe-vera-gel-with-100-pure-turmeric-for-skin-hair-and-body-original-imahfk34fhzqqhj6.jpeg?q=20&crop=false', 'A soothing treatment for irritated skin.', 'Reduces inflammation and soothes rashes.', 'Mix aloe vera gel with a pinch of turmeric.', 'Apply to the affected area and leave for 20 minutes.', 3, 1),
('Lavender Bath Oil', 'https://www.jiomart.com/images/product/original/rvrxj3k1hn/vi-prime-lavender-essential-oil-for-hair-skin-100-pure-lavender-oil-with-natural-lavandula-angustifolia-extract-calming-bath-or-massage-for-restful-sleep-diffuser-ready-for-aromatherapy-10-ml-product-images-orvrxj3k1hn-p594745425-2-202210211700.jpg?im=Resize=(420,420)', 'A calming bath remedy.', 'Relieves anxiety and promotes better sleep.', 'Mix lavender oil with a carrier oil and add to bathwater.', 'Soak in the bath for 15-20 minutes.', 3, 1),
('Neem Soap', 'https://c.ndtvimg.com/2019-04/297c4g0o_neem650_625x300_15_April_19.jpg?downsize=545:307', 'A cleansing remedy for healthy skin.', 'Treats acne and prevents infections.', 'Use a natural neem soap bar.', 'Wash daily with neem soap during a bath.', 3, 1),
('Shea Butter Balm', 'https://i0.wp.com/zainabucosmetics.com/wp-content/uploads/2024/01/62018725-8955-4C23-BCC6-DD1360AF4738-scaled.jpeg?fit=2441%2C2560&ssl=1', 'A natural moisturizer for dry and cracked skin.', 'Deeply nourishes and heals damaged skin.', 'Melt shea butter and mix with coconut oil.', 'Apply generously to dry areas like elbows and knees.', 3, 1);


INSERT INTO Remedies (RemedyName, Remediesimg, Description, Benefits, PreparationMethod, UsageInstructions, CategoryID, CreatedByAdminID)
VALUES 
('Ginger Tea', 'https://www.themediterraneandish.com/wp-content/uploads/2023/01/ginger-tea-recipe-1.jpg', 'A soothing remedy for bloating and nausea.', 'Improves digestion and reduces bloating.', 'Boil ginger slices in water for 10 minutes.', 'Drink warm after meals.', 4, 1),
('Fennel Seed Water', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRU6VdWzedOrsgMUzDaLne1n_1bvaX4_m76Kg&s', 'A natural remedy for indigestion.', 'Relieves gas and bloating.', 'Soak fennel seeds in water overnight.', 'Drink the water in the morning on an empty stomach.', 4, 1),
('Triphala Powder Drink', 'https://vediherbals.com/cdn/shop/articles/Triphala_churna.png?v=1623124525', 'A detoxifying Ayurvedic drink.', 'Promotes gut health and regular bowel movements.', 'Mix Triphala powder in warm water.', 'Consume before bedtime.', 4, 1),
('Peppermint Tea', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvxmtNRT5EC5c_xre6yx49xaPNNn2quDpMQQ&s', 'A calming remedy for stomach discomfort.', 'Relieves gas and soothes indigestion.', 'Steep peppermint leaves in hot water.', 'Drink warm, especially after heavy meals.', 4, 1),
('Ajwain Water', 'https://www.healthshots.com/wp-content/uploads/2020/08/ajwain-water.jpg', 'A remedy for acidity and gas.', 'Improves digestion and reduces flatulence.', 'Boil ajwain seeds in water.', 'Drink warm before meals.', 4, 1),
('Aloe Vera Juice', 'https://post.healthline.com/wp-content/uploads/2020/09/10155-9_Healthy_Benefits_of_Drinking_Aloe_Vera_Juice_1200x628-facebook-1200x628.jpg', 'A natural drink for digestive health.', 'Soothes the stomach and promotes bowel movements.', 'Extract fresh aloe vera gel and blend with water.', 'Drink daily in the morning.', 4, 1),
('Lemon and Honey Water', 'https://www.truemeds.in/_next/image?url=https%3A%2F%2Ftruemedsblog.in%2Fwp-content%2Fuploads%2F2021%2F10%2FBenefits-of-honey-and-lemon-infused-water.jpg&w=1920&q=75', 'A detox drink for digestion.', 'Flushes out toxins and aids metabolism.', 'Mix lemon juice and honey in warm water.', 'Drink on an empty stomach every morning.', 4, 1),
('Cumin Seed Tea', 'https://static.toiimg.com/thumb/msid-115708759,width-1280,height-720,imgsize-129934,resizemode-6,overlay-toi_sw,pt-32,y_pad-40/photo.jpg', 'A herbal remedy for digestive issues.', 'Reduces bloating and aids digestion.', 'Boil cumin seeds in water.', 'Sip warm after meals.', 4, 1);


INSERT INTO Remedies (RemedyName, Remediesimg, Description, Benefits, PreparationMethod, UsageInstructions, CategoryID, CreatedByAdminID)
VALUES 
('Turmeric Milk', 'https://i2.wp.com/www.downshiftology.com/wp-content/uploads/2019/02/Golden-Milk-main.jpg', 'A traditional immunity booster.', 'Fights infections and reduces inflammation.', 'Mix turmeric powder in warm milk.', 'Drink before bedtime.', 5, 1),
('Tulsi Tea', 'https://i.ytimg.com/vi/MklCtTD6DRU/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBXxlsquOZYsro4EApGo9MYZu1nVA', 'A natural remedy for colds and flu.', 'Boosts immunity and relieves congestion.', 'Boil tulsi leaves in water.', 'Drink warm twice daily.', 5, 1),
('Chyawanprash', 'https://www.mdpi.com/biomolecules/biomolecules-09-00161/article_deploy/html/images/biomolecules-09-00161-g001-550.jpg', 'An Ayurvedic health tonic.', 'Improves immunity and overall vitality.', 'Consume directly as per instructions.', 'Take 1-2 teaspoons daily.', 5, 1),
('Lemon and Ginger Tea', 'https://static.toiimg.com/thumb/msid-113739293,width-400,resizemode-4/113739293.jpg', 'A refreshing immunity-boosting drink.', 'Rich in Vitamin C and antioxidants.', 'Boil lemon slices and ginger in water.', 'Drink warm in the morning.', 5, 1),
('Elderberry Syrup', 'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/elderberry-syrup-700-350-16f649d.jpg', 'A traditional remedy for colds and flu.', 'Reduces the duration of colds.', 'Simmer elderberries with water and honey.', 'Take a teaspoon daily during flu season.', 5, 1),
('Giloy Juice', 'https://static.toiimg.com/thumb/imgsize-777964,msid-76389115,width-375,height-210,resizemode-75/76389115.jpg', 'A powerful Ayurvedic remedy.', 'Enhances immunity and detoxifies the body.', 'Extract juice from fresh giloy stems.', 'Drink in the morning on an empty stomach.', 5, 1),
('Herbal Kadha', 'https://static.toiimg.com/thumb/imgsize-971579,msid-76859793,width-375,height-210,resizemode-75/76859793.jpg', 'A herbal drink for boosting immunity.', 'Protects against infections.', 'Boil herbs like tulsi, ginger, and cinnamon in water.', 'Drink warm once daily.', 5, 1),
('Moringa Tea', 'https://i.ytimg.com/vi/V9APs948uZc/maxresdefault.jpg', 'A nutrient-rich herbal tea.', 'Strengthens the immune system.', 'Steep moringa leaves in hot water.', 'Drink twice a day.', 5, 1);


--healtTips data

INSERT INTO HealthTips (TipTitle, TipDescription, HealthTipsimg, CategoryID, CreatedByAdminID)
VALUES 
('Regular Scalp Massage', 'Massaging your scalp boosts blood circulation, strengthens hair roots, and promotes growth.', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.hkvitals.com%2Fblog%2Fscalp-massage-and-its-benefits-for-hair-and-more%2F&psig=AOvVaw2ee8JFEMkpqdv0mWqxyLiC&ust=1733081842591000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCIjkv5HnhIoDFQAAAAAdAAAAABAE', 1, 1),
('Avoid Overwashing Hair', 'Washing hair too often strips natural oils, leading to dryness and breakage.', 'https://www.nutriglowcosmetics.com/wp-content/uploads/2021/11/Avoid-over-washing-the-hair-1.jpg', 1, 1),
('Use a Wide-Tooth Comb', 'Detangle wet hair with a wide-tooth comb to avoid breakage and maintain smoothness.', 'https://images-cdn.ubuy.co.in/63e3817734154103b43aab85-3-pieces-wide-tooth-comb-jumbo-rake.jpg', 1, 1),
('Protect Hair from Sun', 'Cover your hair with a scarf or hat to prevent sun damage and maintain moisture.', 'images/protect_hair_sun.jpg', 1, 1),
('Deep Conditioning Weekly', 'Apply a deep conditioner weekly to restore moisture and prevent split ends.', 'images/deep_conditioning.jpg', 1, 1),
('Trim Regularly', 'Trimming split ends every 6-8 weeks promotes healthy hair growth.', 'https://lovebeautyandplanet.in/cdn/shop/articles/520-x-373-split-ends-trim-hair-featured-image.jpg?v=1704355816', 1, 1),
('Use Lukewarm Water', 'Wash your hair with lukewarm water to avoid stripping its natural moisture.', 'https://static.toiimg.com/thumb/imgsize-35906,msid-108473903,width-375,height-210,resizemode-75/108473903.jpg', 1, 1),
('Avoid Heat Styling', 'Minimize the use of heat tools to prevent damage and maintain healthy hair.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEBcgPGsYcivtRk5UNocl0KjWroJnyF-yFSA&s', 1, 1);

select * from HealthTips

INSERT INTO HealthTips (TipTitle, TipDescription, HealthTipsimg, CategoryID, CreatedByAdminID)
VALUES 
('Stay Hydrated', 'Drink at least 8 glasses of water daily to keep your skin hydrated and glowing.', 'https://www.ctvnews.ca/content/dam/ctvnews/en/images/2023/1/2/drinking-water-1-6214911-1672673128593.jpg', 2, 1),
('Cleanse Twice Daily', 'Cleansing morning and night removes dirt and excess oil, preventing breakouts.', 'https://www.marthastewart.com/thmb/rNaUn8hCnRCS-huSRBWpH6YXv_Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/should-you-wash-face-twice-a-day-0123-2000-e40ff7647bec4923bab3b2e06e3fb23f.jpg', 2, 1),
('Moisturize Daily', 'Apply moisturizer daily to maintain skin hydration and prevent dryness.', 'https://www.jiomart.com/images/product/original/rvzbfgdptw/aaizole-derma-rozimoist-daily-moisturising-cream-moistures-for-face-hand-body-24-hours-long-lasting-hydration-oil-free-non-sticky-fast-absorbing-sun-protection-skin-friendly-ph-men-women-180-g-pack-of-3-product-images-orvzbfgdptw-p609403545-8-202408091255.jpg?im=Resize=(420,420)', 2, 1),
('Wear Sunscreen', 'Protect your skin from UV damage by using SPF 30+ daily.', 'https://www.drmanishasreviveclinic.com/blog/wp-content/uploads/2024/02/sunscreen-1024x576.webp', 2, 1),
('Avoid Touching Your Face', 'Touching your face transfers bacteria and can lead to acne and irritation.', 'https://assets.clevelandclinic.org/transform/a7d47499-2a0f-49a4-897a-6072992b4304/stop-putting-hands-on-face-1213927719', 2, 1),
('Exfoliate Weekly', 'Remove dead skin cells by exfoliating weekly to reveal smoother skin.', 'https://nirvananaturalbliss.com/cdn/shop/articles/6-top-reasons-why-you-should-exfoliate-today-400436.jpg?v=1723966585', 2, 1),
('Get Enough Sleep', 'Sleep 7-9 hours nightly to reduce puffiness and keep your skin rejuvenated.', 'https://media.assettype.com/thequint%2F2019-06%2F1b72586d-1c4f-4712-b982-65b4b59aa851%2FiStock_904079866.jpg?auto=format%2Ccompress&fmt=webp&width=720&w=1200', 2, 1),
('Avoid Harsh Products', 'Use gentle skincare products to prevent irritation and maintain a healthy barrier.', 'https://static.toiimg.com/thumb/msid-89918961,width-1280,height-720,resizemode-4/89918961.jpg', 2, 1);


INSERT INTO HealthTips (TipTitle, TipDescription, HealthTipsimg, CategoryID, CreatedByAdminID)
VALUES 
('Stretch Daily', 'Stretching daily improves flexibility and relieves muscle tension.', 'https://www.baptisthealth.com/-/media/images/migrated/blog-images/teaser-images/stretches-header-1200x560.jpg?rev=8642776c5980412b9ea34904fd11d1b1', 3, 1),
('Exercise Regularly', 'Engage in 30 minutes of physical activity daily to maintain overall health.', 'https://assets.telegraphindia.com/telegraph/2020/Nov/1605415608_physical-exercise.jpg', 3, 1),
('Maintain Good Posture', 'Good posture reduces back pain and improves body alignment.', 'https://www.h-wave.com/wp-content/uploads/2019/01/hurting-back-at-desk-for-posture_850.jpg', 3, 1),
('Take Short Walks', 'Short walks improve circulation and reduce stress during long sitting periods.', 'https://static.toiimg.com/thumb/imgsize-23456,msid-113965317,width-600,resizemode-4/113965317.jpg', 3, 1),
('Eat Balanced Meals', 'A balanced diet of proteins, fats, and carbs supports energy and immunity.', 'https://www.netmeds.com/images/cms/wysiwyg/blog/2021/07/1626258032_eat_big_450.jpg', 3, 1),
('Limit Sugar Intake', 'Reducing sugar prevents energy crashes and promotes better overall health.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjXoiacjZfHVcRAIuayVaVpCX1B8w2pkmoTQ&s', 3, 1),
('Practice Deep Breathing', 'Deep breathing exercises reduce stress and improve oxygen levels.', 'https://i0.wp.com/post.healthline.com/wp-content/uploads/2019/04/Breathing-Exercises-1296x728-header-1296x728.jpg?w=1155&h=1528', 3, 1),
('Get Regular Health Checkups', 'Routine checkups help detect and prevent potential health issues early.', 'https://www.homecareassistanceedmonton.ca/wp-content/uploads/2023/11/Simple-Checklist-for-Your-Aging-Loved-Ones-Yearly-Health-Checkup.jpg', 3, 1);


INSERT INTO HealthTips (TipTitle, TipDescription, HealthTipsimg, CategoryID, CreatedByAdminID)
VALUES 
('Drink Ginger Tea', 'Ginger tea soothes bloating, reduces nausea, and improves digestion.', 'https://static.toiimg.com/thumb/msid-27716213,width-1070,height-580,imgsize-20651,resizemode-75,overlay-toi_sw,pt-32,y_pad-40/photo.jpg', 4, 1),
('Fennel Seed Water', 'Fennel seeds relieve gas and bloating when soaked overnight in water.', 'https://static.toiimg.com/thumb/msid-111116119,width-1280,height-720,resizemode-4/111116119.jpg', 4, 1),
('Triphala Powder', 'Triphala aids digestion, relieves constipation, and detoxifies the gut.', 'https://theancientayurveda.com/wp-content/uploads/2023/10/Triphala-Juice-Manufacturers-in-India.jpg', 4, 1),
('Peppermint Tea', 'Peppermint tea relaxes digestive muscles and reduces bloating.', 'https://media.post.rvohealth.io/wp-content/uploads/2020/09/peppermint-tea-benefits-1200x628-facebook-1200x628.jpg', 4, 1),
('Ajwain Water', 'Ajwain water improves digestion and alleviates acidity and gas.', 'https://www.fitterfly.com/blog/wp-content/uploads/2023/01/The-Incredible-Health-Benefits-of-Ajwain-Water.jpg', 4, 1),
('Aloe Vera Juice', 'Aloe vera juice soothes the stomach and promotes healthy digestion.', 'https://assets.clevelandclinic.org/transform/7d0f7260-b896-4fee-ae87-304722d7621f/aloeVeraDrink-1244678181-770x533-1_jpg', 4, 1),
('Lemon and Honey Water', 'This drink detoxifies the digestive system and boosts metabolism.', 'https://static.toiimg.com/thumb/msid-113025110,width-1280,height-720,resizemode-4/113025110.jpg', 4, 1),
('Cumin Seed Tea', 'Cumin tea helps balance stomach acids and improves digestion.', 'https://static.toiimg.com/thumb/imgsize-54346,msid-63794780/63794780.jpg?width=500&resizemode=4', 4, 1);



INSERT INTO HealthTips (TipTitle, TipDescription, HealthTipsimg, CategoryID, CreatedByAdminID)
VALUES 
('Turmeric Milk', 'Turmeric milk boosts immunity, fights infections, and reduces inflammation.', 'https://images.moneycontrol.com/static-mcnews/2023/10/Health-benefits-of-turmeric-milk.jpg', 5, 1),
('Tulsi Tea', 'Tulsi tea strengthens immunity and relieves cold and flu symptoms.', 'https://www.careinsurance.com/upload_master/media/posts/September2020/tulsi.jpg', 5, 1),
('Chyawanprash', 'This Ayurvedic tonic boosts immunity and improves vitality.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3KI7Hwi1T2JGiKAWpXysc8DjiMnlrM1Jqkg&s', 5, 1),
('Lemon and Ginger Tea', 'Rich in Vitamin C, this tea strengthens immunity and reduces inflammation.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6_Usm3yJKblXVagPLvgQM11cShIlDlyE9YA&s', 5, 1),
('Elderberry Syrup', 'Elderberry syrup shortens cold durations and supports immune health.', 'https://toflwellness.com/wp-content/uploads/2024/09/elderberry-syrup-and-berries.jpg', 5, 1),
('Giloy Juice', 'Giloy juice enhances immunity and detoxifies the body.', 'https://diabesmart.in/cdn/shop/articles/what-are-the-health-benefits-of-giloy-amla-juice.png?v=1717499429', 5, 1),
('Herbal Kadha', 'Herbal Kadha boosts immunity and protects against seasonal illnesses.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfnhaAt7kixFh0SMEjtHiprovfhjOSr0wzzA&s', 5, 1),
('Moringa Tea', 'Moringa tea strengthens the immune system with essential nutrients.', 'https://images.everydayhealth.com/images/heart-health/teas-that-can-help-or-harm-your-heart-hero-1440x810.jpg', 5, 1);








