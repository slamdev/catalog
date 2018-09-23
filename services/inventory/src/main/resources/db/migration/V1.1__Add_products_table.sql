create table product
(
  id                 uuid         not null default gen_random_uuid() primary key,
  name               varchar(255) not null,
  description        text         not null,
  image_url           varchar(255) not null,
  created_date       timestamp    not null default now(),
  last_modified_date timestamp    not null default now()
);
