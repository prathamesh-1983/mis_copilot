# MIS Copilot — AI-Powered Business Reporting Assistant

MIS Copilot is a full-stack hackathon project built with **Flutter**, **Serverpod**, **PostgreSQL**, and **Google Gemini**. It turns sales CSV data into key performance indicators (KPIs) and AI-generated management insights.

> **Status:** MVP / hackathon project. Check the exact Serverpod and dependency versions in your workspace; CLI commands and package APIs may vary by version.

## Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)
- [CSV Format](#csv-format)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Configure Gemini](#configure-gemini)
- [Database and Code Generation](#database-and-code-generation)
- [Run the Application](#run-the-application)
- [How to Use](#how-to-use)
- [API Methods](#api-methods)
- [Security Notes](#security-notes)
- [Troubleshooting](#troubleshooting)
- [Deployment](#deployment)
- [Roadmap](#roadmap)
- [License](#license)

## Overview

MIS Copilot helps reduce the manual effort involved in preparing management information system (MIS) reports. Users upload a sales CSV file, calculate summary metrics, save the report and its sales records, and request an AI-generated narrative with possible insights and actions.

AI-generated content should be reviewed by a person before being used for business decisions.

## Features

### MVP
- Upload a sales CSV file through the Flutter interface.
- Validate required CSV columns.
- Calculate total sales, total profit, average row-level sales value, top product, and top region.
- Store report summaries and sales records in PostgreSQL through Serverpod.
- Generate management insights with Google Gemini when configured.
- View the latest report on a dashboard.
- Browse previously saved reports.

### Planned
- Interactive charts and date/region/category filters.
- AI chat grounded in report data.
- Sales and profit anomaly detection.
- PDF/Excel export.
- Authentication and per-user permissions.
- Large-file processing and storage.
- Automated tests, monitoring, and production hardening.

## Architecture

```text
Flutter UI
   │
   │ Generated, typed Serverpod client
   ▼
Serverpod backend
   ├── CSV validation and parsing
   ├── KPI calculations
   ├── Report endpoints
   └── Gemini AI integration
          │
          ├──────────► Google Gemini API
          │
          ▼
       PostgreSQL
       ├── reports
       └── sales_records
```

Keep the Gemini API key on the server. Never embed it in Flutter code.

## Technology Stack

| Component | Technology |
|---|---|
| Frontend | Flutter / Dart |
| Backend | Serverpod / Dart |
| API communication | Generated Serverpod client |
| Database | PostgreSQL (local setup depends on Serverpod configuration) |
| AI | Google Gemini via a Dart AI integration |
| Input format | CSV |
| IDE | VS Code or Serverpod App Studio |
| Deployment | Serverpod Cloud (optional) |

## Project Structure

The exact structure depends on the Serverpod template/version. Intended source layout:

```text
mis_copilot/
├── mis_copilot_server/
│   ├── config/
│   │   └── passwords.yaml          # Local secrets; never commit
│   ├── lib/
│   │   └── src/
│   │       ├── models/
│   │       │   ├── report.spy.yaml
│   │       │   └── sales_record.spy.yaml
│   │       ├── reports/
│   │       │   └── report_endpoint.dart
│   │       └── generated/          # Generated; do not edit manually
│   └── pubspec.yaml
├── mis_copilot_client/             # Generated client package
├── mis_copilot_flutter/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── client.dart             # Keep template's client setup
│   │   └── screens/
│   │       ├── home_screen.dart
│   │       └── upload_screen.dart
│   └── pubspec.yaml
├── sample_data/
│   └── sales.csv
├── README.md
└── pubspec.yaml
```

Do not manually edit generated files unless your Serverpod version's documentation says to.

## CSV Format

The MVP expects a header row and at least one data row. At minimum, include `Product` and `Sales`.

| Column | Required? | Description |
|---|---|---|
| `Product` | Yes | Product or item name |
| `Sales` | Yes | Numeric sales/revenue amount |
| `Date` | No | Transaction/order date |
| `OrderId` | No | Order identifier |
| `Category` | No | Product category |
| `Region` | No | Sales region |
| `Quantity` | No | Units sold |
| `Profit` | No | Profit amount |

Example:

```csv
Date,OrderId,Product,Category,Region,Quantity,Sales,Profit
2026-09-01,ORD-1001,Laptop Stand,Accessories,West,2,80,24
2026-09-01,ORD-1002,Wireless Mouse,Accessories,North,3,75,30
2026-09-02,ORD-1003,Mechanical Keyboard,Accessories,West,1,120,42
2026-09-02,ORD-1004,Office Chair,Furniture,South,2,360,90
```

Use consistent numeric formats. The initial parser is basic; validate data carefully and avoid relying on it for complex locale-specific number formats.

## Prerequisites

Install versions supported by your Serverpod template:

- Git
- VS Code or Serverpod App Studio
- Flutter SDK and Dart SDK
- Serverpod CLI
- Google Gemini API key (optional; required for live AI insights)
- A supported local database setup for your Serverpod version

Verify the SDKs:

```bash
flutter doctor
flutter --version
dart --version
```

See the official [Serverpod quickstart](https://docs.serverpod.dev/quickstart) and [installation guide](https://docs.serverpod.dev/installation) for current requirements.

## Setup

### 1. Create or open the workspace

If starting from scratch, follow the current Serverpod quickstart. For example, if supported by your installed CLI:

```bash
serverpod quickstart mis_copilot
cd mis_copilot
```

If the project already exists, open its root folder in VS Code or App Studio. The root should contain the server, client, and Flutter packages.

### 2. Install dependencies

Server package:

```bash
cd mis_copilot_server
dart pub get
```

Add the AI dependency if it is not already present and matches your endpoint implementation:

```bash
dart pub add dartantic_ai
```

Flutter package:

```bash
cd ../mis_copilot_flutter
flutter pub get
flutter pub add file_picker
flutter pub add csv
```

If the server endpoint imports `package:csv/csv.dart`, add `csv` to the **server package** too:

```bash
cd ../mis_copilot_server
dart pub add csv
```

Resolve any API differences against the documentation for your installed package versions.

## Configure Gemini

1. Create or open `mis_copilot_server/config/passwords.yaml`.
2. Add the development key using the name expected by your server endpoint.

```yaml
development:
  geminiApiKey: "YOUR_GEMINI_API_KEY"
```

Get a key from [Google AI Studio](https://aistudio.google.com/). Restart the server after changing secrets.

**Security**
- Replace the placeholder with your own key locally.
- Never commit `passwords.yaml`, API keys, or production secrets.
- Confirm the file is excluded by `.gitignore`; add an ignore rule if needed.
- Use your deployment provider's secret-management workflow for production.
- Never expose the key in Flutter code, browser assets, logs, or screenshots.

If Gemini is not configured, report calculations should still work if AI failures are handled gracefully by the endpoint.

## Database and Code Generation

1. Define the Serverpod models in the server package, such as:
   - `lib/src/models/report.spy.yaml`
   - `lib/src/models/sales_record.spy.yaml`
2. Generate protocol and client code using the command supported by your installed CLI:

```bash
serverpod generate
```

3. Resolve code-generation errors.
4. Create and apply the database migration using the workflow supported by your Serverpod version.
5. Start the server and confirm the database is available.

Code generation does not necessarily mean the database migration has been applied. Follow your CLI output and version-specific migration instructions.

### Conceptual database schema

**`reports`**

| Field | Purpose |
|---|---|
| `id` | Primary key generated by Serverpod |
| `fileName` | Uploaded CSV filename |
| `rowCount` | Number of processed rows |
| `totalSales` | Sum of sales values |
| `totalProfit` | Sum of profit values |
| `averageOrderValue` | Initial implementation: total sales divided by processed rows |
| `topProduct` | Product with highest aggregate sales |
| `topRegion` | Region with highest aggregate sales |
| `createdAt` | Report creation timestamp |
| `aiInsight` | Optional AI-generated narrative |

**`sales_records`**

| Field | Purpose |
|---|---|
| `id` | Primary key generated by Serverpod |
| `reportId` | Associated report ID |
| `orderDate` | Optional transaction date |
| `orderId` | Order identifier |
| `product` | Product name |
| `category` | Product category |
| `region` | Sales region |
| `quantity` | Units |
| `sales` | Sales amount |
| `profit` | Profit amount |

## Run the Application

Use the workflow generated by your installed Serverpod template. A common workflow is to start the backend and its configured local database, then run Flutter.

From the workspace root, if supported by your CLI:

```bash
serverpod start
```

If you need to launch Flutter manually, use another terminal:

```bash
cd mis_copilot_flutter
flutter pub get
flutter run -d chrome
```

If the app cannot connect to the backend, check the URL and port in the existing client initialization, the server configuration, and browser network/CORS settings. Keep the client setup generated by your template rather than replacing it blindly.

## How to Use

1. Start the backend and Flutter app.
2. Open **MIS Copilot**.
3. Select **Upload CSV**.
4. Choose a CSV containing `Product` and `Sales`.
5. Wait for validation and processing.
6. Review the KPI summary and AI insight.
7. Open **Reports** to browse saved summaries.

## API Methods

The intended `ReportEndpoint` methods are:

| Method | Purpose |
|---|---|
| `analyzeCsv(fileName, csvText)` | Validate CSV, calculate KPIs, save the report/records, and request AI insights |
| `listReports()` | Return recent report summaries |
| `getReport(id)` | Retrieve one report |
| `getRecords(reportId)` | Retrieve records for a report |

Confirm actual generated client signatures after running Serverpod code generation.

## Security Notes

This is a learning/hackathon MVP and is **not production-hardened**. Before using real business data or deploying publicly:

- Add authentication and authorization.
- Ensure users can access only their own reports and records.
- Validate file size, row count, headers, numeric values, and date formats.
- Reject malformed or unexpectedly large uploads.
- Avoid logging CSV contents or API keys.
- Review what data is sent to Gemini and get permission before sending confidential or personal data to a third-party AI service.
- Add transactions or cleanup so failed record inserts do not leave incomplete reports.
- Add pagination and request timeouts.
- Use HTTPS and managed production secrets.
- Review privacy, security, and data-retention requirements.

The MVP sends CSV text through a normal endpoint, which may not be suitable for large files. Check request-size limits for your Serverpod version and use its supported file-upload/storage mechanism for larger datasets.

## Troubleshooting

### `serverpod` command not found
Check the CLI installation and PATH. See the [Serverpod installation guide](https://docs.serverpod.dev/installation).

### Generated endpoint is missing
Run code generation and inspect compiler output. Confirm the endpoint is in the expected server source directory and follows the endpoint conventions for your version.

### Database table does not exist
Confirm models are valid, generation succeeded, and the migration was created and applied.

### Gemini insight fails
Check that the server-side key is configured, the server was restarted, the selected model is available to the key, package APIs match installed versions, and quota/network access are available.

### CSV upload fails
Confirm the file is UTF-8 CSV, has a header and data rows, includes `Product` and `Sales`, and uses numeric sales values.

### Flutter cannot connect to Serverpod
Confirm the backend is running and the URL/port in the client matches the server configuration. Check browser network and CORS errors for web builds.

## Deployment

Deployment is optional during local development. Before a public demo:

1. Confirm the app works locally.
2. Add authentication and review access controls.
3. Configure production database settings and secrets.
4. Set the Gemini key through managed secrets.
5. Deploy the Serverpod backend and database.
6. Build/host Flutter web using the workflow supported by your hosting setup.
7. Test uploads, persistence, and AI responses using non-sensitive sample data.

See the [Serverpod Cloud deployment guide](https://docs.serverpod.dev/deployments/deploy-to-serverpod-cloud) and [Cloud launch guide](https://docs.serverpod.dev/cloud/getting-started/launch).

## Roadmap

- [ ] Stabilize models, migrations, and endpoint tests.
- [ ] Improve CSV validation and error messages.
- [ ] Add responsive charts and filters.
- [ ] Add AI Q&A grounded in report data.
- [ ] Add anomaly detection and recommendations.
- [ ] Add PDF/Excel export.
- [ ] Add authentication and per-user authorization.
- [ ] Support larger files with storage/background processing.
- [ ] Add automated tests, logging, and monitoring.
- [ ] Deploy a public demo.

## Contributing

Contributions and suggestions are welcome.

1. Fork the repository.
2. Create a feature branch.
3. Make changes and add tests where practical.
4. Run formatting, analysis, and tests for affected packages.
5. Open a pull request describing the change.

Do not commit secrets or private business datasets.

## License

No license has been selected yet. Add a `LICENSE` file before publishing if you want to specify how others may use, modify, and distribute the project.

## Useful Links

- [Serverpod documentation](https://docs.serverpod.dev/)
- [Serverpod quickstart](https://docs.serverpod.dev/quickstart)
- [Serverpod endpoints and APIs](https://docs.serverpod.dev/concepts/endpoints-and-apis)
- [Serverpod models and database](https://docs.serverpod.dev/concepts/data-and-the-database/models)
- [Serverpod Cloud deployment](https://docs.serverpod.dev/deployments/deploy-to-serverpod-cloud)
- [Google AI Studio](https://aistudio.google.com/)
- [Flutter documentation](https://docs.flutter.dev/)
