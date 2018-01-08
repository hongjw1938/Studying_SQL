SELECT channel_desc, calendar_month_desc,
   TO_CHAR(TRUNC(SUM(amount_sold),-5), '9,999,999,999') SALES$,
      RANK() OVER (ORDER BY TRUNC(SUM(amount_sold),-5) DESC) AS RANK,
DENSE_RANK() OVER (ORDER BY TRUNC(SUM(amount_sold),-5) DESC) AS DENSE_RANK
FROM sales, products, customers, times, channels
WHERE sales.prod_id=products.prod_id
  AND sales.cust_id=customers.cust_id
  AND sales.time_id=times.time_id AND sales.channel_id=channels.channel_id
  AND times.calendar_month_desc IN ('2000-09', '2000-10')
  AND channels.channel_desc<>'Tele Sales'
GROUP BY channel_desc, calendar_month_desc;

CHANNEL_DESC         CALENDAR SALES$              RANK DENSE_RANK
-------------------- -------- -------------- --------- ----------
Direct Sales         2000-09       1,200,000         1          1
Direct Sales         2000-10       1,200,000         1          1
Partners             2000-09         600,000         3          2
Partners             2000-10         600,000         3          2
Internet             2000-09         200,000         5          3
Internet             2000-10         200,000         5          3

SELECT channel_desc, calendar_month_desc, TO_CHAR(SUM(amount_sold),
 '9,999,999,999') SALES$, RANK() OVER (PARTITION BY channel_desc
  ORDER BY SUM(amount_sold) DESC) AS RANK_BY_CHANNEL
FROM sales, products, customers, times, channels
WHERE sales.prod_id=products.prod_id AND sales.cust_id=customers.cust_id
  AND sales.time_id=times.time_id AND sales.channel_id=channels.channel_id
  AND times.calendar_month_desc IN ('2000-08', '2000-09', '2000-10', '2000-11')
  AND channels.channel_desc IN ('Direct Sales', 'Internet')
GROUP BY channel_desc, calendar_month_desc;

CHANNEL_DESC         CALENDAR SALES$         RANK_BY_CHANNEL
-------------------- -------- -------------- ---------------
Direct Sales         2000-08       1,236,104               1
Direct Sales         2000-10       1,225,584               2
Direct Sales         2000-09       1,217,808               3
Direct Sales         2000-11       1,115,239               4
Internet             2000-11         284,742               1
Internet             2000-10         239,236               2
Internet             2000-09         228,241               3
Internet             2000-08         215,107               4
 
 
 SELECT calendar_month_desc AS MONTH, channel_desc,
     TO_CHAR(SUM(amount_sold) , '9,999,999,999') SALES$,
     CUME_DIST() OVER (PARTITION BY calendar_month_desc ORDER BY
         SUM(amount_sold) ) AS CUME_DIST_BY_CHANNEL
FROM sales, products, customers, times, channels
WHERE sales.prod_id=products.prod_id AND sales.cust_id=customers.cust_id
  AND sales.time_id=times.time_id AND sales.channel_id=channels.channel_id
  AND times.calendar_month_desc IN ('2000-09', '2000-07','2000-08')
GROUP BY calendar_month_desc, channel_desc;

MONTH    CHANNEL_DESC         SALES$         CUME_DIST_BY_CHANNEL
-------- -------------------- -------------- --------------------
2000-07  Internet                    140,423           .333333333
2000-07  Partners                    611,064           .666666667
2000-07  Direct Sales              1,145,275                    1
2000-08  Internet                    215,107           .333333333
2000-08  Partners                    661,045           .666666667
2000-08  Direct Sales              1,236,104                    1
2000-09  Internet                    228,241           .333333333
2000-09  Partners                    666,172           .666666667
2000-09  Direct Sales              1,217,808                    1


SELECT c.cust_id, t.calendar_quarter_desc, TO_CHAR (SUM(amount_sold),
  '9,999,999,999.99') AS Q_SALES, TO_CHAR(SUM(SUM(amount_sold))
OVER (PARTITION BY c.cust_id ORDER BY c.cust_id, t.calendar_quarter_desc
ROWS UNBOUNDED
PRECEDING), '9,999,999,999.99') AS CUM_SALES
  FROM sales s, times t, customers c
  WHERE s.time_id=t.time_id AND s.cust_id=c.cust_id AND t.calendar_year=2000
    AND c.cust_id IN (2595, 9646, 11111)
  GROUP BY c.cust_id, t.calendar_quarter_desc
  ORDER BY c.cust_id, t.calendar_quarter_desc;

   CUST_ID CALENDA Q_SALES           CUM_SALES
