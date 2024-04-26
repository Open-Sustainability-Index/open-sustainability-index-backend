import { LoaderFunctionArgs } from '@remix-run/node';
import { createSupabaseServerClient } from '../supabase.server';

export async function loader ({ request, params }: LoaderFunctionArgs) {
  const { supabaseClient } = createSupabaseServerClient(request)

  const { data, error } = await supabaseClient.from('company_slug').select(`
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
