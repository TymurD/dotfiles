# Firefox Color palette

For the [Firefox Color](https://addons.mozilla.org/firefox/addon/firefox-color/) extension.
There's no importable file for this tool — enter these by hand in its UI.

| Field | Hex |
|---|---|
| Toolbar Color | `#111111` |
| Toolbar Icons and Text | `#f2f2f2` |
| Background Color | `#1a1a1a` |
| Background Tab Text Color | `#8a8a8a` |
| Search Bar Color | `#222222` |
| Search Text | `#f2f2f2` |
| Tab Highlight Color | `#787878` |
| Popup Background | `#1a1a1a` |
| Popup Text | `#f2f2f2` |

Reasoning: toolbar/background/popup sit on near-black shades a step apart
(`#111111` → `#1a1a1a` → `#222222`) for subtle depth without any hue; all text uses the same
bright `#f2f2f2` as the rest of the rice; the one accent (tab highlight, background tab text)
reuses the muted gray (`#787878`/`#8a8a8a`) from waybar's icons instead of Firefox's default
pink/blue, keeping everything strictly grayscale.
