import { LoaderFunctionArgs } from '@remix-run/node';
import { authenticate } from '../lib/authenticate';
import { createSupabaseServerClient } from '../supabase.server';

/**
 * @openapi
 * /v1/companies/{company}:
 *   get:
 *     description: Get details of a specific company by its slug
 *     tags:
 *       - Companies
 *     parameters:
 *       - in: path
 *         name: company
 *         required: true
 *         description: Company slug
 *         schema:
 *           type: string
 *       - in: query
 *         name: api-key
 *         required: true
 *         description: your unique key
 *         schema:
 *           type: string
 *           default: demo
*     responses:
 *       200:
 *         description: Returns details of the specified company including emissions, targets, and commitments
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 company_name:
 *                   type: string
 *                   description: The name of the company
 *                 industry:
 *                   type: string
 *                   description: The industry of the company
 *                 isic:
 *                   type: string
 *                   description: The ISIC (International Standard Industrial Classification) of the company
 *                 lei:
 *                   type: string
 *                   description: Legal Entity Identifier (LEI) of the company
 *                 company_url:
 *                   type: string
 *                   description: URL of the company's website
 *                 source_reports_page:
 *                   type: string
 *                   description: URL of the page containing source reports
 *                 sbt_status:
 *                   type: string
 *                   description: Status of the Science Based Targets (SBT) initiative
 *                 sbt_near_term_year:
 *                   type: string
 *                   description: Near-term year for SBT
 *                 sbt_near_term_target:
 *                   type: string
 *                   description: Near-term target for SBT
 *                 net_zero_year:
 *                   type: string
 *                   description: Year of net-zero commitment
 *                 slug:
 *                   type: string
 *                   description: Company slug
 *                 emissions:
 *                   type: array
 *                   description: List of emissions data
 *                   items:
 *                     type: object
 *                     properties:
 *                       year:
 *                         type: integer
 *                         description: The year of emissions data
 *                       status:
 *                         type: string
 *                         description: Status of emissions
 *                       revenue:
 *                         type: number
 *                         description: Revenue of the company
 *                       scope_1:
 *                         type: number
 *                         description: Scope 1 emissions
 *                       currency:
 *                         type: string
 *                         description: Currency of revenue
 *                       fiscal_year:
 *                         type: string
 *                         description: Fiscal year
 *                       company_name:
 *                         type: string
 *                         description: The name of the company
 *                       total_scope_3:
 *                         type: string
 *                         description: Total scope 3 emissions
 *                       cradle_to_gate:
 *                         type: number
 *                         description: Cradle-to-gate emissions
 *                       hq_country_move:
 *                         type: string
 *                         description: HQ country movement
 *                       scope_2_location_based:
 *                         type: string
 *                         description: Location-based scope 2 emissions
 *                       source_emission_link:
 *                         type: string
 *                         description: URL of the source emission link
 *                       source_emission_report:
 *                         type: string
 *                         description: URL of the source emission report
 *                       total_reported_emission_scope_1_2:
 *                         type: number
 *                         description: Total reported emissions for scope 1 and 2
 *                       total_reported_emission_scope_1_2_3:
 *                         type: number
 *                         description: Total reported emissions for scope 1, 2, and 3
 *                 targets:
 *                   type: array
 *                   description: List of emission reduction targets
 *                   items:
 *                     type: object
 *                     properties:
 *                       lei:
 *                         type: string
 *                         description: Legal Entity Identifier (LEI) of the company
 *                       type:
 *                         type: string
 *                         description: Type of target
 *                       scope:
 *                         type: string
 *                         description: Scope of target
 *                       action:
 *                         type: string
 *                         description: Action related to the target
 *                       target_year:
 *                         type: integer
 *                         description: Year of the target
 *                       company_name:
 *                         type: string
 *                         description: The name of the company
 *                       target_value:
 *                         type: string
 *                         description: Value of the target
 *                       date_published:
 *                         type: string
 *                         description: Date when the target was published
 *                 commitment:
 *                   type: object
 *                   description: Commitment details
 *                   properties:
 *                     lei:
 *                       type: string
 *                       description: Legal Entity Identifier (LEI) of the company
 *                     action:
 *                       type: string
 *                       description: Action related to the commitment
 *                     status:
 *                       type: string
 *                       description: Status of the commitment
 *                     year_type:
 *                       type: string
 *                       description: Type of year
 *                     date_published:
 *                       type: string
 *                       description: Date when the commitment was published
 *                     commitment_type:
 *                       type: string
 *                       description: Type of commitment
 *                     commitment_deadline:
 *                       type: string
 *                       description: Deadline for the commitment
 */

export async function loader ({ params, request }: LoaderFunctionArgs) {
  authenticate({ request })
  const { supabaseClient } = createSupabaseServerClient(request)

  let dataWithName = {}
  let error = null

  const fields = `
  *,
  emissions:emission(*),
  targets:target(*),
  commitment:commitment(*)
`
  const { data: dataNewSlug, error: errorNewSlug } = await supabaseClient.from('view_company_slug')
    .select(fields).eq('slug', params.company).single()
  dataWithName = {
    company_name: dataNewSlug?.name,
    ...dataNewSlug
  }
  error = errorNewSlug
  
  if (errorNewSlug?.code === 'PGRST116') {
    const { data: dataOldSlug, error: errorOldSlug } = await supabaseClient.from('view_company_slug')
      .select(fields).eq('slug_old', params.company).single()
    dataWithName = {
      slug_new: dataOldSlug?.slug,
      company_name: dataOldSlug?.name,
      ...dataOldSlug
    }
    error = errorOldSlug
  }

  return {
    data: dataWithName,
    error,
  }
}
