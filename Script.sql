-- CREATE запросы

create table if not exists Genres (
	genre_id serial primary key,
	genre_name varchar(125) not null
);

create table if not exists Artists (
	artist_id serial primary key,
	artist_name varchar(125) not null
); 

create table if not exists Albums (
	album_id serial primary key,
	album_name varchar(125) not null,
	release_year smallint not null
);

create table if not exists Tracks (
	track_id serial primary key,
	track_name varchar(125) not null,
	duration time not null,
	album_id integer references Albums(album_id)
);

create table if not exists Compilations (
	compilation_id serial primary key,
	compilation_name varchar(125) not null,
	release_year smallint not null
);

create table if not exists GenreArtist (
	genre_id integer references Genres(genre_id),
	artist_id integer references Artists(artist_id),
	constraint pk primary key (genre_id, artist_id)
);

create table if not exists ArtistAlbum (
	artist_id integer references Artists(artist_id),
	album_id integer references Albums(album_id),
	constraint pk1 primary key (artist_id, album_id)
);

create table if not exists CompilationsTracks (
	compilation_id integer references Compilations(compilation_id),
	track_id integer references Tracks(track_id),
	constraint pk2 primary key (compilation_id, track_id)
);

-- INSERT запросы

insert into Genres (genre_name)
values ('Indie'),
	   ('Rock'),
	   ('Metal'),
	   ('Hip-Hop'),
	   ('Hardcore');


insert into Artists (artist_name)
values ('OMNIXX'),
	   ('Asper X'),
	   ('Linkin Park'),
	   ('Get Scared'),
	   ('Norma Tale');

insert into GenreArtist
values (1, 1),
	   (2, 2),
	   (2, 3),
	   (2, 5),
	   (3, 3),
	   (4, 2),
	   (5, 4);

insert into Albums (album_name, release_year)
values ('Нонсенс', 2020),
	   ('The Dead Days', 2019),
	   ('Hybrid Theory', 2020),
	   ('R.', 2016);

insert into ArtistAlbum
values (1, 1),
	   (2, 4),
	   (3, 3),
	   (4, 2),
	   (5, 4);

insert into Tracks (track_name, duration, album_id)
values ('Зима', '00:03:37', 1),
	   ('Космос', '00:02:49', 1),
	   ('Абсент', '00:02:40', 4),
	   ('Эликсир', '00:02:22', 4),
	   ('Give Up My Ghost', '00:03:19', 2),
   	   ('Time Keeps Running', '00:03:14', 2),
	   ('In the End', '00:03:36', 3),
	   ('One Step Closer', '00:02:37', 3);

insert into Compilations (compilation_name, release_year) 
values ('Девочка с красными глазами', 2020),
	   ('Punk Goes 90s', 2014),
	   ('Reviviscence', 2020),
	   ('Нищета и свобода', 2020);

insert into CompilationsTracks 
values (1, 3),
	   (2, 5),
	   (2, 7),
	   (3, 8),
	   (4, 1),
	   (4, 2),
	   (4, 4);

--SELECT запросы

select track_name, duration from Tracks
where duration = (select max(duration) from Tracks)

select track_name from Tracks
where duration >= '00:03:30';

select compilation_name from compilations
where release_year between 2018 and 2020;

select artist_name from Artists 
where artist_name not like '% %';

select track_name from Tracks
where track_name like '%My%'
   or track_name like '%my%'
   or track_name like '%Мой%'
   or track_name like '%мой%';
  
select genre_id, count(distinct artist_id) from GenreArtist 
group by genre_id  
order by count(*);

select count(*) from Tracks
where album_id in (select album_id from Albums where release_year between 2019 and 2020);

select album_id, avg(duration) from Tracks
group by album_id
order by album_id;

select artist_name from Artists a
join ArtistAlbum a2 on a.artist_id = a2.artist_id
join Albums al on a2.album_id = al.album_id
where release_year != 2020;

select compilation_name from Compilations c
join compilationstracks ct on c.compilation_id = ct.compilation_id 
join tracks t on ct.track_id = t.track_id 
join albums a on t.album_id = a.album_id
join artistalbum a2 on a.album_id = a2.album_id
join artists art on a2.artist_id = art.artist_id 
where art.artist_name = 'Asper X';

