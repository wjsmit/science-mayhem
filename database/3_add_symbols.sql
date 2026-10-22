-- Science Mayhem: adds the "Periodic table: names and symbols" topic (id: symbols).
-- Run ONCE in the Supabase SQL Editor (science-mayhem project). Safe to run twice.
-- It changes the list of allowed topics inside three existing functions; nothing else is touched.
do $do$
declare r record; d text;
begin
  for r in
    select p.oid from pg_proc p
    where p.pronamespace = 'public'::regnamespace
      and p.proname in ('sci_admin_import', 'sci_admin_set_level', 'sci_profile_apply_round')
  loop
    d := pg_get_functiondef(r.oid);
    if position($q$array['ptable','states','cells','mixed']$q$ in d) > 0 then
      execute replace(d, $q$array['ptable','states','cells','mixed']$q$, $q$array['ptable','symbols','states','cells','mixed']$q$);
    end if;
  end loop;
end $do$;
