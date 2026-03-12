'use server';

import { supabase } from '@/lib/supabase';

export async function castPollVote(pollId: string, type: 'serve' | 'flop') {
  if (!pollId) return { success: false, error: 'No poll ID' };

  // Note: In a real production app we would use an RPC function to increment securely
  // For this prototype, we'll fetch current, add 1, and update
  const { data, error } = await supabase
    .from('polls')
    .select('serve_count, flop_count')
    .eq('id', pollId)
    .single();

  if (error || !data) {
    return { success: false, error: 'Poll not found' };
  }

  const updates = type === 'serve' 
    ? { serve_count: data.serve_count + 1 } 
    : { flop_count: data.flop_count + 1 };

  const { error: updateError } = await supabase
    .from('polls')
    .update(updates)
    .eq('id', pollId);

  if (updateError) {
    return { success: false, error: 'Failed to update vote' };
  }

  return { success: true };
}
