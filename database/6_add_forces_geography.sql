-- Science Mayhem: adds the "Forces" (id: forces) and "Geography" (id: geo) levels.
-- Run once in the science-mayhem Supabase project (SQL editor), after scripts 1 to 5. Safe to run again.
do $do$
declare r record; d text;
begin
  for r in select p.oid from pg_proc p where p.pronamespace = 'public'::regnamespace
    and p.proname in ('sci_admin_import','sci_admin_set_level','sci_profile_apply_round')
  loop
    d := pg_get_functiondef(r.oid);
    if position($q$array['ptable','symbols','bonding','motion','states','cells','mixed']$q$ in d) > 0 then
      execute replace(d, $q$array['ptable','symbols','bonding','motion','states','cells','mixed']$q$, $q$array['ptable','symbols','bonding','motion','forces','geo','states','cells','mixed']$q$);
    end if;
  end loop;
end $do$;
