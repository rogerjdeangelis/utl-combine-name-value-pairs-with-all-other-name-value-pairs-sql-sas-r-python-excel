%let pgm=utl-combine-name-value-pairs-with-all-other-name-value-pairs-sql-sas-r-python-excel;

%stop_submission;

Combine name value pairs with all other name value pairs sql sas r python excel

      CONTENTS

         1 SAS SQL
         2 R SQL see
           https://tinyurl.com/4e6yaap8
           for python and excel

github
https://tinyurl.com/22rmw9tn
https://github.com/rogerjdeangelis/utl-combine-name-value-pairs-with-all-other-name-value-pairs-sql-sas-r-python-excel

communities.sas
https://tinyurl.com/mu5y3k8t
https://communities.sas.com/t5/SAS-Programming/Create-combination-of-value-and-name/m-p/839107#M331772

/**************************************************************************************************************************/
/*       INPUT             |            PROCESS                   |        OUTPUT                                         */
/*       =====             |            =======                   |        ======                                         */
/*                         |                                      |                                                       */
/*    NAME    VALUE        | 1 SAS SQL (same r python excel)      | NAME VALUE       NAME2 VALUE2                         */
/*                         | =====================================|                                                       */
/*     V1       A          |                                      |  V1    A   with   V2     B -+ V1 A                    */
/*     V2       B          | proc sql;                            |  V1    A   all    V2     C  | not present             */
/*     V2       C          |   create                             |  V1    A   other  V3     D  | do not join             */
/*     V3       D          |     table want as                    |  V1    A   rows   V3     E  | V1 A with V1 A          */
/*     V3       E          |   select                             |  V1    A          V3     F -+                         */
/*     V3       F          |     l.*                              |                                                       */
/*                         |    ,r.name as name2                  |  V2    B   with   V1     A -+ V2 B & C                */
/*  options                |    ,r.value as value2                |  V2    B   all    V3     D  | not present             */
/*   validvarname=upcase;  |   from                               |  V2    B   other  V3     E  | do not                  */
/*  libname sd1 "d:/sd1";  |     sd1 have l cross join sd1.have   |  V2    B   rows   V3     F  | join                    */
/*  data sd1.have;         |   where                              |                             | V2 B with V 2 B         */
/*   input name$ value$;   |        l.name  <> r.name             |  V2    C   with   V1     A  |                         */
/*  cards4;                |    and l.value <> r.value            |  V2    C   all    V3     D  |                         */
/*   V1  A                 | ;quit;                               |  V2    C   other  V3     E  |                         */
/*   V2  B                 |                                      |  V2    C   roes   V3     F _+                         */
/*   V2  C                 | 2 R SQL SEE                          |                                                       */
/*   V3  D                 |   https://tinyurl.com/4e6yaap8       |  V3    D   with   V1     A -+ V3 D E F                */
/*   V3  E                 |   for python and excel               |  V3    D   other  V2     B  | not present             */
/*   V3  F                 |======================================|  V3    D   rows   V2     C  |                         */
/*  ;;;;                   |                                      |                             |                         */
/*  run;quit;              | %utl_rbeginx;                        |  V3    E   with   V1     A  |                         */
/*                         | parmcards4;                          |  V3    E   other  V2     B  |                         */
/*                         | library(haven)                       |  V3    E   rows   V2     C  |                         */
/*                         | library(sqldf)                       |                r            |                         */
/*                         | source("c:/oto/fn_tosas9x.R")        |  V3    F   with   V1     A  |                         */
/*                         | have<-read_sas(                      |  V3    F   other  V2     B  |                         */
/*                         |  "d:/sd1/have.sas7bdat")             |  V3    F   rows   V2     C _+                         */
/*                         | print(have)                          |                                                       */
/*                         | want<-sqldf('                        |                                                       */
/*                         |   select                             |                                                       */
/*                         |     l.*                              |                                                       */
/*                         |    ,r.name as name2                  |                                                       */
/*                         |    ,r.value as value2                |                                                       */
/*                         |   from                               |                                                       */
/*                         |     have l as l cross join have r    |                                                       */
/*                         |   where                              |                                                       */
/*                         |        l.name  <> r.name             |                                                       */
/*                         |    and l.value <> r.value            |                                                       */
/*                         |   ')                                 |                                                       */
/*                         | want                                 |                                                       */
/*                         | fn_tosas9x(                          |                                                       */
/*                         |       inp    = want                  |                                                       */
/*                         |      ,outlib ="d:/sd1/"              |                                                       */
/*                         |      ,outdsn ="want"                 |                                                       */
/*                         |      )                               |                                                       */
/*                         | ;;;;                                 |                                                       */
/*                         | %utl_rendx;                          |                                                       */
/*                         |                                      |                                                       */
/*                         | proc print data=sd1.want;            |                                                       */
/*                         | run;quit;                            |                                                       */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

