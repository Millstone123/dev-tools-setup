const { execSync } = require('child_process');

function verifySetup() {
  console.log('Verifying environment setup...');
  
  try {
    const nodeVersion = execSync('node --version', { encoding: 'utf8' }).trim();
    console.log(`Node.js: ${nodeVersion}`);
  } catch (e) {
    console.log('Node.js: not found');
  }
  
  try {
    const npmVersion = execSync('npm --version', { encoding: 'utf8' }).trim();
    console.log(`npm: ${npmVersion}`);
  } catch (e) {
    console.log('npm: not found');
  }
  
  console.log('Verification complete.');
}

verifySetup();
