'use client'

import { useState } from 'react'
import { PremiumSearchBar } from '@/components/search/premium-search-bar'
import { SkeletonLoader } from '@/components/search/skeleton-loader'
import { InsightCard } from '@/components/search/insight-card'
import { KnowledgeGraph } from '@/components/search/knowledge-graph'

export default function HomePage() {
  const [isSearching, setIsSearching] = useState(false)
  const [searchResult, setSearchResult] = useState<any>(null)

  const handleSearch = async (query: string) => {
    setIsSearching(true)
    
    // Simulate search delay
    setTimeout(() => {
      setSearchResult({
        query,
        answer: "Esta es una respuesta de ejemplo del Cerebro Colectivo. El sistema está funcionando correctamente.",
        sources: [],
        confidence: 0.85,
        responseTime: 1200
      })
      setIsSearching(false)
    }, 2000)
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-violet-50 via-white to-indigo-50 dark:from-violet-950 dark:via-slate-900 dark:to-indigo-950">
      <div className="container mx-auto px-4 py-8">
        <div className="max-w-4xl mx-auto space-y-8">
          {/* Header */}
          <div className="text-center space-y-4">
            <div className="flex items-center justify-center space-x-2">
              <div className="w-12 h-12 bg-gradient-to-r from-violet-600 to-indigo-600 rounded-lg flex items-center justify-center">
                <span className="text-white font-bold text-xl">🧠</span>
              </div>
              <h1 className="text-4xl font-bold text-premium">Cerebro Colectivo</h1>
            </div>
            <p className="text-xl text-muted-foreground max-w-2xl mx-auto">
              El sistema de conocimiento empresarial más avanzado del mercado
            </p>
          </div>

          {/* Search Section */}
          <div className="space-y-6">
            <PremiumSearchBar 
              onSearch={handleSearch}
              isLoading={isSearching}
            />
            
            {isSearching && <SkeletonLoader />}
            
            {searchResult && !isSearching && (
              <div className="space-y-6 animate-fade-in-up">
                <InsightCard
                  query={searchResult.query}
                  answer={searchResult.answer}
                  sources={searchResult.sources}
                  confidence={searchResult.confidence}
                  responseTime={searchResult.responseTime}
                  onShare={() => console.log('Share clicked')}
                />
                
                <KnowledgeGraph
                  sources={searchResult.sources}
                  query={searchResult.query}
                />
              </div>
            )}
          </div>

          {/* Features */}
          <div className="grid md:grid-cols-3 gap-6 mt-12">
            <div className="premium-card rounded-xl p-6 text-center">
              <div className="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mx-auto mb-4">
                <span className="text-2xl">🔍</span>
              </div>
              <h3 className="font-semibold mb-2">Búsqueda Inteligente</h3>
              <p className="text-sm text-muted-foreground">
                Encuentra información instantáneamente en Slack, Notion y más
              </p>
            </div>
            
            <div className="premium-card rounded-xl p-6 text-center">
              <div className="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center mx-auto mb-4">
                <span className="text-2xl">🔗</span>
              </div>
              <h3 className="font-semibold mb-2">Conexiones de Conocimiento</h3>
              <p className="text-sm text-muted-foreground">
                Visualiza cómo la IA conecta información de diferentes fuentes
              </p>
            </div>
            
            <div className="premium-card rounded-xl p-6 text-center">
              <div className="w-12 h-12 bg-violet-100 rounded-lg flex items-center justify-center mx-auto mb-4">
                <span className="text-2xl">📊</span>
              </div>
              <h3 className="font-semibold mb-2">Insights Compartibles</h3>
              <p className="text-sm text-muted-foreground">
                Comparte descubrimientos valiosos con tu equipo
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
