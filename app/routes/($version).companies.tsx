import { createSupabaseServerClient } from '../supabase.server';
import { LoaderFunctionArgs } from '@remix-run/node';
import { authenticate } from '../lib/authenticate';

export async function loader({ request }: LoaderFunctionArgs) {
  const url = authenticate({ request });

  const limitQueryString = url.searchParams.get('limit');
  const limit_value = limitQueryString ? parseInt(limitQueryString) : 99;
  const offsetQueryString = url.searchParams.get('offset');
  const offset_value = offsetQueryString ? parseInt(offsetQueryString) : 0;

  const sort_by = url.searchParams.get('sort') ?? 'lower(name)';
  const sort_order = url.searchParams.get('order') ?? 'asc';

  const industry_filter = url.searchParams.get('industry') ?? undefined;

  const filterNetZero = url.searchParams.get('net-zero');
  const filterNearTerm = url.searchParams.get('near-term');
  const near_term_filter = filterNearTerm?.toLowerCase() === 'commited';

  const emissions_required = url.searchParams.get('required')?.includes('emissions')
    ? 'required'
    : undefined;

  const tags_filter = url.searchParams.get('tags') ?? undefined;

  let commitment_type_filter, commitment_status_filter, target_target_filter;
  if (filterNetZero) {
    commitment_type_filter = 'Net-zero';
    commitment_status_filter = filterNetZero;
  }
  if (filterNearTerm && !near_term_filter) {
    if (filterNearTerm.toLowerCase() === 'removed') {
      commitment_status_filter = 'Removed';
    } else {
      target_target_filter = 'Near-term';
    }
  }

  const { supabaseClient } = createSupabaseServerClient(request);
  const { data, error } = await supabaseClient.rpc('companies_v2', {
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
    tags_filter,
  });

  return {
    data,
    error,
  };
}
