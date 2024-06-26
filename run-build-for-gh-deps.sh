cd node_modules/@edx/
rm -rf frontend-platform
git clone -b dcoa/design-tokens-support --single-branch https://github.com/eduNEXT/frontend-platform.git
cd frontend-platform
npm ci
npm run build

cp -a dist/. ../frontend-platform/
cd ..
find frontend-platform -mindepth 1 -maxdepth 1 ! -name 'dist' -delete
mv frontend-platform/dist/* frontend-platform/
rm -rf frontend-platform/dist
cd ../..

cd node_modules/@openedx/
rm -rf frontend-build
git clone -b dcoa/design-tokens-support --single-branch https://github.com/eduNEXT/frontend-build.git
cd frontend-build
npm ci

cp -a dist/. ../frontend-build-dist
cd ..
cp -a frontend-build-dist/. frontend-build/
rm -rf frontend-build-dist
cd ../..

cd node_modules/@openedx/
rm -rf paragon
mkdir -p paragon
cd paragon
npm pack @openedx/paragon@23.0.0-alpha.2
tar -xzf openedx-paragon-23.0.0-alpha.2.tgz --strip-components=1
rm openedx-paragon-23.0.0-alpha.2.tgz
cd ../../..

cd node_modules/@edx/
rm -rf frontend-component-header
git clone -b Peter_Kulko/support-design-tokens --single-branch https://github.com/PKulkoRaccoonGang/frontend-component-header.git
cd frontend-component-header
npm i --force
npm run build
cd ../../..

fedx-scripts webpack
