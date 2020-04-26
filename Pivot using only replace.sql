CREATE TABLE #WelshWordsForNumbers
(number INT, word VARCHAR(30))
 
INSERT INTO #WelshWordsForNumbers (Number, Word)
          SELECT 1, 'un'
union all SELECT 2, 'dau'
union all SELECT 3, 'tri'
union all SELECT 4, 'pedwar'
union all SELECT 5, 'pump'
union all SELECT 6, 'chwech'
union all SELECT 7, 'saith'
union all SELECT 8, 'wyth'
union all SELECT 9, 'naw'
union all SELECT 10,'deg'
 
DECLARE @string VARCHAR(MAX)
SELECT @String=REPLACE(COALESCE(@String,'%'),'%', word+',%') 
  FROM #WelshWordsForNumbers ORDER BY Number
SELECT REPLACE(@String,',%','')




SELECT  STUFF(
  (SELECT ','+word FROM #WelshWordsForNumbers
  FOR XML PATH(''), TYPE).value('.', 'varchar(max)')
  ,1,1,'') 
  
  drop table #WelshWordsForNumbers
  
Declare @Respectively Varchar(8000)
Select @Respectively=
         Replace(Replace(
            coalesce(@Respectively, 'I''m told that <t> is shipped from <p> respectively'),
            '<t>',beverage+', <t>'),
         '<p>',producer+', <p>')
from
  (Select 'Tea' as beverage, 'China' as producer
   union all Select 'Coffee', 'Brazil'
   union all Select 'Cocoa', 'America') data
Select Replace(replace(@Respectively,', <p>',''),', <t>','')  

