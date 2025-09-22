import { createClient } from 'npm:@supabase/supabase-js@2';
import { GoogleGenAI } from "npm:@google/genai";

export function getSupabaseClient(req?: Request) {
  const supabaseUrl = Deno.env.get('SUPABASE_URL');
  const supabaseServiceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY');

  if (!supabaseUrl || !supabaseServiceKey) {
    throw new Error('Missing required Supabase environment variables');
  }

  return createClient(supabaseUrl, supabaseServiceKey, {
    global: {
      headers: req ? {
        Authorization: req.headers.get('Authorization') || ''
      } : undefined
    }
  });
}

export function getGoogleAiClient() {
  return new GoogleGenAI({
    apiKey: Deno.env.get("GEMINI_API_KEY")
  });
}
