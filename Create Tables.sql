CREATE TABLE movie (
    title       varchar(40)     NOT NULL,
    year        integer         NOT NULL,
    country     varchar(20)     NOT NULL,
    runtime     integer         NOT NULL,
    genre       varchar(10)     NOT NULL,
    CONSTRAINT pk_movie PRIMARY KEY (title, year)
);

CREATE TABLE person (
    id          integer         NOT NULL,
    first_name  varchar(15)     NOT NULL,
    last_name   varchar(15)     NOT NULL,
    year_born   integer,
    CONSTRAINT pk_person PRIMARY KEY (id)
);

CREATE TABLE actor (
    person_id   integer         NOT NULL,
    title       varchar(40)     NOT NULL,
    year        integer         NOT NULL,
    role        varchar(40)     NOT NULL,
    CONSTRAINT pk_actor PRIMARY KEY (person_id, title, year, role),
    CONSTRAINT fk_actor_person FOREIGN KEY (person_id) REFERENCES person (id),
    CONSTRAINT fk_actor_movie FOREIGN KEY (title, year) REFERENCES movie (title, year)
);

CREATE TABLE director (
    person_id   integer         NOT NULL,
    title       varchar(40)     NOT NULL,
    year        integer         NOT NULL,
    CONSTRAINT pk_director PRIMARY KEY (title, year),
    CONSTRAINT fk_director_person FOREIGN KEY (person_id) REFERENCES person (id),
    CONSTRAINT fk_director_movie FOREIGN KEY (title, year) REFERENCES movie (title, year)
);


-- final query
SELECT
    (SELECT count(*) FROM movie)    AS nr_movies,
    (SELECT count(*) FROM person)   AS nr_persons,
    (SELECT count(*) FROM actor)    AS nr_actors,
    (SELECT count(*) FROM director) AS nr_directors
;
