import { createSupabaseServerClient } from '../supabase.server';
import { LoaderFunctionArgs } from "@remix-run/node";
import { authenticate } from '../lib/authenticate';

export async function loader ({ request }: { LoaderFunctionArgs }) {
  const url = authenticate({ request });

  const limitQueryString = url.searchParams.get('limit')
  const offsetQueryString = url.searchParams.get('offset')
  const sortByQueryString = url.searchParams.get('sort')
  const sortOrderQueryString = url.searchParams.get('order')
  const filterIndustry = url.searchParams.get('industry')
  const filterNearTerm = url.searchParams.get('near-term')
  const filterNetZero = url.searchParams.get('net-zero')
  const emissions_required = url.searchParams.get('emissions')

  const limit_value = limitQueryString ? parseInt(limitQueryString) : 99
  const offset_value = offsetQueryString ? parseInt(offsetQueryString) : 0
  const sort_by = sortByQueryString ?? 'lower(name)'
  const sort_order = sortOrderQueryString ?? 'asc'
  const industry_filter = filterIndustry
  const near_term_filter = filterNearTerm?.toLowerCase() === 'commited'

  let commitment_type_filter,
    commitment_status_filter,
    target_target_filter
  if (filterNetZero) {
    commitment_type_filter = 'Net-zero'
    commitment_status_filter = filterNetZero
  }
  if (filterNearTerm && !near_term_filter) {
    if (filterNearTerm.toLowerCase() === 'removed') {
      commitment_status_filter = 'Removed'
    } else {
      target_target_filter = 'Near-term'
    }
  }

  const { supabaseClient } = createSupabaseServerClient(request)
  const { data, error } = await supabaseClient
    .rpc('companies_v2', {
      limit_value,
      offset_value,
      sort_by,
      sort_order,
      industry_filter,
      near_term_filter,
      commitment_type_filter,
      commitment_status_filter,
      target_target_filter,
      emissions_required,
    })

  return {
    data,
    error,
  }
}
