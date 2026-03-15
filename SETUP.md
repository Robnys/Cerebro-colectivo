# Setup Instructions - Cerebro Colectivo MVP

## 1. Install Dependencies

```bash
npm install
```

## 2. Environment Setup

```bash
cp .env.example .env.local
```

Configure your environment variables:
- `DATABASE_URL`: PostgreSQL connection string
- `GOOGLE_CLIENT_ID` & `GOOGLE_CLIENT_SECRET`: Google OAuth credentials
- `NEXTAUTH_SECRET`: Random secret for NextAuth.js

## 3. Database Setup

```bash
# Generate Prisma client
npm run db:generate

# Push schema to database
npm run db:push

# Apply Row Level Security policies
psql $DATABASE_URL -f prisma/row-level-security.sql
```

## 4. Start Development

```bash
npm run dev
```

## Architecture Notes

### Row Level Security (RLS)
- Automatically isolates data by company
- Uses PostgreSQL session variables: `app.current_company_id`, `app.current_user_id`
- Prevents cross-tenant data access at database level

### Auth Flow
1. User registers via `/api/auth/register`
2. OAuth login via NextAuth.js
3. Session includes company context
4. All API calls automatically scoped to user's company

### Multi-Tenant Safety
- Every query includes company context
- Database-level isolation prevents data leaks
- Application-level validation as backup

## Next Steps

1. Set up Google OAuth credentials
2. Configure PostgreSQL database
3. Test registration flow
4. Implement Slack/Notion integrations (Week 2)
