import { google } from 'googleapis'
import { LoaderFunctionArgs } from 'node_modules/@remix-run/node/dist/index';

export type GoogleSheetResponse = {
  config: Config;
  data: Data;
  headers: GeoIPResponseHeaders;
  status: number;
  statusText: string;
  request: Request;
}

export type Config = {
  url: string;
  method: string;
  userAgentDirectives: UserAgentDirective[];
  headers: ConfigHeaders;
  params: Params;
  retry: boolean;
  responseType: string;
}

export type ConfigHeaders = {
  "x-goog-api-client": string;
  "Accept-Encoding": string;
  "User-Agent": string;
  Authorization: string;
  Accept: string;
}

export type Params = {
}

export type UserAgentDirective = {
  product: string;
  version: string;
  comment: string;
}

export type Data = {
  range: string;
  majorDimension: string;
  values: Array<string[]>;
}

export type GeoIPResponseHeaders = {
  "alt-svc": string;
  "cache-control": string;
  "content-encoding": string;
  "content-type": string;
  date: string;
  server: string;
  "transfer-encoding": string;
  vary: string;
  "x-content-type-options": string;
  "x-frame-options": string;
  "x-l2-request-path": string;
  "x-xss-protection": string;
}

export type Request = {
  responseURL: string;
}


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
    const response: GoogleSheetResponse = await sheets.spreadsheets.values.get({
      auth,
      spreadsheetId,
      range,
    })

    return {
      data: response.data
    }
    console.log(response.data);
  } catch (error) {
    console.error('The API returned an error: ' + error);
    return { error }
  }
}


export async function loader ({ params }: LoaderFunctionArgs) {
  // Call the function
  const { data, error } = await accessSpreadsheet();

  return {
    data: {
      company: params.company,
      ...data,
    },
    error
  }
}

export type loaderType = typeof loader
