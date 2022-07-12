Pixie-cloud chart
---
1. Install dependencies:
```
helm dependency update
```
2. Generate secrets f.e. using cloud_secrets.sh
3. Install the chart:
```
helm install pixie-cloud ./ --namespace plc --create-namespace
```