import { LoaderFunctionArgs } from '@remix-run/node';
import { fromSlug } from '../utils/fromSlug';
import { AccessSpreadsheet } from '../services/AccessSpreadsheet';

export async function loader ({ params, request }: LoaderFunctionArgs) {
  const year = new URL(request.url).searchParams.get('year');
  const { data: sheetData, error } = await AccessSpreadsheet({
    spreadsheetId: process.env.EMISSIONS_DB_ID,
    range: process.env.EMISSIONS_DB_RANGE,
  });
  const headers = sheetData?.values[0]
  const companies = sheetData?.values.filter(value => value[2].toLowerCase() === fromSlug(params.company))

  const data = companies?.map(company =>
    company?.reduce((obj, dataPoint, index) => {
      obj[headers[index]] = dataPoint, {}
      return obj
    }, {})
  ).sort((a, b) => parseInt(b.Year) - parseInt(a.Year))

  if (year) {
    const report = data?.find(report => report.Year === year)
    if (report) return {
      data: report,
      error
    }
    throw new Response("Not Found", {
      status: 404,
    });
  }

  if (data?.length) {
    return {
      data: data[0],
      error,
    }
  }

  throw new Response("Not Found", {
    status: 404,
  });
}
