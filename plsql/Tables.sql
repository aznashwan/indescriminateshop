-- Item is the table representing an Item in out idescriminate shop.
create table Item (
    -- IID is the number ID of the Item.
    IID number(4) constraint Item_PK primary key,

    -- CID is the foreign key to the including Category.
    CID number(4) constraint Item2Category_FK references Category(CID),

    -- Name is the varchar name of the Item.
    Name varchar2(50) unique,

    -- Description is the description of the Item.
    Description varchar2(1000),

    -- Stock is the number of this Item in stock.
    Stock number(6) not null);


-- Category is the table representing a Category of items.
create table Category (
    -- CID is the number ID of the Category.
    CID number(4) constraint Category_PK primary key,

    -- Name is the unique varchar2 name of the Category.
    Name varchar2(20) unique,

    -- ItemCount is the number representing the types of items in the Category.
    -- NOTE: ItemCount is automatically managed by an insert trigger on Item.
    ItemCount number(4) not null constraint itemcount_const check(ItemCount >= 0));

-- CL2CA is just the table for linking Categories to Classes.
create table CL2CA (
    -- CLCAID is the number ID of the link.
    CLCAID number(4),

    -- CID is the foreign key to the ID of the involved Category.
    CID number(4) not null constraint CLCA2CA_FK references Category(CID)
        on delete cascade,

    -- CLID is the foreign key to the ID of the involved Class.
    CLID number(2) not null constraint CLCA2CL_FK references Class(CLID)
        on delete cascade);

-- Class is the table representing a class of similar sub-Categories.
create table Class (
    -- CLID is the number ID of the Class.
    CLID number(2) constraint Class_PK primary key,

    -- Name is the varchar2 name of the Class.
    Name varchar2(20) unique,

    -- CategoryCount is the number of categories within this Class.
    -- NOTE: CategoryCount is automatically managed by an insert trigger.
    CategoryCount number(4) not null constraint categorycount_constr check(CategoryCount >= 0));
