-- Item_Stock_Trigger updates the ItemCount of a Category if an item has been
-- added to it in the appropriate manner.
create or replace trigger Item_Stock_Trigger
    after insert or update of Stock or delete on Item
for each row
declare
begin
    -- make sure the starting Stock is non-negative for starters:
    if (inserting and :new.Stock != 0) then
        update Category set ItemCount = ItemCount + 1
            where Category.CID = :new.CID;
    end if;

    -- else, if updating, check that the initial stock was non-zero when needed:
    if updating then
        if (:old.Stock = 0 and :new.Stock > 0) then
            update Category
                set ItemCount = ItemCount + 1
                where Category.CID = :old.CID;
        elsif (:old.Stock > 0 and :new.Stock = 0) then
            update Category
                set ItemCount = ItemCount - 1
                where Category.CID = :old.CID;
        end if;
    end if;

    if (deleting and :old.Stock != 0) then
        update Category
            set ItemCount = ItemCount - 1
            where Category.CID = :old.CID;
    end if;
    commit;
end;
