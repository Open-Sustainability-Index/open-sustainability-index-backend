import { LoaderFunctionArgs } from '@remix-run/node';

export function authenticate({ request }: LoaderFunctionArgs): URL {
  const url = new URL(request.url);
  const apiKey = url.searchParams.get('api-key') ?? request.headers.get('authorization');
  if (!apiKey) {
    throw new Response(null, {
      status: 401,
      statusText: 'Unauthorized',
    });
  }
  return url;
}
