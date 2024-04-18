import {
  Outlet,
} from "@remix-run/react";

export default function App () {
  return (
    <html>
      <head>
      </head>
      <body>
        <Outlet />
      </body>
    </html>
  );
}
