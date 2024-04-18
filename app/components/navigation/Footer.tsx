import { Box, Typography, Link } from '@mui/material';

function Footer() {
  return (
    <Box sx={{ bgcolor: 'primary.main', p: 2, mt: 'auto', color: 'white' }}>
      <Typography variant="h6">ClimateWiki</Typography>
      <Typography variant="body1">
        <Link href="#" color="secondary">About</Link>{' '}
        <Link href="#" color="secondary">Contact</Link>{' '}
        <Link href="#" color="secondary">Follow</Link>
      </Typography>
      <Typography variant="body2">hello@climatewiki.io</Typography>
      <Typography variant="body2">+46 (8) 880 880</Typography>
    </Box>
  );
}

export default Footer;
