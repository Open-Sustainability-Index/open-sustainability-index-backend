import { LoaderFunctionArgs } from '@remix-run/node';
import { authenticate } from '../lib/authenticate';
import { createSupabaseServerClient } from '../supabase.server';

export async function loader ({ request, params }: LoaderFunctionArgs) {
  authenticate({ request })
  const { supabaseClient } = createSupabaseServerClient(request)

  const { data, error } = await supabaseClient.from('company').select(`
    *,
    emissions:emission(*),
    targets:target(*),
    commitment:commitment(*)
  `).eq('slug', params.company).single()

  return {
    data,
    error,
  }

}
