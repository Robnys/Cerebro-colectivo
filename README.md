# Cerebro Colectivo - MVP

## Arquitectura

```
cerebro-colectivo/
├── src/
│   ├── app/                    # Next.js 14 App Router
│   │   ├── (auth)/            # Auth routes
│   │   ├── dashboard/         # Main app
│   │   ├── api/               # API routes
│   │   └── globals.css
│   ├── components/            # Reusable UI components
│   │   ├── ui/               # shadcn/ui components
│   │   ├── search/           # Search-specific components
│   │   └── auth/             # Auth components
│   ├── lib/                  # Utilities and configurations
│   │   ├── auth.ts           # NextAuth/Clerk configuration
│   │   ├── db.ts             # Prisma client
│   │   ├── utils.ts          # Helper functions
│   │   └── validations.ts    # Zod schemas
│   ├── services/             # Business logic layer
│   │   ├── auth.service.ts
│   │   ├── search.service.ts
│   │   ├── slack.service.ts
│   │   └── notion.service.ts
│   ├── types/                # TypeScript definitions
│   │   ├── auth.types.ts
│   │   ├── search.types.ts
│   │   └── api.types.ts
│   └── hooks/                # Custom React hooks
│       ├── use-auth.ts
│       └── use-search.ts
├── prisma/
│   ├── schema.prisma         # Database schema
│   ├── migrations/           # Database migrations
│   └── seed.ts              # Seed data
├── public/                   # Static assets
├── docs/                     # Documentation
└── scripts/                  # Utility scripts
```

## Tech Stack

- **Frontend**: Next.js 14, TypeScript, Tailwind CSS, shadcn/ui
- **Backend**: Next.js API Routes, Prisma ORM
- **Database**: PostgreSQL with Row Level Security
- **Auth**: NextAuth.js or Clerk
- **AI**: OpenAI API, Pinecone/Weaviate
- **Infrastructure**: Vercel, AWS

## Getting Started

1. Install dependencies
2. Set up environment variables
3. Run database migrations
4. Start development server
