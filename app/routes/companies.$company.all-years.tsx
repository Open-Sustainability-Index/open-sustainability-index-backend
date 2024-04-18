import { LoaderFunctionArgs } from '@remix-run/node';
import { fromSlug } from '../utils/fromSlug';
import { AccessSpreadsheet } from '../services/AccessSpreadsheet';

export async function loader ({ params }: LoaderFunctionArgs) {
  const { data: sheetData, error } = await AccessSpreadsheet();
  const headers = sheetData?.values[0]
  const companies = sheetData?.values.filter(value => value[2].toLowerCase() === fromSlug(params.company))

  const data = companies?.map(company =>
    company?.reduce((obj, dataPoint, index) => {
      obj[headers[index]] = dataPoint, {}
      return obj
    }, {})
  ).sort((a, b) => parseInt(b.Year) - parseInt(a.Year))

  if (data?.length) {
    return {
      data: data,
      error,
    }
  }

  throw new Response("Not Found", {
    status: 404,
  });
}
