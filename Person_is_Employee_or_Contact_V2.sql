select papf.person_number,

(SELECT 'Y'

FROM   dual

where exists

(select 1

  from fusion.per_contact_relationships pcr

  where pcr.person_id IN (select papf1.person_id from fusion.per_all_people_f papf1 where trunc(sysdate) between papf1.effective_start_date and papf1.effective_end_date and papf1.person_number = papf.person_number

UNION

select 1 

from fusion.per_all_people_f papf3,

     fusion.per_all_assignments_f paaf3

where trunc(sysdate) between papf3.effective_start_date and papf3.effective_end_date

and papf3.person_number = papf.person_number

and papf3.person_id = paaf3.person_id

and paaf3.primary_flag = 'Y'

and paaf3.assignment_type = 'E'))) is_employee,

  (SELECT 'Y'

   FROM   dual

   where exists

   (select 1

    from fusion.per_contact_relationships pcr

  where pcr.contact_person_id IN (select papf2.person_id from fusion.per_all_people_f papf2 where trunc(sysdate) between papf2.effective_start_date and papf2.effective_end_date and papf2.person_number =papf.person_number))) is_contact

  from fusion.per_all_people_f papf

  where trunc(sysdate) between papf.effective_start_date and papf.effective_end_date

  and papf.person_id IN

  (SELECT pcr.contact_person_id

   FROM   per_contact_relationships pcr

   UNION

   SELECT pcr.person_id

   FROM   per_contact_relationships pcr

  )