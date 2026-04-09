# Policy: Dygnsvila

## 1. Regel
En förare måste ha minst 11 timmars sammanhängande vila mellan två arbetspass under en 24-timmarsperiod.

## 2. Undantag
Vilan får reduceras till 9 timmar vid högst tre tillfällen mellan två veckovilor.

## 3. Implementation
Logiken implementeras i `kalles-hr` domänen i `DailyRestPolicy.ts` och valideras automatiskt vid varje bemanningsförfrågan.
