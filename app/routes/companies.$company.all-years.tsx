import { LoaderFunctionArgs } from '@remix-run/node';
import { createSupabaseServerClient } from '../supabase.server';
import { fromSlug } from '../utils/fromSlug';

export async function loader ({ request, params }: LoaderFunctionArgs) {
  const { supabaseClient } = createSupabaseServerClient(request)

  const { data, error } = await supabaseClient.from('company').select(`
    *,
    emissions:emission(*),
    targets:target(*),
    commitment:commitment(*)
  `).eq('company_name', fromSlug(params.company))

  return {
    data,
    error,
  }

}
