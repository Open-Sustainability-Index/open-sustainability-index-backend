import { createSupabaseServerClient } from '../supabase.server';
import { LoaderFunctionArgs } from "@remix-run/node";

export async function loader ({ request }: { LoaderFunctionArgs }) {
  const url = new URL(request.url)
  const limitQueryString = url.searchParams.get('limit')
  const offsetQueryString = url.searchParams.get('offset')
  const sortByQueryString = url.searchParams.get('sort')
  const sortOrderQueryString = url.searchParams.get('order')

  const limit_value = limitQueryString ? parseInt(limitQueryString) : 99
  const offset_value = offsetQueryString ? parseInt(offsetQueryString) : 0
  const sort_by = sortByQueryString ?? 'lower(name)'
  const sort_order = sortOrderQueryString ?? 'asc'

  const { supabaseClient } = createSupabaseServerClient(request)
  const { data, error } = await supabaseClient
    .rpc('companies', {
      limit_value,
      offset_value,
      sort_by,
      sort_order,
    })

  return {
    data,
    error,
  }
}
