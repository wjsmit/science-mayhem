-- Science Mayhem: make yourself the teacher. Run ONCE, after 1_setup.sql, in the same Supabase SQL Editor.
-- Change the PIN below to your own (at least 6 characters) before you press Run. The name is the username
-- you will type into the game's Teacher tools; change it too if you like. Only a scrambled version of the PIN is stored.
do $do$
declare
  v_name text := 'atlantis';
  v_pin  text := 'CHANGE-THIS-PIN';
  v_salt text := encode(extensions.gen_random_bytes(8), 'hex');
  v_id text;
begin
  if v_pin = 'CHANGE-THIS-PIN' or char_length(v_pin) < 6 then
    raise exception 'Change v_pin to your own PIN (at least 6 characters) before running this.';
  end if;
  begin
    perform public.sci_profile_create(v_name, 0);
  exception when others then
    if sqlerrm <> 'taken' then raise; end if;
  end;
  v_id := sci.code_id(v_name);
  insert into sci.admins (profile_id, salt, pin_hash)
    values (v_id, v_salt, encode(extensions.digest(v_salt || v_pin, 'sha256'), 'hex'))
    on conflict (profile_id) do update set salt = excluded.salt, pin_hash = excluded.pin_hash;
end $do$;
