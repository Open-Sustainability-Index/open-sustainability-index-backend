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

  const uniqueItems = {};
  data.forEach(item => {
    if (!uniqueItems[item.Name]) {
      uniqueItems[item.Name] = {
        Name: item.Name,
        Industry: item.Industry,
        Year: [item.Year]
      };
    } else {
      if (!uniqueItems[item.Name].Year.includes(item.Year)) {
        uniqueItems[item.Name].Year.push(item.Year);
      }
    }
  });

  const deduplicatedArray = Object.values(uniqueItems);

  return {
    data: deduplicatedArray,
    error,
  }
}
