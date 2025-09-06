import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "https://cdn.jsdelivr.net/npm/@supabase/supabase-js/+esm";
import { z } from "https://deno.land/x/zod/mod.ts";

// Schemas
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

// Supabase client
const supabaseUrl = Deno.env.get('SUPABASE_URL');
const supabaseServiceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY');
const supabase = createClient(supabaseUrl, supabaseServiceKey);

// Edge function
Deno.serve(async (req) => {
  try {
    const body = await req.json();
    const parsed = AddResultRequestSchema.parse(body);
    
    // Fetch options for the given question IDs
    const { data, error } = await supabase
      .from('options')
      .select('*')
      .in('question_id', parsed.questions_ids);
    
    if (error) {
      return new Response(JSON.stringify({
        error: error.message
      }), {
        status: 500
      });
    }
    
    return new Response(JSON.stringify({
      message: `Options fetched for lesson ${parsed.lesson_id}`,
      options: data
    }), {
      headers: {
        "Content-Type": "application/json"
      }
    });
  } catch (err) {
    return new Response(JSON.stringify({
      error: err instanceof z.ZodError ? err.errors : err.message
    }), {
      status: 500
    });
  }
});
