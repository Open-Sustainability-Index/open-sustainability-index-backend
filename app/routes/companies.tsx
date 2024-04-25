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

  const { data, error } = await supabaseClient.from('company').select('company_name, emissions:emission("total_reported_emission_scope_1+2+3",revenue,hq_country_move),commitment(commitment_type,status,commitment_deadline),targets:target(target,type,target_year,scope)')

  return {
    data,
    error,
  }
}
