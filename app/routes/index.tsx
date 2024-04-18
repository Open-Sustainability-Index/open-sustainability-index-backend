import { useState } from 'react'
import { Link, Outlet, useNavigate } from '@remix-run/react'
import { BasejumpUserSession, GetAccountResponse, SignedIn, SignedOut } from '@usebasejump/react'

import { createClient } from '~/@/utils/supabase/client'
import AccountSelector from '~/@/components/basejump/AccountSelector'
import UserAccountButton from '~/@/components/basejump/UserAccountButton'
import NavigationMenu from '~/components/NavigationMenu'
import Header from '~/components/Header'

export default function LoggedInLayout () {
  const [account, setAccount] = useState<GetAccountResponse>()
  const navigate = useNavigate()

  function selectAccount (selected: GetAccountResponse, navigateTo?: string) {
    setAccount(selected)
    if (navigateTo)
      navigate(navigateTo)
  }

  const supabase = createClient()!

  return (
    <div>
      <Header>
        <BasejumpUserSession supabaseClient={supabase}>
          <SignedIn>
            <div className='flex justify-between mb-4'>
              <AccountSelector accountId={account?.account_id} onAccountSelected={selectAccount} />
              <UserAccountButton />
            </div>
          </SignedIn>
          <SignedOut>
            <div className='p-2 px-4'>
              <Link to='/login'>Login</Link>
            </div>
          </SignedOut>
        </BasejumpUserSession>
      </Header>
      <div>
        <div className='flex flex-1 overflow-hidden'>
          <div className='w-64 p-4 overflow-auto'>
            <NavigationMenu isCollapsed={false} account={account} />
          </div>
          <main className='flex-1 p-4 overflow-auto'>
            <Outlet context={
              {
                supabase,
              }
            } />
          </main>
        </div>
      </div>
    </div>
  )
}
