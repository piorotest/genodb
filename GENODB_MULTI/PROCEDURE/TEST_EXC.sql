
  CREATE OR REPLACE EDITIONABLE PROCEDURE "GENODB_MULTI"."TEST_EXC" AS 
 a varchar2(1000);
 -- comment2222212121111111444444444444
 -- now 5

BEGIN
  UTIL_LOG.START_TRACE ( 'TEST_EXC', '', 2);  
  select dirname into a from jobs where dirname = 'asd';
  UTIL_LOG.STOP_TRACE;
  Exception when others then
    UTIL_LOG.ADD_LOG('TEST_EXC','i mamy exception-    buu '||SQLCODE||': '||SQLERRM);
    UTIL_LOG.STOP_TRACE;
    raise_application_error(-20001,'BUUUU 2 ' ||SQLCODE||': '||SQLERRM)  ;
END TEST_EXC;
/
