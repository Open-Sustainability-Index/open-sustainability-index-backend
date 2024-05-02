import { createSupabaseServerClient } from '../supabase.server';
import { LoaderFunctionArgs } from "@remix-run/node";

export async function loader ({ request }: { LoaderFunctionArgs }) {
  const url = new URL(request.url)
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
