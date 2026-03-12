import postgres from 'postgres';
import fs from 'fs';
import path from 'path';

const sqlScript = fs.readFileSync(path.join(process.cwd(), 'supabase_schema_seed.sql'), 'utf8');

const pass = encodeURIComponent('f$-s@!D#6,bDPKb');

// Supabase's IPv4 connection string format:
// postgres://postgres:[YOUR-PASSWORD]@db.wictlliqcshgrpvbyhxj.supabase.co:5432/postgres
const connectionString = `postgresql://postgres:${pass}@db.wictlliqcshgrpvbyhxj.supabase.co:5432/postgres`;

const sql = postgres(connectionString, {
  ssl: 'require' // Disable strict SSL for this script just in case
});

async function run() {
  try {
    console.log('Connecting to Supabase at db.wictlliqcshgrpvbyhxj.supabase.co...');
    await sql.unsafe(sqlScript);
    console.log('Successfully created tables and seeded data!');
  } catch (err) {
    console.error('Error running setup:', err);
  } finally {
    await sql.end();
  }
}

run();
