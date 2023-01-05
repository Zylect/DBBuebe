CREATE VIEW M141.Originalform AS 
SELECT 
  Path, 
  Time, 
  Systemuser.Name AS "Systemuser", 
  Usergroup.Name AS "Usergroup", 
  Content, 
  Digest, 
  Size, 
  Compression 
FROM 
  Meta 
  LEFT JOIN Data ON Meta.Data_ID = Data.ID_Data 
  LEFT JOIN Systemuser ON Meta.Systemuser_ID = Systemuser.ID_Systemuser 
  LEFT JOIN Usergroup ON Meta.Usergroup_ID = Usergroup.ID_Usergroup 
  LEFT JOIN Type ON Data.Type_ID = Type.ID_Type;
