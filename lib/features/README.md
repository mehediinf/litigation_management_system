# Banking MVVM Feature Structure

Each banking feature follows this structure:

```text
features/
  feature_name/
    data/
      datasources/
      models/
      repositories/
    domain/
      entities/
      repositories/
      usecases/
    presentation/
      viewmodels/
      views/
      widgets/
```

Recommended feature modules for this banking app:

- `auth`: login, registration, OTP, biometrics, device binding
- `accounts`: savings/current account summary and details
- `transactions`: transaction history, filters, statements
- `cards`: debit/credit card controls and limits
- `payments`: bill pay, transfers, QR and merchant payments
- `beneficiaries`: saved payees and bank recipients
- `loans`: loan accounts, EMI, schedules, dues
- `notifications`: alerts, inbox, push preference
- `profile`: KYC info, personal details, security profile
- `settings`: app preferences, language, privacy, session management

Layer responsibilities:

- `data`: API/local storage adapters, DTO models, repository implementations
- `domain`: business entities, repository contracts, use cases
- `presentation`: Flutter UI, screen-specific widgets, and viewmodels

Suggested scaling rules:

- Keep one viewmodel per screen flow, not per widget
- Keep API response models inside `data/models`
- Never let UI import `data` directly; UI should depend on `domain` and `viewmodels`
- Put shared widgets in `lib/shared/widgets`
- Put app-wide services and utilities in `lib/core`
