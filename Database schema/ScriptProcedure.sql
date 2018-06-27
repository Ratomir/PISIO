CREATE PROCEDURE ChangeUserPassword (IN userName nvarchar(64), IN newPassword nvarchar(64))
BEGIN
declare salt varchar(36);
set salt = UUID();
select @count = count(id) from User where UserName = @userName;
if @count == 1 then 
    begin 
		update User set salt = @salt, Password = SHA(CONCAT(salt, @newPassword), 512)
        where UserName = @userName;
        re
    end
else 
	begin 
    end
end if
END