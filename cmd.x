!create readFile : Permission
!create writeFile : Permission
!create read : Operation
!create file : Object
!insert(readFile, read) into PermOperations
!insert(readFile, file) into PermObjects
!insert(read, file) into ExecuteOn