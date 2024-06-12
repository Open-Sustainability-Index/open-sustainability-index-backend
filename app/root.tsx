import { Outlet } from '@remix-run/react';

export default function App(): JSX.Element {
  return (
    <html>
      <head></head>
      <body>
        <Outlet />
      </body>
    </html>
  );
}
