import { createSupabaseServerClient } from '../supabase.server';
import { LoaderFunctionArgs } from '@remix-run/node';
import { authenticate } from '../lib/authenticate';

/**
 * @openapi
 * /v1/search:
 *   get:
 *     description: Search for companies/industries by name
 *     tags:
 *       - Search
 *     parameters:
 *       - in: query
 *         name: query
 *         required: true
 *         description: The search query string
 *         schema:
 *           type: string
 *       - in: query
 *         name: sort
 *         required: false
 *         description: Sort field for the search results
 *         schema:
 *           type: string
 *       - in: query
 *         name: order
 *         required: false
 *         description: Sort order for the search results
 *         schema:
 *           type: string
 *           enum:
 *             - asc
 *             - desc
 *       - in: query
 *         name: api-key
 *         required: true
 *         description: Your API key
 *         schema:
 *           type: string
 *           default: demo
 *     responses:
 *       200:
 *         description: Returns a list of companies/industries matching the search query
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 data:
 *                   type: array
 *                   description: List of companies/industries matching the search query
 *                   items:
 *                     type: object
 *                     properties:
 *                       name:
 *                         type: string
 *                         description: The name of the company/industry
 *                       slug:
 *                         type: string
 *                         description: The slug of the company/industry
 *                       type:
 *                         type: string
 *                         description: Type of the entity (e.g. company/industry)
 *                 error:
 *                   type: object
 *                   description: Error object if there is any issue with the request
 */

export async function loader({ request }: LoaderFunctionArgs) {
  const url = authenticate({ request });
  const query = url.searchParams.get('query');
  const sort_by = url.searchParams.get('sort') ?? undefined;
  const sort_order = url.searchParams.get('order') ?? undefined;

  const { supabaseClient } = createSupabaseServerClient(request);
  const { data, error } = await supabaseClient.rpc('search', {
    query,
    sort_by,
    sort_order,
  });

  return {
    data,
    error,
  };
}
