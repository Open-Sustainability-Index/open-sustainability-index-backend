import { createSupabaseServerClient } from '../supabase.server';
import { LoaderFunctionArgs } from "@remix-run/node";
import { authenticate } from '../lib/authenticate';

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
 *        description: Your unique key
 *        schema:
 *          type: string
 *          default: demo
 *      - in: query
 *        name: limit
 *        description: Max records to return
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
 *        description: Sort by this attribute value
 *        schema:
 *          type: string
 *      - in: query
 *        name: order
 *        description: Order the sorted results ascending or descending
 *        schema:
 *          type: string
 *          enum:
 *          - asc
 *          - desc
 *      - in: query
 *        name: industry
 *        description: Return only companies within this industry
 *        schema:
 *          type: string
 *      - in: query
 *        name: near-term
 *        description: Filter based on near-term status
 *        schema:
 *          type: string
 *      - in: query
 *        name: net-zero
 *        description: Filter based on net-zero status
 *        schema:
 *          type: string
 *     responses:
 *       200:
 *         description: Returns array of companies, their emissions, and targets
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 data:
 *                   type: array
 *                   description: List of companies, their emissions, and targets
 *                   items:
 *                     type: object
 *                     properties:
 *                       company_name:
 *                         type: string
 *                         description: The name of the company
 *                       industry:
 *                         type: string
 *                         description: The industry of the company
 *                       commitment_type:
 *                         type: string
 *                         description: The type of commitment
 *                       status:
 *                         type: string
 *                         description: The status of the commitment
 *                       commitment_deadline:
 *                         type: string
 *                         description: The deadline of the commitment
 *                       total_reported_emission_scope_1_2_3:
 *                         type: integer
 *                         description: Total reported emissions for scope 1, 2, and 3
 *                       revenue:
 *                         type: integer
 *                         description: The revenue of the company
 *                       hq_country_move:
 *                         type: string
 *                         description: The country where the company's headquarters are located
 *                       year:
 *                         type: integer
 *                         description: The year
 *                       currency:
 *                         type: string
 *                         description: The currency used
 *                       emission_intensity:
 *                         type: number
 *                         description: The emission intensity
 *                       targets:
 *                         type: array
 *                         description: List of targets set by the company
 *                         items:
 *                           type: object
 *                           properties:
 *                             target_type:
 *                               type: string
 *                               description: The type of target
 *                             target_scope:
 *                               type: string
 *                               description: The scope of the target
 *                             target_year:
 *                               type: integer
 *                               description: The year of the target
 *                             target:
 *                               type: string
 *                               description: The target itself
 *                 error:
 *                   type: object
 *                   description: Error object if there is any issue with the request
 */

export async function loader ({ request }: { LoaderFunctionArgs }) {
  const url = authenticate({ request });

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
