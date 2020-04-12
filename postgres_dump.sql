-- -------------------------------------------------------------
-- TablePlus 2.10(268)
--
-- https://tableplus.com/
--
-- Database: gobarber
-- Generation Time: 2020-04-12 02:16:33.0670
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

DROP TABLE IF EXISTS "public"."SequelizeMeta";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."SequelizeMeta" (
    "name" varchar(255) NOT NULL,
    PRIMARY KEY ("name")
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

INSERT INTO "public"."appointments" ("id", "date", "user_id", "provider_id", "canceled_at", "created_at", "updated_at") VALUES ('1', '2020-04-16 21:00:00+00', '4', '3', NULL, '2020-04-12 04:05:35.716+00', '2020-04-12 04:05:35.716+00');

INSERT INTO "public"."files" ("id", "name", "path", "created_at", "updated_at") VALUES ('1', 'avatar-2020.jpg', '5ce58cc5718369014a6b5facdd84b715.jpg', '2020-04-11 21:53:50.904+00', '2020-04-11 21:53:50.904+00');

INSERT INTO "public"."SequelizeMeta" ("name") VALUES ('20190731105839-create-users.js'),
('20190802115148-create-files.js'),
('20190802121030-add-avatar-field-to-users.js'),
('20190810030258-create-appointments.js'),
('20200411155843-create-users.js');

INSERT INTO "public"."users" ("id", "name", "email", "password_hash", "provider", "created_at", "updated_at", "avatar_id") VALUES ('3', 'Adeonir', 'adeonir@gmail.com', '$2a$08$1q/4JrmUGR1GMQ1PlFn4BuENSzT.j.eT7Q3.Lx9okHQfgKkab/BG6', 't', '2020-04-11 20:24:54.155+00', '2020-04-12 00:15:40.513+00', '1'),
('4', 'Douglas', 'douglas@gmail.com', '$2a$08$qjPrUzibTNUCC6sOViwALe7KgeKBWvwS1EOQ0/XtTPLFMchof9qHO', 'f', '2020-04-12 04:03:24.348+00', '2020-04-12 04:03:24.348+00', NULL);

ALTER TABLE "public"."appointments" ADD FOREIGN KEY ("provider_id") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "public"."appointments" ADD FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "public"."users" ADD FOREIGN KEY ("avatar_id") REFERENCES "public"."files"("id") ON DELETE SET NULL ON UPDATE CASCADE;
