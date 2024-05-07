import { createSupabaseServerClient } from '../supabase.server';
import { LoaderFunctionArgs } from "@remix-run/node";

/**
 * @openapi
 * /v1/companies:
 *   get:
 *     description: Get companies
 *     tags:
 *       - Companies
 *     parameters:
 *      - in: query
 *        name: api-key
 *        required: true
 *        description: your unique key
 *        schema:
 *          type: string
 *          default: demo
 *      - in: query
 *        name: limit
 *        description: max records to return
 *        schema:
 *          type: integer
 *          default: 99
 *      - in: query
 *        name: offset
 *        description: Number of items to skip, used for pagination
 *        schema:
 *          type: integer
 *          default: 0
 *      - in: query
 *        name: sort
 *        description: sort by this attribute value
 *        schema:
 *          type: string
 *      - in: query
 *        name: order
 *        description: order the sorted results ascending or descending
 *        schema:
 *          type: string
 *          enum:
 *          - asc
 *          - desc
 *      - in: query
 *        name: industry
 *        description: return only companies within this industry
 *        schema:
 *          type: string
 *      - in: query
 *        name: near-term
 *        description: filter based on near-term status
 *        schema:
 *          type: string
 *      - in: query
 *        name: net-zero
 *        description: filter based on net-zero status
 *        schema:
 *          type: string
 *     responses:
 *       200:
 *         description: Returns array companies, their emissions, and targets
 */

export async function loader ({ request }: { LoaderFunctionArgs }) {
  const url = new URL(request.url)
  const limitQueryString = url.searchParams.get('limit')
  const offsetQueryString = url.searchParams.get('offset')
  const sortByQueryString = url.searchParams.get('sort')
  const sortOrderQueryString = url.searchParams.get('order')
  const filterIndustry = url.searchParams.get('industry')
  const filterNearTerm = url.searchParams.get('near-term')
  const filterNetZero = url.searchParams.get('net-zero')

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
    .rpc('companies', {
      limit_value,
      offset_value,
      sort_by,
      sort_order,
      industry_filter,
      near_term_filter,
      commitment_type_filter,
      commitment_status_filter,
      target_target_filter,
    })

  return {
    data,
    error,
  }
}
