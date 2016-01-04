-- Clear_Class_Counts is a helper procedure which iterates over all the Classes
-- and sets their CategoryCount to 0.
create or update procedure Clear_Class_Counts is
    cursor class_cur is
        select CategoryCount from Class for update of CategoryCount;
    catcount Class.CategoryCount%TYPE;
begin
    open class_cur;

    loop
        fetch class_cur;
        exit when class_cur%NOTFOUND;

        class_cur.catcount = 0;
    end loop;

    close class_cur;
    commit;
end;

