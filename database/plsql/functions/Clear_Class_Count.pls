-- Clear_Class_Counts is a helper procedure which iterates over all the Classes
-- and sets their CategoryCount to 0.
create or replace procedure Clear_Class_Counts is
    cursor class_cur is
        select * from Class;
    clsvar Class%ROWTYPE;
begin
    open class_cur;

    loop
        fetch class_cur into clsvar;
        exit when class_cur%NOTFOUND;

        update Class
          set CATEGORYCOUNT = 0
          where CLID = clsvar.CLID;
    end loop;

    close class_cur;
    commit;
end;
