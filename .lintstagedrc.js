module.exports = {
  '*.js': 'npx eslint --cache',
  'package.json': [
    'npx fixpack',
    'npx prettier --parser json-stringify --write',
    'git diff --exit-code --quiet'
  ],
  'package-lock.json': 'node -e "process.exitCode = 1;"'
};