options
 validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
 input name$ value$;
cards4;
 V1  A
 V2  B
 V2  C
 V3  D
 V3  E
 V3  F
;;;;
run;quit;

/**************************************************************************************************************************/
/*  NAME    VALUE                                                                                                         */
/*                                                                                                                        */
/*   V1       A                                                                                                           */
/*   V2       B                                                                                                           */
/*   V2       C                                                                                                           */
/*   V3       D                                                                                                           */
/*   V3       E                                                                                                           */
/*   V3       F                                                                                                           */
/**************************************************************************************************************************/

/*             _
/ |  ___  __ _| |
| | / __|/ _` | |
| | \__ \ (_| | |
|_| |___/\__, |_|
            |_|
*/

proc sql;
  create
    table want as
  select
    l.*
   ,r.name as name2
   ,r.value as value2
  from
    sd1 have l cross join sd1.have
  where
       l.name  <> r.name
   and l.value <> r.value
;quit;

/**************************************************************************************************************************/
/*   NAME    VALUE    NAME2    VALUE2                                                                                     */
/*                                                                                                                        */
/*    V1       A       V2        B                                                                                        */
/*    V1       A       V2        C                                                                                        */
/*    V1       A       V3        D                                                                                        */
/*    V1       A       V3        E                                                                                        */
/*    V1       A       V3        F                                                                                        */
/*    V2       B       V1        A                                                                                        */
/*    V2       B       V3        D                                                                                        */
/*    V2       B       V3        E                                                                                        */
/*    V2       B       V3        F                                                                                        */
/*    V2       C       V1        A                                                                                        */
/*    V2       C       V3        D                                                                                        */
/*    V2       C       V3        E                                                                                        */
/*    V2       C       V3        F                                                                                        */
/*    V3       D       V1        A                                                                                        */
/*    V3       D       V2        B                                                                                        */
/*    V3       D       V2        C                                                                                        */
/*    V3       E       V1        A                                                                                        */
/*    V3       E       V2        B                                                                                        */
/*    V3       E       V2        C                                                                                        */
/*    V3       F       V1        A                                                                                        */
/*    V3       F       V2        B                                                                                        */
/*    V3       F       V2        C                                                                                        */
/**************************************************************************************************************************/

/*___                     _
|___ \   _ __   ___  __ _| |
  __) | | `__| / __|/ _` | |
 / __/  | |    \__ \ (_| | |
|_____| |_|    |___/\__, |_|
                       |_|
*/

proc datasets lib=sd1 nolist nodetails;
 delete want;
run;quit;

%utl_rbeginx;
parmcards4;
library(haven)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
have<-read_sas(
 "d:/sd1/have.sas7bdat")
print(have)
want<-sqldf('
  select
    l.*
   ,r.name as name2
   ,r.value as value2
  from
    have as l cross join have r
  where
       l.name  <> r.name
   and l.value <> r.value
  ')
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/* R                            | SAS                                                                                     */
/*  NAME VALUE NAME2 VALUE2     | ROWNAMES    NAME    VALUE    NAME2    VALUE2                                            */
/*                              |                                                                                         */
/*    V1     A    V2      B     |     1        V1       A       V2        B                                               */
/*    V1     A    V2      C     |     2        V1       A       V2        C                                               */
/*    V1     A    V3      D     |     3        V1       A       V3        D                                               */
/*    V1     A    V3      E     |     4        V1       A       V3        E                                               */
/*    V1     A    V3      F     |     5        V1       A       V3        F                                               */
/*    V2     B    V1      A     |     6        V2       B       V1        A                                               */
/*    V2     B    V3      D     |     7        V2       B       V3        D                                               */
/*    V2     B    V3      E     |     8        V2       B       V3        E                                               */
/*    V2     B    V3      F     |     9        V2       B       V3        F                                               */
/*    V2     C    V1      A     |    10        V2       C       V1        A                                               */
/*    V2     C    V3      D     |    11        V2       C       V3        D                                               */
/*    V2     C    V3      E     |    12        V2       C       V3        E                                               */
/*    V2     C    V3      F     |    13        V2       C       V3        F                                               */
/*    V3     D    V1      A     |    14        V3       D       V1        A                                               */
/*    V3     D    V2      B     |    15        V3       D       V2        B                                               */
/*    V3     D    V2      C     |    16        V3       D       V2        C                                               */
/*    V3     E    V1      A     |    17        V3       E       V1        A                                               */
/*    V3     E    V2      B     |    18        V3       E       V2        B                                               */
/*    V3     E    V2      C     |    19        V3       E       V2        C                                               */
/*    V3     F    V1      A     |    20        V3       F       V1        A                                               */
/*    V3     F    V2      B     |    21        V3       F       V2        B                                               */
/*    V3     F    V2      C     |    22        V3       F       V2        C                                               */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
