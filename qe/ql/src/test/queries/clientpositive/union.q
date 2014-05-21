-- union case: both subqueries are map jobs on same input, followed by filesink

EXPLAIN FROM (  FROM src select src.key, src.value WHERE src.key < 100  UNION ALL  FROM src SELECT src.* WHERE src.key > 100) unioninput INSERT OVERWRITE DIRECTORY '../build/ql/test/data/warehouse/union.out' SELECT unioninput.*;

drop table union_sub_tmp;

create table union_sub_tmp as select * FROM (  FROM src select src.key, src.value WHERE src.key < 100  UNION ALL  FROM src SELECT src.* WHERE src.key > 100) unioninput ;

select * from union_sub_tmp order by key desc;

drop table union_sub_tmp;