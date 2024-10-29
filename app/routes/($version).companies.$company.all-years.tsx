import { LoaderFunctionArgs } from '@remix-run/node';
import { authenticate } from '../lib/authenticate';
import { createSupabaseServerClient } from '../supabase.server';

export async function loader({ params, request }: LoaderFunctionArgs) {
  authenticate({ request });
  const { supabaseClient } = createSupabaseServerClient(request);

  let dataWithName = {};
  let error = null;

  const fields = `
  *,
  emissions:view_emission(*),
  targets:target(*),
  commitment:commitment(*)
`;
  const { data: dataNewSlug, error: errorNewSlug } = await supabaseClient
    .from('view_company_slug')
    .select(fields)
    .eq('slug', params.company)
    .single();
  dataWithName = {
    company_name: dataNewSlug?.name,
    ...dataNewSlug,
  };
  error = errorNewSlug;

  if (errorNewSlug?.code === 'PGRST116') {
    const { data: dataOldSlug, error: errorOldSlug } = await supabaseClient
      .from('view_company_slug')
      .select(fields)
      .eq('slug_old', params.company)
      .single();
    dataWithName = {
      slug_new: dataOldSlug?.slug,
      company_name: dataOldSlug?.name,
      ...dataOldSlug,
    };
    error = errorOldSlug;
  }

  return {
    data: dataWithName,
    error,
  };
}
