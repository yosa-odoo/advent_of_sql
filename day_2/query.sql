select string_agg(chr(value), '') as wish
from (select * from letters_a union all select * from letters_b) as c
where CHR(value) SIMILAR TO '[a-zA-Z,.!?: ]';