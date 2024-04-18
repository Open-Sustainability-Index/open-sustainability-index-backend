import { AccessSpreadsheet } from '../services/AccessSpreadsheet';

export async function loader () {
  const { data: sheetData, error } = await AccessSpreadsheet();
  const headers = sheetData?.values[0]

  const data = sheetData?.values.map(value => {
    return {
      [headers[1]]: value[1],
      [headers[2]]: value[2],
      [headers[3]]: value[3],
    }
  })

  return {
    data,
    error,
  }
}
