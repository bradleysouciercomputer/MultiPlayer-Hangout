drop policy if exists "Authenticated users can receive global lobby events" on realtime.messages;
create policy "Authenticated users can receive global lobby events"
  on realtime.messages for select to authenticated
  using (topic = 'global-lobby');

drop policy if exists "Authenticated users can send global lobby events" on realtime.messages;
create policy "Authenticated users can send global lobby events"
  on realtime.messages for insert to authenticated
  with check (topic = 'global-lobby');
