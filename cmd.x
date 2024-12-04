!create readFile : Permission
!create writeFile : Permission
!create deleteFile : Permission

!create read : Operation
!create write : Operation

!create file : Object
!create wfile : Object
!create deleted : Object
-- !destroy deleted

!insert(readFile, read) into PermOperations
!insert(writeFile, write) into PermOperations

!insert(readFile, file) into PermObjects
!insert(writeFile, wfile) into PermObjects

!insert(write, wfile) into ExecuteOn
!insert(read, file) into ExecuteOn

--?? readFile.checkAccess(file, read)
--?? readFile.checkAccess(file, write)

!create admin : User
!create user : User
!create superUser : User

!create adminSession : Session
!create userSession : Session
!create superSession : Session

!insert(admin, adminSession) into UserSessions
!insert(user, userSession) into UserSessions
!insert(superUser, superSession) into UserSessions
-- !delete (admin, adminSession) from UserSessions

!create adminRole : Role
!create userRole : Role
!create superRole : Role

!insert (adminRole, userRole) into RoleHierarchy
!insert (superRole, adminRole) into RoleHierarchy
!insert (superRole, userRole) into RoleHierarchy
--!delete (adminRole, userRole) from RoleHierarchy

!insert (admin, adminRole) into UserAssignment
!insert (user, userRole) into UserAssignment
!insert (superUser, superRole) into UserAssignment

!insert (readFile, adminRole) into PermAssignment
!insert (writeFile, superRole) into PermAssignment
!insert (readFile, userRole) into PermAssignment

!openter superRole grantPermission(deleteFile)
!insert (deleteFile, superRole) into PermAssignment
!opexit


?? readFile.checkAccess(file, read)
--this returns true
-- now delete the ExecuteOn association between file & read
--!delete (read, file) from ExecuteOn
-- ?? readFile.checkAccess(file, read)
--this should be false now. Even though we did not modify the permission object,
-- it lost access because read operation can no longer be executed on the file.
-- We still have the write operation on wfile which we can verify by running
--?? writeFile.checkAccess(wfile, write)
-- We can also verify that superRole also has writePermission by
--?? superRole.checkAccess(wfile, write)

