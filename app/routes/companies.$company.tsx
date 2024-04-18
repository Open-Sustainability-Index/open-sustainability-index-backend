import { HeadersFunction } from '@remix-run/node';
import { LoaderFunctionArgs } from '@remix-run/node';
import { AccessSpreadsheet } from '../services/AccessSpreadsheet';

export const headers: HeadersFunction = () => ({
  "Cache-Control": "max-age=0, s-maxage=3600",
});

export async function loader ({ params }: LoaderFunctionArgs) {
  const { data: sheetData, error } = await AccessSpreadsheet();
  const headers = sheetData?.values[0]
  const companies = sheetData?.values.filter(value => value[2].toLowerCase() === params.company.toLowerCase())

  const data = companies?.map(company =>
    company?.reduce((obj, dataPoint, index) => {
      obj[headers[index]] = dataPoint, {}
      return obj
    }, {})
  )

  return {
    data,
    error,
  }
}
