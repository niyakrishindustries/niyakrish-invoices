# Niyakrish Invoices - Invoice Management System

A modern invoice management system built with Next.js, Supabase, and Tailwind CSS.

## Features

- ✅ Create, edit, and manage invoices
- ✅ Customer management
- ✅ Payment tracking
- ✅ Tax calculations (CGST/SGST)
- ✅ PDF export and printing
- ✅ User authentication with Supabase
- ✅ Multi-user support with role-based access
- ✅ Invoice history and reporting

## Tech Stack

- **Frontend**: Next.js 14, React 18, TypeScript, Tailwind CSS
- **Backend**: Supabase (PostgreSQL)
- **Authentication**: Supabase Auth
- **PDF Generation**: html2pdf.js

## Getting Started

### Prerequisites

- Node.js 18+ installed
- Supabase account (free tier available at https://supabase.com)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/niyakrishindustries/niyakrish-invoices.git
   cd niyakrish-invoices
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Setup Supabase**
   - Create a new project at https://supabase.com
   - Copy your project URL and anon key
   - Create a `.env.local` file in the root directory:
     ```
     NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
     NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
     ```

4. **Setup Database Schema**
   - Go to Supabase SQL Editor
   - Run the SQL from `database/schema.sql`

5. **Run the development server**
   ```bash
   npm run dev
   ```

6. **Open in browser**
   ```
   http://localhost:3000
   ```

## Project Structure

```
.
├── app/                      # Next.js app directory
│   ├── layout.tsx           # Root layout
│   ├── page.tsx             # Home page
│   └── invoices/            # Invoice pages
├── components/              # Reusable components
│   ├── InvoiceForm.tsx      # Invoice form component
│   ├── InvoiceList.tsx      # Invoice list component
│   └── ...
├── lib/                     # Utilities and helpers
│   ├── supabase.ts         # Supabase client
│   └── utils.ts            # Helper functions
├── database/               # Database schema
│   └── schema.sql         # SQL schema definitions
├── public/                # Static files
├── .env.example          # Environment variables template
├── next.config.js        # Next.js configuration
├── tailwind.config.js    # Tailwind CSS configuration
└── package.json
```

## Next Steps

1. Set up Supabase project and environment variables
2. Run database schema
3. Implement authentication
4. Build invoice management features
5. Deploy to production

## Deployment

This project can be deployed to:
- Vercel (recommended)
- Netlify
- AWS
- Your own server

## Support

For issues or questions, please create an issue on GitHub.

## License

MIT
