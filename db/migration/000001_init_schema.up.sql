CREATE TABLE "users" (
  "username" varchar PRIMARY KEY,
  "hashed_password" varchar NOT NULL,
  "full_name" varchar NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "password_changed_at" timestamptz NOT NULL DEFAULT '0001-01-01 00:00:00Z',
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "portfolio" (
  "id" bigserial PRIMARY KEY,
  "photo" varchar,
  "aboutme" varchar
);

CREATE TABLE "links" (
  "id" bigserial PRIMARY KEY,
  "portfolio_id" bigint,
  "title" varchar NOT NULL,
  "url" varchar NOT NULL
);

CREATE TABLE "projects" (
  "id" bigserial PRIMARY KEY,
  "portfolio_id" bigint NOT NULL,
  "title" varchar NOT NULL,
  "start_date" timestamptz,
  "end_date" timestamptz
);

CREATE TABLE "skills" (
  "id" bigserial PRIMARY KEY,
  "portfolio_id" bigint NOT NULL,
  "title" varchar NOT NULL,
  "progress" varchar NOT NULL
);

CREATE INDEX ON "users" ("username");

CREATE INDEX ON "links" ("portfolio_id");

CREATE INDEX ON "projects" ("portfolio_id");

CREATE INDEX ON "skills" ("portfolio_id");

ALTER TABLE "links" ADD FOREIGN KEY ("portfolio_id") REFERENCES "portfolio" ("id");

ALTER TABLE "projects" ADD FOREIGN KEY ("portfolio_id") REFERENCES "portfolio" ("id");

ALTER TABLE "skills" ADD FOREIGN KEY ("portfolio_id") REFERENCES "portfolio" ("id");
