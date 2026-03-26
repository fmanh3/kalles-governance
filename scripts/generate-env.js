const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

// 1. Kör terraform output
console.log('Hämtar data från Terraform...');
const tfDir = path.join(__dirname, '../infrastructure/gcp');

let tfOutput;
try {
  const outputRaw = execSync('terraform output -json', { cwd: tfDir, encoding: 'utf-8' });
  tfOutput = JSON.parse(outputRaw);
} catch (error) {
  console.error('Kunde inte köra "terraform output". Har du kört "terraform apply" ännu?');
  process.exit(1);
}

const projectId = tfOutput.project_id?.value;

if (!projectId) {
  console.error('Kunde inte hitta project_id i Terraform outputs.');
  process.exit(1);
}

// Hjälpfunktion för att uppdatera en .env-fil säkert
function updateEnvFile(filePath, newVars) {
  let content = '';
  if (fs.existsSync(filePath)) {
    content = fs.readFileSync(filePath, 'utf-8');
  }

  const lines = content.split('\n');
  const envMap = {};
  
  // Parsa befintliga
  lines.forEach(line => {
    const match = line.match(/^([^=]+)=(.*)$/);
    if (match) {
      envMap[match[1].trim()] = match[2].trim();
    }
  });

  // Skriv över/lägg till nya
  for (const [key, value] of Object.entries(newVars)) {
    envMap[key] = value;
  }

  // Generera ny filtext
  const newContent = Object.entries(envMap)
    .map(([k, v]) => `${k}=${v}`)
    .join('\n') + '\n';

  fs.writeFileSync(filePath, newContent);
  console.log(`Uppdaterade ${filePath}`);
}

// 2. Kalles Finance .env
const financeEnvPath = path.join(__dirname, '../../kalles-finance/.env');
updateEnvFile(financeEnvPath, {
  'GOOGLE_CLOUD_PROJECT': projectId,
  'DB_HOST': '127.0.0.1', // Standard om Cloud SQL Auth Proxy körs lokalt
  'DB_PORT': '5432',
  'DB_USER': tfOutput.finance_db_user?.value || 'finance-user',
  'DB_PASSWORD': tfOutput.finance_db_password?.value || '',
  'DB_NAME': 'kalles-finance',
  'CLOUD_SQL_CONNECTION_NAME': tfOutput.finance_db_connection_name?.value || ''
});

// 3. Kalles HR .env
const hrEnvPath = path.join(__dirname, '../../kalles-hr/.env');
updateEnvFile(hrEnvPath, {
  'GOOGLE_CLOUD_PROJECT': projectId,
  'DB_HOST': '127.0.0.1', 
  'DB_PORT': '5433', // Exempel: Port 5433 för HR om du kör två Cloud SQL Auth Proxies
  'DB_USER': tfOutput.hr_db_user?.value || 'hr-user',
  'DB_PASSWORD': tfOutput.hr_db_password?.value || '',
  'DB_NAME': 'kalles-hr',
  'CLOUD_SQL_CONNECTION_NAME': tfOutput.hr_db_connection_name?.value || ''
});

// 4. Kalles Traffic .env
const trafficEnvPath = path.join(__dirname, '../../kalles-traffic/.env');
updateEnvFile(trafficEnvPath, {
  'GOOGLE_CLOUD_PROJECT': projectId
});

console.log('\nKlart! Lokala .env-filer är nu uppdaterade (utan att röra rot-miljön).');
console.log('OBS: För att köra mot Cloud SQL lokalt behöver du köra Cloud SQL Auth Proxy:');
console.log(`  ./cloud-sql-proxy ${tfOutput.finance_db_connection_name?.value} --port 5432`);