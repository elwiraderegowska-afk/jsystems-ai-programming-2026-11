# Design Guidelines

Design system extracted from [devpowers.com](https://devpowers.com/) (default page style **"Comic Current"**) on 2026-11-25 with the Playwright CLI in a headed Chrome session. Machine-readable tokens live in [`assets/design-tokens.json`](../assets/design-tokens.json); this document explains how to use them.

> The source site also offers alternative page styles (Minimalist, Editorial, Premium Glow, Boho, Bento, Terminal dev). They are **not** part of this design system.

## Assets

| File | Purpose |
|---|---|
| [`assets/design-tokens.json`](../assets/design-tokens.json) | All tokens: colors, light/dark themes, typography, spacing, radii, shadows, components |
| [`assets/homepage.png`](../assets/homepage.png) | Full-page reference screenshot, light theme (1025 px wide) |
| [`assets/homepage-dark.png`](../assets/homepage-dark.png) | Above-the-fold reference screenshot, dark theme |
| [`assets/logo.svg`](../assets/logo.svg) | DevPowers wordmark + mascot, `fill="currentColor"` |
| [`assets/favicon.svg`](../assets/favicon.svg) | Mascot favicon, `#004581`, switches to white under `prefers-color-scheme: dark` |

## Colors

Use the **semantic CSS variables**, not raw hex values, so light and dark themes work automatically. Dark theme is enabled by the `dark` class on `<html>`.

| Token | Light | Dark | Usage |
|---|---|---|---|
| `--surface` | `#fff9eb` | `#17121d` | Page background (warm paper) |
| `--surface-raised` | `#ffffff` | `#241c2e` | Cards, buttons (light variant), inputs |
| `--surface-strong` | `#004581` | `#0d3b66` | Strong blue sections and panels |
| `--on-surface` | `#101820` | `#f7efe1` | Body text, headings |
| `--on-surface-strong` | `#ffffff` | `#ffffff` | Text on `--surface-strong` |
| `--muted` | `#4c5b66` | `#c3b4a6` | Secondary text, timestamps, captions |
| `--accent` | `#d30f10` | `#ff3b30` | Primary CTA, highlighted heading words |
| `--on-accent` | `#ffffff` | `#1a0d0c` | Text on accent |
| `--accent-warm` | `#ffd447` | `#ffd233` | Stickers, badges, active states, focus ring |
| `--on-accent-warm` | `#101820` | `#191016` | Text on warm accent |
| `--positive` | `#167a3e` | `#6bdd97` | Success, check icons |
| `--negative` | `#d30f10` | `#ff5a4d` | Errors |
| `--chat-client` | `#fff1b8` | `#4a3a12` | User chat bubble |
| `--chat-agent` | `#d9ecff` | `#14395c` | Agent chat bubble |
| `--soft-red` / `--soft-blue` | `#fff0ed` / `#eaf5ff` | `#3b1a1a` / `#132c44` | Tinted panels, menu hover |
| `--hairline` | `#101820` | `#f7efe1` | All outlines (3 px) |
| `--shadow` | `#101820` | `#000000` | Hard offset shadows |

Additional section colors (light theme): bright halftone band `#038bfe`, deep blue band `#003761`, footer navy `#002d52`.

## Typography

| Role | Family | Weights | Notes |
|---|---|---|---|
| Display (headings, buttons, stickers) | **Bangers** | 400 only | All-caps comic face; `letter-spacing: 0.02em` |
| Body (text, nav, inputs) | **Atkinson Hyperlegible** | 400, 700 | High-legibility sans; base 16 px / 1.5 |

Both fonts load from Google Fonts (not self-hosted, nothing downloaded):

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Atkinson+Hyperlegible:wght@400;700&family=Bangers&display=swap" rel="stylesheet">
```

Both are published under the SIL Open Font License; verify licensing for your use case anyway.

**Size scale**

| Element | Size | Line height |
|---|---|---|
| H1 (hero) | 61.36px (≈ 3.835rem) | 1 |
| Section headings | 57.2px | ≈ 1.05 |
| H3 / card titles (large) | 29.6px | 1.08 |
| H2 (small section label) | 28px | 32px |
| Lead paragraph | 21.6px | 1.625 |
| Button label | 20px | 1 |
| Card title | 21.6px (Bangers) | — |
| Body | 16px | 1.5 |
| Nav / small | 14px, bold | 20px |

The hero headline mixes three treatments on separate lines: solid ink, **outlined** (transparent fill with an ink stroke), and **accent red**.

## Spacing

Base unit **4 px**. Common values: `4, 8, 12, 16, 20, 24, 28, 32, 36, 48, 64` px.

- Card padding: `16px` (bottom `18.4px`)
- Grid gaps: `16px` (most common), `12px`, `28px`
- Section vertical padding: `72.8px` (hero: `64px` top)
- Container: `width: min(72rem, 100% - 2rem); margin-inline: auto;`
- Breakpoints: `640 / 768 / 1024 / 1280` px (Tailwind defaults)

## Border radius

| Token | Value | Usage |
|---|---|---|
| `sm` | 6px | Small chips |
| `button` | 7px | All buttons, icon buttons |
| `md` | 8px | Inputs, inner panels |
| `lg` | 10px | Stickers, mid-size boxes (most common) |
| `xl` | 16px | Cards, promise tiles |
| `bubble` | `14px 14px 14px 4px` | Chat bubbles (flatten the tail corner) |
| `circle` | 50% | Avatars, step/pager dots |

## Borders and shadows (the signature)

Every interactive or framed element has a **3 px solid `--hairline` outline** and a **hard, unblurred offset shadow** in `--shadow`:

| Token | Value | Usage |
|---|---|---|
| `sm` | `3px 3px 0` | Stickers, pager dots |
| `md` | `4px 4px 0` | Buttons, cards (default) |
| `lg` | `6px 6px 0` | Large panels (e.g. the chat demo) |
| `pressed` | `2px 2px 0` | Button hover/press state |
| `accent` / `warm` | `6px 6px 0` in red / yellow | Featured panels |

Never use blurred (`box-shadow: 0 4px 12px …`) shadows; they break the comic style.

Backgrounds use a subtle **halftone dot** texture: `radial-gradient(var(--hairline) 2.2px, transparent 2.35px)` on a dot grid (bold on blue bands, very faint on the paper background).

## Components

### Button

```css
.btn {
  font: 400 20px/1 Bangers, sans-serif;
  letter-spacing: 0.02em;
  padding: 10.4px 16px;
  border: 3px solid var(--hairline);
  border-radius: 7px;
  box-shadow: 4px 4px 0 var(--shadow);
  display: inline-flex; align-items: center; gap: 10px;
}
.btn:hover { transform: translate(2px, 2px); box-shadow: 2px 2px 0 var(--shadow); }
.btn-primary { background: var(--accent); color: var(--on-accent); }
.btn-light   { background: var(--surface-raised); color: var(--on-surface); }
.btn-warm    { background: var(--accent-warm); color: var(--on-accent-warm); }
```

- **Primary** (red): one main action per view ("Get a quote", "Tell us what you need").
- **Light** (white): secondary actions and icon-only buttons (theme toggle, menu).
- **Warm** (yellow): alternate highlighted action.
- Icons: [Lucide](https://lucide.dev/), 24 px, placed left of the label.

### Card / tile

White (`--surface-raised`) box, 3 px outline, `16px` radius, `4px 4px 0` shadow, `16px` padding. Title in Bangers ~21.6 px, body in Atkinson 16 px. Hero tiles have a small speech-bubble tail at the bottom-left.

### Sticker / badge

Yellow (`--accent-warm`) label, Bangers 20 px, 3 px outline, `10px` radius, `3px 3px 0` shadow, padding `5.6px 11.2px`, slightly rotated (`rotate(-1deg)`). Used for eyebrows above headings and corner badges ("5 working days").

### Chat bubbles

- Client message: `--chat-client` (pale yellow), right-aligned.
- Agent message: `--chat-agent` (pale blue), left-aligned, with a circular avatar.
- 3 px outline, `14px` radius with one flattened corner toward the speaker, timestamp in `--muted` below.
- Status chips (e.g. "End-to-end tests ✓") in a white outlined box with `--positive` check icons.

### Header

Sticky, `--surface` background, ~76 px tall. Logo left (158 px wide); right side: icon buttons (theme, style) + primary CTA + menu button.

### Navigation

Atkinson Hyperlegible 14 px bold, `--on-surface`. Focus: `outline: 4px solid var(--accent-warm); outline-offset: 3px`.

### Inputs (derived; the source page has no form)

```css
.input {
  font: 400 16px/1.5 "Atkinson Hyperlegible", sans-serif;
  background: var(--surface-raised); color: var(--on-surface);
  border: 3px solid var(--hairline); border-radius: 8px;
  padding: 10.4px 12px;
  box-shadow: 3px 3px 0 var(--shadow);
}
.input:focus-visible { outline: 4px solid var(--accent-warm); outline-offset: 2px; }
.input[aria-invalid="true"] { border-color: var(--negative); }
```

### Footer

Navy `#002d52`, white text, `48px` vertical padding.

### Focus and motion

- Global focus ring: `:focus-visible { outline: 4px solid var(--accent-warm); outline-offset: 4px; }`.
- The site honors `prefers-reduced-motion`; disable the hover translate and any animation under `reduce`.

## Logo usage

- Use [`assets/logo.svg`](../assets/logo.svg) in the header, left-aligned, ~158 px wide (viewBox 449.8 × 100).
- The SVG uses `fill="currentColor"`: set `color: var(--on-surface)` and it switches automatically between ink (`#101820`) on light and cream (`#f7efe1`) on dark. No separate inverted file is needed.
- Use [`assets/favicon.svg`](../assets/favicon.svg) as `<link rel="icon" type="image/svg+xml">`.
- **The logo is a DevPowers brand asset.** Verify usage rights before using it outside the course.

## Visual style summary

DevPowers is a bold **comic-book / neo-brutalist** brand: warm paper background, thick ink outlines, hard offset shadows and halftone dot textures. Headings shout in the all-caps Bangers display face, while body text stays calm and highly legible in Atkinson Hyperlegible, so the playfulness never costs accessibility. The palette is a confident primary trio (signal red, superhero blue, sticker yellow) on cream, with a fully designed dark theme. Interactions feel tactile: buttons "press" into their shadow on hover, and stickers sit slightly askew. The overall tone is friendly, energetic and confident ("Your website. Your superpowers.").
