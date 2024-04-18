import {
  Links,
  LinksFunction,
  Meta,
  Outlet,
  Scripts,
} from "@remix-run/react";
import { ThemeProvider } from '@mui/material/styles'
import CssBaseline from '@mui/material/CssBaseline'
import Container from '@mui/material/Container'

import theme from './theme/theme'
import styles from "./theme/global.css?url"
import Header from './components/navigation/Header';
import Footer from './components/navigation/Footer';

export const links: LinksFunction = () => [
  { rel: "stylesheet", href: 'https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap' },
  { rel: "stylesheet", href: styles },
];

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
          <CssBaseline />
          <Header />
          <Container>
            <Outlet />
          </Container>
          <Footer />
        </ThemeProvider>

        <Scripts />
      </body>
    </html>
  );
}
