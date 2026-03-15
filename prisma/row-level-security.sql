-- Row Level Security (RLS) for Multi-Tenancy
-- This ensures Company A can never access Company B's data

-- Enable RLS on all tables that contain company-specific data
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE integrations ENABLE ROW LEVEL SECURITY;
ALTER TABLE slack_messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE notion_pages ENABLE ROW LEVEL SECURITY;
ALTER TABLE vector_embeddings ENABLE ROW LEVEL SECURITY;
ALTER TABLE search_queries ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE knowledge_hits ENABLE ROW LEVEL SECURITY;
ALTER TABLE shared_insights ENABLE ROW LEVEL SECURITY;

-- Users can only see their own company's users
CREATE POLICY users_company_policy ON users
    FOR ALL TO authenticated_role
    USING (company_id = current_setting('app.current_company_id')::UUID);

-- Integrations are scoped to company
CREATE POLICY integrations_company_policy ON integrations
    FOR ALL TO authenticated_role
    USING (company_id = current_setting('app.current_company_id')::UUID);

-- Slack messages are company-scoped
CREATE POLICY slack_messages_company_policy ON slack_messages
    FOR ALL TO authenticated_role
    USING (company_id = current_setting('app.current_company_id')::UUID);

-- Notion pages are company-scoped
CREATE POLICY notion_pages_company_policy ON notion_pages
    FOR ALL TO authenticated_role
    USING (company_id = current_setting('app.current_company_id')::UUID);

-- Vector embeddings follow their source
CREATE POLICY vector_embeddings_company_policy ON vector_embeddings
    FOR ALL TO authenticated_role
    USING (
        EXISTS (
            SELECT 1 FROM slack_messages 
            WHERE slack_messages.company_id = current_setting('app.current_company_id')::UUID
            AND slack_messages.message_id = vector_embeddings.source_id
            AND vector_embeddings.source_type = 'SLACK_MESSAGE'
        )
        OR
        EXISTS (
            SELECT 1 FROM notion_pages 
            WHERE notion_pages.company_id = current_setting('app.current_company_id')::UUID
            AND notion_pages.page_id = vector_embeddings.source_id
            AND vector_embeddings.source_type = 'NOTION_PAGE'
        )
    );

-- Search queries are user and company scoped
CREATE POLICY search_queries_company_policy ON search_queries
    FOR ALL TO authenticated_role
    USING (
        company_id = current_setting('app.current_company_id')::UUID
        AND user_id = current_setting('app.current_user_id')::UUID
    );

-- User sessions are user scoped
CREATE POLICY user_sessions_user_policy ON user_sessions
    FOR ALL TO authenticated_role
    USING (user_id = current_setting('app.current_user_id')::UUID);

-- Knowledge hits follow their search query
CREATE POLICY knowledge_hits_company_policy ON knowledge_hits
    FOR ALL TO authenticated_role
    USING (
        EXISTS (
            SELECT 1 FROM search_queries 
            WHERE search_queries.company_id = current_setting('app.current_company_id')::UUID
            AND search_queries.id = knowledge_hits.query_id
        )
    );

-- Shared insights are company scoped
CREATE POLICY shared_insights_company_policy ON shared_insights
    FOR ALL TO authenticated_role
    USING (company_id = current_setting('app.current_company_id')::UUID);

-- Function to set company context for the session
CREATE OR REPLACE FUNCTION set_company_context(user_id UUID, company_id UUID)
RETURNS void AS $$
BEGIN
    PERFORM set_config('app.current_user_id', user_id::text, true);
    PERFORM set_config('app.current_company_id', company_id::text, true);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to clear company context
CREATE OR REPLACE FUNCTION clear_company_context()
RETURNS void AS $$
BEGIN
    PERFORM set_config('app.current_user_id', '', true);
    PERFORM set_config('app.current_company_id', '', true);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
