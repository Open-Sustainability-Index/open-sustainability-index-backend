import { createSupabaseServerClient } from '../supabase.server';
import { LoaderFunctionArgs } from "@remix-run/node";
import { authenticate } from '../lib/authenticate';

export async function loader ({ request }: { LoaderFunctionArgs }) {
  authenticate({ request })
  // const url = new URL(request.url)
  // const sort_by = url.searchParams.get('sort') ?? undefined
  // const sort_order = url.searchParams.get('order') ?? undefined

  const { supabaseClient } = createSupabaseServerClient(request)
  const { data, error } = await supabaseClient
    .from('industry')
    .select('*')

  return {
    data,
    error,
  }
}
