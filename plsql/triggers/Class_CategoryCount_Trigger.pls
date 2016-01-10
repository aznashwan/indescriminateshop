-- Class_CategoryCount_Trigger updates the CategoryCount of Classes if
-- an item has been added to it in the appropriate manner.
create or replace trigger Category_ItemCount_Trigger 
    after insert or update of ItemCount or delete on Category
for each row
declare
    cursor link_cur(cid number) is select * from CL2CA where CID = cid;
    cid Category.CID%TYPE;
begin
    -- get the CID we're working on:
    if deleting then
        cid := :old.CID;
    else
        cid := :new.CID;
    end if;

    for link in link_cur(cid) loop
        -- make sure the starting ItemCount is non-negative for starters:
        if (inserting and :new.ItemCount != 0) then
            update Class set CategoryCount = CategoryCount + 1
                where CLID = link.CLID;
        end if;

        -- else, if updating, check that the initial stock was non-zero when needed:
        if updating then
            if (:old.ItemCount = 0 and :new.ItemCount > 0) then
                update Class set CategoryCount = CategoryCount + 1
                    where CLID = link.CLID;
            elsif (:old.ItemCount > 0 and :new.ItemCount = 0) then
                update Class set CategoryCount = CategoryCount - 1
                    where CLID = link.CLID;
            end if;
        end if;

        if (deleting and :old.ItemCount != 0) then
                update Class set CategoryCount = CategoryCount - 1
                    where CLID = link.CLID;
        end if;
    end loop;
end;
