---
applyTo: "**/*.ts,**/*.tsx"
---

## TypeScript Standards
- Strict mode always: `"strict": true` in tsconfig
- No implicit `any` — explicit types or proper inference
- Prefer `interface` over `type` for object shapes (extendable)
- Use const assertions for literal objects: `as const`
- Async functions: always return `Promise<T>`, not `Promise<any>`
- Error handling: typed errors — never throw raw strings
- No non-null assertions (`!.`) unless provably safe
- Use discriminated unions over optional chaining chains where type safety matters
- Import order: stdlib → third-party → internal (relative)
- Barrel exports (`index.ts`) only when the module is stable
- No `enum` — use `const` objects + `keyof typeof` instead
