SET QUOTED_IDENTIFIER ON

go

-- these are subscriber side procs
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


go

-- drop all the procedures first
if object_id('MSmerge_ins_sp_BB5C29C42300434E8D8B572FB3524CD3','P') is not NULL
    drop procedure MSmerge_ins_sp_BB5C29C42300434E8D8B572FB3524CD3
if object_id('MSmerge_ins_sp_BB5C29C42300434E8D8B572FB3524CD3_batch','P') is not NULL
    drop procedure MSmerge_ins_sp_BB5C29C42300434E8D8B572FB3524CD3_batch
if object_id('MSmerge_upd_sp_BB5C29C42300434E8D8B572FB3524CD3','P') is not NULL
    drop procedure MSmerge_upd_sp_BB5C29C42300434E8D8B572FB3524CD3
if object_id('MSmerge_upd_sp_BB5C29C42300434E8D8B572FB3524CD3_batch','P') is not NULL
    drop procedure MSmerge_upd_sp_BB5C29C42300434E8D8B572FB3524CD3_batch
if object_id('MSmerge_del_sp_BB5C29C42300434E8D8B572FB3524CD3','P') is not NULL
    drop procedure MSmerge_del_sp_BB5C29C42300434E8D8B572FB3524CD3
if object_id('MSmerge_sel_sp_BB5C29C42300434E8D8B572FB3524CD3','P') is not NULL
    drop procedure MSmerge_sel_sp_BB5C29C42300434E8D8B572FB3524CD3
if object_id('MSmerge_sel_sp_BB5C29C42300434E8D8B572FB3524CD3_metadata','P') is not NULL
    drop procedure MSmerge_sel_sp_BB5C29C42300434E8D8B572FB3524CD3_metadata
if object_id('MSmerge_cft_sp_BB5C29C42300434E8D8B572FB3524CD3','P') is not NULL
    drop procedure MSmerge_cft_sp_BB5C29C42300434E8D8B572FB3524CD3


go
create procedure dbo.[MSmerge_ins_sp_BB5C29C42300434E8D8B572FB3524CD3] (@rowguid uniqueidentifier, 
            @generation bigint, @lineage varbinary(311),  @colv varbinary(1) 
, 
        @p1 varchar(12)
, 
        @p2 nvarchar(50)
, 
        @p3 int
, 
        @p4 int
, 
        @p5 int
, 
        @p6 uniqueidentifier
,@metadata_type tinyint = NULL, @lineage_old varbinary(311) = NULL, @compatlevel int = 10 
) as
    declare @errcode    int
    declare @retcode    int
    declare @rowcount   int
    declare @error      int
    declare @tablenick  int
    declare @started_transaction bit
    declare @publication_number smallint
    
    set nocount on

    select @started_transaction = 0
    select @publication_number = 4

    set @errcode= 0
    select @tablenick= 31081000
    
    if ({ fn ISPALUSER('8D8B572F-B352-4CD3-9BF9-08911C828501') } <> 1)
    begin
        RAISERROR (14126, 11, -1)
        return 4
    end



    declare @resend int

    set @resend = 0 

    if @@trancount = 0 
    begin
        begin transaction
        select @started_transaction = 1
    end
    if @metadata_type = 1 or @metadata_type = 5
    begin
        if @compatlevel < 90 and @lineage_old is not null
            set @lineage_old= {fn LINEAGE_80_TO_90(@lineage_old)}
        -- check meta consistency
        if not exists (select * from dbo.MSmerge_tombstone where tablenick = @tablenick and rowguid = @rowguid and
                        lineage = @lineage_old)
        begin
            set @errcode= 2
-- DEBUG            insert into MSmerge_debug 
-- DEBUG                (okay, artnick, rowguid, type, successcode, generation_new, lineage_old, lineage_new, twhen, comment)
-- DEBUG                values (1, @tablenick, @rowguid, @metadata_type, @errcode, @generation, @lineage_old, @lineage, getdate(), 'sp_ins')
            goto Failure
        end
    end
    -- set row meta data
    
        exec @retcode= sys.sp_MSsetrowmetadata 
            @tablenick, @rowguid, @generation, 
            @lineage, @colv, 2, @resend OUTPUT,
            @compatlevel, 1, '8D8B572F-B352-4CD3-9BF9-08911C828501'
        if @retcode<>0 or @@ERROR<>0
        begin
            set @errcode= 0
            goto Failure
        end 
    insert into [dbo].[HOCPHI] (
[MASV]
, 
        [NIENKHOA]
, 
        [HOCKY]
, 
        [HOCPHI]
, 
        [SOTIENDADONG]
, 
        [rowguid]
) values (
@p1
, 
        @p2
, 
        @p3
, 
        @p4
, 
        @p5
, 
        @p6
)
        select @rowcount= @@rowcount, @error= @@error
        if (@rowcount <> 1)
        begin
            set @errcode= 3
            goto Failure
        end


    -- set row meta data
    if @resend > 0  
        update dbo.MSmerge_contents set generation = 0, partchangegen = 0 
            where rowguid = @rowguid and tablenick = @tablenick 

    if @started_transaction = 1
        commit tran
    

    delete from dbo.MSmerge_metadataaction_request
        where tablenick=@tablenick and rowguid=@rowguid

    -- DEBUG    insert into MSmerge_debug 
    -- DEBUG        (okay, artnick, rowguid, type, successcode, generation_new, lineage_old, lineage_new, twhen, comment) 
    -- DEBUG        values (0, @tablenick, @rowguid, @metadata_type, 1, @generation, @lineage_old, @lineage, getdate(), 'sp_ins, @resend=' + convert(nchar(1), @resend))

    return(1)

Failure:
    if @started_transaction = 1
        rollback tran
    -- DEBUG    insert into MSmerge_debug 
    -- DEBUG        (okay, artnick, rowguid, type, successcode, generation_new, lineage_old, lineage_new, twhen, comment) 
    -- DEBUG        values (1, @tablenick, @rowguid, @metadata_type, @errcode, @generation, @lineage_old, @lineage, getdate(), 'sp_ins, @resend=' + convert(nchar(1), @resend))

    


    declare @REPOLEExtErrorDupKey            int
    declare @REPOLEExtErrorDupUniqueIndex    int

    set @REPOLEExtErrorDupKey= 2627
    set @REPOLEExtErrorDupUniqueIndex= 2601
    
    if @error in (@REPOLEExtErrorDupUniqueIndex, @REPOLEExtErrorDupKey)
    begin
        update mc
            set mc.generation= 0
            from dbo.MSmerge_contents mc join [dbo].[HOCPHI] t on mc.rowguid=t.rowguidcol
            where
                mc.tablenick = 31081000 and
                (

                        (t.[MASV]=@p1 and t.[NIENKHOA]=@p2 and t.[HOCKY]=@p3)

                        )
            end

    return(@errcode)
    

go
Create procedure dbo.[MSmerge_upd_sp_BB5C29C42300434E8D8B572FB3524CD3] (@rowguid uniqueidentifier, @setbm varbinary(125) = NULL,
        @metadata_type tinyint, @lineage_old varbinary(311), @generation bigint,
        @lineage_new varbinary(311), @colv varbinary(1) 
,
        @p1 varchar(12) = NULL 
,
        @p2 nvarchar(50) = NULL 
,
        @p3 int = NULL 
,
        @p4 int = NULL 
,
        @p5 int = NULL 
,
        @p6 uniqueidentifier = NULL 
, @compatlevel int = 10 
)
as
    declare @match int 

    declare @fset int
    declare @errcode int
    declare @retcode smallint
    declare @rowcount int
    declare @error int
    declare @hasperm bit
    declare @tablenick int
    declare @started_transaction bit
    declare @indexing_column_updated bit
    declare @publication_number smallint

    set nocount on

    if ({ fn ISPALUSER('8D8B572F-B352-4CD3-9BF9-08911C828501') } <> 1)
    begin
        RAISERROR (14126, 11, -1)
        return 4
    end

    select @started_transaction = 0
    select @publication_number = 4
    select @tablenick = 31081000

    if is_member('db_owner') = 1
        select @hasperm = 1
    else
        select @hasperm = 0

    select @indexing_column_updated = 0

    declare @l1 varchar(12)

    declare @l2 nvarchar(50)

    declare @iscol2set bit

    declare @l3 int

    declare @iscol3set bit

    if @@trancount = 0
    begin
        begin transaction sub
        select @started_transaction = 1
    end


    select 

        @l1 = [MASV]
, 
        @l2 = [NIENKHOA]
, 
        @l3 = [HOCKY]
        from [dbo].[HOCPHI] where rowguidcol = @rowguid
    set @match = NULL

       
    declare @firstUpdStmtCol bit
    declare @nUpdateCols int
    declare @updatestmt nvarchar(4000) 
    
    select @firstUpdStmtCol = 1
    select @nUpdateCols = 0
    select @updatestmt = 'update ' + '[dbo].[HOCPHI]' + ' set '
            

    if convert(varbinary(12), @p1)
            = convert(varbinary(12), @l1)
        set @fset = 0
    else if ( @l1 is null and @p1 is null) 
        set @fset = 0
    else if @p1 is not null
        set @fset = 1
    else if @setbm = 0x0
        set @fset = 0
    else
        exec @fset = sys.sp_MStestbit @setbm, 1
    if @fset <> 0
    begin

        if @match is NULL
        begin
            if @metadata_type = 3
            begin
                update [dbo].[HOCPHI] set [MASV] = @p1 
                from [dbo].[HOCPHI] t 
                where t.[rowguid] = @rowguid and
                   not exists (select 1 from dbo.MSmerge_contents c with (rowlock)
                                where c.rowguid = @rowguid and 
                                      c.tablenick = 31081000)
            end
            else if @metadata_type = 2
            begin
                update [dbo].[HOCPHI] set [MASV] = @p1 
                from [dbo].[HOCPHI] t 
                where t.[rowguid] = @rowguid and
                      exists (select 1 from dbo.MSmerge_contents c with (rowlock)
                                where c.rowguid = @rowguid and 
                                      c.tablenick = 31081000 and
                                      c.lineage = @lineage_old)
            end
            else
            begin
                set @errcode=2
                goto Failure
            end
        end
        else
        begin
            update [dbo].[HOCPHI] set [MASV] = @p1 
                where rowguidcol = @rowguid
        end
        select @rowcount= @@rowcount, @error= @@error
        if (@rowcount <> 1)
        begin
            set @errcode= 3
            goto Failure
        end
        select @match = 1
    end 

    if convert(varbinary(100), @p2)
            = convert(varbinary(100), @l2)
        set @fset = 0
    else if ( @l2 is null and @p2 is null) 
        set @fset = 0
    else if @p2 is not null
        set @fset = 1
    else if @setbm = 0x0
        set @fset = 0
    else
        exec @fset = sys.sp_MStestbit @setbm, 2
    if @fset <> 0
    begin

        select @indexing_column_updated = 1
        select @iscol2set = 1
        if @firstUpdStmtCol = 1
            select @firstUpdStmtCol = 0
        else
            select @updatestmt = @updatestmt + ','
        select @updatestmt = @updatestmt + '[NIENKHOA] = @p2'
        select @nUpdateCols = @nUpdateCols + 1
    end
    else
    begin
        select @iscol2set = 0
    end

    if @p3 = @l3
        set @fset = 0
    else if ( @l3 is null and @p3 is null) 
        set @fset = 0
    else if @p3 is not null
        set @fset = 1
    else if @setbm = 0x0
        set @fset = 0
    else
        exec @fset = sys.sp_MStestbit @setbm, 3
    if @fset <> 0
    begin

        select @indexing_column_updated = 1
        select @iscol3set = 1
        if @firstUpdStmtCol = 1
            select @firstUpdStmtCol = 0
        else
            select @updatestmt = @updatestmt + ','
        select @updatestmt = @updatestmt + '[HOCKY] = @p3'
        select @nUpdateCols = @nUpdateCols + 1
    end
    else
    begin
        select @iscol3set = 0
    end

    if @indexing_column_updated = 1
    begin
        if @hasperm = 0
        begin
            update [dbo].[HOCPHI] set 

                [NIENKHOA] = case @iscol2set when 1 then @p2 else t.[NIENKHOA] end
,
                [HOCKY] = case @iscol3set when 1 then @p3 else t.[HOCKY] end
 
             from [dbo].[HOCPHI] t 
                left outer join dbo.MSmerge_contents c with (rowlock)
                    on c.rowguid = t.[rowguid] and 
                       c.tablenick = 31081000 and
                       t.[rowguid] = @rowguid
             where t.[rowguid] = @rowguid and
             ((@match is not NULL and @match = 1) or 
              ((@metadata_type = 3 and c.rowguid is NULL) or
               (@metadata_type = 2 and c.rowguid is not NULL and c.lineage = @lineage_old)))

            select @rowcount= @@rowcount, @error= @@error

        end
        else -- we can do sp_executesql since the current user has permissions to update the table
        begin 
            if @match is NULL
            begin
                if @metadata_type = 3
                begin
                    select @updatestmt = @updatestmt + '
                       from [dbo].[HOCPHI] t 
                       where t.[rowguid] = @rowguid and
                             not exists (select 1 from dbo.MSmerge_contents c with (rowlock)
                                         where c.rowguid = @rowguid and 
                                               c.tablenick = 31081000)'
                end
                else if @metadata_type = 2
                begin
                    select @updatestmt = @updatestmt + '
                       from [dbo].[HOCPHI] t 
                       where t.[rowguid] = @rowguid and
                             exists (select 1 from dbo.MSmerge_contents c with (rowlock)
                                     where c.rowguid = @rowguid and 
                                           c.tablenick = 31081000 and
                                           c.lineage = @lineage_old)'
                end
            end
            else
            begin
                select @updatestmt = @updatestmt + '
                    where rowguidcol = @rowguid '
            end
            select @updatestmt = @updatestmt + '
                select @rowcount = @@rowcount, @error = @@error'
            exec sys.sp_executesql @stmt = @updatestmt, @parameters = N'

                    @p2 nvarchar(50)
,

                    @p3 int
, @rowguid uniqueidentifier = ''00000000-0000-0000-0000-000000000000'', @lineage_old varbinary(311), @rowcount int output, @error int output',

                    @p2 = @p2
,

                    @p3 = @p3

                    , @rowguid = @rowguid, @lineage_old = @lineage_old, @rowcount = @rowcount OUTPUT, @error = @error OUTPUT 
        end  -- end if @hasperm
        if (@rowcount <> 1)
        begin
            set @errcode= 3
            goto Failure
        end    
        select @match = 1    
    end -- end if @indexing_column_updated 

    if @match is NULL
    begin
        update [dbo].[HOCPHI] set 

            [HOCPHI] = case when @p4 is NULL then (case when sys.fn_IsBitSetInBitmask(@setbm, 4) <> 0 then @p4 else t.[HOCPHI] end) else @p4 end 
,

            [SOTIENDADONG] = case when @p5 is NULL then (case when sys.fn_IsBitSetInBitmask(@setbm, 5) <> 0 then @p5 else t.[SOTIENDADONG] end) else @p5 end 
 
         from [dbo].[HOCPHI] t 
            left outer join dbo.MSmerge_contents c with (rowlock)
                on c.rowguid = t.[rowguid] and 
                   c.tablenick = 31081000 and
                   t.[rowguid] = @rowguid
         where t.[rowguid] = @rowguid and
         ((@match is not NULL and @match = 1) or 
          ((@metadata_type = 3 and c.rowguid is NULL) or
           (@metadata_type = 2 and c.rowguid is not NULL and c.lineage = @lineage_old)))

        select @rowcount= @@rowcount, @error= @@error
    end
    else
    begin
        update [dbo].[HOCPHI] set 

            [HOCPHI] = case when @p4 is NULL then (case when sys.fn_IsBitSetInBitmask(@setbm, 4) <> 0 then @p4 else t.[HOCPHI] end) else @p4 end 
,

            [SOTIENDADONG] = case when @p5 is NULL then (case when sys.fn_IsBitSetInBitmask(@setbm, 5) <> 0 then @p5 else t.[SOTIENDADONG] end) else @p5 end 
 
         from [dbo].[HOCPHI] t 
             where t.[rowguid] = @rowguid

        select @rowcount= @@rowcount, @error= @@error
    end

    if (@rowcount <> 1) or (@error <> 0)
    begin
        set @errcode= 3
        goto Failure
    end

    select @match = 1
 
    exec @retcode= sys.sp_MSsetrowmetadata 
        @tablenick, @rowguid, @generation, 
        @lineage_new, @colv, 2, NULL, 
        @compatlevel, 0, '8D8B572F-B352-4CD3-9BF9-08911C828501'
    if @retcode<>0 or @@ERROR<>0
    begin
        set @errcode= 3
        goto Failure
    end 

delete from dbo.MSmerge_metadataaction_request
    where tablenick=@tablenick and rowguid=@rowguid

    if @started_transaction = 1
        commit transaction

-- DEBUG    insert into MSmerge_debug 
-- DEBUG        (okay, artnick, rowguid, type, successcode, generation_new, lineage_old, lineage_new, twhen, comment)
-- DEBUG        values (0, @tablenick, @rowguid, @metadata_type, 1, @generation, @lineage_old, @lineage_new, getdate(), 'sp_upd')

    return(1)

Failure:
    --rollback transaction sub
    --commit transaction
    if @started_transaction = 1    
        rollback transaction
-- DEBUG    insert into MSmerge_debug 
-- DEBUG        (okay, artnick, rowguid, type, successcode, generation_new, lineage_old, lineage_new, twhen, comment)
-- DEBUG        values (1, @tablenick, @rowguid, @metadata_type, @errcode, @generation, @lineage_old, @lineage_new, getdate(), 'sp_upd')




    declare @REPOLEExtErrorDupKey            int
    declare @REPOLEExtErrorDupUniqueIndex    int

    set @REPOLEExtErrorDupKey= 2627
    set @REPOLEExtErrorDupUniqueIndex= 2601
    
    if @error in (@REPOLEExtErrorDupUniqueIndex, @REPOLEExtErrorDupKey)
    begin
        update mc
            set mc.generation= 0
            from dbo.MSmerge_contents mc join [dbo].[HOCPHI] t on mc.rowguid=t.rowguidcol
            where
                mc.tablenick = 31081000 and
                (

                        (t.[MASV]=@p1 and t.[NIENKHOA]=@p2 and t.[HOCKY]=@p3)

                        )
            end

    return @errcode

go

create procedure dbo.[MSmerge_del_sp_BB5C29C42300434E8D8B572FB3524CD3]
(
    @rowstobedeleted int, 
    @partition_id int = NULL 
,
    @rowguid1 uniqueidentifier = NULL,
    @metadata_type1 tinyint = NULL,
    @generation1 bigint = NULL,
    @lineage_old1 varbinary(311) = NULL,
    @lineage_new1 varbinary(311) = NULL,
    @rowguid2 uniqueidentifier = NULL,
    @metadata_type2 tinyint = NULL,
    @generation2 bigint = NULL,
    @lineage_old2 varbinary(311) = NULL,
    @lineage_new2 varbinary(311) = NULL,
    @rowguid3 uniqueidentifier = NULL,
    @metadata_type3 tinyint = NULL,
    @generation3 bigint = NULL,
    @lineage_old3 varbinary(311) = NULL,
    @lineage_new3 varbinary(311) = NULL,
    @rowguid4 uniqueidentifier = NULL,
    @metadata_type4 tinyint = NULL,
    @generation4 bigint = NULL,
    @lineage_old4 varbinary(311) = NULL,
    @lineage_new4 varbinary(311) = NULL,
    @rowguid5 uniqueidentifier = NULL,
    @metadata_type5 tinyint = NULL,
    @generation5 bigint = NULL,
    @lineage_old5 varbinary(311) = NULL,
    @lineage_new5 varbinary(311) = NULL,
    @rowguid6 uniqueidentifier = NULL,
    @metadata_type6 tinyint = NULL,
    @generation6 bigint = NULL,
    @lineage_old6 varbinary(311) = NULL,
    @lineage_new6 varbinary(311) = NULL,
    @rowguid7 uniqueidentifier = NULL,
    @metadata_type7 tinyint = NULL,
    @generation7 bigint = NULL,
    @lineage_old7 varbinary(311) = NULL,
    @lineage_new7 varbinary(311) = NULL,
    @rowguid8 uniqueidentifier = NULL,
    @metadata_type8 tinyint = NULL,
    @generation8 bigint = NULL,
    @lineage_old8 varbinary(311) = NULL,
    @lineage_new8 varbinary(311) = NULL,
    @rowguid9 uniqueidentifier = NULL,
    @metadata_type9 tinyint = NULL,
    @generation9 bigint = NULL,
    @lineage_old9 varbinary(311) = NULL,
    @lineage_new9 varbinary(311) = NULL,
    @rowguid10 uniqueidentifier = NULL,
    @metadata_type10 tinyint = NULL,
    @generation10 bigint = NULL,
    @lineage_old10 varbinary(311) = NULL,
    @lineage_new10 varbinary(311) = NULL
,
    @rowguid11 uniqueidentifier = NULL,
    @metadata_type11 tinyint = NULL,
    @generation11 bigint = NULL,
    @lineage_old11 varbinary(311) = NULL,
    @lineage_new11 varbinary(311) = NULL,
    @rowguid12 uniqueidentifier = NULL,
    @metadata_type12 tinyint = NULL,
    @generation12 bigint = NULL,
    @lineage_old12 varbinary(311) = NULL,
    @lineage_new12 varbinary(311) = NULL,
    @rowguid13 uniqueidentifier = NULL,
    @metadata_type13 tinyint = NULL,
    @generation13 bigint = NULL,
    @lineage_old13 varbinary(311) = NULL,
    @lineage_new13 varbinary(311) = NULL,
    @rowguid14 uniqueidentifier = NULL,
    @metadata_type14 tinyint = NULL,
    @generation14 bigint = NULL,
    @lineage_old14 varbinary(311) = NULL,
    @lineage_new14 varbinary(311) = NULL,
    @rowguid15 uniqueidentifier = NULL,
    @metadata_type15 tinyint = NULL,
    @generation15 bigint = NULL,
    @lineage_old15 varbinary(311) = NULL,
    @lineage_new15 varbinary(311) = NULL,
    @rowguid16 uniqueidentifier = NULL,
    @metadata_type16 tinyint = NULL,
    @generation16 bigint = NULL,
    @lineage_old16 varbinary(311) = NULL,
    @lineage_new16 varbinary(311) = NULL,
    @rowguid17 uniqueidentifier = NULL,
    @metadata_type17 tinyint = NULL,
    @generation17 bigint = NULL,
    @lineage_old17 varbinary(311) = NULL,
    @lineage_new17 varbinary(311) = NULL,
    @rowguid18 uniqueidentifier = NULL,
    @metadata_type18 tinyint = NULL,
    @generation18 bigint = NULL,
    @lineage_old18 varbinary(311) = NULL,
    @lineage_new18 varbinary(311) = NULL,
    @rowguid19 uniqueidentifier = NULL,
    @metadata_type19 tinyint = NULL,
    @generation19 bigint = NULL,
    @lineage_old19 varbinary(311) = NULL,
    @lineage_new19 varbinary(311) = NULL,
    @rowguid20 uniqueidentifier = NULL,
    @metadata_type20 tinyint = NULL,
    @generation20 bigint = NULL,
    @lineage_old20 varbinary(311) = NULL,
    @lineage_new20 varbinary(311) = NULL
,
    @rowguid21 uniqueidentifier = NULL,
    @metadata_type21 tinyint = NULL,
    @generation21 bigint = NULL,
    @lineage_old21 varbinary(311) = NULL,
    @lineage_new21 varbinary(311) = NULL,
    @rowguid22 uniqueidentifier = NULL,
    @metadata_type22 tinyint = NULL,
    @generation22 bigint = NULL,
    @lineage_old22 varbinary(311) = NULL,
    @lineage_new22 varbinary(311) = NULL,
    @rowguid23 uniqueidentifier = NULL,
    @metadata_type23 tinyint = NULL,
    @generation23 bigint = NULL,
    @lineage_old23 varbinary(311) = NULL,
    @lineage_new23 varbinary(311) = NULL,
    @rowguid24 uniqueidentifier = NULL,
    @metadata_type24 tinyint = NULL,
    @generation24 bigint = NULL,
    @lineage_old24 varbinary(311) = NULL,
    @lineage_new24 varbinary(311) = NULL,
    @rowguid25 uniqueidentifier = NULL,
    @metadata_type25 tinyint = NULL,
    @generation25 bigint = NULL,
    @lineage_old25 varbinary(311) = NULL,
    @lineage_new25 varbinary(311) = NULL,
    @rowguid26 uniqueidentifier = NULL,
    @metadata_type26 tinyint = NULL,
    @generation26 bigint = NULL,
    @lineage_old26 varbinary(311) = NULL,
    @lineage_new26 varbinary(311) = NULL,
    @rowguid27 uniqueidentifier = NULL,
    @metadata_type27 tinyint = NULL,
    @generation27 bigint = NULL,
    @lineage_old27 varbinary(311) = NULL,
    @lineage_new27 varbinary(311) = NULL,
    @rowguid28 uniqueidentifier = NULL,
    @metadata_type28 tinyint = NULL,
    @generation28 bigint = NULL,
    @lineage_old28 varbinary(311) = NULL,
    @lineage_new28 varbinary(311) = NULL,
    @rowguid29 uniqueidentifier = NULL,
    @metadata_type29 tinyint = NULL,
    @generation29 bigint = NULL,
    @lineage_old29 varbinary(311) = NULL,
    @lineage_new29 varbinary(311) = NULL,
    @rowguid30 uniqueidentifier = NULL,
    @metadata_type30 tinyint = NULL,
    @generation30 bigint = NULL,
    @lineage_old30 varbinary(311) = NULL,
    @lineage_new30 varbinary(311) = NULL
,
    @rowguid31 uniqueidentifier = NULL,
    @metadata_type31 tinyint = NULL,
    @generation31 bigint = NULL,
    @lineage_old31 varbinary(311) = NULL,
    @lineage_new31 varbinary(311) = NULL,
    @rowguid32 uniqueidentifier = NULL,
    @metadata_type32 tinyint = NULL,
    @generation32 bigint = NULL,
    @lineage_old32 varbinary(311) = NULL,
    @lineage_new32 varbinary(311) = NULL,
    @rowguid33 uniqueidentifier = NULL,
    @metadata_type33 tinyint = NULL,
    @generation33 bigint = NULL,
    @lineage_old33 varbinary(311) = NULL,
    @lineage_new33 varbinary(311) = NULL,
    @rowguid34 uniqueidentifier = NULL,
    @metadata_type34 tinyint = NULL,
    @generation34 bigint = NULL,
    @lineage_old34 varbinary(311) = NULL,
    @lineage_new34 varbinary(311) = NULL,
    @rowguid35 uniqueidentifier = NULL,
    @metadata_type35 tinyint = NULL,
    @generation35 bigint = NULL,
    @lineage_old35 varbinary(311) = NULL,
    @lineage_new35 varbinary(311) = NULL,
    @rowguid36 uniqueidentifier = NULL,
    @metadata_type36 tinyint = NULL,
    @generation36 bigint = NULL,
    @lineage_old36 varbinary(311) = NULL,
    @lineage_new36 varbinary(311) = NULL,
    @rowguid37 uniqueidentifier = NULL,
    @metadata_type37 tinyint = NULL,
    @generation37 bigint = NULL,
    @lineage_old37 varbinary(311) = NULL,
    @lineage_new37 varbinary(311) = NULL,
    @rowguid38 uniqueidentifier = NULL,
    @metadata_type38 tinyint = NULL,
    @generation38 bigint = NULL,
    @lineage_old38 varbinary(311) = NULL,
    @lineage_new38 varbinary(311) = NULL,
    @rowguid39 uniqueidentifier = NULL,
    @metadata_type39 tinyint = NULL,
    @generation39 bigint = NULL,
    @lineage_old39 varbinary(311) = NULL,
    @lineage_new39 varbinary(311) = NULL,
    @rowguid40 uniqueidentifier = NULL,
    @metadata_type40 tinyint = NULL,
    @generation40 bigint = NULL,
    @lineage_old40 varbinary(311) = NULL,
    @lineage_new40 varbinary(311) = NULL
,
    @rowguid41 uniqueidentifier = NULL,
    @metadata_type41 tinyint = NULL,
    @generation41 bigint = NULL,
    @lineage_old41 varbinary(311) = NULL,
    @lineage_new41 varbinary(311) = NULL,
    @rowguid42 uniqueidentifier = NULL,
    @metadata_type42 tinyint = NULL,
    @generation42 bigint = NULL,
    @lineage_old42 varbinary(311) = NULL,
    @lineage_new42 varbinary(311) = NULL,
    @rowguid43 uniqueidentifier = NULL,
    @metadata_type43 tinyint = NULL,
    @generation43 bigint = NULL,
    @lineage_old43 varbinary(311) = NULL,
    @lineage_new43 varbinary(311) = NULL,
    @rowguid44 uniqueidentifier = NULL,
    @metadata_type44 tinyint = NULL,
    @generation44 bigint = NULL,
    @lineage_old44 varbinary(311) = NULL,
    @lineage_new44 varbinary(311) = NULL,
    @rowguid45 uniqueidentifier = NULL,
    @metadata_type45 tinyint = NULL,
    @generation45 bigint = NULL,
    @lineage_old45 varbinary(311) = NULL,
    @lineage_new45 varbinary(311) = NULL,
    @rowguid46 uniqueidentifier = NULL,
    @metadata_type46 tinyint = NULL,
    @generation46 bigint = NULL,
    @lineage_old46 varbinary(311) = NULL,
    @lineage_new46 varbinary(311) = NULL,
    @rowguid47 uniqueidentifier = NULL,
    @metadata_type47 tinyint = NULL,
    @generation47 bigint = NULL,
    @lineage_old47 varbinary(311) = NULL,
    @lineage_new47 varbinary(311) = NULL,
    @rowguid48 uniqueidentifier = NULL,
    @metadata_type48 tinyint = NULL,
    @generation48 bigint = NULL,
    @lineage_old48 varbinary(311) = NULL,
    @lineage_new48 varbinary(311) = NULL,
    @rowguid49 uniqueidentifier = NULL,
    @metadata_type49 tinyint = NULL,
    @generation49 bigint = NULL,
    @lineage_old49 varbinary(311) = NULL,
    @lineage_new49 varbinary(311) = NULL,
    @rowguid50 uniqueidentifier = NULL,
    @metadata_type50 tinyint = NULL,
    @generation50 bigint = NULL,
    @lineage_old50 varbinary(311) = NULL,
    @lineage_new50 varbinary(311) = NULL
,
    @rowguid51 uniqueidentifier = NULL,
    @metadata_type51 tinyint = NULL,
    @generation51 bigint = NULL,
    @lineage_old51 varbinary(311) = NULL,
    @lineage_new51 varbinary(311) = NULL,
    @rowguid52 uniqueidentifier = NULL,
    @metadata_type52 tinyint = NULL,
    @generation52 bigint = NULL,
    @lineage_old52 varbinary(311) = NULL,
    @lineage_new52 varbinary(311) = NULL,
    @rowguid53 uniqueidentifier = NULL,
    @metadata_type53 tinyint = NULL,
    @generation53 bigint = NULL,
    @lineage_old53 varbinary(311) = NULL,
    @lineage_new53 varbinary(311) = NULL,
    @rowguid54 uniqueidentifier = NULL,
    @metadata_type54 tinyint = NULL,
    @generation54 bigint = NULL,
    @lineage_old54 varbinary(311) = NULL,
    @lineage_new54 varbinary(311) = NULL,
    @rowguid55 uniqueidentifier = NULL,
    @metadata_type55 tinyint = NULL,
    @generation55 bigint = NULL,
    @lineage_old55 varbinary(311) = NULL,
    @lineage_new55 varbinary(311) = NULL,
    @rowguid56 uniqueidentifier = NULL,
    @metadata_type56 tinyint = NULL,
    @generation56 bigint = NULL,
    @lineage_old56 varbinary(311) = NULL,
    @lineage_new56 varbinary(311) = NULL,
    @rowguid57 uniqueidentifier = NULL,
    @metadata_type57 tinyint = NULL,
    @generation57 bigint = NULL,
    @lineage_old57 varbinary(311) = NULL,
    @lineage_new57 varbinary(311) = NULL,
    @rowguid58 uniqueidentifier = NULL,
    @metadata_type58 tinyint = NULL,
    @generation58 bigint = NULL,
    @lineage_old58 varbinary(311) = NULL,
    @lineage_new58 varbinary(311) = NULL,
    @rowguid59 uniqueidentifier = NULL,
    @metadata_type59 tinyint = NULL,
    @generation59 bigint = NULL,
    @lineage_old59 varbinary(311) = NULL,
    @lineage_new59 varbinary(311) = NULL,
    @rowguid60 uniqueidentifier = NULL,
    @metadata_type60 tinyint = NULL,
    @generation60 bigint = NULL,
    @lineage_old60 varbinary(311) = NULL,
    @lineage_new60 varbinary(311) = NULL
,
    @rowguid61 uniqueidentifier = NULL,
    @metadata_type61 tinyint = NULL,
    @generation61 bigint = NULL,
    @lineage_old61 varbinary(311) = NULL,
    @lineage_new61 varbinary(311) = NULL,
    @rowguid62 uniqueidentifier = NULL,
    @metadata_type62 tinyint = NULL,
    @generation62 bigint = NULL,
    @lineage_old62 varbinary(311) = NULL,
    @lineage_new62 varbinary(311) = NULL,
    @rowguid63 uniqueidentifier = NULL,
    @metadata_type63 tinyint = NULL,
    @generation63 bigint = NULL,
    @lineage_old63 varbinary(311) = NULL,
    @lineage_new63 varbinary(311) = NULL,
    @rowguid64 uniqueidentifier = NULL,
    @metadata_type64 tinyint = NULL,
    @generation64 bigint = NULL,
    @lineage_old64 varbinary(311) = NULL,
    @lineage_new64 varbinary(311) = NULL,
    @rowguid65 uniqueidentifier = NULL,
    @metadata_type65 tinyint = NULL,
    @generation65 bigint = NULL,
    @lineage_old65 varbinary(311) = NULL,
    @lineage_new65 varbinary(311) = NULL,
    @rowguid66 uniqueidentifier = NULL,
    @metadata_type66 tinyint = NULL,
    @generation66 bigint = NULL,
    @lineage_old66 varbinary(311) = NULL,
    @lineage_new66 varbinary(311) = NULL,
    @rowguid67 uniqueidentifier = NULL,
    @metadata_type67 tinyint = NULL,
    @generation67 bigint = NULL,
    @lineage_old67 varbinary(311) = NULL,
    @lineage_new67 varbinary(311) = NULL,
    @rowguid68 uniqueidentifier = NULL,
    @metadata_type68 tinyint = NULL,
    @generation68 bigint = NULL,
    @lineage_old68 varbinary(311) = NULL,
    @lineage_new68 varbinary(311) = NULL,
    @rowguid69 uniqueidentifier = NULL,
    @metadata_type69 tinyint = NULL,
    @generation69 bigint = NULL,
    @lineage_old69 varbinary(311) = NULL,
    @lineage_new69 varbinary(311) = NULL,
    @rowguid70 uniqueidentifier = NULL,
    @metadata_type70 tinyint = NULL,
    @generation70 bigint = NULL,
    @lineage_old70 varbinary(311) = NULL,
    @lineage_new70 varbinary(311) = NULL
,
    @rowguid71 uniqueidentifier = NULL,
    @metadata_type71 tinyint = NULL,
    @generation71 bigint = NULL,
    @lineage_old71 varbinary(311) = NULL,
    @lineage_new71 varbinary(311) = NULL,
    @rowguid72 uniqueidentifier = NULL,
    @metadata_type72 tinyint = NULL,
    @generation72 bigint = NULL,
    @lineage_old72 varbinary(311) = NULL,
    @lineage_new72 varbinary(311) = NULL,
    @rowguid73 uniqueidentifier = NULL,
    @metadata_type73 tinyint = NULL,
    @generation73 bigint = NULL,
    @lineage_old73 varbinary(311) = NULL,
    @lineage_new73 varbinary(311) = NULL,
    @rowguid74 uniqueidentifier = NULL,
    @metadata_type74 tinyint = NULL,
    @generation74 bigint = NULL,
    @lineage_old74 varbinary(311) = NULL,
    @lineage_new74 varbinary(311) = NULL,
    @rowguid75 uniqueidentifier = NULL,
    @metadata_type75 tinyint = NULL,
    @generation75 bigint = NULL,
    @lineage_old75 varbinary(311) = NULL,
    @lineage_new75 varbinary(311) = NULL,
    @rowguid76 uniqueidentifier = NULL,
    @metadata_type76 tinyint = NULL,
    @generation76 bigint = NULL,
    @lineage_old76 varbinary(311) = NULL,
    @lineage_new76 varbinary(311) = NULL,
    @rowguid77 uniqueidentifier = NULL,
    @metadata_type77 tinyint = NULL,
    @generation77 bigint = NULL,
    @lineage_old77 varbinary(311) = NULL,
    @lineage_new77 varbinary(311) = NULL,
    @rowguid78 uniqueidentifier = NULL,
    @metadata_type78 tinyint = NULL,
    @generation78 bigint = NULL,
    @lineage_old78 varbinary(311) = NULL,
    @lineage_new78 varbinary(311) = NULL,
    @rowguid79 uniqueidentifier = NULL,
    @metadata_type79 tinyint = NULL,
    @generation79 bigint = NULL,
    @lineage_old79 varbinary(311) = NULL,
    @lineage_new79 varbinary(311) = NULL,
    @rowguid80 uniqueidentifier = NULL,
    @metadata_type80 tinyint = NULL,
    @generation80 bigint = NULL,
    @lineage_old80 varbinary(311) = NULL,
    @lineage_new80 varbinary(311) = NULL
,
    @rowguid81 uniqueidentifier = NULL,
    @metadata_type81 tinyint = NULL,
    @generation81 bigint = NULL,
    @lineage_old81 varbinary(311) = NULL,
    @lineage_new81 varbinary(311) = NULL,
    @rowguid82 uniqueidentifier = NULL,
    @metadata_type82 tinyint = NULL,
    @generation82 bigint = NULL,
    @lineage_old82 varbinary(311) = NULL,
    @lineage_new82 varbinary(311) = NULL,
    @rowguid83 uniqueidentifier = NULL,
    @metadata_type83 tinyint = NULL,
    @generation83 bigint = NULL,
    @lineage_old83 varbinary(311) = NULL,
    @lineage_new83 varbinary(311) = NULL,
    @rowguid84 uniqueidentifier = NULL,
    @metadata_type84 tinyint = NULL,
    @generation84 bigint = NULL,
    @lineage_old84 varbinary(311) = NULL,
    @lineage_new84 varbinary(311) = NULL,
    @rowguid85 uniqueidentifier = NULL,
    @metadata_type85 tinyint = NULL,
    @generation85 bigint = NULL,
    @lineage_old85 varbinary(311) = NULL,
    @lineage_new85 varbinary(311) = NULL,
    @rowguid86 uniqueidentifier = NULL,
    @metadata_type86 tinyint = NULL,
    @generation86 bigint = NULL,
    @lineage_old86 varbinary(311) = NULL,
    @lineage_new86 varbinary(311) = NULL,
    @rowguid87 uniqueidentifier = NULL,
    @metadata_type87 tinyint = NULL,
    @generation87 bigint = NULL,
    @lineage_old87 varbinary(311) = NULL,
    @lineage_new87 varbinary(311) = NULL,
    @rowguid88 uniqueidentifier = NULL,
    @metadata_type88 tinyint = NULL,
    @generation88 bigint = NULL,
    @lineage_old88 varbinary(311) = NULL,
    @lineage_new88 varbinary(311) = NULL,
    @rowguid89 uniqueidentifier = NULL,
    @metadata_type89 tinyint = NULL,
    @generation89 bigint = NULL,
    @lineage_old89 varbinary(311) = NULL,
    @lineage_new89 varbinary(311) = NULL,
    @rowguid90 uniqueidentifier = NULL,
    @metadata_type90 tinyint = NULL,
    @generation90 bigint = NULL,
    @lineage_old90 varbinary(311) = NULL,
    @lineage_new90 varbinary(311) = NULL
,
    @rowguid91 uniqueidentifier = NULL,
    @metadata_type91 tinyint = NULL,
    @generation91 bigint = NULL,
    @lineage_old91 varbinary(311) = NULL,
    @lineage_new91 varbinary(311) = NULL,
    @rowguid92 uniqueidentifier = NULL,
    @metadata_type92 tinyint = NULL,
    @generation92 bigint = NULL,
    @lineage_old92 varbinary(311) = NULL,
    @lineage_new92 varbinary(311) = NULL,
    @rowguid93 uniqueidentifier = NULL,
    @metadata_type93 tinyint = NULL,
    @generation93 bigint = NULL,
    @lineage_old93 varbinary(311) = NULL,
    @lineage_new93 varbinary(311) = NULL,
    @rowguid94 uniqueidentifier = NULL,
    @metadata_type94 tinyint = NULL,
    @generation94 bigint = NULL,
    @lineage_old94 varbinary(311) = NULL,
    @lineage_new94 varbinary(311) = NULL,
    @rowguid95 uniqueidentifier = NULL,
    @metadata_type95 tinyint = NULL,
    @generation95 bigint = NULL,
    @lineage_old95 varbinary(311) = NULL,
    @lineage_new95 varbinary(311) = NULL,
    @rowguid96 uniqueidentifier = NULL,
    @metadata_type96 tinyint = NULL,
    @generation96 bigint = NULL,
    @lineage_old96 varbinary(311) = NULL,
    @lineage_new96 varbinary(311) = NULL,
    @rowguid97 uniqueidentifier = NULL,
    @metadata_type97 tinyint = NULL,
    @generation97 bigint = NULL,
    @lineage_old97 varbinary(311) = NULL,
    @lineage_new97 varbinary(311) = NULL,
    @rowguid98 uniqueidentifier = NULL,
    @metadata_type98 tinyint = NULL,
    @generation98 bigint = NULL,
    @lineage_old98 varbinary(311) = NULL,
    @lineage_new98 varbinary(311) = NULL,
    @rowguid99 uniqueidentifier = NULL,
    @metadata_type99 tinyint = NULL,
    @generation99 bigint = NULL,
    @lineage_old99 varbinary(311) = NULL,
    @lineage_new99 varbinary(311) = NULL,
    @rowguid100 uniqueidentifier = NULL,
    @metadata_type100 tinyint = NULL,
    @generation100 bigint = NULL,
    @lineage_old100 varbinary(311) = NULL,
    @lineage_new100 varbinary(311) = NULL

)
as
begin


    -- this proc returns 0 to indicate error and 1 to indicate success
    declare @retcode    int
    set nocount on
    declare @rows_deleted int
    declare @rows_remaining int
    declare @error int
    declare @tomb_rows_updated int
    declare @publication_number smallint
    declare @rows_in_syncview int
        
    if ({ fn ISPALUSER('8D8B572F-B352-4CD3-9BF9-08911C828501') } <> 1)
    begin       
        RAISERROR (14126, 11, -1)
        return 0
    end
    
    select @publication_number = 4

    if @rowstobedeleted is NULL or @rowstobedeleted <= 0
        return 0

    begin tran
    save tran batchdeleteproc


    delete [dbo].[HOCPHI] with (rowlock)
    from 
    (

    select @rowguid1 as rowguid, @metadata_type1 as metadata_type, @lineage_old1 as lineage_old, @lineage_new1 as lineage_new, @generation1 as generation  union all 
    select @rowguid2 as rowguid, @metadata_type2 as metadata_type, @lineage_old2 as lineage_old, @lineage_new2 as lineage_new, @generation2 as generation  union all 
    select @rowguid3 as rowguid, @metadata_type3 as metadata_type, @lineage_old3 as lineage_old, @lineage_new3 as lineage_new, @generation3 as generation  union all 
    select @rowguid4 as rowguid, @metadata_type4 as metadata_type, @lineage_old4 as lineage_old, @lineage_new4 as lineage_new, @generation4 as generation  union all 
    select @rowguid5 as rowguid, @metadata_type5 as metadata_type, @lineage_old5 as lineage_old, @lineage_new5 as lineage_new, @generation5 as generation  union all 
    select @rowguid6 as rowguid, @metadata_type6 as metadata_type, @lineage_old6 as lineage_old, @lineage_new6 as lineage_new, @generation6 as generation  union all 
    select @rowguid7 as rowguid, @metadata_type7 as metadata_type, @lineage_old7 as lineage_old, @lineage_new7 as lineage_new, @generation7 as generation  union all 
    select @rowguid8 as rowguid, @metadata_type8 as metadata_type, @lineage_old8 as lineage_old, @lineage_new8 as lineage_new, @generation8 as generation  union all 
    select @rowguid9 as rowguid, @metadata_type9 as metadata_type, @lineage_old9 as lineage_old, @lineage_new9 as lineage_new, @generation9 as generation  union all 
    select @rowguid10 as rowguid, @metadata_type10 as metadata_type, @lineage_old10 as lineage_old, @lineage_new10 as lineage_new, @generation10 as generation 
 union all 
    select @rowguid11 as rowguid, @metadata_type11 as metadata_type, @lineage_old11 as lineage_old, @lineage_new11 as lineage_new, @generation11 as generation  union all 
    select @rowguid12 as rowguid, @metadata_type12 as metadata_type, @lineage_old12 as lineage_old, @lineage_new12 as lineage_new, @generation12 as generation  union all 
    select @rowguid13 as rowguid, @metadata_type13 as metadata_type, @lineage_old13 as lineage_old, @lineage_new13 as lineage_new, @generation13 as generation  union all 
    select @rowguid14 as rowguid, @metadata_type14 as metadata_type, @lineage_old14 as lineage_old, @lineage_new14 as lineage_new, @generation14 as generation  union all 
    select @rowguid15 as rowguid, @metadata_type15 as metadata_type, @lineage_old15 as lineage_old, @lineage_new15 as lineage_new, @generation15 as generation  union all 
    select @rowguid16 as rowguid, @metadata_type16 as metadata_type, @lineage_old16 as lineage_old, @lineage_new16 as lineage_new, @generation16 as generation  union all 
    select @rowguid17 as rowguid, @metadata_type17 as metadata_type, @lineage_old17 as lineage_old, @lineage_new17 as lineage_new, @generation17 as generation  union all 
    select @rowguid18 as rowguid, @metadata_type18 as metadata_type, @lineage_old18 as lineage_old, @lineage_new18 as lineage_new, @generation18 as generation  union all 
    select @rowguid19 as rowguid, @metadata_type19 as metadata_type, @lineage_old19 as lineage_old, @lineage_new19 as lineage_new, @generation19 as generation  union all 
    select @rowguid20 as rowguid, @metadata_type20 as metadata_type, @lineage_old20 as lineage_old, @lineage_new20 as lineage_new, @generation20 as generation 
 union all 
    select @rowguid21 as rowguid, @metadata_type21 as metadata_type, @lineage_old21 as lineage_old, @lineage_new21 as lineage_new, @generation21 as generation  union all 
    select @rowguid22 as rowguid, @metadata_type22 as metadata_type, @lineage_old22 as lineage_old, @lineage_new22 as lineage_new, @generation22 as generation  union all 
    select @rowguid23 as rowguid, @metadata_type23 as metadata_type, @lineage_old23 as lineage_old, @lineage_new23 as lineage_new, @generation23 as generation  union all 
    select @rowguid24 as rowguid, @metadata_type24 as metadata_type, @lineage_old24 as lineage_old, @lineage_new24 as lineage_new, @generation24 as generation  union all 
    select @rowguid25 as rowguid, @metadata_type25 as metadata_type, @lineage_old25 as lineage_old, @lineage_new25 as lineage_new, @generation25 as generation  union all 
    select @rowguid26 as rowguid, @metadata_type26 as metadata_type, @lineage_old26 as lineage_old, @lineage_new26 as lineage_new, @generation26 as generation  union all 
    select @rowguid27 as rowguid, @metadata_type27 as metadata_type, @lineage_old27 as lineage_old, @lineage_new27 as lineage_new, @generation27 as generation  union all 
    select @rowguid28 as rowguid, @metadata_type28 as metadata_type, @lineage_old28 as lineage_old, @lineage_new28 as lineage_new, @generation28 as generation  union all 
    select @rowguid29 as rowguid, @metadata_type29 as metadata_type, @lineage_old29 as lineage_old, @lineage_new29 as lineage_new, @generation29 as generation  union all 
    select @rowguid30 as rowguid, @metadata_type30 as metadata_type, @lineage_old30 as lineage_old, @lineage_new30 as lineage_new, @generation30 as generation 
 union all 
    select @rowguid31 as rowguid, @metadata_type31 as metadata_type, @lineage_old31 as lineage_old, @lineage_new31 as lineage_new, @generation31 as generation  union all 
    select @rowguid32 as rowguid, @metadata_type32 as metadata_type, @lineage_old32 as lineage_old, @lineage_new32 as lineage_new, @generation32 as generation  union all 
    select @rowguid33 as rowguid, @metadata_type33 as metadata_type, @lineage_old33 as lineage_old, @lineage_new33 as lineage_new, @generation33 as generation  union all 
    select @rowguid34 as rowguid, @metadata_type34 as metadata_type, @lineage_old34 as lineage_old, @lineage_new34 as lineage_new, @generation34 as generation  union all 
    select @rowguid35 as rowguid, @metadata_type35 as metadata_type, @lineage_old35 as lineage_old, @lineage_new35 as lineage_new, @generation35 as generation  union all 
    select @rowguid36 as rowguid, @metadata_type36 as metadata_type, @lineage_old36 as lineage_old, @lineage_new36 as lineage_new, @generation36 as generation  union all 
    select @rowguid37 as rowguid, @metadata_type37 as metadata_type, @lineage_old37 as lineage_old, @lineage_new37 as lineage_new, @generation37 as generation  union all 
    select @rowguid38 as rowguid, @metadata_type38 as metadata_type, @lineage_old38 as lineage_old, @lineage_new38 as lineage_new, @generation38 as generation  union all 
    select @rowguid39 as rowguid, @metadata_type39 as metadata_type, @lineage_old39 as lineage_old, @lineage_new39 as lineage_new, @generation39 as generation  union all 
    select @rowguid40 as rowguid, @metadata_type40 as metadata_type, @lineage_old40 as lineage_old, @lineage_new40 as lineage_new, @generation40 as generation 
 union all 
    select @rowguid41 as rowguid, @metadata_type41 as metadata_type, @lineage_old41 as lineage_old, @lineage_new41 as lineage_new, @generation41 as generation  union all 
    select @rowguid42 as rowguid, @metadata_type42 as metadata_type, @lineage_old42 as lineage_old, @lineage_new42 as lineage_new, @generation42 as generation  union all 
    select @rowguid43 as rowguid, @metadata_type43 as metadata_type, @lineage_old43 as lineage_old, @lineage_new43 as lineage_new, @generation43 as generation  union all 
    select @rowguid44 as rowguid, @metadata_type44 as metadata_type, @lineage_old44 as lineage_old, @lineage_new44 as lineage_new, @generation44 as generation  union all 
    select @rowguid45 as rowguid, @metadata_type45 as metadata_type, @lineage_old45 as lineage_old, @lineage_new45 as lineage_new, @generation45 as generation  union all 
    select @rowguid46 as rowguid, @metadata_type46 as metadata_type, @lineage_old46 as lineage_old, @lineage_new46 as lineage_new, @generation46 as generation  union all 
    select @rowguid47 as rowguid, @metadata_type47 as metadata_type, @lineage_old47 as lineage_old, @lineage_new47 as lineage_new, @generation47 as generation  union all 
    select @rowguid48 as rowguid, @metadata_type48 as metadata_type, @lineage_old48 as lineage_old, @lineage_new48 as lineage_new, @generation48 as generation  union all 
    select @rowguid49 as rowguid, @metadata_type49 as metadata_type, @lineage_old49 as lineage_old, @lineage_new49 as lineage_new, @generation49 as generation  union all 
    select @rowguid50 as rowguid, @metadata_type50 as metadata_type, @lineage_old50 as lineage_old, @lineage_new50 as lineage_new, @generation50 as generation 
 union all 
    select @rowguid51 as rowguid, @metadata_type51 as metadata_type, @lineage_old51 as lineage_old, @lineage_new51 as lineage_new, @generation51 as generation  union all 
    select @rowguid52 as rowguid, @metadata_type52 as metadata_type, @lineage_old52 as lineage_old, @lineage_new52 as lineage_new, @generation52 as generation  union all 
    select @rowguid53 as rowguid, @metadata_type53 as metadata_type, @lineage_old53 as lineage_old, @lineage_new53 as lineage_new, @generation53 as generation  union all 
    select @rowguid54 as rowguid, @metadata_type54 as metadata_type, @lineage_old54 as lineage_old, @lineage_new54 as lineage_new, @generation54 as generation  union all 
    select @rowguid55 as rowguid, @metadata_type55 as metadata_type, @lineage_old55 as lineage_old, @lineage_new55 as lineage_new, @generation55 as generation  union all 
    select @rowguid56 as rowguid, @metadata_type56 as metadata_type, @lineage_old56 as lineage_old, @lineage_new56 as lineage_new, @generation56 as generation  union all 
    select @rowguid57 as rowguid, @metadata_type57 as metadata_type, @lineage_old57 as lineage_old, @lineage_new57 as lineage_new, @generation57 as generation  union all 
    select @rowguid58 as rowguid, @metadata_type58 as metadata_type, @lineage_old58 as lineage_old, @lineage_new58 as lineage_new, @generation58 as generation  union all 
    select @rowguid59 as rowguid, @metadata_type59 as metadata_type, @lineage_old59 as lineage_old, @lineage_new59 as lineage_new, @generation59 as generation  union all 
    select @rowguid60 as rowguid, @metadata_type60 as metadata_type, @lineage_old60 as lineage_old, @lineage_new60 as lineage_new, @generation60 as generation 
 union all 
    select @rowguid61 as rowguid, @metadata_type61 as metadata_type, @lineage_old61 as lineage_old, @lineage_new61 as lineage_new, @generation61 as generation  union all 
    select @rowguid62 as rowguid, @metadata_type62 as metadata_type, @lineage_old62 as lineage_old, @lineage_new62 as lineage_new, @generation62 as generation  union all 
    select @rowguid63 as rowguid, @metadata_type63 as metadata_type, @lineage_old63 as lineage_old, @lineage_new63 as lineage_new, @generation63 as generation  union all 
    select @rowguid64 as rowguid, @metadata_type64 as metadata_type, @lineage_old64 as lineage_old, @lineage_new64 as lineage_new, @generation64 as generation  union all 
    select @rowguid65 as rowguid, @metadata_type65 as metadata_type, @lineage_old65 as lineage_old, @lineage_new65 as lineage_new, @generation65 as generation  union all 
    select @rowguid66 as rowguid, @metadata_type66 as metadata_type, @lineage_old66 as lineage_old, @lineage_new66 as lineage_new, @generation66 as generation  union all 
    select @rowguid67 as rowguid, @metadata_type67 as metadata_type, @lineage_old67 as lineage_old, @lineage_new67 as lineage_new, @generation67 as generation  union all 
    select @rowguid68 as rowguid, @metadata_type68 as metadata_type, @lineage_old68 as lineage_old, @lineage_new68 as lineage_new, @generation68 as generation  union all 
    select @rowguid69 as rowguid, @metadata_type69 as metadata_type, @lineage_old69 as lineage_old, @lineage_new69 as lineage_new, @generation69 as generation  union all 
    select @rowguid70 as rowguid, @metadata_type70 as metadata_type, @lineage_old70 as lineage_old, @lineage_new70 as lineage_new, @generation70 as generation 
 union all 
    select @rowguid71 as rowguid, @metadata_type71 as metadata_type, @lineage_old71 as lineage_old, @lineage_new71 as lineage_new, @generation71 as generation  union all 
    select @rowguid72 as rowguid, @metadata_type72 as metadata_type, @lineage_old72 as lineage_old, @lineage_new72 as lineage_new, @generation72 as generation  union all 
    select @rowguid73 as rowguid, @metadata_type73 as metadata_type, @lineage_old73 as lineage_old, @lineage_new73 as lineage_new, @generation73 as generation  union all 
    select @rowguid74 as rowguid, @metadata_type74 as metadata_type, @lineage_old74 as lineage_old, @lineage_new74 as lineage_new, @generation74 as generation  union all 
    select @rowguid75 as rowguid, @metadata_type75 as metadata_type, @lineage_old75 as lineage_old, @lineage_new75 as lineage_new, @generation75 as generation  union all 
    select @rowguid76 as rowguid, @metadata_type76 as metadata_type, @lineage_old76 as lineage_old, @lineage_new76 as lineage_new, @generation76 as generation  union all 
    select @rowguid77 as rowguid, @metadata_type77 as metadata_type, @lineage_old77 as lineage_old, @lineage_new77 as lineage_new, @generation77 as generation  union all 
    select @rowguid78 as rowguid, @metadata_type78 as metadata_type, @lineage_old78 as lineage_old, @lineage_new78 as lineage_new, @generation78 as generation  union all 
    select @rowguid79 as rowguid, @metadata_type79 as metadata_type, @lineage_old79 as lineage_old, @lineage_new79 as lineage_new, @generation79 as generation  union all 
    select @rowguid80 as rowguid, @metadata_type80 as metadata_type, @lineage_old80 as lineage_old, @lineage_new80 as lineage_new, @generation80 as generation 
 union all 
    select @rowguid81 as rowguid, @metadata_type81 as metadata_type, @lineage_old81 as lineage_old, @lineage_new81 as lineage_new, @generation81 as generation  union all 
    select @rowguid82 as rowguid, @metadata_type82 as metadata_type, @lineage_old82 as lineage_old, @lineage_new82 as lineage_new, @generation82 as generation  union all 
    select @rowguid83 as rowguid, @metadata_type83 as metadata_type, @lineage_old83 as lineage_old, @lineage_new83 as lineage_new, @generation83 as generation  union all 
    select @rowguid84 as rowguid, @metadata_type84 as metadata_type, @lineage_old84 as lineage_old, @lineage_new84 as lineage_new, @generation84 as generation  union all 
    select @rowguid85 as rowguid, @metadata_type85 as metadata_type, @lineage_old85 as lineage_old, @lineage_new85 as lineage_new, @generation85 as generation  union all 
    select @rowguid86 as rowguid, @metadata_type86 as metadata_type, @lineage_old86 as lineage_old, @lineage_new86 as lineage_new, @generation86 as generation  union all 
    select @rowguid87 as rowguid, @metadata_type87 as metadata_type, @lineage_old87 as lineage_old, @lineage_new87 as lineage_new, @generation87 as generation  union all 
    select @rowguid88 as rowguid, @metadata_type88 as metadata_type, @lineage_old88 as lineage_old, @lineage_new88 as lineage_new, @generation88 as generation  union all 
    select @rowguid89 as rowguid, @metadata_type89 as metadata_type, @lineage_old89 as lineage_old, @lineage_new89 as lineage_new, @generation89 as generation  union all 
    select @rowguid90 as rowguid, @metadata_type90 as metadata_type, @lineage_old90 as lineage_old, @lineage_new90 as lineage_new, @generation90 as generation 
 union all 
    select @rowguid91 as rowguid, @metadata_type91 as metadata_type, @lineage_old91 as lineage_old, @lineage_new91 as lineage_new, @generation91 as generation  union all 
    select @rowguid92 as rowguid, @metadata_type92 as metadata_type, @lineage_old92 as lineage_old, @lineage_new92 as lineage_new, @generation92 as generation  union all 
    select @rowguid93 as rowguid, @metadata_type93 as metadata_type, @lineage_old93 as lineage_old, @lineage_new93 as lineage_new, @generation93 as generation  union all 
    select @rowguid94 as rowguid, @metadata_type94 as metadata_type, @lineage_old94 as lineage_old, @lineage_new94 as lineage_new, @generation94 as generation  union all 
    select @rowguid95 as rowguid, @metadata_type95 as metadata_type, @lineage_old95 as lineage_old, @lineage_new95 as lineage_new, @generation95 as generation  union all 
    select @rowguid96 as rowguid, @metadata_type96 as metadata_type, @lineage_old96 as lineage_old, @lineage_new96 as lineage_new, @generation96 as generation  union all 
    select @rowguid97 as rowguid, @metadata_type97 as metadata_type, @lineage_old97 as lineage_old, @lineage_new97 as lineage_new, @generation97 as generation  union all 
    select @rowguid98 as rowguid, @metadata_type98 as metadata_type, @lineage_old98 as lineage_old, @lineage_new98 as lineage_new, @generation98 as generation  union all 
    select @rowguid99 as rowguid, @metadata_type99 as metadata_type, @lineage_old99 as lineage_old, @lineage_new99 as lineage_new, @generation99 as generation  union all 
    select @rowguid100 as rowguid, @metadata_type100 as metadata_type, @lineage_old100 as lineage_old, @lineage_new100 as lineage_new, @generation100 as generation 
) as rows
    inner join [dbo].[HOCPHI] t with (rowlock) on rows.rowguid = t.[rowguid] and rows.rowguid is not NULL

    left outer join dbo.MSmerge_contents cont with (rowlock) 
    on rows.rowguid = cont.rowguid and cont.tablenick = 31081000 
    and rows.rowguid is not NULL
    where ((rows.metadata_type = 3 and cont.rowguid is NULL) or
           ((rows.metadata_type = 5 or  rows.metadata_type = 6) and (cont.rowguid is NULL or cont.lineage = rows.lineage_old)) or
           (cont.rowguid is not NULL and cont.lineage = rows.lineage_old))
           and rows.rowguid is not NULL 

    select @rows_deleted = @@rowcount, @error = @@error
    if @error<>0
        goto Failure
    if @rows_deleted > @rowstobedeleted
    begin
        -- this is just not possible
        raiserror(20684, 16, -1, '[dbo].[HOCPHI]')
        goto Failure
    end
    if @rows_deleted <> @rowstobedeleted
    begin

        -- we will now check if any of the rows we wanted to delete were not deleted. If the rows were not deleted
        -- by the previous delete because it was already deleted, we will still assume that this is a success
        select @rows_remaining = count(*) from 
        ( 

         select @rowguid1 as rowguid union all 
         select @rowguid2 as rowguid union all 
         select @rowguid3 as rowguid union all 
         select @rowguid4 as rowguid union all 
         select @rowguid5 as rowguid union all 
         select @rowguid6 as rowguid union all 
         select @rowguid7 as rowguid union all 
         select @rowguid8 as rowguid union all 
         select @rowguid9 as rowguid union all 
         select @rowguid10 as rowguid union all 
         select @rowguid11 as rowguid union all 
         select @rowguid12 as rowguid union all 
         select @rowguid13 as rowguid union all 
         select @rowguid14 as rowguid union all 
         select @rowguid15 as rowguid union all 
         select @rowguid16 as rowguid union all 
         select @rowguid17 as rowguid union all 
         select @rowguid18 as rowguid union all 
         select @rowguid19 as rowguid union all 
         select @rowguid20 as rowguid union all 
         select @rowguid21 as rowguid union all 
         select @rowguid22 as rowguid union all 
         select @rowguid23 as rowguid union all 
         select @rowguid24 as rowguid union all 
         select @rowguid25 as rowguid union all 
         select @rowguid26 as rowguid union all 
         select @rowguid27 as rowguid union all 
         select @rowguid28 as rowguid union all 
         select @rowguid29 as rowguid union all 
         select @rowguid30 as rowguid union all 
         select @rowguid31 as rowguid union all 
         select @rowguid32 as rowguid union all 
         select @rowguid33 as rowguid union all 
         select @rowguid34 as rowguid union all 
         select @rowguid35 as rowguid union all 
         select @rowguid36 as rowguid union all 
         select @rowguid37 as rowguid union all 
         select @rowguid38 as rowguid union all 
         select @rowguid39 as rowguid union all 
         select @rowguid40 as rowguid union all 
         select @rowguid41 as rowguid union all 
         select @rowguid42 as rowguid union all 
         select @rowguid43 as rowguid union all 
         select @rowguid44 as rowguid union all 
         select @rowguid45 as rowguid union all 
         select @rowguid46 as rowguid union all 
         select @rowguid47 as rowguid union all 
         select @rowguid48 as rowguid union all 
         select @rowguid49 as rowguid union all 
         select @rowguid50 as rowguid union all

         select @rowguid51 as rowguid union all 
         select @rowguid52 as rowguid union all 
         select @rowguid53 as rowguid union all 
         select @rowguid54 as rowguid union all 
         select @rowguid55 as rowguid union all 
         select @rowguid56 as rowguid union all 
         select @rowguid57 as rowguid union all 
         select @rowguid58 as rowguid union all 
         select @rowguid59 as rowguid union all 
         select @rowguid60 as rowguid union all 
         select @rowguid61 as rowguid union all 
         select @rowguid62 as rowguid union all 
         select @rowguid63 as rowguid union all 
         select @rowguid64 as rowguid union all 
         select @rowguid65 as rowguid union all 
         select @rowguid66 as rowguid union all 
         select @rowguid67 as rowguid union all 
         select @rowguid68 as rowguid union all 
         select @rowguid69 as rowguid union all 
         select @rowguid70 as rowguid union all 
         select @rowguid71 as rowguid union all 
         select @rowguid72 as rowguid union all 
         select @rowguid73 as rowguid union all 
         select @rowguid74 as rowguid union all 
         select @rowguid75 as rowguid union all 
         select @rowguid76 as rowguid union all 
         select @rowguid77 as rowguid union all 
         select @rowguid78 as rowguid union all 
         select @rowguid79 as rowguid union all 
         select @rowguid80 as rowguid union all 
         select @rowguid81 as rowguid union all 
         select @rowguid82 as rowguid union all 
         select @rowguid83 as rowguid union all 
         select @rowguid84 as rowguid union all 
         select @rowguid85 as rowguid union all 
         select @rowguid86 as rowguid union all 
         select @rowguid87 as rowguid union all 
         select @rowguid88 as rowguid union all 
         select @rowguid89 as rowguid union all 
         select @rowguid90 as rowguid union all 
         select @rowguid91 as rowguid union all 
         select @rowguid92 as rowguid union all 
         select @rowguid93 as rowguid union all 
         select @rowguid94 as rowguid union all 
         select @rowguid95 as rowguid union all 
         select @rowguid96 as rowguid union all 
         select @rowguid97 as rowguid union all 
         select @rowguid98 as rowguid union all 
         select @rowguid99 as rowguid union all 
         select @rowguid100 as rowguid

        ) as rows
        inner join [dbo].[HOCPHI] t with (rowlock) 
        on t.[rowguid] = rows.rowguid
        and rows.rowguid is not NULL
        
        if @@error <> 0
            goto Failure
        
        if @rows_remaining <> 0
        begin
            -- failed deleting one or more rows. Could be because of metadata mismatch
            --raiserror(20682, 10, -1, @rows_remaining, '[dbo].[HOCPHI]')
            goto Failure
        end        
    end

    -- if we get here it means that all the rows that we intend to delete were either deleted by us
    -- or they were already deleted by someone else and do not exist in the user table
    -- we insert a tombstone entry for the rows we have deleted and delete the contents rows if exists

    -- if the rows were previously deleted we still want to update the metadatatype, generation and lineage
    -- in MSmerge_tombstone. We could find rows in the following update also if the trigger got called by
    -- the user table delete and it inserted the rows into tombstone (it would have inserted with type 1)
    update dbo.MSmerge_tombstone with (rowlock)
        set type = case when (rows.metadata_type=5 or rows.metadata_type=6) then rows.metadata_type else 1 end,
            generation = rows.generation,
            lineage = rows.lineage_new
    from 
    (

    select @rowguid1 as rowguid, @metadata_type1 as metadata_type, @lineage_old1 as lineage_old, @lineage_new1 as lineage_new, @generation1 as generation  union all 
    select @rowguid2 as rowguid, @metadata_type2 as metadata_type, @lineage_old2 as lineage_old, @lineage_new2 as lineage_new, @generation2 as generation  union all 
    select @rowguid3 as rowguid, @metadata_type3 as metadata_type, @lineage_old3 as lineage_old, @lineage_new3 as lineage_new, @generation3 as generation  union all 
    select @rowguid4 as rowguid, @metadata_type4 as metadata_type, @lineage_old4 as lineage_old, @lineage_new4 as lineage_new, @generation4 as generation  union all 
    select @rowguid5 as rowguid, @metadata_type5 as metadata_type, @lineage_old5 as lineage_old, @lineage_new5 as lineage_new, @generation5 as generation  union all 
    select @rowguid6 as rowguid, @metadata_type6 as metadata_type, @lineage_old6 as lineage_old, @lineage_new6 as lineage_new, @generation6 as generation  union all 
    select @rowguid7 as rowguid, @metadata_type7 as metadata_type, @lineage_old7 as lineage_old, @lineage_new7 as lineage_new, @generation7 as generation  union all 
    select @rowguid8 as rowguid, @metadata_type8 as metadata_type, @lineage_old8 as lineage_old, @lineage_new8 as lineage_new, @generation8 as generation  union all 
    select @rowguid9 as rowguid, @metadata_type9 as metadata_type, @lineage_old9 as lineage_old, @lineage_new9 as lineage_new, @generation9 as generation  union all 
    select @rowguid10 as rowguid, @metadata_type10 as metadata_type, @lineage_old10 as lineage_old, @lineage_new10 as lineage_new, @generation10 as generation 
 union all 
    select @rowguid11 as rowguid, @metadata_type11 as metadata_type, @lineage_old11 as lineage_old, @lineage_new11 as lineage_new, @generation11 as generation  union all 
    select @rowguid12 as rowguid, @metadata_type12 as metadata_type, @lineage_old12 as lineage_old, @lineage_new12 as lineage_new, @generation12 as generation  union all 
    select @rowguid13 as rowguid, @metadata_type13 as metadata_type, @lineage_old13 as lineage_old, @lineage_new13 as lineage_new, @generation13 as generation  union all 
    select @rowguid14 as rowguid, @metadata_type14 as metadata_type, @lineage_old14 as lineage_old, @lineage_new14 as lineage_new, @generation14 as generation  union all 
    select @rowguid15 as rowguid, @metadata_type15 as metadata_type, @lineage_old15 as lineage_old, @lineage_new15 as lineage_new, @generation15 as generation  union all 
    select @rowguid16 as rowguid, @metadata_type16 as metadata_type, @lineage_old16 as lineage_old, @lineage_new16 as lineage_new, @generation16 as generation  union all 
    select @rowguid17 as rowguid, @metadata_type17 as metadata_type, @lineage_old17 as lineage_old, @lineage_new17 as lineage_new, @generation17 as generation  union all 
    select @rowguid18 as rowguid, @metadata_type18 as metadata_type, @lineage_old18 as lineage_old, @lineage_new18 as lineage_new, @generation18 as generation  union all 
    select @rowguid19 as rowguid, @metadata_type19 as metadata_type, @lineage_old19 as lineage_old, @lineage_new19 as lineage_new, @generation19 as generation  union all 
    select @rowguid20 as rowguid, @metadata_type20 as metadata_type, @lineage_old20 as lineage_old, @lineage_new20 as lineage_new, @generation20 as generation 
 union all 
    select @rowguid21 as rowguid, @metadata_type21 as metadata_type, @lineage_old21 as lineage_old, @lineage_new21 as lineage_new, @generation21 as generation  union all 
    select @rowguid22 as rowguid, @metadata_type22 as metadata_type, @lineage_old22 as lineage_old, @lineage_new22 as lineage_new, @generation22 as generation  union all 
    select @rowguid23 as rowguid, @metadata_type23 as metadata_type, @lineage_old23 as lineage_old, @lineage_new23 as lineage_new, @generation23 as generation  union all 
    select @rowguid24 as rowguid, @metadata_type24 as metadata_type, @lineage_old24 as lineage_old, @lineage_new24 as lineage_new, @generation24 as generation  union all 
    select @rowguid25 as rowguid, @metadata_type25 as metadata_type, @lineage_old25 as lineage_old, @lineage_new25 as lineage_new, @generation25 as generation  union all 
    select @rowguid26 as rowguid, @metadata_type26 as metadata_type, @lineage_old26 as lineage_old, @lineage_new26 as lineage_new, @generation26 as generation  union all 
    select @rowguid27 as rowguid, @metadata_type27 as metadata_type, @lineage_old27 as lineage_old, @lineage_new27 as lineage_new, @generation27 as generation  union all 
    select @rowguid28 as rowguid, @metadata_type28 as metadata_type, @lineage_old28 as lineage_old, @lineage_new28 as lineage_new, @generation28 as generation  union all 
    select @rowguid29 as rowguid, @metadata_type29 as metadata_type, @lineage_old29 as lineage_old, @lineage_new29 as lineage_new, @generation29 as generation  union all 
    select @rowguid30 as rowguid, @metadata_type30 as metadata_type, @lineage_old30 as lineage_old, @lineage_new30 as lineage_new, @generation30 as generation 
 union all 
    select @rowguid31 as rowguid, @metadata_type31 as metadata_type, @lineage_old31 as lineage_old, @lineage_new31 as lineage_new, @generation31 as generation  union all 
    select @rowguid32 as rowguid, @metadata_type32 as metadata_type, @lineage_old32 as lineage_old, @lineage_new32 as lineage_new, @generation32 as generation  union all 
    select @rowguid33 as rowguid, @metadata_type33 as metadata_type, @lineage_old33 as lineage_old, @lineage_new33 as lineage_new, @generation33 as generation  union all 
    select @rowguid34 as rowguid, @metadata_type34 as metadata_type, @lineage_old34 as lineage_old, @lineage_new34 as lineage_new, @generation34 as generation  union all 
    select @rowguid35 as rowguid, @metadata_type35 as metadata_type, @lineage_old35 as lineage_old, @lineage_new35 as lineage_new, @generation35 as generation  union all 
    select @rowguid36 as rowguid, @metadata_type36 as metadata_type, @lineage_old36 as lineage_old, @lineage_new36 as lineage_new, @generation36 as generation  union all 
    select @rowguid37 as rowguid, @metadata_type37 as metadata_type, @lineage_old37 as lineage_old, @lineage_new37 as lineage_new, @generation37 as generation  union all 
    select @rowguid38 as rowguid, @metadata_type38 as metadata_type, @lineage_old38 as lineage_old, @lineage_new38 as lineage_new, @generation38 as generation  union all 
    select @rowguid39 as rowguid, @metadata_type39 as metadata_type, @lineage_old39 as lineage_old, @lineage_new39 as lineage_new, @generation39 as generation  union all 
    select @rowguid40 as rowguid, @metadata_type40 as metadata_type, @lineage_old40 as lineage_old, @lineage_new40 as lineage_new, @generation40 as generation 
 union all 
    select @rowguid41 as rowguid, @metadata_type41 as metadata_type, @lineage_old41 as lineage_old, @lineage_new41 as lineage_new, @generation41 as generation  union all 
    select @rowguid42 as rowguid, @metadata_type42 as metadata_type, @lineage_old42 as lineage_old, @lineage_new42 as lineage_new, @generation42 as generation  union all 
    select @rowguid43 as rowguid, @metadata_type43 as metadata_type, @lineage_old43 as lineage_old, @lineage_new43 as lineage_new, @generation43 as generation  union all 
    select @rowguid44 as rowguid, @metadata_type44 as metadata_type, @lineage_old44 as lineage_old, @lineage_new44 as lineage_new, @generation44 as generation  union all 
    select @rowguid45 as rowguid, @metadata_type45 as metadata_type, @lineage_old45 as lineage_old, @lineage_new45 as lineage_new, @generation45 as generation  union all 
    select @rowguid46 as rowguid, @metadata_type46 as metadata_type, @lineage_old46 as lineage_old, @lineage_new46 as lineage_new, @generation46 as generation  union all 
    select @rowguid47 as rowguid, @metadata_type47 as metadata_type, @lineage_old47 as lineage_old, @lineage_new47 as lineage_new, @generation47 as generation  union all 
    select @rowguid48 as rowguid, @metadata_type48 as metadata_type, @lineage_old48 as lineage_old, @lineage_new48 as lineage_new, @generation48 as generation  union all 
    select @rowguid49 as rowguid, @metadata_type49 as metadata_type, @lineage_old49 as lineage_old, @lineage_new49 as lineage_new, @generation49 as generation  union all 
    select @rowguid50 as rowguid, @metadata_type50 as metadata_type, @lineage_old50 as lineage_old, @lineage_new50 as lineage_new, @generation50 as generation 
 union all 
    select @rowguid51 as rowguid, @metadata_type51 as metadata_type, @lineage_old51 as lineage_old, @lineage_new51 as lineage_new, @generation51 as generation  union all 
    select @rowguid52 as rowguid, @metadata_type52 as metadata_type, @lineage_old52 as lineage_old, @lineage_new52 as lineage_new, @generation52 as generation  union all 
    select @rowguid53 as rowguid, @metadata_type53 as metadata_type, @lineage_old53 as lineage_old, @lineage_new53 as lineage_new, @generation53 as generation  union all 
    select @rowguid54 as rowguid, @metadata_type54 as metadata_type, @lineage_old54 as lineage_old, @lineage_new54 as lineage_new, @generation54 as generation  union all 
    select @rowguid55 as rowguid, @metadata_type55 as metadata_type, @lineage_old55 as lineage_old, @lineage_new55 as lineage_new, @generation55 as generation  union all 
    select @rowguid56 as rowguid, @metadata_type56 as metadata_type, @lineage_old56 as lineage_old, @lineage_new56 as lineage_new, @generation56 as generation  union all 
    select @rowguid57 as rowguid, @metadata_type57 as metadata_type, @lineage_old57 as lineage_old, @lineage_new57 as lineage_new, @generation57 as generation  union all 
    select @rowguid58 as rowguid, @metadata_type58 as metadata_type, @lineage_old58 as lineage_old, @lineage_new58 as lineage_new, @generation58 as generation  union all 
    select @rowguid59 as rowguid, @metadata_type59 as metadata_type, @lineage_old59 as lineage_old, @lineage_new59 as lineage_new, @generation59 as generation  union all 
    select @rowguid60 as rowguid, @metadata_type60 as metadata_type, @lineage_old60 as lineage_old, @lineage_new60 as lineage_new, @generation60 as generation 
 union all 
    select @rowguid61 as rowguid, @metadata_type61 as metadata_type, @lineage_old61 as lineage_old, @lineage_new61 as lineage_new, @generation61 as generation  union all 
    select @rowguid62 as rowguid, @metadata_type62 as metadata_type, @lineage_old62 as lineage_old, @lineage_new62 as lineage_new, @generation62 as generation  union all 
    select @rowguid63 as rowguid, @metadata_type63 as metadata_type, @lineage_old63 as lineage_old, @lineage_new63 as lineage_new, @generation63 as generation  union all 
    select @rowguid64 as rowguid, @metadata_type64 as metadata_type, @lineage_old64 as lineage_old, @lineage_new64 as lineage_new, @generation64 as generation  union all 
    select @rowguid65 as rowguid, @metadata_type65 as metadata_type, @lineage_old65 as lineage_old, @lineage_new65 as lineage_new, @generation65 as generation  union all 
    select @rowguid66 as rowguid, @metadata_type66 as metadata_type, @lineage_old66 as lineage_old, @lineage_new66 as lineage_new, @generation66 as generation  union all 
    select @rowguid67 as rowguid, @metadata_type67 as metadata_type, @lineage_old67 as lineage_old, @lineage_new67 as lineage_new, @generation67 as generation  union all 
    select @rowguid68 as rowguid, @metadata_type68 as metadata_type, @lineage_old68 as lineage_old, @lineage_new68 as lineage_new, @generation68 as generation  union all 
    select @rowguid69 as rowguid, @metadata_type69 as metadata_type, @lineage_old69 as lineage_old, @lineage_new69 as lineage_new, @generation69 as generation  union all 
    select @rowguid70 as rowguid, @metadata_type70 as metadata_type, @lineage_old70 as lineage_old, @lineage_new70 as lineage_new, @generation70 as generation 
 union all 
    select @rowguid71 as rowguid, @metadata_type71 as metadata_type, @lineage_old71 as lineage_old, @lineage_new71 as lineage_new, @generation71 as generation  union all 
    select @rowguid72 as rowguid, @metadata_type72 as metadata_type, @lineage_old72 as lineage_old, @lineage_new72 as lineage_new, @generation72 as generation  union all 
    select @rowguid73 as rowguid, @metadata_type73 as metadata_type, @lineage_old73 as lineage_old, @lineage_new73 as lineage_new, @generation73 as generation  union all 
    select @rowguid74 as rowguid, @metadata_type74 as metadata_type, @lineage_old74 as lineage_old, @lineage_new74 as lineage_new, @generation74 as generation  union all 
    select @rowguid75 as rowguid, @metadata_type75 as metadata_type, @lineage_old75 as lineage_old, @lineage_new75 as lineage_new, @generation75 as generation  union all 
    select @rowguid76 as rowguid, @metadata_type76 as metadata_type, @lineage_old76 as lineage_old, @lineage_new76 as lineage_new, @generation76 as generation  union all 
    select @rowguid77 as rowguid, @metadata_type77 as metadata_type, @lineage_old77 as lineage_old, @lineage_new77 as lineage_new, @generation77 as generation  union all 
    select @rowguid78 as rowguid, @metadata_type78 as metadata_type, @lineage_old78 as lineage_old, @lineage_new78 as lineage_new, @generation78 as generation  union all 
    select @rowguid79 as rowguid, @metadata_type79 as metadata_type, @lineage_old79 as lineage_old, @lineage_new79 as lineage_new, @generation79 as generation  union all 
    select @rowguid80 as rowguid, @metadata_type80 as metadata_type, @lineage_old80 as lineage_old, @lineage_new80 as lineage_new, @generation80 as generation 
 union all 
    select @rowguid81 as rowguid, @metadata_type81 as metadata_type, @lineage_old81 as lineage_old, @lineage_new81 as lineage_new, @generation81 as generation  union all 
    select @rowguid82 as rowguid, @metadata_type82 as metadata_type, @lineage_old82 as lineage_old, @lineage_new82 as lineage_new, @generation82 as generation  union all 
    select @rowguid83 as rowguid, @metadata_type83 as metadata_type, @lineage_old83 as lineage_old, @lineage_new83 as lineage_new, @generation83 as generation  union all 
    select @rowguid84 as rowguid, @metadata_type84 as metadata_type, @lineage_old84 as lineage_old, @lineage_new84 as lineage_new, @generation84 as generation  union all 
    select @rowguid85 as rowguid, @metadata_type85 as metadata_type, @lineage_old85 as lineage_old, @lineage_new85 as lineage_new, @generation85 as generation  union all 
    select @rowguid86 as rowguid, @metadata_type86 as metadata_type, @lineage_old86 as lineage_old, @lineage_new86 as lineage_new, @generation86 as generation  union all 
    select @rowguid87 as rowguid, @metadata_type87 as metadata_type, @lineage_old87 as lineage_old, @lineage_new87 as lineage_new, @generation87 as generation  union all 
    select @rowguid88 as rowguid, @metadata_type88 as metadata_type, @lineage_old88 as lineage_old, @lineage_new88 as lineage_new, @generation88 as generation  union all 
    select @rowguid89 as rowguid, @metadata_type89 as metadata_type, @lineage_old89 as lineage_old, @lineage_new89 as lineage_new, @generation89 as generation  union all 
    select @rowguid90 as rowguid, @metadata_type90 as metadata_type, @lineage_old90 as lineage_old, @lineage_new90 as lineage_new, @generation90 as generation 
 union all 
    select @rowguid91 as rowguid, @metadata_type91 as metadata_type, @lineage_old91 as lineage_old, @lineage_new91 as lineage_new, @generation91 as generation  union all 
    select @rowguid92 as rowguid, @metadata_type92 as metadata_type, @lineage_old92 as lineage_old, @lineage_new92 as lineage_new, @generation92 as generation  union all 
    select @rowguid93 as rowguid, @metadata_type93 as metadata_type, @lineage_old93 as lineage_old, @lineage_new93 as lineage_new, @generation93 as generation  union all 
    select @rowguid94 as rowguid, @metadata_type94 as metadata_type, @lineage_old94 as lineage_old, @lineage_new94 as lineage_new, @generation94 as generation  union all 
    select @rowguid95 as rowguid, @metadata_type95 as metadata_type, @lineage_old95 as lineage_old, @lineage_new95 as lineage_new, @generation95 as generation  union all 
    select @rowguid96 as rowguid, @metadata_type96 as metadata_type, @lineage_old96 as lineage_old, @lineage_new96 as lineage_new, @generation96 as generation  union all 
    select @rowguid97 as rowguid, @metadata_type97 as metadata_type, @lineage_old97 as lineage_old, @lineage_new97 as lineage_new, @generation97 as generation  union all 
    select @rowguid98 as rowguid, @metadata_type98 as metadata_type, @lineage_old98 as lineage_old, @lineage_new98 as lineage_new, @generation98 as generation  union all 
    select @rowguid99 as rowguid, @metadata_type99 as metadata_type, @lineage_old99 as lineage_old, @lineage_new99 as lineage_new, @generation99 as generation  union all 
    select @rowguid100 as rowguid, @metadata_type100 as metadata_type, @lineage_old100 as lineage_old, @lineage_new100 as lineage_new, @generation100 as generation 

    ) as rows
    inner join dbo.MSmerge_tombstone tomb with (rowlock) 
    on tomb.rowguid = rows.rowguid and tomb.tablenick = 31081000
    and rows.rowguid is not null
    and rows.lineage_new is not NULL
    option (force order, loop join)
    select @tomb_rows_updated = @@rowcount, @error = @@error
    if @error<>0
        goto Failure

        -- the trigger would have inserted a row in past partition mapping for the currently deleted
        -- row. We need to update that row with the current generation if it exists
        update dbo.MSmerge_past_partition_mappings with (rowlock)
        set generation = rows.generation
    from
    (

    select @rowguid1 as rowguid, @metadata_type1 as metadata_type, @lineage_old1 as lineage_old, @lineage_new1 as lineage_new, @generation1 as generation  union all 
    select @rowguid2 as rowguid, @metadata_type2 as metadata_type, @lineage_old2 as lineage_old, @lineage_new2 as lineage_new, @generation2 as generation  union all 
    select @rowguid3 as rowguid, @metadata_type3 as metadata_type, @lineage_old3 as lineage_old, @lineage_new3 as lineage_new, @generation3 as generation  union all 
    select @rowguid4 as rowguid, @metadata_type4 as metadata_type, @lineage_old4 as lineage_old, @lineage_new4 as lineage_new, @generation4 as generation  union all 
    select @rowguid5 as rowguid, @metadata_type5 as metadata_type, @lineage_old5 as lineage_old, @lineage_new5 as lineage_new, @generation5 as generation  union all 
    select @rowguid6 as rowguid, @metadata_type6 as metadata_type, @lineage_old6 as lineage_old, @lineage_new6 as lineage_new, @generation6 as generation  union all 
    select @rowguid7 as rowguid, @metadata_type7 as metadata_type, @lineage_old7 as lineage_old, @lineage_new7 as lineage_new, @generation7 as generation  union all 
    select @rowguid8 as rowguid, @metadata_type8 as metadata_type, @lineage_old8 as lineage_old, @lineage_new8 as lineage_new, @generation8 as generation  union all 
    select @rowguid9 as rowguid, @metadata_type9 as metadata_type, @lineage_old9 as lineage_old, @lineage_new9 as lineage_new, @generation9 as generation  union all 
    select @rowguid10 as rowguid, @metadata_type10 as metadata_type, @lineage_old10 as lineage_old, @lineage_new10 as lineage_new, @generation10 as generation 
 union all 
    select @rowguid11 as rowguid, @metadata_type11 as metadata_type, @lineage_old11 as lineage_old, @lineage_new11 as lineage_new, @generation11 as generation  union all 
    select @rowguid12 as rowguid, @metadata_type12 as metadata_type, @lineage_old12 as lineage_old, @lineage_new12 as lineage_new, @generation12 as generation  union all 
    select @rowguid13 as rowguid, @metadata_type13 as metadata_type, @lineage_old13 as lineage_old, @lineage_new13 as lineage_new, @generation13 as generation  union all 
    select @rowguid14 as rowguid, @metadata_type14 as metadata_type, @lineage_old14 as lineage_old, @lineage_new14 as lineage_new, @generation14 as generation  union all 
    select @rowguid15 as rowguid, @metadata_type15 as metadata_type, @lineage_old15 as lineage_old, @lineage_new15 as lineage_new, @generation15 as generation  union all 
    select @rowguid16 as rowguid, @metadata_type16 as metadata_type, @lineage_old16 as lineage_old, @lineage_new16 as lineage_new, @generation16 as generation  union all 
    select @rowguid17 as rowguid, @metadata_type17 as metadata_type, @lineage_old17 as lineage_old, @lineage_new17 as lineage_new, @generation17 as generation  union all 
    select @rowguid18 as rowguid, @metadata_type18 as metadata_type, @lineage_old18 as lineage_old, @lineage_new18 as lineage_new, @generation18 as generation  union all 
    select @rowguid19 as rowguid, @metadata_type19 as metadata_type, @lineage_old19 as lineage_old, @lineage_new19 as lineage_new, @generation19 as generation  union all 
    select @rowguid20 as rowguid, @metadata_type20 as metadata_type, @lineage_old20 as lineage_old, @lineage_new20 as lineage_new, @generation20 as generation 
 union all 
    select @rowguid21 as rowguid, @metadata_type21 as metadata_type, @lineage_old21 as lineage_old, @lineage_new21 as lineage_new, @generation21 as generation  union all 
    select @rowguid22 as rowguid, @metadata_type22 as metadata_type, @lineage_old22 as lineage_old, @lineage_new22 as lineage_new, @generation22 as generation  union all 
    select @rowguid23 as rowguid, @metadata_type23 as metadata_type, @lineage_old23 as lineage_old, @lineage_new23 as lineage_new, @generation23 as generation  union all 
    select @rowguid24 as rowguid, @metadata_type24 as metadata_type, @lineage_old24 as lineage_old, @lineage_new24 as lineage_new, @generation24 as generation  union all 
    select @rowguid25 as rowguid, @metadata_type25 as metadata_type, @lineage_old25 as lineage_old, @lineage_new25 as lineage_new, @generation25 as generation  union all 
    select @rowguid26 as rowguid, @metadata_type26 as metadata_type, @lineage_old26 as lineage_old, @lineage_new26 as lineage_new, @generation26 as generation  union all 
    select @rowguid27 as rowguid, @metadata_type27 as metadata_type, @lineage_old27 as lineage_old, @lineage_new27 as lineage_new, @generation27 as generation  union all 
    select @rowguid28 as rowguid, @metadata_type28 as metadata_type, @lineage_old28 as lineage_old, @lineage_new28 as lineage_new, @generation28 as generation  union all 
    select @rowguid29 as rowguid, @metadata_type29 as metadata_type, @lineage_old29 as lineage_old, @lineage_new29 as lineage_new, @generation29 as generation  union all 
    select @rowguid30 as rowguid, @metadata_type30 as metadata_type, @lineage_old30 as lineage_old, @lineage_new30 as lineage_new, @generation30 as generation 
 union all 
    select @rowguid31 as rowguid, @metadata_type31 as metadata_type, @lineage_old31 as lineage_old, @lineage_new31 as lineage_new, @generation31 as generation  union all 
    select @rowguid32 as rowguid, @metadata_type32 as metadata_type, @lineage_old32 as lineage_old, @lineage_new32 as lineage_new, @generation32 as generation  union all 
    select @rowguid33 as rowguid, @metadata_type33 as metadata_type, @lineage_old33 as lineage_old, @lineage_new33 as lineage_new, @generation33 as generation  union all 
    select @rowguid34 as rowguid, @metadata_type34 as metadata_type, @lineage_old34 as lineage_old, @lineage_new34 as lineage_new, @generation34 as generation  union all 
    select @rowguid35 as rowguid, @metadata_type35 as metadata_type, @lineage_old35 as lineage_old, @lineage_new35 as lineage_new, @generation35 as generation  union all 
    select @rowguid36 as rowguid, @metadata_type36 as metadata_type, @lineage_old36 as lineage_old, @lineage_new36 as lineage_new, @generation36 as generation  union all 
    select @rowguid37 as rowguid, @metadata_type37 as metadata_type, @lineage_old37 as lineage_old, @lineage_new37 as lineage_new, @generation37 as generation  union all 
    select @rowguid38 as rowguid, @metadata_type38 as metadata_type, @lineage_old38 as lineage_old, @lineage_new38 as lineage_new, @generation38 as generation  union all 
    select @rowguid39 as rowguid, @metadata_type39 as metadata_type, @lineage_old39 as lineage_old, @lineage_new39 as lineage_new, @generation39 as generation  union all 
    select @rowguid40 as rowguid, @metadata_type40 as metadata_type, @lineage_old40 as lineage_old, @lineage_new40 as lineage_new, @generation40 as generation 
 union all 
    select @rowguid41 as rowguid, @metadata_type41 as metadata_type, @lineage_old41 as lineage_old, @lineage_new41 as lineage_new, @generation41 as generation  union all 
    select @rowguid42 as rowguid, @metadata_type42 as metadata_type, @lineage_old42 as lineage_old, @lineage_new42 as lineage_new, @generation42 as generation  union all 
    select @rowguid43 as rowguid, @metadata_type43 as metadata_type, @lineage_old43 as lineage_old, @lineage_new43 as lineage_new, @generation43 as generation  union all 
    select @rowguid44 as rowguid, @metadata_type44 as metadata_type, @lineage_old44 as lineage_old, @lineage_new44 as lineage_new, @generation44 as generation  union all 
    select @rowguid45 as rowguid, @metadata_type45 as metadata_type, @lineage_old45 as lineage_old, @lineage_new45 as lineage_new, @generation45 as generation  union all 
    select @rowguid46 as rowguid, @metadata_type46 as metadata_type, @lineage_old46 as lineage_old, @lineage_new46 as lineage_new, @generation46 as generation  union all 
    select @rowguid47 as rowguid, @metadata_type47 as metadata_type, @lineage_old47 as lineage_old, @lineage_new47 as lineage_new, @generation47 as generation  union all 
    select @rowguid48 as rowguid, @metadata_type48 as metadata_type, @lineage_old48 as lineage_old, @lineage_new48 as lineage_new, @generation48 as generation  union all 
    select @rowguid49 as rowguid, @metadata_type49 as metadata_type, @lineage_old49 as lineage_old, @lineage_new49 as lineage_new, @generation49 as generation  union all 
    select @rowguid50 as rowguid, @metadata_type50 as metadata_type, @lineage_old50 as lineage_old, @lineage_new50 as lineage_new, @generation50 as generation 
 union all 
    select @rowguid51 as rowguid, @metadata_type51 as metadata_type, @lineage_old51 as lineage_old, @lineage_new51 as lineage_new, @generation51 as generation  union all 
    select @rowguid52 as rowguid, @metadata_type52 as metadata_type, @lineage_old52 as lineage_old, @lineage_new52 as lineage_new, @generation52 as generation  union all 
    select @rowguid53 as rowguid, @metadata_type53 as metadata_type, @lineage_old53 as lineage_old, @lineage_new53 as lineage_new, @generation53 as generation  union all 
    select @rowguid54 as rowguid, @metadata_type54 as metadata_type, @lineage_old54 as lineage_old, @lineage_new54 as lineage_new, @generation54 as generation  union all 
    select @rowguid55 as rowguid, @metadata_type55 as metadata_type, @lineage_old55 as lineage_old, @lineage_new55 as lineage_new, @generation55 as generation  union all 
    select @rowguid56 as rowguid, @metadata_type56 as metadata_type, @lineage_old56 as lineage_old, @lineage_new56 as lineage_new, @generation56 as generation  union all 
    select @rowguid57 as rowguid, @metadata_type57 as metadata_type, @lineage_old57 as lineage_old, @lineage_new57 as lineage_new, @generation57 as generation  union all 
    select @rowguid58 as rowguid, @metadata_type58 as metadata_type, @lineage_old58 as lineage_old, @lineage_new58 as lineage_new, @generation58 as generation  union all 
    select @rowguid59 as rowguid, @metadata_type59 as metadata_type, @lineage_old59 as lineage_old, @lineage_new59 as lineage_new, @generation59 as generation  union all 
    select @rowguid60 as rowguid, @metadata_type60 as metadata_type, @lineage_old60 as lineage_old, @lineage_new60 as lineage_new, @generation60 as generation 
 union all 
    select @rowguid61 as rowguid, @metadata_type61 as metadata_type, @lineage_old61 as lineage_old, @lineage_new61 as lineage_new, @generation61 as generation  union all 
    select @rowguid62 as rowguid, @metadata_type62 as metadata_type, @lineage_old62 as lineage_old, @lineage_new62 as lineage_new, @generation62 as generation  union all 
    select @rowguid63 as rowguid, @metadata_type63 as metadata_type, @lineage_old63 as lineage_old, @lineage_new63 as lineage_new, @generation63 as generation  union all 
    select @rowguid64 as rowguid, @metadata_type64 as metadata_type, @lineage_old64 as lineage_old, @lineage_new64 as lineage_new, @generation64 as generation  union all 
    select @rowguid65 as rowguid, @metadata_type65 as metadata_type, @lineage_old65 as lineage_old, @lineage_new65 as lineage_new, @generation65 as generation  union all 
    select @rowguid66 as rowguid, @metadata_type66 as metadata_type, @lineage_old66 as lineage_old, @lineage_new66 as lineage_new, @generation66 as generation  union all 
    select @rowguid67 as rowguid, @metadata_type67 as metadata_type, @lineage_old67 as lineage_old, @lineage_new67 as lineage_new, @generation67 as generation  union all 
    select @rowguid68 as rowguid, @metadata_type68 as metadata_type, @lineage_old68 as lineage_old, @lineage_new68 as lineage_new, @generation68 as generation  union all 
    select @rowguid69 as rowguid, @metadata_type69 as metadata_type, @lineage_old69 as lineage_old, @lineage_new69 as lineage_new, @generation69 as generation  union all 
    select @rowguid70 as rowguid, @metadata_type70 as metadata_type, @lineage_old70 as lineage_old, @lineage_new70 as lineage_new, @generation70 as generation 
 union all 
    select @rowguid71 as rowguid, @metadata_type71 as metadata_type, @lineage_old71 as lineage_old, @lineage_new71 as lineage_new, @generation71 as generation  union all 
    select @rowguid72 as rowguid, @metadata_type72 as metadata_type, @lineage_old72 as lineage_old, @lineage_new72 as lineage_new, @generation72 as generation  union all 
    select @rowguid73 as rowguid, @metadata_type73 as metadata_type, @lineage_old73 as lineage_old, @lineage_new73 as lineage_new, @generation73 as generation  union all 
    select @rowguid74 as rowguid, @metadata_type74 as metadata_type, @lineage_old74 as lineage_old, @lineage_new74 as lineage_new, @generation74 as generation  union all 
    select @rowguid75 as rowguid, @metadata_type75 as metadata_type, @lineage_old75 as lineage_old, @lineage_new75 as lineage_new, @generation75 as generation  union all 
    select @rowguid76 as rowguid, @metadata_type76 as metadata_type, @lineage_old76 as lineage_old, @lineage_new76 as lineage_new, @generation76 as generation  union all 
    select @rowguid77 as rowguid, @metadata_type77 as metadata_type, @lineage_old77 as lineage_old, @lineage_new77 as lineage_new, @generation77 as generation  union all 
    select @rowguid78 as rowguid, @metadata_type78 as metadata_type, @lineage_old78 as lineage_old, @lineage_new78 as lineage_new, @generation78 as generation  union all 
    select @rowguid79 as rowguid, @metadata_type79 as metadata_type, @lineage_old79 as lineage_old, @lineage_new79 as lineage_new, @generation79 as generation  union all 
    select @rowguid80 as rowguid, @metadata_type80 as metadata_type, @lineage_old80 as lineage_old, @lineage_new80 as lineage_new, @generation80 as generation 
 union all 
    select @rowguid81 as rowguid, @metadata_type81 as metadata_type, @lineage_old81 as lineage_old, @lineage_new81 as lineage_new, @generation81 as generation  union all 
    select @rowguid82 as rowguid, @metadata_type82 as metadata_type, @lineage_old82 as lineage_old, @lineage_new82 as lineage_new, @generation82 as generation  union all 
    select @rowguid83 as rowguid, @metadata_type83 as metadata_type, @lineage_old83 as lineage_old, @lineage_new83 as lineage_new, @generation83 as generation  union all 
    select @rowguid84 as rowguid, @metadata_type84 as metadata_type, @lineage_old84 as lineage_old, @lineage_new84 as lineage_new, @generation84 as generation  union all 
    select @rowguid85 as rowguid, @metadata_type85 as metadata_type, @lineage_old85 as lineage_old, @lineage_new85 as lineage_new, @generation85 as generation  union all 
    select @rowguid86 as rowguid, @metadata_type86 as metadata_type, @lineage_old86 as lineage_old, @lineage_new86 as lineage_new, @generation86 as generation  union all 
    select @rowguid87 as rowguid, @metadata_type87 as metadata_type, @lineage_old87 as lineage_old, @lineage_new87 as lineage_new, @generation87 as generation  union all 
    select @rowguid88 as rowguid, @metadata_type88 as metadata_type, @lineage_old88 as lineage_old, @lineage_new88 as lineage_new, @generation88 as generation  union all 
    select @rowguid89 as rowguid, @metadata_type89 as metadata_type, @lineage_old89 as lineage_old, @lineage_new89 as lineage_new, @generation89 as generation  union all 
    select @rowguid90 as rowguid, @metadata_type90 as metadata_type, @lineage_old90 as lineage_old, @lineage_new90 as lineage_new, @generation90 as generation 
 union all 
    select @rowguid91 as rowguid, @metadata_type91 as metadata_type, @lineage_old91 as lineage_old, @lineage_new91 as lineage_new, @generation91 as generation  union all 
    select @rowguid92 as rowguid, @metadata_type92 as metadata_type, @lineage_old92 as lineage_old, @lineage_new92 as lineage_new, @generation92 as generation  union all 
    select @rowguid93 as rowguid, @metadata_type93 as metadata_type, @lineage_old93 as lineage_old, @lineage_new93 as lineage_new, @generation93 as generation  union all 
    select @rowguid94 as rowguid, @metadata_type94 as metadata_type, @lineage_old94 as lineage_old, @lineage_new94 as lineage_new, @generation94 as generation  union all 
    select @rowguid95 as rowguid, @metadata_type95 as metadata_type, @lineage_old95 as lineage_old, @lineage_new95 as lineage_new, @generation95 as generation  union all 
    select @rowguid96 as rowguid, @metadata_type96 as metadata_type, @lineage_old96 as lineage_old, @lineage_new96 as lineage_new, @generation96 as generation  union all 
    select @rowguid97 as rowguid, @metadata_type97 as metadata_type, @lineage_old97 as lineage_old, @lineage_new97 as lineage_new, @generation97 as generation  union all 
    select @rowguid98 as rowguid, @metadata_type98 as metadata_type, @lineage_old98 as lineage_old, @lineage_new98 as lineage_new, @generation98 as generation  union all 
    select @rowguid99 as rowguid, @metadata_type99 as metadata_type, @lineage_old99 as lineage_old, @lineage_new99 as lineage_new, @generation99 as generation  union all 
    select @rowguid100 as rowguid, @metadata_type100 as metadata_type, @lineage_old100 as lineage_old, @lineage_new100 as lineage_new, @generation100 as generation 

        ) as rows
        inner join dbo.MSmerge_past_partition_mappings ppm with (rowlock) 
        on ppm.rowguid = rows.rowguid and ppm.tablenick = 31081000 
        and ppm.generation = 0
        and rows.rowguid is not NULL
        and rows.lineage_new is not null
        option (force order, loop join)
        if @error<>0
                goto Failure

    if @tomb_rows_updated <> @rowstobedeleted
    begin
        -- now insert rows that are not in tombstone
        insert into dbo.MSmerge_tombstone with (rowlock)
            (rowguid, tablenick, type, generation, lineage)
        select rows.rowguid, 31081000, 
               case when (rows.metadata_type=5 or rows.metadata_type=6) then rows.metadata_type else 1 end, 
               rows.generation, rows.lineage_new
        from 
        (

    select @rowguid1 as rowguid, @metadata_type1 as metadata_type, @lineage_old1 as lineage_old, @lineage_new1 as lineage_new, @generation1 as generation  union all 
    select @rowguid2 as rowguid, @metadata_type2 as metadata_type, @lineage_old2 as lineage_old, @lineage_new2 as lineage_new, @generation2 as generation  union all 
    select @rowguid3 as rowguid, @metadata_type3 as metadata_type, @lineage_old3 as lineage_old, @lineage_new3 as lineage_new, @generation3 as generation  union all 
    select @rowguid4 as rowguid, @metadata_type4 as metadata_type, @lineage_old4 as lineage_old, @lineage_new4 as lineage_new, @generation4 as generation  union all 
    select @rowguid5 as rowguid, @metadata_type5 as metadata_type, @lineage_old5 as lineage_old, @lineage_new5 as lineage_new, @generation5 as generation  union all 
    select @rowguid6 as rowguid, @metadata_type6 as metadata_type, @lineage_old6 as lineage_old, @lineage_new6 as lineage_new, @generation6 as generation  union all 
    select @rowguid7 as rowguid, @metadata_type7 as metadata_type, @lineage_old7 as lineage_old, @lineage_new7 as lineage_new, @generation7 as generation  union all 
    select @rowguid8 as rowguid, @metadata_type8 as metadata_type, @lineage_old8 as lineage_old, @lineage_new8 as lineage_new, @generation8 as generation  union all 
    select @rowguid9 as rowguid, @metadata_type9 as metadata_type, @lineage_old9 as lineage_old, @lineage_new9 as lineage_new, @generation9 as generation  union all 
    select @rowguid10 as rowguid, @metadata_type10 as metadata_type, @lineage_old10 as lineage_old, @lineage_new10 as lineage_new, @generation10 as generation 
 union all 
    select @rowguid11 as rowguid, @metadata_type11 as metadata_type, @lineage_old11 as lineage_old, @lineage_new11 as lineage_new, @generation11 as generation  union all 
    select @rowguid12 as rowguid, @metadata_type12 as metadata_type, @lineage_old12 as lineage_old, @lineage_new12 as lineage_new, @generation12 as generation  union all 
    select @rowguid13 as rowguid, @metadata_type13 as metadata_type, @lineage_old13 as lineage_old, @lineage_new13 as lineage_new, @generation13 as generation  union all 
    select @rowguid14 as rowguid, @metadata_type14 as metadata_type, @lineage_old14 as lineage_old, @lineage_new14 as lineage_new, @generation14 as generation  union all 
    select @rowguid15 as rowguid, @metadata_type15 as metadata_type, @lineage_old15 as lineage_old, @lineage_new15 as lineage_new, @generation15 as generation  union all 
    select @rowguid16 as rowguid, @metadata_type16 as metadata_type, @lineage_old16 as lineage_old, @lineage_new16 as lineage_new, @generation16 as generation  union all 
    select @rowguid17 as rowguid, @metadata_type17 as metadata_type, @lineage_old17 as lineage_old, @lineage_new17 as lineage_new, @generation17 as generation  union all 
    select @rowguid18 as rowguid, @metadata_type18 as metadata_type, @lineage_old18 as lineage_old, @lineage_new18 as lineage_new, @generation18 as generation  union all 
    select @rowguid19 as rowguid, @metadata_type19 as metadata_type, @lineage_old19 as lineage_old, @lineage_new19 as lineage_new, @generation19 as generation  union all 
    select @rowguid20 as rowguid, @metadata_type20 as metadata_type, @lineage_old20 as lineage_old, @lineage_new20 as lineage_new, @generation20 as generation 
 union all 
    select @rowguid21 as rowguid, @metadata_type21 as metadata_type, @lineage_old21 as lineage_old, @lineage_new21 as lineage_new, @generation21 as generation  union all 
    select @rowguid22 as rowguid, @metadata_type22 as metadata_type, @lineage_old22 as lineage_old, @lineage_new22 as lineage_new, @generation22 as generation  union all 
    select @rowguid23 as rowguid, @metadata_type23 as metadata_type, @lineage_old23 as lineage_old, @lineage_new23 as lineage_new, @generation23 as generation  union all 
    select @rowguid24 as rowguid, @metadata_type24 as metadata_type, @lineage_old24 as lineage_old, @lineage_new24 as lineage_new, @generation24 as generation  union all 
    select @rowguid25 as rowguid, @metadata_type25 as metadata_type, @lineage_old25 as lineage_old, @lineage_new25 as lineage_new, @generation25 as generation  union all 
    select @rowguid26 as rowguid, @metadata_type26 as metadata_type, @lineage_old26 as lineage_old, @lineage_new26 as lineage_new, @generation26 as generation  union all 
    select @rowguid27 as rowguid, @metadata_type27 as metadata_type, @lineage_old27 as lineage_old, @lineage_new27 as lineage_new, @generation27 as generation  union all 
    select @rowguid28 as rowguid, @metadata_type28 as metadata_type, @lineage_old28 as lineage_old, @lineage_new28 as lineage_new, @generation28 as generation  union all 
    select @rowguid29 as rowguid, @metadata_type29 as metadata_type, @lineage_old29 as lineage_old, @lineage_new29 as lineage_new, @generation29 as generation  union all 
    select @rowguid30 as rowguid, @metadata_type30 as metadata_type, @lineage_old30 as lineage_old, @lineage_new30 as lineage_new, @generation30 as generation 
 union all 
    select @rowguid31 as rowguid, @metadata_type31 as metadata_type, @lineage_old31 as lineage_old, @lineage_new31 as lineage_new, @generation31 as generation  union all 
    select @rowguid32 as rowguid, @metadata_type32 as metadata_type, @lineage_old32 as lineage_old, @lineage_new32 as lineage_new, @generation32 as generation  union all 
    select @rowguid33 as rowguid, @metadata_type33 as metadata_type, @lineage_old33 as lineage_old, @lineage_new33 as lineage_new, @generation33 as generation  union all 
    select @rowguid34 as rowguid, @metadata_type34 as metadata_type, @lineage_old34 as lineage_old, @lineage_new34 as lineage_new, @generation34 as generation  union all 
    select @rowguid35 as rowguid, @metadata_type35 as metadata_type, @lineage_old35 as lineage_old, @lineage_new35 as lineage_new, @generation35 as generation  union all 
    select @rowguid36 as rowguid, @metadata_type36 as metadata_type, @lineage_old36 as lineage_old, @lineage_new36 as lineage_new, @generation36 as generation  union all 
    select @rowguid37 as rowguid, @metadata_type37 as metadata_type, @lineage_old37 as lineage_old, @lineage_new37 as lineage_new, @generation37 as generation  union all 
    select @rowguid38 as rowguid, @metadata_type38 as metadata_type, @lineage_old38 as lineage_old, @lineage_new38 as lineage_new, @generation38 as generation  union all 
    select @rowguid39 as rowguid, @metadata_type39 as metadata_type, @lineage_old39 as lineage_old, @lineage_new39 as lineage_new, @generation39 as generation  union all 
    select @rowguid40 as rowguid, @metadata_type40 as metadata_type, @lineage_old40 as lineage_old, @lineage_new40 as lineage_new, @generation40 as generation 
 union all 
    select @rowguid41 as rowguid, @metadata_type41 as metadata_type, @lineage_old41 as lineage_old, @lineage_new41 as lineage_new, @generation41 as generation  union all 
    select @rowguid42 as rowguid, @metadata_type42 as metadata_type, @lineage_old42 as lineage_old, @lineage_new42 as lineage_new, @generation42 as generation  union all 
    select @rowguid43 as rowguid, @metadata_type43 as metadata_type, @lineage_old43 as lineage_old, @lineage_new43 as lineage_new, @generation43 as generation  union all 
    select @rowguid44 as rowguid, @metadata_type44 as metadata_type, @lineage_old44 as lineage_old, @lineage_new44 as lineage_new, @generation44 as generation  union all 
    select @rowguid45 as rowguid, @metadata_type45 as metadata_type, @lineage_old45 as lineage_old, @lineage_new45 as lineage_new, @generation45 as generation  union all 
    select @rowguid46 as rowguid, @metadata_type46 as metadata_type, @lineage_old46 as lineage_old, @lineage_new46 as lineage_new, @generation46 as generation  union all 
    select @rowguid47 as rowguid, @metadata_type47 as metadata_type, @lineage_old47 as lineage_old, @lineage_new47 as lineage_new, @generation47 as generation  union all 
    select @rowguid48 as rowguid, @metadata_type48 as metadata_type, @lineage_old48 as lineage_old, @lineage_new48 as lineage_new, @generation48 as generation  union all 
    select @rowguid49 as rowguid, @metadata_type49 as metadata_type, @lineage_old49 as lineage_old, @lineage_new49 as lineage_new, @generation49 as generation  union all 
    select @rowguid50 as rowguid, @metadata_type50 as metadata_type, @lineage_old50 as lineage_old, @lineage_new50 as lineage_new, @generation50 as generation 
 union all 
    select @rowguid51 as rowguid, @metadata_type51 as metadata_type, @lineage_old51 as lineage_old, @lineage_new51 as lineage_new, @generation51 as generation  union all 
    select @rowguid52 as rowguid, @metadata_type52 as metadata_type, @lineage_old52 as lineage_old, @lineage_new52 as lineage_new, @generation52 as generation  union all 
    select @rowguid53 as rowguid, @metadata_type53 as metadata_type, @lineage_old53 as lineage_old, @lineage_new53 as lineage_new, @generation53 as generation  union all 
    select @rowguid54 as rowguid, @metadata_type54 as metadata_type, @lineage_old54 as lineage_old, @lineage_new54 as lineage_new, @generation54 as generation  union all 
    select @rowguid55 as rowguid, @metadata_type55 as metadata_type, @lineage_old55 as lineage_old, @lineage_new55 as lineage_new, @generation55 as generation  union all 
    select @rowguid56 as rowguid, @metadata_type56 as metadata_type, @lineage_old56 as lineage_old, @lineage_new56 as lineage_new, @generation56 as generation  union all 
    select @rowguid57 as rowguid, @metadata_type57 as metadata_type, @lineage_old57 as lineage_old, @lineage_new57 as lineage_new, @generation57 as generation  union all 
    select @rowguid58 as rowguid, @metadata_type58 as metadata_type, @lineage_old58 as lineage_old, @lineage_new58 as lineage_new, @generation58 as generation  union all 
    select @rowguid59 as rowguid, @metadata_type59 as metadata_type, @lineage_old59 as lineage_old, @lineage_new59 as lineage_new, @generation59 as generation  union all 
    select @rowguid60 as rowguid, @metadata_type60 as metadata_type, @lineage_old60 as lineage_old, @lineage_new60 as lineage_new, @generation60 as generation 
 union all 
    select @rowguid61 as rowguid, @metadata_type61 as metadata_type, @lineage_old61 as lineage_old, @lineage_new61 as lineage_new, @generation61 as generation  union all 
    select @rowguid62 as rowguid, @metadata_type62 as metadata_type, @lineage_old62 as lineage_old, @lineage_new62 as lineage_new, @generation62 as generation  union all 
    select @rowguid63 as rowguid, @metadata_type63 as metadata_type, @lineage_old63 as lineage_old, @lineage_new63 as lineage_new, @generation63 as generation  union all 
    select @rowguid64 as rowguid, @metadata_type64 as metadata_type, @lineage_old64 as lineage_old, @lineage_new64 as lineage_new, @generation64 as generation  union all 
    select @rowguid65 as rowguid, @metadata_type65 as metadata_type, @lineage_old65 as lineage_old, @lineage_new65 as lineage_new, @generation65 as generation  union all 
    select @rowguid66 as rowguid, @metadata_type66 as metadata_type, @lineage_old66 as lineage_old, @lineage_new66 as lineage_new, @generation66 as generation  union all 
    select @rowguid67 as rowguid, @metadata_type67 as metadata_type, @lineage_old67 as lineage_old, @lineage_new67 as lineage_new, @generation67 as generation  union all 
    select @rowguid68 as rowguid, @metadata_type68 as metadata_type, @lineage_old68 as lineage_old, @lineage_new68 as lineage_new, @generation68 as generation  union all 
    select @rowguid69 as rowguid, @metadata_type69 as metadata_type, @lineage_old69 as lineage_old, @lineage_new69 as lineage_new, @generation69 as generation  union all 
    select @rowguid70 as rowguid, @metadata_type70 as metadata_type, @lineage_old70 as lineage_old, @lineage_new70 as lineage_new, @generation70 as generation 
 union all 
    select @rowguid71 as rowguid, @metadata_type71 as metadata_type, @lineage_old71 as lineage_old, @lineage_new71 as lineage_new, @generation71 as generation  union all 
    select @rowguid72 as rowguid, @metadata_type72 as metadata_type, @lineage_old72 as lineage_old, @lineage_new72 as lineage_new, @generation72 as generation  union all 
    select @rowguid73 as rowguid, @metadata_type73 as metadata_type, @lineage_old73 as lineage_old, @lineage_new73 as lineage_new, @generation73 as generation  union all 
    select @rowguid74 as rowguid, @metadata_type74 as metadata_type, @lineage_old74 as lineage_old, @lineage_new74 as lineage_new, @generation74 as generation  union all 
    select @rowguid75 as rowguid, @metadata_type75 as metadata_type, @lineage_old75 as lineage_old, @lineage_new75 as lineage_new, @generation75 as generation  union all 
    select @rowguid76 as rowguid, @metadata_type76 as metadata_type, @lineage_old76 as lineage_old, @lineage_new76 as lineage_new, @generation76 as generation  union all 
    select @rowguid77 as rowguid, @metadata_type77 as metadata_type, @lineage_old77 as lineage_old, @lineage_new77 as lineage_new, @generation77 as generation  union all 
    select @rowguid78 as rowguid, @metadata_type78 as metadata_type, @lineage_old78 as lineage_old, @lineage_new78 as lineage_new, @generation78 as generation  union all 
    select @rowguid79 as rowguid, @metadata_type79 as metadata_type, @lineage_old79 as lineage_old, @lineage_new79 as lineage_new, @generation79 as generation  union all 
    select @rowguid80 as rowguid, @metadata_type80 as metadata_type, @lineage_old80 as lineage_old, @lineage_new80 as lineage_new, @generation80 as generation 
 union all 
    select @rowguid81 as rowguid, @metadata_type81 as metadata_type, @lineage_old81 as lineage_old, @lineage_new81 as lineage_new, @generation81 as generation  union all 
    select @rowguid82 as rowguid, @metadata_type82 as metadata_type, @lineage_old82 as lineage_old, @lineage_new82 as lineage_new, @generation82 as generation  union all 
    select @rowguid83 as rowguid, @metadata_type83 as metadata_type, @lineage_old83 as lineage_old, @lineage_new83 as lineage_new, @generation83 as generation  union all 
    select @rowguid84 as rowguid, @metadata_type84 as metadata_type, @lineage_old84 as lineage_old, @lineage_new84 as lineage_new, @generation84 as generation  union all 
    select @rowguid85 as rowguid, @metadata_type85 as metadata_type, @lineage_old85 as lineage_old, @lineage_new85 as lineage_new, @generation85 as generation  union all 
    select @rowguid86 as rowguid, @metadata_type86 as metadata_type, @lineage_old86 as lineage_old, @lineage_new86 as lineage_new, @generation86 as generation  union all 
    select @rowguid87 as rowguid, @metadata_type87 as metadata_type, @lineage_old87 as lineage_old, @lineage_new87 as lineage_new, @generation87 as generation  union all 
    select @rowguid88 as rowguid, @metadata_type88 as metadata_type, @lineage_old88 as lineage_old, @lineage_new88 as lineage_new, @generation88 as generation  union all 
    select @rowguid89 as rowguid, @metadata_type89 as metadata_type, @lineage_old89 as lineage_old, @lineage_new89 as lineage_new, @generation89 as generation  union all 
    select @rowguid90 as rowguid, @metadata_type90 as metadata_type, @lineage_old90 as lineage_old, @lineage_new90 as lineage_new, @generation90 as generation 
 union all 
    select @rowguid91 as rowguid, @metadata_type91 as metadata_type, @lineage_old91 as lineage_old, @lineage_new91 as lineage_new, @generation91 as generation  union all 
    select @rowguid92 as rowguid, @metadata_type92 as metadata_type, @lineage_old92 as lineage_old, @lineage_new92 as lineage_new, @generation92 as generation  union all 
    select @rowguid93 as rowguid, @metadata_type93 as metadata_type, @lineage_old93 as lineage_old, @lineage_new93 as lineage_new, @generation93 as generation  union all 
    select @rowguid94 as rowguid, @metadata_type94 as metadata_type, @lineage_old94 as lineage_old, @lineage_new94 as lineage_new, @generation94 as generation  union all 
    select @rowguid95 as rowguid, @metadata_type95 as metadata_type, @lineage_old95 as lineage_old, @lineage_new95 as lineage_new, @generation95 as generation  union all 
    select @rowguid96 as rowguid, @metadata_type96 as metadata_type, @lineage_old96 as lineage_old, @lineage_new96 as lineage_new, @generation96 as generation  union all 
    select @rowguid97 as rowguid, @metadata_type97 as metadata_type, @lineage_old97 as lineage_old, @lineage_new97 as lineage_new, @generation97 as generation  union all 
    select @rowguid98 as rowguid, @metadata_type98 as metadata_type, @lineage_old98 as lineage_old, @lineage_new98 as lineage_new, @generation98 as generation  union all 
    select @rowguid99 as rowguid, @metadata_type99 as metadata_type, @lineage_old99 as lineage_old, @lineage_new99 as lineage_new, @generation99 as generation  union all 
    select @rowguid100 as rowguid, @metadata_type100 as metadata_type, @lineage_old100 as lineage_old, @lineage_new100 as lineage_new, @generation100 as generation 

        ) as rows
        left outer join dbo.MSmerge_tombstone tomb with (rowlock) 
        on tomb.rowguid = rows.rowguid 
        and tomb.tablenick = 31081000
        and rows.rowguid is not NULL and rows.lineage_new is not null
        where tomb.rowguid is NULL 
        and rows.rowguid is not NULL and rows.lineage_new is not null
        
        if @@error<>0
            goto Failure

        -- now delete the contents rows
        delete dbo.MSmerge_contents with (rowlock)
        from 
        (

         select @rowguid1 as rowguid union all 
         select @rowguid2 as rowguid union all 
         select @rowguid3 as rowguid union all 
         select @rowguid4 as rowguid union all 
         select @rowguid5 as rowguid union all 
         select @rowguid6 as rowguid union all 
         select @rowguid7 as rowguid union all 
         select @rowguid8 as rowguid union all 
         select @rowguid9 as rowguid union all 
         select @rowguid10 as rowguid union all 
         select @rowguid11 as rowguid union all 
         select @rowguid12 as rowguid union all 
         select @rowguid13 as rowguid union all 
         select @rowguid14 as rowguid union all 
         select @rowguid15 as rowguid union all 
         select @rowguid16 as rowguid union all 
         select @rowguid17 as rowguid union all 
         select @rowguid18 as rowguid union all 
         select @rowguid19 as rowguid union all 
         select @rowguid20 as rowguid union all 
         select @rowguid21 as rowguid union all 
         select @rowguid22 as rowguid union all 
         select @rowguid23 as rowguid union all 
         select @rowguid24 as rowguid union all 
         select @rowguid25 as rowguid union all 
         select @rowguid26 as rowguid union all 
         select @rowguid27 as rowguid union all 
         select @rowguid28 as rowguid union all 
         select @rowguid29 as rowguid union all 
         select @rowguid30 as rowguid union all 
         select @rowguid31 as rowguid union all 
         select @rowguid32 as rowguid union all 
         select @rowguid33 as rowguid union all 
         select @rowguid34 as rowguid union all 
         select @rowguid35 as rowguid union all 
         select @rowguid36 as rowguid union all 
         select @rowguid37 as rowguid union all 
         select @rowguid38 as rowguid union all 
         select @rowguid39 as rowguid union all 
         select @rowguid40 as rowguid union all 
         select @rowguid41 as rowguid union all 
         select @rowguid42 as rowguid union all 
         select @rowguid43 as rowguid union all 
         select @rowguid44 as rowguid union all 
         select @rowguid45 as rowguid union all 
         select @rowguid46 as rowguid union all 
         select @rowguid47 as rowguid union all 
         select @rowguid48 as rowguid union all 
         select @rowguid49 as rowguid union all 
         select @rowguid50 as rowguid union all

         select @rowguid51 as rowguid union all 
         select @rowguid52 as rowguid union all 
         select @rowguid53 as rowguid union all 
         select @rowguid54 as rowguid union all 
         select @rowguid55 as rowguid union all 
         select @rowguid56 as rowguid union all 
         select @rowguid57 as rowguid union all 
         select @rowguid58 as rowguid union all 
         select @rowguid59 as rowguid union all 
         select @rowguid60 as rowguid union all 
         select @rowguid61 as rowguid union all 
         select @rowguid62 as rowguid union all 
         select @rowguid63 as rowguid union all 
         select @rowguid64 as rowguid union all 
         select @rowguid65 as rowguid union all 
         select @rowguid66 as rowguid union all 
         select @rowguid67 as rowguid union all 
         select @rowguid68 as rowguid union all 
         select @rowguid69 as rowguid union all 
         select @rowguid70 as rowguid union all 
         select @rowguid71 as rowguid union all 
         select @rowguid72 as rowguid union all 
         select @rowguid73 as rowguid union all 
         select @rowguid74 as rowguid union all 
         select @rowguid75 as rowguid union all 
         select @rowguid76 as rowguid union all 
         select @rowguid77 as rowguid union all 
         select @rowguid78 as rowguid union all 
         select @rowguid79 as rowguid union all 
         select @rowguid80 as rowguid union all 
         select @rowguid81 as rowguid union all 
         select @rowguid82 as rowguid union all 
         select @rowguid83 as rowguid union all 
         select @rowguid84 as rowguid union all 
         select @rowguid85 as rowguid union all 
         select @rowguid86 as rowguid union all 
         select @rowguid87 as rowguid union all 
         select @rowguid88 as rowguid union all 
         select @rowguid89 as rowguid union all 
         select @rowguid90 as rowguid union all 
         select @rowguid91 as rowguid union all 
         select @rowguid92 as rowguid union all 
         select @rowguid93 as rowguid union all 
         select @rowguid94 as rowguid union all 
         select @rowguid95 as rowguid union all 
         select @rowguid96 as rowguid union all 
         select @rowguid97 as rowguid union all 
         select @rowguid98 as rowguid union all 
         select @rowguid99 as rowguid union all 
         select @rowguid100 as rowguid

        ) as rows, dbo.MSmerge_contents cont with (rowlock)
        where cont.rowguid = rows.rowguid and cont.tablenick = 31081000
            and rows.rowguid is not NULL
        option (force order, loop join)
        if @@error<>0 
            goto Failure
    end

    exec @retcode = sys.sp_MSdeletemetadataactionrequest '8D8B572F-B352-4CD3-9BF9-08911C828501', 31081000, 
        @rowguid1, 
        @rowguid2, 
        @rowguid3, 
        @rowguid4, 
        @rowguid5, 
        @rowguid6, 
        @rowguid7, 
        @rowguid8, 
        @rowguid9, 
        @rowguid10, 
        @rowguid11, 
        @rowguid12, 
        @rowguid13, 
        @rowguid14, 
        @rowguid15, 
        @rowguid16, 
        @rowguid17, 
        @rowguid18, 
        @rowguid19, 
        @rowguid20, 
        @rowguid21, 
        @rowguid22, 
        @rowguid23, 
        @rowguid24, 
        @rowguid25, 
        @rowguid26, 
        @rowguid27, 
        @rowguid28, 
        @rowguid29, 
        @rowguid30, 
        @rowguid31, 
        @rowguid32, 
        @rowguid33, 
        @rowguid34, 
        @rowguid35, 
        @rowguid36, 
        @rowguid37, 
        @rowguid38, 
        @rowguid39, 
        @rowguid40, 
        @rowguid41, 
        @rowguid42, 
        @rowguid43, 
        @rowguid44, 
        @rowguid45, 
        @rowguid46, 
        @rowguid47, 
        @rowguid48, 
        @rowguid49, 
        @rowguid50, 
        @rowguid51, 
        @rowguid52, 
        @rowguid53, 
        @rowguid54, 
        @rowguid55, 
        @rowguid56, 
        @rowguid57, 
        @rowguid58, 
        @rowguid59, 
        @rowguid60, 
        @rowguid61, 
        @rowguid62, 
        @rowguid63, 
        @rowguid64, 
        @rowguid65, 
        @rowguid66, 
        @rowguid67, 
        @rowguid68, 
        @rowguid69, 
        @rowguid70, 
        @rowguid71, 
        @rowguid72, 
        @rowguid73, 
        @rowguid74, 
        @rowguid75, 
        @rowguid76, 
        @rowguid77, 
        @rowguid78, 
        @rowguid79, 
        @rowguid80, 
        @rowguid81, 
        @rowguid82, 
        @rowguid83, 
        @rowguid84, 
        @rowguid85, 
        @rowguid86, 
        @rowguid87, 
        @rowguid88, 
        @rowguid89, 
        @rowguid90, 
        @rowguid91, 
        @rowguid92, 
        @rowguid93, 
        @rowguid94, 
        @rowguid95, 
        @rowguid96, 
        @rowguid97, 
        @rowguid98, 
        @rowguid99, 
        @rowguid100
    if @retcode<>0 or @@error<>0
        goto Failure


    commit tran
    return 1

Failure:
    rollback tran batchdeleteproc
    commit tran
    return 0
end

go
create procedure dbo.[MSmerge_ins_sp_BB5C29C42300434E8D8B572FB3524CD3_batch] (
        @rows_tobe_inserted int,
        @partition_id int = null 
,
    @rowguid1 uniqueidentifier = NULL,
    @generation1 bigint = NULL,
    @lineage1 varbinary(311) = NULL,
    @colv1 varbinary(1) = NULL,
    @p1 varchar(12) = NULL,
    @p2 nvarchar(50) = NULL,
    @p3 int = NULL,
    @p4 int = NULL,
    @p5 int = NULL,
    @p6 uniqueidentifier = NULL,
    @rowguid2 uniqueidentifier = NULL,
    @generation2 bigint = NULL,
    @lineage2 varbinary(311) = NULL,
    @colv2 varbinary(1) = NULL,
    @p7 varchar(12) = NULL,
    @p8 nvarchar(50) = NULL,
    @p9 int = NULL,
    @p10 int = NULL,
    @p11 int = NULL,
    @p12 uniqueidentifier = NULL,
    @rowguid3 uniqueidentifier = NULL,
    @generation3 bigint = NULL,
    @lineage3 varbinary(311) = NULL,
    @colv3 varbinary(1) = NULL,
    @p13 varchar(12) = NULL,
    @p14 nvarchar(50) = NULL,
    @p15 int = NULL,
    @p16 int = NULL,
    @p17 int = NULL,
    @p18 uniqueidentifier = NULL,
    @rowguid4 uniqueidentifier = NULL,
    @generation4 bigint = NULL,
    @lineage4 varbinary(311) = NULL,
    @colv4 varbinary(1) = NULL,
    @p19 varchar(12) = NULL,
    @p20 nvarchar(50) = NULL,
    @p21 int = NULL,
    @p22 int = NULL,
    @p23 int = NULL,
    @p24 uniqueidentifier = NULL,
    @rowguid5 uniqueidentifier = NULL,
    @generation5 bigint = NULL,
    @lineage5 varbinary(311) = NULL,
    @colv5 varbinary(1) = NULL,
    @p25 varchar(12) = NULL,
    @p26 nvarchar(50) = NULL,
    @p27 int = NULL,
    @p28 int = NULL,
    @p29 int = NULL,
    @p30 uniqueidentifier = NULL,
    @rowguid6 uniqueidentifier = NULL,
    @generation6 bigint = NULL,
    @lineage6 varbinary(311) = NULL,
    @colv6 varbinary(1) = NULL,
    @p31 varchar(12) = NULL,
    @p32 nvarchar(50) = NULL,
    @p33 int = NULL,
    @p34 int = NULL,
    @p35 int = NULL,
    @p36 uniqueidentifier = NULL,
    @rowguid7 uniqueidentifier = NULL,
    @generation7 bigint = NULL,
    @lineage7 varbinary(311) = NULL,
    @colv7 varbinary(1) = NULL,
    @p37 varchar(12) = NULL,
    @p38 nvarchar(50) = NULL,
    @p39 int = NULL,
    @p40 int = NULL,
    @p41 int = NULL,
    @p42 uniqueidentifier = NULL,
    @rowguid8 uniqueidentifier = NULL,
    @generation8 bigint = NULL,
    @lineage8 varbinary(311) = NULL,
    @colv8 varbinary(1) = NULL,
    @p43 varchar(12) = NULL,
    @p44 nvarchar(50) = NULL,
    @p45 int = NULL,
    @p46 int = NULL,
    @p47 int = NULL,
    @p48 uniqueidentifier = NULL,
    @rowguid9 uniqueidentifier = NULL,
    @generation9 bigint = NULL,
    @lineage9 varbinary(311) = NULL,
    @colv9 varbinary(1) = NULL,
    @p49 varchar(12) = NULL,
    @p50 nvarchar(50) = NULL,
    @p51 int = NULL,
    @p52 int = NULL,
    @p53 int = NULL,
    @p54 uniqueidentifier = NULL,
    @rowguid10 uniqueidentifier = NULL,
    @generation10 bigint = NULL,
    @lineage10 varbinary(311) = NULL,
    @colv10 varbinary(1) = NULL,
    @p55 varchar(12) = NULL,
    @p56 nvarchar(50) = NULL,
    @p57 int = NULL,
    @p58 int = NULL,
    @p59 int = NULL,
    @p60 uniqueidentifier = NULL,
    @rowguid11 uniqueidentifier = NULL,
    @generation11 bigint = NULL,
    @lineage11 varbinary(311) = NULL,
    @colv11 varbinary(1) = NULL,
    @p61 varchar(12) = NULL,
    @p62 nvarchar(50) = NULL,
    @p63 int = NULL,
    @p64 int = NULL,
    @p65 int = NULL,
    @p66 uniqueidentifier = NULL,
    @rowguid12 uniqueidentifier = NULL,
    @generation12 bigint = NULL,
    @lineage12 varbinary(311) = NULL,
    @colv12 varbinary(1) = NULL,
    @p67 varchar(12) = NULL,
    @p68 nvarchar(50) = NULL,
    @p69 int = NULL,
    @p70 int = NULL,
    @p71 int = NULL,
    @p72 uniqueidentifier = NULL,
    @rowguid13 uniqueidentifier = NULL,
    @generation13 bigint = NULL,
    @lineage13 varbinary(311) = NULL,
    @colv13 varbinary(1) = NULL,
    @p73 varchar(12) = NULL
,
    @p74 nvarchar(50) = NULL,
    @p75 int = NULL,
    @p76 int = NULL,
    @p77 int = NULL,
    @p78 uniqueidentifier = NULL,
    @rowguid14 uniqueidentifier = NULL,
    @generation14 bigint = NULL,
    @lineage14 varbinary(311) = NULL,
    @colv14 varbinary(1) = NULL,
    @p79 varchar(12) = NULL,
    @p80 nvarchar(50) = NULL,
    @p81 int = NULL,
    @p82 int = NULL,
    @p83 int = NULL,
    @p84 uniqueidentifier = NULL,
    @rowguid15 uniqueidentifier = NULL,
    @generation15 bigint = NULL,
    @lineage15 varbinary(311) = NULL,
    @colv15 varbinary(1) = NULL,
    @p85 varchar(12) = NULL,
    @p86 nvarchar(50) = NULL,
    @p87 int = NULL,
    @p88 int = NULL,
    @p89 int = NULL,
    @p90 uniqueidentifier = NULL,
    @rowguid16 uniqueidentifier = NULL,
    @generation16 bigint = NULL,
    @lineage16 varbinary(311) = NULL,
    @colv16 varbinary(1) = NULL,
    @p91 varchar(12) = NULL,
    @p92 nvarchar(50) = NULL,
    @p93 int = NULL,
    @p94 int = NULL,
    @p95 int = NULL,
    @p96 uniqueidentifier = NULL,
    @rowguid17 uniqueidentifier = NULL,
    @generation17 bigint = NULL,
    @lineage17 varbinary(311) = NULL,
    @colv17 varbinary(1) = NULL,
    @p97 varchar(12) = NULL,
    @p98 nvarchar(50) = NULL,
    @p99 int = NULL,
    @p100 int = NULL,
    @p101 int = NULL,
    @p102 uniqueidentifier = NULL,
    @rowguid18 uniqueidentifier = NULL,
    @generation18 bigint = NULL,
    @lineage18 varbinary(311) = NULL,
    @colv18 varbinary(1) = NULL,
    @p103 varchar(12) = NULL,
    @p104 nvarchar(50) = NULL,
    @p105 int = NULL,
    @p106 int = NULL,
    @p107 int = NULL,
    @p108 uniqueidentifier = NULL,
    @rowguid19 uniqueidentifier = NULL,
    @generation19 bigint = NULL,
    @lineage19 varbinary(311) = NULL,
    @colv19 varbinary(1) = NULL,
    @p109 varchar(12) = NULL,
    @p110 nvarchar(50) = NULL,
    @p111 int = NULL,
    @p112 int = NULL,
    @p113 int = NULL,
    @p114 uniqueidentifier = NULL,
    @rowguid20 uniqueidentifier = NULL,
    @generation20 bigint = NULL,
    @lineage20 varbinary(311) = NULL,
    @colv20 varbinary(1) = NULL,
    @p115 varchar(12) = NULL,
    @p116 nvarchar(50) = NULL,
    @p117 int = NULL,
    @p118 int = NULL,
    @p119 int = NULL,
    @p120 uniqueidentifier = NULL,
    @rowguid21 uniqueidentifier = NULL,
    @generation21 bigint = NULL,
    @lineage21 varbinary(311) = NULL,
    @colv21 varbinary(1) = NULL,
    @p121 varchar(12) = NULL,
    @p122 nvarchar(50) = NULL,
    @p123 int = NULL,
    @p124 int = NULL,
    @p125 int = NULL,
    @p126 uniqueidentifier = NULL,
    @rowguid22 uniqueidentifier = NULL,
    @generation22 bigint = NULL,
    @lineage22 varbinary(311) = NULL,
    @colv22 varbinary(1) = NULL,
    @p127 varchar(12) = NULL,
    @p128 nvarchar(50) = NULL,
    @p129 int = NULL,
    @p130 int = NULL,
    @p131 int = NULL,
    @p132 uniqueidentifier = NULL,
    @rowguid23 uniqueidentifier = NULL,
    @generation23 bigint = NULL,
    @lineage23 varbinary(311) = NULL,
    @colv23 varbinary(1) = NULL,
    @p133 varchar(12) = NULL,
    @p134 nvarchar(50) = NULL,
    @p135 int = NULL,
    @p136 int = NULL,
    @p137 int = NULL,
    @p138 uniqueidentifier = NULL,
    @rowguid24 uniqueidentifier = NULL,
    @generation24 bigint = NULL,
    @lineage24 varbinary(311) = NULL,
    @colv24 varbinary(1) = NULL,
    @p139 varchar(12) = NULL,
    @p140 nvarchar(50) = NULL,
    @p141 int = NULL,
    @p142 int = NULL,
    @p143 int = NULL,
    @p144 uniqueidentifier = NULL,
    @rowguid25 uniqueidentifier = NULL,
    @generation25 bigint = NULL,
    @lineage25 varbinary(311) = NULL,
    @colv25 varbinary(1) = NULL,
    @p145 varchar(12) = NULL
,
    @p146 nvarchar(50) = NULL,
    @p147 int = NULL,
    @p148 int = NULL,
    @p149 int = NULL,
    @p150 uniqueidentifier = NULL,
    @rowguid26 uniqueidentifier = NULL,
    @generation26 bigint = NULL,
    @lineage26 varbinary(311) = NULL,
    @colv26 varbinary(1) = NULL,
    @p151 varchar(12) = NULL,
    @p152 nvarchar(50) = NULL,
    @p153 int = NULL,
    @p154 int = NULL,
    @p155 int = NULL,
    @p156 uniqueidentifier = NULL,
    @rowguid27 uniqueidentifier = NULL,
    @generation27 bigint = NULL,
    @lineage27 varbinary(311) = NULL,
    @colv27 varbinary(1) = NULL,
    @p157 varchar(12) = NULL,
    @p158 nvarchar(50) = NULL,
    @p159 int = NULL,
    @p160 int = NULL,
    @p161 int = NULL,
    @p162 uniqueidentifier = NULL,
    @rowguid28 uniqueidentifier = NULL,
    @generation28 bigint = NULL,
    @lineage28 varbinary(311) = NULL,
    @colv28 varbinary(1) = NULL,
    @p163 varchar(12) = NULL,
    @p164 nvarchar(50) = NULL,
    @p165 int = NULL,
    @p166 int = NULL,
    @p167 int = NULL,
    @p168 uniqueidentifier = NULL,
    @rowguid29 uniqueidentifier = NULL,
    @generation29 bigint = NULL,
    @lineage29 varbinary(311) = NULL,
    @colv29 varbinary(1) = NULL,
    @p169 varchar(12) = NULL,
    @p170 nvarchar(50) = NULL,
    @p171 int = NULL,
    @p172 int = NULL,
    @p173 int = NULL,
    @p174 uniqueidentifier = NULL,
    @rowguid30 uniqueidentifier = NULL,
    @generation30 bigint = NULL,
    @lineage30 varbinary(311) = NULL,
    @colv30 varbinary(1) = NULL,
    @p175 varchar(12) = NULL,
    @p176 nvarchar(50) = NULL,
    @p177 int = NULL,
    @p178 int = NULL,
    @p179 int = NULL,
    @p180 uniqueidentifier = NULL,
    @rowguid31 uniqueidentifier = NULL,
    @generation31 bigint = NULL,
    @lineage31 varbinary(311) = NULL,
    @colv31 varbinary(1) = NULL,
    @p181 varchar(12) = NULL,
    @p182 nvarchar(50) = NULL,
    @p183 int = NULL,
    @p184 int = NULL,
    @p185 int = NULL,
    @p186 uniqueidentifier = NULL,
    @rowguid32 uniqueidentifier = NULL,
    @generation32 bigint = NULL,
    @lineage32 varbinary(311) = NULL,
    @colv32 varbinary(1) = NULL,
    @p187 varchar(12) = NULL,
    @p188 nvarchar(50) = NULL,
    @p189 int = NULL,
    @p190 int = NULL,
    @p191 int = NULL,
    @p192 uniqueidentifier = NULL,
    @rowguid33 uniqueidentifier = NULL,
    @generation33 bigint = NULL,
    @lineage33 varbinary(311) = NULL,
    @colv33 varbinary(1) = NULL,
    @p193 varchar(12) = NULL,
    @p194 nvarchar(50) = NULL,
    @p195 int = NULL,
    @p196 int = NULL,
    @p197 int = NULL,
    @p198 uniqueidentifier = NULL,
    @rowguid34 uniqueidentifier = NULL,
    @generation34 bigint = NULL,
    @lineage34 varbinary(311) = NULL,
    @colv34 varbinary(1) = NULL,
    @p199 varchar(12) = NULL,
    @p200 nvarchar(50) = NULL,
    @p201 int = NULL,
    @p202 int = NULL,
    @p203 int = NULL,
    @p204 uniqueidentifier = NULL,
    @rowguid35 uniqueidentifier = NULL,
    @generation35 bigint = NULL,
    @lineage35 varbinary(311) = NULL,
    @colv35 varbinary(1) = NULL,
    @p205 varchar(12) = NULL,
    @p206 nvarchar(50) = NULL,
    @p207 int = NULL,
    @p208 int = NULL,
    @p209 int = NULL,
    @p210 uniqueidentifier = NULL,
    @rowguid36 uniqueidentifier = NULL,
    @generation36 bigint = NULL,
    @lineage36 varbinary(311) = NULL,
    @colv36 varbinary(1) = NULL,
    @p211 varchar(12) = NULL,
    @p212 nvarchar(50) = NULL,
    @p213 int = NULL,
    @p214 int = NULL,
    @p215 int = NULL,
    @p216 uniqueidentifier = NULL,
    @rowguid37 uniqueidentifier = NULL,
    @generation37 bigint = NULL,
    @lineage37 varbinary(311) = NULL,
    @colv37 varbinary(1) = NULL,
    @p217 varchar(12) = NULL
,
    @p218 nvarchar(50) = NULL,
    @p219 int = NULL,
    @p220 int = NULL,
    @p221 int = NULL,
    @p222 uniqueidentifier = NULL,
    @rowguid38 uniqueidentifier = NULL,
    @generation38 bigint = NULL,
    @lineage38 varbinary(311) = NULL,
    @colv38 varbinary(1) = NULL,
    @p223 varchar(12) = NULL,
    @p224 nvarchar(50) = NULL,
    @p225 int = NULL,
    @p226 int = NULL,
    @p227 int = NULL,
    @p228 uniqueidentifier = NULL,
    @rowguid39 uniqueidentifier = NULL,
    @generation39 bigint = NULL,
    @lineage39 varbinary(311) = NULL,
    @colv39 varbinary(1) = NULL,
    @p229 varchar(12) = NULL,
    @p230 nvarchar(50) = NULL,
    @p231 int = NULL,
    @p232 int = NULL,
    @p233 int = NULL,
    @p234 uniqueidentifier = NULL,
    @rowguid40 uniqueidentifier = NULL,
    @generation40 bigint = NULL,
    @lineage40 varbinary(311) = NULL,
    @colv40 varbinary(1) = NULL,
    @p235 varchar(12) = NULL,
    @p236 nvarchar(50) = NULL,
    @p237 int = NULL,
    @p238 int = NULL,
    @p239 int = NULL,
    @p240 uniqueidentifier = NULL,
    @rowguid41 uniqueidentifier = NULL,
    @generation41 bigint = NULL,
    @lineage41 varbinary(311) = NULL,
    @colv41 varbinary(1) = NULL,
    @p241 varchar(12) = NULL,
    @p242 nvarchar(50) = NULL,
    @p243 int = NULL,
    @p244 int = NULL,
    @p245 int = NULL,
    @p246 uniqueidentifier = NULL,
    @rowguid42 uniqueidentifier = NULL,
    @generation42 bigint = NULL,
    @lineage42 varbinary(311) = NULL,
    @colv42 varbinary(1) = NULL,
    @p247 varchar(12) = NULL,
    @p248 nvarchar(50) = NULL,
    @p249 int = NULL,
    @p250 int = NULL,
    @p251 int = NULL,
    @p252 uniqueidentifier = NULL,
    @rowguid43 uniqueidentifier = NULL,
    @generation43 bigint = NULL,
    @lineage43 varbinary(311) = NULL,
    @colv43 varbinary(1) = NULL,
    @p253 varchar(12) = NULL,
    @p254 nvarchar(50) = NULL,
    @p255 int = NULL,
    @p256 int = NULL,
    @p257 int = NULL,
    @p258 uniqueidentifier = NULL,
    @rowguid44 uniqueidentifier = NULL,
    @generation44 bigint = NULL,
    @lineage44 varbinary(311) = NULL,
    @colv44 varbinary(1) = NULL,
    @p259 varchar(12) = NULL,
    @p260 nvarchar(50) = NULL,
    @p261 int = NULL,
    @p262 int = NULL,
    @p263 int = NULL,
    @p264 uniqueidentifier = NULL,
    @rowguid45 uniqueidentifier = NULL,
    @generation45 bigint = NULL,
    @lineage45 varbinary(311) = NULL,
    @colv45 varbinary(1) = NULL,
    @p265 varchar(12) = NULL,
    @p266 nvarchar(50) = NULL,
    @p267 int = NULL,
    @p268 int = NULL,
    @p269 int = NULL,
    @p270 uniqueidentifier = NULL,
    @rowguid46 uniqueidentifier = NULL,
    @generation46 bigint = NULL,
    @lineage46 varbinary(311) = NULL,
    @colv46 varbinary(1) = NULL,
    @p271 varchar(12) = NULL,
    @p272 nvarchar(50) = NULL,
    @p273 int = NULL,
    @p274 int = NULL,
    @p275 int = NULL,
    @p276 uniqueidentifier = NULL,
    @rowguid47 uniqueidentifier = NULL,
    @generation47 bigint = NULL,
    @lineage47 varbinary(311) = NULL,
    @colv47 varbinary(1) = NULL,
    @p277 varchar(12) = NULL,
    @p278 nvarchar(50) = NULL,
    @p279 int = NULL,
    @p280 int = NULL,
    @p281 int = NULL,
    @p282 uniqueidentifier = NULL,
    @rowguid48 uniqueidentifier = NULL,
    @generation48 bigint = NULL,
    @lineage48 varbinary(311) = NULL,
    @colv48 varbinary(1) = NULL,
    @p283 varchar(12) = NULL,
    @p284 nvarchar(50) = NULL,
    @p285 int = NULL,
    @p286 int = NULL,
    @p287 int = NULL,
    @p288 uniqueidentifier = NULL,
    @rowguid49 uniqueidentifier = NULL,
    @generation49 bigint = NULL,
    @lineage49 varbinary(311) = NULL,
    @colv49 varbinary(1) = NULL,
    @p289 varchar(12) = NULL
,
    @p290 nvarchar(50) = NULL,
    @p291 int = NULL,
    @p292 int = NULL,
    @p293 int = NULL,
    @p294 uniqueidentifier = NULL,
    @rowguid50 uniqueidentifier = NULL,
    @generation50 bigint = NULL,
    @lineage50 varbinary(311) = NULL,
    @colv50 varbinary(1) = NULL,
    @p295 varchar(12) = NULL,
    @p296 nvarchar(50) = NULL,
    @p297 int = NULL,
    @p298 int = NULL,
    @p299 int = NULL,
    @p300 uniqueidentifier = NULL,
    @rowguid51 uniqueidentifier = NULL,
    @generation51 bigint = NULL,
    @lineage51 varbinary(311) = NULL,
    @colv51 varbinary(1) = NULL,
    @p301 varchar(12) = NULL,
    @p302 nvarchar(50) = NULL,
    @p303 int = NULL,
    @p304 int = NULL,
    @p305 int = NULL,
    @p306 uniqueidentifier = NULL,
    @rowguid52 uniqueidentifier = NULL,
    @generation52 bigint = NULL,
    @lineage52 varbinary(311) = NULL,
    @colv52 varbinary(1) = NULL,
    @p307 varchar(12) = NULL,
    @p308 nvarchar(50) = NULL,
    @p309 int = NULL,
    @p310 int = NULL,
    @p311 int = NULL,
    @p312 uniqueidentifier = NULL,
    @rowguid53 uniqueidentifier = NULL,
    @generation53 bigint = NULL,
    @lineage53 varbinary(311) = NULL,
    @colv53 varbinary(1) = NULL,
    @p313 varchar(12) = NULL,
    @p314 nvarchar(50) = NULL,
    @p315 int = NULL,
    @p316 int = NULL,
    @p317 int = NULL,
    @p318 uniqueidentifier = NULL,
    @rowguid54 uniqueidentifier = NULL,
    @generation54 bigint = NULL,
    @lineage54 varbinary(311) = NULL,
    @colv54 varbinary(1) = NULL,
    @p319 varchar(12) = NULL,
    @p320 nvarchar(50) = NULL,
    @p321 int = NULL,
    @p322 int = NULL,
    @p323 int = NULL,
    @p324 uniqueidentifier = NULL,
    @rowguid55 uniqueidentifier = NULL,
    @generation55 bigint = NULL,
    @lineage55 varbinary(311) = NULL,
    @colv55 varbinary(1) = NULL,
    @p325 varchar(12) = NULL,
    @p326 nvarchar(50) = NULL,
    @p327 int = NULL,
    @p328 int = NULL,
    @p329 int = NULL,
    @p330 uniqueidentifier = NULL,
    @rowguid56 uniqueidentifier = NULL,
    @generation56 bigint = NULL,
    @lineage56 varbinary(311) = NULL,
    @colv56 varbinary(1) = NULL,
    @p331 varchar(12) = NULL,
    @p332 nvarchar(50) = NULL,
    @p333 int = NULL,
    @p334 int = NULL,
    @p335 int = NULL,
    @p336 uniqueidentifier = NULL,
    @rowguid57 uniqueidentifier = NULL,
    @generation57 bigint = NULL,
    @lineage57 varbinary(311) = NULL,
    @colv57 varbinary(1) = NULL,
    @p337 varchar(12) = NULL,
    @p338 nvarchar(50) = NULL,
    @p339 int = NULL,
    @p340 int = NULL,
    @p341 int = NULL,
    @p342 uniqueidentifier = NULL,
    @rowguid58 uniqueidentifier = NULL,
    @generation58 bigint = NULL,
    @lineage58 varbinary(311) = NULL,
    @colv58 varbinary(1) = NULL,
    @p343 varchar(12) = NULL,
    @p344 nvarchar(50) = NULL,
    @p345 int = NULL,
    @p346 int = NULL,
    @p347 int = NULL,
    @p348 uniqueidentifier = NULL,
    @rowguid59 uniqueidentifier = NULL,
    @generation59 bigint = NULL,
    @lineage59 varbinary(311) = NULL,
    @colv59 varbinary(1) = NULL,
    @p349 varchar(12) = NULL,
    @p350 nvarchar(50) = NULL,
    @p351 int = NULL,
    @p352 int = NULL,
    @p353 int = NULL,
    @p354 uniqueidentifier = NULL,
    @rowguid60 uniqueidentifier = NULL,
    @generation60 bigint = NULL,
    @lineage60 varbinary(311) = NULL,
    @colv60 varbinary(1) = NULL,
    @p355 varchar(12) = NULL,
    @p356 nvarchar(50) = NULL,
    @p357 int = NULL,
    @p358 int = NULL,
    @p359 int = NULL,
    @p360 uniqueidentifier = NULL,
    @rowguid61 uniqueidentifier = NULL,
    @generation61 bigint = NULL,
    @lineage61 varbinary(311) = NULL,
    @colv61 varbinary(1) = NULL,
    @p361 varchar(12) = NULL
,
    @p362 nvarchar(50) = NULL,
    @p363 int = NULL,
    @p364 int = NULL,
    @p365 int = NULL,
    @p366 uniqueidentifier = NULL,
    @rowguid62 uniqueidentifier = NULL,
    @generation62 bigint = NULL,
    @lineage62 varbinary(311) = NULL,
    @colv62 varbinary(1) = NULL,
    @p367 varchar(12) = NULL,
    @p368 nvarchar(50) = NULL,
    @p369 int = NULL,
    @p370 int = NULL,
    @p371 int = NULL,
    @p372 uniqueidentifier = NULL,
    @rowguid63 uniqueidentifier = NULL,
    @generation63 bigint = NULL,
    @lineage63 varbinary(311) = NULL,
    @colv63 varbinary(1) = NULL,
    @p373 varchar(12) = NULL,
    @p374 nvarchar(50) = NULL,
    @p375 int = NULL,
    @p376 int = NULL,
    @p377 int = NULL,
    @p378 uniqueidentifier = NULL,
    @rowguid64 uniqueidentifier = NULL,
    @generation64 bigint = NULL,
    @lineage64 varbinary(311) = NULL,
    @colv64 varbinary(1) = NULL,
    @p379 varchar(12) = NULL,
    @p380 nvarchar(50) = NULL,
    @p381 int = NULL,
    @p382 int = NULL,
    @p383 int = NULL,
    @p384 uniqueidentifier = NULL,
    @rowguid65 uniqueidentifier = NULL,
    @generation65 bigint = NULL,
    @lineage65 varbinary(311) = NULL,
    @colv65 varbinary(1) = NULL,
    @p385 varchar(12) = NULL,
    @p386 nvarchar(50) = NULL,
    @p387 int = NULL,
    @p388 int = NULL,
    @p389 int = NULL,
    @p390 uniqueidentifier = NULL,
    @rowguid66 uniqueidentifier = NULL,
    @generation66 bigint = NULL,
    @lineage66 varbinary(311) = NULL,
    @colv66 varbinary(1) = NULL,
    @p391 varchar(12) = NULL,
    @p392 nvarchar(50) = NULL,
    @p393 int = NULL,
    @p394 int = NULL,
    @p395 int = NULL,
    @p396 uniqueidentifier = NULL,
    @rowguid67 uniqueidentifier = NULL,
    @generation67 bigint = NULL,
    @lineage67 varbinary(311) = NULL,
    @colv67 varbinary(1) = NULL,
    @p397 varchar(12) = NULL,
    @p398 nvarchar(50) = NULL,
    @p399 int = NULL,
    @p400 int = NULL,
    @p401 int = NULL,
    @p402 uniqueidentifier = NULL,
    @rowguid68 uniqueidentifier = NULL,
    @generation68 bigint = NULL,
    @lineage68 varbinary(311) = NULL,
    @colv68 varbinary(1) = NULL,
    @p403 varchar(12) = NULL,
    @p404 nvarchar(50) = NULL,
    @p405 int = NULL,
    @p406 int = NULL,
    @p407 int = NULL,
    @p408 uniqueidentifier = NULL,
    @rowguid69 uniqueidentifier = NULL,
    @generation69 bigint = NULL,
    @lineage69 varbinary(311) = NULL,
    @colv69 varbinary(1) = NULL,
    @p409 varchar(12) = NULL,
    @p410 nvarchar(50) = NULL,
    @p411 int = NULL,
    @p412 int = NULL,
    @p413 int = NULL,
    @p414 uniqueidentifier = NULL,
    @rowguid70 uniqueidentifier = NULL,
    @generation70 bigint = NULL,
    @lineage70 varbinary(311) = NULL,
    @colv70 varbinary(1) = NULL,
    @p415 varchar(12) = NULL,
    @p416 nvarchar(50) = NULL,
    @p417 int = NULL,
    @p418 int = NULL,
    @p419 int = NULL,
    @p420 uniqueidentifier = NULL,
    @rowguid71 uniqueidentifier = NULL,
    @generation71 bigint = NULL,
    @lineage71 varbinary(311) = NULL,
    @colv71 varbinary(1) = NULL,
    @p421 varchar(12) = NULL,
    @p422 nvarchar(50) = NULL,
    @p423 int = NULL,
    @p424 int = NULL,
    @p425 int = NULL,
    @p426 uniqueidentifier = NULL,
    @rowguid72 uniqueidentifier = NULL,
    @generation72 bigint = NULL,
    @lineage72 varbinary(311) = NULL,
    @colv72 varbinary(1) = NULL,
    @p427 varchar(12) = NULL,
    @p428 nvarchar(50) = NULL,
    @p429 int = NULL,
    @p430 int = NULL,
    @p431 int = NULL,
    @p432 uniqueidentifier = NULL,
    @rowguid73 uniqueidentifier = NULL,
    @generation73 bigint = NULL,
    @lineage73 varbinary(311) = NULL,
    @colv73 varbinary(1) = NULL,
    @p433 varchar(12) = NULL
,
    @p434 nvarchar(50) = NULL,
    @p435 int = NULL,
    @p436 int = NULL,
    @p437 int = NULL,
    @p438 uniqueidentifier = NULL,
    @rowguid74 uniqueidentifier = NULL,
    @generation74 bigint = NULL,
    @lineage74 varbinary(311) = NULL,
    @colv74 varbinary(1) = NULL,
    @p439 varchar(12) = NULL,
    @p440 nvarchar(50) = NULL,
    @p441 int = NULL,
    @p442 int = NULL,
    @p443 int = NULL,
    @p444 uniqueidentifier = NULL,
    @rowguid75 uniqueidentifier = NULL,
    @generation75 bigint = NULL,
    @lineage75 varbinary(311) = NULL,
    @colv75 varbinary(1) = NULL,
    @p445 varchar(12) = NULL,
    @p446 nvarchar(50) = NULL,
    @p447 int = NULL,
    @p448 int = NULL,
    @p449 int = NULL,
    @p450 uniqueidentifier = NULL,
    @rowguid76 uniqueidentifier = NULL,
    @generation76 bigint = NULL,
    @lineage76 varbinary(311) = NULL,
    @colv76 varbinary(1) = NULL,
    @p451 varchar(12) = NULL,
    @p452 nvarchar(50) = NULL,
    @p453 int = NULL,
    @p454 int = NULL,
    @p455 int = NULL,
    @p456 uniqueidentifier = NULL,
    @rowguid77 uniqueidentifier = NULL,
    @generation77 bigint = NULL,
    @lineage77 varbinary(311) = NULL,
    @colv77 varbinary(1) = NULL,
    @p457 varchar(12) = NULL,
    @p458 nvarchar(50) = NULL,
    @p459 int = NULL,
    @p460 int = NULL,
    @p461 int = NULL,
    @p462 uniqueidentifier = NULL,
    @rowguid78 uniqueidentifier = NULL,
    @generation78 bigint = NULL,
    @lineage78 varbinary(311) = NULL,
    @colv78 varbinary(1) = NULL,
    @p463 varchar(12) = NULL,
    @p464 nvarchar(50) = NULL,
    @p465 int = NULL,
    @p466 int = NULL,
    @p467 int = NULL,
    @p468 uniqueidentifier = NULL,
    @rowguid79 uniqueidentifier = NULL,
    @generation79 bigint = NULL,
    @lineage79 varbinary(311) = NULL,
    @colv79 varbinary(1) = NULL,
    @p469 varchar(12) = NULL,
    @p470 nvarchar(50) = NULL,
    @p471 int = NULL,
    @p472 int = NULL,
    @p473 int = NULL,
    @p474 uniqueidentifier = NULL,
    @rowguid80 uniqueidentifier = NULL,
    @generation80 bigint = NULL,
    @lineage80 varbinary(311) = NULL,
    @colv80 varbinary(1) = NULL,
    @p475 varchar(12) = NULL,
    @p476 nvarchar(50) = NULL,
    @p477 int = NULL,
    @p478 int = NULL,
    @p479 int = NULL,
    @p480 uniqueidentifier = NULL,
    @rowguid81 uniqueidentifier = NULL,
    @generation81 bigint = NULL,
    @lineage81 varbinary(311) = NULL,
    @colv81 varbinary(1) = NULL,
    @p481 varchar(12) = NULL,
    @p482 nvarchar(50) = NULL,
    @p483 int = NULL,
    @p484 int = NULL,
    @p485 int = NULL,
    @p486 uniqueidentifier = NULL,
    @rowguid82 uniqueidentifier = NULL,
    @generation82 bigint = NULL,
    @lineage82 varbinary(311) = NULL,
    @colv82 varbinary(1) = NULL,
    @p487 varchar(12) = NULL,
    @p488 nvarchar(50) = NULL,
    @p489 int = NULL,
    @p490 int = NULL,
    @p491 int = NULL,
    @p492 uniqueidentifier = NULL,
    @rowguid83 uniqueidentifier = NULL,
    @generation83 bigint = NULL,
    @lineage83 varbinary(311) = NULL,
    @colv83 varbinary(1) = NULL,
    @p493 varchar(12) = NULL,
    @p494 nvarchar(50) = NULL,
    @p495 int = NULL,
    @p496 int = NULL,
    @p497 int = NULL,
    @p498 uniqueidentifier = NULL,
    @rowguid84 uniqueidentifier = NULL,
    @generation84 bigint = NULL,
    @lineage84 varbinary(311) = NULL,
    @colv84 varbinary(1) = NULL,
    @p499 varchar(12) = NULL,
    @p500 nvarchar(50) = NULL,
    @p501 int = NULL,
    @p502 int = NULL,
    @p503 int = NULL,
    @p504 uniqueidentifier = NULL,
    @rowguid85 uniqueidentifier = NULL,
    @generation85 bigint = NULL,
    @lineage85 varbinary(311) = NULL,
    @colv85 varbinary(1) = NULL,
    @p505 varchar(12) = NULL
,
    @p506 nvarchar(50) = NULL,
    @p507 int = NULL,
    @p508 int = NULL,
    @p509 int = NULL,
    @p510 uniqueidentifier = NULL,
    @rowguid86 uniqueidentifier = NULL,
    @generation86 bigint = NULL,
    @lineage86 varbinary(311) = NULL,
    @colv86 varbinary(1) = NULL,
    @p511 varchar(12) = NULL,
    @p512 nvarchar(50) = NULL,
    @p513 int = NULL,
    @p514 int = NULL,
    @p515 int = NULL,
    @p516 uniqueidentifier = NULL,
    @rowguid87 uniqueidentifier = NULL,
    @generation87 bigint = NULL,
    @lineage87 varbinary(311) = NULL,
    @colv87 varbinary(1) = NULL,
    @p517 varchar(12) = NULL,
    @p518 nvarchar(50) = NULL,
    @p519 int = NULL,
    @p520 int = NULL,
    @p521 int = NULL,
    @p522 uniqueidentifier = NULL,
    @rowguid88 uniqueidentifier = NULL,
    @generation88 bigint = NULL,
    @lineage88 varbinary(311) = NULL,
    @colv88 varbinary(1) = NULL,
    @p523 varchar(12) = NULL,
    @p524 nvarchar(50) = NULL,
    @p525 int = NULL,
    @p526 int = NULL,
    @p527 int = NULL,
    @p528 uniqueidentifier = NULL,
    @rowguid89 uniqueidentifier = NULL,
    @generation89 bigint = NULL,
    @lineage89 varbinary(311) = NULL,
    @colv89 varbinary(1) = NULL,
    @p529 varchar(12) = NULL,
    @p530 nvarchar(50) = NULL,
    @p531 int = NULL,
    @p532 int = NULL,
    @p533 int = NULL,
    @p534 uniqueidentifier = NULL,
    @rowguid90 uniqueidentifier = NULL,
    @generation90 bigint = NULL,
    @lineage90 varbinary(311) = NULL,
    @colv90 varbinary(1) = NULL,
    @p535 varchar(12) = NULL,
    @p536 nvarchar(50) = NULL,
    @p537 int = NULL,
    @p538 int = NULL,
    @p539 int = NULL,
    @p540 uniqueidentifier = NULL,
    @rowguid91 uniqueidentifier = NULL,
    @generation91 bigint = NULL,
    @lineage91 varbinary(311) = NULL,
    @colv91 varbinary(1) = NULL,
    @p541 varchar(12) = NULL,
    @p542 nvarchar(50) = NULL,
    @p543 int = NULL,
    @p544 int = NULL,
    @p545 int = NULL,
    @p546 uniqueidentifier = NULL,
    @rowguid92 uniqueidentifier = NULL,
    @generation92 bigint = NULL,
    @lineage92 varbinary(311) = NULL,
    @colv92 varbinary(1) = NULL,
    @p547 varchar(12) = NULL,
    @p548 nvarchar(50) = NULL,
    @p549 int = NULL,
    @p550 int = NULL,
    @p551 int = NULL,
    @p552 uniqueidentifier = NULL,
    @rowguid93 uniqueidentifier = NULL,
    @generation93 bigint = NULL,
    @lineage93 varbinary(311) = NULL,
    @colv93 varbinary(1) = NULL,
    @p553 varchar(12) = NULL,
    @p554 nvarchar(50) = NULL,
    @p555 int = NULL,
    @p556 int = NULL,
    @p557 int = NULL,
    @p558 uniqueidentifier = NULL,
    @rowguid94 uniqueidentifier = NULL,
    @generation94 bigint = NULL,
    @lineage94 varbinary(311) = NULL,
    @colv94 varbinary(1) = NULL,
    @p559 varchar(12) = NULL,
    @p560 nvarchar(50) = NULL,
    @p561 int = NULL,
    @p562 int = NULL,
    @p563 int = NULL,
    @p564 uniqueidentifier = NULL,
    @rowguid95 uniqueidentifier = NULL,
    @generation95 bigint = NULL,
    @lineage95 varbinary(311) = NULL,
    @colv95 varbinary(1) = NULL,
    @p565 varchar(12) = NULL,
    @p566 nvarchar(50) = NULL,
    @p567 int = NULL,
    @p568 int = NULL,
    @p569 int = NULL,
    @p570 uniqueidentifier = NULL,
    @rowguid96 uniqueidentifier = NULL,
    @generation96 bigint = NULL,
    @lineage96 varbinary(311) = NULL,
    @colv96 varbinary(1) = NULL,
    @p571 varchar(12) = NULL,
    @p572 nvarchar(50) = NULL,
    @p573 int = NULL,
    @p574 int = NULL,
    @p575 int = NULL,
    @p576 uniqueidentifier = NULL,
    @rowguid97 uniqueidentifier = NULL,
    @generation97 bigint = NULL,
    @lineage97 varbinary(311) = NULL,
    @colv97 varbinary(1) = NULL,
    @p577 varchar(12) = NULL
,
    @p578 nvarchar(50) = NULL,
    @p579 int = NULL,
    @p580 int = NULL,
    @p581 int = NULL,
    @p582 uniqueidentifier = NULL,
    @rowguid98 uniqueidentifier = NULL,
    @generation98 bigint = NULL,
    @lineage98 varbinary(311) = NULL,
    @colv98 varbinary(1) = NULL,
    @p583 varchar(12) = NULL,
    @p584 nvarchar(50) = NULL,
    @p585 int = NULL,
    @p586 int = NULL,
    @p587 int = NULL,
    @p588 uniqueidentifier = NULL,
    @rowguid99 uniqueidentifier = NULL,
    @generation99 bigint = NULL,
    @lineage99 varbinary(311) = NULL,
    @colv99 varbinary(1) = NULL,
    @p589 varchar(12) = NULL,
    @p590 nvarchar(50) = NULL,
    @p591 int = NULL,
    @p592 int = NULL,
    @p593 int = NULL,
    @p594 uniqueidentifier = NULL,
    @rowguid100 uniqueidentifier = NULL,
    @generation100 bigint = NULL,
    @lineage100 varbinary(311) = NULL,
    @colv100 varbinary(1) = NULL,
    @p595 varchar(12) = NULL
,
    @p596 nvarchar(50) = NULL
,
    @p597 int = NULL
,
    @p598 int = NULL
,
    @p599 int = NULL
,
    @p600 uniqueidentifier = NULL

) as
begin
    declare @errcode    int
    declare @retcode    int
    declare @rowcount   int
    declare @error      int
    declare @rows_in_contents int
    declare @rows_inserted_into_contents int
    declare @publication_number smallint
    declare @gen_cur bigint
    declare @rows_in_tomb bit
    declare @rows_in_syncview int
    declare @marker uniqueidentifier
    
    set nocount on
    
    set @errcode= 0
    set @publication_number = 4
    
    if ({ fn ISPALUSER('8D8B572F-B352-4CD3-9BF9-08911C828501') } <> 1)
    begin
        RAISERROR (14126, 11, -1)
        return 4
    end

    if @rows_tobe_inserted is NULL or @rows_tobe_inserted <=0
        return 0



    begin tran
    save tran batchinsertproc 

    exec @retcode = sys.sp_MSmerge_getgencur_public 31081000, @rows_tobe_inserted, @gen_cur output
    if @retcode<>0 or @@error<>0
        return 4



    select @rows_in_tomb = 0
    select @rows_in_tomb = 1 from (

         select @rowguid1 as rowguid union all 
         select @rowguid2 as rowguid union all 
         select @rowguid3 as rowguid union all 
         select @rowguid4 as rowguid union all 
         select @rowguid5 as rowguid union all 
         select @rowguid6 as rowguid union all 
         select @rowguid7 as rowguid union all 
         select @rowguid8 as rowguid union all 
         select @rowguid9 as rowguid union all 
         select @rowguid10 as rowguid union all 
         select @rowguid11 as rowguid union all 
         select @rowguid12 as rowguid union all 
         select @rowguid13 as rowguid union all 
         select @rowguid14 as rowguid union all 
         select @rowguid15 as rowguid union all 
         select @rowguid16 as rowguid union all 
         select @rowguid17 as rowguid union all 
         select @rowguid18 as rowguid union all 
         select @rowguid19 as rowguid union all 
         select @rowguid20 as rowguid union all 
         select @rowguid21 as rowguid union all 
         select @rowguid22 as rowguid union all 
         select @rowguid23 as rowguid union all 
         select @rowguid24 as rowguid union all 
         select @rowguid25 as rowguid union all 
         select @rowguid26 as rowguid union all 
         select @rowguid27 as rowguid union all 
         select @rowguid28 as rowguid union all 
         select @rowguid29 as rowguid union all 
         select @rowguid30 as rowguid union all 
         select @rowguid31 as rowguid union all 
         select @rowguid32 as rowguid union all 
         select @rowguid33 as rowguid union all 
         select @rowguid34 as rowguid union all 
         select @rowguid35 as rowguid union all 
         select @rowguid36 as rowguid union all 
         select @rowguid37 as rowguid union all 
         select @rowguid38 as rowguid union all 
         select @rowguid39 as rowguid union all 
         select @rowguid40 as rowguid union all 
         select @rowguid41 as rowguid union all 
         select @rowguid42 as rowguid union all 
         select @rowguid43 as rowguid union all 
         select @rowguid44 as rowguid union all 
         select @rowguid45 as rowguid union all 
         select @rowguid46 as rowguid union all 
         select @rowguid47 as rowguid union all 
         select @rowguid48 as rowguid union all 
         select @rowguid49 as rowguid union all 
         select @rowguid50 as rowguid union all

         select @rowguid51 as rowguid union all 
         select @rowguid52 as rowguid union all 
         select @rowguid53 as rowguid union all 
         select @rowguid54 as rowguid union all 
         select @rowguid55 as rowguid union all 
         select @rowguid56 as rowguid union all 
         select @rowguid57 as rowguid union all 
         select @rowguid58 as rowguid union all 
         select @rowguid59 as rowguid union all 
         select @rowguid60 as rowguid union all 
         select @rowguid61 as rowguid union all 
         select @rowguid62 as rowguid union all 
         select @rowguid63 as rowguid union all 
         select @rowguid64 as rowguid union all 
         select @rowguid65 as rowguid union all 
         select @rowguid66 as rowguid union all 
         select @rowguid67 as rowguid union all 
         select @rowguid68 as rowguid union all 
         select @rowguid69 as rowguid union all 
         select @rowguid70 as rowguid union all 
         select @rowguid71 as rowguid union all 
         select @rowguid72 as rowguid union all 
         select @rowguid73 as rowguid union all 
         select @rowguid74 as rowguid union all 
         select @rowguid75 as rowguid union all 
         select @rowguid76 as rowguid union all 
         select @rowguid77 as rowguid union all 
         select @rowguid78 as rowguid union all 
         select @rowguid79 as rowguid union all 
         select @rowguid80 as rowguid union all 
         select @rowguid81 as rowguid union all 
         select @rowguid82 as rowguid union all 
         select @rowguid83 as rowguid union all 
         select @rowguid84 as rowguid union all 
         select @rowguid85 as rowguid union all 
         select @rowguid86 as rowguid union all 
         select @rowguid87 as rowguid union all 
         select @rowguid88 as rowguid union all 
         select @rowguid89 as rowguid union all 
         select @rowguid90 as rowguid union all 
         select @rowguid91 as rowguid union all 
         select @rowguid92 as rowguid union all 
         select @rowguid93 as rowguid union all 
         select @rowguid94 as rowguid union all 
         select @rowguid95 as rowguid union all 
         select @rowguid96 as rowguid union all 
         select @rowguid97 as rowguid union all 
         select @rowguid98 as rowguid union all 
         select @rowguid99 as rowguid union all 
         select @rowguid100 as rowguid

    ) as rows
    inner join dbo.MSmerge_tombstone tomb with (rowlock) 
    on tomb.rowguid = rows.rowguid
    and tomb.tablenick = 31081000
    and rows.rowguid is not NULL
        
    if @rows_in_tomb = 1
    begin
        raiserror(20692, 16, -1, 'HOCPHI')
        set @errcode=3
        goto Failure
    end

    
    select @marker = newid()
    insert into dbo.MSmerge_contents with (rowlock)
    (rowguid, tablenick, generation, partchangegen, lineage, colv1, marker)
    select rows.rowguid, 31081000, rows.generation, (-rows.generation), rows.lineage, rows.colv, @marker
    from (

    select @rowguid1 as rowguid, @generation1 as generation, @lineage1 as lineage, @colv1 as colv union all
    select @rowguid2 as rowguid, @generation2 as generation, @lineage2 as lineage, @colv2 as colv union all
    select @rowguid3 as rowguid, @generation3 as generation, @lineage3 as lineage, @colv3 as colv union all
    select @rowguid4 as rowguid, @generation4 as generation, @lineage4 as lineage, @colv4 as colv union all
    select @rowguid5 as rowguid, @generation5 as generation, @lineage5 as lineage, @colv5 as colv union all
    select @rowguid6 as rowguid, @generation6 as generation, @lineage6 as lineage, @colv6 as colv union all
    select @rowguid7 as rowguid, @generation7 as generation, @lineage7 as lineage, @colv7 as colv union all
    select @rowguid8 as rowguid, @generation8 as generation, @lineage8 as lineage, @colv8 as colv union all
    select @rowguid9 as rowguid, @generation9 as generation, @lineage9 as lineage, @colv9 as colv union all
    select @rowguid10 as rowguid, @generation10 as generation, @lineage10 as lineage, @colv10 as colv union all
    select @rowguid11 as rowguid, @generation11 as generation, @lineage11 as lineage, @colv11 as colv union all
    select @rowguid12 as rowguid, @generation12 as generation, @lineage12 as lineage, @colv12 as colv union all
    select @rowguid13 as rowguid, @generation13 as generation, @lineage13 as lineage, @colv13 as colv union all
    select @rowguid14 as rowguid, @generation14 as generation, @lineage14 as lineage, @colv14 as colv union all
    select @rowguid15 as rowguid, @generation15 as generation, @lineage15 as lineage, @colv15 as colv union all
    select @rowguid16 as rowguid, @generation16 as generation, @lineage16 as lineage, @colv16 as colv union all
    select @rowguid17 as rowguid, @generation17 as generation, @lineage17 as lineage, @colv17 as colv union all
    select @rowguid18 as rowguid, @generation18 as generation, @lineage18 as lineage, @colv18 as colv union all
    select @rowguid19 as rowguid, @generation19 as generation, @lineage19 as lineage, @colv19 as colv union all
    select @rowguid20 as rowguid, @generation20 as generation, @lineage20 as lineage, @colv20 as colv union all
    select @rowguid21 as rowguid, @generation21 as generation, @lineage21 as lineage, @colv21 as colv union all
    select @rowguid22 as rowguid, @generation22 as generation, @lineage22 as lineage, @colv22 as colv union all
    select @rowguid23 as rowguid, @generation23 as generation, @lineage23 as lineage, @colv23 as colv union all
    select @rowguid24 as rowguid, @generation24 as generation, @lineage24 as lineage, @colv24 as colv union all
    select @rowguid25 as rowguid, @generation25 as generation, @lineage25 as lineage, @colv25 as colv union all
    select @rowguid26 as rowguid, @generation26 as generation, @lineage26 as lineage, @colv26 as colv union all
    select @rowguid27 as rowguid, @generation27 as generation, @lineage27 as lineage, @colv27 as colv union all
    select @rowguid28 as rowguid, @generation28 as generation, @lineage28 as lineage, @colv28 as colv union all
    select @rowguid29 as rowguid, @generation29 as generation, @lineage29 as lineage, @colv29 as colv union all
    select @rowguid30 as rowguid, @generation30 as generation, @lineage30 as lineage, @colv30 as colv union all
    select @rowguid31 as rowguid, @generation31 as generation, @lineage31 as lineage, @colv31 as colv union all
    select @rowguid32 as rowguid, @generation32 as generation, @lineage32 as lineage, @colv32 as colv union all
    select @rowguid33 as rowguid, @generation33 as generation, @lineage33 as lineage, @colv33 as colv union all
    select @rowguid34 as rowguid, @generation34 as generation, @lineage34 as lineage, @colv34 as colv
 union all
    select @rowguid35 as rowguid, @generation35 as generation, @lineage35 as lineage, @colv35 as colv union all
    select @rowguid36 as rowguid, @generation36 as generation, @lineage36 as lineage, @colv36 as colv union all
    select @rowguid37 as rowguid, @generation37 as generation, @lineage37 as lineage, @colv37 as colv union all
    select @rowguid38 as rowguid, @generation38 as generation, @lineage38 as lineage, @colv38 as colv union all
    select @rowguid39 as rowguid, @generation39 as generation, @lineage39 as lineage, @colv39 as colv union all
    select @rowguid40 as rowguid, @generation40 as generation, @lineage40 as lineage, @colv40 as colv union all
    select @rowguid41 as rowguid, @generation41 as generation, @lineage41 as lineage, @colv41 as colv union all
    select @rowguid42 as rowguid, @generation42 as generation, @lineage42 as lineage, @colv42 as colv union all
    select @rowguid43 as rowguid, @generation43 as generation, @lineage43 as lineage, @colv43 as colv union all
    select @rowguid44 as rowguid, @generation44 as generation, @lineage44 as lineage, @colv44 as colv union all
    select @rowguid45 as rowguid, @generation45 as generation, @lineage45 as lineage, @colv45 as colv union all
    select @rowguid46 as rowguid, @generation46 as generation, @lineage46 as lineage, @colv46 as colv union all
    select @rowguid47 as rowguid, @generation47 as generation, @lineage47 as lineage, @colv47 as colv union all
    select @rowguid48 as rowguid, @generation48 as generation, @lineage48 as lineage, @colv48 as colv union all
    select @rowguid49 as rowguid, @generation49 as generation, @lineage49 as lineage, @colv49 as colv union all
    select @rowguid50 as rowguid, @generation50 as generation, @lineage50 as lineage, @colv50 as colv union all
    select @rowguid51 as rowguid, @generation51 as generation, @lineage51 as lineage, @colv51 as colv union all
    select @rowguid52 as rowguid, @generation52 as generation, @lineage52 as lineage, @colv52 as colv union all
    select @rowguid53 as rowguid, @generation53 as generation, @lineage53 as lineage, @colv53 as colv union all
    select @rowguid54 as rowguid, @generation54 as generation, @lineage54 as lineage, @colv54 as colv union all
    select @rowguid55 as rowguid, @generation55 as generation, @lineage55 as lineage, @colv55 as colv union all
    select @rowguid56 as rowguid, @generation56 as generation, @lineage56 as lineage, @colv56 as colv union all
    select @rowguid57 as rowguid, @generation57 as generation, @lineage57 as lineage, @colv57 as colv union all
    select @rowguid58 as rowguid, @generation58 as generation, @lineage58 as lineage, @colv58 as colv union all
    select @rowguid59 as rowguid, @generation59 as generation, @lineage59 as lineage, @colv59 as colv union all
    select @rowguid60 as rowguid, @generation60 as generation, @lineage60 as lineage, @colv60 as colv union all
    select @rowguid61 as rowguid, @generation61 as generation, @lineage61 as lineage, @colv61 as colv union all
    select @rowguid62 as rowguid, @generation62 as generation, @lineage62 as lineage, @colv62 as colv union all
    select @rowguid63 as rowguid, @generation63 as generation, @lineage63 as lineage, @colv63 as colv union all
    select @rowguid64 as rowguid, @generation64 as generation, @lineage64 as lineage, @colv64 as colv union all
    select @rowguid65 as rowguid, @generation65 as generation, @lineage65 as lineage, @colv65 as colv union all
    select @rowguid66 as rowguid, @generation66 as generation, @lineage66 as lineage, @colv66 as colv union all
    select @rowguid67 as rowguid, @generation67 as generation, @lineage67 as lineage, @colv67 as colv union all
    select @rowguid68 as rowguid, @generation68 as generation, @lineage68 as lineage, @colv68 as colv
 union all
    select @rowguid69 as rowguid, @generation69 as generation, @lineage69 as lineage, @colv69 as colv union all
    select @rowguid70 as rowguid, @generation70 as generation, @lineage70 as lineage, @colv70 as colv union all
    select @rowguid71 as rowguid, @generation71 as generation, @lineage71 as lineage, @colv71 as colv union all
    select @rowguid72 as rowguid, @generation72 as generation, @lineage72 as lineage, @colv72 as colv union all
    select @rowguid73 as rowguid, @generation73 as generation, @lineage73 as lineage, @colv73 as colv union all
    select @rowguid74 as rowguid, @generation74 as generation, @lineage74 as lineage, @colv74 as colv union all
    select @rowguid75 as rowguid, @generation75 as generation, @lineage75 as lineage, @colv75 as colv union all
    select @rowguid76 as rowguid, @generation76 as generation, @lineage76 as lineage, @colv76 as colv union all
    select @rowguid77 as rowguid, @generation77 as generation, @lineage77 as lineage, @colv77 as colv union all
    select @rowguid78 as rowguid, @generation78 as generation, @lineage78 as lineage, @colv78 as colv union all
    select @rowguid79 as rowguid, @generation79 as generation, @lineage79 as lineage, @colv79 as colv union all
    select @rowguid80 as rowguid, @generation80 as generation, @lineage80 as lineage, @colv80 as colv union all
    select @rowguid81 as rowguid, @generation81 as generation, @lineage81 as lineage, @colv81 as colv union all
    select @rowguid82 as rowguid, @generation82 as generation, @lineage82 as lineage, @colv82 as colv union all
    select @rowguid83 as rowguid, @generation83 as generation, @lineage83 as lineage, @colv83 as colv union all
    select @rowguid84 as rowguid, @generation84 as generation, @lineage84 as lineage, @colv84 as colv union all
    select @rowguid85 as rowguid, @generation85 as generation, @lineage85 as lineage, @colv85 as colv union all
    select @rowguid86 as rowguid, @generation86 as generation, @lineage86 as lineage, @colv86 as colv union all
    select @rowguid87 as rowguid, @generation87 as generation, @lineage87 as lineage, @colv87 as colv union all
    select @rowguid88 as rowguid, @generation88 as generation, @lineage88 as lineage, @colv88 as colv union all
    select @rowguid89 as rowguid, @generation89 as generation, @lineage89 as lineage, @colv89 as colv union all
    select @rowguid90 as rowguid, @generation90 as generation, @lineage90 as lineage, @colv90 as colv union all
    select @rowguid91 as rowguid, @generation91 as generation, @lineage91 as lineage, @colv91 as colv union all
    select @rowguid92 as rowguid, @generation92 as generation, @lineage92 as lineage, @colv92 as colv union all
    select @rowguid93 as rowguid, @generation93 as generation, @lineage93 as lineage, @colv93 as colv union all
    select @rowguid94 as rowguid, @generation94 as generation, @lineage94 as lineage, @colv94 as colv union all
    select @rowguid95 as rowguid, @generation95 as generation, @lineage95 as lineage, @colv95 as colv union all
    select @rowguid96 as rowguid, @generation96 as generation, @lineage96 as lineage, @colv96 as colv union all
    select @rowguid97 as rowguid, @generation97 as generation, @lineage97 as lineage, @colv97 as colv union all
    select @rowguid98 as rowguid, @generation98 as generation, @lineage98 as lineage, @colv98 as colv union all
    select @rowguid99 as rowguid, @generation99 as generation, @lineage99 as lineage, @colv99 as colv union all
    select @rowguid100 as rowguid, @generation100 as generation, @lineage100 as lineage, @colv100 as colv

    ) as rows
    where rows.rowguid is not NULL 

    select @rows_inserted_into_contents = @@rowcount, @error = @@error
    if @error<>0
    begin
        set @errcode=3
        goto Failure
    end

    if (@rows_inserted_into_contents <> @rows_tobe_inserted)
    begin
        raiserror(20693, 16, -1, 'HOCPHI')
        set @errcode=4
        goto Failure
    end

    insert into [dbo].[HOCPHI] with (rowlock) (
[MASV]
, 
        [NIENKHOA]
, 
        [HOCKY]
, 
        [HOCPHI]
, 
        [SOTIENDADONG]
, 
        [rowguid]
)
    select 
c1
, 
        c2
, 
        c3
, 
        c4
, 
        c5
, 
        rowguid

    from (

    select @p1 as c1, @p2 as c2, @p3 as c3, @p4 as c4, @p5 as c5, @p6 as rowguid union all
    select @p7 as c1, @p8 as c2, @p9 as c3, @p10 as c4, @p11 as c5, @p12 as rowguid union all
    select @p13 as c1, @p14 as c2, @p15 as c3, @p16 as c4, @p17 as c5, @p18 as rowguid union all
    select @p19 as c1, @p20 as c2, @p21 as c3, @p22 as c4, @p23 as c5, @p24 as rowguid union all
    select @p25 as c1, @p26 as c2, @p27 as c3, @p28 as c4, @p29 as c5, @p30 as rowguid union all
    select @p31 as c1, @p32 as c2, @p33 as c3, @p34 as c4, @p35 as c5, @p36 as rowguid union all
    select @p37 as c1, @p38 as c2, @p39 as c3, @p40 as c4, @p41 as c5, @p42 as rowguid union all
    select @p43 as c1, @p44 as c2, @p45 as c3, @p46 as c4, @p47 as c5, @p48 as rowguid union all
    select @p49 as c1, @p50 as c2, @p51 as c3, @p52 as c4, @p53 as c5, @p54 as rowguid union all
    select @p55 as c1, @p56 as c2, @p57 as c3, @p58 as c4, @p59 as c5, @p60 as rowguid union all
    select @p61 as c1, @p62 as c2, @p63 as c3, @p64 as c4, @p65 as c5, @p66 as rowguid union all
    select @p67 as c1, @p68 as c2, @p69 as c3, @p70 as c4, @p71 as c5, @p72 as rowguid union all
    select @p73 as c1, @p74 as c2, @p75 as c3, @p76 as c4, @p77 as c5, @p78 as rowguid union all
    select @p79 as c1, @p80 as c2, @p81 as c3, @p82 as c4, @p83 as c5, @p84 as rowguid union all
    select @p85 as c1, @p86 as c2, @p87 as c3, @p88 as c4, @p89 as c5, @p90 as rowguid union all
    select @p91 as c1, @p92 as c2, @p93 as c3, @p94 as c4, @p95 as c5, @p96 as rowguid union all
    select @p97 as c1, @p98 as c2, @p99 as c3, @p100 as c4, @p101 as c5, @p102 as rowguid union all
    select @p103 as c1, @p104 as c2, @p105 as c3, @p106 as c4, @p107 as c5, @p108 as rowguid union all
    select @p109 as c1, @p110 as c2, @p111 as c3, @p112 as c4, @p113 as c5, @p114 as rowguid union all
    select @p115 as c1, @p116 as c2, @p117 as c3, @p118 as c4, @p119 as c5, @p120 as rowguid union all
    select @p121 as c1, @p122 as c2, @p123 as c3, @p124 as c4, @p125 as c5, @p126 as rowguid union all
    select @p127 as c1, @p128 as c2, @p129 as c3, @p130 as c4, @p131 as c5, @p132 as rowguid union all
    select @p133 as c1, @p134 as c2, @p135 as c3, @p136 as c4, @p137 as c5, @p138 as rowguid union all
    select @p139 as c1, @p140 as c2, @p141 as c3, @p142 as c4, @p143 as c5, @p144 as rowguid union all
    select @p145 as c1, @p146 as c2, @p147 as c3, @p148 as c4, @p149 as c5, @p150 as rowguid union all
    select @p151 as c1, @p152 as c2, @p153 as c3, @p154 as c4, @p155 as c5, @p156 as rowguid union all
    select @p157 as c1, @p158 as c2, @p159 as c3, @p160 as c4, @p161 as c5, @p162 as rowguid union all
    select @p163 as c1, @p164 as c2, @p165 as c3, @p166 as c4, @p167 as c5, @p168 as rowguid union all
    select @p169 as c1, @p170 as c2, @p171 as c3, @p172 as c4, @p173 as c5, @p174 as rowguid union all
    select @p175 as c1, @p176 as c2, @p177 as c3, @p178 as c4, @p179 as c5, @p180 as rowguid union all
    select @p181 as c1, @p182 as c2, @p183 as c3, @p184 as c4, @p185 as c5, @p186 as rowguid union all
    select @p187 as c1, @p188 as c2, @p189 as c3, @p190 as c4, @p191 as c5, @p192 as rowguid union all
    select @p193 as c1, @p194 as c2, @p195 as c3, @p196 as c4, @p197 as c5, @p198 as rowguid union all
    select @p199 as c1, @p200 as c2, @p201 as c3, @p202 as c4, @p203 as c5, @p204 as rowguid union all
    select @p205 as c1, @p206 as c2, @p207 as c3, @p208 as c4, @p209 as c5, @p210 as rowguid union all
    select @p211 as c1, @p212 as c2, @p213 as c3, @p214 as c4, @p215 as c5, @p216 as rowguid union all
    select @p217 as c1, @p218 as c2, @p219 as c3, @p220 as c4, @p221 as c5, @p222 as rowguid union all
    select @p223 as c1
, @p224 as c2, @p225 as c3, @p226 as c4, @p227 as c5, @p228 as rowguid union all
    select @p229 as c1, @p230 as c2, @p231 as c3, @p232 as c4, @p233 as c5, @p234 as rowguid union all
    select @p235 as c1, @p236 as c2, @p237 as c3, @p238 as c4, @p239 as c5, @p240 as rowguid union all
    select @p241 as c1, @p242 as c2, @p243 as c3, @p244 as c4, @p245 as c5, @p246 as rowguid union all
    select @p247 as c1, @p248 as c2, @p249 as c3, @p250 as c4, @p251 as c5, @p252 as rowguid union all
    select @p253 as c1, @p254 as c2, @p255 as c3, @p256 as c4, @p257 as c5, @p258 as rowguid union all
    select @p259 as c1, @p260 as c2, @p261 as c3, @p262 as c4, @p263 as c5, @p264 as rowguid union all
    select @p265 as c1, @p266 as c2, @p267 as c3, @p268 as c4, @p269 as c5, @p270 as rowguid union all
    select @p271 as c1, @p272 as c2, @p273 as c3, @p274 as c4, @p275 as c5, @p276 as rowguid union all
    select @p277 as c1, @p278 as c2, @p279 as c3, @p280 as c4, @p281 as c5, @p282 as rowguid union all
    select @p283 as c1, @p284 as c2, @p285 as c3, @p286 as c4, @p287 as c5, @p288 as rowguid union all
    select @p289 as c1, @p290 as c2, @p291 as c3, @p292 as c4, @p293 as c5, @p294 as rowguid union all
    select @p295 as c1, @p296 as c2, @p297 as c3, @p298 as c4, @p299 as c5, @p300 as rowguid union all
    select @p301 as c1, @p302 as c2, @p303 as c3, @p304 as c4, @p305 as c5, @p306 as rowguid union all
    select @p307 as c1, @p308 as c2, @p309 as c3, @p310 as c4, @p311 as c5, @p312 as rowguid union all
    select @p313 as c1, @p314 as c2, @p315 as c3, @p316 as c4, @p317 as c5, @p318 as rowguid union all
    select @p319 as c1, @p320 as c2, @p321 as c3, @p322 as c4, @p323 as c5, @p324 as rowguid union all
    select @p325 as c1, @p326 as c2, @p327 as c3, @p328 as c4, @p329 as c5, @p330 as rowguid union all
    select @p331 as c1, @p332 as c2, @p333 as c3, @p334 as c4, @p335 as c5, @p336 as rowguid union all
    select @p337 as c1, @p338 as c2, @p339 as c3, @p340 as c4, @p341 as c5, @p342 as rowguid union all
    select @p343 as c1, @p344 as c2, @p345 as c3, @p346 as c4, @p347 as c5, @p348 as rowguid union all
    select @p349 as c1, @p350 as c2, @p351 as c3, @p352 as c4, @p353 as c5, @p354 as rowguid union all
    select @p355 as c1, @p356 as c2, @p357 as c3, @p358 as c4, @p359 as c5, @p360 as rowguid union all
    select @p361 as c1, @p362 as c2, @p363 as c3, @p364 as c4, @p365 as c5, @p366 as rowguid union all
    select @p367 as c1, @p368 as c2, @p369 as c3, @p370 as c4, @p371 as c5, @p372 as rowguid union all
    select @p373 as c1, @p374 as c2, @p375 as c3, @p376 as c4, @p377 as c5, @p378 as rowguid union all
    select @p379 as c1, @p380 as c2, @p381 as c3, @p382 as c4, @p383 as c5, @p384 as rowguid union all
    select @p385 as c1, @p386 as c2, @p387 as c3, @p388 as c4, @p389 as c5, @p390 as rowguid union all
    select @p391 as c1, @p392 as c2, @p393 as c3, @p394 as c4, @p395 as c5, @p396 as rowguid union all
    select @p397 as c1, @p398 as c2, @p399 as c3, @p400 as c4, @p401 as c5, @p402 as rowguid union all
    select @p403 as c1, @p404 as c2, @p405 as c3, @p406 as c4, @p407 as c5, @p408 as rowguid union all
    select @p409 as c1, @p410 as c2, @p411 as c3, @p412 as c4, @p413 as c5, @p414 as rowguid union all
    select @p415 as c1, @p416 as c2, @p417 as c3, @p418 as c4, @p419 as c5, @p420 as rowguid union all
    select @p421 as c1, @p422 as c2, @p423 as c3, @p424 as c4, @p425 as c5, @p426 as rowguid union all
    select @p427 as c1, @p428 as c2, @p429 as c3, @p430 as c4, @p431 as c5, @p432 as rowguid union all
    select @p433 as c1, @p434 as c2, @p435 as c3, @p436 as c4, @p437 as c5, @p438 as rowguid union all
    select @p439 as c1, @p440 as c2
, @p441 as c3, @p442 as c4, @p443 as c5, @p444 as rowguid union all
    select @p445 as c1, @p446 as c2, @p447 as c3, @p448 as c4, @p449 as c5, @p450 as rowguid union all
    select @p451 as c1, @p452 as c2, @p453 as c3, @p454 as c4, @p455 as c5, @p456 as rowguid union all
    select @p457 as c1, @p458 as c2, @p459 as c3, @p460 as c4, @p461 as c5, @p462 as rowguid union all
    select @p463 as c1, @p464 as c2, @p465 as c3, @p466 as c4, @p467 as c5, @p468 as rowguid union all
    select @p469 as c1, @p470 as c2, @p471 as c3, @p472 as c4, @p473 as c5, @p474 as rowguid union all
    select @p475 as c1, @p476 as c2, @p477 as c3, @p478 as c4, @p479 as c5, @p480 as rowguid union all
    select @p481 as c1, @p482 as c2, @p483 as c3, @p484 as c4, @p485 as c5, @p486 as rowguid union all
    select @p487 as c1, @p488 as c2, @p489 as c3, @p490 as c4, @p491 as c5, @p492 as rowguid union all
    select @p493 as c1, @p494 as c2, @p495 as c3, @p496 as c4, @p497 as c5, @p498 as rowguid union all
    select @p499 as c1, @p500 as c2, @p501 as c3, @p502 as c4, @p503 as c5, @p504 as rowguid union all
    select @p505 as c1, @p506 as c2, @p507 as c3, @p508 as c4, @p509 as c5, @p510 as rowguid union all
    select @p511 as c1, @p512 as c2, @p513 as c3, @p514 as c4, @p515 as c5, @p516 as rowguid union all
    select @p517 as c1, @p518 as c2, @p519 as c3, @p520 as c4, @p521 as c5, @p522 as rowguid union all
    select @p523 as c1, @p524 as c2, @p525 as c3, @p526 as c4, @p527 as c5, @p528 as rowguid union all
    select @p529 as c1, @p530 as c2, @p531 as c3, @p532 as c4, @p533 as c5, @p534 as rowguid union all
    select @p535 as c1, @p536 as c2, @p537 as c3, @p538 as c4, @p539 as c5, @p540 as rowguid union all
    select @p541 as c1, @p542 as c2, @p543 as c3, @p544 as c4, @p545 as c5, @p546 as rowguid union all
    select @p547 as c1, @p548 as c2, @p549 as c3, @p550 as c4, @p551 as c5, @p552 as rowguid union all
    select @p553 as c1, @p554 as c2, @p555 as c3, @p556 as c4, @p557 as c5, @p558 as rowguid union all
    select @p559 as c1, @p560 as c2, @p561 as c3, @p562 as c4, @p563 as c5, @p564 as rowguid union all
    select @p565 as c1, @p566 as c2, @p567 as c3, @p568 as c4, @p569 as c5, @p570 as rowguid union all
    select @p571 as c1, @p572 as c2, @p573 as c3, @p574 as c4, @p575 as c5, @p576 as rowguid union all
    select @p577 as c1, @p578 as c2, @p579 as c3, @p580 as c4, @p581 as c5, @p582 as rowguid union all
    select @p583 as c1, @p584 as c2, @p585 as c3, @p586 as c4, @p587 as c5, @p588 as rowguid union all
    select @p589 as c1, @p590 as c2, @p591 as c3, @p592 as c4, @p593 as c5, @p594 as rowguid union all
    select @p595 as c1
, @p596 as c2
, @p597 as c3
, @p598 as c4
, @p599 as c5
, @p600 as rowguid

    ) as rows
    where rows.rowguid is not NULL
    select @rowcount = @@rowcount, @error = @@error

    if (@rowcount <> @rows_tobe_inserted) or (@error <> 0)
    begin
        set @errcode= 3
        goto Failure
    end


    exec @retcode = sys.sp_MSdeletemetadataactionrequest '8D8B572F-B352-4CD3-9BF9-08911C828501', 31081000, 
        @rowguid1, 
        @rowguid2, 
        @rowguid3, 
        @rowguid4, 
        @rowguid5, 
        @rowguid6, 
        @rowguid7, 
        @rowguid8, 
        @rowguid9, 
        @rowguid10, 
        @rowguid11, 
        @rowguid12, 
        @rowguid13, 
        @rowguid14, 
        @rowguid15, 
        @rowguid16, 
        @rowguid17, 
        @rowguid18, 
        @rowguid19, 
        @rowguid20, 
        @rowguid21, 
        @rowguid22, 
        @rowguid23, 
        @rowguid24, 
        @rowguid25, 
        @rowguid26, 
        @rowguid27, 
        @rowguid28, 
        @rowguid29, 
        @rowguid30, 
        @rowguid31, 
        @rowguid32, 
        @rowguid33, 
        @rowguid34, 
        @rowguid35, 
        @rowguid36, 
        @rowguid37, 
        @rowguid38, 
        @rowguid39, 
        @rowguid40, 
        @rowguid41, 
        @rowguid42, 
        @rowguid43, 
        @rowguid44, 
        @rowguid45, 
        @rowguid46, 
        @rowguid47, 
        @rowguid48, 
        @rowguid49, 
        @rowguid50, 
        @rowguid51, 
        @rowguid52, 
        @rowguid53, 
        @rowguid54, 
        @rowguid55, 
        @rowguid56, 
        @rowguid57, 
        @rowguid58, 
        @rowguid59, 
        @rowguid60, 
        @rowguid61, 
        @rowguid62, 
        @rowguid63, 
        @rowguid64, 
        @rowguid65, 
        @rowguid66, 
        @rowguid67, 
        @rowguid68, 
        @rowguid69, 
        @rowguid70, 
        @rowguid71, 
        @rowguid72, 
        @rowguid73, 
        @rowguid74, 
        @rowguid75, 
        @rowguid76, 
        @rowguid77, 
        @rowguid78, 
        @rowguid79, 
        @rowguid80, 
        @rowguid81, 
        @rowguid82, 
        @rowguid83, 
        @rowguid84, 
        @rowguid85, 
        @rowguid86, 
        @rowguid87, 
        @rowguid88, 
        @rowguid89, 
        @rowguid90, 
        @rowguid91, 
        @rowguid92, 
        @rowguid93, 
        @rowguid94, 
        @rowguid95, 
        @rowguid96, 
        @rowguid97, 
        @rowguid98, 
        @rowguid99, 
        @rowguid100
    if @retcode<>0 or @@error<>0
        goto Failure
    

    commit tran
    return 1

Failure:
    rollback tran batchinsertproc
    commit tran
    return 0
end


go
create procedure dbo.[MSmerge_upd_sp_BB5C29C42300434E8D8B572FB3524CD3_batch] (
        @rows_tobe_updated int,
        @partition_id int = null 
,
    @rowguid1 uniqueidentifier = NULL,
    @setbm1 varbinary(125) = NULL,
    @metadata_type1 tinyint = NULL,
    @lineage_old1 varbinary(311) = NULL,
    @generation1 bigint = NULL,
    @lineage_new1 varbinary(311) = NULL,
    @colv1 varbinary(1) = NULL,
    @p1 varchar(12) = NULL,
    @p2 nvarchar(50) = NULL,
    @p3 int = NULL,
    @p4 int = NULL,
    @p5 int = NULL,
    @p6 uniqueidentifier = NULL,
    @rowguid2 uniqueidentifier = NULL,
    @setbm2 varbinary(125) = NULL,
    @metadata_type2 tinyint = NULL,
    @lineage_old2 varbinary(311) = NULL,
    @generation2 bigint = NULL,
    @lineage_new2 varbinary(311) = NULL,
    @colv2 varbinary(1) = NULL,
    @p7 varchar(12) = NULL,
    @p8 nvarchar(50) = NULL,
    @p9 int = NULL,
    @p10 int = NULL,
    @p11 int = NULL,
    @p12 uniqueidentifier = NULL,
    @rowguid3 uniqueidentifier = NULL,
    @setbm3 varbinary(125) = NULL,
    @metadata_type3 tinyint = NULL,
    @lineage_old3 varbinary(311) = NULL,
    @generation3 bigint = NULL,
    @lineage_new3 varbinary(311) = NULL,
    @colv3 varbinary(1) = NULL,
    @p13 varchar(12) = NULL,
    @p14 nvarchar(50) = NULL,
    @p15 int = NULL,
    @p16 int = NULL,
    @p17 int = NULL,
    @p18 uniqueidentifier = NULL,
    @rowguid4 uniqueidentifier = NULL,
    @setbm4 varbinary(125) = NULL,
    @metadata_type4 tinyint = NULL,
    @lineage_old4 varbinary(311) = NULL,
    @generation4 bigint = NULL,
    @lineage_new4 varbinary(311) = NULL,
    @colv4 varbinary(1) = NULL,
    @p19 varchar(12) = NULL,
    @p20 nvarchar(50) = NULL,
    @p21 int = NULL,
    @p22 int = NULL,
    @p23 int = NULL,
    @p24 uniqueidentifier = NULL,
    @rowguid5 uniqueidentifier = NULL,
    @setbm5 varbinary(125) = NULL,
    @metadata_type5 tinyint = NULL,
    @lineage_old5 varbinary(311) = NULL,
    @generation5 bigint = NULL,
    @lineage_new5 varbinary(311) = NULL,
    @colv5 varbinary(1) = NULL,
    @p25 varchar(12) = NULL,
    @p26 nvarchar(50) = NULL,
    @p27 int = NULL,
    @p28 int = NULL,
    @p29 int = NULL,
    @p30 uniqueidentifier = NULL,
    @rowguid6 uniqueidentifier = NULL,
    @setbm6 varbinary(125) = NULL,
    @metadata_type6 tinyint = NULL,
    @lineage_old6 varbinary(311) = NULL,
    @generation6 bigint = NULL,
    @lineage_new6 varbinary(311) = NULL,
    @colv6 varbinary(1) = NULL,
    @p31 varchar(12) = NULL,
    @p32 nvarchar(50) = NULL,
    @p33 int = NULL,
    @p34 int = NULL,
    @p35 int = NULL,
    @p36 uniqueidentifier = NULL,
    @rowguid7 uniqueidentifier = NULL,
    @setbm7 varbinary(125) = NULL,
    @metadata_type7 tinyint = NULL,
    @lineage_old7 varbinary(311) = NULL,
    @generation7 bigint = NULL,
    @lineage_new7 varbinary(311) = NULL,
    @colv7 varbinary(1) = NULL,
    @p37 varchar(12) = NULL,
    @p38 nvarchar(50) = NULL,
    @p39 int = NULL,
    @p40 int = NULL,
    @p41 int = NULL,
    @p42 uniqueidentifier = NULL,
    @rowguid8 uniqueidentifier = NULL,
    @setbm8 varbinary(125) = NULL,
    @metadata_type8 tinyint = NULL,
    @lineage_old8 varbinary(311) = NULL,
    @generation8 bigint = NULL,
    @lineage_new8 varbinary(311) = NULL,
    @colv8 varbinary(1) = NULL,
    @p43 varchar(12) = NULL,
    @p44 nvarchar(50) = NULL,
    @p45 int = NULL,
    @p46 int = NULL,
    @p47 int = NULL,
    @p48 uniqueidentifier = NULL,
    @rowguid9 uniqueidentifier = NULL,
    @setbm9 varbinary(125) = NULL,
    @metadata_type9 tinyint = NULL,
    @lineage_old9 varbinary(311) = NULL,
    @generation9 bigint = NULL,
    @lineage_new9 varbinary(311) = NULL,
    @colv9 varbinary(1) = NULL,
    @p49 varchar(12) = NULL
,
    @p50 nvarchar(50) = NULL,
    @p51 int = NULL,
    @p52 int = NULL,
    @p53 int = NULL,
    @p54 uniqueidentifier = NULL,
    @rowguid10 uniqueidentifier = NULL,
    @setbm10 varbinary(125) = NULL,
    @metadata_type10 tinyint = NULL,
    @lineage_old10 varbinary(311) = NULL,
    @generation10 bigint = NULL,
    @lineage_new10 varbinary(311) = NULL,
    @colv10 varbinary(1) = NULL,
    @p55 varchar(12) = NULL,
    @p56 nvarchar(50) = NULL,
    @p57 int = NULL,
    @p58 int = NULL,
    @p59 int = NULL,
    @p60 uniqueidentifier = NULL,
    @rowguid11 uniqueidentifier = NULL,
    @setbm11 varbinary(125) = NULL,
    @metadata_type11 tinyint = NULL,
    @lineage_old11 varbinary(311) = NULL,
    @generation11 bigint = NULL,
    @lineage_new11 varbinary(311) = NULL,
    @colv11 varbinary(1) = NULL,
    @p61 varchar(12) = NULL,
    @p62 nvarchar(50) = NULL,
    @p63 int = NULL,
    @p64 int = NULL,
    @p65 int = NULL,
    @p66 uniqueidentifier = NULL,
    @rowguid12 uniqueidentifier = NULL,
    @setbm12 varbinary(125) = NULL,
    @metadata_type12 tinyint = NULL,
    @lineage_old12 varbinary(311) = NULL,
    @generation12 bigint = NULL,
    @lineage_new12 varbinary(311) = NULL,
    @colv12 varbinary(1) = NULL,
    @p67 varchar(12) = NULL,
    @p68 nvarchar(50) = NULL,
    @p69 int = NULL,
    @p70 int = NULL,
    @p71 int = NULL,
    @p72 uniqueidentifier = NULL,
    @rowguid13 uniqueidentifier = NULL,
    @setbm13 varbinary(125) = NULL,
    @metadata_type13 tinyint = NULL,
    @lineage_old13 varbinary(311) = NULL,
    @generation13 bigint = NULL,
    @lineage_new13 varbinary(311) = NULL,
    @colv13 varbinary(1) = NULL,
    @p73 varchar(12) = NULL,
    @p74 nvarchar(50) = NULL,
    @p75 int = NULL,
    @p76 int = NULL,
    @p77 int = NULL,
    @p78 uniqueidentifier = NULL,
    @rowguid14 uniqueidentifier = NULL,
    @setbm14 varbinary(125) = NULL,
    @metadata_type14 tinyint = NULL,
    @lineage_old14 varbinary(311) = NULL,
    @generation14 bigint = NULL,
    @lineage_new14 varbinary(311) = NULL,
    @colv14 varbinary(1) = NULL,
    @p79 varchar(12) = NULL,
    @p80 nvarchar(50) = NULL,
    @p81 int = NULL,
    @p82 int = NULL,
    @p83 int = NULL,
    @p84 uniqueidentifier = NULL,
    @rowguid15 uniqueidentifier = NULL,
    @setbm15 varbinary(125) = NULL,
    @metadata_type15 tinyint = NULL,
    @lineage_old15 varbinary(311) = NULL,
    @generation15 bigint = NULL,
    @lineage_new15 varbinary(311) = NULL,
    @colv15 varbinary(1) = NULL,
    @p85 varchar(12) = NULL,
    @p86 nvarchar(50) = NULL,
    @p87 int = NULL,
    @p88 int = NULL,
    @p89 int = NULL,
    @p90 uniqueidentifier = NULL,
    @rowguid16 uniqueidentifier = NULL,
    @setbm16 varbinary(125) = NULL,
    @metadata_type16 tinyint = NULL,
    @lineage_old16 varbinary(311) = NULL,
    @generation16 bigint = NULL,
    @lineage_new16 varbinary(311) = NULL,
    @colv16 varbinary(1) = NULL,
    @p91 varchar(12) = NULL,
    @p92 nvarchar(50) = NULL,
    @p93 int = NULL,
    @p94 int = NULL,
    @p95 int = NULL,
    @p96 uniqueidentifier = NULL,
    @rowguid17 uniqueidentifier = NULL,
    @setbm17 varbinary(125) = NULL,
    @metadata_type17 tinyint = NULL,
    @lineage_old17 varbinary(311) = NULL,
    @generation17 bigint = NULL,
    @lineage_new17 varbinary(311) = NULL,
    @colv17 varbinary(1) = NULL,
    @p97 varchar(12) = NULL,
    @p98 nvarchar(50) = NULL,
    @p99 int = NULL
,
    @p100 int = NULL,
    @p101 int = NULL,
    @p102 uniqueidentifier = NULL,
    @rowguid18 uniqueidentifier = NULL,
    @setbm18 varbinary(125) = NULL,
    @metadata_type18 tinyint = NULL,
    @lineage_old18 varbinary(311) = NULL,
    @generation18 bigint = NULL,
    @lineage_new18 varbinary(311) = NULL,
    @colv18 varbinary(1) = NULL,
    @p103 varchar(12) = NULL,
    @p104 nvarchar(50) = NULL,
    @p105 int = NULL,
    @p106 int = NULL,
    @p107 int = NULL,
    @p108 uniqueidentifier = NULL,
    @rowguid19 uniqueidentifier = NULL,
    @setbm19 varbinary(125) = NULL,
    @metadata_type19 tinyint = NULL,
    @lineage_old19 varbinary(311) = NULL,
    @generation19 bigint = NULL,
    @lineage_new19 varbinary(311) = NULL,
    @colv19 varbinary(1) = NULL,
    @p109 varchar(12) = NULL,
    @p110 nvarchar(50) = NULL,
    @p111 int = NULL,
    @p112 int = NULL,
    @p113 int = NULL,
    @p114 uniqueidentifier = NULL,
    @rowguid20 uniqueidentifier = NULL,
    @setbm20 varbinary(125) = NULL,
    @metadata_type20 tinyint = NULL,
    @lineage_old20 varbinary(311) = NULL,
    @generation20 bigint = NULL,
    @lineage_new20 varbinary(311) = NULL,
    @colv20 varbinary(1) = NULL,
    @p115 varchar(12) = NULL,
    @p116 nvarchar(50) = NULL,
    @p117 int = NULL,
    @p118 int = NULL,
    @p119 int = NULL,
    @p120 uniqueidentifier = NULL,
    @rowguid21 uniqueidentifier = NULL,
    @setbm21 varbinary(125) = NULL,
    @metadata_type21 tinyint = NULL,
    @lineage_old21 varbinary(311) = NULL,
    @generation21 bigint = NULL,
    @lineage_new21 varbinary(311) = NULL,
    @colv21 varbinary(1) = NULL,
    @p121 varchar(12) = NULL,
    @p122 nvarchar(50) = NULL,
    @p123 int = NULL,
    @p124 int = NULL,
    @p125 int = NULL,
    @p126 uniqueidentifier = NULL,
    @rowguid22 uniqueidentifier = NULL,
    @setbm22 varbinary(125) = NULL,
    @metadata_type22 tinyint = NULL,
    @lineage_old22 varbinary(311) = NULL,
    @generation22 bigint = NULL,
    @lineage_new22 varbinary(311) = NULL,
    @colv22 varbinary(1) = NULL,
    @p127 varchar(12) = NULL,
    @p128 nvarchar(50) = NULL,
    @p129 int = NULL,
    @p130 int = NULL,
    @p131 int = NULL,
    @p132 uniqueidentifier = NULL,
    @rowguid23 uniqueidentifier = NULL,
    @setbm23 varbinary(125) = NULL,
    @metadata_type23 tinyint = NULL,
    @lineage_old23 varbinary(311) = NULL,
    @generation23 bigint = NULL,
    @lineage_new23 varbinary(311) = NULL,
    @colv23 varbinary(1) = NULL,
    @p133 varchar(12) = NULL,
    @p134 nvarchar(50) = NULL,
    @p135 int = NULL,
    @p136 int = NULL,
    @p137 int = NULL,
    @p138 uniqueidentifier = NULL,
    @rowguid24 uniqueidentifier = NULL,
    @setbm24 varbinary(125) = NULL,
    @metadata_type24 tinyint = NULL,
    @lineage_old24 varbinary(311) = NULL,
    @generation24 bigint = NULL,
    @lineage_new24 varbinary(311) = NULL,
    @colv24 varbinary(1) = NULL,
    @p139 varchar(12) = NULL,
    @p140 nvarchar(50) = NULL,
    @p141 int = NULL,
    @p142 int = NULL,
    @p143 int = NULL,
    @p144 uniqueidentifier = NULL,
    @rowguid25 uniqueidentifier = NULL,
    @setbm25 varbinary(125) = NULL,
    @metadata_type25 tinyint = NULL,
    @lineage_old25 varbinary(311) = NULL,
    @generation25 bigint = NULL,
    @lineage_new25 varbinary(311) = NULL,
    @colv25 varbinary(1) = NULL,
    @p145 varchar(12) = NULL,
    @p146 nvarchar(50) = NULL,
    @p147 int = NULL
,
    @p148 int = NULL,
    @p149 int = NULL,
    @p150 uniqueidentifier = NULL,
    @rowguid26 uniqueidentifier = NULL,
    @setbm26 varbinary(125) = NULL,
    @metadata_type26 tinyint = NULL,
    @lineage_old26 varbinary(311) = NULL,
    @generation26 bigint = NULL,
    @lineage_new26 varbinary(311) = NULL,
    @colv26 varbinary(1) = NULL,
    @p151 varchar(12) = NULL,
    @p152 nvarchar(50) = NULL,
    @p153 int = NULL,
    @p154 int = NULL,
    @p155 int = NULL,
    @p156 uniqueidentifier = NULL,
    @rowguid27 uniqueidentifier = NULL,
    @setbm27 varbinary(125) = NULL,
    @metadata_type27 tinyint = NULL,
    @lineage_old27 varbinary(311) = NULL,
    @generation27 bigint = NULL,
    @lineage_new27 varbinary(311) = NULL,
    @colv27 varbinary(1) = NULL,
    @p157 varchar(12) = NULL,
    @p158 nvarchar(50) = NULL,
    @p159 int = NULL,
    @p160 int = NULL,
    @p161 int = NULL,
    @p162 uniqueidentifier = NULL,
    @rowguid28 uniqueidentifier = NULL,
    @setbm28 varbinary(125) = NULL,
    @metadata_type28 tinyint = NULL,
    @lineage_old28 varbinary(311) = NULL,
    @generation28 bigint = NULL,
    @lineage_new28 varbinary(311) = NULL,
    @colv28 varbinary(1) = NULL,
    @p163 varchar(12) = NULL,
    @p164 nvarchar(50) = NULL,
    @p165 int = NULL,
    @p166 int = NULL,
    @p167 int = NULL,
    @p168 uniqueidentifier = NULL,
    @rowguid29 uniqueidentifier = NULL,
    @setbm29 varbinary(125) = NULL,
    @metadata_type29 tinyint = NULL,
    @lineage_old29 varbinary(311) = NULL,
    @generation29 bigint = NULL,
    @lineage_new29 varbinary(311) = NULL,
    @colv29 varbinary(1) = NULL,
    @p169 varchar(12) = NULL,
    @p170 nvarchar(50) = NULL,
    @p171 int = NULL,
    @p172 int = NULL,
    @p173 int = NULL,
    @p174 uniqueidentifier = NULL,
    @rowguid30 uniqueidentifier = NULL,
    @setbm30 varbinary(125) = NULL,
    @metadata_type30 tinyint = NULL,
    @lineage_old30 varbinary(311) = NULL,
    @generation30 bigint = NULL,
    @lineage_new30 varbinary(311) = NULL,
    @colv30 varbinary(1) = NULL,
    @p175 varchar(12) = NULL,
    @p176 nvarchar(50) = NULL,
    @p177 int = NULL,
    @p178 int = NULL,
    @p179 int = NULL,
    @p180 uniqueidentifier = NULL,
    @rowguid31 uniqueidentifier = NULL,
    @setbm31 varbinary(125) = NULL,
    @metadata_type31 tinyint = NULL,
    @lineage_old31 varbinary(311) = NULL,
    @generation31 bigint = NULL,
    @lineage_new31 varbinary(311) = NULL,
    @colv31 varbinary(1) = NULL,
    @p181 varchar(12) = NULL,
    @p182 nvarchar(50) = NULL,
    @p183 int = NULL,
    @p184 int = NULL,
    @p185 int = NULL,
    @p186 uniqueidentifier = NULL,
    @rowguid32 uniqueidentifier = NULL,
    @setbm32 varbinary(125) = NULL,
    @metadata_type32 tinyint = NULL,
    @lineage_old32 varbinary(311) = NULL,
    @generation32 bigint = NULL,
    @lineage_new32 varbinary(311) = NULL,
    @colv32 varbinary(1) = NULL,
    @p187 varchar(12) = NULL,
    @p188 nvarchar(50) = NULL,
    @p189 int = NULL,
    @p190 int = NULL,
    @p191 int = NULL,
    @p192 uniqueidentifier = NULL,
    @rowguid33 uniqueidentifier = NULL,
    @setbm33 varbinary(125) = NULL,
    @metadata_type33 tinyint = NULL,
    @lineage_old33 varbinary(311) = NULL,
    @generation33 bigint = NULL,
    @lineage_new33 varbinary(311) = NULL,
    @colv33 varbinary(1) = NULL,
    @p193 varchar(12) = NULL,
    @p194 nvarchar(50) = NULL,
    @p195 int = NULL
,
    @p196 int = NULL,
    @p197 int = NULL,
    @p198 uniqueidentifier = NULL,
    @rowguid34 uniqueidentifier = NULL,
    @setbm34 varbinary(125) = NULL,
    @metadata_type34 tinyint = NULL,
    @lineage_old34 varbinary(311) = NULL,
    @generation34 bigint = NULL,
    @lineage_new34 varbinary(311) = NULL,
    @colv34 varbinary(1) = NULL,
    @p199 varchar(12) = NULL,
    @p200 nvarchar(50) = NULL,
    @p201 int = NULL,
    @p202 int = NULL,
    @p203 int = NULL,
    @p204 uniqueidentifier = NULL,
    @rowguid35 uniqueidentifier = NULL,
    @setbm35 varbinary(125) = NULL,
    @metadata_type35 tinyint = NULL,
    @lineage_old35 varbinary(311) = NULL,
    @generation35 bigint = NULL,
    @lineage_new35 varbinary(311) = NULL,
    @colv35 varbinary(1) = NULL,
    @p205 varchar(12) = NULL,
    @p206 nvarchar(50) = NULL,
    @p207 int = NULL,
    @p208 int = NULL,
    @p209 int = NULL,
    @p210 uniqueidentifier = NULL,
    @rowguid36 uniqueidentifier = NULL,
    @setbm36 varbinary(125) = NULL,
    @metadata_type36 tinyint = NULL,
    @lineage_old36 varbinary(311) = NULL,
    @generation36 bigint = NULL,
    @lineage_new36 varbinary(311) = NULL,
    @colv36 varbinary(1) = NULL,
    @p211 varchar(12) = NULL,
    @p212 nvarchar(50) = NULL,
    @p213 int = NULL,
    @p214 int = NULL,
    @p215 int = NULL,
    @p216 uniqueidentifier = NULL,
    @rowguid37 uniqueidentifier = NULL,
    @setbm37 varbinary(125) = NULL,
    @metadata_type37 tinyint = NULL,
    @lineage_old37 varbinary(311) = NULL,
    @generation37 bigint = NULL,
    @lineage_new37 varbinary(311) = NULL,
    @colv37 varbinary(1) = NULL,
    @p217 varchar(12) = NULL,
    @p218 nvarchar(50) = NULL,
    @p219 int = NULL,
    @p220 int = NULL,
    @p221 int = NULL,
    @p222 uniqueidentifier = NULL,
    @rowguid38 uniqueidentifier = NULL,
    @setbm38 varbinary(125) = NULL,
    @metadata_type38 tinyint = NULL,
    @lineage_old38 varbinary(311) = NULL,
    @generation38 bigint = NULL,
    @lineage_new38 varbinary(311) = NULL,
    @colv38 varbinary(1) = NULL,
    @p223 varchar(12) = NULL,
    @p224 nvarchar(50) = NULL,
    @p225 int = NULL,
    @p226 int = NULL,
    @p227 int = NULL,
    @p228 uniqueidentifier = NULL,
    @rowguid39 uniqueidentifier = NULL,
    @setbm39 varbinary(125) = NULL,
    @metadata_type39 tinyint = NULL,
    @lineage_old39 varbinary(311) = NULL,
    @generation39 bigint = NULL,
    @lineage_new39 varbinary(311) = NULL,
    @colv39 varbinary(1) = NULL,
    @p229 varchar(12) = NULL,
    @p230 nvarchar(50) = NULL,
    @p231 int = NULL,
    @p232 int = NULL,
    @p233 int = NULL,
    @p234 uniqueidentifier = NULL,
    @rowguid40 uniqueidentifier = NULL,
    @setbm40 varbinary(125) = NULL,
    @metadata_type40 tinyint = NULL,
    @lineage_old40 varbinary(311) = NULL,
    @generation40 bigint = NULL,
    @lineage_new40 varbinary(311) = NULL,
    @colv40 varbinary(1) = NULL,
    @p235 varchar(12) = NULL,
    @p236 nvarchar(50) = NULL,
    @p237 int = NULL,
    @p238 int = NULL,
    @p239 int = NULL,
    @p240 uniqueidentifier = NULL,
    @rowguid41 uniqueidentifier = NULL,
    @setbm41 varbinary(125) = NULL,
    @metadata_type41 tinyint = NULL,
    @lineage_old41 varbinary(311) = NULL,
    @generation41 bigint = NULL,
    @lineage_new41 varbinary(311) = NULL,
    @colv41 varbinary(1) = NULL,
    @p241 varchar(12) = NULL,
    @p242 nvarchar(50) = NULL,
    @p243 int = NULL
,
    @p244 int = NULL,
    @p245 int = NULL,
    @p246 uniqueidentifier = NULL,
    @rowguid42 uniqueidentifier = NULL,
    @setbm42 varbinary(125) = NULL,
    @metadata_type42 tinyint = NULL,
    @lineage_old42 varbinary(311) = NULL,
    @generation42 bigint = NULL,
    @lineage_new42 varbinary(311) = NULL,
    @colv42 varbinary(1) = NULL,
    @p247 varchar(12) = NULL,
    @p248 nvarchar(50) = NULL,
    @p249 int = NULL,
    @p250 int = NULL,
    @p251 int = NULL,
    @p252 uniqueidentifier = NULL,
    @rowguid43 uniqueidentifier = NULL,
    @setbm43 varbinary(125) = NULL,
    @metadata_type43 tinyint = NULL,
    @lineage_old43 varbinary(311) = NULL,
    @generation43 bigint = NULL,
    @lineage_new43 varbinary(311) = NULL,
    @colv43 varbinary(1) = NULL,
    @p253 varchar(12) = NULL,
    @p254 nvarchar(50) = NULL,
    @p255 int = NULL,
    @p256 int = NULL,
    @p257 int = NULL,
    @p258 uniqueidentifier = NULL,
    @rowguid44 uniqueidentifier = NULL,
    @setbm44 varbinary(125) = NULL,
    @metadata_type44 tinyint = NULL,
    @lineage_old44 varbinary(311) = NULL,
    @generation44 bigint = NULL,
    @lineage_new44 varbinary(311) = NULL,
    @colv44 varbinary(1) = NULL,
    @p259 varchar(12) = NULL,
    @p260 nvarchar(50) = NULL,
    @p261 int = NULL,
    @p262 int = NULL,
    @p263 int = NULL,
    @p264 uniqueidentifier = NULL,
    @rowguid45 uniqueidentifier = NULL,
    @setbm45 varbinary(125) = NULL,
    @metadata_type45 tinyint = NULL,
    @lineage_old45 varbinary(311) = NULL,
    @generation45 bigint = NULL,
    @lineage_new45 varbinary(311) = NULL,
    @colv45 varbinary(1) = NULL,
    @p265 varchar(12) = NULL,
    @p266 nvarchar(50) = NULL,
    @p267 int = NULL,
    @p268 int = NULL,
    @p269 int = NULL,
    @p270 uniqueidentifier = NULL,
    @rowguid46 uniqueidentifier = NULL,
    @setbm46 varbinary(125) = NULL,
    @metadata_type46 tinyint = NULL,
    @lineage_old46 varbinary(311) = NULL,
    @generation46 bigint = NULL,
    @lineage_new46 varbinary(311) = NULL,
    @colv46 varbinary(1) = NULL,
    @p271 varchar(12) = NULL,
    @p272 nvarchar(50) = NULL,
    @p273 int = NULL,
    @p274 int = NULL,
    @p275 int = NULL,
    @p276 uniqueidentifier = NULL,
    @rowguid47 uniqueidentifier = NULL,
    @setbm47 varbinary(125) = NULL,
    @metadata_type47 tinyint = NULL,
    @lineage_old47 varbinary(311) = NULL,
    @generation47 bigint = NULL,
    @lineage_new47 varbinary(311) = NULL,
    @colv47 varbinary(1) = NULL,
    @p277 varchar(12) = NULL,
    @p278 nvarchar(50) = NULL,
    @p279 int = NULL,
    @p280 int = NULL,
    @p281 int = NULL,
    @p282 uniqueidentifier = NULL,
    @rowguid48 uniqueidentifier = NULL,
    @setbm48 varbinary(125) = NULL,
    @metadata_type48 tinyint = NULL,
    @lineage_old48 varbinary(311) = NULL,
    @generation48 bigint = NULL,
    @lineage_new48 varbinary(311) = NULL,
    @colv48 varbinary(1) = NULL,
    @p283 varchar(12) = NULL,
    @p284 nvarchar(50) = NULL,
    @p285 int = NULL,
    @p286 int = NULL,
    @p287 int = NULL,
    @p288 uniqueidentifier = NULL,
    @rowguid49 uniqueidentifier = NULL,
    @setbm49 varbinary(125) = NULL,
    @metadata_type49 tinyint = NULL,
    @lineage_old49 varbinary(311) = NULL,
    @generation49 bigint = NULL,
    @lineage_new49 varbinary(311) = NULL,
    @colv49 varbinary(1) = NULL,
    @p289 varchar(12) = NULL,
    @p290 nvarchar(50) = NULL,
    @p291 int = NULL
,
    @p292 int = NULL,
    @p293 int = NULL,
    @p294 uniqueidentifier = NULL,
    @rowguid50 uniqueidentifier = NULL,
    @setbm50 varbinary(125) = NULL,
    @metadata_type50 tinyint = NULL,
    @lineage_old50 varbinary(311) = NULL,
    @generation50 bigint = NULL,
    @lineage_new50 varbinary(311) = NULL,
    @colv50 varbinary(1) = NULL,
    @p295 varchar(12) = NULL,
    @p296 nvarchar(50) = NULL,
    @p297 int = NULL,
    @p298 int = NULL,
    @p299 int = NULL,
    @p300 uniqueidentifier = NULL,
    @rowguid51 uniqueidentifier = NULL,
    @setbm51 varbinary(125) = NULL,
    @metadata_type51 tinyint = NULL,
    @lineage_old51 varbinary(311) = NULL,
    @generation51 bigint = NULL,
    @lineage_new51 varbinary(311) = NULL,
    @colv51 varbinary(1) = NULL,
    @p301 varchar(12) = NULL,
    @p302 nvarchar(50) = NULL,
    @p303 int = NULL,
    @p304 int = NULL,
    @p305 int = NULL,
    @p306 uniqueidentifier = NULL,
    @rowguid52 uniqueidentifier = NULL,
    @setbm52 varbinary(125) = NULL,
    @metadata_type52 tinyint = NULL,
    @lineage_old52 varbinary(311) = NULL,
    @generation52 bigint = NULL,
    @lineage_new52 varbinary(311) = NULL,
    @colv52 varbinary(1) = NULL,
    @p307 varchar(12) = NULL,
    @p308 nvarchar(50) = NULL,
    @p309 int = NULL,
    @p310 int = NULL,
    @p311 int = NULL,
    @p312 uniqueidentifier = NULL,
    @rowguid53 uniqueidentifier = NULL,
    @setbm53 varbinary(125) = NULL,
    @metadata_type53 tinyint = NULL,
    @lineage_old53 varbinary(311) = NULL,
    @generation53 bigint = NULL,
    @lineage_new53 varbinary(311) = NULL,
    @colv53 varbinary(1) = NULL,
    @p313 varchar(12) = NULL,
    @p314 nvarchar(50) = NULL,
    @p315 int = NULL,
    @p316 int = NULL,
    @p317 int = NULL,
    @p318 uniqueidentifier = NULL,
    @rowguid54 uniqueidentifier = NULL,
    @setbm54 varbinary(125) = NULL,
    @metadata_type54 tinyint = NULL,
    @lineage_old54 varbinary(311) = NULL,
    @generation54 bigint = NULL,
    @lineage_new54 varbinary(311) = NULL,
    @colv54 varbinary(1) = NULL,
    @p319 varchar(12) = NULL,
    @p320 nvarchar(50) = NULL,
    @p321 int = NULL,
    @p322 int = NULL,
    @p323 int = NULL,
    @p324 uniqueidentifier = NULL,
    @rowguid55 uniqueidentifier = NULL,
    @setbm55 varbinary(125) = NULL,
    @metadata_type55 tinyint = NULL,
    @lineage_old55 varbinary(311) = NULL,
    @generation55 bigint = NULL,
    @lineage_new55 varbinary(311) = NULL,
    @colv55 varbinary(1) = NULL,
    @p325 varchar(12) = NULL,
    @p326 nvarchar(50) = NULL,
    @p327 int = NULL,
    @p328 int = NULL,
    @p329 int = NULL,
    @p330 uniqueidentifier = NULL,
    @rowguid56 uniqueidentifier = NULL,
    @setbm56 varbinary(125) = NULL,
    @metadata_type56 tinyint = NULL,
    @lineage_old56 varbinary(311) = NULL,
    @generation56 bigint = NULL,
    @lineage_new56 varbinary(311) = NULL,
    @colv56 varbinary(1) = NULL,
    @p331 varchar(12) = NULL,
    @p332 nvarchar(50) = NULL,
    @p333 int = NULL,
    @p334 int = NULL,
    @p335 int = NULL,
    @p336 uniqueidentifier = NULL,
    @rowguid57 uniqueidentifier = NULL,
    @setbm57 varbinary(125) = NULL,
    @metadata_type57 tinyint = NULL,
    @lineage_old57 varbinary(311) = NULL,
    @generation57 bigint = NULL,
    @lineage_new57 varbinary(311) = NULL,
    @colv57 varbinary(1) = NULL,
    @p337 varchar(12) = NULL,
    @p338 nvarchar(50) = NULL,
    @p339 int = NULL
,
    @p340 int = NULL,
    @p341 int = NULL,
    @p342 uniqueidentifier = NULL,
    @rowguid58 uniqueidentifier = NULL,
    @setbm58 varbinary(125) = NULL,
    @metadata_type58 tinyint = NULL,
    @lineage_old58 varbinary(311) = NULL,
    @generation58 bigint = NULL,
    @lineage_new58 varbinary(311) = NULL,
    @colv58 varbinary(1) = NULL,
    @p343 varchar(12) = NULL,
    @p344 nvarchar(50) = NULL,
    @p345 int = NULL,
    @p346 int = NULL,
    @p347 int = NULL,
    @p348 uniqueidentifier = NULL,
    @rowguid59 uniqueidentifier = NULL,
    @setbm59 varbinary(125) = NULL,
    @metadata_type59 tinyint = NULL,
    @lineage_old59 varbinary(311) = NULL,
    @generation59 bigint = NULL,
    @lineage_new59 varbinary(311) = NULL,
    @colv59 varbinary(1) = NULL,
    @p349 varchar(12) = NULL,
    @p350 nvarchar(50) = NULL,
    @p351 int = NULL,
    @p352 int = NULL,
    @p353 int = NULL,
    @p354 uniqueidentifier = NULL,
    @rowguid60 uniqueidentifier = NULL,
    @setbm60 varbinary(125) = NULL,
    @metadata_type60 tinyint = NULL,
    @lineage_old60 varbinary(311) = NULL,
    @generation60 bigint = NULL,
    @lineage_new60 varbinary(311) = NULL,
    @colv60 varbinary(1) = NULL,
    @p355 varchar(12) = NULL,
    @p356 nvarchar(50) = NULL,
    @p357 int = NULL,
    @p358 int = NULL,
    @p359 int = NULL,
    @p360 uniqueidentifier = NULL,
    @rowguid61 uniqueidentifier = NULL,
    @setbm61 varbinary(125) = NULL,
    @metadata_type61 tinyint = NULL,
    @lineage_old61 varbinary(311) = NULL,
    @generation61 bigint = NULL,
    @lineage_new61 varbinary(311) = NULL,
    @colv61 varbinary(1) = NULL,
    @p361 varchar(12) = NULL,
    @p362 nvarchar(50) = NULL,
    @p363 int = NULL,
    @p364 int = NULL,
    @p365 int = NULL,
    @p366 uniqueidentifier = NULL,
    @rowguid62 uniqueidentifier = NULL,
    @setbm62 varbinary(125) = NULL,
    @metadata_type62 tinyint = NULL,
    @lineage_old62 varbinary(311) = NULL,
    @generation62 bigint = NULL,
    @lineage_new62 varbinary(311) = NULL,
    @colv62 varbinary(1) = NULL,
    @p367 varchar(12) = NULL,
    @p368 nvarchar(50) = NULL,
    @p369 int = NULL,
    @p370 int = NULL,
    @p371 int = NULL,
    @p372 uniqueidentifier = NULL,
    @rowguid63 uniqueidentifier = NULL,
    @setbm63 varbinary(125) = NULL,
    @metadata_type63 tinyint = NULL,
    @lineage_old63 varbinary(311) = NULL,
    @generation63 bigint = NULL,
    @lineage_new63 varbinary(311) = NULL,
    @colv63 varbinary(1) = NULL,
    @p373 varchar(12) = NULL,
    @p374 nvarchar(50) = NULL,
    @p375 int = NULL,
    @p376 int = NULL,
    @p377 int = NULL,
    @p378 uniqueidentifier = NULL,
    @rowguid64 uniqueidentifier = NULL,
    @setbm64 varbinary(125) = NULL,
    @metadata_type64 tinyint = NULL,
    @lineage_old64 varbinary(311) = NULL,
    @generation64 bigint = NULL,
    @lineage_new64 varbinary(311) = NULL,
    @colv64 varbinary(1) = NULL,
    @p379 varchar(12) = NULL,
    @p380 nvarchar(50) = NULL,
    @p381 int = NULL,
    @p382 int = NULL,
    @p383 int = NULL,
    @p384 uniqueidentifier = NULL,
    @rowguid65 uniqueidentifier = NULL,
    @setbm65 varbinary(125) = NULL,
    @metadata_type65 tinyint = NULL,
    @lineage_old65 varbinary(311) = NULL,
    @generation65 bigint = NULL,
    @lineage_new65 varbinary(311) = NULL,
    @colv65 varbinary(1) = NULL,
    @p385 varchar(12) = NULL,
    @p386 nvarchar(50) = NULL,
    @p387 int = NULL
,
    @p388 int = NULL,
    @p389 int = NULL,
    @p390 uniqueidentifier = NULL,
    @rowguid66 uniqueidentifier = NULL,
    @setbm66 varbinary(125) = NULL,
    @metadata_type66 tinyint = NULL,
    @lineage_old66 varbinary(311) = NULL,
    @generation66 bigint = NULL,
    @lineage_new66 varbinary(311) = NULL,
    @colv66 varbinary(1) = NULL,
    @p391 varchar(12) = NULL,
    @p392 nvarchar(50) = NULL,
    @p393 int = NULL,
    @p394 int = NULL,
    @p395 int = NULL,
    @p396 uniqueidentifier = NULL,
    @rowguid67 uniqueidentifier = NULL,
    @setbm67 varbinary(125) = NULL,
    @metadata_type67 tinyint = NULL,
    @lineage_old67 varbinary(311) = NULL,
    @generation67 bigint = NULL,
    @lineage_new67 varbinary(311) = NULL,
    @colv67 varbinary(1) = NULL,
    @p397 varchar(12) = NULL,
    @p398 nvarchar(50) = NULL,
    @p399 int = NULL,
    @p400 int = NULL,
    @p401 int = NULL,
    @p402 uniqueidentifier = NULL,
    @rowguid68 uniqueidentifier = NULL,
    @setbm68 varbinary(125) = NULL,
    @metadata_type68 tinyint = NULL,
    @lineage_old68 varbinary(311) = NULL,
    @generation68 bigint = NULL,
    @lineage_new68 varbinary(311) = NULL,
    @colv68 varbinary(1) = NULL,
    @p403 varchar(12) = NULL,
    @p404 nvarchar(50) = NULL,
    @p405 int = NULL,
    @p406 int = NULL,
    @p407 int = NULL,
    @p408 uniqueidentifier = NULL,
    @rowguid69 uniqueidentifier = NULL,
    @setbm69 varbinary(125) = NULL,
    @metadata_type69 tinyint = NULL,
    @lineage_old69 varbinary(311) = NULL,
    @generation69 bigint = NULL,
    @lineage_new69 varbinary(311) = NULL,
    @colv69 varbinary(1) = NULL,
    @p409 varchar(12) = NULL,
    @p410 nvarchar(50) = NULL,
    @p411 int = NULL,
    @p412 int = NULL,
    @p413 int = NULL,
    @p414 uniqueidentifier = NULL,
    @rowguid70 uniqueidentifier = NULL,
    @setbm70 varbinary(125) = NULL,
    @metadata_type70 tinyint = NULL,
    @lineage_old70 varbinary(311) = NULL,
    @generation70 bigint = NULL,
    @lineage_new70 varbinary(311) = NULL,
    @colv70 varbinary(1) = NULL,
    @p415 varchar(12) = NULL,
    @p416 nvarchar(50) = NULL,
    @p417 int = NULL,
    @p418 int = NULL,
    @p419 int = NULL,
    @p420 uniqueidentifier = NULL,
    @rowguid71 uniqueidentifier = NULL,
    @setbm71 varbinary(125) = NULL,
    @metadata_type71 tinyint = NULL,
    @lineage_old71 varbinary(311) = NULL,
    @generation71 bigint = NULL,
    @lineage_new71 varbinary(311) = NULL,
    @colv71 varbinary(1) = NULL,
    @p421 varchar(12) = NULL,
    @p422 nvarchar(50) = NULL,
    @p423 int = NULL,
    @p424 int = NULL,
    @p425 int = NULL,
    @p426 uniqueidentifier = NULL,
    @rowguid72 uniqueidentifier = NULL,
    @setbm72 varbinary(125) = NULL,
    @metadata_type72 tinyint = NULL,
    @lineage_old72 varbinary(311) = NULL,
    @generation72 bigint = NULL,
    @lineage_new72 varbinary(311) = NULL,
    @colv72 varbinary(1) = NULL,
    @p427 varchar(12) = NULL,
    @p428 nvarchar(50) = NULL,
    @p429 int = NULL,
    @p430 int = NULL,
    @p431 int = NULL,
    @p432 uniqueidentifier = NULL,
    @rowguid73 uniqueidentifier = NULL,
    @setbm73 varbinary(125) = NULL,
    @metadata_type73 tinyint = NULL,
    @lineage_old73 varbinary(311) = NULL,
    @generation73 bigint = NULL,
    @lineage_new73 varbinary(311) = NULL,
    @colv73 varbinary(1) = NULL,
    @p433 varchar(12) = NULL,
    @p434 nvarchar(50) = NULL,
    @p435 int = NULL
,
    @p436 int = NULL,
    @p437 int = NULL,
    @p438 uniqueidentifier = NULL,
    @rowguid74 uniqueidentifier = NULL,
    @setbm74 varbinary(125) = NULL,
    @metadata_type74 tinyint = NULL,
    @lineage_old74 varbinary(311) = NULL,
    @generation74 bigint = NULL,
    @lineage_new74 varbinary(311) = NULL,
    @colv74 varbinary(1) = NULL,
    @p439 varchar(12) = NULL,
    @p440 nvarchar(50) = NULL,
    @p441 int = NULL,
    @p442 int = NULL,
    @p443 int = NULL,
    @p444 uniqueidentifier = NULL,
    @rowguid75 uniqueidentifier = NULL,
    @setbm75 varbinary(125) = NULL,
    @metadata_type75 tinyint = NULL,
    @lineage_old75 varbinary(311) = NULL,
    @generation75 bigint = NULL,
    @lineage_new75 varbinary(311) = NULL,
    @colv75 varbinary(1) = NULL,
    @p445 varchar(12) = NULL,
    @p446 nvarchar(50) = NULL,
    @p447 int = NULL,
    @p448 int = NULL,
    @p449 int = NULL,
    @p450 uniqueidentifier = NULL,
    @rowguid76 uniqueidentifier = NULL,
    @setbm76 varbinary(125) = NULL,
    @metadata_type76 tinyint = NULL,
    @lineage_old76 varbinary(311) = NULL,
    @generation76 bigint = NULL,
    @lineage_new76 varbinary(311) = NULL,
    @colv76 varbinary(1) = NULL,
    @p451 varchar(12) = NULL,
    @p452 nvarchar(50) = NULL,
    @p453 int = NULL,
    @p454 int = NULL,
    @p455 int = NULL,
    @p456 uniqueidentifier = NULL,
    @rowguid77 uniqueidentifier = NULL,
    @setbm77 varbinary(125) = NULL,
    @metadata_type77 tinyint = NULL,
    @lineage_old77 varbinary(311) = NULL,
    @generation77 bigint = NULL,
    @lineage_new77 varbinary(311) = NULL,
    @colv77 varbinary(1) = NULL,
    @p457 varchar(12) = NULL,
    @p458 nvarchar(50) = NULL,
    @p459 int = NULL,
    @p460 int = NULL,
    @p461 int = NULL,
    @p462 uniqueidentifier = NULL,
    @rowguid78 uniqueidentifier = NULL,
    @setbm78 varbinary(125) = NULL,
    @metadata_type78 tinyint = NULL,
    @lineage_old78 varbinary(311) = NULL,
    @generation78 bigint = NULL,
    @lineage_new78 varbinary(311) = NULL,
    @colv78 varbinary(1) = NULL,
    @p463 varchar(12) = NULL
,
    @p464 nvarchar(50) = NULL
,
    @p465 int = NULL
,
    @p466 int = NULL
,
    @p467 int = NULL
,
    @p468 uniqueidentifier = NULL

) as
begin
    declare @errcode    int
    declare @retcode    int
    declare @rowcount   int
    declare @error      int
    declare @publication_number smallint
    declare @filtering_column_updated bit
    declare @rows_updated int
    declare @cont_rows_updated int
    declare @rows_in_syncview int
    
    set nocount on
    
    set @errcode= 0
    set @publication_number = 4
    
    if ({ fn ISPALUSER('8D8B572F-B352-4CD3-9BF9-08911C828501') } <> 1)
    begin
        RAISERROR (14126, 11, -1)
        return 4
    end

    if @rows_tobe_updated is NULL or @rows_tobe_updated <=0
        return 0

    select @filtering_column_updated = 0
    select @rows_updated = 0
    select @cont_rows_updated = 0 

    begin tran
    save tran batchupdateproc 

    select @filtering_column_updated = 0

    -- case 1 of setting the filtering column where we are setting it to NULL and the table has a non NULL value for this column
    select @filtering_column_updated = 1 from 
        (

            select @rowguid1 as rowguid, @p1 as c1, @setbm1 as setbm
 union all
            select @rowguid2 as rowguid, @p7 as c1, @setbm2 as setbm
 union all
            select @rowguid3 as rowguid, @p13 as c1, @setbm3 as setbm
 union all
            select @rowguid4 as rowguid, @p19 as c1, @setbm4 as setbm
 union all
            select @rowguid5 as rowguid, @p25 as c1, @setbm5 as setbm
 union all
            select @rowguid6 as rowguid, @p31 as c1, @setbm6 as setbm
 union all
            select @rowguid7 as rowguid, @p37 as c1, @setbm7 as setbm
 union all
            select @rowguid8 as rowguid, @p43 as c1, @setbm8 as setbm
 union all
            select @rowguid9 as rowguid, @p49 as c1, @setbm9 as setbm
 union all
            select @rowguid10 as rowguid, @p55 as c1, @setbm10 as setbm
 union all
            select @rowguid11 as rowguid, @p61 as c1, @setbm11 as setbm
 union all
            select @rowguid12 as rowguid, @p67 as c1, @setbm12 as setbm
 union all
            select @rowguid13 as rowguid, @p73 as c1, @setbm13 as setbm
 union all
            select @rowguid14 as rowguid, @p79 as c1, @setbm14 as setbm
 union all
            select @rowguid15 as rowguid, @p85 as c1, @setbm15 as setbm
 union all
            select @rowguid16 as rowguid, @p91 as c1, @setbm16 as setbm
 union all
            select @rowguid17 as rowguid, @p97 as c1, @setbm17 as setbm
 union all
            select @rowguid18 as rowguid, @p103 as c1, @setbm18 as setbm
 union all
            select @rowguid19 as rowguid, @p109 as c1, @setbm19 as setbm
 union all
            select @rowguid20 as rowguid, @p115 as c1, @setbm20 as setbm
 union all
            select @rowguid21 as rowguid, @p121 as c1, @setbm21 as setbm
 union all
            select @rowguid22 as rowguid, @p127 as c1, @setbm22 as setbm
 union all
            select @rowguid23 as rowguid, @p133 as c1, @setbm23 as setbm
 union all
            select @rowguid24 as rowguid, @p139 as c1, @setbm24 as setbm
 union all
            select @rowguid25 as rowguid, @p145 as c1, @setbm25 as setbm
 union all
            select @rowguid26 as rowguid, @p151 as c1, @setbm26 as setbm
 union all
            select @rowguid27 as rowguid, @p157 as c1, @setbm27 as setbm
 union all
            select @rowguid28 as rowguid, @p163 as c1, @setbm28 as setbm
 union all
            select @rowguid29 as rowguid, @p169 as c1, @setbm29 as setbm
 union all
            select @rowguid30 as rowguid, @p175 as c1, @setbm30 as setbm
 union all
            select @rowguid31 as rowguid, @p181 as c1, @setbm31 as setbm
 union all
            select @rowguid32 as rowguid, @p187 as c1, @setbm32 as setbm
 union all
            select @rowguid33 as rowguid, @p193 as c1, @setbm33 as setbm
 union all
            select @rowguid34 as rowguid, @p199 as c1, @setbm34 as setbm
 union all
            select @rowguid35 as rowguid, @p205 as c1, @setbm35 as setbm
 union all
            select @rowguid36 as rowguid, @p211 as c1, @setbm36 as setbm
 union all
            select @rowguid37 as rowguid, @p217 as c1, @setbm37 as setbm
 union all
            select @rowguid38 as rowguid, @p223 as c1, @setbm38 as setbm
 union all
            select @rowguid39 as rowguid, @p229 as c1, @setbm39 as setbm
 union all
            select @rowguid40 as rowguid, @p235 as c1, @setbm40 as setbm
 union all
            select @rowguid41 as rowguid, @p241 as c1, @setbm41 as setbm
 union all
            select @rowguid42 as rowguid, @p247 as c1, @setbm42 as setbm
 union all
            select @rowguid43 as rowguid, @p253 as c1, @setbm43 as setbm
 union all
            select @rowguid44 as rowguid, @p259 as c1, @setbm44 as setbm
 union all
            select @rowguid45 as rowguid, @p265 as c1, @setbm45 as setbm
 union all
            select @rowguid46 as rowguid, @p271 as c1, @setbm46 as setbm
 union all
            select @rowguid47 as rowguid, @p277 as c1, @setbm47 as setbm
 union all
            select @rowguid48 as rowguid, @p283 as c1, @setbm48 as setbm
 union all
            select @rowguid49 as rowguid, @p289 as c1, @setbm49 as setbm
 union all
            select @rowguid50 as rowguid, @p295 as c1, @setbm50 as setbm
 union all
            select @rowguid51 as rowguid, @p301 as c1, @setbm51 as setbm
 union all
            select @rowguid52 as rowguid, @p307 as c1, @setbm52 as setbm
 union all
            select @rowguid53 as rowguid, @p313 as c1, @setbm53 as setbm
 union all
            select @rowguid54 as rowguid, @p319 as c1, @setbm54 as setbm
 union all
            select @rowguid55 as rowguid, @p325 as c1, @setbm55 as setbm
 union all
            select @rowguid56 as rowguid, @p331 as c1, @setbm56 as setbm
 union all
            select @rowguid57 as rowguid, @p337 as c1, @setbm57 as setbm
 union all
            select @rowguid58 as rowguid, @p343 as c1, @setbm58 as setbm
 union all
            select @rowguid59 as rowguid, @p349 as c1, @setbm59 as setbm
 union all
            select @rowguid60 as rowguid, @p355 as c1, @setbm60 as setbm
 union all
            select @rowguid61 as rowguid, @p361 as c1, @setbm61 as setbm
 union all
            select @rowguid62 as rowguid, @p367 as c1, @setbm62 as setbm
 union all
            select @rowguid63 as rowguid, @p373 as c1, @setbm63 as setbm
 union all
            select @rowguid64 as rowguid, @p379 as c1, @setbm64 as setbm
 union all
            select @rowguid65 as rowguid, @p385 as c1, @setbm65 as setbm
 union all
            select @rowguid66 as rowguid, @p391 as c1, @setbm66 as setbm
 union all
            select @rowguid67 as rowguid, @p397 as c1, @setbm67 as setbm
 union all
            select @rowguid68 as rowguid, @p403 as c1, @setbm68 as setbm
 union all
            select @rowguid69 as rowguid, @p409 as c1, @setbm69 as setbm
 union all
            select @rowguid70 as rowguid, @p415 as c1, @setbm70 as setbm
 union all
            select @rowguid71 as rowguid, @p421 as c1, @setbm71 as setbm
 union all
            select @rowguid72 as rowguid, @p427 as c1, @setbm72 as setbm
 union all
            select @rowguid73 as rowguid, @p433 as c1, @setbm73 as setbm
 union all
            select @rowguid74 as rowguid, @p439 as c1, @setbm74 as setbm
 union all
            select @rowguid75 as rowguid, @p445 as c1, @setbm75 as setbm
 union all
            select @rowguid76 as rowguid, @p451 as c1, @setbm76 as setbm
 union all
            select @rowguid77 as rowguid, @p457 as c1, @setbm77 as setbm
 union all
            select @rowguid78 as rowguid, @p463 as c1, @setbm78 as setbm

        ) as rows
        inner join [dbo].[HOCPHI] t with (rowlock) 
        on t.[rowguid] = rows.rowguid and rows.rowguid is not NULL
        where rows.c1 is NULL and sys.fn_IsBitSetInBitmask(rows.setbm, 1) <> 0 and t.[MASV] is not NULL
        
    if @filtering_column_updated = 1
    begin
        raiserror(20694, 16, -1, 'HOCPHI', '[MASV]')
        set @errcode=4
        goto Failure
    end

    -- case 2 of setting the filtering column where we are setting it to a not null value and the value is not equal to the value in the table
    select @filtering_column_updated = 1 from 
        (

            select @rowguid1 as rowguid, @p1 as c1
 union all
            select @rowguid2 as rowguid, @p7 as c1
 union all
            select @rowguid3 as rowguid, @p13 as c1
 union all
            select @rowguid4 as rowguid, @p19 as c1
 union all
            select @rowguid5 as rowguid, @p25 as c1
 union all
            select @rowguid6 as rowguid, @p31 as c1
 union all
            select @rowguid7 as rowguid, @p37 as c1
 union all
            select @rowguid8 as rowguid, @p43 as c1
 union all
            select @rowguid9 as rowguid, @p49 as c1
 union all
            select @rowguid10 as rowguid, @p55 as c1
 union all
            select @rowguid11 as rowguid, @p61 as c1
 union all
            select @rowguid12 as rowguid, @p67 as c1
 union all
            select @rowguid13 as rowguid, @p73 as c1
 union all
            select @rowguid14 as rowguid, @p79 as c1
 union all
            select @rowguid15 as rowguid, @p85 as c1
 union all
            select @rowguid16 as rowguid, @p91 as c1
 union all
            select @rowguid17 as rowguid, @p97 as c1
 union all
            select @rowguid18 as rowguid, @p103 as c1
 union all
            select @rowguid19 as rowguid, @p109 as c1
 union all
            select @rowguid20 as rowguid, @p115 as c1
 union all
            select @rowguid21 as rowguid, @p121 as c1
 union all
            select @rowguid22 as rowguid, @p127 as c1
 union all
            select @rowguid23 as rowguid, @p133 as c1
 union all
            select @rowguid24 as rowguid, @p139 as c1
 union all
            select @rowguid25 as rowguid, @p145 as c1
 union all
            select @rowguid26 as rowguid, @p151 as c1
 union all
            select @rowguid27 as rowguid, @p157 as c1
 union all
            select @rowguid28 as rowguid, @p163 as c1
 union all
            select @rowguid29 as rowguid, @p169 as c1
 union all
            select @rowguid30 as rowguid, @p175 as c1
 union all
            select @rowguid31 as rowguid, @p181 as c1
 union all
            select @rowguid32 as rowguid, @p187 as c1
 union all
            select @rowguid33 as rowguid, @p193 as c1
 union all
            select @rowguid34 as rowguid, @p199 as c1
 union all
            select @rowguid35 as rowguid, @p205 as c1
 union all
            select @rowguid36 as rowguid, @p211 as c1
 union all
            select @rowguid37 as rowguid, @p217 as c1
 union all
            select @rowguid38 as rowguid, @p223 as c1
 union all
            select @rowguid39 as rowguid, @p229 as c1
 union all
            select @rowguid40 as rowguid, @p235 as c1
 union all
            select @rowguid41 as rowguid, @p241 as c1
 union all
            select @rowguid42 as rowguid, @p247 as c1
 union all
            select @rowguid43 as rowguid, @p253 as c1
 union all
            select @rowguid44 as rowguid, @p259 as c1
 union all
            select @rowguid45 as rowguid, @p265 as c1
 union all
            select @rowguid46 as rowguid, @p271 as c1
 union all
            select @rowguid47 as rowguid, @p277 as c1
 union all
            select @rowguid48 as rowguid, @p283 as c1
 union all
            select @rowguid49 as rowguid, @p289 as c1
 union all
            select @rowguid50 as rowguid, @p295 as c1
 union all
            select @rowguid51 as rowguid, @p301 as c1
 union all
            select @rowguid52 as rowguid, @p307 as c1
 union all
            select @rowguid53 as rowguid, @p313 as c1
 union all
            select @rowguid54 as rowguid, @p319 as c1
 union all
            select @rowguid55 as rowguid, @p325 as c1
 union all
            select @rowguid56 as rowguid, @p331 as c1
 union all
            select @rowguid57 as rowguid, @p337 as c1
 union all
            select @rowguid58 as rowguid, @p343 as c1
 union all
            select @rowguid59 as rowguid, @p349 as c1
 union all
            select @rowguid60 as rowguid, @p355 as c1
 union all
            select @rowguid61 as rowguid, @p361 as c1
 union all
            select @rowguid62 as rowguid, @p367 as c1
 union all
            select @rowguid63 as rowguid, @p373 as c1
 union all
            select @rowguid64 as rowguid, @p379 as c1
 union all
            select @rowguid65 as rowguid, @p385 as c1
 union all
            select @rowguid66 as rowguid, @p391 as c1
 union all
            select @rowguid67 as rowguid, @p397 as c1
 union all
            select @rowguid68 as rowguid, @p403 as c1
 union all
            select @rowguid69 as rowguid, @p409 as c1
 union all
            select @rowguid70 as rowguid, @p415 as c1
 union all
            select @rowguid71 as rowguid, @p421 as c1
 union all
            select @rowguid72 as rowguid, @p427 as c1
 union all
            select @rowguid73 as rowguid, @p433 as c1
 union all
            select @rowguid74 as rowguid, @p439 as c1
 union all
            select @rowguid75 as rowguid, @p445 as c1
 union all
            select @rowguid76 as rowguid, @p451 as c1
 union all
            select @rowguid77 as rowguid, @p457 as c1
 union all
            select @rowguid78 as rowguid, @p463 as c1

        ) as rows
        inner join [dbo].[HOCPHI] t with (rowlock) 
        on t.[rowguid] = rows.rowguid and rows.rowguid is not NULL
        where rows.c1 is not NULL and (t.[MASV] is NULL or t.[MASV] <> rows.c1 )   

    if @filtering_column_updated = 1
    begin
        raiserror(20694, 16, -1, 'HOCPHI', '[MASV]')
        set @errcode=4
        goto Failure
    end

    update [dbo].[HOCPHI] with (rowlock)
    set 

        [NIENKHOA] = case when rows.c2 is NULL then (case when sys.fn_IsBitSetInBitmask(rows.setbm, 2) <> 0 then rows.c2 else t.[NIENKHOA] end) else rows.c2 end 
,
        [HOCKY] = case when rows.c3 is NULL then (case when sys.fn_IsBitSetInBitmask(rows.setbm, 3) <> 0 then rows.c3 else t.[HOCKY] end) else rows.c3 end 
,
        [HOCPHI] = case when rows.c4 is NULL then (case when sys.fn_IsBitSetInBitmask(rows.setbm, 4) <> 0 then rows.c4 else t.[HOCPHI] end) else rows.c4 end 
,
        [SOTIENDADONG] = case when rows.c5 is NULL then (case when sys.fn_IsBitSetInBitmask(rows.setbm, 5) <> 0 then rows.c5 else t.[SOTIENDADONG] end) else rows.c5 end 

    from (

    select @rowguid1 as rowguid, @setbm1 as setbm, @metadata_type1 as metadata_type, @lineage_old1 as lineage_old, @p2 as c2, @p3 as c3, @p4 as c4, @p5 as c5 union all
    select @rowguid2 as rowguid, @setbm2 as setbm, @metadata_type2 as metadata_type, @lineage_old2 as lineage_old, @p8 as c2, @p9 as c3, @p10 as c4, @p11 as c5 union all
    select @rowguid3 as rowguid, @setbm3 as setbm, @metadata_type3 as metadata_type, @lineage_old3 as lineage_old, @p14 as c2, @p15 as c3, @p16 as c4, @p17 as c5 union all
    select @rowguid4 as rowguid, @setbm4 as setbm, @metadata_type4 as metadata_type, @lineage_old4 as lineage_old, @p20 as c2, @p21 as c3, @p22 as c4, @p23 as c5 union all
    select @rowguid5 as rowguid, @setbm5 as setbm, @metadata_type5 as metadata_type, @lineage_old5 as lineage_old, @p26 as c2, @p27 as c3, @p28 as c4, @p29 as c5 union all
    select @rowguid6 as rowguid, @setbm6 as setbm, @metadata_type6 as metadata_type, @lineage_old6 as lineage_old, @p32 as c2, @p33 as c3, @p34 as c4, @p35 as c5 union all
    select @rowguid7 as rowguid, @setbm7 as setbm, @metadata_type7 as metadata_type, @lineage_old7 as lineage_old, @p38 as c2, @p39 as c3, @p40 as c4, @p41 as c5 union all
    select @rowguid8 as rowguid, @setbm8 as setbm, @metadata_type8 as metadata_type, @lineage_old8 as lineage_old, @p44 as c2, @p45 as c3, @p46 as c4, @p47 as c5 union all
    select @rowguid9 as rowguid, @setbm9 as setbm, @metadata_type9 as metadata_type, @lineage_old9 as lineage_old, @p50 as c2, @p51 as c3, @p52 as c4, @p53 as c5 union all
    select @rowguid10 as rowguid, @setbm10 as setbm, @metadata_type10 as metadata_type, @lineage_old10 as lineage_old, @p56 as c2, @p57 as c3, @p58 as c4, @p59 as c5 union all
    select @rowguid11 as rowguid, @setbm11 as setbm, @metadata_type11 as metadata_type, @lineage_old11 as lineage_old, @p62 as c2, @p63 as c3, @p64 as c4, @p65 as c5 union all
    select @rowguid12 as rowguid, @setbm12 as setbm, @metadata_type12 as metadata_type, @lineage_old12 as lineage_old, @p68 as c2, @p69 as c3, @p70 as c4, @p71 as c5 union all
    select @rowguid13 as rowguid, @setbm13 as setbm, @metadata_type13 as metadata_type, @lineage_old13 as lineage_old, @p74 as c2, @p75 as c3, @p76 as c4, @p77 as c5 union all
    select @rowguid14 as rowguid, @setbm14 as setbm, @metadata_type14 as metadata_type, @lineage_old14 as lineage_old, @p80 as c2, @p81 as c3, @p82 as c4, @p83 as c5 union all
    select @rowguid15 as rowguid, @setbm15 as setbm, @metadata_type15 as metadata_type, @lineage_old15 as lineage_old, @p86 as c2, @p87 as c3, @p88 as c4, @p89 as c5 union all
    select @rowguid16 as rowguid, @setbm16 as setbm, @metadata_type16 as metadata_type, @lineage_old16 as lineage_old, @p92 as c2, @p93 as c3, @p94 as c4, @p95 as c5 union all
    select @rowguid17 as rowguid, @setbm17 as setbm, @metadata_type17 as metadata_type, @lineage_old17 as lineage_old, @p98 as c2, @p99 as c3, @p100 as c4, @p101 as c5 union all
    select @rowguid18 as rowguid, @setbm18 as setbm, @metadata_type18 as metadata_type, @lineage_old18 as lineage_old, @p104 as c2, @p105 as c3, @p106 as c4, @p107 as c5 union all
    select @rowguid19 as rowguid, @setbm19 as setbm, @metadata_type19 as metadata_type, @lineage_old19 as lineage_old, @p110 as c2, @p111 as c3, @p112 as c4, @p113 as c5 union all
    select @rowguid20 as rowguid, @setbm20 as setbm, @metadata_type20 as metadata_type, @lineage_old20 as lineage_old, @p116 as c2, @p117 as c3, @p118 as c4, @p119 as c5 union all
    select @rowguid21 as rowguid, @setbm21 as setbm, @metadata_type21 as metadata_type, @lineage_old21 as lineage_old, @p122 as c2, @p123 as c3, @p124 as c4, @p125 as c5 union all
    select @rowguid22 as rowguid, @setbm22 as setbm, @metadata_type22 as metadata_type, @lineage_old22 as lineage_old, @p128 as c2
, @p129 as c3, @p130 as c4, @p131 as c5 union all
    select @rowguid23 as rowguid, @setbm23 as setbm, @metadata_type23 as metadata_type, @lineage_old23 as lineage_old, @p134 as c2, @p135 as c3, @p136 as c4, @p137 as c5 union all
    select @rowguid24 as rowguid, @setbm24 as setbm, @metadata_type24 as metadata_type, @lineage_old24 as lineage_old, @p140 as c2, @p141 as c3, @p142 as c4, @p143 as c5 union all
    select @rowguid25 as rowguid, @setbm25 as setbm, @metadata_type25 as metadata_type, @lineage_old25 as lineage_old, @p146 as c2, @p147 as c3, @p148 as c4, @p149 as c5 union all
    select @rowguid26 as rowguid, @setbm26 as setbm, @metadata_type26 as metadata_type, @lineage_old26 as lineage_old, @p152 as c2, @p153 as c3, @p154 as c4, @p155 as c5 union all
    select @rowguid27 as rowguid, @setbm27 as setbm, @metadata_type27 as metadata_type, @lineage_old27 as lineage_old, @p158 as c2, @p159 as c3, @p160 as c4, @p161 as c5 union all
    select @rowguid28 as rowguid, @setbm28 as setbm, @metadata_type28 as metadata_type, @lineage_old28 as lineage_old, @p164 as c2, @p165 as c3, @p166 as c4, @p167 as c5 union all
    select @rowguid29 as rowguid, @setbm29 as setbm, @metadata_type29 as metadata_type, @lineage_old29 as lineage_old, @p170 as c2, @p171 as c3, @p172 as c4, @p173 as c5 union all
    select @rowguid30 as rowguid, @setbm30 as setbm, @metadata_type30 as metadata_type, @lineage_old30 as lineage_old, @p176 as c2, @p177 as c3, @p178 as c4, @p179 as c5 union all
    select @rowguid31 as rowguid, @setbm31 as setbm, @metadata_type31 as metadata_type, @lineage_old31 as lineage_old, @p182 as c2, @p183 as c3, @p184 as c4, @p185 as c5 union all
    select @rowguid32 as rowguid, @setbm32 as setbm, @metadata_type32 as metadata_type, @lineage_old32 as lineage_old, @p188 as c2, @p189 as c3, @p190 as c4, @p191 as c5 union all
    select @rowguid33 as rowguid, @setbm33 as setbm, @metadata_type33 as metadata_type, @lineage_old33 as lineage_old, @p194 as c2, @p195 as c3, @p196 as c4, @p197 as c5 union all
    select @rowguid34 as rowguid, @setbm34 as setbm, @metadata_type34 as metadata_type, @lineage_old34 as lineage_old, @p200 as c2, @p201 as c3, @p202 as c4, @p203 as c5 union all
    select @rowguid35 as rowguid, @setbm35 as setbm, @metadata_type35 as metadata_type, @lineage_old35 as lineage_old, @p206 as c2, @p207 as c3, @p208 as c4, @p209 as c5 union all
    select @rowguid36 as rowguid, @setbm36 as setbm, @metadata_type36 as metadata_type, @lineage_old36 as lineage_old, @p212 as c2, @p213 as c3, @p214 as c4, @p215 as c5 union all
    select @rowguid37 as rowguid, @setbm37 as setbm, @metadata_type37 as metadata_type, @lineage_old37 as lineage_old, @p218 as c2, @p219 as c3, @p220 as c4, @p221 as c5 union all
    select @rowguid38 as rowguid, @setbm38 as setbm, @metadata_type38 as metadata_type, @lineage_old38 as lineage_old, @p224 as c2, @p225 as c3, @p226 as c4, @p227 as c5 union all
    select @rowguid39 as rowguid, @setbm39 as setbm, @metadata_type39 as metadata_type, @lineage_old39 as lineage_old, @p230 as c2, @p231 as c3, @p232 as c4, @p233 as c5 union all
    select @rowguid40 as rowguid, @setbm40 as setbm, @metadata_type40 as metadata_type, @lineage_old40 as lineage_old, @p236 as c2, @p237 as c3, @p238 as c4, @p239 as c5 union all
    select @rowguid41 as rowguid, @setbm41 as setbm, @metadata_type41 as metadata_type, @lineage_old41 as lineage_old, @p242 as c2, @p243 as c3, @p244 as c4, @p245 as c5 union all
    select @rowguid42 as rowguid, @setbm42 as setbm, @metadata_type42 as metadata_type, @lineage_old42 as lineage_old, @p248 as c2, @p249 as c3, @p250 as c4, @p251 as c5 union all
    select @rowguid43 as rowguid, @setbm43 as setbm, @metadata_type43 as metadata_type, @lineage_old43 as lineage_old, @p254 as c2
, @p255 as c3, @p256 as c4, @p257 as c5 union all
    select @rowguid44 as rowguid, @setbm44 as setbm, @metadata_type44 as metadata_type, @lineage_old44 as lineage_old, @p260 as c2, @p261 as c3, @p262 as c4, @p263 as c5 union all
    select @rowguid45 as rowguid, @setbm45 as setbm, @metadata_type45 as metadata_type, @lineage_old45 as lineage_old, @p266 as c2, @p267 as c3, @p268 as c4, @p269 as c5 union all
    select @rowguid46 as rowguid, @setbm46 as setbm, @metadata_type46 as metadata_type, @lineage_old46 as lineage_old, @p272 as c2, @p273 as c3, @p274 as c4, @p275 as c5 union all
    select @rowguid47 as rowguid, @setbm47 as setbm, @metadata_type47 as metadata_type, @lineage_old47 as lineage_old, @p278 as c2, @p279 as c3, @p280 as c4, @p281 as c5 union all
    select @rowguid48 as rowguid, @setbm48 as setbm, @metadata_type48 as metadata_type, @lineage_old48 as lineage_old, @p284 as c2, @p285 as c3, @p286 as c4, @p287 as c5 union all
    select @rowguid49 as rowguid, @setbm49 as setbm, @metadata_type49 as metadata_type, @lineage_old49 as lineage_old, @p290 as c2, @p291 as c3, @p292 as c4, @p293 as c5 union all
    select @rowguid50 as rowguid, @setbm50 as setbm, @metadata_type50 as metadata_type, @lineage_old50 as lineage_old, @p296 as c2, @p297 as c3, @p298 as c4, @p299 as c5 union all
    select @rowguid51 as rowguid, @setbm51 as setbm, @metadata_type51 as metadata_type, @lineage_old51 as lineage_old, @p302 as c2, @p303 as c3, @p304 as c4, @p305 as c5 union all
    select @rowguid52 as rowguid, @setbm52 as setbm, @metadata_type52 as metadata_type, @lineage_old52 as lineage_old, @p308 as c2, @p309 as c3, @p310 as c4, @p311 as c5 union all
    select @rowguid53 as rowguid, @setbm53 as setbm, @metadata_type53 as metadata_type, @lineage_old53 as lineage_old, @p314 as c2, @p315 as c3, @p316 as c4, @p317 as c5 union all
    select @rowguid54 as rowguid, @setbm54 as setbm, @metadata_type54 as metadata_type, @lineage_old54 as lineage_old, @p320 as c2, @p321 as c3, @p322 as c4, @p323 as c5 union all
    select @rowguid55 as rowguid, @setbm55 as setbm, @metadata_type55 as metadata_type, @lineage_old55 as lineage_old, @p326 as c2, @p327 as c3, @p328 as c4, @p329 as c5 union all
    select @rowguid56 as rowguid, @setbm56 as setbm, @metadata_type56 as metadata_type, @lineage_old56 as lineage_old, @p332 as c2, @p333 as c3, @p334 as c4, @p335 as c5 union all
    select @rowguid57 as rowguid, @setbm57 as setbm, @metadata_type57 as metadata_type, @lineage_old57 as lineage_old, @p338 as c2, @p339 as c3, @p340 as c4, @p341 as c5 union all
    select @rowguid58 as rowguid, @setbm58 as setbm, @metadata_type58 as metadata_type, @lineage_old58 as lineage_old, @p344 as c2, @p345 as c3, @p346 as c4, @p347 as c5 union all
    select @rowguid59 as rowguid, @setbm59 as setbm, @metadata_type59 as metadata_type, @lineage_old59 as lineage_old, @p350 as c2, @p351 as c3, @p352 as c4, @p353 as c5 union all
    select @rowguid60 as rowguid, @setbm60 as setbm, @metadata_type60 as metadata_type, @lineage_old60 as lineage_old, @p356 as c2, @p357 as c3, @p358 as c4, @p359 as c5 union all
    select @rowguid61 as rowguid, @setbm61 as setbm, @metadata_type61 as metadata_type, @lineage_old61 as lineage_old, @p362 as c2, @p363 as c3, @p364 as c4, @p365 as c5 union all
    select @rowguid62 as rowguid, @setbm62 as setbm, @metadata_type62 as metadata_type, @lineage_old62 as lineage_old, @p368 as c2, @p369 as c3, @p370 as c4, @p371 as c5 union all
    select @rowguid63 as rowguid, @setbm63 as setbm, @metadata_type63 as metadata_type, @lineage_old63 as lineage_old, @p374 as c2, @p375 as c3, @p376 as c4, @p377 as c5 union all
    select @rowguid64 as rowguid, @setbm64 as setbm, @metadata_type64 as metadata_type, @lineage_old64 as lineage_old, @p380 as c2
, @p381 as c3, @p382 as c4, @p383 as c5 union all
    select @rowguid65 as rowguid, @setbm65 as setbm, @metadata_type65 as metadata_type, @lineage_old65 as lineage_old, @p386 as c2, @p387 as c3, @p388 as c4, @p389 as c5 union all
    select @rowguid66 as rowguid, @setbm66 as setbm, @metadata_type66 as metadata_type, @lineage_old66 as lineage_old, @p392 as c2, @p393 as c3, @p394 as c4, @p395 as c5 union all
    select @rowguid67 as rowguid, @setbm67 as setbm, @metadata_type67 as metadata_type, @lineage_old67 as lineage_old, @p398 as c2, @p399 as c3, @p400 as c4, @p401 as c5 union all
    select @rowguid68 as rowguid, @setbm68 as setbm, @metadata_type68 as metadata_type, @lineage_old68 as lineage_old, @p404 as c2, @p405 as c3, @p406 as c4, @p407 as c5 union all
    select @rowguid69 as rowguid, @setbm69 as setbm, @metadata_type69 as metadata_type, @lineage_old69 as lineage_old, @p410 as c2, @p411 as c3, @p412 as c4, @p413 as c5 union all
    select @rowguid70 as rowguid, @setbm70 as setbm, @metadata_type70 as metadata_type, @lineage_old70 as lineage_old, @p416 as c2, @p417 as c3, @p418 as c4, @p419 as c5 union all
    select @rowguid71 as rowguid, @setbm71 as setbm, @metadata_type71 as metadata_type, @lineage_old71 as lineage_old, @p422 as c2, @p423 as c3, @p424 as c4, @p425 as c5 union all
    select @rowguid72 as rowguid, @setbm72 as setbm, @metadata_type72 as metadata_type, @lineage_old72 as lineage_old, @p428 as c2, @p429 as c3, @p430 as c4, @p431 as c5 union all
    select @rowguid73 as rowguid, @setbm73 as setbm, @metadata_type73 as metadata_type, @lineage_old73 as lineage_old, @p434 as c2, @p435 as c3, @p436 as c4, @p437 as c5 union all
    select @rowguid74 as rowguid, @setbm74 as setbm, @metadata_type74 as metadata_type, @lineage_old74 as lineage_old, @p440 as c2, @p441 as c3, @p442 as c4, @p443 as c5 union all
    select @rowguid75 as rowguid, @setbm75 as setbm, @metadata_type75 as metadata_type, @lineage_old75 as lineage_old, @p446 as c2, @p447 as c3, @p448 as c4, @p449 as c5 union all
    select @rowguid76 as rowguid, @setbm76 as setbm, @metadata_type76 as metadata_type, @lineage_old76 as lineage_old, @p452 as c2, @p453 as c3, @p454 as c4, @p455 as c5 union all
    select @rowguid77 as rowguid, @setbm77 as setbm, @metadata_type77 as metadata_type, @lineage_old77 as lineage_old, @p458 as c2, @p459 as c3, @p460 as c4, @p461 as c5 union all
    select @rowguid78 as rowguid, @setbm78 as setbm, @metadata_type78 as metadata_type, @lineage_old78 as lineage_old, @p464 as c2
, @p465 as c3
, @p466 as c4
, @p467 as c5
) as rows
    inner join [dbo].[HOCPHI] t with (rowlock) on rows.rowguid = t.[rowguid]
        and rows.rowguid is not null
    left outer join dbo.MSmerge_contents cont with (rowlock) on rows.rowguid = cont.rowguid 
    and cont.tablenick = 31081000
    where  ((rows.metadata_type = 2 and cont.rowguid is not NULL and cont.lineage = rows.lineage_old) or
           (rows.metadata_type = 3 and cont.rowguid is NULL))
           and rows.rowguid is not null
    
    select @rowcount = @@rowcount, @error = @@error

    select @rows_updated = @rowcount
    if (@rows_updated <> @rows_tobe_updated) or (@error <> 0)
    begin
        raiserror(20695, 16, -1, @rows_updated, @rows_tobe_updated, 'HOCPHI')
        set @errcode= 3
        goto Failure
    end

    update dbo.MSmerge_contents with (rowlock)
    set generation = rows.generation,
        lineage = rows.lineage_new,
        colv1 = rows.colv
    from (

    select @rowguid1 as rowguid, @generation1 as generation, @lineage_new1 as lineage_new, @colv1 as colv union all
    select @rowguid2 as rowguid, @generation2 as generation, @lineage_new2 as lineage_new, @colv2 as colv union all
    select @rowguid3 as rowguid, @generation3 as generation, @lineage_new3 as lineage_new, @colv3 as colv union all
    select @rowguid4 as rowguid, @generation4 as generation, @lineage_new4 as lineage_new, @colv4 as colv union all
    select @rowguid5 as rowguid, @generation5 as generation, @lineage_new5 as lineage_new, @colv5 as colv union all
    select @rowguid6 as rowguid, @generation6 as generation, @lineage_new6 as lineage_new, @colv6 as colv union all
    select @rowguid7 as rowguid, @generation7 as generation, @lineage_new7 as lineage_new, @colv7 as colv union all
    select @rowguid8 as rowguid, @generation8 as generation, @lineage_new8 as lineage_new, @colv8 as colv union all
    select @rowguid9 as rowguid, @generation9 as generation, @lineage_new9 as lineage_new, @colv9 as colv union all
    select @rowguid10 as rowguid, @generation10 as generation, @lineage_new10 as lineage_new, @colv10 as colv union all
    select @rowguid11 as rowguid, @generation11 as generation, @lineage_new11 as lineage_new, @colv11 as colv union all
    select @rowguid12 as rowguid, @generation12 as generation, @lineage_new12 as lineage_new, @colv12 as colv union all
    select @rowguid13 as rowguid, @generation13 as generation, @lineage_new13 as lineage_new, @colv13 as colv union all
    select @rowguid14 as rowguid, @generation14 as generation, @lineage_new14 as lineage_new, @colv14 as colv union all
    select @rowguid15 as rowguid, @generation15 as generation, @lineage_new15 as lineage_new, @colv15 as colv union all
    select @rowguid16 as rowguid, @generation16 as generation, @lineage_new16 as lineage_new, @colv16 as colv union all
    select @rowguid17 as rowguid, @generation17 as generation, @lineage_new17 as lineage_new, @colv17 as colv union all
    select @rowguid18 as rowguid, @generation18 as generation, @lineage_new18 as lineage_new, @colv18 as colv union all
    select @rowguid19 as rowguid, @generation19 as generation, @lineage_new19 as lineage_new, @colv19 as colv union all
    select @rowguid20 as rowguid, @generation20 as generation, @lineage_new20 as lineage_new, @colv20 as colv union all
    select @rowguid21 as rowguid, @generation21 as generation, @lineage_new21 as lineage_new, @colv21 as colv union all
    select @rowguid22 as rowguid, @generation22 as generation, @lineage_new22 as lineage_new, @colv22 as colv union all
    select @rowguid23 as rowguid, @generation23 as generation, @lineage_new23 as lineage_new, @colv23 as colv union all
    select @rowguid24 as rowguid, @generation24 as generation, @lineage_new24 as lineage_new, @colv24 as colv union all
    select @rowguid25 as rowguid, @generation25 as generation, @lineage_new25 as lineage_new, @colv25 as colv union all
    select @rowguid26 as rowguid, @generation26 as generation, @lineage_new26 as lineage_new, @colv26 as colv union all
    select @rowguid27 as rowguid, @generation27 as generation, @lineage_new27 as lineage_new, @colv27 as colv union all
    select @rowguid28 as rowguid, @generation28 as generation, @lineage_new28 as lineage_new, @colv28 as colv union all
    select @rowguid29 as rowguid, @generation29 as generation, @lineage_new29 as lineage_new, @colv29 as colv union all
    select @rowguid30 as rowguid, @generation30 as generation, @lineage_new30 as lineage_new, @colv30 as colv union all
    select @rowguid31 as rowguid, @generation31 as generation, @lineage_new31 as lineage_new, @colv31 as colv union all
    select @rowguid32 as rowguid, @generation32 as generation, @lineage_new32 as lineage_new, @colv32 as colv
 union all
    select @rowguid33 as rowguid, @generation33 as generation, @lineage_new33 as lineage_new, @colv33 as colv union all
    select @rowguid34 as rowguid, @generation34 as generation, @lineage_new34 as lineage_new, @colv34 as colv union all
    select @rowguid35 as rowguid, @generation35 as generation, @lineage_new35 as lineage_new, @colv35 as colv union all
    select @rowguid36 as rowguid, @generation36 as generation, @lineage_new36 as lineage_new, @colv36 as colv union all
    select @rowguid37 as rowguid, @generation37 as generation, @lineage_new37 as lineage_new, @colv37 as colv union all
    select @rowguid38 as rowguid, @generation38 as generation, @lineage_new38 as lineage_new, @colv38 as colv union all
    select @rowguid39 as rowguid, @generation39 as generation, @lineage_new39 as lineage_new, @colv39 as colv union all
    select @rowguid40 as rowguid, @generation40 as generation, @lineage_new40 as lineage_new, @colv40 as colv union all
    select @rowguid41 as rowguid, @generation41 as generation, @lineage_new41 as lineage_new, @colv41 as colv union all
    select @rowguid42 as rowguid, @generation42 as generation, @lineage_new42 as lineage_new, @colv42 as colv union all
    select @rowguid43 as rowguid, @generation43 as generation, @lineage_new43 as lineage_new, @colv43 as colv union all
    select @rowguid44 as rowguid, @generation44 as generation, @lineage_new44 as lineage_new, @colv44 as colv union all
    select @rowguid45 as rowguid, @generation45 as generation, @lineage_new45 as lineage_new, @colv45 as colv union all
    select @rowguid46 as rowguid, @generation46 as generation, @lineage_new46 as lineage_new, @colv46 as colv union all
    select @rowguid47 as rowguid, @generation47 as generation, @lineage_new47 as lineage_new, @colv47 as colv union all
    select @rowguid48 as rowguid, @generation48 as generation, @lineage_new48 as lineage_new, @colv48 as colv union all
    select @rowguid49 as rowguid, @generation49 as generation, @lineage_new49 as lineage_new, @colv49 as colv union all
    select @rowguid50 as rowguid, @generation50 as generation, @lineage_new50 as lineage_new, @colv50 as colv union all
    select @rowguid51 as rowguid, @generation51 as generation, @lineage_new51 as lineage_new, @colv51 as colv union all
    select @rowguid52 as rowguid, @generation52 as generation, @lineage_new52 as lineage_new, @colv52 as colv union all
    select @rowguid53 as rowguid, @generation53 as generation, @lineage_new53 as lineage_new, @colv53 as colv union all
    select @rowguid54 as rowguid, @generation54 as generation, @lineage_new54 as lineage_new, @colv54 as colv union all
    select @rowguid55 as rowguid, @generation55 as generation, @lineage_new55 as lineage_new, @colv55 as colv union all
    select @rowguid56 as rowguid, @generation56 as generation, @lineage_new56 as lineage_new, @colv56 as colv union all
    select @rowguid57 as rowguid, @generation57 as generation, @lineage_new57 as lineage_new, @colv57 as colv union all
    select @rowguid58 as rowguid, @generation58 as generation, @lineage_new58 as lineage_new, @colv58 as colv union all
    select @rowguid59 as rowguid, @generation59 as generation, @lineage_new59 as lineage_new, @colv59 as colv union all
    select @rowguid60 as rowguid, @generation60 as generation, @lineage_new60 as lineage_new, @colv60 as colv union all
    select @rowguid61 as rowguid, @generation61 as generation, @lineage_new61 as lineage_new, @colv61 as colv union all
    select @rowguid62 as rowguid, @generation62 as generation, @lineage_new62 as lineage_new, @colv62 as colv union all
    select @rowguid63 as rowguid, @generation63 as generation, @lineage_new63 as lineage_new, @colv63 as colv
 union all
    select @rowguid64 as rowguid, @generation64 as generation, @lineage_new64 as lineage_new, @colv64 as colv union all
    select @rowguid65 as rowguid, @generation65 as generation, @lineage_new65 as lineage_new, @colv65 as colv union all
    select @rowguid66 as rowguid, @generation66 as generation, @lineage_new66 as lineage_new, @colv66 as colv union all
    select @rowguid67 as rowguid, @generation67 as generation, @lineage_new67 as lineage_new, @colv67 as colv union all
    select @rowguid68 as rowguid, @generation68 as generation, @lineage_new68 as lineage_new, @colv68 as colv union all
    select @rowguid69 as rowguid, @generation69 as generation, @lineage_new69 as lineage_new, @colv69 as colv union all
    select @rowguid70 as rowguid, @generation70 as generation, @lineage_new70 as lineage_new, @colv70 as colv union all
    select @rowguid71 as rowguid, @generation71 as generation, @lineage_new71 as lineage_new, @colv71 as colv union all
    select @rowguid72 as rowguid, @generation72 as generation, @lineage_new72 as lineage_new, @colv72 as colv union all
    select @rowguid73 as rowguid, @generation73 as generation, @lineage_new73 as lineage_new, @colv73 as colv union all
    select @rowguid74 as rowguid, @generation74 as generation, @lineage_new74 as lineage_new, @colv74 as colv union all
    select @rowguid75 as rowguid, @generation75 as generation, @lineage_new75 as lineage_new, @colv75 as colv union all
    select @rowguid76 as rowguid, @generation76 as generation, @lineage_new76 as lineage_new, @colv76 as colv union all
    select @rowguid77 as rowguid, @generation77 as generation, @lineage_new77 as lineage_new, @colv77 as colv union all
    select @rowguid78 as rowguid, @generation78 as generation, @lineage_new78 as lineage_new, @colv78 as colv

    ) as rows
    inner join dbo.MSmerge_contents cont with (rowlock) 
    on cont.rowguid = rows.rowguid and cont.tablenick = 31081000
    and rows.rowguid is not NULL 
    and rows.lineage_new is not NULL
    option (force order, loop join)
    select @cont_rows_updated = @@rowcount, @error = @@error
    if @error<>0
    begin
        set @errcode= 3
        goto Failure
    end

    if @cont_rows_updated <> @rows_tobe_updated
    begin

        insert into dbo.MSmerge_contents with (rowlock)
        (tablenick, rowguid, lineage, colv1, generation)
        select 31081000, rows.rowguid, rows.lineage_new, rows.colv, rows.generation
        from (

    select @rowguid1 as rowguid, @generation1 as generation, @lineage_new1 as lineage_new, @colv1 as colv union all
    select @rowguid2 as rowguid, @generation2 as generation, @lineage_new2 as lineage_new, @colv2 as colv union all
    select @rowguid3 as rowguid, @generation3 as generation, @lineage_new3 as lineage_new, @colv3 as colv union all
    select @rowguid4 as rowguid, @generation4 as generation, @lineage_new4 as lineage_new, @colv4 as colv union all
    select @rowguid5 as rowguid, @generation5 as generation, @lineage_new5 as lineage_new, @colv5 as colv union all
    select @rowguid6 as rowguid, @generation6 as generation, @lineage_new6 as lineage_new, @colv6 as colv union all
    select @rowguid7 as rowguid, @generation7 as generation, @lineage_new7 as lineage_new, @colv7 as colv union all
    select @rowguid8 as rowguid, @generation8 as generation, @lineage_new8 as lineage_new, @colv8 as colv union all
    select @rowguid9 as rowguid, @generation9 as generation, @lineage_new9 as lineage_new, @colv9 as colv union all
    select @rowguid10 as rowguid, @generation10 as generation, @lineage_new10 as lineage_new, @colv10 as colv union all
    select @rowguid11 as rowguid, @generation11 as generation, @lineage_new11 as lineage_new, @colv11 as colv union all
    select @rowguid12 as rowguid, @generation12 as generation, @lineage_new12 as lineage_new, @colv12 as colv union all
    select @rowguid13 as rowguid, @generation13 as generation, @lineage_new13 as lineage_new, @colv13 as colv union all
    select @rowguid14 as rowguid, @generation14 as generation, @lineage_new14 as lineage_new, @colv14 as colv union all
    select @rowguid15 as rowguid, @generation15 as generation, @lineage_new15 as lineage_new, @colv15 as colv union all
    select @rowguid16 as rowguid, @generation16 as generation, @lineage_new16 as lineage_new, @colv16 as colv union all
    select @rowguid17 as rowguid, @generation17 as generation, @lineage_new17 as lineage_new, @colv17 as colv union all
    select @rowguid18 as rowguid, @generation18 as generation, @lineage_new18 as lineage_new, @colv18 as colv union all
    select @rowguid19 as rowguid, @generation19 as generation, @lineage_new19 as lineage_new, @colv19 as colv union all
    select @rowguid20 as rowguid, @generation20 as generation, @lineage_new20 as lineage_new, @colv20 as colv union all
    select @rowguid21 as rowguid, @generation21 as generation, @lineage_new21 as lineage_new, @colv21 as colv union all
    select @rowguid22 as rowguid, @generation22 as generation, @lineage_new22 as lineage_new, @colv22 as colv union all
    select @rowguid23 as rowguid, @generation23 as generation, @lineage_new23 as lineage_new, @colv23 as colv union all
    select @rowguid24 as rowguid, @generation24 as generation, @lineage_new24 as lineage_new, @colv24 as colv union all
    select @rowguid25 as rowguid, @generation25 as generation, @lineage_new25 as lineage_new, @colv25 as colv union all
    select @rowguid26 as rowguid, @generation26 as generation, @lineage_new26 as lineage_new, @colv26 as colv union all
    select @rowguid27 as rowguid, @generation27 as generation, @lineage_new27 as lineage_new, @colv27 as colv union all
    select @rowguid28 as rowguid, @generation28 as generation, @lineage_new28 as lineage_new, @colv28 as colv union all
    select @rowguid29 as rowguid, @generation29 as generation, @lineage_new29 as lineage_new, @colv29 as colv union all
    select @rowguid30 as rowguid, @generation30 as generation, @lineage_new30 as lineage_new, @colv30 as colv union all
    select @rowguid31 as rowguid, @generation31 as generation, @lineage_new31 as lineage_new, @colv31 as colv union all
    select @rowguid32 as rowguid, @generation32 as generation, @lineage_new32 as lineage_new, @colv32 as colv
 union all
    select @rowguid33 as rowguid, @generation33 as generation, @lineage_new33 as lineage_new, @colv33 as colv union all
    select @rowguid34 as rowguid, @generation34 as generation, @lineage_new34 as lineage_new, @colv34 as colv union all
    select @rowguid35 as rowguid, @generation35 as generation, @lineage_new35 as lineage_new, @colv35 as colv union all
    select @rowguid36 as rowguid, @generation36 as generation, @lineage_new36 as lineage_new, @colv36 as colv union all
    select @rowguid37 as rowguid, @generation37 as generation, @lineage_new37 as lineage_new, @colv37 as colv union all
    select @rowguid38 as rowguid, @generation38 as generation, @lineage_new38 as lineage_new, @colv38 as colv union all
    select @rowguid39 as rowguid, @generation39 as generation, @lineage_new39 as lineage_new, @colv39 as colv union all
    select @rowguid40 as rowguid, @generation40 as generation, @lineage_new40 as lineage_new, @colv40 as colv union all
    select @rowguid41 as rowguid, @generation41 as generation, @lineage_new41 as lineage_new, @colv41 as colv union all
    select @rowguid42 as rowguid, @generation42 as generation, @lineage_new42 as lineage_new, @colv42 as colv union all
    select @rowguid43 as rowguid, @generation43 as generation, @lineage_new43 as lineage_new, @colv43 as colv union all
    select @rowguid44 as rowguid, @generation44 as generation, @lineage_new44 as lineage_new, @colv44 as colv union all
    select @rowguid45 as rowguid, @generation45 as generation, @lineage_new45 as lineage_new, @colv45 as colv union all
    select @rowguid46 as rowguid, @generation46 as generation, @lineage_new46 as lineage_new, @colv46 as colv union all
    select @rowguid47 as rowguid, @generation47 as generation, @lineage_new47 as lineage_new, @colv47 as colv union all
    select @rowguid48 as rowguid, @generation48 as generation, @lineage_new48 as lineage_new, @colv48 as colv union all
    select @rowguid49 as rowguid, @generation49 as generation, @lineage_new49 as lineage_new, @colv49 as colv union all
    select @rowguid50 as rowguid, @generation50 as generation, @lineage_new50 as lineage_new, @colv50 as colv union all
    select @rowguid51 as rowguid, @generation51 as generation, @lineage_new51 as lineage_new, @colv51 as colv union all
    select @rowguid52 as rowguid, @generation52 as generation, @lineage_new52 as lineage_new, @colv52 as colv union all
    select @rowguid53 as rowguid, @generation53 as generation, @lineage_new53 as lineage_new, @colv53 as colv union all
    select @rowguid54 as rowguid, @generation54 as generation, @lineage_new54 as lineage_new, @colv54 as colv union all
    select @rowguid55 as rowguid, @generation55 as generation, @lineage_new55 as lineage_new, @colv55 as colv union all
    select @rowguid56 as rowguid, @generation56 as generation, @lineage_new56 as lineage_new, @colv56 as colv union all
    select @rowguid57 as rowguid, @generation57 as generation, @lineage_new57 as lineage_new, @colv57 as colv union all
    select @rowguid58 as rowguid, @generation58 as generation, @lineage_new58 as lineage_new, @colv58 as colv union all
    select @rowguid59 as rowguid, @generation59 as generation, @lineage_new59 as lineage_new, @colv59 as colv union all
    select @rowguid60 as rowguid, @generation60 as generation, @lineage_new60 as lineage_new, @colv60 as colv union all
    select @rowguid61 as rowguid, @generation61 as generation, @lineage_new61 as lineage_new, @colv61 as colv union all
    select @rowguid62 as rowguid, @generation62 as generation, @lineage_new62 as lineage_new, @colv62 as colv union all
    select @rowguid63 as rowguid, @generation63 as generation, @lineage_new63 as lineage_new, @colv63 as colv
 union all
    select @rowguid64 as rowguid, @generation64 as generation, @lineage_new64 as lineage_new, @colv64 as colv union all
    select @rowguid65 as rowguid, @generation65 as generation, @lineage_new65 as lineage_new, @colv65 as colv union all
    select @rowguid66 as rowguid, @generation66 as generation, @lineage_new66 as lineage_new, @colv66 as colv union all
    select @rowguid67 as rowguid, @generation67 as generation, @lineage_new67 as lineage_new, @colv67 as colv union all
    select @rowguid68 as rowguid, @generation68 as generation, @lineage_new68 as lineage_new, @colv68 as colv union all
    select @rowguid69 as rowguid, @generation69 as generation, @lineage_new69 as lineage_new, @colv69 as colv union all
    select @rowguid70 as rowguid, @generation70 as generation, @lineage_new70 as lineage_new, @colv70 as colv union all
    select @rowguid71 as rowguid, @generation71 as generation, @lineage_new71 as lineage_new, @colv71 as colv union all
    select @rowguid72 as rowguid, @generation72 as generation, @lineage_new72 as lineage_new, @colv72 as colv union all
    select @rowguid73 as rowguid, @generation73 as generation, @lineage_new73 as lineage_new, @colv73 as colv union all
    select @rowguid74 as rowguid, @generation74 as generation, @lineage_new74 as lineage_new, @colv74 as colv union all
    select @rowguid75 as rowguid, @generation75 as generation, @lineage_new75 as lineage_new, @colv75 as colv union all
    select @rowguid76 as rowguid, @generation76 as generation, @lineage_new76 as lineage_new, @colv76 as colv union all
    select @rowguid77 as rowguid, @generation77 as generation, @lineage_new77 as lineage_new, @colv77 as colv union all
    select @rowguid78 as rowguid, @generation78 as generation, @lineage_new78 as lineage_new, @colv78 as colv

        ) as rows
        left outer join dbo.MSmerge_contents cont with (rowlock) 
        on cont.rowguid = rows.rowguid and cont.tablenick = 31081000
        and rows.rowguid is not NULL
        and rows.lineage_new is not NULL
        where cont.rowguid is NULL
        and rows.rowguid is not NULL
        and rows.lineage_new is not NULL
        
        if @@error<>0
        begin
            set @errcode= 3
            goto Failure
        end
    end

    exec @retcode = sys.sp_MSdeletemetadataactionrequest '8D8B572F-B352-4CD3-9BF9-08911C828501', 31081000, 
        @rowguid1, 
        @rowguid2, 
        @rowguid3, 
        @rowguid4, 
        @rowguid5, 
        @rowguid6, 
        @rowguid7, 
        @rowguid8, 
        @rowguid9, 
        @rowguid10, 
        @rowguid11, 
        @rowguid12, 
        @rowguid13, 
        @rowguid14, 
        @rowguid15, 
        @rowguid16, 
        @rowguid17, 
        @rowguid18, 
        @rowguid19, 
        @rowguid20, 
        @rowguid21, 
        @rowguid22, 
        @rowguid23, 
        @rowguid24, 
        @rowguid25, 
        @rowguid26, 
        @rowguid27, 
        @rowguid28, 
        @rowguid29, 
        @rowguid30, 
        @rowguid31, 
        @rowguid32, 
        @rowguid33, 
        @rowguid34, 
        @rowguid35, 
        @rowguid36, 
        @rowguid37, 
        @rowguid38, 
        @rowguid39, 
        @rowguid40, 
        @rowguid41, 
        @rowguid42, 
        @rowguid43, 
        @rowguid44, 
        @rowguid45, 
        @rowguid46, 
        @rowguid47, 
        @rowguid48, 
        @rowguid49, 
        @rowguid50, 
        @rowguid51, 
        @rowguid52, 
        @rowguid53, 
        @rowguid54, 
        @rowguid55, 
        @rowguid56, 
        @rowguid57, 
        @rowguid58, 
        @rowguid59, 
        @rowguid60, 
        @rowguid61, 
        @rowguid62, 
        @rowguid63, 
        @rowguid64, 
        @rowguid65, 
        @rowguid66, 
        @rowguid67, 
        @rowguid68, 
        @rowguid69, 
        @rowguid70, 
        @rowguid71, 
        @rowguid72, 
        @rowguid73, 
        @rowguid74, 
        @rowguid75, 
        @rowguid76, 
        @rowguid77, 
        @rowguid78
    if @retcode<>0 or @@error<>0
        goto Failure
    

    commit tran
    return 1

Failure:
    rollback tran batchupdateproc
    commit tran
    return 0
end


go

update dbo.sysmergepartitioninfo 
    set column_list = N't.*', 
        column_list_blob = N't.*'
    where artid = 'BB5C29C4-2300-434E-AC2A-A98F754BF494' and pubid = '8D8B572F-B352-4CD3-9BF9-08911C828501'

go
SET ANSI_NULLS ON SET QUOTED_IDENTIFIER ON

go

    create procedure dbo.[MSmerge_sel_sp_BB5C29C42300434E8D8B572FB3524CD3] (
        @maxschemaguidforarticle uniqueidentifier,
        @type int output, 
        @rowguid uniqueidentifier=NULL,
        @enumentirerowmetadata bit= 1,
        @blob_cols_at_the_end bit=0,
        @logical_record_parent_rowguid uniqueidentifier = '00000000-0000-0000-0000-000000000000',
        @metadata_type tinyint = 0,
        @lineage_old varbinary(311) = NULL,
        @rowcount int = NULL output
        ) 
    as
    begin
        declare @retcode    int
        
        set nocount on
            
        if ({ fn ISPALUSER('8D8B572F-B352-4CD3-9BF9-08911C828501') } <> 1)
        begin       
            RAISERROR (14126, 11, -1)
            return (1)
        end 

    if @type = 1
        begin
            select 
t.*
          from [dbo].[HOCPHI] t where rowguidcol = @rowguid
        if @@ERROR<>0 return(1)
    end 
    else if @type < 4 
        begin
            -- case one: no blob gen optimization
            if @blob_cols_at_the_end=0
            begin
                select 
                c.tablenick, 
                c.rowguid, 
                c.generation,
                case @enumentirerowmetadata
                    when 0 then null
                    else c.lineage
                end as lineage,
                case @enumentirerowmetadata
                    when 0 then null
                    else c.colv1
                end as colv1,
                
t.*

                from #cont c , [dbo].[HOCPHI] t with (rowlock)
                where t.rowguidcol = c.rowguid
                order by t.rowguidcol 
                
            if @@ERROR<>0 return(1)
            end
  
            -- case two: blob gen optimization
            else 
            begin
                select 
                c.tablenick, 
                c.rowguid, 
                c.generation,
                case @enumentirerowmetadata
                    when 0 then null
                    else c.lineage
                end as lineage,
                case @enumentirerowmetadata
                    when 0 then null
                    else c.colv1
                end as colv1,
t.*

                from #cont c,[dbo].[HOCPHI] t with (rowlock)
              where t.rowguidcol = c.rowguid
                 order by t.rowguidcol 
                 
            if @@ERROR<>0 return(1)
            end
        end
   else if @type = 4
    begin
        set @type = 0
        if exists (select * from [dbo].[HOCPHI] where rowguidcol = @rowguid)
            set @type = 3
        if @@ERROR<>0 return(1)
    end

    else if @type = 5
    begin
         
        delete [dbo].[HOCPHI] where rowguidcol = @rowguid
        if @@ERROR<>0 return(1)

        delete from dbo.MSmerge_metadataaction_request
            where tablenick=31081000 and rowguid=@rowguid
    end 

    else if @type = 6 -- sp_MSenumcolumns
    begin
        select 
t.*
         from [dbo].[HOCPHI] t where 1=2
        if @@ERROR<>0 return(1)
    end

    else if @type = 7 -- sp_MSlocktable
    begin
        select 1 from [dbo].[HOCPHI] with (tablock holdlock) where 1 = 2
        if @@ERROR<>0 return(1)
    end

    else if @type = 8 -- put update lock
    begin
        if not exists (select * from [dbo].[HOCPHI] with (UPDLOCK HOLDLOCK) where rowguidcol = @rowguid)
        begin
            RAISERROR(20031 , 16, -1)
            return(1)
        end
    end
    else if @type = 9
    begin
        declare @oldmaxversion int, @replnick binary(6)
                , @cur_article_rowcount int, @column_tracking int
                        
        select @replnick = 0x548eea202917

        select top 1 @oldmaxversion = maxversion_at_cleanup,
                     @column_tracking = column_tracking
        from dbo.sysmergearticles 
        where nickname = 31081000
        
        select @cur_article_rowcount = count(*) from #rows 
        where tablenick = 31081000
            
        update dbo.MSmerge_contents 
        set lineage = { fn UPDATELINEAGE(lineage, @replnick, @oldmaxversion+1) }
        where tablenick = 31081000
        and rowguid in (select rowguid from #rows where tablenick = 31081000) 

        if @@rowcount <> @cur_article_rowcount
        begin
            declare @lineage varbinary(311), @colv1 varbinary(1)
                    , @cur_rowguid uniqueidentifier, @prev_rowguid uniqueidentifier
            set @lineage = { fn UPDATELINEAGE(0x0, @replnick, @oldmaxversion+1) }
            if @column_tracking <> 0
                set @colv1 = 0xFF
            else
                set @colv1 = NULL
                
            select top 1 @cur_rowguid = rowguid from #rows
            where tablenick = 31081000
            order by rowguid
            
            while @cur_rowguid is not null
            begin
                if not exists (select * from dbo.MSmerge_contents 
                                where tablenick = 31081000
                                and rowguid = @cur_rowguid)
                begin
                    begin tran 
                    save tran insert_contents_row 

                    if exists (select * from [dbo].[HOCPHI]with (holdlock) where rowguidcol = @cur_rowguid)
                    begin
                        exec @retcode = sys.sp_MSevaluate_change_membership_for_row @tablenick = 31081000, @rowguid = @cur_rowguid
                        if @retcode <> 0 or @@error <> 0
                        begin
                            rollback tran insert_contents_row
                            return 1
                        end
                        insert into dbo.MSmerge_contents (rowguid, tablenick, generation, lineage, colv1, logical_record_parent_rowguid)
                            values (@cur_rowguid, 31081000, 0, @lineage, @colv1, @logical_record_parent_rowguid)
                    end
                    commit tran
                end
                
                select @prev_rowguid = @cur_rowguid
                select @cur_rowguid = NULL
                
                select top 1 @cur_rowguid = rowguid from #rows
                where tablenick = 31081000
                and rowguid > @prev_rowguid
                order by rowguid
            end
        end 

        select 
            r.tablenick, 
            r.rowguid, 
            mc.generation,
            case @enumentirerowmetadata
                when 0 then null
                else mc.lineage
            end,
            case @enumentirerowmetadata
                when 0 then null
                else mc.colv1
            end,
            
t.*
         from #rows r left outer join [dbo].[HOCPHI] t on r.rowguid = t.rowguidcol and r.tablenick = 31081000
                 left outer join dbo.MSmerge_contents mc on
                 mc.tablenick = 31081000 and mc.rowguid = t.rowguidcol
                 where r.tablenick = 31081000
         order by r.idx
         
        if @@ERROR<>0 return(1)
    end 

        else if @type = 10  
        begin
            select 
                c.tablenick, 
                c.rowguid, 
                c.generation,
                case @enumentirerowmetadata
                    when 0 then null
                    else c.lineage
                end,
                case @enumentirerowmetadata
                    when 0 then null
                    else c.colv1
                end,
                null,
                
t.*
         from #cont c,[dbo].[HOCPHI] t with (rowlock) where
                      t.rowguidcol = c.rowguid
             order by t.rowguidcol 
                        
            if @@ERROR<>0 return(1)
        end

    else if @type = 11
    begin
         
        -- we will do a delete with metadata match
        if @metadata_type = 0
        begin
            delete from [dbo].[HOCPHI] where [rowguid] = @rowguid
            select @rowcount = @@rowcount
            if @rowcount <> 1
            begin
                RAISERROR(20031 , 16, -1)
                return(1)
            end
        end
        else
        begin
            if @metadata_type = 3
                delete [dbo].[HOCPHI] from [dbo].[HOCPHI] t
                    where t.[rowguid] = @rowguid and 
                        not exists (select 1 from dbo.MSmerge_contents c with (rowlock) where
                                                c.rowguid = @rowguid and
                                                c.tablenick = 31081000)
            else if @metadata_type = 5 or @metadata_type = 6
                delete [dbo].[HOCPHI] from [dbo].[HOCPHI] t
                    where t.[rowguid] = @rowguid and 
                         not exists (select 1 from dbo.MSmerge_contents c with (rowlock) where
                                                c.rowguid = @rowguid and
                                                c.tablenick = 31081000 and
                                                c.lineage <> @lineage_old)
                                                
            else
                delete [dbo].[HOCPHI] from [dbo].[HOCPHI] t
                    where t.[rowguid] = @rowguid and 
                         exists (select 1 from dbo.MSmerge_contents c with (rowlock) where
                                                c.rowguid = @rowguid and
                                                c.tablenick = 31081000 and
                                                c.lineage = @lineage_old)
            select @rowcount = @@rowcount
            if @rowcount <> 1 
            begin
                if not exists (select * from [dbo].[HOCPHI] where [rowguid] = @rowguid)
                begin
                    RAISERROR(20031 , 16, -1)
                    return(1)
                end
            end
        end
        if @@ERROR<>0 
        begin
            delete from dbo.MSmerge_metadataaction_request
                where tablenick=31081000 and rowguid=@rowguid

            return(1)
        end        
    end

    else if @type = 12
    begin 
        -- this type indicates metadata type selection
        declare @maxversion int
        declare @error int
        
        select @maxversion= maxversion_at_cleanup from dbo.sysmergearticles 
            where nickname = 31081000 and pubid = '8D8B572F-B352-4CD3-9BF9-08911C828501'
        if @error <> 0 
            return 1
        select case when (cont.generation is NULL and tomb.generation is null) 
                    then 0 
                    else isnull(cont.generation, tomb.generation) 
               end as generation, 
               case when t.[rowguid] is null 
                    then (case when tomb.rowguid is NULL then 0 else tomb.type end) 
                    else (case when cont.rowguid is null then 3 else 2 end) 
               end as type,
               case when tomb.rowguid is null 
                    then cont.lineage 
                    else tomb.lineage
               end as lineage, 
               cont.colv1 as colv, 
               @maxversion as maxversion
        from
        (select @rowguid as rowguid) as rows 
        left outer join [dbo].[HOCPHI] t with (rowlock) 
        on t.[rowguid] = rows.rowguid
        and rows.rowguid is not null
        left outer join dbo.MSmerge_contents cont with (rowlock) 
        on cont.rowguid = rows.rowguid and cont.tablenick = 31081000
        left outer join dbo.MSmerge_tombstone tomb with (rowlock) 
        on tomb.rowguid = rows.rowguid and tomb.tablenick = 31081000
        where rows.rowguid is not null
        
        select @error = @@error
        if @error <> 0 
        begin
            --raiserror(@error, 16, -1)
            return 1
        end
    end

    return(0)
end


go

create procedure dbo.[MSmerge_sel_sp_BB5C29C42300434E8D8B572FB3524CD3_metadata]
( 
    @rowguid1 uniqueidentifier,
    @rowguid2 uniqueidentifier = NULL,
    @rowguid3 uniqueidentifier = NULL,
    @rowguid4 uniqueidentifier = NULL,
    @rowguid5 uniqueidentifier = NULL,
    @rowguid6 uniqueidentifier = NULL,
    @rowguid7 uniqueidentifier = NULL,
    @rowguid8 uniqueidentifier = NULL,
    @rowguid9 uniqueidentifier = NULL,
    @rowguid10 uniqueidentifier = NULL,
    @rowguid11 uniqueidentifier = NULL,
    @rowguid12 uniqueidentifier = NULL,
    @rowguid13 uniqueidentifier = NULL,
    @rowguid14 uniqueidentifier = NULL,
    @rowguid15 uniqueidentifier = NULL,
    @rowguid16 uniqueidentifier = NULL,
    @rowguid17 uniqueidentifier = NULL,
    @rowguid18 uniqueidentifier = NULL,
    @rowguid19 uniqueidentifier = NULL,
    @rowguid20 uniqueidentifier = NULL,
    @rowguid21 uniqueidentifier = NULL,
    @rowguid22 uniqueidentifier = NULL,
    @rowguid23 uniqueidentifier = NULL,
    @rowguid24 uniqueidentifier = NULL,
    @rowguid25 uniqueidentifier = NULL,
    @rowguid26 uniqueidentifier = NULL,
    @rowguid27 uniqueidentifier = NULL,
    @rowguid28 uniqueidentifier = NULL,
    @rowguid29 uniqueidentifier = NULL,
    @rowguid30 uniqueidentifier = NULL,
    @rowguid31 uniqueidentifier = NULL,
    @rowguid32 uniqueidentifier = NULL,
    @rowguid33 uniqueidentifier = NULL,
    @rowguid34 uniqueidentifier = NULL,
    @rowguid35 uniqueidentifier = NULL,
    @rowguid36 uniqueidentifier = NULL,
    @rowguid37 uniqueidentifier = NULL,
    @rowguid38 uniqueidentifier = NULL,
    @rowguid39 uniqueidentifier = NULL,
    @rowguid40 uniqueidentifier = NULL,
    @rowguid41 uniqueidentifier = NULL,
    @rowguid42 uniqueidentifier = NULL,
    @rowguid43 uniqueidentifier = NULL,
    @rowguid44 uniqueidentifier = NULL,
    @rowguid45 uniqueidentifier = NULL,
    @rowguid46 uniqueidentifier = NULL,
    @rowguid47 uniqueidentifier = NULL,
    @rowguid48 uniqueidentifier = NULL,
    @rowguid49 uniqueidentifier = NULL,
    @rowguid50 uniqueidentifier = NULL,

    @rowguid51 uniqueidentifier = NULL,
    @rowguid52 uniqueidentifier = NULL,
    @rowguid53 uniqueidentifier = NULL,
    @rowguid54 uniqueidentifier = NULL,
    @rowguid55 uniqueidentifier = NULL,
    @rowguid56 uniqueidentifier = NULL,
    @rowguid57 uniqueidentifier = NULL,
    @rowguid58 uniqueidentifier = NULL,
    @rowguid59 uniqueidentifier = NULL,
    @rowguid60 uniqueidentifier = NULL,
    @rowguid61 uniqueidentifier = NULL,
    @rowguid62 uniqueidentifier = NULL,
    @rowguid63 uniqueidentifier = NULL,
    @rowguid64 uniqueidentifier = NULL,
    @rowguid65 uniqueidentifier = NULL,
    @rowguid66 uniqueidentifier = NULL,
    @rowguid67 uniqueidentifier = NULL,
    @rowguid68 uniqueidentifier = NULL,
    @rowguid69 uniqueidentifier = NULL,
    @rowguid70 uniqueidentifier = NULL,
    @rowguid71 uniqueidentifier = NULL,
    @rowguid72 uniqueidentifier = NULL,
    @rowguid73 uniqueidentifier = NULL,
    @rowguid74 uniqueidentifier = NULL,
    @rowguid75 uniqueidentifier = NULL,
    @rowguid76 uniqueidentifier = NULL,
    @rowguid77 uniqueidentifier = NULL,
    @rowguid78 uniqueidentifier = NULL,
    @rowguid79 uniqueidentifier = NULL,
    @rowguid80 uniqueidentifier = NULL,
    @rowguid81 uniqueidentifier = NULL,
    @rowguid82 uniqueidentifier = NULL,
    @rowguid83 uniqueidentifier = NULL,
    @rowguid84 uniqueidentifier = NULL,
    @rowguid85 uniqueidentifier = NULL,
    @rowguid86 uniqueidentifier = NULL,
    @rowguid87 uniqueidentifier = NULL,
    @rowguid88 uniqueidentifier = NULL,
    @rowguid89 uniqueidentifier = NULL,
    @rowguid90 uniqueidentifier = NULL,
    @rowguid91 uniqueidentifier = NULL,
    @rowguid92 uniqueidentifier = NULL,
    @rowguid93 uniqueidentifier = NULL,
    @rowguid94 uniqueidentifier = NULL,
    @rowguid95 uniqueidentifier = NULL,
    @rowguid96 uniqueidentifier = NULL,
    @rowguid97 uniqueidentifier = NULL,
    @rowguid98 uniqueidentifier = NULL,
    @rowguid99 uniqueidentifier = NULL,
    @rowguid100 uniqueidentifier = NULL
) 

as
begin
    declare @retcode    int
    declare @maxversion int
    set nocount on
        
    if ({ fn ISPALUSER('8D8B572F-B352-4CD3-9BF9-08911C828501') } <> 1)
    begin       
        RAISERROR (14126, 11, -1)
        return (1)
    end
    
    select @maxversion= maxversion_at_cleanup from dbo.sysmergearticles 
        where nickname = 31081000 and pubid = '8D8B572F-B352-4CD3-9BF9-08911C828501'


        select case when (cont.generation is NULL and tomb.generation is null) then 0 else isnull(cont.generation, tomb.generation) end as generation, 
               case when t.[rowguid] is null then (case when tomb.rowguid is NULL then 0 else tomb.type end) else (case when cont.rowguid is null then 3 else 2 end) end as type,
               case when tomb.rowguid is null then cont.lineage else tomb.lineage end as lineage,  
               cont.colv1 as colv,
               @maxversion as maxversion,
               rows.rowguid as rowguid
    

        from
        ( 
        select @rowguid1 as rowguid, 1 as sortcol union all
        select @rowguid2 as rowguid, 2 as sortcol union all
        select @rowguid3 as rowguid, 3 as sortcol union all
        select @rowguid4 as rowguid, 4 as sortcol union all
        select @rowguid5 as rowguid, 5 as sortcol union all
        select @rowguid6 as rowguid, 6 as sortcol union all
        select @rowguid7 as rowguid, 7 as sortcol union all
        select @rowguid8 as rowguid, 8 as sortcol union all
        select @rowguid9 as rowguid, 9 as sortcol union all
        select @rowguid10 as rowguid, 10 as sortcol union all
        select @rowguid11 as rowguid, 11 as sortcol union all
        select @rowguid12 as rowguid, 12 as sortcol union all
        select @rowguid13 as rowguid, 13 as sortcol union all
        select @rowguid14 as rowguid, 14 as sortcol union all
        select @rowguid15 as rowguid, 15 as sortcol union all
        select @rowguid16 as rowguid, 16 as sortcol union all
        select @rowguid17 as rowguid, 17 as sortcol union all
        select @rowguid18 as rowguid, 18 as sortcol union all
        select @rowguid19 as rowguid, 19 as sortcol union all
        select @rowguid20 as rowguid, 20 as sortcol union all
        select @rowguid21 as rowguid, 21 as sortcol union all
        select @rowguid22 as rowguid, 22 as sortcol union all
        select @rowguid23 as rowguid, 23 as sortcol union all
        select @rowguid24 as rowguid, 24 as sortcol union all
        select @rowguid25 as rowguid, 25 as sortcol union all
        select @rowguid26 as rowguid, 26 as sortcol union all
        select @rowguid27 as rowguid, 27 as sortcol union all
        select @rowguid28 as rowguid, 28 as sortcol union all
        select @rowguid29 as rowguid, 29 as sortcol union all
        select @rowguid30 as rowguid, 30 as sortcol union all
        select @rowguid31 as rowguid, 31 as sortcol union all

        select @rowguid32 as rowguid, 32 as sortcol union all
        select @rowguid33 as rowguid, 33 as sortcol union all
        select @rowguid34 as rowguid, 34 as sortcol union all
        select @rowguid35 as rowguid, 35 as sortcol union all
        select @rowguid36 as rowguid, 36 as sortcol union all
        select @rowguid37 as rowguid, 37 as sortcol union all
        select @rowguid38 as rowguid, 38 as sortcol union all
        select @rowguid39 as rowguid, 39 as sortcol union all
        select @rowguid40 as rowguid, 40 as sortcol union all
        select @rowguid41 as rowguid, 41 as sortcol union all
        select @rowguid42 as rowguid, 42 as sortcol union all
        select @rowguid43 as rowguid, 43 as sortcol union all
        select @rowguid44 as rowguid, 44 as sortcol union all
        select @rowguid45 as rowguid, 45 as sortcol union all
        select @rowguid46 as rowguid, 46 as sortcol union all
        select @rowguid47 as rowguid, 47 as sortcol union all
        select @rowguid48 as rowguid, 48 as sortcol union all
        select @rowguid49 as rowguid, 49 as sortcol union all
        select @rowguid50 as rowguid, 50 as sortcol union all
        select @rowguid51 as rowguid, 51 as sortcol union all
        select @rowguid52 as rowguid, 52 as sortcol union all
        select @rowguid53 as rowguid, 53 as sortcol union all
        select @rowguid54 as rowguid, 54 as sortcol union all
        select @rowguid55 as rowguid, 55 as sortcol union all
        select @rowguid56 as rowguid, 56 as sortcol union all
        select @rowguid57 as rowguid, 57 as sortcol union all
        select @rowguid58 as rowguid, 58 as sortcol union all
        select @rowguid59 as rowguid, 59 as sortcol union all
        select @rowguid60 as rowguid, 60 as sortcol union all
        select @rowguid61 as rowguid, 61 as sortcol union all
        select @rowguid62 as rowguid, 62 as sortcol union all
 
        select @rowguid63 as rowguid, 63 as sortcol union all
        select @rowguid64 as rowguid, 64 as sortcol union all
        select @rowguid65 as rowguid, 65 as sortcol union all
        select @rowguid66 as rowguid, 66 as sortcol union all
        select @rowguid67 as rowguid, 67 as sortcol union all
        select @rowguid68 as rowguid, 68 as sortcol union all
        select @rowguid69 as rowguid, 69 as sortcol union all
        select @rowguid70 as rowguid, 70 as sortcol union all
        select @rowguid71 as rowguid, 71 as sortcol union all
        select @rowguid72 as rowguid, 72 as sortcol union all
        select @rowguid73 as rowguid, 73 as sortcol union all
        select @rowguid74 as rowguid, 74 as sortcol union all
        select @rowguid75 as rowguid, 75 as sortcol union all
        select @rowguid76 as rowguid, 76 as sortcol union all
        select @rowguid77 as rowguid, 77 as sortcol union all
        select @rowguid78 as rowguid, 78 as sortcol union all
        select @rowguid79 as rowguid, 79 as sortcol union all
        select @rowguid80 as rowguid, 80 as sortcol union all
        select @rowguid81 as rowguid, 81 as sortcol union all
        select @rowguid82 as rowguid, 82 as sortcol union all
        select @rowguid83 as rowguid, 83 as sortcol union all
        select @rowguid84 as rowguid, 84 as sortcol union all
        select @rowguid85 as rowguid, 85 as sortcol union all
        select @rowguid86 as rowguid, 86 as sortcol union all
        select @rowguid87 as rowguid, 87 as sortcol union all
        select @rowguid88 as rowguid, 88 as sortcol union all
        select @rowguid89 as rowguid, 89 as sortcol union all
        select @rowguid90 as rowguid, 90 as sortcol union all
        select @rowguid91 as rowguid, 91 as sortcol union all
        select @rowguid92 as rowguid, 92 as sortcol union all
        select @rowguid93 as rowguid, 93 as sortcol union all
 
        select @rowguid94 as rowguid, 94 as sortcol union all
        select @rowguid95 as rowguid, 95 as sortcol union all
        select @rowguid96 as rowguid, 96 as sortcol union all
        select @rowguid97 as rowguid, 97 as sortcol union all
        select @rowguid98 as rowguid, 98 as sortcol union all
        select @rowguid99 as rowguid, 99 as sortcol union all
        select @rowguid100 as rowguid, 100 as sortcol
        ) as rows 

        left outer join [dbo].[HOCPHI] t with (rowlock) 
        on t.[rowguid] = rows.rowguid
        and rows.rowguid is not null
        left outer join dbo.MSmerge_contents cont with (rowlock) 
        on cont.rowguid = rows.rowguid and cont.tablenick = 31081000
        left outer join dbo.MSmerge_tombstone tomb with (rowlock) 
        on tomb.rowguid = rows.rowguid and tomb.tablenick = 31081000
        where rows.rowguid is not null
        order by rows.sortcol
                
        if @@error <> 0 
            return 1
    end
    

go
Create procedure dbo.[MSmerge_cft_sp_BB5C29C42300434E8D8B572FB3524CD3] ( 
@p1 varchar(12), 
        @p2 nvarchar(50), 
        @p3 int, 
        @p4 int, 
        @p5 int, 
        @p6 uniqueidentifier, 
        @p7  nvarchar(255) 
, @conflict_type int,  @reason_code int,  @reason_text nvarchar(720)
, @pubid uniqueidentifier, @create_time datetime = NULL
, @tablenick int = 0, @source_id uniqueidentifier = NULL, @check_conflicttable_existence bit = 0 
) as
declare @retcode int
-- security check
exec @retcode = sys.sp_MSrepl_PAL_rolecheck @objid = 1984726123, @pubid = '8D8B572F-B352-4CD3-9BF9-08911C828501'
if @@error <> 0 or @retcode <> 0 return 1 

if 1 = @check_conflicttable_existence
begin
    if 1984726123 is null return 0
end


    if @source_id is NULL 
        select @source_id = subid from dbo.sysmergesubscriptions 
            where lower(@p7) = LOWER(subscriber_server) + '.' + LOWER(db_name) 

    if @source_id is NULL select @source_id = newid() 
  
    set @create_time=getdate()

  if exists (select * from MSmerge_conflicts_info info inner join [dbo].[MSmerge_conflict_QLDSV_HP_HOCPHI] ct 
    on ct.rowguidcol=info.rowguid and 
       ct.origin_datasource_id = info.origin_datasource_id
     where info.rowguid = @p6 and info.origin_datasource = @p7 and info.tablenick = @tablenick)
    begin
        update [dbo].[MSmerge_conflict_QLDSV_HP_HOCPHI] with (rowlock) set 
[MASV] = @p1
,
        [NIENKHOA] = @p2
,
        [HOCKY] = @p3
,
        [HOCPHI] = @p4
,
        [SOTIENDADONG] = @p5
 from [dbo].[MSmerge_conflict_QLDSV_HP_HOCPHI] ct inner join MSmerge_conflicts_info info 
        on ct.rowguidcol=info.rowguid and 
           ct.origin_datasource_id = info.origin_datasource_id
 where info.rowguid = @p6 and info.origin_datasource = @p7 and info.tablenick = @tablenick


    end
    else
    begin
        insert into [dbo].[MSmerge_conflict_QLDSV_HP_HOCPHI] (
[MASV]
,
        [NIENKHOA]
,
        [HOCKY]
,
        [HOCPHI]
,
        [SOTIENDADONG]
,
        [rowguid]
,
        [origin_datasource_id]
) values (

@p1
,
        @p2
,
        @p3
,
        @p4
,
        @p5
,
        @p6
,
         @source_id 
)

    end

    
    if exists (select * from MSmerge_conflicts_info info where tablenick=@tablenick and rowguid=@p6 and info.origin_datasource= @p7 and info.conflict_type not in (4,7,8,12))
    begin
        update MSmerge_conflicts_info with (rowlock) 
            set conflict_type=@conflict_type, 
                reason_code=@reason_code,
                reason_text=@reason_text,
                pubid=@pubid,
                MSrepl_create_time=@create_time
            where tablenick=@tablenick and rowguid=@p6 and origin_datasource= @p7
            and conflict_type not in (4,7,8,12)
    end
    else    
    begin
    
        insert MSmerge_conflicts_info with (rowlock) 
            values(@tablenick, @p6, @p7, @conflict_type, @reason_code, @reason_text,  @pubid, @create_time, @source_id)
    end

        declare @error    int
        set @error= @reason_code

    declare @REPOLEExtErrorDupKey            int
    declare @REPOLEExtErrorDupUniqueIndex    int

    set @REPOLEExtErrorDupKey= 2627
    set @REPOLEExtErrorDupUniqueIndex= 2601
    
    if @error in (@REPOLEExtErrorDupUniqueIndex, @REPOLEExtErrorDupKey)
    begin
        update mc
            set mc.generation= 0
            from dbo.MSmerge_contents mc join [dbo].[HOCPHI] t on mc.rowguid=t.rowguidcol
            where
                mc.tablenick = 31081000 and
                (

                        (t.[MASV]=@p1 and t.[NIENKHOA]=@p2 and t.[HOCKY]=@p3)

                        )
            end

go

update dbo.sysmergearticles 
    set insert_proc = 'MSmerge_ins_sp_BB5C29C42300434E8D8B572FB3524CD3',
        select_proc = 'MSmerge_sel_sp_BB5C29C42300434E8D8B572FB3524CD3',
        metadata_select_proc = 'MSmerge_sel_sp_BB5C29C42300434E8D8B572FB3524CD3_metadata',
        update_proc = 'MSmerge_upd_sp_BB5C29C42300434E8D8B572FB3524CD3',
        ins_conflict_proc = 'MSmerge_cft_sp_BB5C29C42300434E8D8B572FB3524CD3',
        delete_proc = 'MSmerge_del_sp_BB5C29C42300434E8D8B572FB3524CD3'
    where artid = 'BB5C29C4-2300-434E-AC2A-A98F754BF494' and pubid = '8D8B572F-B352-4CD3-9BF9-08911C828501'

go

	if object_id('sp_MSpostapplyscript_forsubscriberprocs','P') is not NULL
		exec sys.sp_MSpostapplyscript_forsubscriberprocs @procsuffix = 'BB5C29C42300434E8D8B572FB3524CD3'

go
