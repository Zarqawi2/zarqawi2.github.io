create table if not exists public.site_stats (
  key text primary key,
  value bigint not null default 0,
  updated_at timestamptz not null default now()
);

insert into public.site_stats (key, value)
values
  ('visitors', 0),
  ('hearts', 0)
on conflict (key) do nothing;

create table if not exists public.site_visits (
  user_id text primary key,
  created_at timestamptz not null default now()
);

create table if not exists public.site_hearts (
  user_id text primary key,
  created_at timestamptz not null default now()
);

alter table public.site_stats enable row level security;
alter table public.site_visits enable row level security;
alter table public.site_hearts enable row level security;

drop policy if exists "read site stats" on public.site_stats;
drop policy if exists "read own visits" on public.site_visits;
drop policy if exists "read own hearts" on public.site_hearts;

create policy "read site stats"
on public.site_stats
for select
to authenticated
using (true);

create policy "read own visits"
on public.site_visits
for select
to authenticated
using (user_id = auth.user_id()::text);

create policy "read own hearts"
on public.site_hearts
for select
to authenticated
using (user_id = auth.user_id()::text);

create or replace function public.get_site_counters()
returns table(visitors bigint, hearts bigint, supported boolean)
language plpgsql
security definer
set search_path = public
as $$
declare
  current_user_id text := auth.user_id()::text;
begin
  if current_user_id is null then
    raise exception 'authentication required';
  end if;

  return query
  select
    coalesce((select value from public.site_stats where key = 'visitors'), 0),
    coalesce((select value from public.site_stats where key = 'hearts'), 0),
    exists(select 1 from public.site_hearts where user_id = current_user_id);
end;
$$;

create or replace function public.get_public_site_counters()
returns table(visitors bigint, hearts bigint, supported boolean)
language plpgsql
security definer
set search_path = public
as $$
begin
  return query
  select
    coalesce((select value from public.site_stats where key = 'visitors'), 0),
    coalesce((select value from public.site_stats where key = 'hearts'), 0),
    false;
end;
$$;

create or replace function public.record_visit()
returns table(visitors bigint, hearts bigint, supported boolean)
language plpgsql
security definer
set search_path = public
as $$
declare
  current_user_id text := auth.user_id()::text;
  inserted_rows integer := 0;
begin
  if current_user_id is null then
    raise exception 'authentication required';
  end if;

  insert into public.site_visits (user_id)
  values (current_user_id)
  on conflict (user_id) do nothing;

  get diagnostics inserted_rows = row_count;

  if inserted_rows > 0 then
    update public.site_stats
    set value = value + 1,
        updated_at = now()
    where key = 'visitors';
  end if;

  return query
  select
    coalesce((select value from public.site_stats where key = 'visitors'), 0),
    coalesce((select value from public.site_stats where key = 'hearts'), 0),
    exists(select 1 from public.site_hearts where user_id = current_user_id);
end;
$$;

create or replace function public.record_heart()
returns table(visitors bigint, hearts bigint, supported boolean)
language plpgsql
security definer
set search_path = public
as $$
declare
  current_user_id text := auth.user_id()::text;
  inserted_rows integer := 0;
begin
  if current_user_id is null then
    raise exception 'authentication required';
  end if;

  insert into public.site_hearts (user_id)
  values (current_user_id)
  on conflict (user_id) do nothing;

  get diagnostics inserted_rows = row_count;

  if inserted_rows > 0 then
    update public.site_stats
    set value = value + 1,
        updated_at = now()
    where key = 'hearts';
  end if;

  return query
  select
    coalesce((select value from public.site_stats where key = 'visitors'), 0),
    coalesce((select value from public.site_stats where key = 'hearts'), 0),
    true;
end;
$$;

grant usage on schema public to authenticated;
grant usage on schema public to anonymous;
grant select on public.site_stats to authenticated;
grant select on public.site_visits to authenticated;
grant select on public.site_hearts to authenticated;
grant execute on function public.get_public_site_counters() to anonymous;
grant execute on function public.get_public_site_counters() to authenticated;
grant execute on function public.get_site_counters() to authenticated;
grant execute on function public.record_visit() to authenticated;
grant execute on function public.record_heart() to authenticated;
