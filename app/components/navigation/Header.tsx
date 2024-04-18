import { AppBar, Toolbar, Typography, Button, Box, Link } from '@mui/material';

function Header() {
  return (
    <AppBar position="sticky" sx={{ bgcolor: 'primary.main' }}>
      <Toolbar>
        <Typography variant="h6" color="inherit" noWrap sx={{ flexGrow: 1 }}>
          ClimateWiki
        </Typography>
        <Box sx={{ display: 'flex', alignItems: 'center', color: 'white' }}>
          <Link href="#" color="secondary" sx={{ margin: 1 }}>Companies</Link>
          <Link href="#" color="secondary" sx={{ margin: 1 }}>Industries</Link>
          <Link href="#" color="secondary" sx={{ margin: 1 }}>Countries</Link>
          <Link href="#" color="secondary" sx={{ margin: 1 }}>Partners</Link>
          <Link href="#" color="secondary" sx={{ margin: 1 }}>About</Link>
          <Link href="#" color="secondary" sx={{ margin: 1 }}>API</Link>
          <Link href="#" color="secondary" sx={{ margin: 1 }}>FAQ</Link>
          <Link href="#" color="secondary" sx={{ margin: 1 }}>Governance</Link>
          <Button variant="contained" color="secondary" sx={{ marginLeft: 2 }}>
            Report Emissions
          </Button>
        </Box>
      </Toolbar>
    </AppBar>
  );
}

export default Header;
