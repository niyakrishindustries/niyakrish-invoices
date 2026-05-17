'use client'

import { useEffect, useState } from 'react'

export default function Home() {
  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    setIsLoading(false)
  }, [])

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-gray-900"></div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100">
      <div className="max-w-4xl mx-auto px-4 py-12">
        <div className="bg-white rounded-lg shadow-lg p-8">
          <h1 className="text-4xl font-bold text-gray-900 mb-4">Welcome to Niyakrish Invoices</h1>
          <p className="text-lg text-gray-600 mb-8">
            A modern invoice management system for your business.
          </p>
          
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
            <div className="border-l-4 border-blue-500 pl-4">
              <h2 className="text-xl font-semibold text-gray-900 mb-2">Getting Started</h2>
              <p className="text-gray-600">
                This is your invoice management system. Complete setup is in progress.
              </p>
            </div>
            <div className="border-l-4 border-green-500 pl-4">
              <h2 className="text-xl font-semibold text-gray-900 mb-2">Features</h2>
              <p className="text-gray-600">
                Invoice creation, customer management, payment tracking, and more.
              </p>
            </div>
          </div>

          <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
            <p className="text-sm text-gray-600">
              <strong>Next Step:</strong> Complete the Supabase setup by adding your API credentials to .env.local
            </p>
          </div>
        </div>
      </div>
    </div>
  )
}
