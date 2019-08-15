-- -------------------------------------------------------------
-- TablePlus 2.3(222)
--
-- https://tableplus.com/
--
-- Database: gobarber
-- Generation Time: 2019-08-14 22:19:41.7790
-- -------------------------------------------------------------


DROP TABLE IF EXISTS "public"."appointments";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS appointments_id_seq;

-- Table Definition
CREATE TABLE "public"."appointments" (
    "id" int4 NOT NULL DEFAULT nextval('appointments_id_seq'::regclass),
    "date" timestamptz NOT NULL,
    "user_id" int4,
    "provider_id" int4,
    "canceled_at" timestamptz,
    "created_at" timestamptz NOT NULL,
    "updated_at" timestamptz NOT NULL,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."files";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS files_id_seq;

-- Table Definition
CREATE TABLE "public"."files" (
    "id" int4 NOT NULL DEFAULT nextval('files_id_seq'::regclass),
    "name" varchar(255) NOT NULL,
    "path" varchar(255) NOT NULL,
    "created_at" timestamptz NOT NULL,
    "updated_at" timestamptz NOT NULL,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."users";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS users_id_seq;

-- Table Definition
CREATE TABLE "public"."users" (
    "id" int4 NOT NULL DEFAULT nextval('users_id_seq'::regclass),
    "name" varchar(255) NOT NULL,
    "email" varchar(255) NOT NULL,
    "password_hash" varchar(255) NOT NULL,
    "provider" bool NOT NULL DEFAULT false,
    "created_at" timestamptz NOT NULL,
    "updated_at" timestamptz NOT NULL,
    "avatar_id" int4,
    PRIMARY KEY ("id")
);

INSERT INTO "public"."appointments" ("id", "date", "user_id", "provider_id", "canceled_at", "created_at", "updated_at") VALUES ('18', '2019-08-16 14:00:00+00', '11', '11', NULL, '2019-08-15 00:29:57.363+00', '2019-08-15 00:29:57.363+00');

INSERT INTO "public"."files" ("id", "name", "path", "created_at", "updated_at") VALUES ('4', 'men-1.jpg', 'b212f33ed2b558b4fc3dcdd861dc6669.jpg', '2019-08-14 11:42:04.342+00', '2019-08-14 11:42:04.342+00'),
('5', 'man-2.jpg', '74a897fd662906e4cb3b88333dc0479b.jpg', '2019-08-14 11:42:13.135+00', '2019-08-14 11:42:13.135+00'),
('6', 'woman-1.jpg', '838a5268accb27a9bfa873200438f17b.jpg', '2019-08-14 11:42:19.366+00', '2019-08-14 11:42:19.366+00');

INSERT INTO "public"."users" ("id", "name", "email", "password_hash", "provider", "created_at", "updated_at", "avatar_id") VALUES ('9', 'Adeonir', 'adeonir@gmail.com', '$2a$08$DYtsvPNbeCfro/FDLpw5Z.5vZ4N04q2wZzNtqeVJezvRYaW8yFlQ2', 'f', '2019-08-14 11:33:49.455+00', '2019-08-14 11:33:49.455+00', '4'),
('10', 'Cassi', 'cassi@gmail.com', '$2a$08$DZ2sxRKstCiAFN80orHvqe.oRNVXINOqdi0chsWjZz.UOfhFhBcP.', 'f', '2019-08-14 11:33:59.791+00', '2019-08-14 11:33:59.791+00', '6'),
('11', 'Douglas', 'douglas@gmail.com', '$2a$08$33RmySsPW/sl2oxUl6UvIOaMYCj0e8pAR.Yy8PnTlXnOAyK/a/ZcW', 't', '2019-08-14 11:34:12.859+00', '2019-08-14 11:34:12.859+00', '5');

ALTER TABLE "public"."appointments" ADD FOREIGN KEY ("provider_id") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "public"."appointments" ADD FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "public"."users" ADD FOREIGN KEY ("avatar_id") REFERENCES "public"."files"("id") ON DELETE SET NULL ON UPDATE CASCADE;
