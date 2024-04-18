import { useLoaderData } from '@remix-run/react'
import { LoaderFunctionArgs } from 'node_modules/@remix-run/node/dist/index'
import { loaderType } from '../server/loaders/sheet'

export { loader } from '../server/loaders/sheet'

import { HeadersFunction } from '@remix-run/node';


export const headers: HeadersFunction = () => ({
  "Cache-Control": "max-age=0, s-maxage=3600",
});


export default function Company () {

  const {
    data,
    error,
  } = useLoaderData<loaderType>()

  const company = data.values.find(value =>
    value[2].toLowerCase() === data.company.toLowerCase()
  )



  return (
    <>
      {JSON.stringify(company)}
    </>
  )
}
