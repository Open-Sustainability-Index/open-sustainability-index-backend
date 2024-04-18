import { HeadersFunction } from '@remix-run/node';
import { google } from 'googleapis'


export const headers: HeadersFunction = () => ({
  "Cache-Control": "max-age=0, s-maxage=3600",
});

// Specify the scopes needed
const SCOPES = ['https://www.googleapis.com/auth/spreadsheets'];

// Initialize the auth client
const auth = new google.auth.JWT({
  email: process.env.GOOGLE_API_EMAIL,
  key: process.env.GOOGLE_API_KEY.replace(/\\n/g, '\n'),
  scopes: SCOPES
});

// Function to authenticate and access the Sheets API
async function accessSpreadsheet () {
  const sheets = google.sheets({ version: 'v4', auth });
  const spreadsheetId = '1f_TkKzFUN_oABqHxL4mjrmeLlESU9pEeoOphhP8X2Oo';

  // Example: Read from the spreadsheet
  const range = 'Company Emissions Database!A:AZ';
  try {
    const response = await sheets.spreadsheets.values.get({
      auth,
      spreadsheetId,
      range,
    })

    return { data: response }
    console.log(response.data);
  } catch (error) {
    console.error('The API returned an error: ' + error);
    return { error }
  }
}


export async function loader () {
  // Call the function
  return accessSpreadsheet();
}
