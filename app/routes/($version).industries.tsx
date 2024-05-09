import { createSupabaseServerClient } from '../supabase.server';
import { LoaderFunctionArgs } from "@remix-run/node";
import { authenticate } from '../lib/authenticate';

/**
 * @openapi
 * /v1/industries:
 *   get:
 *     description: Get a list of industries
 *     tags:
 *       - Industries
 *     parameters:
 *       - in: query
 *         name: api-key
 *         required: true
 *         description: Your API key
 *         schema:
 *           type: string
 *           default: demo
 *     responses:
 *       200:
 *         description: Returns a list of industries
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 data:
 *                   type: array
 *                   description: List of industries
 *                   items:
 *                     type: object
 *                     properties:
 *                       name:
 *                         type: string
 *                         description: The name of the industry
 *                       slug:
 *                         type: string
 *                         description: The slug of the industry
 *                       company_count:
 *                         type: integer
 *                         description: Number of companies in the industry
 *                 error:
 *                   type: object
 *                   description: Error object if there is any issue with the request
 */

export async function loader ({ request }: { LoaderFunctionArgs }) {
  authenticate({ request })
  // const url = new URL(request.url)
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
