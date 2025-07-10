# sherpa-observability/platform

IaC for our observability platforms: Coralogix, Checkly, PagerDuty

## Setup
After checking out the source code for the project run this to get common modules:
```bash
git submodule update --init --recursive
```

To update the version of modules-common that is used by the project run:
```bash
git submodule foreach git pull origin main
```

Create a `.env` file for configuration/secrets:
```bash
AWS_PROFILE=xxxxxxxxxx
CORALOGIX_API_KEY=cxup_xxxxxxxxxxxxxxxx
TF_VAR_checkly_api_key=cu_xxxxxxxxxxxxxxxx
TF_VAR_checkly_account_id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxxx
```

Initialize terraform:
```bash
bin/tf staging init
bin/tf production init
```
