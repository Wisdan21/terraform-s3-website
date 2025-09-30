# Hosting av statisk nettside med Terraform og AWS

## Mål
Deploy en statisk nettside på AWS S3 ved hjelp av Terraform. Denne øvelsen dekker bruk av moduler fra Terraform Registry, håndtering av ressurser med AWS CLI, samt bruk av variabler og outputs i Terraform.

## Forberedelser

### Steg 0: Opprett GitHub Codespace fra din fork

1. **Fork dette repositoriet** til din egen GitHub-konto
2. **Åpne Codespace**: Klikk på "Code" → "Codespaces" → "Create codespace on main"
3. **Vent på at Codespace starter**: Dette kan ta et par minutter første gang
4. **Terminalvindu**: Du vil utføre de fleste kommandoer i terminalen som åpner seg nederst i Codespace

### Steg 1: Verifiser miljøet

Repositoriet er allerede klonet i ditt Codespace. Verifiser at du er i riktig mappe:

```bash
pwd
ls
```

Du skal se filene fra dette repositoriet, inkludert mappen `s3_demo_website`. 

### Steg 2: Terraform-konfigurasjon

1. **Opprett `main.tf`**: Definer infrastrukturen for å hoste nettsiden i en S3 bucket.

```hcl
module "website" {
   source = "github.com/glennbechdevops/s3-website-module?ref=1.1.0"
   bucket_name = var.bucket_name
}
```

Modulen er hentet fra: https://github.com/glennbechdevops/s3-website-module
Merk at vi bruker en spesifikk versjon (1.1.0) av modulen.

2. **Opprett `variables.tf`**: Definer nødvendige variabler.

```hcl
variable "bucket_name" {
  description = "The name of the bucket"
  type        = string
}
```

3. **Opprett `outputs.tf`**: Hent ut bucket-domenenavnet.

```hcl
output "website_url" {
  value = module.website.s3_website_url
}
```

### Steg 3: Deploy infrastrukturen

Erstatt `<unikt-bucket-navn>` med ditt eget unike navn (f.eks. dine initialer eller studentnummer).

```bash
terraform init
terraform apply -var 'bucket_name=<unikt-bucket-navn>'
```

**Merk**: Hvis du får en feilmelding om `AccessDenied` ved `PutBucketPolicy`, prøv kommandoen på nytt. Spør instruktør hvis du er nysgjerrig på hvorfor dette skjer.

### Steg 4: Last opp filer til S3

Bruk AWS CLI for å laste opp nettsidefilene til S3 bucketen:

```bash
aws s3 sync s3_demo_website s3://<unikt-bucket-navn>
```

### Steg 5: Inspiser bucketen i AWS Console

Gå til AWS Console og se på objekter og bucket-egenskaper for å forstå hvordan alt er satt opp.

### Steg 6: Åpne nettsiden

Hent URL-en til nettsiden:

```bash
terraform output website_url
```

Åpne URL-en i nettleseren for å se din statiske nettside.

### Bonusoppgave: Modifiser nettsiden

Prøv å endre HTML- og CSS-filene i `s3_demo_website`-mappen, og kjør sync-kommandoen på nytt for å se endringene:

```bash
aws s3 sync s3_demo_website s3://<unikt-bucket-navn>
```

## Oppsummering

Du har nå deployet og håndtert en statisk nettside på AWS ved hjelp av Terraform og AWS CLI.
