import os
from typing import Optional
from dotenv import load_dotenv

load_dotenv()

SYSTEM_PROMPT = """You are a helpful assistant that converts natural language questions
about an HR database into safe, read-only SQL (PostgreSQL dialect).
Rules:
- SELECT queries only. Never write/alter/delete.
- Use these tables and columns:
  departments(dept_id, dept_name, location)
  employees(emp_id, first_name, last_name, email, hire_date, salary, dept_id)
  projects(project_id, project_name, dept_id, budget, start_date, end_date)
  assignments(emp_id, project_id, role, allocation_percent)
- Prefer explicit JOINs.
- Return only the SQL code, no explanations or markdown.
"""

def nl_to_sql(question: str) -> Optional[str]:
    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        return None

    from openai import OpenAI
    client = OpenAI(api_key=api_key)
    prompt = f"{SYSTEM_PROMPT}\n\nQuestion: {question}\nSQL:"

    resp = client.chat.completions.create(
        model="gpt-4o-mini",
        messages=[{"role": "user", "content": prompt}],
        temperature=0
    )
    sql = resp.choices[0].message.content.strip()
    if not sql.lower().startswith("select"):
        return None
    return sql
