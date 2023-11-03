-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`bookseries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`bookseries` ;

CREATE TABLE IF NOT EXISTS `mydb`.`bookseries` (
  `idbookseries` INT NULL AUTO_INCREMENT,
  `bookseries` VARCHAR(45) NULL,
  `publisher` VARCHAR(45) NULL,
  `description` VARCHAR(255) NULL,
  `classification` VARCHAR(45) NULL,
  PRIMARY KEY (`idbookseries`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`book` ;

CREATE TABLE IF NOT EXISTS `mydb`.`book` (
  `idbook` INT NOT NULL AUTO_INCREMENT,
  `bookname` VARCHAR(45) NULL,
  `publicationyear` YEAR NULL,
  `description` VARCHAR(255) NULL,
  `idbookseries` INT NOT NULL,
  `seriesnumber` VARCHAR(45) NULL,
  `writer` VARCHAR(45) NULL,
  PRIMARY KEY (`idbook`),
  INDEX `fk_Kirja_kirjasarja1_idx` (`idbookseries` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`picture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`picture` ;

CREATE TABLE IF NOT EXISTS `mydb`.`picture` (
  `idpicture` INT NULL AUTO_INCREMENT,
  `picturename` VARCHAR(45) NULL,
  `publicationyear` VARCHAR(45) NULL,
  `artist` VARCHAR(45) NULL,
  `style` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `filename` VARCHAR(255) NULL,
  PRIMARY KEY (`idpicture`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`artwork`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`artwork` ;

CREATE TABLE IF NOT EXISTS `mydb`.`artwork` (
  `idbook` INT NOT NULL,
  `idpicture` INT NOT NULL,
  `pagenumber` INT NULL,
  PRIMARY KEY (`idbook`, `idpicture`),
  INDEX `fk_Kuvitus_Book1_idx` (`idbook` ASC) VISIBLE,
  INDEX `fk_Kuvitus_Picture1_idx` (`idpicture` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`user` ;

CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `iduser` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`iduser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`bookshelf`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`bookshelf` ;

CREATE TABLE IF NOT EXISTS `mydb`.`bookshelf` (
  `idbookshelf` INT NOT NULL,
  `iduser` INT NOT NULL,
  `owner` VARCHAR(45) NULL,
  PRIMARY KEY (`idbookshelf`),
  INDEX `fk_Kirjahylly_Käyttäjä1_idx` (`iduser` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`userseries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`userseries` ;

CREATE TABLE IF NOT EXISTS `mydb`.`userseries` (
  `idbookseries` INT NOT NULL,
  `idbookshelf` INT NOT NULL,
  PRIMARY KEY (`idbookseries`, `idbookshelf`),
  INDEX `fk_omatsarjat_bookseries1_idx` (`idbookseries` ASC) VISIBLE,
  INDEX `fk_omatsarjat_Kirjahylly1_idx` (`idbookshelf` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`bookcopy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`bookcopy` ;

CREATE TABLE IF NOT EXISTS `mydb`.`bookcopy` (
  `idbookcopy` INT NOT NULL AUTO_INCREMENT,
  `bookname` VARCHAR(45) NULL,
  `edition` INT NULL,
  `publicationyear` YEAR NULL,
  `idbook` INT NULL,
  `purchaseprice` DECIMAL(6,2) NULL,
  `purchasedate` DATE NULL,
  `condition` INT NULL,
  `description` VARCHAR(255) NULL,
  `solddate` DATE NULL,
  `soldprice` DECIMAL(6,2) NULL,
  `idbookseries` INT NULL,
  `idbookshelf` INT NOT NULL,
  PRIMARY KEY (`idbookcopy`),
  INDEX `fk_kirjakopio_Kirja1_idx` (`idbook` ASC) VISIBLE,
  INDEX `fk_kirjakopio_omatsarjat1_idx` (`idbookseries` ASC, `idbookshelf` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`photo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`photo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`photo` (
  `idphoto` INT NOT NULL AUTO_INCREMENT,
  `photoname` VARCHAR(255) NULL,
  `idbookcopy` INT NOT NULL,
  `pagenumber` INT NULL,
  PRIMARY KEY (`idphoto`),
  INDEX `fk_valokuva_kirjakopio1_idx` (`idbookcopy` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`bookseries`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`bookseries` (`idbookseries`, `bookseries`, `publisher`, `description`, `classification`) VALUES (1, 'Harry Potter', 'Bloomsbury', 'Harry Potter is a series of fantasy novels by J.K. Rowling about a young orphan boy named Harry who learns he is a wizard and attends a school for magic, where he makes friends and fights against the dark wizard Voldemort.', NULL);
INSERT INTO `mydb`.`bookseries` (`idbookseries`, `bookseries`, `publisher`, `description`, `classification`) VALUES (2, 'Lord of the Rings', 'Allen & Unwin', 'The Lord of the Rings is a fantasy novel series by J.R.R. Tolkien about a hobbit named Frodo who sets out on a perilous quest to destroy a powerful ring and defeat the dark lord Sauron, with the help of a fellowship of companions.', NULL);
INSERT INTO `mydb`.`bookseries` (`idbookseries`, `bookseries`, `publisher`, `description`, `classification`) VALUES (3, 'Game of Thrones', 'Voyager Books', 'Game of Thrones is a fantasy novel series by George R.R. Martin about noble families competing for control of the Iron Throne in the fictional world of Westeros, known for its complex characters, intricate plot lines, and gritty realism.', NULL);
INSERT INTO `mydb`.`bookseries` (`idbookseries`, `bookseries`, `publisher`, `description`, `classification`) VALUES (4, 'Hunger Games', 'Scholastic', 'The Hunger Games is a dystopian novel series by Suzanne Collins where children from different districts are forced to fight to the death in an annual event, and a young girl named Katniss becomes a symbol of rebellion against the tyrannical Capitol.', NULL);
INSERT INTO `mydb`.`bookseries` (`idbookseries`, `bookseries`, `publisher`, `description`, `classification`) VALUES (5, 'Flintstones', 'DC Comics', 'The Flintstones comic books follow the daily lives of the prehistoric Flintstone family and their neighbors in Bedrock, with humor, satire, and nostalgia.', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`book`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`book` (`idbook`, `bookname`, `publicationyear`, `description`, `idbookseries`, `seriesnumber`, `writer`) VALUES (1, 'Flintstones', 2000, 'Kuinka Retusta tuli Äiti', 5, NULL, NULL);
INSERT INTO `mydb`.`book` (`idbook`, `bookname`, `publicationyear`, `description`, `idbookseries`, `seriesnumber`, `writer`) VALUES (8, 'Harry Potter and the Philosopher’s Stone', 1997, NULL, 1, '1', 'J.K. Rowling');
INSERT INTO `mydb`.`book` (`idbook`, `bookname`, `publicationyear`, `description`, `idbookseries`, `seriesnumber`, `writer`) VALUES (9, 'Harry Potter and the Chamber of Secrets', 1998, NULL, 1, '2', 'J.K. Rowling');
INSERT INTO `mydb`.`book` (`idbook`, `bookname`, `publicationyear`, `description`, `idbookseries`, `seriesnumber`, `writer`) VALUES (10, 'Harry Potter and the Prisoner of Azkaban', 1999, NULL, 1, '3', 'J.K. Rowling');
INSERT INTO `mydb`.`book` (`idbook`, `bookname`, `publicationyear`, `description`, `idbookseries`, `seriesnumber`, `writer`) VALUES (11, 'Harry Potter and the Goblet of Fire', 2000, NULL, 1, '4', 'J.K. Rowling');
INSERT INTO `mydb`.`book` (`idbook`, `bookname`, `publicationyear`, `description`, `idbookseries`, `seriesnumber`, `writer`) VALUES (12, 'Harry Potter and the Order of the Phoenix', 2003, NULL, 1, '5', 'J.K. Rowling');
INSERT INTO `mydb`.`book` (`idbook`, `bookname`, `publicationyear`, `description`, `idbookseries`, `seriesnumber`, `writer`) VALUES (13, 'Harry Potter and the Half-Blood Prince', 2005, NULL, 1, '6', 'J.K. Rowling');
INSERT INTO `mydb`.`book` (`idbook`, `bookname`, `publicationyear`, `description`, `idbookseries`, `seriesnumber`, `writer`) VALUES (14, 'Harry Potter and the Deathly Hallows', 2007, NULL, 1, '7', 'J.K. Rowling');
INSERT INTO `mydb`.`book` (`idbook`, `bookname`, `publicationyear`, `description`, `idbookseries`, `seriesnumber`, `writer`) VALUES (15, 'The Fellowship of the Ring (TlotR, #1)', 1954, NULL, 2, '1', 'J.R.R. Tolkien');
INSERT INTO `mydb`.`book` (`idbook`, `bookname`, `publicationyear`, `description`, `idbookseries`, `seriesnumber`, `writer`) VALUES (16, 'The Two Towers (TlotR, #2)', 1954, NULL, 2, '2', 'J.R.R. Tolkien');
INSERT INTO `mydb`.`book` (`idbook`, `bookname`, `publicationyear`, `description`, `idbookseries`, `seriesnumber`, `writer`) VALUES (17, 'The Return of the King (TlotR, #3)', 1955, NULL, 2, '3', 'J.R.R. Tolkien');
INSERT INTO `mydb`.`book` (`idbook`, `bookname`, `publicationyear`, `description`, `idbookseries`, `seriesnumber`, `writer`) VALUES (18, 'A Game of Thrones (ASoIaF, #1)', 1996, NULL, 3, '1', 'George R.R. Martin');
INSERT INTO `mydb`.`book` (`idbook`, `bookname`, `publicationyear`, `description`, `idbookseries`, `seriesnumber`, `writer`) VALUES (19, 'A Clash of Kings (ASoIaF, #2)', 1998, NULL, 3, '2', 'George R.R. Martin');
INSERT INTO `mydb`.`book` (`idbook`, `bookname`, `publicationyear`, `description`, `idbookseries`, `seriesnumber`, `writer`) VALUES (20, ' 	A Storm of Swords (ASoIaF,#3) ', 2000, NULL, 3, '3', 'George R.R. Martin');
INSERT INTO `mydb`.`book` (`idbook`, `bookname`, `publicationyear`, `description`, `idbookseries`, `seriesnumber`, `writer`) VALUES (21, ' A Feast for Crows (ASoIaF, #4)', 2005, NULL, 3, '4', 'George R.R. Martin');
INSERT INTO `mydb`.`book` (`idbook`, `bookname`, `publicationyear`, `description`, `idbookseries`, `seriesnumber`, `writer`) VALUES (22, 'A Dance with Dragons (ASoIaF, #5)', 2011, NULL, 3, '5', 'George R.R. Martin');
INSERT INTO `mydb`.`book` (`idbook`, `bookname`, `publicationyear`, `description`, `idbookseries`, `seriesnumber`, `writer`) VALUES (23, 'The Hunger Games (THG, #1)', 2008, NULL, 4, '1', 'Suzanne Collins');
INSERT INTO `mydb`.`book` (`idbook`, `bookname`, `publicationyear`, `description`, `idbookseries`, `seriesnumber`, `writer`) VALUES (24, 'Catching Fire (THG, #2)', 2009, NULL, 4, '2', 'Suzanne Collins');
INSERT INTO `mydb`.`book` (`idbook`, `bookname`, `publicationyear`, `description`, `idbookseries`, `seriesnumber`, `writer`) VALUES (25, 'Mockingjay (THG, #3)', 2010, NULL, 4, '3', 'Suzanne Collins');
INSERT INTO `mydb`.`book` (`idbook`, `bookname`, `publicationyear`, `description`, `idbookseries`, `seriesnumber`, `writer`) VALUES (26, 'The Ballad of Songbirds and Snakes (THG, #0)', 2020, NULL, 4, '4', 'Suzanne Collins');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`picture`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (1, 'eka', 'Unknown', 'Unknown', 'Unkown', 'etu', ' https://upload.wikimedia.org/wikipedia/en/thumb/6/6b/Harry_Potter_and_the_Philosopher%27s_Stone_Book_Cover.jpg/220px-Harry_Potter_and_the_Philosopher%27s_Stone_Book_Cover.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (2, 'eka', 'Unknown', 'Unknown', 'Unkown', 'taka', ' https://m.media-amazon.com/images/I/71Y-5qRVUlL._AC_UF1000,1000_QL80_.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (3, 'toka', 'Unknown', 'Unknown', 'Unkown', 'etu', 'https://upload.wikimedia.org/wikipedia/en/thumb/5/5c/Harry_Potter_and_the_Chamber_of_Secrets.jpg/220px-Harry_Potter_and_the_Chamber_of_Secrets.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (4, 'toka', 'Unknown', 'Unknown', 'Unkown', 'taka', 'https://m.media-amazon.com/images/I/5191isFAtRL._AC_UF1000,1000_QL80_.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (5, 'kolmas', 'Unknown', 'Unknown', 'Unkown', 'etu', 'https://upload.wikimedia.org/wikipedia/en/thumb/a/a0/Harry_Potter_and_the_Prisoner_of_Azkaban.jpg/220px-Harry_Potter_and_the_Prisoner_of_Azkaban.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (6, 'kolmas', 'Unknown', 'Unknown', 'Unkown', 'taka', 'https://cdn01.sapnaonline.com/bk_images/676/9781408855676_1.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (7, 'neljas', 'Unknown', 'Unknown', 'Unkown', 'etu', 'https://upload.wikimedia.org/wikipedia/en/thumb/b/b6/Harry_Potter_and_the_Goblet_of_Fire_cover.png/220px-Harry_Potter_and_the_Goblet_of_Fire_cover.png');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (8, 'neljas', 'Unknown', 'Unknown', 'Unkown', 'taka', 'https://store.goodreads.lk/wp-content/uploads/2020/07/9781408855683-1.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (9, 'viides', 'Unknown', 'Unknown', 'Unkown', 'etu', 'https://upload.wikimedia.org/wikipedia/en/thumb/7/70/Harry_Potter_and_the_Order_of_the_Phoenix.jpg/220px-Harry_Potter_and_the_Order_of_the_Phoenix.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (10, 'viides', 'Unknown', 'Unknown', 'Unkown', 'taka', 'https://pictures.abebooks.com/inventory/15775901479_3.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (11, 'kuudes', 'Unknown', 'Unknown', 'Unkown', 'etu', 'https://upload.wikimedia.org/wikipedia/en/thumb/b/b5/Harry_Potter_and_the_Half-Blood_Prince_cover.png/220px-Harry_Potter_and_the_Half-Blood_Prince_cover.png');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (12, 'kuudes', 'Unknown', 'Unknown', 'Unkown', 'taka', 'https://prodimage.images-bn.com/pimages/9780439785969_p2_v1_s600x595.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (13, 'seiska', 'Unknown', 'Unknown', 'Unkown', 'etu', 'https://upload.wikimedia.org/wikipedia/en/thumb/a/a9/Harry_Potter_and_the_Deathly_Hallows.jpg/220px-Harry_Potter_and_the_Deathly_Hallows.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (14, 'seiska', 'Unknown', 'Unknown', 'Unkown', 'taka', 'https://store.goodreads.lk/wp-content/uploads/2020/07/9781408855713-1.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (15, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://upload.wikimedia.org/wikipedia/en/8/8e/The_Fellowship_of_the_Ring_cover.gif');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (16, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://www.tolkienguide.com/pictures/books/us-pb/brem-fotr-back.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (17, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://upload.wikimedia.org/wikipedia/en/thumb/a/a1/The_Two_Towers_cover.gif/220px-The_Two_Towers_cover.gif');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (18, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://www.tolkienguide.com/pictures/books/us-pb/brem-rotk-back.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (19, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://upload.wikimedia.org/wikipedia/en/thumb/1/11/The_Return_of_the_King_cover.gif/220px-The_Return_of_the_King_cover.gif');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (20, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://www.tolkienguide.com/pictures/books/us-pb/brem-rotk-back.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (21, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://upload.wikimedia.org/wikipedia/en/9/93/AGameOfThrones.jpg
');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (22, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://m.media-amazon.com/images/I/810h2BdHmsL._AC_UF1000,1000_QL80_.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (23, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://upload.wikimedia.org/wikipedia/en/3/39/AClashOfKings.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (24, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://m.media-amazon.com/images/I/81t6UAt6FqL._AC_UF1000,1000_QL80_.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (25, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://upload.wikimedia.org/wikipedia/en/thumb/2/24/AStormOfSwords.jpg/220px-AStormOfSwords.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (26, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://m.media-amazon.com/images/I/81jpOUts9lL._AC_UF1000,1000_QL80_.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (27, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://upload.wikimedia.org/wikipedia/en/thumb/a/a3/AFeastForCrows.jpg/220px-AFeastForCrows.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (28, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://m.media-amazon.com/images/I/719+3O6QpqL._AC_UF1000,1000_QL80_.jpg');

INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (29, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://upload.wikimedia.org/wikipedia/en/thumb/5/5d/A_Dance_With_Dragons_US.jpg/220px-A_Dance_With_Dragons_US.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (30, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://m.media-amazon.com/images/I/81MdAWD3vXL._AC_UF1000,1000_QL80_.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (31, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://upload.wikimedia.org/wikipedia/en/d/dc/The_Hunger_Games.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (32, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://m.media-amazon.com/images/I/51g34CC4whL._AC_UF350,350_QL80_.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (33, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://upload.wikimedia.org/wikipedia/en/thumb/a/a2/Catching_Fire_%28Suzanne_Collins_novel_-_cover_art%29.jpg/220px-Catching_Fire_%28Suzanne_Collins_novel_-_cover_art%29.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (34, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://m.media-amazon.com/images/I/71cLEuiVcnL._AC_UF1000,1000_QL80_.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (35, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Mockingjay.JPG/220px-Mockingjay.JPG');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (36, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://m.media-amazon.com/images/I/81WvnmPw4EL._AC_UF1000,1000_QL80_.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (37, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://m.media-amazon.com/images/I/61kMbMCmXIL._AC_UF1000,1000_QL80_.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (38, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://www.bookxcess.com/cdn/shop/products/9781338671162_2_1500x.jpg?v=1693880073');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (39, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://moog.antikvariaattimakedonia.fi/Images/manual/Kiviset%20ja%20Soraset%201965%2004%20001.jpg');
INSERT INTO `mydb`.`picture` (`idpicture`, `picturename`, `publicationyear`, `artist`, `style`, `description`, `filename`) VALUES (40, 'Unknown', 'Unknown', 'Unknown', 'Unkown', 'Unknown', 'https://moog.antikvariaattimakedonia.fi/Images/manual/Kiviset%20ja%20Soraset%201965%2004%20takakansi%20005.jpg');


COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`artwork`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (8, 1, 0);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (8, 2, 99999);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (9, 3, 0);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (9, 4, 99999);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (10, 5, 0);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (10, 6, 99999);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (11, 7, 0);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (11, 8, 99999);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (12, 9, 0);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (12, 10, 99999);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (13, 11, 0);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (13, 12, 99999);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (14, 13, 0);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (14, 14, 99999);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (15, 15, 0);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (15, 16, 99999);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (16, 17, 0);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (16, 18, 99999);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (17, 19, 0);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (17, 20, 99999);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (18, 21, 0);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (18, 22, 99999);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (19, 23, 0);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (19, 24, 99999);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (20, 25, 0);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (20, 26, 99999);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (21, 27, 0);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (21, 28, 99999);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (22, 29, 0);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (22, 30, 99999);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (23, 31, 0);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (23, 32, 99999);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (24, 33, 0);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (24, 34, 99999);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (25, 35, 0);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (25, 36, 99999);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (26, 37, 0);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (26, 38, 99999);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (1, 39, 0);
INSERT INTO `mydb`.`artwork` (`idbook`, `idpicture`, `pagenumber`) VALUES (1, 40, 99999);


COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`user` (`iduser`, `username`, `password`, `email`) VALUES (1, 'Matti.Mainio', 'Kissa', 'matti@email.com');
INSERT INTO `mydb`.`user` (`iduser`, `username`, `password`, `email`) VALUES (2, 'Liisa.Lisko', 'Kissa', 'liisa@email.com');
INSERT INTO `mydb`.`user` (`iduser`, `username`, `password`, `email`) VALUES (3, 'Jeppe.Teppo', 'Kissa', 'markku@email.com');
INSERT INTO `mydb`.`user` (`iduser`, `username`, `password`, `email`) VALUES (4, 'Markku.Miettinen', 'Kissa', 'markku@email.com');
INSERT INTO `mydb`.`user` (`iduser`, `username`, `password`, `email`) VALUES (5, 'Matias.Heikkinen', 'Kissa', 'matias@email.com');
INSERT INTO `mydb`.`user` (`iduser`, `username`, `password`, `email`) VALUES (6, 'Ari.Rantanen', 'Kissa', 'ari@email.com');
INSERT INTO `mydb`.`user` (`iduser`, `username`, `password`, `email`) VALUES (7, 'Antero.Ahonen', 'Kissa', 'antero@email.com');
INSERT INTO `mydb`.`user` (`iduser`, `username`, `password`, `email`) VALUES (8, 'Veikko.Rantanen', 'Kissa', 'veikko@email.com');
INSERT INTO `mydb`.`user` (`iduser`, `username`, `password`, `email`) VALUES (9, 'Kari.Leppänen', 'Kissa', 'kari@email.com');
INSERT INTO `mydb`.`user` (`iduser`, `username`, `password`, `email`) VALUES (10, 'Kalevi.Koskinen', 'Kissa', 'kalevi@email.com');
INSERT INTO `mydb`.`user` (`iduser`, `username`, `password`, `email`) VALUES (11, 'Jari.Koskinen', 'Kissa', 'jari@email.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`bookshelf`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`bookshelf` (`idbookshelf`, `iduser`, `owner`) VALUES (1, 1, 'Matti Mainio');
INSERT INTO `mydb`.`bookshelf` (`idbookshelf`, `iduser`, `owner`) VALUES (2, 2, 'Liisa Lisko');
INSERT INTO `mydb`.`bookshelf` (`idbookshelf`, `iduser`, `owner`) VALUES (3, 3, 'Jeppe Teppo');
INSERT INTO `mydb`.`bookshelf` (`idbookshelf`, `iduser`, `owner`) VALUES (4, 4, 'Markku Miettinen');
INSERT INTO `mydb`.`bookshelf` (`idbookshelf`, `iduser`, `owner`) VALUES (5, 5, 'Matias Heikkinen');
INSERT INTO `mydb`.`bookshelf` (`idbookshelf`, `iduser`, `owner`) VALUES (6, 6, 'Ari Rantanen');
INSERT INTO `mydb`.`bookshelf` (`idbookshelf`, `iduser`, `owner`) VALUES (7, 7, 'Antero Ahonen');
INSERT INTO `mydb`.`bookshelf` (`idbookshelf`, `iduser`, `owner`) VALUES (8, 6, 'Veikko Rantanen');
INSERT INTO `mydb`.`bookshelf` (`idbookshelf`, `iduser`, `owner`) VALUES (9, 9, 'Kari Leppänen');
INSERT INTO `mydb`.`bookshelf` (`idbookshelf`, `iduser`, `owner`) VALUES (10, 10, 'Kalevi Koskinen');
INSERT INTO `mydb`.`bookshelf` (`idbookshelf`, `iduser`, `owner`) VALUES (11, 11, 'Jari Koskinen');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`userseries`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`userseries` (`idbookseries`, `idbookshelf`) VALUES (1, 1);
INSERT INTO `mydb`.`userseries` (`idbookseries`, `idbookshelf`) VALUES (2, 2);
INSERT INTO `mydb`.`userseries` (`idbookseries`, `idbookshelf`) VALUES (3, 3);
INSERT INTO `mydb`.`userseries` (`idbookseries`, `idbookshelf`) VALUES (4, 4);
INSERT INTO `mydb`.`userseries` (`idbookseries`, `idbookshelf`) VALUES (5, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`bookcopy`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`bookcopy` (`idbookcopy`, `bookname`, `edition`, `publicationyear`, `idbook`, `purchaseprice`, `purchasedate`, `condition`, `description`, `solddate`, `soldprice`, `idbookseries`, `idbookshelf`) VALUES (1, '', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`photo`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`photo` (`idphoto`, `photoname`, `idbookcopy`, `pagenumber`) VALUES (1, 'roope.png', 1, 4);

COMMIT;