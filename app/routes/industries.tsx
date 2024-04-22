import { AccessSpreadsheet } from '../services/AccessSpreadsheet';

export async function loader () {
  const { data: sheetData, error } = await AccessSpreadsheet();

  const allIndustries = sheetData?.values.map(value =>
    value[3]
  )

  return {
    data: [...new Set(allIndustries)]
      .filter(value => value !== '' && value !== '#N/A')
      .sort(),
    error
  }
}
