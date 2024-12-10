!create readFile : Permission
!create writeFile : Permission
!create deleteFile : Permission

!create read : Operation
!create write : Operation

!create rfile : Object
!create wfile : Object
!create dfile : Object
-- !destroy dfile

!create office : Location
!create home : Location
!create away : Location
!create serverRoom : Location

!insert (home, rfile) into ObjLocation
!insert (office, wfile) into ObjLocation
!insert (serverRoom, dfile) into ObjLocation

!insert(readFile, read) into PermOperations
!insert(writeFile, write) into PermOperations

!insert(home, readFile) into PermObjLoc
!insert(office, readFile) into PermObjLoc
!insert(office, writeFile) into PermObjLoc
!insert(serverRoom, readFile) into PermObjLoc
!insert(serverRoom, writeFile) into PermObjLoc
!insert(serverRoom, deleteFile) into PermObjLoc

!insert(readFile, rfile) into PermObjects
!insert(writeFile, wfile) into PermObjects
!insert(deleteFile, dfile) into PermObjects

!insert(write, wfile) into ExecuteOn
!insert(read, rfile) into ExecuteOn

--?? readFile.checkAccess(rfile, read)
--?? readFile.checkAccess(rfile, write)

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


?? readFile.checkAccess(rfile, read)
--this returns true
-- now delete the ExecuteOn association between rfile & read
--!delete (read, rfile) from ExecuteOn
-- ?? readFile.checkAccess(rfile, read)
--this should be false now. Even though we did not modify the permission object,
-- it lost access because read operation can no longer be executed on the file.
-- We still have the write operation on wfile which we can verify by running
--?? writeFile.checkAccess(wfile, write)
-- We can also verify that superRole also has writePermission by
--?? superRole.checkAccess(wfile, write)


 !create del : Operation
 !insert(del, dfile) into ExecuteOn
 !insert(deleteFile, del) into PermOperations
 !insert(deleteFile, dfile) into PermObjects

 --ssdConstraint satisfy
 !delete (deleteFile, superRole) from PermAssignment








 -- 1) added 3 locations
 -- 2) associated objects with these locations
 -- 3) If permission p has access to object O, location associated with p & o must be same
 -----------------------------
 -- readFile.checkAccess(rfile, read) returns true
 -- !delete (home, rfile) from ObjLocation -> CheckAcess return false
 -- !insert (away, rfile) into ObjLocation -> CheckAccess return false
 -- also violates constraints
 --
