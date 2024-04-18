import { AccessSpreadsheet } from '../services/AccessSpreadsheet';

export async function loader () {
  const { data: sheetData, error } = await AccessSpreadsheet();

  const data = sheetData?.values.map(value => {
    return {
      name: value[2],
      industry: value[3],
    }
  })

  return {
    data,
    error,
  }
}
