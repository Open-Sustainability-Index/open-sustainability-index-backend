import {
  Links,
  Meta,
  Outlet,
  Scripts,
} from "@remix-run/react";
import { ThemeProvider } from '@mui/material/styles'
import Container from '@mui/material/Container'

import theme from './theme/theme'

export default function App() {
  return (
    <html>
      <head>
        <link
          rel="icon"
          href="data:image/x-icon;base64,AA"
        />
        <Meta />
        <Links />
      </head>
      <body>
        <ThemeProvider theme={theme}>
          <Outlet />
        </ThemeProvider>

        <Scripts />
      </body>
    </html>
  );
}
