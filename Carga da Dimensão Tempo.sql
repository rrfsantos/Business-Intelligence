﻿create table dim_data (
sk_data integer not null,
nk_data date not null,
desc_data_completa varchar(60) not null,
nr_ano integer not null,
nm_trimestre varchar(20) not null,
nr_ano_trimestre varchar(20) not null,
nr_mes integer not null,
nm_mes varchar(20) not null,
ano_mes varchar(20) not null,
nr_semana integer not null,
ano_semana varchar(20) not null,
nr_dia integer not null,
nr_dia_ano integer not null,
nm_dia_semana varchar(20) not null,
flag_final_semana char(3) not null,
flag_feriado char(3) not null,
nm_feriado varchar(60) not null,
dt_carga timestamp not null,
constraint sk_data_pk primary key (sk_data)
);

insert into dim_data
select to_number(to_char(datum,'yyyymmdd'), '99999999') as sk_tempo,
datum as nk_data,
to_char(datum,'dd/mm/yyyy') as data_completa_formatada,
extract (year from datum) as nr_ano,
'T' || to_char(datum, 'q') as nm_trimestre,
to_char(datum, '"T"q/yyyy') as nr_ano_trimenstre,
extract(month from datum) as nr_mes,
to_char(datum, 'tmMonth') as nm_mes,
to_char(datum, 'yyyy/mm') as nr_ano_nr_mes,
extract(week from datum) as nr_semana,
to_char(datum, 'iyyy/iw') as nr_ano_nr_semana,
extract(day from datum) as nr_dia,
extract(doy from datum) as nr_dia_ano,
to_char(datum, 'tmDay') as nm_dia_semana,
case when extract(isodow from datum) in (6, 7) then 'Sim' else 'Não'
end as flag_final_semana,
case when to_char(datum, 'mmdd') in ('0101','1225') then 'Sim' else 'Não'
end as flag_feriado,
case when to_char(datum, 'mmdd') = '0101' then 'Ano Novo' 
when to_char(datum, 'mmdd') = '0421' then 'Tiradentes'
when to_char(datum, 'mmdd') = '0501' then 'Dia do Trabalhador'
when to_char(datum, 'mmdd') = '0907' then 'Dia da Pátria' 
when to_char(datum, 'mmdd') = '1012' then 'Nossa Senhora Aparecida' 
when to_char(datum, 'mmdd') = '1102' then 'Finados' 
when to_char(datum, 'mmdd') = '1115' then 'Proclamação da República'
when to_char(datum, 'mmdd') = '1225' then 'Natal' 
else 'Não é Feriado'

end as nm_feriado,
current_date as data_carga
from (
select '2015-01-01'::date + sequence.day as datum ---Insira a data inicial
from generate_series(0,7304) as sequence(day)     ---Cria 20 anos à frente
group by sequence.day
) dq
order by 1 desc;

select min(nk_data) as "data inicial", max(nk_data) as "data final"
from dim_data;

---Script by Prof. Anderson Nascimento vs. 2020.1

