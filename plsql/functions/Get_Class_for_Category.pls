-- Get_Class_for_Category is a helper procedure which returns the CLID of the
-- Class corresponding to the the given CID.
create or update function Get_Class_for_Category(cid number) number is
    cursor link_cur is
        select * from CL2CA where CID = cid;
    clid Class.CLID%TYPE;
begin
    clid = -1;

    -- iterate through all the links to find the right one:
    for link in link_cur loop
        clid := link.CLID;
    end loop;

    return clid;
end;
