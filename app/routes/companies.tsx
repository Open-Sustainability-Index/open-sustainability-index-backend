import { createSupabaseServerClient } from '../supabase.server';
import { AccessSpreadsheet } from '../services/AccessSpreadsheet';
import { LoaderFunctionArgs } from "@remix-run/node";

export async function loader ({ request }: { LoaderFunctionArgs }) {
  const url = new URL(request.url)
  const limitQueryString = url.searchParams.get('limit')
  const offsetQueryString = url.searchParams.get('offset')
  const nameQueryString = url.searchParams.get('name')
  const limit = limitQueryString ? parseInt(limitQueryString) : 0
  const offset = offsetQueryString ? parseInt(offsetQueryString) : 0

  const { supabaseClient } = createSupabaseServerClient(request)

  const { data, error } = await supabaseClient.from('company').select('company_name, industry, emission(year)')

  return {
    data,
    error,
  }
}
