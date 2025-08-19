from dotenv import load_dotenv
from ai_agent import nl_to_sql
from database import run_sql

load_dotenv()

BANNER = """
🔍 HR Data Query Assistant
Type natural language (e.g., "Top 3 highest paid employees")
or start with 'SQL:' to run a direct query.
Type 'exit' to quit.
"""

def main():
    print(BANNER)
    while True:
        try:
            q = input("Your question> ").strip()
        except (EOFError, KeyboardInterrupt):
            print("\nBye!")
            break

        if not q:
            continue
        if q.lower() == "exit":
            print("Bye!")
            break

        if q.lower().startswith("sql:"):
            sql = q[4:].strip()
        else:
            sql = nl_to_sql(q) or ""
            if not sql:
                print("🤖 AI not configured or failed to build SQL. "
                      "Tip: prefix with 'SQL:' and write your query directly.")
                continue

        try:
            rows = run_sql(sql)
            if not rows:
                print("(no rows)")
                continue
            cols = list(rows[0].keys())
            print(" | ".join(cols))
            print("-" * (3 * len(cols) + 5))
            for r in rows:
                print(" | ".join(str(r[c]) for c in cols))
        except Exception as e:
            print(f"❌ Error: {e}")

if __name__ == "__main__":
    main()
