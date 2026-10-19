-- Trigger execution does not require client RPC permissions. Keep these helpers private.
revoke all on function public.create_profile_for_new_user() from public, anon, authenticated;
revoke all on function public.stamp_chat_display_name() from public, anon, authenticated;
