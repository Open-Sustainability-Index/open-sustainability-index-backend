import { HeadersFunction } from '@remix-run/node';
import { google } from 'googleapis'


export const headers: HeadersFunction = () => ({
  // Tell the browser to always check the freshness of the cache
  "Cache-Control": "public, max-age=0, must-revalidate",
  // Tell the CDN to treat it as fresh for 5 minutes, but for a week after that return a stale version while it revalidates
  "Netlify-CDN-Cache-Control": "public, s-maxage=300, stale-while-revalidate=604800",
});

// Specify the scopes needed
const SCOPES = ['https://www.googleapis.com/auth/spreadsheets'];

// Initialize the auth client
const auth = new google.auth.JWT({
  email: process.env.GOOGLE_API_EMAIL,
  key: process.env.GOOGLE_API_KEY,
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
