
  CREATE OR REPLACE EDITIONABLE PROCEDURE "GENODB_MULTI"."TEST_LOAD" IS

    TYPE tbclob IS TABLE OF varchar2(2000);
    tblongline tbclob;

    file_clob clob ;
    l_file blob;
    l_loop number;
    -- test


  v_charset_id   INTEGER := DBMS_LOB.DEFAULT_CSID;  
  v_dest_offset  INTEGER := 1;
  v_src_offset   INTEGER := 1;
  v_lang_context INTEGER := DBMS_LOB.DEFAULT_LANG_CTX;
  v_warning      INTEGER := DBMS_LOB.WARN_INCONVERTIBLE_CHAR;


BEGIN

    DBMS_LOB.CREATETEMPORARY(file_clob, TRUE);
    DBMS_LOB.OPEN (file_clob, DBMS_LOB.LOB_READWRITE);


    for l_loop in 1..6 loop 
	SELECT LPAD(ani_id,10,0)||' '||LPAD('20241001',8,0)||' '||snps
	BULK COLLECT INTO tblongline
	FROM ani_predict ;

	FOR i IN tbLongLine.FIRST..tbLongLine.LAST LOOP    

	--file_clob := file_clob || tbLongLine(i) || '\n';
    DBMS_LOB.APPEND(file_clob, tbLongLine(i) || chr(10));

	END LOOP;  



    end loop;



  DBMS_LOB.CREATETEMPORARY(LOB_LOC => l_file, CACHE => FALSE);

  DBMS_LOB.CONVERTTOBLOB(dest_lob     => l_file,
                         src_clob     => file_clob,
                         amount       => DBMS_LOB.LOBMAXSIZE,
                         dest_offset  => v_dest_offset,
                         src_offset   => v_src_offset,
                         blob_csid    => v_charset_id,
                         lang_context => v_lang_context,
                         warning      => v_warning);


  dbms_cloud.put_object (
    credential_name => 'dbopstest_cred',
    object_uri      => 'https://swiftobjectstorage.eu-frankfurt-1.oraclecloud.com/v1/frcc7qi8dcas/dataintegration_bucket/clob.txt',
    contents        => l_file);

end;
/