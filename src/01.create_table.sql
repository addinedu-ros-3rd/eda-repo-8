-- 지역

-- 타 테이블에서 region_id가 참조되는 것을 무시하고 region 테이블 삭제
SET foreign_key_checks = 0;

DROP TABLE IF EXISTS `ko_region` cascade;
create table ko_region(
    id int not null auto_increment,
    name varchar(8),  -- 서울특별시, 부산광역시, ...
    name_short varchar(4),  -- 서울, 부산, 충북, 충남, ...
    constraint pk_ko_region primary key(id),
    constraint uq_name_ko_region unique(name),
    constraint uq_name_short_ko_region unique(name_short)
);

-- FK 체크 원복
SET foreign_key_checks = 1;

-- 지역별 1인가구 통계
DROP TABLE IF EXISTS `home_single`;
create table home_single(
    id int not null auto_increment,
    region_id int,  -- 데이터 원본 지역명으로 ko_region 테이블에서 조회하여 가져온 id값
    region_name varchar(8) not null,  -- 데이터 원본에 명시된 지역명
    age varchar(8),  -- 원본 연령
    age_group int,  -- 분석을 위해 수치화한 연령대 값
    people_m int,
    people_f int,
    constraint pk_home_single primary key(id),
    constraint fk_home_single foreign key(region_id)  -- foreign key는 null값도 가능, insert시에는 null로
        references ko_region(id)
        on update cascade on delete cascade
    -- 지역 테이블에서 지역 수정/삭제 시 자동 반영
);

-- 지역별 가구주의 연령 + 가구원 수 통계
DROP TABLE IF EXISTS `home_age_and_members`;
create table home_age_and_members(
    id int not null auto_increment,
    region_id int,
    region_name varchar(8) not null,
    age varchar(8),  -- 원본 연령
    age_group int,  -- 분석을 위해 수치화한 연령대 값
    member_one int,
    member_two int,
    member_three int,
    member_four int,
    member_five int,
    member_six int,
    member_seven int,  -- 가구원수 7명 이상
    constraint pk_home_age_and_members primary key(id),
    constraint fk_home_age_and_members foreign key(region_id)
        references ko_region(id)
        on update cascade on delete cascade
);

-- 지역별 고령자가구 통계
DROP TABLE IF EXISTS `home_silver`;
create table home_silver(
    id int not null auto_increment,
    region_id int,
    region_name varchar(8) not null,
    all_silver int,  -- 가구원 모두 65세 이상  -- 아마 이 컬럼 값을 주로 사용하게 될 것
    mix_silver int,  -- 65세 이상 + 65세 미만
    no_silver int,  -- 65세 이상 가구원 없음
    constraint pk_home_silver primary key(id),
    constraint fk_home_silver foreign key(region_id)
        references ko_region(id)
        on update cascade on delete cascade
);

-- 지역별 거주환경 통계
DROP TABLE IF EXISTS `home_house`;
create table home_house(
    id int not null auto_increment,
    region_id int,
    region_name varchar(8) not null,
    dandok int,  -- 단독주택
    apart int,  -- 아파트
    yeonlip int,  -- 연립주택
    dasede int,  -- 다세대주택
    no_living int,  -- 비거주용 건물 내 주택(근린생활시설 등)
    no_house int,  -- 주택 이외의 거처
    constraint pk_home_house primary key(id),
    constraint fk_home_house foreign key(region_id)
        references ko_region(id)
        on update cascade on delete cascade
);

-- 지역별 세대구성 통계
DROP TABLE IF EXISTS `home_generation`;
create table home_generation(
    id int not null auto_increment,
    region_id int,
    region_name varchar(8) not null,
    one_gen int,
    two_gen int,
    three_gen int,
    more_than_four_gen int,
    single_home int,  -- 1인 가구
    no_blood int,  -- 비친족 가구
    constraint pk_home_generation primary key(id),
    constraint fk_home_generation foreign key(region_id)
        references ko_region(id)
        on update cascade on delete cascade
);

-- 지역별 생활폐기물 배출 통계
DROP TABLE IF EXISTS `trash`;
create table trash(
    id int not null auto_increment,
    region_id int,
    region_name varchar(8) not null,
    mix_recycle float,  -- 혼합배출 > 재활용
    mix_burn float,  -- 혼합배출 > 소각
    mix_bury float,  -- 혼합배출 > 매립
    mix_etc float,  -- 혼합배출 > 기타
    recycle_recycle float,  -- 분리배출 > 재활용
    recycle_burn float,  -- 분리배출 > 소각
    recycle_bury float,  -- 분리배출 > 매립
    recycle_etc float,  -- 분리배출 > 기타
    food_recycle float,  -- 음식물쓰레기 > 재활용
    food_burn float,  -- 음식물쓰레기 > 소각
    food_bury float,  -- 음식물쓰레기 > 매립
    food_etc float,  -- 음식물쓰레기 > 기타
    plastic float,
    paper float,
    constraint pk_trash primary key(id),
    constraint fk_trash foreign key(region_id)
        references ko_region(id)
        on update cascade on delete cascade
);

-- 지역별 화물 통계
DROP TABLE IF EXISTS `parcel`;
create table parcel(
    id int not null auto_increment,
    region_id int,
    region_name varchar(8) not null,
    parcel_sum int,
    constraint pk_parcel primary key(id),
    constraint fk_parcel foreign key(region_id)
        references ko_region(id)
        on update cascade on delete cascade  
);

-- 미성년자 자녀가 있는 가구 통계
DROP TABLE IF EXISTS `home_with_minor`;
create table home_with_minor(
    id int not null auto_increment,
    region_id int,
    region_name varchar(8) not null,
    numbers int,
    constraint pk_home_with_minor primary key(id),
    constraint fk_home_with_minor foreign key(region_id)
        references ko_region(id)
        on update cascade on delete cascade
);

-- 주거면적 통계
DROP TABLE IF EXISTS `home_space`;
create table home_space(
    id int not null auto_increment,
    region_id int,
    region_name varchar(8) not null,
    house_type varchar(16) not null,
    home_numbers int,
    family_numbers int,
    home_meters float,
    indiv_meters float,
    constraint pk_home_space primary key(id),
    constraint fk_home_space foreign key(region_id)
        references ko_region(id)
        on update cascade on delete cascade
);