# Account deletion requests

0. Sanity dump all identifiable user data across auth and public tables (non sensitive)
``` sql
select
  au.id as user_id,
  au.email as auth_email,
  au.created_at as auth_created,
  au.last_sign_in_at,
  p.*
from auth.users au
left join public.profiles p on p.id = au.id
order by au.created_at desc;
```

1. create a minimal table to track deletions (run once)
``` sql
create table if not exists public.account_deletions (
  user_id uuid primary key,
  deleted_at timestamptz not null
);
```

2. sanity check: show all live user data before deletion
``` sql
select
  au.id as user_id,
  au.email as auth_email,
  au.created_at,
  au.last_sign_in_at,
  p.*
from auth.users au
left join public.profiles p on p.id = au.id
order by au.created_at desc;
```

3. full deletion script (run any time)
``` sql
begin;

-- store minimal deletion proof
insert into public.account_deletions (user_id, deleted_at)
select user_id, now()
from public.deletion_requests
where processed = false
on conflict (user_id) do nothing;

-- delete personal data
delete from public.profiles
where id in (select user_id from public.deletion_requests where processed = false);

delete from auth.users
where id in (select user_id from public.deletion_requests where processed = false);

-- mark deletion request handled (do not touch email column)
update public.deletion_requests
set processed = true
where processed = false;

commit;
```

4. Sanity - No deleted user should still exist:
``` sql
select d.user_id, p.id as profile, a.id as auth
from public.account_deletions d
left join public.profiles p on p.id = d.user_id
left join auth.users a on a.id = d.user_id
where p.id is not null or a.id is not null;
```

5. Sanity - Pending requests should be zero:
``` sql
select count(*) from public.deletion_requests where processed = false;
```

6. Sanity - Deletion log should contain only uuid + time:
``` sql
select * from public.account_deletions order by deleted_at desc;
```
