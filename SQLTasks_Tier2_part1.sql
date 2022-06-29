/* ************************************************************************************
   *   The link for Part 2 is:                                                        *
   *   https://github.com/rikki731/springboard/blob/main/SQLTasks_Tier2_part2.ipynb   *
   ************************************************************************************ */

/* Q1: List facilities charge a fee to members */
select name 
       from Facilities
       where membercost <> 0;

/* Q2: how many facilities do not charge a fee to members */
select count(*)
       from Facilities
       where membercost = 0;

/* Q3: List of facilities charge a fee to member but < 20% monthlymaintenance cost */
select facid,
	   name,
	   membercost,
	   monthlymaintenance
       from Facilities
       where membercost <> 0
             and membercost < 0.2 * monthlymaintenance;

/* Q4: details of id 1 and 5 w/o using OR */
select * from Facilities
       where facid in (1,5);

/* Q5: List of facilities w label */
select name,
       monthlymaintenance,
       case when monthlymaintenance > 100 then 'expensive'
       else 'cheap'end as label
       from Facilities;

/* Q6: Last member signed up w/o using LIMIT */
select firstname,
       surname,
       max(joindate) as latest
       from Members
       where memid <> 0;

/* Q7: List of members used tennis court */
select distinct concat_ws(', ', surname, firstname) as full_name,
       name
       from Bookings
       inner join Members
       using (memid)
       inner join Facilities
       using (facid)
       where name like 'Tennis%'
             and memid <> 0
       order by full_name, name;

/* Q8: List of Bookings on date 2012-09-14, cost one more then $30 */
select name,
       case when memid = 0 then 'GUEST'
       else concat_ws(', ', firstname, surname) end as members,
       case when memid = 0 then guestcost * slots 
       else membercost * slots end as costs
       from Bookings
       left join Members
       using (memid)
       left join Facilities
       using (facid)
       where date(starttime) = '2012-09-14'
             and costs > 30
       order by costs desc;

/* Q9: w subquery */

select name,
       case when m.memid = 0 then 'GUEST'
       else concat_ws(', ', surname, firstname) end as full_name,
       case when m.memid = 0 then guestcost * slots
       else membercost * slots end as costs
       from Members as m,
       (select memid, facid, slots
        from Bookings
             where date(starttime) = '2012-09-14') as b,
       (select name, membercost, guestcost, facid
        from Facilities) as f
       where m.memid = b.memid and f.facid = b.facid and costs > 30.0
	   order by costs desc;

/* ************************************************************************************
   *   The link for Part 2 is:                                                        *
   *   https://github.com/rikki731/springboard/blob/main/SQLTasks_Tier2_part2.ipynb   *
   ************************************************************************************ */