---------- ------- ----------------- -----------------
      2595 2000-01            659.92            659.92
      2595 2000-02            224.79            884.71
      2595 2000-03            313.90          1,198.61
      2595 2000-04          6,015.08          7,213.69
      9646 2000-01          1,337.09          1,337.09
      9646 2000-02            185.67          1,522.76
      9646 2000-03            203.86          1,726.62
      9646 2000-04            458.29          2,184.91
     11111 2000-01             43.18             43.18
     11111 2000-02             33.33             76.51
     11111 2000-03            579.73            656.24
     11111 2000-04            307.58            963.82
     
     
     SELECT time_id, daily_sum, SUM(daily_sum) OVER (ORDER BY time_id
RANGE BETWEEN INTERVAL '10' DAY PRECEDING AND CURRENT ROW)
AS current_group_sum
FROM (SELECT time_id, channel_id, SUM(s.quantity_sold)
AS daily_sum
FROM customers c, sales s, countries
WHERE c.cust_id=s.cust_id
  AND c.country_id = countries.country_id
  AND s.cust_id IN (638, 634, 753, 440 ) AND s.time_id BETWEEN '01-MAY-00'
  AND '13-MAY-00' GROUP BY time_id, channel_id);

TIME_ID    DAILY_SUM CURRENT_GROUP_SUM
--------- ---------- -----------------
06-MAY-00          7                 7   /* 7 */
10-MAY-00          1                 9   /* 7 + (1+1) */
10-MAY-00          1                 9   /* 7 + (1+1) */
11-MAY-00          2                15   /* 7 + (1+1) + (2+4) */
11-MAY-00          4                15   /* 7 + (1+1) + (2+4) */
12-MAY-00          1                16   /* 7 + (1+1) + (2+4) + 1 */
13-MAY-00          2                23   /* 7 + (1+1) + (2+4) + 1 + (5+2) */
13-MAY-00          5                23   /* 7 + (1+1) + (2+4) + 1 + (5+2) */



SELECT t.time_id, TO_CHAR(amount_sold, '9,999,999,999') AS INDIV_SALE,
       TO_CHAR(SUM(amount_sold) OVER (PARTITION BY t.time_id ORDER BY t.time_id
ROWS UNBOUNDED PRECEDING), '9,999,999,999') AS CUM_SALES
FROM sales s, times t, customers c
WHERE s.time_id=t.time_id AND s.cust_id=c.cust_id
  AND t.time_id IN 
   (TO_DATE('11-DEC-1999'), TO_DATE('12-DEC-1999')) 
  AND c.cust_id 
BETWEEN 6500 AND 6600
ORDER BY t.time_id;

TIME_ID   INDIV_SALE    CUM_SALES
--------- ----------    ---------
12-DEC-99         23           23
12-DEC-99          9           32
12-DEC-99         14           46
12-DEC-99         24           70
12-DEC-99         19           89

SELECT prod_category, country_region, sales
FROM (SELECT SUBSTR(p.prod_category,1,8) AS prod_category, co.country_region,
 SUM(amount_sold) AS sales,
MAX(SUM(amount_sold)) OVER (PARTITION BY prod_category) AS MAX_REG_SALES
FROM sales s, customers c, countries co, products p
WHERE s.cust_id=c.cust_id AND c.country_id=co.country_id
   AND s.prod_id =p.prod_id AND s.time_id = TO_DATE('11-OCT-2001')
GROUP BY prod_category, country_region)
WHERE sales = MAX_REG_SALES;

PROD_CAT COUNTRY_REGION            SALES MAX_REG_SALES
-------- -------------------- ---------- -------------
Electron Americas                 581.92        581.92
Hardware Americas                 925.93        925.93
Peripher Americas                3084.48       4290.38
Peripher Asia                    2616.51       4290.38
Peripher Europe                  4290.38       4290.38
Peripher Oceania                  940.43       4290.38
Software Americas                 4445.7        4445.7
Software Asia                    1408.19        4445.7
Software Europe                  3288.83        4445.7
Software Oceania                  890.25        4445.7


PROD_CAT COUNTRY_REGION            SALES
-------- -------------------- ----------
Electron Americas                 581.92
Hardware Americas                 925.93
Peripher Europe                  4290.38
Software Americas                 4445.7

SELECT ch.channel_desc, TO_CHAR(SUM(amount_sold),'9,999,999') AS SALES,
     TO_CHAR(SUM(SUM(amount_sold)) OVER (), '9,999,999') AS TOTAL_SALES,
     TO_CHAR(RATIO_TO_REPORT(SUM(amount_sold)) OVER (), '9.999')
     AS RATIO_TO_REPORT
FROM sales s, channels ch 
WHERE s.channel_id=ch.channel_id  AND s.time_id=to_DATE('11-OCT-2000')
GROUP BY ch.channel_desc;

CHANNEL_DESC         SALES      TOTAL_SALE RATIO_
-------------------- ---------- ---------- ------
Direct Sales             14,447     23,183   .623
Internet                    345     23,183   .015
Partners                  8,391     23,183   .362