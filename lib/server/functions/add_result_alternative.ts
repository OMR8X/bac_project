import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from 'npm:@supabase/supabase-js@2';
import { z } from "https://deno.land/x/zod/mod.ts";

// Zod schemas
const AnswerSchema = z.object({
  question_id: z.number(),
  selected_option_id: z.number()
});

const AddResultRequestSchema = z.object({
  lesson_id: z.number(),
  duration_seconds: z.number(),
  questions_ids: z.array(z.number()),
  answers: z.array(AnswerSchema)
});

// Deno Edge Function
Deno.serve(async (req) => {
  try {
    // Parse JSON body
    const body = await req.json();
    const parsed = AddResultRequestSchema.parse(body);
    
    // Validate environment variables
    const supabaseUrl = Deno.env.get('SUPABASE_URL');
    const supabaseServiceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY');
    
    if (!supabaseUrl || !supabaseServiceKey) {
      return new Response(JSON.stringify({
        error: "Missing environment variables",
        details: "SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY not set"
      }), {
        status: 500,
        headers: { "Content-Type": "application/json" }
      });
    }
    
    // Initialize Supabase client with Service Role Key
    const supabase = createClient(supabaseUrl, supabaseServiceKey, {
      global: {
        headers: {
          Authorization: req.headers.get('Authorization') || ''
        }
      }
    });
    
    console.log("Using direct SQL query instead of RPC function");
    
    // Use direct SQL query instead of RPC function to avoid schema issues
    const { data: questions_response, error } = await supabase
      .from('questions')
      .select(`
        *,
        options (
          id,
          text,
          is_correct,
          image_url,
          created_at,
          updated_at
        )
      `)
      .in('id', parsed.questions_ids);
    
    if (error) {
      console.error("Supabase query error:", error);
      return new Response(JSON.stringify({
        error: "Supabase query error",
        details: error.message || error,
        code: error.code,
        hint: error.hint
      }), {
        status: 500,
        headers: { "Content-Type": "application/json" }
      });
    }
    
    console.log("Query successful, questions found:", questions_response?.length);
    
    return new Response(JSON.stringify({
      message: `Lesson ${parsed.lesson_id} received!`,
      questions_response,
      request_data: parsed,
      success: true
    }), {
      headers: { "Content-Type": "application/json" }
    });
    
  } catch (err) {
    console.error("Function error:", err);
    return new Response(JSON.stringify({
      error: err instanceof z.ZodError ? "Validation error" : "Internal error",
      details: err instanceof z.ZodError ? err.errors : err.message
    }), {
      status: 500,
      headers: { "Content-Type": "application/json" }
    });
  }
});
